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

+ (void)registerLayoutAttribute:(SGWLLayoutAttribute)layoutAttribute keyCode:(SGWLKeyCode)keyCode modifiers:(SGWLModifiersKey)modifiers
{
    int intModifiers = controlKey;
    switch (modifiers) {
        case SGWLModifiersKeyControl:
            intModifiers = controlKey;
            break;
        case SGWLModifiersKeyOption:
            intModifiers = optionKey;
            break;
        case SGWLModifiersKeyCommand:
            intModifiers = cmdKey;
            break;
        case SGWLModifiersKeyShift:
            intModifiers = shiftKey;
            break;
    }
    
    [self registerLayoutAttribute:layoutAttribute
                      freeKeyCode:keyCode
                    freeModifiers:intModifiers];
}

+ (void)registerLayoutAttribute:(SGWLLayoutAttribute)layoutAttribute
                    freeKeyCode:(int)keyCode
                  freeModifiers:(int)modifiers
{
    [SGWLLayout setup];
    
    NSString * keyName = [NSString stringWithFormat:@"%ld", layoutAttribute];
    
    PTKeyCombo * keyCombo = [PTKeyCombo keyComboWithKeyCode:keyCode modifiers:modifiers];
    
    PTHotKey* ptHotKey = [[PTHotKey alloc] init];
    [ptHotKey setName:keyName];
    [ptHotKey setKeyCombo:keyCombo];
    [ptHotKey setIsExclusive:YES];
    [ptHotKey setTarget:self];
    [ptHotKey setAction:@selector(globalHotKeyDidPress:)];
    
    [[PTHotKeyCenter sharedCenter] registerHotKey:ptHotKey];
}

+ (void)globalHotKeyDidPress:(PTHotKey *)hotKey
{
    SGWLLayoutAttribute layoutAttribute = [hotKey.name integerValue];
    [SGWLLayout layoutCurrentFocusedWindowWithLayoutAttribute:layoutAttribute];
}

@end
