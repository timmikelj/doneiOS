//
//  ListViewModel.m
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "ListViewModel.h"
#import "ListModel.h"

@interface ListViewModel()

@property (nonatomic, strong) ListModel *model;

@end

@implementation ListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [ListModel new];
        self.items = [[Item allObjects] sortedResultsUsingKeyPath:@"timeStamp" ascending:NO];
    }
    return self;
}

- (void)addNewItemWithName:(NSString *)name withCompletionHandler:(void (^)(void))completionHandler
{
    [self.model addNewItemWithName:name withCompletionHandler:^{
        completionHandler();
    }];
}

@end
