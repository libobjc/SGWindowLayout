//
//  HotKey.m
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import "SGWLHotKey.h"
#import "PTHotKey.h"
#import "PTHotKeyCenter.h"

@interface SGWLHotKey ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, void (^)()> * handlers;

@end

@implementation SGWLHotKey

+ (instancetype)sharedInstance
{
    static SGWLHotKey * obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[SGWLHotKey alloc] init];
    });
    return obj;
}

+ (void)registerKeyCode:(SGWLKeyCode)keyCode modifiers:(SGWLModifiersKey)modifiers handler:(void (^)())handler
{
    [[SGWLHotKey sharedInstance] registerKeyCode:keyCode modifiers:modifiers handler:handler];
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.handlers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerKeyCode:(SGWLKeyCode)keyCode modifiers:(SGWLModifiersKey)modifiers handler:(void (^)())handler
{
    int intModifiers = controlKey;
    switch (modifiers)
    {
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
    [self registerFreeKeyCode:keyCode freeModifiers:intModifiers handler:handler];
}

- (void)registerFreeKeyCode:(int)keyCode freeModifiers:(int)modifiers handler:(void (^)())handler
{
    static int index = 0;
    NSString * name = [NSString stringWithFormat:@"%d", index++];
    
    PTKeyCombo * keyCombo = [PTKeyCombo keyComboWithKeyCode:keyCode modifiers:modifiers];
    
    PTHotKey * ptHotKey = [[PTHotKey alloc] init];
    [ptHotKey setName:name];
    [ptHotKey setKeyCombo:keyCombo];
    [ptHotKey setIsExclusive:YES];
    [ptHotKey setTarget:self];
    [ptHotKey setAction:@selector(globalHotKeyDidPress:)];
    
    [self.handlers setObject:handler forKey:name];
    
    [[PTHotKeyCenter sharedCenter] registerHotKey:ptHotKey];
}

- (void)globalHotKeyDidPress:(PTHotKey *)hotKey
{
    void (^handler)() = [self.handlers objectForKey:hotKey.name];
    if (handler)
    {
        handler();
    }
}

@end
