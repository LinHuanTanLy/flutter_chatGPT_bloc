import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppBlocObserver extends BlocObserver{
  const AppBlocObserver();
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}