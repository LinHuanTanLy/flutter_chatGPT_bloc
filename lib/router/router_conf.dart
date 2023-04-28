import 'package:flutter_chatgpt/pages/chat/chat.dart';
import 'package:flutter_chatgpt/pages/demo/demo_page.dart';
import 'package:flutter_chatgpt/pages/home.dart';
import 'package:go_router/go_router.dart';

import 'router_key.dart';

class RouterConf {
  static final RouterConf _singleton = RouterConf._internal();
  GoRouter? _routerConf;

  factory RouterConf() {
    return _singleton;
  }

  RouterConf._internal() {
    _routerConf = GoRouter(
      routes: [
        GoRoute(
            path: RouterKey.home,
            builder: (context, state) => const HomePage()),
        GoRoute(
            path: RouterKey.chat, builder: (context, state) => const ChatPage()),
        GoRoute(
            path: RouterKey.demoPage,
            builder: (context, state) => const DemoPage()),
      ],
    );
  }

  GoRouter? get router {
    return _routerConf;
  }
}
