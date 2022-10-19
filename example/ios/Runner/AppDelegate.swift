import UIKit
import Flutter
//import CometChatPro

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
//    var flutterViewController: FlutterViewController?
//    var window: UIWindow?
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
//        CometChat.calldelegate = self
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
