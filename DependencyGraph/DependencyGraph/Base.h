//
//  Base.h
//  DependencyGraph
//
//  Created by 陈东 on 2019/7/30.
//  Copyright © 2019 陈东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCBase : NSObject

- (void)update;

@end

@interface OCSub: OCBase

@end

NS_ASSUME_NONNULL_END
