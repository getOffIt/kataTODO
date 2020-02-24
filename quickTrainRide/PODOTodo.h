//
//  PODOTodo.h
//  quickTrainRide
//
//  Created by Antoine Rabanes on 20/02/2020.
//  Copyright © 2020 Antoine Rabanes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PODOTodo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isCompleted;
@property (nonatomic, assign) NSString *userID;
@property (nonatomic, strong) NSString *author;
@end

NS_ASSUME_NONNULL_END
