import 'package:mobx/mobx.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {

  _TodoStore(this.title, {this.done = false});

  final String title;

  @observable
  bool done;

  @action
  void toggleDone() => done = !done;
}