import 'package:favor_cometchat/enums/cometchat_call_enums.dart';
import 'package:favor_cometchat/favor_cometchat.dart';
import 'package:favor_cometchat/models/cometchat_call_model.dart';
import 'package:favor_cometchat_example/cometchat_constant.dart';
import 'package:flutter/material.dart';

class PlatformViewPage extends StatefulWidget {
  const PlatformViewPage({super.key});

  @override
  State<PlatformViewPage> createState() => _PlatformViewPageState();
}

class _PlatformViewPageState extends State<PlatformViewPage> {
  final _favorCometchatPlugin = FavorCometchat();
  Widget tempWidget = const Text("Widget is NUll");

  Future<void> initCometChatCalling() async {
    final model = CometchatCallModel(
      appID: CometchatConstant.appID,
      region: CometchatConstant.region,
      userUID: CometchatConstant.uid_10001,
    );

    model.userName = "Bitle";
    model.receiverUid = CometchatConstant.uid_10000;
    model.receiverName = "Niki";

    _favorCometchatPlugin.initCall(
      receiverUid: model.receiverUid!,
      receiverType: ReceiverType.user,
      callType: CallType.video,
    );
    tempWidget = await _favorCometchatPlugin.initView(callModel: model);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    initCometChatCalling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Expanded(child: tempWidget),
      ),
    );
  }
}
