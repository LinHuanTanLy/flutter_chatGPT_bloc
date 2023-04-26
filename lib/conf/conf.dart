import 'package:envied/envied.dart';
part 'conf.g.dart';
@Envied()
abstract class Config {
  @EnviedField(varName: "API_KEY")
  static const key = _Config.key;
  @EnviedField(varName: "BASE_URL")
  static const baseUrl = _Config.baseUrl;
}
