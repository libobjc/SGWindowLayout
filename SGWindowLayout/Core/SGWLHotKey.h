//
//  HotKey.h
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGWLLayout.h"

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

+ (void)registerLayoutAttribute:(SGWLLayoutAttribute)layoutAttribute
                        keyCode:(SGWLKeyCode)keyCode
                      modifiers:(SGWLModifiersKey)modifiers;

+ (void)registerLayoutAttribute:(SGWLLayoutAttribute)layoutAttribute
                    freeKeyCode:(int)keyCode
                  freeModifiers:(int)modifiers;

@end
