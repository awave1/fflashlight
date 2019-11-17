#import "FflashlightPlugin.h"
#import <fflashlight/fflashlight-Swift.h>

@implementation FflashlightPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFflashlightPlugin registerWithRegistrar:registrar];
}
@end
