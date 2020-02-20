//
//  TODOService.m
//  quickTrainRide
//
//  Created by Antoine Rabanes on 20/02/2020.
//  Copyright © 2020 Antoine Rabanes. All rights reserved.
//

#import "TODOService.h"

@implementation TODOService

- (NSArray<NSDictionary *> *)retrieveTODOS {
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *URL = [bundle URLForResource:@"todossmall" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    NSArray<NSDictionary *> *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    return array;
    
}

@end
