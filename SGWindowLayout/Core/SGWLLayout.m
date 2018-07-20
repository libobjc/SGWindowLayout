//
//  Layout.m
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import "SGWLLayout.h"

@implementation SGWLLayout

+ (instancetype)sharedInstance
{
    static SGWLLayout * obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[SGWLLayout alloc] init];
    });
    return obj;
}

+ (void)layoutCurrentFocusedWindowWithLayoutAttribute:(SGWLLayoutAttribute)layoutAttribute
{
    [[SGWLLayout sharedInstance] layoutCurrentFocusedWindowWithLayoutAttribute:layoutAttribute];
}

- (instancetype)init
{
    if (self = [super init])
    {
        if (!AXIsProcessTrusted())
        {
            [self processTrusted];
        }
    }
    return self;
}

- (void)layoutCurrentFocusedWindowWithLayoutAttribute:(SGWLLayoutAttribute)layoutAttribute
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
    CGRect resultFrame = [self realFrameCurrentFrame:currentFrame layoutAttribute:layoutAttribute];
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

- (void)processTrusted
{
    CFMutableDictionaryRef options = CFDictionaryCreateMutable(NULL, 0, NULL, NULL);
    CFDictionaryAddValue(options, kAXTrustedCheckOptionPrompt, kCFBooleanTrue);
    AXIsProcessTrustedWithOptions(options);
    CFRelease(options);
}

- (pid_t)fetchProcessIdentifier
{
    NSRunningApplication * application = [NSWorkspace sharedWorkspace].frontmostApplication;
    return application.processIdentifier;
}

- (NSRect)realFrameCurrentFrame:(NSRect)currentFrame layoutAttribute:(SGWLLayoutAttribute)layoutAttribute
{
    NSRect realFrame;
    NSRect screenFrame = [self screenFrame];
    
    switch (layoutAttribute) {
        case SGWLLayoutAttributeLeft:
        {
            realFrame.origin = screenFrame.origin;
            realFrame.size = NSMakeSize(screenFrame.size.width/2, screenFrame.size.height);
        }
            break;
        case SGWLLayoutAttributeFull:
        {
            realFrame = screenFrame;
        }
            break;
        case SGWLLayoutAttributeRight:
        {
            realFrame.origin = CGPointMake(screenFrame.origin.x + screenFrame.size.width/2, screenFrame.origin.y);
            realFrame.size = NSMakeSize(screenFrame.size.width/2, screenFrame.size.height);
        }
            break;
        case SGWLLayoutAttributeTop:
        {
            realFrame.origin = screenFrame.origin;
            realFrame.size = NSMakeSize(screenFrame.size.width, screenFrame.size.height/2);
        }
            break;
        case SGWLLayoutAttributeBottom:
        {
            realFrame.origin = NSMakePoint(screenFrame.origin.x, screenFrame.origin.y + screenFrame.size.height/2);
            realFrame.size = NSMakeSize(screenFrame.size.width, screenFrame.size.height/2);
        }
            break;
        case SGWLLayoutAttributeLeftTop:
        {
            realFrame.origin = screenFrame.origin;
            realFrame.size = NSMakeSize(screenFrame.size.width/2, screenFrame.size.height/2);
        }
            break;
        case SGWLLayoutAttributeRightTop:
        {
            realFrame.origin = CGPointMake(screenFrame.origin.x + screenFrame.size.width/2, screenFrame.origin.y);
            realFrame.size = NSMakeSize(screenFrame.size.width/2, screenFrame.size.height/2);
        }
            break;
        case SGWLLayoutAttributeLeftBottom:
        {
            realFrame.origin = NSMakePoint(screenFrame.origin.x, screenFrame.origin.y + screenFrame.size.height/2);
            realFrame.size = NSMakeSize(screenFrame.size.width/2, screenFrame.size.height/2);
        }
            break;
        case SGWLLayoutAttributeRightBottom:
        {
            realFrame.origin = CGPointMake(screenFrame.origin.x + screenFrame.size.width/2, screenFrame.origin.y + screenFrame.size.height/2);
            realFrame.size = NSMakeSize(screenFrame.size.width/2, screenFrame.size.height/2);
        }
            break;
        case SGWLLayoutAttributeSmaller:
        {
            realFrame.origin = currentFrame.origin;
            realFrame.size = NSMakeSize(currentFrame.size.width/2, currentFrame.size.height/2);
        }
            break;
    }
    
    if (realFrame.origin.y > 0) {
        realFrame.origin.y += 23;
    }
    return realFrame;
}

- (NSRect)screenFrame
{
    NSScreen * baseScreen = [NSScreen screens].firstObject;
    NSRect baseFrame = baseScreen.frame;
    
    NSScreen * mainScreen = [NSScreen mainScreen];
    NSRect mainFrame = mainScreen.frame;
    NSRect mainVisibleFrame = mainScreen.visibleFrame;
    
    NSRect frame = NSMakeRect(mainVisibleFrame.origin.x,
                             baseFrame.size.height - mainFrame.size.height - mainFrame.origin.y,
                             mainVisibleFrame.size.width, mainVisibleFrame.size.height);
    
    return frame;
}

@end
