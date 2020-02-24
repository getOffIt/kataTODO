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

- (void)retrieveLocalTODOSWithCompletionHandler:(void (^)(NSArray<PODOTodo *> *podos))completionHandler {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *URL = [bundle URLForResource:@"todosProd" withExtension:@"json"];
        NSData *data = [NSData dataWithContentsOfURL:URL];
        NSArray<NSDictionary *> *arrayOfTodos = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];

        NSURL *URLUsers = [bundle URLForResource:@"usersprod" withExtension:@"json"];
        NSData *dataUsers = [NSData dataWithContentsOfURL:URLUsers];
        NSArray<NSDictionary *> *arrayOfUsers = [NSJSONSerialization JSONObjectWithData:dataUsers options:0 error:NULL];
        __block NSArray<PODOTodo *> *adaptedPodos = [self PODOsAdaptedFromJSONArray:arrayOfTodos];
        __block NSArray<PODOTodo *> *decoratedPodos = [self PODOs:adaptedPodos decoratedWithUsers:arrayOfUsers];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completionHandler(decoratedPodos);
        });
    });
}

- (NSArray<PODOTodo *> *)PODOsAdaptedFromJSONArray:(NSArray *)jsonArray {
    __block NSMutableArray<PODOTodo *> *arrayOfPODO = [NSMutableArray new];
    
    [jsonArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        PODOTodo *todo = [PODOTodo new];
        todo.title = dict[@"title"];
        todo.isCompleted = [dict[@"completed"] boolValue];
        todo.userID = dict[@"userId"];
        todo.author = @"hi";
        [arrayOfPODO addObject:todo];
    }];
    
    return arrayOfPODO;
}

- (NSArray<PODOTodo *> *)PODOs:(NSArray<PODOTodo *> *)podos decoratedWithUsers:(NSArray *)users {
    NSDictionary *usersDict = [self dictionaryFromJSONArray:users];
    
    for (PODOTodo *podo in podos) {
        NSDictionary *userObject = usersDict[podo.userID];
        if (userObject) {
            podo.author = userObject[@"name"];
        }
    }
    
    return podos;
}

- (NSDictionary *)dictionaryFromJSONArray:(NSArray *)array {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [array enumerateObjectsUsingBlock:^(NSDictionary *element, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = element[@"id"];
        [dict setObject:element forKey:key];
    }];
    return dict;
}

@end
