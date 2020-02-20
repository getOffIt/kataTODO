//
//  TODOService.h
//  quickTrainRide
//
//  Created by Antoine Rabanes on 20/02/2020.
//  Copyright © 2020 Antoine Rabanes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TODOService : NSObject

- (NSArray<NSDictionary *> *)retrieveTODOS;

@end

NS_ASSUME_NONNULL_END
