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

@property (nonatomic, strong) NSStatusItem * statusItem;
@property (weak) IBOutlet NSMenu *statusMenu;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:20];
    self.statusItem.button.target = self;
    self.statusItem.button.action = @selector(statusItemAction:);
    self.statusItem.button.image = [NSImage imageNamed:@"logo"];
    self.statusItem.menu = self.statusMenu;
    
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

- (void)statusItemAction:(NSStatusItem *)statusItem
{
    NSLog(@"status bar did click");
}

- (void)statusItemDoubleAction:(NSStatusItem *)statusItem
{
    NSLog(@"double click");
}

- (IBAction)quitAction:(id)sender
{
    [[NSApplication sharedApplication] terminate:self];
}

@end
