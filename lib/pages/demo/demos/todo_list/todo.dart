import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String desc;
  final bool completed;

  Todo(this.id, this.desc, this.completed);
}

class TodoList extends StateNotifier<List<Todo>> {
  TodoList(super.state);

  void add(String desc) {
    state = [...state, Todo(const Uuid().v4(), desc, false)];
  }

  void toggle(String id) {
    state = [
      for (Todo todo in state)
        if (todo.id == id) Todo(todo.id, todo.desc, !todo.completed) else todo
    ];
  }

  void edit(String id, String desc) {
    state = [
      for (Todo todo in state)
        if (todo.id == id) Todo(todo.id, desc, todo.completed) else todo
    ];
  }

  void remove(String id) {
    state = state.where((element) => element.id != id).toList();
  }
}
