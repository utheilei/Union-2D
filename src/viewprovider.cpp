#include "viewprovider.h"

ViewProvider::ViewProvider()
    : QQuickImageProvider(QQuickImageProvider::Image)
{

}

ViewProvider::~ViewProvider()
{
}

void ViewProvider::updateView(const QImage &view)
{
    m_views = view;
}

QImage ViewProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    return m_views.isNull() ? QImage(":/icon/images/backgroud.jpeg") : m_views;
}
