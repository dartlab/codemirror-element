// Copyright (c) 2015, DartLab.org. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';

import 'package:codemirror/codemirror.dart' as cm;

@CustomTag('code-mirror')
class CodeMirror extends PolymerElement {
  @published String value;

  @published bool autoCloseTags;
  @published bool indentWithTabs;
  @published bool lineNumbers;
  @published String mode;
  @published String theme;

  cm.CodeMirror editor;
  cm.Doc doc;

  /// Constructor used to create instance of MainApp.
  CodeMirror.created() : super.created() {
  }

  /// Called when an instance of main-app is inserted into the DOM.
  attached() {
    super.attached();
    if (editor == null) {
      Map options = {
        'mode': mode,
        'theme': theme,
        'lineNumbers': lineNumbers,
        'autoCloseTags': autoCloseTags,
      };

      var textContainer = shadowRoot.querySelector('textarea');
      editor = new cm.CodeMirror.fromTextArea(textContainer, options: options);
      doc = editor.getDoc();
      doc.setValue(value);
      doc.onChange.listen((data) => value = doc.getValue());
    }
  }

  valueChanged(_, String value) {
    if (doc != null && doc.getValue() != value) {
      doc.setValue(value);
    }
  }

  autoCloseTagsChanged(_, bool value) => editor.setOption('autoCloseTags', value);
  indentWithTabsChanged(_, bool value) => editor.setOption('indentWithTabs', value);
  lineNumbersChanged(_, bool value) => editor.setOption('lineNumbers', value);
  modeChanged(_, String value) => editor.setOption('mode', value);
  themeChanged(_, String value) => editor.setOption('theme', value);

  focus() => editor.focus();
}
