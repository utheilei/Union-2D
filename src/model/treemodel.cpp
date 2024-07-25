#include "treeitem.h"
#include "treemodel.h"

#include <QDebug>

TreeModel::TreeModel(QObject* parent) : QAbstractItemModel(parent)
{
    m_rootItem = new TreeItem(QVector<QVariant>());
}

TreeModel::~TreeModel()
{
    delete m_rootItem;
}

void TreeModel::setHeaders(const QStringList &headers)
{
    if (m_rootItem)
    {
        QVector<QVariant> data;
        foreach (const auto &text, headers)
        {
            data.append(text);
        }
        m_rootItem->setAllData(data);
    }
    emit headersChanged();
}

QStringList TreeModel::headers()
{
    QStringList list;
    foreach (const auto &text, m_rootItem->allData())
    {
        list.append(text.toString());
    }
    return list;
}

int TreeModel::columnCount(const QModelIndex & /* parent */) const
{
    return m_rootItem->columnCount();
}

QVariant TreeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role)
    {
        case Qt::DisplayRole:
        case Qt::EditRole:
        {
            const TreeItem* item = this->item(index);
            return item->data(index.column());
        }
        case Qt::FontRole:
        {
            const TreeItem* item = this->item(index);
            return item->font();
        }
        default:
            break;
    }

    return QVariant();
}

Qt::ItemFlags TreeModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return QAbstractItemModel::flags(index);

    auto flags = Qt::ItemIsEditable | QAbstractItemModel::flags(index);

    if (!item(index)->isEnabled())
    {
        flags = flags & ~(Qt::ItemIsSelectable | Qt::ItemIsEnabled);
    }

    return flags;
}

TreeItem* TreeModel::item(const QModelIndex &index) const
{
    if (index.isValid())
    {
        TreeItem* item = static_cast<TreeItem*>(index.internalPointer());
        if (item)
            return item;
    }
    return m_rootItem;
}

void TreeModel::insertItem(int position, TreeItem* item, const QModelIndex &parent)
{
    if (nullptr == item)
        return;

    TreeItem* parentItem = this->item(parent);
    beginInsertRows(parent, position, position);
    parentItem->insertChild(position, item);
    endInsertRows();
}

void TreeModel::insertItems(int position, QList<TreeItem*> items)
{
    int count = items.size();
    if (count <= 0)
        return;

    beginResetModel();
    if (m_rootItem)
        m_rootItem->insertChildren(position, items);
    endResetModel();
}

void TreeModel::appendItem(TreeItem* item)
{
    if (item == nullptr)
        return;

    beginResetModel();
    if (m_rootItem)
    {
        m_rootItem->appendChild(item);
    }
    endResetModel();
}

void TreeModel::appendItems(QList<TreeItem*> items)
{
    int count = items.size();
    if (count <= 0)
        return;

    beginResetModel();
    if (m_rootItem)
    {
        m_rootItem->appendChildren(items);
    }
    endResetModel();
}

void TreeModel::sort(int column, Qt::SortOrder order)
{
    if (m_sortEnabled)
    {
        m_rootItem->sortChildren(column, order, this);
    }
}

TreeItem* TreeModel::rootItem() const
{
    return m_rootItem;
}

QModelIndex TreeModel::createTreeIndex(int row, int column, TreeItem* parent) const
{
    return createIndex(row, column, parent);
}

void TreeModel::changeTreePersistentIndexList(const QModelIndexList &from, const QModelIndexList &to)
{
    changePersistentIndexList(from, to);
}

TreeItem* TreeModel::itemFromIndex(const QModelIndex &index) const
{
    if (!index.isValid())
        return m_rootItem;

    return static_cast<TreeItem*>(index.internalPointer());
}

QModelIndex TreeModel::indexFromItem(const TreeItem* item) const
{
    if (item && item->parent())
    {
        return createIndex(item->childNumber(), 0, const_cast<TreeItem*>(item));
    }

    return QModelIndex();
}

QList<TreeItem*> TreeModel::findItems(const QString &text, Qt::SortOrder order)
{
    QList<TreeItem*> items = matchItems(m_rootItem, text);

    std::stable_sort(items.begin(), items.end(), [order, this](const TreeItem * infoA, const TreeItem * infoB)
    {
        if (Qt::SortOrder::AscendingOrder == order)
        {
            return indexFromItem(infoA).row() < indexFromItem(infoB).row();
        }
        else
        {
            return indexFromItem(infoA).row() > indexFromItem(infoB).row();
        }
    });

    return items;
}

QModelIndexList TreeModel::findModelIndexs(const QString &text, Qt::SortOrder order)
{
    QModelIndexList list;
    QList<TreeItem*> items = findItems(text, order);

    foreach (const auto &item, items)
        list.append(indexFromItem(item));

    return list;
}

void TreeModel::clearModel(TreeItem* item)
{
    TreeItem* deleteItem = (nullptr == item) ? m_rootItem : item;
    beginResetModel();
    deleteItem->removeAllChildren();
    endResetModel();
}

void TreeModel::setSortEnabled(bool enabled)
{
    m_sortEnabled = enabled;
}

