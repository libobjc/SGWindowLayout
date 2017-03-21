//
//  Layout.h
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, LayoutAttribute) {
    LayoutAttributeLeft,
    LayoutAttributeFull,
    LayoutAttributeRight,
    LayoutAttributeTop,
    LayoutAttributeBottom,
    LayoutAttributeLeftTop,
    LayoutAttributeRightTop,
    LayoutAttributeLeftBottom,
    LayoutAttributeRightBottom,
    LayoutAttributeSmaller,
};

@interface Layout : NSObject

+ (void)setup;
+ (void)layoutWindowWithAttribute:(LayoutAttribute)attribute screenFrame:(NSRect)screenFrame;

@end
