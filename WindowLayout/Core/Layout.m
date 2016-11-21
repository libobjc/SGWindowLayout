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

+ (void)layoutWindowWithAttribute:(LayoutAttribute)attribute frame:(NSRect)frame
{
    CGPoint position = [self rect:frame attribute:attribute].origin;
    CGSize size = [self rect:frame attribute:attribute].size;
    
    pid_t pid = [self fetchProcessIdentifier];
    
    AXUIElementRef application = AXUIElementCreateApplication(pid);
    
    AXUIElementRef focusedWindow;
    AXError error = AXUIElementCopyAttributeValue(application, kAXFocusedWindowAttribute, (CFTypeRef *)&focusedWindow);
    
    if (error != kAXErrorSuccess) {
        NSLog(@"error : get focused window error");
        return;
    }
    
    AXValueRef positionValue = AXValueCreate(kAXValueCGPointType, &position);
    AXValueRef sizeValue = AXValueCreate(kAXValueCGSizeType, &size);
    
//    AXUIElementSetAttributeValue(focusedWindow, (CFStringRef)NSAccessibilityPositionAttribute, positionValue);
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

+ (NSRect)rect:(NSRect)rect attribute:(LayoutAttribute)attribute
{
    NSRect frame;
    switch (attribute) {
        case LayoutAttributeLeft:
        {
            frame.origin = rect.origin;
            frame.size = NSMakeSize(rect.size.width/2, rect.size.height);
        }
            break;
        case LayoutAttributeFull:
        {
            frame = rect;
        }
            break;
        case LayoutAttributeRight:
        {
            frame.origin = CGPointMake(rect.origin.x + rect.size.width/2, rect.origin.y);
            frame.size = NSMakeSize(rect.size.width/2, rect.size.height);
        }
            break;
        case LayoutAttributeTop:
        {
            frame.origin = rect.origin;
            frame.size = NSMakeSize(rect.size.width, rect.size.height/2);
        }
            break;
        case LayoutAttributeBottom:
        {
            frame.origin = NSMakePoint(rect.origin.x, rect.origin.y + rect.size.height/2);
            frame.size = NSMakeSize(rect.size.width, rect.size.height/2);
        }
            break;
    }
    
    return frame;
}

@end
