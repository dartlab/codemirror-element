// Copyright (c) 2015, DartLab.org. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

export 'package:polymer/init.dart';
import 'package:polymer/polymer.dart';

@CustomTag('simple-example')
class SimpleExample extends PolymerElement {
  @observable String value = r"""main() {
  var who = 'World';
  print('Hello $who!');
}""";

  @observable bool autoCloseTags = false;
  @observable bool indentWithTabs = false;
  @observable bool lineNumbers = true;
  @observable String mode = 'dart';
  @observable String theme = 'monokai';

  /// Constructor used to create instance of MainApp.
  SimpleExample.created() : super.created();

  resize() => document.querySelectorAll('html /deep/ code-mirror').forEach((node) => node.refresh());
}
