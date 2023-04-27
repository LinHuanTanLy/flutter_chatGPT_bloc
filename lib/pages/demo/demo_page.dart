import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/pages/demo/demos/counter/counter.dart';

import 'demos/todo_list/todo_list.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const CounterDemo();
    return  TodoListPage();
  }
}
