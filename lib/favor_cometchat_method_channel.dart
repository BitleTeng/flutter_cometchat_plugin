import 'package:favor_cometchat/enums/cometchat_call_enums.dart';
import 'package:favor_cometchat/models/cometchat_call_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'favor_cometchat_platform_interface.dart';

class MethodChannelFavorCometchat extends FavorCometchatPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('favor_cometchat');

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

  @override
  Future<bool> logout() async {
    final result = await methodChannel.invokeMethod<bool>('logout');
    return result ?? false;
  }

  @override
  Future<bool> audioCall({
    required String receiverUid,
    String? sessionId,
  }) async {
    final result = await methodChannel.invokeMethod<bool>('startCall', {
      "sessionId": sessionId,
      "callType": "audio",
      "receiverType": "user",
      "receiverUid": receiverUid,
    });
    return result ?? false;
  }

  @override
  Future<bool> videoCall({
    required String receiverUid,
    String? sessionId,
  }) async {
    final result = await methodChannel.invokeMethod<bool>('startCall', {
      "sessionId": sessionId,
      "callType": "video",
      "receiverType": "user",
      "receiverUid": receiverUid,
    });
    return result ?? false;
  }

  @override
  Future<bool> endCall(String sessionId) async {
    final result = await methodChannel.invokeMethod<bool>('endCall', {
      "sessionId": sessionId,
    });
    return result ?? false;
  }

  @override
  Future<String?> initCall({
    required String receiverUid,
    required ReceiverType receiverType,
    required CallType callType,
  }) async {
    final result = await methodChannel.invokeMethod<String?>('initCall', {
      "callType": callType.value,
      "receiverType": receiverType.value,
      "receiverUid": receiverUid,
    });

    return result;
  }

  @override
  Future<Widget> initView({required CometchatCallModel callModel}) async {
    Map<String, dynamic> creationParams = {
      "userUID": callModel.userUID,
      "userName": callModel.userName,
      "receiverUid": callModel.receiverUid,
      "receiverName": callModel.receiverName,
      "mode": callModel.mode.value,
      "appID": callModel.appID,
      "region": callModel.region,
      "defaultLayout": callModel.defaultLayout,
      "videoMuted": callModel.videoMuted,
      "audioMuted": callModel.audioMuted,
      "endCallButtonDisable": callModel.endCallButtonDisable,
      "audioModeButtonDisable": callModel.audioModeButtonDisable,
      "pauseVideoButtonDisable": callModel.pauseVideoButtonDisable,
      "isInitiator": callModel.isInitiator,
      "isAudioOnly": callModel.isAudioOnly,
    };

    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: "favor_cometchat_calling_view",
        onPlatformViewCreated: (int viewId) {},
        creationParamsCodec: const StandardMessageCodec(),
        creationParams: creationParams,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: "favor_cometchat_calling_view",
        onPlatformViewCreated: (int viewId) {},
        creationParamsCodec: const StandardMessageCodec(),
        creationParams: creationParams,
      );
    }

    return const SizedBox.shrink();
  }
}
