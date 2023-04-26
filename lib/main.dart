import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatgpt/bloc/conversation/conversation_bloc.dart';
import 'package:flutter_chatgpt/cubit/setting_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get_it/get_it.dart';
import 'app_bloc_observer.dart';
import 'bloc/message/message_bloc.dart';
import 'router/router_conf.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // 将状态栏背景色设置为透明色
  ));
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  GetIt.instance.registerSingleton<SettingCubit>(SettingCubit());
  Bloc.observer = const AppBlocObserver();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (c) => GetIt.instance.get<SettingCubit>()),
        BlocProvider(create: (c) => MessageBloc()),
        BlocProvider(create: (c) => ConversationBloc()),
      ],
      child:
          BlocBuilder<SettingCubit, SettingState>(builder: ((context, state) {
        final RouterConf routerConf = RouterConf();

        return MaterialApp.router(
          routeInformationParser: routerConf.router?.routeInformationParser,
          routerDelegate: routerConf.router?.routerDelegate,
          routeInformationProvider: routerConf.router?.routeInformationProvider,
        );
      }))));
}
