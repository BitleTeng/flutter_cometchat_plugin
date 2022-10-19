import Flutter
import UIKit
import CometChatPro

public class SwiftFavorCometchatPlugin: NSObject, FlutterPlugin{
    var registrar: FlutterPluginRegistrar
    let viewId = "favor_cometchat_calling_view"
    let cometChatUtil = CometChatUtil()
    
    init(with registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
        super.init()
        //            let appDelegate = UIApplication.shared.delegate
        //            CometChat.calldelegate = appDelegate as? any CometChatCallDelegate
        
        DispatchQueue.main.async {
            let cometChatUI = CometChatUI()
            cometChatUI.setup(withStyle: .fullScreen)
            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                //                navigationController.pushViewController(cometChatUI, animated: true)
                //                self.present(cometChatUI, animated: true, completion: nil)
                navigationController.present(cometChatUI, animated: true, completion: nil)
            }
        }
        CometChat.calldelegate = self
        self.registrar.register(CometChatCallingViewFactory(messenger:  registrar.messenger()), withId:  viewId)
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "favor_cometchat", binaryMessenger: registrar.messenger())
        let instance = SwiftFavorCometchatPlugin(with: registrar)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "init":
            let arguments = call.arguments  as! Dictionary<String, Any>
            let appID = arguments["appID"] as! String
            let region = arguments["region"] as! String
            let mySettings = AppSettings.AppSettingsBuilder()
                .subscribePresenceForAllUsers()
                .setRegion(region: region)
                .autoEstablishSocketConnection(true)
                .build()
            
            CometChat.init(appId: appID ,appSettings: mySettings,onSuccess: { (isSuccess) in
                if (isSuccess) {
                    print("CometChat Pro SDK intialise successfully.")
                    result(true)
                }
            }) { (error) in
                result(false)
                print("CometChat Pro SDK failed intialise with error: \(error.errorDescription)")
            }
        case "login":
            let arguments = call.arguments  as! Dictionary<String, Any>
            let uid = arguments["uid"] as! String
            let apiKey = arguments["authKey"] as! String
            
            if CometChat.getLoggedInUser() == nil {
                CometChat.login(UID: uid, apiKey: apiKey, onSuccess: { (user) in
                    print("Login successful : " + user.stringValue())
                    result(true)
                }) { (error) in
                    print("Login failed with error: " + error.errorDescription);
                    result(false)
                }
            }
        case "logout":
            print("logout...")
            result(true)
        case "startCall":
            print("startCall...")
            result(true)
        case "endCall":
            print("endCall...")
            result(true)
        case "initCall":
            let receiverID = "superhero1"
            let receiverType:CometChat.ReceiverType = .user
            let callType: CometChat.CallType = .video
            
            let newCall = Call(receiverId: receiverID, callType: callType, receiverType: receiverType);
            CometChat.initiateCall(call: newCall, onSuccess: { (ongoing_call) in
                
                print("Call initiated successfully " + ongoing_call!.stringValue());
                result(ongoing_call?.sessionID)
            }) { (error) in
                result(nil)
                print("Call initialization failed with error:  " + error!.errorDescription);
            }
        case "initView":
//            self.registrar.register(CometChatCallingViewFactory(messenger:  registrar.messenger()), withId:  viewId)
            result(true)
        default:
            result("iOS " + UIDevice.current.systemVersion)
            print("default...")
        }
    }
}

@available(iOS 11, *)
extension SwiftFavorCometchatPlugin : CometChatCallDelegate {
    public func onIncomingCallReceived(incomingCall: Call?, error: CometChatException?) {
        print(#function)
        if let currentCall = incomingCall {
            DispatchQueue.main.async {
                let call = CometChatIncomingCall()
                call.modalPresentationStyle = .custom
                call.setCall(call: currentCall)
                
                if let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController {
                        currentController = presentedController
                    }
                    currentController.present(call, animated: true, completion: nil)
                }
                
                if let call = incomingCall {
                    CometChatCallManager.incomingCallDelegate?.onIncomingCallReceived(incomingCall: call, error: error)
                }
            }
        }
    }
    
    public func onOutgoingCallAccepted(acceptedCall: Call?, error: CometChatException?) {
        print(#function)
        //        if let call = acceptedCall {
        //            CometChatCallManager.outgoingCallDelegate?.onOutgoingCallAccepted(acceptedCall: call, error: error)
        //        }
        print("Outgoing call " + (acceptedCall?.stringValue() ?? ""));
        let uiView = CometChatCallingView.rtcPlatformView
        
        let sessionID = acceptedCall!.sessionID
        print("sessionID =======\(sessionID!)"  );
        let callSettings = CallSettings.CallSettingsBuilder(callView: uiView, sessionId:sessionID!).build()
        
        CometChat.startCall(callSettings: callSettings, onUserJoined: { (user) in
            print("userJoined \(user!)")
        }, onUserLeft: { (user) in
            print("userLeft \(user!)")
        }, onUserListUpdated: { (userList) in
            print("userList \(userList!)")
        }, onAudioModesUpdated: { (audioList) in
            print("audioList \(audioList!)")
        }, onUserMuted: {onUserMuted in
            print("onUserMuted \(onUserMuted!)")
        }, onCallSwitchedToVideo: {callSwitchVideo in
            print("callSwitchVideo \(callSwitchVideo!)")
        }, onRecordingStarted: {onRecordingStarted in
            print("onRecordingStarted \(onRecordingStarted!)")
        }, onRecordingStopped: {onRecordingStopped in
            print("onRecordingStopped \(onRecordingStopped!)")
        }, onError: { (error) in
            print("OnError \(error!.errorDescription)")
        }) { (call) in
            print("onCallended \(call!)")
        }
    }
    
    public func onOutgoingCallRejected(rejectedCall: Call?, error: CometChatException?) {
        print(#function)
        if let call = rejectedCall {
            CometChatCallManager.outgoingCallDelegate?.onOutgoingCallRejected(rejectedCall: call, error: error)
        }
    }
    
    public func onIncomingCallCancelled(canceledCall: Call?, error: CometChatException?) {
        print(#function)
        if let call = canceledCall {
            CometChatCallManager.incomingCallDelegate?.onIncomingCallCancelled(canceledCall: call, error: error)
        }
    }
}

