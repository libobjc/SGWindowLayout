//
//  HotKey.m
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import "SGWLHotKey.h"
#import "SGWLLayout.h"
#import "PTHotKey.h"
#import "PTHotKeyCenter.h"

@implementation SGWLHotKey

+ (void)setup
{
    [self registerName:@"A" keyCode:0 modifiers:controlKey];
    [self registerName:@"S" keyCode:1 modifiers:controlKey];
    [self registerName:@"D" keyCode:2 modifiers:controlKey];
    [self registerName:@"W" keyCode:13 modifiers:controlKey];
    [self registerName:@"X" keyCode:7 modifiers:controlKey];
//    [self registerName:@"Q" keyCode:12 modifiers:controlKey];
//    [self registerName:@"E" keyCode:14 modifiers:controlKey];
//    [self registerName:@"Z" keyCode:6 modifiers:controlKey];
//    [self registerName:@"C" keyCode:8 modifiers:controlKey];
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
    SGWLLayoutAttribute attribute;
    if ([hotKey.name isEqualToString:@"A"]) {
        attribute = SGWLLayoutAttributeLeft;
    } else if ([hotKey.name isEqualToString:@"S"]) {
        attribute = SGWLLayoutAttributeFull;
    } else if ([hotKey.name isEqualToString:@"D"]) {
        attribute = SGWLLayoutAttributeRight;
    } else if ([hotKey.name isEqualToString:@"W"]) {
        attribute = SGWLLayoutAttributeTop;
    } else if ([hotKey.name isEqualToString:@"X"]) {
        attribute = SGWLLayoutAttributeBottom;
    } else if ([hotKey.name isEqualToString:@"Q"]) {
        attribute = SGWLLayoutAttributeLeftTop;
    } else if ([hotKey.name isEqualToString:@"E"]) {
        attribute = SGWLLayoutAttributeRightTop;
    } else if ([hotKey.name isEqualToString:@"Z"]) {
        attribute = SGWLLayoutAttributeLeftBottom;
    } else if ([hotKey.name isEqualToString:@"C"]) {
        attribute = SGWLLayoutAttributeRightBottom;
    }
    [SGWLLayout layoutWindowWithAttribute:attribute screenFrame:[self screenFrame]];
}

+ (NSRect)screenFrame
{
    NSScreen * baseScreen = [NSScreen screens].firstObject;
    NSRect baseFrame = baseScreen.frame;
    
    NSScreen * mainScreen = [NSScreen mainScreen];
    NSRect mainFrame = mainScreen.frame;
    NSRect mainVisibleFrame = mainScreen.visibleFrame;
    
    NSRect rect = NSMakeRect(mainVisibleFrame.origin.x,
                             baseFrame.size.height - mainFrame.size.height - mainFrame.origin.y,
                             mainVisibleFrame.size.width, mainVisibleFrame.size.height);
    
    return rect;
}

@end
