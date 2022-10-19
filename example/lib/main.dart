import 'package:favor_cometchat_example/cometchat_constant.dart';
import 'package:favor_cometchat_example/platform_view_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:favor_cometchat/favor_cometchat.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _favorCometchatPlugin = FavorCometchat();

  Future<void> init() async {
    await [
      Permission.notification,
      Permission.microphone,
      Permission.camera,
    ].request();

    await _favorCometchatPlugin.init(
      appID: CometchatConstant.appID,
      region: CometchatConstant.region,
    );

    await _favorCometchatPlugin.login(
      authKey: CometchatConstant.authKey,
      uid: CometchatConstant.uid_10001,
    );
  }

  Future<void> next() async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PlatformViewPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Builder(builder: (context) {
            return TextButton(
              onPressed: next,
              child: const Text('Next Page'),
            );
          }),
        ),
      ),
    );
  }
}
