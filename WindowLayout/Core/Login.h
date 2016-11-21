//
//  Login.h
//  WindowLayout
//
//  Created by Single on 2016/11/21.
//  Copyright © 2016年 single. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject

+ (instancetype)login;
- (BOOL)state;
- (void)startAtLogin:(BOOL)flag;

@end
