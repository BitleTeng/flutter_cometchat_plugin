enum CometchatCallMode {
  defaults("DEFAULT"),
  single("SINGLE"),
  spotlight("SPOTLIGHT");

  final String value;
  const CometchatCallMode(this.value);
}

class CometchatCallModel {
  CometchatCallModel({
    this.sessionId,
    required this.appID,
    required this.region,
    required this.userUID,
    this.receiverName,
    this.receiverUid,
    this.userName,
    this.userAvatar,
    this.defaultLayout,
    this.isInitiator,
    this.isAudioOnly,
    this.audioMuted,
    this.videoMuted,
    this.mode = CometchatCallMode.defaults,
    this.analyticsSettingsHost,
    this.analyticsSettingsVersion,
    this.endCallButtonDisable = false,
    this.pauseVideoButtonDisable = false,
    this.audioModeButtonDisable = false,
    this.switchCameraButtonDisable = false,
    this.muteAudioButtonDisable = false,
    this.showSwitchToVideoCall = false,
  });

  String? sessionId;
  String appID;
  String? region;
  CometchatCallMode mode;
  String? analyticsSettingsHost;
  String? analyticsSettingsVersion;
  String? receiverUid;
  String? receiverName;
  bool? isAudioOnly;
  bool? endCallButtonDisable;
  bool? pauseVideoButtonDisable;
  bool? audioModeButtonDisable;
  bool? switchCameraButtonDisable;
  bool? defaultLayout;
  bool? isInitiator;
  bool? audioMuted;
  bool? videoMuted;
  bool? muteAudioButtonDisable;
  bool? showSwitchToVideoCall;
  String? userAvatar;
  String? userName;
  String? userUID;
}
