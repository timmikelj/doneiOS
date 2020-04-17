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
        self.model.viewModelDelegate = self;
        self.items = [self getItemsByDateDescending];
    }
    return self;
}

- (RLMResults<Item *> *)getItemsByDateDescending
{
    return [[Item allObjects] sortedResultsUsingKeyPath:@"timeStamp" ascending:NO];
}

- (void)addNewItemWithName:(NSString *)name withCompletionHandler:(void (^)(void))completionHandler
{
    [self.model addNewItemWithName:name withCompletionHandler:^{
        completionHandler();
    }];
}

- (void)reloadItemWithReference:(RLMThreadSafeReference *)itemReference
{    
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    Item *item = [realm resolveThreadSafeReference:itemReference];
//    NSUInteger index = [self.items indexOfObject:item];
//    [self.viewControllerDelegate reloadTableViewCellAtIndex:index];
}

- (void)reloadItemWithName:(NSString *)itemName
{
    RLMResults<Item *> *items = [self getItemsByDateDescending];
    NSUInteger index = [items indexOfObjectWhere:@"name == %@", itemName];
    [self.viewControllerDelegate reloadTableViewCellAtIndex:index];
}

- (void)reloadItem:(Item *)item {
    

}

@end
