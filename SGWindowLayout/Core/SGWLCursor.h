//
//  SGWLCursor.h
//  SGWindowLayout
//
//  Created by Single on 2018/7/20.
//  Copyright © 2018年 single. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface SGWLCursor : NSObject

+ (NSScreen *)swapCursorIfNeeded;
+ (BOOL)swapCursorToScreenIfNeeded:(NSScreen *)screen;

@end
