export 'package:polymer/init.dart';
import 'package:polymer/polymer.dart';

@CustomTag('simple-example')
class SimpleExample extends PolymerElement {
  @observable String value = r"""main() {
  var who = 'World';
  print('Hello $who!');
}""";
  @observable bool show = true;

  @observable bool autoCloseTags = true;
  @observable bool indentWithTabs = false;
  @observable bool lineNumbers = true;
  @observable String mode = 'dart';
  @observable String theme = 'monokai';

  /// Constructor used to create instance of MainApp.
  SimpleExample.created() : super.created();
}