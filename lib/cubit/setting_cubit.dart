import 'package:flutter_chatgpt/conf/conf.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> with HydratedMixin {
  SettingCubit() : super(const SettingState(Config.key, Config.baseUrl, true)) {
    hydrate();
  }

  @override
  SettingState? fromJson(Map<String, dynamic> json) {
    String apiKey = json['api_key'] as String;
    String baseUrl = json['base_url'] as String;
    bool ifStream = json['if_stream'] as bool;
    return SettingState(apiKey, baseUrl, ifStream);
  }

  @override
  Map<String, dynamic>? toJson(SettingState state) {
    return {
      "api_key": state.key,
      "base_url": state.baseUrl,
      "if_stream": state.ifStream
    };
  }
}
