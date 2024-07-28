#ifndef TREEITEM_H
#define TREEITEM_H

#include <QIcon>
#include <QVariant>
#include <QVector>
#include <QFont>

class TreeModel;

class TreeItem
{
public:
    explicit TreeItem(const QVector<QVariant> &data, TreeItem* parent = nullptr);
    ~TreeItem();

    Q_INVOKABLE void setProperty(const QString &name, const QVariant &value);
    Q_INVOKABLE QVariant property(const QString &name) const;

    void setFont(const QFont &font);
    QFont font() const;

    TreeItem *takeItem(int index);

    Q_INVOKABLE void setEnabled(bool enabled);
    Q_INVOKABLE bool isEnabled() const;

    Q_INVOKABLE TreeItem* child(int number);
    Q_INVOKABLE int childCount() const;
    Q_INVOKABLE bool isEmpty() const;
    Q_INVOKABLE int columnCount() const;
    Q_INVOKABLE QVariant data(int column) const;

    bool insertChildren(int position, int count, int columns);
    bool insertColumns(int position, int columns);

    Q_INVOKABLE TreeItem* parent() const;

    bool removeChildren(int position, int count);
    bool removeColumns(int position, int columns);

    Q_INVOKABLE int childNumber() const;
    Q_INVOKABLE bool setData(int column, const QVariant &value);

    Q_INVOKABLE void appendChild(TreeItem* item);
    Q_INVOKABLE void appendChildren(QList<TreeItem*> items);
    Q_INVOKABLE void insertChild(int position, TreeItem* item);
    Q_INVOKABLE void insertChildren(int position, QList<TreeItem*> items);

    inline QIcon icon() const
    {
        return m_icon;
    }

    void removeAllChildren();

    Q_INVOKABLE void setIcon(const QIcon &icon);

    Q_INVOKABLE int depth() const;

    Q_INVOKABLE void setAllData(const QVector<QVariant> &data);
    Q_INVOKABLE QVector<QVariant> allData() const;

    void sortChildren(int column, Qt::SortOrder order, TreeModel* model);

    Q_INVOKABLE void setParent(TreeItem* parent);

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
