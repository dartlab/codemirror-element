// Copyright (c) 2015, DartLab.org. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';

import 'package:codemirror/codemirror.dart' as cm;

@CustomTag('code-mirror')
class CodeMirror extends PolymerElement {
  @published String value = '';

  @published bool autoCloseTags = false;
  @published bool indentWithTabs = false;
  @published bool lineNumbers = false;
  @published String mode = '';
  @published String theme = '';

  cm.CodeMirror editor;
  cm.Doc doc;

  /// Constructor used to create instance of CodeMirror.
  CodeMirror.created() : super.created();

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
      doc.setValue(ifNull(value, ''));
    }
  }

  autoCloseTagsChanged(_, bool value) => editor.setOption('autoCloseTags', ifNull(value, false));
  indentWithTabsChanged(_, bool value) => editor.setOption('indentWithTabs', ifNull(value, false));
  lineNumbersChanged(_, bool value) => editor.setOption('lineNumbers', ifNull(value, false));
  modeChanged(_, String value) => editor.setOption('mode', ifNull(value, ''));
  themeChanged(_, String value) => editor.setOption('theme', ifNull(value, ''));

  focus() => editor.focus();
  refresh() => editor.refresh();
}

ifNull(value, defaultValue) => value != null ? value : defaultValue;