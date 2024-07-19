#ifndef TABLEMODEL_H
#define TABLEMODEL_H

#include <QAbstractTableModel>
#include <QQmlParserStatus>
#include <QSortFilterProxyModel>

class TableModel : public QAbstractTableModel, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)
    Q_PROPERTY(QStringList horHeader READ getHorHeader WRITE setHorHeader NOTIFY horHeaderChanged)
    Q_PROPERTY(QList<QList<QVariantMap>> modelData READ getModelData WRITE setModelData)

public:
    explicit TableModel(QObject* parent = nullptr);

    Q_INVOKABLE QStringList getHorHeader() const;
    Q_INVOKABLE void setHorHeader(const QStringList &header);

    Q_INVOKABLE QList<QList<QVariantMap>> getModelData() const;
    Q_INVOKABLE void setModelData(const QList<QList<QVariantMap>> &modelData);
    Q_INVOKABLE QString item(int row, int column) const;
    Q_INVOKABLE bool insertItem(int row, const QList<QVariantMap> &data);
    Q_INVOKABLE bool removeItem(int row);

    void classBegin() override;

    void componentComplete() override;

    Q_INVOKABLE void insertRoleName(int role, const QByteArray &roleName);

    QHash<int, QByteArray> roleNames() const override;

    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    bool setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role = Qt::EditRole) override;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex &index) const override;

    bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

    bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

signals:
    void horHeaderChanged();

private:
    bool m_completed = false;
    QList<QList<QVariantMap>> m_modelData;
    QStringList m_horHeaderList;
    QHash<int, QByteArray> m_roleNames;
};

class FuzzyFilterProxyModel : public QSortFilterProxyModel, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)
    Q_PROPERTY(QStringList horHeader READ getHorHeader WRITE setHorHeader NOTIFY horHeaderChanged)
public:
    explicit FuzzyFilterProxyModel(QObject* parent = nullptr);

    QStringList getHorHeader() const;

    void setHorHeader(const QStringList &header);

    Q_INVOKABLE TableModel* sourceTableModel() const;

    Q_INVOKABLE void insertRoleName(int role, const QByteArray &roleName);

signals:
    void horHeaderChanged();

protected:
    void classBegin() override;

    void componentComplete() override;

};

#endif // TABLEMODEL_H
