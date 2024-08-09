/*
* Copyright (C) 2020 ~ 2025 Uniontech Software Technology Co.,Ltd.
*
* Author:     helei <helei@uniontech.com>
*
* Maintainer: helei <helei@uniontech.com>
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "textdocument.h"

#include <QApplication>
#include <QClipboard>
#include <QFileInfo>
#include <QMimeData>
#include <QMovie>
#include <QQmlFile>
#include <QTextCursor>

QuickTextDocument::QuickTextDocument(QObject *parent) : QObject(parent)
{
}

QuickTextDocument::~QuickTextDocument()
{
    clear();
}

void QuickTextDocument::insertQuickImage(const QUrl &url)
{
    if (!url.isValid() || url.isEmpty())
        return;

    QImage image = QImage(QQmlFile::urlToLocalFileOrQrc(url));
    if (image.isNull()) {
        qInfo() << "不支持的图像格式";
        return;
    }

    QString filename = url.toString();
    int width = qMin(m_maxWidth, image.width());
    int height = qMin(m_maxHeight, image.height());
    if (filename.left(3) == "qrc") {
        width = 25;
        height = 25;
    }

    qInfo() << "processMovie" << filename << url << QQmlFile::urlToLocalFileOrQrc(url);
    insertImage(filename, QSize(width, height));
    processMovie(url);
}

void QuickTextDocument::processQuickImage(const QString &text)
{
    QRegExp imgReg("<img src\\s*=\\s*['\"]([^'\"]*)['\"]");
    QString str = text;
    QStringList imageList;
    int pos = 0;
    while ((pos = imgReg.indexIn(str, pos)) != -1) {
        auto cap = imgReg.capturedTexts().at(0);
        if (cap.contains("qrc:/")) {
            cap = cap.mid(cap.indexOf("qrc:/"));
            cap = cap.left(cap.length() - 1);
            if (!imageList.contains(cap))
                imageList << cap;
        } else if (cap.contains("file:/")) {
            cap = cap.mid(cap.indexOf("file:/"));
            cap = cap.left(cap.length() - 1);
            if (!imageList.contains(cap))
                imageList << cap;
        }
        pos += imgReg.matchedLength();
    }

    foreach (const auto &image, imageList)
        processMovie(QUrl(image));
}

void QuickTextDocument::processPasteText()
{
    const QClipboard *clipboard = QApplication::clipboard();
    QString text = clipboard->text();
    const QMimeData *mimeData = clipboard->mimeData();

    if (mimeData->hasImage()) {
        textCursor().insertImage(qvariant_cast<QImage>(mimeData->imageData()), text);
    } else if (mimeData->hasHtml()) {
        textCursor().insertHtml(mimeData->html());
        processQuickImage(mimeData->html());
    } else {
        QUrl url;
        if (text.startsWith("file") || text.startsWith("qrc"))
            url = QUrl(text);
        else
            url = QUrl::fromLocalFile(text);

        QFileInfo info(toLocalFileName(text));
        if (info.isFile()) {
            QImage image = QImage(toLocalFileName(text));
            if (image.isNull()) {
                textCursor().insertText(clipboard->text());
            } else {
                int width = qMin(m_maxWidth, image.width());
                int height = qMin(m_maxHeight, image.height());
                if (clipboard->text().left(3) == "qrc") {
                    width = 25;
                    height = 25;
                }
                qInfo() << "=======" << url;
                insertImage(url.toString(), QSize(width, height));
                processMovie(url);
            }
        } else {
            textCursor().insertText(clipboard->text());
        }
    }
}

void QuickTextDocument::clear()
{
    for (auto it : m_urls)
        it->deleteLater();
    m_urls.clear();
}

QString QuickTextDocument::toPlainText()
{
    if (textDocument()) {
        return textDocument()->toPlainText();
    } else {
        return QString();
    }
}

QQuickTextDocument *QuickTextDocument::quickTextDocument() const
{
    return m_quickTextDocument;
}

void QuickTextDocument::setQuickTextDocument(QQuickTextDocument *document)
{
    if (m_quickTextDocument != document) {
        m_quickTextDocument = document;
        emit quickTextDocumentChanged();
    }
}

int QuickTextDocument::cursorPosition() const
{
    return m_cursorPosition;
}

void QuickTextDocument::setCursorPosition(int position)
{
    if (m_cursorPosition != position) {
        m_cursorPosition = position;
        emit cursorPositionChanged();
    }
}

int QuickTextDocument::maxWidth() const
{
    return m_maxWidth;
}

void QuickTextDocument::setMaxWidth(int max)
{
    if (m_maxWidth != max) {
        m_maxWidth = max;
        emit maxWidthChanged();
    }
}

int QuickTextDocument::maxHeight() const
{
    return m_maxHeight;
}

void QuickTextDocument::setMaxHeight(int max)
{
    if (m_maxHeight != max) {
        m_maxHeight = max;
        emit maxHeightChanged();
    }
}

QTextDocument *QuickTextDocument::textDocument() const
{
    if (m_quickTextDocument == Q_NULLPTR)
        return Q_NULLPTR;

    auto doc = m_quickTextDocument->textDocument();
    doc->setDefaultStyleSheet(".divs .imgs{display: inline-block;vertical-align: middle;}.divs .infos{display: inline-block;}");

    return doc;
}

QTextCursor QuickTextDocument::textCursor() const
{
    if (textDocument() == Q_NULLPTR)
        return QTextCursor();

    QTextDocument *doc = textDocument();

    QTextCursor cursor = QTextCursor(doc);
    cursor.setPosition(m_cursorPosition);
    return cursor;
}

void QuickTextDocument::insertImage(const QString &fileName, const QSize &size)
{
    QTextImageFormat format;
    format.setName(fileName);
    format.setWidth(size.width());
    format.setHeight(size.height());
    format.setVerticalAlignment(QTextCharFormat::AlignBaseline);
    textCursor().insertImage(format, QTextFrameFormat::InFlow);
}

QString QuickTextDocument::toLocalFileName(QString &name)
{
    if (name.left(4) == "file")
        name = name.mid(8);
    else if (name.left(3) == "qrc")
        name = name.mid(3);

    return name;
}

void QuickTextDocument::processMovie(const QUrl &url)
{
    QString fileName = url.toString();
    QString suffix = QFileInfo(fileName).suffix();
    if (suffix == "GIF" || suffix == "gif") {
        if (m_urls.contains(url))
            return;

        QMovie *movie = new QMovie(toLocalFileName(fileName));
        movie->setCacheMode(QMovie::CacheNone);
        connect(movie, &QMovie::finished, movie, &QMovie::start);
        connect(movie, &QMovie::frameChanged, this, [url, this](int){
            QMovie *movie = qobject_cast<QMovie *>(sender());
            textDocument()->addResource(QTextDocument::ImageResource, url, movie->currentPixmap());
            emit imageUpdate();
        });
        m_urls[url] = movie;
        movie->start();
    }
}
