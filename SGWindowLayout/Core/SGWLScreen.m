//
//  SGWLScreen.m
//  SGWindowLayout
//
//  Created by Single on 2018/7/20.
//  Copyright © 2018年 single. All rights reserved.
//

#import "SGWLScreen.h"

@implementation SGWLScreen

+ (NSScreen *)screenWithPoint:(CGPoint)point
{
    for (NSScreen * obj in [NSScreen screens])
    {
        if (CGRectContainsPoint(obj.frame, point))
        {
            return obj;
        }
    }
    return nil;
}

+ (NSScreen *)nextScreenWithPoint:(CGPoint)point
{
    int index = 0;
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
        return [[NSScreen screens] objectAtIndex:index];
    }
    return nil;
}

@end
