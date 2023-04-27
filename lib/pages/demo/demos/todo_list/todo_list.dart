import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/pages/demo/demos/todo_list/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum TodoListFilter {
  all,
  unCompleted,
  completed,
}
///拿到数据源的provider
var todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList([
    Todo('todo-0', 'hi', false),
    Todo('todo-1', 'hi1', true),
    Todo('todo-2', 'hi2', false),
    Todo('todo-3', 'hi3', true),
    Todo('todo-4', 'hi4', false),
  ]);
});

///筛选状态
final todoListFilter = StateProvider((ref) => TodoListFilter.all);
///过滤结果集
final filterTodolist = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todos;
    case TodoListFilter.completed:
      return todos.where((element) => element.completed).toList();

    case TodoListFilter.unCompleted:
      return todos.where((element) => !element.completed).toList();
  }
});

class TodoListPage extends ConsumerStatefulWidget {
  const TodoListPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPage> {
  ///状态
  ///0 all
  ///1 unCompleted
  ///2 completed
  updateTodoList(int status) {
    TodoListFilter newFilter;
    if (status == 0) {
      newFilter = TodoListFilter.all;
    } else if (status == 1) {
      newFilter = TodoListFilter.unCompleted;
    } else {
      newFilter = TodoListFilter.completed;
    }

    ref.read(todoListFilter.notifier).state = newFilter;
  }

   void _updateCurrentTodoListStatus(bool? value, Todo todo) {
      ref.read(todoListProvider.notifier).toggle(todo.id);

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('todo'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => updateTodoList(0),
                  child: Center(
                      child: Text(
                    'all',
                    style: TextStyle(
                        color: ref.watch(todoListFilter) == TodoListFilter.all
                            ? Colors.red
                            : Colors.black),
                  )),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => updateTodoList(2),
                  child: Center(
                      child: Text(
                    'completed',
                    style: TextStyle(
                        color: ref.watch(todoListFilter) ==
                                TodoListFilter.completed
                            ? Colors.red
                            : Colors.black),
                  )),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => updateTodoList(1),
                  child: Center(
                      child: Text(
                    'uncompleted',
                    style: TextStyle(
                        color: ref.watch(todoListFilter) ==
                                TodoListFilter.unCompleted
                            ? Colors.red
                            : Colors.black),
                  )),
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (c, i) {
              Todo todo = ref.watch(filterTodolist)[i];
              return SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Checkbox(value: todo.completed, onChanged: (value) {
                      _updateCurrentTodoListStatus(value,todo);
                    }),
                    Text(todo.desc)
                  ],
                ),
              );
            },
            itemCount: ref.watch(filterTodolist).length,
          ))
        ],
      ),
    );
  }
  
 
}
