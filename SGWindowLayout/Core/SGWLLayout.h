//
//  Layout.h
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, SGWLLayoutAttribute) {
    SGWLLayoutAttributeLeft,
    SGWLLayoutAttributeFull,
    SGWLLayoutAttributeRight,
    SGWLLayoutAttributeTop,
    SGWLLayoutAttributeBottom,
    SGWLLayoutAttributeLeftTop,
    SGWLLayoutAttributeRightTop,
    SGWLLayoutAttributeLeftBottom,
    SGWLLayoutAttributeRightBottom,
    SGWLLayoutAttributeSmaller,
};

@interface SGWLLayout : NSObject

+ (void)setup;
+ (void)layoutWindowWithAttribute:(SGWLLayoutAttribute)attribute screenFrame:(NSRect)screenFrame;

@end
