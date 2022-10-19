//
//  CometChatCallingView.swift
//  favor_cometchat
//
//  Created by Bitle on 2022/10/5.
//
import Flutter
import UIKit
import CometChatPro
//,RTCEventDelegate
public class CometChatCallingView:NSObject,FlutterPlatformView{
    static  public var  rtcPlatformView = UIView()
    private var rtcView:CometChatRTCView
    
    @objc init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.yellow
        
        let rtcViewBuilder  = CometChatRTCViewBuilder()
        rtcViewBuilder.defaultLayout = true
        rtcViewBuilder.isInitiator = true
        rtcViewBuilder.isAudioOnly = true
        rtcViewBuilder.showRecordingButton = true
        rtcViewBuilder.audioModeButtonDisable = false
        rtcViewBuilder.mode = "SPOTLIGHT"
        rtcViewBuilder.isSingleMode = false
        rtcViewBuilder.isConference = true
        rtcViewBuilder.rtcReveiver = [
            "uid":"superhero1",
            "name":"Iron Man",
            "avatar": "https://data-us.cometchat.io/assets/images/avatars/ironman.png"
        ]
        rtcViewBuilder.appID="2191805862a34f2d"
        rtcViewBuilder.domain="rtc-us.cometchat.io"
        rtcViewBuilder.region = "us"
        rtcViewBuilder.rtcUser = [
            "uid":"10001",
            "name":"Bitle",
            "avatar": "https://data-us.cometchat.io/assets/images/avatars/ironman.png"
        ]
        
        rtcViewBuilder.rtcInitiator = [
            "uid":"10001",
            "name":"Bitle",
            "avatar": "https://data-us.cometchat.io/assets/images/avatars/ironman.png"
        ]
        
        rtcViewBuilder.analyticsSettings = [
            "ANALYTICS_HOST" : "metrics-us.cometchat.io",
            "ANALYTICS_PING_DISABLED" : 0,
            "ANALYTICS_USE_SSL" : 1,
            "ANALYTICS_VERSION" :"v3"
        ]
        
        rtcViewBuilder.view = uiView
        rtcView = CometChatRTCView(builder: rtcViewBuilder)
        
        CometChatCallingView.rtcPlatformView = rtcViewBuilder.view!
        rtcView.startSession()
//        rtcView.startRecording()
        super.init()
//        rtcView.delegate = self
    }
    
//    public func onCallEndedFromRTC() {
//        print("=======onCallEndedFromRTC")
//    }
//
//    public func onCallEndButtonPressedFromRTC() {
//        print("=========onCallEndButtonPressedFromRTC")
//    }
    
    public func view() -> UIView {
        return CometChatCallingView.rtcPlatformView
    }
}


