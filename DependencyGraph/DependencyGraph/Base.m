//
//  Base.m
//  DependencyGraph
//
//  Created by 陈东 on 2019/7/30.
//  Copyright © 2019 陈东. All rights reserved.
//

#import "Base.h"

@implementation OCBase

- (void)update
{
    [self _update];
}

- (void)_update
{
    NSLog(@"base _update");
}
@end

@implementation OCSub

- (void)_update
{
    NSString *s = @"́";
    NSLog(@"%@", s);
    NSLog(@"sub _update β✔️");
}
@end
