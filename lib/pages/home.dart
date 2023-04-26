import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_chatgpt/router/router_key.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('demo'),
      ),
      body: Column(
        children: [
          MaterialButton(
            onPressed: () {
              context.push(RouterKey.chat);
            },
            child: const Text('chat'),
          ),
           MaterialButton(
            onPressed: () {
              context.push(RouterKey.demo);
            },
            child: const Text('demo'),
          )
        ],
      ),
    );
  }
}
