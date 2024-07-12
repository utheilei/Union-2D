#ifndef TREEITEM_H
#define TREEITEM_H

#include "UIComponent/uicomponent_global.h"

#include <QIcon>
#include <QVariant>
#include <QVector>
#include <QFont>

class TreeModel;

class UICOMPONENT_EXPORT TreeItem
{
public:
    explicit TreeItem(const QVector<QVariant> &data, TreeItem* parent = nullptr);
    ~TreeItem();

    void setProperty(const QString &name, const QVariant &value);
    QVariant property(const QString &name) const;

    void setFont(const QFont &font);
    QFont font() const;

    void setEnabled(bool enabled);
    bool isEnabled() const;

    TreeItem* child(int number);
    int childCount() const;
    bool isEmpty() const;
    int columnCount() const;
    QVariant data(int column) const;
    bool insertChildren(int position, int count, int columns);
    bool insertColumns(int position, int columns);
    TreeItem* parent() const;
    bool removeChildren(int position, int count);
    bool removeColumns(int position, int columns);
    int childNumber() const;
    bool setData(int column, const QVariant &value);

    void appendChild(TreeItem* item);
    void appendChildren(QList<TreeItem*> items);
    void insertChild(int position, TreeItem* item);
    void insertChildren(int position, QList<TreeItem*> items);

    inline QIcon icon() const
    {
        return m_icon;
    }

    void removeAllChildren();

    void setIcon(const QIcon &icon);

    int depth() const;

    QVector<QVariant> allData() const;

    void sortChildren(int column, Qt::SortOrder order, TreeModel* model);

    void setParent(TreeItem* parent);

    static bool isVariantLessThan(const QVariant &left, const QVariant &right,
                                  bool isLocaleAware = true, Qt::CaseSensitivity caseSensitivity = Qt::CaseInsensitive);

private:
    QList<TreeItem*> childItems;
    QVector<QVariant> itemData;
    TreeItem* parentItem = nullptr;
    QIcon m_icon = QIcon();
    QFont m_font;
    QMap<QString, QVariant> m_propertyMap;
};

#endif // TREEITEM_H
