// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:favor_cometchat/favor_cometchat_method_channel.dart';

// void main() {
//   MethodChannelFavorCometchat platform = MethodChannelFavorCometchat();
//   const MethodChannel channel = MethodChannel('favor_cometchat');

//   TestWidgetsFlutterBinding.ensureInitialized();

//   setUp(() {
//     channel.setMockMethodCallHandler((MethodCall methodCall) async {
//       return '42';
//     });
//   });

//   tearDown(() {
//     channel.setMockMethodCallHandler(null);
//   });

//   test('getPlatformVersion', () async {
//     expect(await platform.init(appID: '', region: ''), '42');
//   });
// }
