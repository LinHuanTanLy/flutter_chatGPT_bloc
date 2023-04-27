import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'router/router_conf.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // 将状态栏背景色设置为透明色
  ));
  WidgetsFlutterBinding.ensureInitialized();
  final RouterConf routerConf = RouterConf();
  runApp(ProviderScope(
      child: MaterialApp.router(
    routeInformationParser: routerConf.router?.routeInformationParser,
    routerDelegate: routerConf.router?.routerDelegate,
    routeInformationProvider: routerConf.router?.routeInformationProvider,
  )));
}
