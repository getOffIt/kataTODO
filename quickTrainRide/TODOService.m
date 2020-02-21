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

- (void)retrieveTODOSWithCompletionHandler:(void (^)(NSArray<PODOTodo *> *podos))completionHandler {
        NSURL *URL = [NSURL URLWithString:@"https://jsonplaceholder.typicode.com/todos"];
    __weak typeof(self) weakself = self;
        [[[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            __block NSArray<PODOTodo *> *array = [weakself PODOsAdaptedFromJSONArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(array);
            });
            
            
        }] resume];
}

- (NSArray<PODOTodo *> *)PODOsAdaptedFromJSONArray:(NSArray *)jsonArray {
    __block NSMutableArray<PODOTodo *> *arrayOfPODO = [NSMutableArray new];
    
    [jsonArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        PODOTodo *todo = [PODOTodo new];
        todo.title = dict[@"title"];
        todo.isCompleted = dict[@"completed"];
        [arrayOfPODO addObject:todo];
    }];
    
    return arrayOfPODO;
}

@end
