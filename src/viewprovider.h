#ifndef VIEWPROVIDER_H
#define VIEWPROVIDER_H

#include <QQuickImageProvider>

class ViewProvider : public QQuickImageProvider
{
public:
    ViewProvider();
    ~ViewProvider() override;

    void updateView(const QImage &view);
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;

private:
    QImage m_views;
};

#endif // VIEWPROVIDER_H
