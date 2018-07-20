//
//  SGWLCursor.m
//  SGWindowLayout
//
//  Created by Single on 2018/7/20.
//  Copyright © 2018年 single. All rights reserved.
//

#import "SGWLCursor.h"

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

+ (void)swapCursor
{
    [[self sharedInstance] swapCursor];
}

- (void)swapCursor
{
    int index = 0;
    CGPoint point = [NSEvent mouseLocation];
    for (int i = 0; i < [NSScreen screens].count; i++)
    {
        NSScreen * screen = [[NSScreen screens] objectAtIndex:i];
        if (CGRectContainsPoint(screen.frame, point))
        {
            index = i + 1;
        }
    }
    if (index == [NSScreen screens].count)
    {
        index = 0;
    }
    if (index < [NSScreen screens].count)
    {
        NSScreen * screen = [[NSScreen screens] objectAtIndex:index];
        [self moveToScreen:screen];
    }
}

- (void)moveToScreen:(NSScreen *)screen
{
    uint32_t displayID = [[screen.deviceDescription objectForKey:@"NSScreenNumber"] intValue];
    CGPoint point = CGPointMake(CGRectGetWidth(screen.frame) / 2.0, CGRectGetHeight(screen.frame) / 2.0);
    CGDisplayMoveCursorToPoint(displayID, point);
}

@end
