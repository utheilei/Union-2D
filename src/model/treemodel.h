#ifndef TREEMODEL_H
#define TREEMODEL_H

#include <QAbstractItemModel>
#include <QModelIndex>
#include <QVariant>

class TreeItem;
class TreeModel : public QAbstractItemModel
{
    Q_OBJECT

public:
    Q_PROPERTY(QStringList headers READ headers WRITE setHeaders NOTIFY headersChanged)

    explicit TreeModel(QObject* parent = Q_NULLPTR);
    ~TreeModel() override;

    void setHeaders(const QStringList &headers);

    QStringList headers();

    QVariant data(const QModelIndex &index, int role) const override;
    QVariant headerData(int section, Qt::Orientation orientation,
                        int role = Qt::DisplayRole) const override;

    Q_INVOKABLE QModelIndex index(int row, int column,
                                  const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE QModelIndex parent(const QModelIndex &index) const override;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    Qt::ItemFlags flags(const QModelIndex &index) const override;
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;
    bool setHeaderData(int section, Qt::Orientation orientation,
                       const QVariant &value, int role = Qt::EditRole) override;

    bool insertColumns(int position, int columns,
                       const QModelIndex &parent = QModelIndex()) override;
    bool removeColumns(int position, int columns,
                       const QModelIndex &parent = QModelIndex()) override;
    bool insertRows(int position, int rows,
                    const QModelIndex &parent = QModelIndex()) override;
    bool removeRows(int position, int rows,
                    const QModelIndex &parent = QModelIndex()) override;

    Q_INVOKABLE bool moveItem(const QModelIndex &source, int sourceRow,
                              const QModelIndex &destination, int destinationChild);

    Q_INVOKABLE void insertItems(int position, const QList<QVariantList> &datas, const QModelIndex &parent = QModelIndex());

    Q_INVOKABLE void insertItem(int position, const QVariantList &data, const QModelIndex &parent = QModelIndex());

    Q_INVOKABLE QVariant itemData(int column, const QModelIndex &index) const;

    Q_INVOKABLE TreeItem* item(const QModelIndex &index) const;

    void insertItem(int position, TreeItem* item, const QModelIndex &parent = QModelIndex());

    void insertItems(int position, QList<TreeItem*> items);

    void appendItem(TreeItem* item);

    void appendItems(QList<TreeItem*> items);

    Q_INVOKABLE void sort(int column, Qt::SortOrder order = Qt::AscendingOrder) override;

    Q_INVOKABLE TreeItem* rootItem() const;

    QModelIndex createTreeIndex(int row, int column, TreeItem* parent) const;

    void changeTreePersistentIndexList(const QModelIndexList &from, const QModelIndexList &to);

    Q_INVOKABLE TreeItem* itemFromIndex(const QModelIndex &index) const;

    Q_INVOKABLE QModelIndex indexFromItem(const TreeItem* item) const;

    Q_INVOKABLE QList<TreeItem*> findItems(const QString &text, Qt::SortOrder order);

    Q_INVOKABLE QModelIndexList findModelIndexs(const QString &text, Qt::SortOrder order);

    Q_INVOKABLE void clearModel(TreeItem* item = nullptr);

    Q_INVOKABLE void setSortEnabled(bool enabled);

    Q_INVOKABLE bool childHasSelected(const QModelIndex &currentIndex, const QModelIndexList &selectIndexs);

signals:
    void headersChanged();

private:
    QList<TreeItem*> matchItems(TreeItem* item, const QString &text);
    TreeItem* m_rootItem = nullptr;
    bool m_sortEnabled = false;
};

#endif // TREEMODEL_H
