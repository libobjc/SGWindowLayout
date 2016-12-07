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
    [self registerName:@"A" keyCode:0 modifiers:controlKey];
    [self registerName:@"S" keyCode:1 modifiers:controlKey];
    [self registerName:@"D" keyCode:2 modifiers:controlKey];
    [self registerName:@"W" keyCode:13 modifiers:controlKey];
    [self registerName:@"X" keyCode:7 modifiers:controlKey];
    [self registerName:@"Q" keyCode:12 modifiers:controlKey];
    [self registerName:@"E" keyCode:14 modifiers:controlKey];
    [self registerName:@"Z" keyCode:6 modifiers:controlKey];
    [self registerName:@"C" keyCode:8 modifiers:controlKey];
}

+ (void)registerName:(NSString *)name keyCode:(int)keyCode modifiers:(int)modifiers
{
    PTKeyCombo* keyCombo = [PTKeyCombo keyComboWithKeyCode:keyCode modifiers:modifiers];
    
    PTHotKey* ptHotKey = [[PTHotKey alloc] init];
    [ptHotKey setName:name];
    [ptHotKey setKeyCombo:keyCombo];
    [ptHotKey setIsExclusive:YES];
    [ptHotKey setTarget:self];
    [ptHotKey setAction:@selector(globalHotKeyDidPress:)];
    
    [[PTHotKeyCenter sharedCenter] registerHotKey:ptHotKey];
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
    } else if ([hotKey.name isEqualToString:@"Q"]) {
        attribute = LayoutAttributeLeftTop;
    } else if ([hotKey.name isEqualToString:@"E"]) {
        attribute = LayoutAttributeRightTop;
    } else if ([hotKey.name isEqualToString:@"Z"]) {
        attribute = LayoutAttributeLeftBottom;
    } else if ([hotKey.name isEqualToString:@"C"]) {
        attribute = LayoutAttributeRightBottom;
    }
    [Layout layoutWindowWithAttribute:attribute frame:[self frame]];
}

+ (NSRect)frame
{
    return [NSScreen mainScreen].visibleFrame;
}

@end
