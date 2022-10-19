import 'package:favor_cometchat/enums/cometchat_call_enums.dart';
import 'package:favor_cometchat/models/cometchat_call_model.dart';
import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'favor_cometchat_method_channel.dart';

abstract class FavorCometchatPlatform extends PlatformInterface {
  FavorCometchatPlatform() : super(token: _token);

  static final Object _token = Object();
  static FavorCometchatPlatform _instance = MethodChannelFavorCometchat();

  static FavorCometchatPlatform get instance => _instance;

  static set instance(FavorCometchatPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> init({
    required String appID,
    required String region,
  }) {
    throw UnimplementedError('platform has not been implemented.');
  }

  Future<bool> login({
    required String uid,
    required String authKey,
  }) {
    throw UnimplementedError('platform has not been implemented.');
  }

  Future<bool> logout() {
    throw UnimplementedError('platform has not been implemented.');
  }

  Future<bool> audioCall({
    String? sessionId,
    required String receiverUid,
  }) {
    throw UnimplementedError('platform has not been implemented.');
  }

  Future<bool> videoCall({
    String? sessionId,
    required String receiverUid,
  }) {
    throw UnimplementedError('platform has not been implemented.');
  }

  Future<bool> endCall(String sessionId) {
    throw UnimplementedError('platform has not been implemented.');
  }

  Future<String?> initCall({
    required String receiverUid,
    required ReceiverType receiverType,
    required CallType callType,
  }) {
    throw UnimplementedError('platform has not been implemented.');
  }

  Future<Widget> initView({required CometchatCallModel callModel}) {
    throw UnimplementedError('platform has not been implemented.');
  }
}
