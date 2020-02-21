//
//  TodosStateManager.h
//  quickTrainRide
//
//  Created by Antoine Rabanes on 21/02/2020.
//  Copyright © 2020 Antoine Rabanes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PODOTodo.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum todoFilter
{
    TODOSTATE_ALL,
    TODOSTATE_ACTIVE,
    TODOSTATE_COMPLETED
} TodoFilter;

@interface TodosStateManager : NSObject

- (NSInteger )count;
- (void)setState:(TodoFilter) state;
- (NSArray<PODOTodo *> *)todos;
- (void)setTodos:(NSArray<PODOTodo *> *)todos;

@end

NS_ASSUME_NONNULL_END
