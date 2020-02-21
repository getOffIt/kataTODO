//
//  TodosStateManager.m
//  quickTrainRide
//
//  Created by Antoine Rabanes on 21/02/2020.
//  Copyright © 2020 Antoine Rabanes. All rights reserved.
//

#import "TodosStateManager.h"

@interface TodosStateManager()

@property (nonatomic, strong) NSArray<PODOTodo *> *initialArray;
@property (nonatomic, assign) TodoFilter internalState;

@end

@implementation TodosStateManager

- (NSInteger )count
{
    if (!self.initialArray) {
        return 1;
    }
    
    if (self.internalState == TODOSTATE_ACTIVE) {

        return [self filterNonCompletedArrays].count;
    }
    return self.initialArray.count;
}

- (void)setState:(TodoFilter) state {
    self.internalState = state;
}

- (void)setTodos:(NSArray<PODOTodo *> *)todos {
    self.initialArray = todos;
}

- (NSMutableArray<PODOTodo *> *)filterNonCompletedArrays {
    NSMutableArray<PODOTodo *> *tmpArray = [NSMutableArray new];
    [self.initialArray enumerateObjectsUsingBlock:^(PODOTodo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isCompleted == NO) {
            [tmpArray addObject:obj];
        }
    }];
    return tmpArray;
}

- (NSMutableArray<PODOTodo *> *)filterCompletedArrays {
    NSMutableArray<PODOTodo *> *tmpArray = [NSMutableArray new];
    [self.initialArray enumerateObjectsUsingBlock:^(PODOTodo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isCompleted == YES) {
            [tmpArray addObject:obj];
        }
    }];
    return tmpArray;
}

- (NSArray<PODOTodo *> *)todos {
    if (self.internalState == TODOSTATE_ACTIVE) {
        NSMutableArray<PODOTodo *> * tmpArray = [self filterNonCompletedArrays];
        return tmpArray;
    }
    if (self.internalState == TODOSTATE_COMPLETED) {
        NSMutableArray<PODOTodo *> * tmpArray = [self filterCompletedArrays];
        return tmpArray;

    }
    return self.initialArray;
}

@end
