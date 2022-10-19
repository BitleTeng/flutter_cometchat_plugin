import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'favor_cometchat_platform_interface.dart';

class FavorCometchatWeb extends FavorCometchatPlatform {
  FavorCometchatWeb();

  @visibleForTesting
  final methodChannel = const MethodChannel('favor_cometchat');

  static void registerWith(Registrar registrar) {
    FavorCometchatPlatform.instance = FavorCometchatWeb();
    // final MethodChannel channel =
    //     MethodChannel("web_plugin", const StandardMethodCodec(), registrar,);
  }

  @override
  Future<bool> init({
    required String appID,
    required String region,
  }) async {
    final result = await methodChannel.invokeMethod<bool>('init', {
      "appID": appID,
      "region": region,
    });
    return result ?? false;
  }

  @override
  Future<bool> login({
    required String uid,
    required String authKey,
  }) async {
    final result = await methodChannel.invokeMethod<bool>('login', {
      "uid": uid,
      "authKey": authKey,
    });
    return result ?? false;
  }
}
