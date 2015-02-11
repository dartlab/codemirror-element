// Copyright (c) 2015, DartLab.org. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library codemirror_element.codemirror_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:polymer/polymer.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart' show useHtmlConfiguration;
import 'package:codemirror_element/codemirror.dart';
import 'package:smoke/smoke.dart' as smoke;

class MyModel extends Object with Observable {
  @observable String value;
  @observable bool autoCloseTags;
  @observable bool indentWithTabs;
  @observable bool lineNumbers;
  @observable String mode;
  @observable String theme;

  MyModel();
  MyModel.filled()
      : value = "Some content",
        mode = "dart",
        theme = "monokai",
        lineNumbers = true,
        indentWithTabs = true,
        autoCloseTags = true;
}

void main() {
  useHtmlConfiguration();

  initPolymer().run(() {
    return Polymer.onReady.then((_) {
      group('core-mirror', () {
        test('default values', () {
          var editor = querySelector('#default') as CodeMirror;
          expect(editor.editor, isNotNull);
          expect(editor.value, isEmpty);
          expect(editor.autoCloseTags, isFalse);
          expect(editor.indentWithTabs, isFalse);
          expect(editor.lineNumbers, isFalse);
          expect(editor.mode, isEmpty);
          expect(editor.theme, isEmpty);
        });

        var attributesTest = {
          "value": "Some content",
          "mode": "dart",
          "theme": "monokai",
          "lineNumbers": true,
          "indentWithTabs": true,
          "autoCloseTags": true,
        };

        attributesTest.forEach((attribute, value) {
          test('$attribute="$value"', () {
            var editor = querySelector('#$attribute') as CodeMirror;
            expect(smoke.read(editor, new Symbol(attribute)), equals(value));
          });
        });

        test('bind all attributes with null values', () {
          var template = querySelector('#bind-value-template') as AutoBindingElement;
          var model = template.model = new MyModel();

          return flushLayoutAndRender().then((_) {
            CodeMirror editor = querySelector('#bind-value-editor') as CodeMirror;

            expect(editor.value, isEmpty);
            expect(editor.autoCloseTags, isFalse);
            expect(editor.indentWithTabs, isFalse);
            expect(editor.lineNumbers, isFalse);
            expect(editor.mode, isEmpty);
            expect(editor.theme, isEmpty);
          });
        });

        test('bind all attributes with not null values', () {
          var template = querySelector('#bind-value-template') as AutoBindingElement;
          var model = template.model = new MyModel.filled();

          return flushLayoutAndRender().then((_) {
            CodeMirror editor = querySelector('#bind-value-editor') as CodeMirror;

            expect(editor.value, "Some content");
            expect(editor.mode, "dart");
            expect(editor.theme, "monokai");
            expect(editor.autoCloseTags, isTrue);
            expect(editor.indentWithTabs, isTrue);
            expect(editor.lineNumbers, isTrue);
          });
        });

        test('bind value', () {
          const initialValue = "Initial value";
          const inputValue = "Input value";
          const codeMirrorInputValue = "Code Mirror input value";
          const modelValue = 'Model value';

          var template = querySelector('#bind-value-template') as AutoBindingElement;
          var model = template.model = new MyModel()..value = initialValue;
          CodeMirror editor;

          expectAllEqualTo(value) {
            expect(model.value, equals(value));
            expect(editor.value, equals(value));
            expect(editor.editor.getDoc().getValue(), equals(value));
          }

          return flushLayoutAndRender().then((_) {
            editor = querySelector('#bind-value-editor') as CodeMirror;

            expectAllEqualTo(initialValue);

            editor.value = inputValue;
            return flushLayoutAndRender();
          }).then((_) {
            expectAllEqualTo(inputValue);

            editor.editor.getDoc().setValue(codeMirrorInputValue);
            return flushLayoutAndRender();
          }).then((_) {
            expectAllEqualTo(codeMirrorInputValue);

            model.value = modelValue;
            return flushLayoutAndRender();
          }).then((_) {
            expectAllEqualTo(modelValue);
          });
        });
      });
    });
  });
}

Future flushLayoutAndRender() {
  context['Polymer'].callMethod('flush', []);
  document.body.offsetTop;
  return new Future(() {});
}
