//
//  SGWLCursor.m
//  SGWindowLayout
//
//  Created by Single on 2018/7/20.
//  Copyright © 2018年 single. All rights reserved.
//

#import "SGWLCursor.h"
#import "SGWLScreen.h"
#import "SGWLPoint.h"

@interface SGWLCursor ()

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSScreen * mainScreen;

@end

@implementation SGWLCursor

+ (instancetype)sharedInstance
{
    static SGWLCursor * obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[SGWLCursor alloc] init];
    });
    return obj;
}

+ (NSScreen *)swapCursorIfNeeded
{
    return [[self sharedInstance] swapCursorIfNeeded];
}

+ (BOOL)swapCursorToScreenIfNeeded:(NSScreen *)screen
{
    return [[self sharedInstance] swapCursorToScreenIfNeeded:screen];
}

- (NSScreen *)swapCursorIfNeeded
{
    if ([NSScreen screens].count <= 1)
    {
        return nil;
    }
    CGPoint point = [SGWLPoint mouseLocation];
    NSScreen * screen = [SGWLScreen nextScreenWithPoint:point];
    [self moveToScreen:screen];
    return screen;
}

- (BOOL)swapCursorToScreenIfNeeded:(NSScreen *)screen
{
    if (!screen)
    {
        return NO;
    }
    CGPoint mousePoint = [SGWLPoint mouseLocation];
    NSScreen * mouseScreen = [SGWLScreen screenWithPoint:mousePoint];
    if (screen != mouseScreen)
    {
        return [self moveToScreen:screen];
    }
    return NO;
}

- (BOOL)moveToScreen:(NSScreen *)screen
{
    if (!screen)
    {
        return NO;
    }
    uint32_t displayID = [[screen.deviceDescription objectForKey:@"NSScreenNumber"] intValue];
    CGPoint point = CGPointMake(CGRectGetWidth(screen.frame) / 2.0, CGRectGetHeight(screen.frame) / 2.0);
    CGDisplayMoveCursorToPoint(displayID, point);
    return YES;
}

@end
