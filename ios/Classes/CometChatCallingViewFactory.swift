//
//  CometChatCallingViewFactory.swift
//  favor_cometchat
//
//  Created by Bitle on 2022/10/5.
//

import Flutter
import UIKit

public class CometChatCallingViewFactory:NSObject,FlutterPlatformViewFactory{
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        
        super.init()
    }
    
    public func create(withFrame frame: CGRect,
                       viewIdentifier viewId: Int64,
                       arguments args: Any?) -> FlutterPlatformView {
        return CometChatCallingView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger
        )
    }
}
