#include "treeitem.h"
#include "treemodel.h"

#include <QStringList>
#include <QDebug>
#include <QDateTime>
#include <QModelIndexList>

TreeItem::TreeItem(const QVector<QVariant> &data, TreeItem* parent): itemData(data), parentItem(parent)
{
    setEnabled(true);
}

TreeItem::~TreeItem()
{
    removeAllChildren();
}

void TreeItem::setProperty(const QString &name, const QVariant &value)
{
    m_propertyMap[name] = value;
}

QVariant TreeItem::property(const QString &name) const
{
    return m_propertyMap[name];
}

void TreeItem::setFont(const QFont &font)
{
    m_font = font;
}

QFont TreeItem::font() const
{
    return m_font;
}

TreeItem *TreeItem::takeItem(int index)
{
    if (index < 0 || index > childItems.size())
        return nullptr;
    return childItems.takeAt(index);
}

void TreeItem::setEnabled(bool enabled)
{
    m_propertyMap["Enabled"] = enabled;
}

bool TreeItem::isEnabled() const
{
    return m_propertyMap["Enabled"].toBool();
}

TreeItem* TreeItem::child(int number)
{
    return childItems.at(number);
}

int TreeItem::childCount() const
{
    return childItems.count();
}

bool TreeItem::isEmpty() const
{
    return childItems.empty();
}

int TreeItem::childNumber() const
{
    if (parentItem)
        return parentItem->childItems.indexOf(const_cast<TreeItem*>(this));

    return 0;
}

int TreeItem::columnCount() const
{
    return itemData.count();
}

QVariant TreeItem::data(int column) const
{
    if (column > itemData.size() - 1)
        return QVariant();

    return itemData.value(column);
}

bool TreeItem::insertChildren(int position, int count, int columns)
{
    if (position < 0 || position > childItems.size())
        return false;

    for (int row = 0; row < count; ++row)
    {
        QVector<QVariant> data(columns);
        TreeItem* item = new TreeItem(data, this);
        childItems.insert(position, item);
    }

    return true;
}

bool TreeItem::insertColumns(int position, int columns)
{
    if (position < 0 || position > itemData.size())
        return false;

    for (int column = 0; column < columns; ++column)
        itemData.insert(position, QVariant());

    foreach (TreeItem* child, childItems)
        child->insertColumns(position, columns);

    return true;
}

TreeItem* TreeItem::parent() const
{
    return parentItem;
}

bool TreeItem::removeChildren(int position, int count)
{
    if (position < 0 || position + count > childItems.size())
        return false;

    for (int row = 0; row < count; ++row)
        delete childItems.takeAt(position);

    return true;
}

bool TreeItem::removeColumns(int position, int columns)
{
    if (position < 0 || position + columns > itemData.size())
        return false;

    for (int column = 0; column < columns; ++column)
        itemData.remove(position);

    foreach (TreeItem* child, childItems)
        child->removeColumns(position, columns);

    return true;
}

bool TreeItem::setData(int column, const QVariant &value)
{
    if (column < 0 || column >= itemData.size())
        return false;

    itemData[column] = value;
    return true;
}

void TreeItem::appendChild(TreeItem* item)
{
    childItems.append(item);
}

void TreeItem::appendChildren(QList<TreeItem*> items)
{
    childItems.append(items);
}

void TreeItem::insertChild(int position, TreeItem* item)
{
    if (position < 0 || position > childItems.size())
        return;

    if (nullptr == item)
    {
        return;
    }
    childItems.insert(position, item);
}

void TreeItem::insertChildren(int position, QList<TreeItem*> items)
{
    if (position < 0 || position > childItems.size())
        return;

    int count = items.size();
    for (int row = position; row < count + position; ++row)
    {
        auto item = items.at(row - position);
        childItems.insert(row, item);
    }
}

void TreeItem::removeAllChildren()
{
    if (!childItems.isEmpty())
    {
        qDeleteAll(childItems);
        childItems.clear();
    }
}

