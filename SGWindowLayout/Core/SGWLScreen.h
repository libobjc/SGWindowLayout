//
//  SGWLScreen.h
//  SGWindowLayout
//
//  Created by Single on 2018/7/20.
//  Copyright © 2018年 single. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface SGWLScreen : NSObject

+ (NSScreen *)screenWithPoint:(CGPoint)point;
+ (NSScreen *)nextScreenWithPoint:(CGPoint)point;

@end
