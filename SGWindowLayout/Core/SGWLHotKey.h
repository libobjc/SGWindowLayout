//
//  HotKey.h
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SGWLKeyCode)
{
    SGWLKeyCodeA = 0,
    SGWLKeyCodeS = 1,
    SGWLKeyCodeD = 2,
    SGWLKeyCodeW = 13,
    SGWLKeyCodeX = 7,
    SGWLKeyCodeQ = 12,
    SGWLKeyCodeE = 14,
    SGWLKeyCodeZ = 6,
    SGWLKeyCodeC = 8,
};

typedef NS_ENUM(NSInteger, SGWLModifiersKey)
{
    SGWLModifiersKeyControl,
    SGWLModifiersKeyOption,
    SGWLModifiersKeyCommand,
    SGWLModifiersKeyShift,
};

@interface SGWLHotKey : NSObject

+ (void)registerKeyCode:(SGWLKeyCode)keyCode modifiers:(SGWLModifiersKey)modifiers handler:(void (^)())handler;

@end