void TreeItem::setIcon(const QIcon &icon)
{
    m_icon = icon;
}

int TreeItem::depth() const
{
    int d = 0;
    auto pNode = this;
    while (pNode->parent())
    {
        d++;
        pNode = pNode->parent();
    }

    return d;
}

void TreeItem::setAllData(const QVector<QVariant> &data)
{
    itemData = data;
}

QVector<QVariant> TreeItem::allData() const
{
    return itemData;
}

void TreeItem::sortChildren(int column, Qt::SortOrder order, TreeModel* model)
{
    if (column >= columnCount() || childCount() <= 0)
        return;

    QVector<QPair<TreeItem*, int>> sortable;
    sortable.reserve(childCount());

    for (int row = 0; row < childCount(); ++row)
    {
        TreeItem* itm = child(row);
        if (itm)
            sortable.append(qMakePair(itm, row));
    }

    if (order == Qt::AscendingOrder)
    {
        std::stable_sort(sortable.begin(), sortable.end(), [column](const QPair<TreeItem*, int> &s1, const QPair<TreeItem*, int> &s2)
        {
            QVariant variant1 = s1.first->data(column);
            QVariant variant2 = s2.first->data(column);
            return isVariantLessThan(variant1, variant2);
        });
    }
    else
    {
        std::stable_sort(sortable.begin(), sortable.end(), [column](const QPair<TreeItem*, int> &s1, const QPair<TreeItem*, int> &s2)
        {
            QVariant variant1 = s1.first->data(column);
            QVariant variant2 = s2.first->data(column);
            return isVariantLessThan(variant2, variant1);
        });
    }

    QModelIndexList changedPersistentIndexesFrom;
    QModelIndexList changedPersistentIndexesTo;
    QList<TreeItem*> sorted_children;
    for (int i = 0; i < childCount(); ++i)
    {
        int r = sortable.at(i).second;
        TreeItem* itm = child(r);
        sorted_children.append(itm);
        if (model)
        {
            QModelIndex from = model->createTreeIndex(r, 0, this);
            QModelIndex to = model->createTreeIndex(i, 0, this);
            changedPersistentIndexesFrom.append(from);
            changedPersistentIndexesTo.append(to);
        }
    }

    childItems = sorted_children;

    if (model)
    {
        model->changeTreePersistentIndexList(changedPersistentIndexesFrom, changedPersistentIndexesTo);
    }

    foreach (const auto &it, childItems)
    {
        it->sortChildren(column, order, model);
    }
}

void TreeItem::setParent(TreeItem* parent)
{
    parentItem = parent;
}

bool TreeItem::isVariantLessThan(const QVariant &left, const QVariant &right, bool isLocaleAware, Qt::CaseSensitivity caseSensitivity)
{
    if (left.userType() == QVariant::Invalid)
        return false;
    if (right.userType() == QVariant::Invalid)
        return true;

    switch (left.userType())
    {
        case QVariant::Int:
            return left.toInt() < right.toInt();
        case QVariant::UInt:
            return left.toUInt() < right.toUInt();
        case QVariant::LongLong:
            return left.toLongLong() < right.toLongLong();
        case QVariant::ULongLong:
            return left.toULongLong() < right.toULongLong();
        case QMetaType::Float:
            return left.toFloat() < right.toFloat();
        case QVariant::Double:
            return left.toDouble() < right.toDouble();
        case QVariant::Char:
            return left.toChar() < right.toChar();
        case QVariant::Date:
            return left.toDate() < right.toDate();
        case QVariant::Time:
            return left.toTime() < right.toTime();
        case QVariant::DateTime:
            return left.toDateTime() < right.toDateTime();
        default:
            if (isLocaleAware)
                return left.toString().localeAwareCompare(right.toString()) < 0;
            else
                return left.toString().compare(right.toString(), caseSensitivity) < 0;
    }
}
