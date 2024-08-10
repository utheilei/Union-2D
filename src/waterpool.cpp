#include "waterpool.h"

#include <QTime>
#include <QtMath>

WaterPool::WaterPool(QQuickItem *parent) : QQuickItem(parent)
{
    animation.setDuration(3000);
    animation.setEasingCurve(QEasingCurve::OutCirc);

    connect(&animation, &QVariantAnimation::valueChanged, this, &WaterPool::onValueChanged);

    connect(&animation, &QVariantAnimation::finished, this, &WaterPool::onStartFishAnimation);

    connect(this, &WaterPool::visibleChanged, this, &WaterPool::onStartFishAnimation);
}

void WaterPool::startFishAnimation(const QPoint &point)
{
    auto item = fishItem();
    if (nullptr == item)
        return;
    QPoint startPos = QRectF(item->position(), item->size()).center().toPoint();
    QPoint endPos = QPoint((point.x() - item->width()/2), (point.y() - item->height()/2));
    animation.setStartValue(startPos);
    animation.setEndValue(endPos);

    QPainterPath path(startPos);
    QPoint c1((startPos + endPos).x()/2, startPos.y());
    QPoint c2((startPos + endPos).x()/2, endPos.y());
    path.cubicTo(c1, c2, endPos);
    m_path = path;
    animation.start();
}

void WaterPool::onValueChanged(const QVariant &value)
{
    auto item = fishItem();
    if (nullptr == item)
        return;
    QPoint point = value.value<QPoint>();
    auto totalPoint = (animation.endValue().value<QPoint>() - animation.startValue().value<QPoint>());
    auto currentPoint = (point - animation.startValue().value<QPoint>());
    qreal percent = qreal(float(qAbs(currentPoint.rx() * currentPoint.y())) / float(qAbs(totalPoint.x() * totalPoint.y())));
    item->setRotation(-m_path.angleAtPercent(percent));
    item->setX(m_path.pointAtPercent(percent).x() - item->width()/2);
    item->setY(m_path.pointAtPercent(percent).y() - item->height()/2);
}

void WaterPool::onStartFishAnimation()
{
    if (this->isVisible())
    {
        startFishAnimation(randoPoint());
    }
}

QPoint WaterPool::randoPoint()
{
    QTime time;
    time= QTime::currentTime();
    qsrand(time.msec() + time.second()*1000);
    int x = qrand() % int(width());
    int y = qrand() % int(height());

    if (!this->contains(QPoint(x, y)))
        return randoPoint();

    return QPoint(x, y);
}

QQuickItem *WaterPool::fishItem()
{
    return findChild<QQuickItem *>("fish");
}

