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
#import "Login.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSStatusItem * statusItem;
@property (weak) IBOutlet NSMenu *statusMenu;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:22];
    self.statusItem.image = [NSImage imageNamed:@"logo"];
    self.statusItem.menu = self.statusMenu;
    NSMenuItem * item = [self.statusMenu itemAtIndex:0];
    item.state = [[Login login] state];
    
    [HotKey setup];
    [Layout setup];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (IBAction)quitAction:(id)sender
{
    [[NSApplication sharedApplication] terminate:self];
}

- (IBAction)startAtLogin:(NSMenuItem *)menuItem
{
    menuItem.state = !menuItem.state;
    [[Login login] startAtLogin:menuItem.state];
}

@end
