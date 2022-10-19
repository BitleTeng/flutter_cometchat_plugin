// import 'package:flutter_test/flutter_test.dart';
// import 'package:favor_cometchat/favor_cometchat.dart';
// import 'package:favor_cometchat/favor_cometchat_platform_interface.dart';
// import 'package:favor_cometchat/favor_cometchat_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockFavorCometchatPlatform
//     with MockPlatformInterfaceMixin
//     implements FavorCometchatPlatform {
//   @override
//   Future<String?> init() => Future.value('42');
// }

// void main() {
//   final FavorCometchatPlatform initialPlatform =
//       FavorCometchatPlatform.instance;

//   test('$MethodChannelFavorCometchat is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelFavorCometchat>());
//   });

//   test('getPlatformVersion', () async {
//     FavorCometchat favorCometchatPlugin = FavorCometchat();
//     MockFavorCometchatPlatform fakePlatform = MockFavorCometchatPlatform();
//     FavorCometchatPlatform.instance = fakePlatform;

//     expect(await favorCometchatPlugin.getPlatformVersion(), '42');
//   });
// }
