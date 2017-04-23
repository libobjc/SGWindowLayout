//
//  AppDelegate.m
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import "AppDelegate.h"
#import "SGWLHotKey.h"
#import "SGWLLayout.h"
#import "SGWLLogin.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSStatusItem * statusItem;
@property (weak) IBOutlet NSMenu *statusMenu;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // status item.
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:22];
    self.statusItem.image = [NSImage imageNamed:@"logo"];
    self.statusItem.menu = self.statusMenu;
    NSMenuItem * item = [self.statusMenu itemAtIndex:0];
    item.state = [SGWLLogin login].startAtLogin;
    
    // register hotkey.
    [self registerHotKey];
}

- (void)registerHotKey
{
    [SGWLHotKey registerLayoutAttribute:SGWLLayoutAttributeLeft
                                keyCode:SGWLKeyCodeA
                              modifiers:SGWLModifiersKeyControl];
    [SGWLHotKey registerLayoutAttribute:SGWLLayoutAttributeFull
                                keyCode:SGWLKeyCodeS
                              modifiers:SGWLModifiersKeyControl];
    [SGWLHotKey registerLayoutAttribute:SGWLLayoutAttributeRight
                                keyCode:SGWLKeyCodeD
                              modifiers:SGWLModifiersKeyControl];
    [SGWLHotKey registerLayoutAttribute:SGWLLayoutAttributeTop
                                keyCode:SGWLKeyCodeW
                              modifiers:SGWLModifiersKeyControl];
    [SGWLHotKey registerLayoutAttribute:SGWLLayoutAttributeBottom
                                keyCode:SGWLKeyCodeX
                              modifiers:SGWLModifiersKeyControl];
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
    [SGWLLogin login].startAtLogin = menuItem.state;
}

@end
