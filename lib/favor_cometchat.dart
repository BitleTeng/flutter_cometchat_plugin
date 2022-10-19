import 'package:favor_cometchat/enums/cometchat_call_enums.dart';
import 'package:favor_cometchat/models/cometchat_call_model.dart';
import 'package:flutter/widgets.dart';
import 'favor_cometchat_platform_interface.dart';

class FavorCometchat {
  Future<bool> init({
    required String appID,
    required String region,
  }) {
    return FavorCometchatPlatform.instance.init(
      appID: appID,
      region: region,
    );
  }

  Future<bool> login({
    required String uid,
    required String authKey,
  }) {
    return FavorCometchatPlatform.instance.login(
      authKey: authKey,
      uid: uid,
    );
  }

  Future<bool> logout() {
    return FavorCometchatPlatform.instance.logout();
  }

  Future<String?> initCall({
    required String receiverUid,
    required ReceiverType receiverType,
    required CallType callType,
  }) async {
    final result = await FavorCometchatPlatform.instance.initCall(
      receiverUid: receiverUid,
      receiverType: receiverType,
      callType: callType,
    );

    return result;
  }

  Future<Widget> initView({required CometchatCallModel callModel}) {
    return FavorCometchatPlatform.instance.initView(callModel: callModel);
  }

  Future<bool> videoCall(
      {String? sessionId, required String receiverUid}) async {
    return await FavorCometchatPlatform.instance.videoCall(
      sessionId: sessionId,
      receiverUid: receiverUid,
    );
  }

  Future<bool> audioCall(
      {String? sessionId, required String receiverUid}) async {
    return await FavorCometchatPlatform.instance.audioCall(
      sessionId: sessionId,
      receiverUid: receiverUid,
    );
  }

  Future<bool> endCall(String sessionId) async {
    return await FavorCometchatPlatform.instance.endCall(sessionId);
  }
}
