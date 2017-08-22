/***************************************************************************************************
 *
 * $ALPINE_TOOLKIT_BEGIN_LICENSE:GPL3$
 *
 * Copyright (C) 2017 Fabrice Salvaire
 * Contact: http://www.fabrice-salvaire.fr
 *
 * This file is part of the Alpine ToolKit software.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $ALPINE_TOOLKIT_END_LICENSE$
 *
 **************************************************************************************************/

import QtQml 2.2
import QtQuick 2.6

import QtQuick.Controls 2.1

import "qrc:Widgets" as Widgets

Widgets.Popup {

    onAboutToShow: {
        if (! third_party_license_schema_manager.is_json_loaded()) {
            third_party_license_schema_manager.load_json();
            var third_party_licenses = third_party_license_schema_manager.third_party_licenses;
            for (var i = 0; i < third_party_licenses.length; i++) {
                var third_party_license = third_party_licenses[i];
                console.info(third_party_license.third_party_name);
                about_text += "<h3>" + third_party_license.third_party_name + "</h3>";
                about_text += "<ul>";
                about_text += "<li><a href=\"" + third_party_license.third_party_url + "\">Home page</a></li>";
                // if (third_party_license.licence_name)
                about_text += "<li>License: " + third_party_license.license_name + "</li>";
                // if (third_party_license.licence_url)
                about_text += "<li><a href=\"" + third_party_license.license_url + "\">License page</a></li>";
                about_text += "</ul>";
                about_text += "<div>" + third_party_license.license_text + "</div>";
            }
        }
    }

    Flickable {
        id: flickable
        anchors.fill: parent

        TextArea.flickable: TextArea {
            id: text_area
            font.pointSize: 12
            readOnly: true
            text: about_text
            textFormat: TextEdit.RichText
            wrapMode: Text.WordWrap

            background: null // suppress bottom line

            onLinkActivated: Qt.openUrlExternally(link)
            // Fixme: hover style
            // http://doc.qt.io/qt-5/richtext-html-subset.html
            // :hover is not supported
        }

        ScrollBar.vertical: ScrollBar { }
    }

    property string about_text : '
<h1>About</h1>

<p><strong>Alpine ToolKit Test Release V%1</strong></p>

<p>Copyright © 2017 Fabrice Salvaire</p>

<p><a href="%2">%2</a></p>

<p><strong></strong></p>
<p><strong>For R&D use only</strong></p>
<p><strong>Will stop to work after 2017/08/31</strong></p>

This sofwtare is using Qt LGPL, SQLite, cmark github, SnowBall.

<h2>Third Parties Licenses</h2>
'.arg(1).arg(application.home_page)
// application.version
// v%1
// <h2>License</h2>
// 
// <p>
// This program is free software: you can redistribute it and/or
// modify it under the terms of the GNU General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
// </p>
// 
// <p>
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
// </p>
// 
// <p>
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <a
// href="http://www.gnu.org/licenses">http://www.gnu.org/licenses</a>.
// <p>
}
