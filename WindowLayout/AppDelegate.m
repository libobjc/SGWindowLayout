//
//  AppDelegate.m
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import "AppDelegate.h"
#import "HotKey.h"
#import "Layout.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [HotKey setup];
    [Layout setup];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    
}

@end
