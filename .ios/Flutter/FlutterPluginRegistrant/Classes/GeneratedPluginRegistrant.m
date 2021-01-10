//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_money_formatter/FlutterMoneyFormatterPlugin.h>)
#import <flutter_money_formatter/FlutterMoneyFormatterPlugin.h>
#else
@import flutter_money_formatter;
#endif

#if __has_include(<sqflite/SqflitePlugin.h>)
#import <sqflite/SqflitePlugin.h>
#else
@import sqflite;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterMoneyFormatterPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterMoneyFormatterPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
}

@end
