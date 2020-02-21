//
//  TodosStateManager.m
//  quickTrainRide
//
//  Created by Antoine Rabanes on 21/02/2020.
//  Copyright © 2020 Antoine Rabanes. All rights reserved.
//

#import "TodosStateManager.h"

@interface TodosStateManager()

@property (nonatomic, strong) NSArray<PODOTodo *> *initialTODOSArray;
@property (nonatomic, strong) NSMutableArray<PODOTodo *> *completedTODOSArray;
@property (nonatomic, strong) NSMutableArray<PODOTodo *> *incompletedTODOSArray;
@property (nonatomic, assign) TodoFilter internalState;

@end

@implementation TodosStateManager

- (NSInteger )count
{
    if (!self.initialTODOSArray) {
        return 1;
    }
    
    if (self.internalState == TODOSTATE_ACTIVE) {

        return [self filterNonCompletedArrays].count;
    }
    return self.initialTODOSArray.count;
}

- (void)setState:(TodoFilter) state {
    self.internalState = state;
}

- (void)setTodos:(NSArray<PODOTodo *> *)todos {
    
    self.completedTODOSArray = nil;
    self.incompletedTODOSArray = nil;
    self.initialTODOSArray = todos;
    
}

- (NSArray<PODOTodo *> *)filterNonCompletedArrays {
    if (self.completedTODOSArray) {
        return self.completedTODOSArray;
    }
    self.completedTODOSArray = [NSMutableArray<PODOTodo *> new];
    [self.initialTODOSArray enumerateObjectsUsingBlock:^(PODOTodo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isCompleted == NO) {
            [self.completedTODOSArray addObject:obj];
        }
    }];
    return self.completedTODOSArray;
}

- (NSArray<PODOTodo *> *)filterCompletedArrays {
    if (self.incompletedTODOSArray) {
        return self.incompletedTODOSArray;
    }
    self.incompletedTODOSArray = [NSMutableArray<PODOTodo *> new];
    [self.initialTODOSArray enumerateObjectsUsingBlock:^(PODOTodo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isCompleted == YES) {
            [self.incompletedTODOSArray addObject:obj];
        }
    }];
    return self.incompletedTODOSArray;
}

- (NSArray<PODOTodo *> *)todos {
    if (self.internalState == TODOSTATE_ACTIVE) {
        NSArray<PODOTodo *> *tmpArray = [self filterNonCompletedArrays];
        return tmpArray;
    }
    if (self.internalState == TODOSTATE_COMPLETED) {
        NSArray<PODOTodo *> * tmpArray = [self filterCompletedArrays];
        return tmpArray;

    }
    return self.initialTODOSArray;
}

@end
