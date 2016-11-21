//
//  HotKey.m
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import "HotKey.h"
#import "PTHotKey.h"
#import "PTHotKeyCenter.h"
#import "Layout.h"

@implementation HotKey

+ (void)setup
{
    PTKeyCombo* keyComboA = [PTKeyCombo keyComboWithKeyCode:0 modifiers:controlKey];
    PTKeyCombo* keyComboS = [PTKeyCombo keyComboWithKeyCode:1 modifiers:controlKey];
    PTKeyCombo* keyComboD = [PTKeyCombo keyComboWithKeyCode:2 modifiers:controlKey];
    PTKeyCombo* keyComboW = [PTKeyCombo keyComboWithKeyCode:13 modifiers:controlKey];
    PTKeyCombo* keyComboX = [PTKeyCombo keyComboWithKeyCode:7 modifiers:controlKey];
    
    PTHotKey* ptHotKeyA = [[PTHotKey alloc] init];
    [ptHotKeyA setName:@"A"];
    [ptHotKeyA setKeyCombo:keyComboA];
    [ptHotKeyA setIsExclusive:YES];
    [ptHotKeyA setTarget:self];
    [ptHotKeyA setAction:@selector(globalHotKeyDidPress:)];
    
    PTHotKey* ptHotKeyS = [[PTHotKey alloc] init];
    [ptHotKeyS setName:@"S"];
    [ptHotKeyS setKeyCombo:keyComboS];
    [ptHotKeyS setIsExclusive:YES];
    [ptHotKeyS setTarget:self];
    [ptHotKeyS setAction:@selector(globalHotKeyDidPress:)];
    
    PTHotKey* ptHotKeyD = [[PTHotKey alloc] init];
    [ptHotKeyD setName:@"D"];
    [ptHotKeyD setKeyCombo:keyComboD];
    [ptHotKeyD setIsExclusive:YES];
    [ptHotKeyD setTarget:self];
    [ptHotKeyD setAction:@selector(globalHotKeyDidPress:)];
    
    PTHotKey* ptHotKeyW = [[PTHotKey alloc] init];
    [ptHotKeyW setName:@"W"];
    [ptHotKeyW setKeyCombo:keyComboW];
    [ptHotKeyW setIsExclusive:YES];
    [ptHotKeyW setTarget:self];
    [ptHotKeyW setAction:@selector(globalHotKeyDidPress:)];
    
    PTHotKey* ptHotKeyX = [[PTHotKey alloc] init];
    [ptHotKeyX setName:@"X"];
    [ptHotKeyX setKeyCombo:keyComboX];
    [ptHotKeyX setIsExclusive:YES];
    [ptHotKeyX setTarget:self];
    [ptHotKeyX setAction:@selector(globalHotKeyDidPress:)];
    
    [[PTHotKeyCenter sharedCenter] registerHotKey:ptHotKeyA];
    [[PTHotKeyCenter sharedCenter] registerHotKey:ptHotKeyS];
    [[PTHotKeyCenter sharedCenter] registerHotKey:ptHotKeyD];
    [[PTHotKeyCenter sharedCenter] registerHotKey:ptHotKeyW];
    [[PTHotKeyCenter sharedCenter] registerHotKey:ptHotKeyX];
}

+ (void)globalHotKeyDidPress:(PTHotKey *)hotKey
{
    LayoutAttribute attribute;
    if ([hotKey.name isEqualToString:@"A"]) {
        attribute = LayoutAttributeLeft;
    } else if ([hotKey.name isEqualToString:@"S"]) {
        attribute = LayoutAttributeFull;
    } else if ([hotKey.name isEqualToString:@"D"]) {
        attribute = LayoutAttributeRight;
    } else if ([hotKey.name isEqualToString:@"W"]) {
        attribute = LayoutAttributeTop;
    } else if ([hotKey.name isEqualToString:@"X"]) {
        attribute = LayoutAttributeBottom;
    }
    [Layout layoutWindowWithAttribute:attribute frame:[self frame]];
}

+ (NSRect)frame
{
    return [NSScreen mainScreen].visibleFrame;
}

@end
