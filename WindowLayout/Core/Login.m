//
//  Login.m
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import "Login.h"

@interface Login ()

{
    LSSharedFileListItemRef _itemHandle;
    LSSharedFileListRef _sharedFileList;
}

@end

@implementation Login

+ (instancetype)login
{
    static Login * login = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        login = [[self alloc] init];
    });
    return login;
}

- (instancetype)init
{
    if (self = [super init]) {
        _sharedFileList = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    }
    return self;
}

- (void)startAtLogin:(BOOL)flag
{
    NSURL * bundleURL = [[NSBundle mainBundle] bundleURL];
    
    if (flag) {
        _itemHandle = LSSharedFileListInsertItemURL(_sharedFileList, kLSSharedFileListItemLast, NULL, NULL, (__bridge CFURLRef)bundleURL, NULL, NULL);
        if (_itemHandle == NULL) {
            NSLog(@"注册开机启动失败");
        }
    } else {
        LSSharedFileListItemRemove(_sharedFileList, _itemHandle);
    }
}

- (BOOL)state
{
    UInt32 seed = 0;
    CFArrayRef loginItemsSnapshot = LSSharedFileListCopySnapshot(_sharedFileList, &seed);
    if (loginItemsSnapshot == NULL) return NO;
    
    CFIndex totalCount = CFArrayGetCount(loginItemsSnapshot);
    for (CFIndex index = 0; index < totalCount; index++)
    {
        LSSharedFileListItemRef handle = (LSSharedFileListItemRef)CFArrayGetValueAtIndex(loginItemsSnapshot, index);
        CFRetain(handle);
    
        CFURLRef urlRef = LSSharedFileListItemCopyResolvedURL(handle, kLSSharedFileListNoUserInteraction, NULL);
        NSURL * url =  CFBridgingRelease(urlRef);
        
        if ([url isEqualTo:[[NSBundle mainBundle] bundleURL]]) {
            _itemHandle = handle;
            CFRelease(loginItemsSnapshot);
            return YES;
        }
    }
    CFRelease(loginItemsSnapshot);
    return NO;
}

@end
