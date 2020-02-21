//
//  TODOService.m
//  quickTrainRide
//
//  Created by Antoine Rabanes on 20/02/2020.
//  Copyright © 2020 Antoine Rabanes. All rights reserved.
//

#import "TODOService.h"

@implementation TODOService

- (NSArray<PODOTodo *> *)retrieveTODOSSynchronously {
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *URL = [bundle URLForResource:@"todossmall" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    NSArray<NSDictionary *> *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    return [self PODOsAdaptedFromJSONArray:array];
}

- (NSArray<PODOTodo *> *)PODOsAdaptedFromJSONArray:(NSArray *)jsonArray {
    __block NSMutableArray<PODOTodo *> *arrayOfPODO = [NSMutableArray new];
    
    [jsonArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        PODOTodo *todo = [PODOTodo new];
        todo.title = dict[@"title"];
        [arrayOfPODO addObject:todo];
    }];
    
    return arrayOfPODO;
}

@end
