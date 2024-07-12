#include "treeitem.h"
#include "treemodel.h"

TreeModel::TreeModel(const QStringList &headers, QObject* parent)
    : QAbstractItemModel(parent)
{
    QVector<QVariant> rootData;
    foreach (QString header, headers)
        rootData << header;

    m_rootItem = new TreeItem(rootData);
}

TreeModel::~TreeModel()
{
    delete m_rootItem;
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
            const TreeItem* item = getItem(index);
            return item->data(index.column());
        }
        case Qt::FontRole:
        {
            const TreeItem* item = getItem(index);
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
        return Q_NULLPTR;

    auto flags = Qt::ItemIsEditable | QAbstractItemModel::flags(index);

    if (!getItem(index)->isEnabled())
    {
        flags = flags & ~(Qt::ItemIsSelectable | Qt::ItemIsEnabled);
    }

    return flags;
}

TreeItem* TreeModel::getItem(const QModelIndex &index) const
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

    TreeItem* parentItem = getItem(parent);
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
    auto model = index.model();
    if (nullptr == model)
        return nullptr;

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

    qSort(items.begin(), items.end(), [order, this](const TreeItem * infoA, const TreeItem * infoB)
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

    TreeItem* parentItem = getItem(parent);

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
    TreeItem* parentItem = getItem(parent);
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

    const TreeItem* childItem = getItem(index);
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
    TreeItem* parentItem = getItem(parent);
    bool success = true;

    beginRemoveRows(parent, position, position + rows - 1);
    success = parentItem->removeChildren(position, rows);
    endRemoveRows();

    return success;
}

int TreeModel::rowCount(const QModelIndex &parent) const
{
    if (parent.column() > 0) return 0;

    const TreeItem* parentItem = getItem(parent);

    return parentItem->childCount();
}

bool TreeModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (role != Qt::EditRole)
        return false;

    TreeItem* item = getItem(index);
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
