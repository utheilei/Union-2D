#include "tablemodel.h"

#include <QDebug>

TableModel::TableModel(QObject* parent) : QAbstractTableModel(parent)
{
}

QStringList TableModel::getHorHeader() const
{
    return m_horHeaderList;
}

void TableModel::setHorHeader(const QStringList &header)
{
    m_horHeaderList = header;
    emit horHeaderChanged();
}

QList<QList<QVariantMap>> TableModel::getModelData() const
{
    return m_modelData;
}

void TableModel::setModelData(const QList<QList<QVariantMap>> &modelData)
{
    beginResetModel();
    m_modelData = modelData;
    endResetModel();
}

void TableModel::classBegin()
{
    qInfo() << "TableModel::classBegin()";
}

void TableModel::componentComplete()
{
    qInfo() << "TableModel::componentComplete()";
    m_roleNames = QAbstractItemModel::roleNames();
    m_completed = true;
}

void TableModel::insertRoleName(int role, const QByteArray &roleName)
{
    m_roleNames.insert(role, roleName);
}

QHash<int, QByteArray> TableModel::roleNames() const
{
    return m_roleNames;
}

QString TableModel::item(int row, int column) const
{
    return index(row, column).data().toString();
}

bool TableModel::insertItem(int row, const QList<QVariantMap> &data)
{
    if (row < 0 || !data.isEmpty())
        return false;

    beginInsertRows(QModelIndex(), row, row);
    m_modelData.insert(row, data);
    endInsertRows();

    return true;
}

bool TableModel::removeItem(int row)
{
    return removeRows(row, 1);
}

QVariant TableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal)
            return m_horHeaderList.value(section);
        else if (orientation == Qt::Vertical)
            return QString::number(section);
    }

    return QVariant();
}

bool TableModel::setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role)
{
    if (value != headerData(section, orientation, role))
    {
        if (orientation == Qt::Horizontal && role == Qt::EditRole)
        {
            m_horHeaderList[section] = value.toString();
            emit headerDataChanged(orientation, section, section);
            return true;
        }
    }
    return false;
}


int TableModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_modelData.count();
}

int TableModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_horHeaderList.count();
}

QVariant TableModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if ((Qt::UserRole + 1000) == role)
    {
        return index.row();
    }

    if (!m_roleNames.contains(role))
    {
        return QVariant();
    }
    return m_modelData.at(index.row()).at(index.column())[m_roleNames[role]];
}

bool TableModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!m_roleNames.contains(role))
    {
        return false;
    }
    if (!index.isValid())
    {
        return false;
    }
    m_modelData[index.row()][index.column()][m_roleNames[role]] = value;
    emit dataChanged(index, index, QVector<int>() << role);
    return true;
}

Qt::ItemFlags TableModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsEnabled | Qt::ItemIsSelectable | Qt::ItemIsEditable;
}

bool TableModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);

    for (int i = row; i <= row + count - 1; ++i)
        m_modelData.insert(i, QList<QVariantMap>());

    endInsertRows();

    return true;
}

bool TableModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);

    for (int i = row + count - 1; i >= row; --i)
        m_modelData.removeAt(i);

    endRemoveRows();

    return true;
}

FuzzyFilterProxyModel::FuzzyFilterProxyModel(QObject* parent) : QSortFilterProxyModel(parent)
{
    setSourceModel(new TableModel(this));
}

QStringList FuzzyFilterProxyModel::getHorHeader() const
{
    if (auto model = sourceTableModel())
    {
        return model->getHorHeader();
    }
    else
    {
        return QStringList();
    }
}

void FuzzyFilterProxyModel::setHorHeader(const QStringList &header)
{
    if (auto model = sourceTableModel())
    {
        model->setHorHeader(header);
        emit horHeaderChanged();
    }
}

TableModel* FuzzyFilterProxyModel::sourceTableModel() const
{
    return qobject_cast<TableModel*>(this->sourceModel());
}

void FuzzyFilterProxyModel::insertRoleName(int role, const QByteArray &roleName)
{
    if (auto model = sourceTableModel())
    {
        model->insertRoleName(role, roleName);
    }
}

void FuzzyFilterProxyModel::classBegin()
{
    qInfo() << "FuzzyFilterProxyModel::classBegin()";
}

void FuzzyFilterProxyModel::componentComplete()
{
    qInfo() << "FuzzyFilterProxyModel::componentComplete()";
    setSortRole(Qt::UserRole + 1000);
    sort(0);
}

