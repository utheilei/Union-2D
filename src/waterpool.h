#ifndef WATERPOOL_H
#define WATERPOOL_H

#include <QVariantAnimation>
#include <QPainterPath>
#include <QQuickItem>

class WaterPool : public QQuickItem
{
    Q_OBJECT
public:
    explicit WaterPool(QQuickItem *parent = nullptr);
    ~WaterPool() override = default;

    Q_INVOKABLE void startFishAnimation(const QPoint &point);

private slots:
    void onValueChanged(const QVariant &value);

    void onStartFishAnimation();

private:
    QPoint randoPoint();
    QQuickItem *fishItem();

    QVariantAnimation animation;
    QPainterPath m_path;
};

#endif // WATERPOOL_H
