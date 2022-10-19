#import "FavorCometchatPlugin.h"
#if __has_include(<favor_cometchat/favor_cometchat-Swift.h>)
#import <favor_cometchat/favor_cometchat-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "favor_cometchat-Swift.h"
#endif

@implementation FavorCometchatPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFavorCometchatPlugin registerWithRegistrar:registrar];
}
@end
