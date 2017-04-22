//
//  Layout.m
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import "Layout.h"

@implementation Layout

+ (void)setup
{
    if (!AXIsProcessTrusted()) {
        [self processTrusted];
    }
}

+ (void)processTrusted
{
    CFMutableDictionaryRef options = CFDictionaryCreateMutable(NULL, 0, NULL, NULL);
    CFDictionaryAddValue(options, kAXTrustedCheckOptionPrompt, kCFBooleanTrue);
    AXIsProcessTrustedWithOptions(options);
    CFRelease(options);
}

+ (pid_t)fetchProcessIdentifier
{
    NSRunningApplication * application = [NSWorkspace sharedWorkspace].frontmostApplication;
    return application.processIdentifier;
}

+ (void)layoutWindowWithAttribute:(LayoutAttribute)attribute screenFrame:(NSRect)screenFrame
{
    if (!AXIsProcessTrusted()) {
        [self processTrusted];
        return;
    }
    
    pid_t pid = [self fetchProcessIdentifier];
    
    AXUIElementRef application = AXUIElementCreateApplication(pid);
    
    AXUIElementRef focusedWindow;
    AXError error = AXUIElementCopyAttributeValue(application, kAXFocusedWindowAttribute, (CFTypeRef *)&focusedWindow);
    
    if (error != kAXErrorSuccess) {
        NSLog(@"error : get focused window error");
        return;
    }
    
    AXValueRef currentPositionValue;
    error = AXUIElementCopyAttributeValue(focusedWindow, kAXPositionAttribute, (CFTypeRef *)&currentPositionValue);
    if (error != kAXErrorSuccess) {
        NSLog(@"error : get focused window position error");
    }
    
    CGPoint currentPoint;
    AXValueGetValue(currentPositionValue, kAXValueCGPointType, &currentPoint);
    
    AXValueRef currentSizeValue;
    error = AXUIElementCopyAttributeValue(focusedWindow, kAXSizeAttribute, (CFTypeRef *)&currentSizeValue);
    if (error != kAXErrorSuccess) {
        NSLog(@"error : get focused window size error");
    }
    
    CGSize currentSize;
    AXValueGetValue(currentSizeValue, kAXValueTypeCGSize, &currentSize);
    
    NSRect currentFrame = NSMakeRect(currentPoint.x, currentPoint.y, currentSize.width, currentSize.height);
    CGRect resultFrame = [self realFrameWithScreenFrame:screenFrame currentFrame:currentFrame attribute:attribute];
    CGPoint position = resultFrame.origin;
    CGSize size = resultFrame.size;
    
    AXValueRef positionValue = AXValueCreate(kAXValueCGPointType, &position);
    AXValueRef sizeValue = AXValueCreate(kAXValueCGSizeType, &size);
    
    error = AXUIElementSetAttributeValue(focusedWindow, kAXPositionAttribute, positionValue);
    if (error != kAXErrorSuccess) {
        NSLog(@"error : set position error");
        return;
    }
    error = AXUIElementSetAttributeValue(focusedWindow, kAXSizeAttribute, sizeValue);
    if (error != kAXErrorSuccess) {
        NSLog(@"error : set size error");
        return;
    }
    
    CFRelease(positionValue);
    CFRelease(sizeValue);
}

+ (NSRect)realFrameWithScreenFrame:(NSRect)screenFrame currentFrame:(NSRect)currentFrame attribute:(LayoutAttribute)attribute
{
    NSRect frame;
    switch (attribute) {
        case LayoutAttributeLeft:
        {
            frame.origin = screenFrame.origin;
            frame.size = NSMakeSize(screenFrame.size.width/2, screenFrame.size.height);
        }
            break;
        case LayoutAttributeFull:
        {
            frame = screenFrame;
        }
            break;
        case LayoutAttributeRight:
        {
            frame.origin = CGPointMake(screenFrame.origin.x + screenFrame.size.width/2, screenFrame.origin.y);
            frame.size = NSMakeSize(screenFrame.size.width/2, screenFrame.size.height);
        }
            break;
        case LayoutAttributeTop:
        {
            frame.origin = screenFrame.origin;
            frame.size = NSMakeSize(screenFrame.size.width, screenFrame.size.height/2);
        }
            break;
        case LayoutAttributeBottom:
        {
            frame.origin = NSMakePoint(screenFrame.origin.x, screenFrame.origin.y + screenFrame.size.height/2);
            frame.size = NSMakeSize(screenFrame.size.width, screenFrame.size.height/2);
        }
            break;
        case LayoutAttributeLeftTop:
        {
            frame.origin = screenFrame.origin;
            frame.size = NSMakeSize(screenFrame.size.width/2, screenFrame.size.height/2);
        }
            break;
        case LayoutAttributeRightTop:
        {
            frame.origin = CGPointMake(screenFrame.origin.x + screenFrame.size.width/2, screenFrame.origin.y);
            frame.size = NSMakeSize(screenFrame.size.width/2, screenFrame.size.height/2);
        }
            break;
        case LayoutAttributeLeftBottom:
        {
            frame.origin = NSMakePoint(screenFrame.origin.x, screenFrame.origin.y + screenFrame.size.height/2);
            frame.size = NSMakeSize(screenFrame.size.width/2, screenFrame.size.height/2);
        }
            break;
        case LayoutAttributeRightBottom:
        {
            frame.origin = CGPointMake(screenFrame.origin.x + screenFrame.size.width/2, screenFrame.origin.y + screenFrame.size.height/2);
            frame.size = NSMakeSize(screenFrame.size.width/2, screenFrame.size.height/2);
        }
            break;
        case LayoutAttributeSmaller:
        {
            frame.origin = currentFrame.origin;
            frame.size = NSMakeSize(currentFrame.size.width*3/4, currentFrame.size.height/2);
        }
            break;
    }
    
    if (frame.origin.y > 0) {
        frame.origin.y += 23;
    }
    return frame;
}

@end
