/*
* Copyright (C) 2020 ~ 2035 Uniontech Software Technology Co.,Ltd.
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

#ifndef QUICKTEXTDOCUMENT_H
#define QUICKTEXTDOCUMENT_H

#include <QQuickTextDocument>

class QuickTextDocument : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QQuickTextDocument *quickTextDocument READ quickTextDocument WRITE setQuickTextDocument NOTIFY quickTextDocumentChanged)
    Q_PROPERTY(int cursorPosition READ cursorPosition WRITE setCursorPosition NOTIFY cursorPositionChanged)
    Q_PROPERTY(int maxWidth READ maxWidth WRITE setMaxWidth NOTIFY maxWidthChanged)
    Q_PROPERTY(int maxHeight READ maxHeight WRITE setMaxHeight NOTIFY maxHeightChanged)

public:
    explicit QuickTextDocument(QObject *parent = Q_NULLPTR);
    ~QuickTextDocument();

    Q_INVOKABLE void insertQuickImage(const QUrl &url);
    Q_INVOKABLE void processQuickImage(const QString &text);
    Q_INVOKABLE void processPasteText();
    Q_INVOKABLE void clear();
    Q_INVOKABLE QString toPlainText();

    QQuickTextDocument *quickTextDocument() const;
    void setQuickTextDocument(QQuickTextDocument *document);

    int cursorPosition() const;
    void setCursorPosition(int position);

    int maxWidth() const;
    void setMaxWidth(int max);

    int maxHeight() const;
    void setMaxHeight(int max);

private:
    QTextDocument *textDocument() const;
    QTextCursor textCursor() const;
    void insertImage(const QString &fileName, const QSize &size);
    QString toLocalFileName(QString &name);
    void processMovie(const QUrl &url);

Q_SIGNALS:
    void imageUpdate();
    void quickTextDocumentChanged();
    void cursorPositionChanged();
    void maxWidthChanged();
    void maxHeightChanged();

private:
    QMap<QUrl, QMovie *> m_urls;
    QQuickTextDocument *m_quickTextDocument;
    int m_cursorPosition;
    int m_maxWidth = 100;
    int m_maxHeight = 100;
};

#endif // QUICKTEXTDOCUMENT_H