bool TreeModel::childHasSelected(const QModelIndex &currentIndex, const QModelIndexList &selectIndexs)
{
    if (!currentIndex.isValid())
        return false;

    if (!hasChildren(currentIndex))
        return false;

    for (int i = 0; i < rowCount(currentIndex); i++)
    {
        auto childIndex = this->index(i, 0, currentIndex);
        if (!childIndex.isValid())
            continue;

        if (!hasChildren(childIndex))
        {
            if (selectIndexs.contains(childIndex))
            {
                return true;
            }
        }
        else
        {
            if (childHasSelected(childIndex, selectIndexs))
            {
                return true;
            }
        }
    }

    return false;
}

QList<TreeItem*> TreeModel::matchItems(TreeItem* item, const QString &text)
{
    QList<TreeItem*> items;

    if (nullptr == item)
        return items;

    for (int i = 0; i < item->childCount(); i++)
    {
        auto childItem = item->child(i);
        if (nullptr == childItem)
            continue;

        if (childItem->childCount() <= 0)
        {
            if (0 == QString::compare(text, childItem->data(0).toString()))
            {
                items.append(childItem);
            }
        }
        else
        {
            items.append(matchItems(childItem, text));
        }
    }

    return items;
}

QVariant TreeModel::headerData(int section, Qt::Orientation orientation,
                               int role) const
{
    if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
        return m_rootItem->data(section);

    return QVariant();
}

QModelIndex TreeModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!hasIndex(row, column, parent))
        return QModelIndex();

    if (parent.isValid() && parent.column() != 0)
        return QModelIndex();

    TreeItem* parentItem = this->item(parent);

    TreeItem* childItem = parentItem->child(row);
    if (childItem)
        return createIndex(row, column, childItem);
    else
        return QModelIndex();
}

bool TreeModel::insertColumns(int position, int columns, const QModelIndex &parent)
{
    bool success;

    beginInsertColumns(parent, position, position + columns - 1);
    success = m_rootItem->insertColumns(position, columns);
    endInsertColumns();

    return success;
}

bool TreeModel::insertRows(int position, int rows, const QModelIndex &parent)
{
    TreeItem* parentItem = this->item(parent);
    bool success;

    beginInsertRows(parent, position, position + rows - 1);
    success = parentItem->insertChildren(position, rows, m_rootItem->columnCount());
    endInsertRows();

    return success;
}

QModelIndex TreeModel::parent(const QModelIndex &index) const
{
    if (!index.isValid())
        return QModelIndex();

    const TreeItem* childItem = this->item(index);
    TreeItem* parentItem = childItem->parent();

    if (parentItem == m_rootItem || !parentItem)
        return QModelIndex();

    return createIndex(parentItem->childNumber(), 0, parentItem);
}

bool TreeModel::removeColumns(int position, int columns, const QModelIndex &parent)
{
    bool success;

    beginRemoveColumns(parent, position, position + columns - 1);
    success = m_rootItem->removeColumns(position, columns);
    endRemoveColumns();

    if (m_rootItem->columnCount() == 0)
        removeRows(0, rowCount());

    return success;
}

bool TreeModel::removeRows(int position, int rows, const QModelIndex &parent)
{
    TreeItem* parentItem = this->item(parent);
    bool success = true;

    beginRemoveRows(parent, position, position + rows - 1);
    success = parentItem->removeChildren(position, rows);
    endRemoveRows();

    return success;
}

bool TreeModel::moveItem(const QModelIndex &source, int sourceRow,
                         const QModelIndex &destination, int destinationChild)
{
    auto sourceItem = itemFromIndex(source);
    auto sourceParentItem = itemFromIndex(source.parent());
    auto destinationItem = itemFromIndex(destination);
    beginResetModel();
    auto item = sourceParentItem->takeItem(sourceItem->childNumber());
    item->setParent(destinationItem);
    destinationItem->insertChild(destination.row(), item);
    endResetModel();
    emit layoutChanged();
    return true;
}

void TreeModel::insertItems(int position, const QList<QVariantList> &datas, const QModelIndex &parent)
{
    qDebug() << "insertItems" << parent;
    TreeItem* parentItem = this->item(parent);
    QList<TreeItem*> items;
    for (const auto &data : datas)
    {
        items.append(new TreeItem(data.toVector(), parentItem));
    }
    int rows = datas.size();
    beginInsertRows(parent, position, position + rows - 1);
    parentItem->insertChildren(position, items);
    endInsertRows();
}

void TreeModel::insertItem(int position, const QVariantList &data, const QModelIndex &parent)
{
    TreeItem* parentItem = this->item(parent);
    beginInsertRows(parent, position, position);
    TreeItem* item = new TreeItem(data.toVector(), parentItem);
    parentItem->insertChild(position, item);
    endInsertRows();
}

QVariant TreeModel::itemData(int column, const QModelIndex &index) const
{
    return item(index)->data(column);
}

int TreeModel::rowCount(const QModelIndex &parent) const
{
    if (parent.column() > 0) return 0;

    const TreeItem* parentItem = this->item(parent);

    return parentItem->childCount();
}

bool TreeModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (role != Qt::EditRole)
        return false;

    TreeItem* item = this->item(index);
    if (value == item->data(index.column()))
    {
        return true;
    }
    bool result = item->setData(index.column(), value);

    if (result)
        emit dataChanged(index, index, {role});

    return result;
}

bool TreeModel::setHeaderData(int section, Qt::Orientation orientation,
                              const QVariant &value, int role)
{
    if (role != Qt::EditRole || orientation != Qt::Horizontal)
        return false;

    bool result = m_rootItem->setData(section, value);

    if (result)
        emit headerDataChanged(orientation, section, section);

    return result;
}
