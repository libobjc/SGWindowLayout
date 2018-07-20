//
//  SGWLPoint.m
//  SGWindowLayout
//
//  Created by Single on 2018/7/20.
//  Copyright © 2018年 single. All rights reserved.
//

#import "SGWLPoint.h"

@implementation SGWLPoint

+ (CGPoint)mouseLocation
{
    return [NSEvent mouseLocation];
}

+ (CGPoint)focusedWindowLocation
{
    pid_t pid = [NSWorkspace sharedWorkspace].frontmostApplication.processIdentifier;
    
    AXUIElementRef application = AXUIElementCreateApplication(pid);
    
    AXUIElementRef focusedWindow;
    AXError error = AXUIElementCopyAttributeValue(application, kAXFocusedWindowAttribute, (CFTypeRef *)&focusedWindow);
    
    if (error != kAXErrorSuccess) {
        NSLog(@"error : get focused window error");
        return CGPointZero;
    }
    
    AXValueRef currentPositionValue;
    error = AXUIElementCopyAttributeValue(focusedWindow, kAXPositionAttribute, (CFTypeRef *)&currentPositionValue);
    if (error != kAXErrorSuccess) {
        NSLog(@"error : get focused window position error");
        return CGPointZero;
    }
    
    CGPoint currentPoint;
    AXValueGetValue(currentPositionValue, kAXValueCGPointType, &currentPoint);
    
    return currentPoint;
}

@end
