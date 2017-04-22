//
//  Login.m
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import "SGWLLogin.h"

@interface SGWLLogin ()

@property (nonatomic, assign) LSSharedFileListRef sharedFileList;
@property (nonatomic, assign) LSSharedFileListItemRef shareedFileListItem;

@end

@implementation SGWLLogin

+ (instancetype)login
{
    static SGWLLogin * login = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        login = [[self alloc] init];
    });
    return login;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

- (instancetype)init
{
    if (self = [super init]) {
        self.sharedFileList = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    }
    return self;
}

- (void)setStartAtLogin:(BOOL)startAtLogin
{
    NSURL * bundleURL = [[NSBundle mainBundle] bundleURL];
    if (startAtLogin) {
        self.shareedFileListItem = LSSharedFileListInsertItemURL(self.sharedFileList, kLSSharedFileListItemLast, NULL, NULL, (__bridge CFURLRef)bundleURL, NULL, NULL);
        if (self.shareedFileListItem == NULL) {
            NSLog(@"register start at login failure!");
        }
    } else {
        LSSharedFileListItemRemove(self.sharedFileList, self.shareedFileListItem);
    }
}

- (BOOL)startAtLogin
{
    UInt32 seed = 0;
    CFArrayRef loginItemsSnapshot = LSSharedFileListCopySnapshot(self.sharedFileList, &seed);
    if (loginItemsSnapshot == NULL) return NO;
    
    CFIndex totalCount = CFArrayGetCount(loginItemsSnapshot);
    for (CFIndex index = 0; index < totalCount; index++)
    {
        LSSharedFileListItemRef handle = (LSSharedFileListItemRef)CFArrayGetValueAtIndex(loginItemsSnapshot, index);
        CFRetain(handle);
    
        CFURLRef urlRef = LSSharedFileListItemCopyResolvedURL(handle, kLSSharedFileListNoUserInteraction, NULL);
        NSURL * url =  CFBridgingRelease(urlRef);
        
        if ([url isEqualTo:[[NSBundle mainBundle] bundleURL]]) {
            self.shareedFileListItem = handle;
            CFRelease(loginItemsSnapshot);
            return YES;
        }
    }
    CFRelease(loginItemsSnapshot);
    return NO;
}

#pragma clang diagnostic pop

@end
