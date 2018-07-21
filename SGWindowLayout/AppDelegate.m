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
#import "SGWLCursor.h"
#import "SGWLLogin.h"

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
    item.state = [SGWLLogin login].startAtLogin;
    
    [self registerHotKey];
}

- (void)registerHotKey
{
    [SGWLHotKey registerKeyCode:SGWLKeyCodeQ modifiers:SGWLModifiersKeyControl handler:^{
        [SGWLLayout layoutCurrentFocusedWindowWithLayoutAttribute:SGWLLayoutAttributeLeft];
    }];
    [SGWLHotKey registerKeyCode:SGWLKeyCodeW modifiers:SGWLModifiersKeyControl handler:^{
        [SGWLLayout layoutCurrentFocusedWindowWithLayoutAttribute:SGWLLayoutAttributeFull];
    }];
    [SGWLHotKey registerKeyCode:SGWLKeyCodeE modifiers:SGWLModifiersKeyControl handler:^{
        [SGWLLayout layoutCurrentFocusedWindowWithLayoutAttribute:SGWLLayoutAttributeRight];
    }];
    [SGWLHotKey registerKeyCode:SGWLKeyCodeS modifiers:SGWLModifiersKeyControl handler:^{
        [SGWLLayout layoutCurrentFocusedWindowWithLayoutAttribute:SGWLLayoutAttributeSmaller];
    }];
    [SGWLHotKey registerKeyCode:SGWLKeyCodeX modifiers:SGWLModifiersKeyControl handler:^{
        NSScreen * screen = [SGWLLayout swapScreenIfNeeded];
        [SGWLCursor swapCursorToScreenIfNeeded:screen];
    }];
    [SGWLHotKey registerKeyCode:SGWLKeyCodeZ modifiers:SGWLModifiersKeyControl handler:^{
        [SGWLCursor swapCursorIfNeeded];
    }];
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
