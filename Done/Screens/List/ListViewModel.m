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

- (RLMResults<Item *> *)getItemsByDateDescending {
    return [[Item allObjects] sortedResultsUsingKeyPath:@"timeStamp" ascending:NO];
}

- (void)addNewItemWithName:(NSString *)name withCompletionHandler:(void (^)(void))completionHandler {
    [self.model addNewItemWithName:name withCompletionHandler:^{
        completionHandler();
    }];
}

- (void)removeItemAtIndex:(NSUInteger)index {
    Item *itemToDelete = [self.items objectAtIndex:index];
    [self.model removeItem:itemToDelete];
}

- (void)toggleItemCompletionAtIndex:(NSUInteger)index withCompletionHandler:(void (^)(void))completionHandler {
    Item *itemToToggle = [self.items objectAtIndex:index];
    [self.model toggleItemCompletion:itemToToggle withCompletionHandler:^{
        completionHandler();
    }];
}

- (UILabel *)emptyListLabelForView:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               view.bounds.size.width - 32,
                                                               view.bounds.size.height)];
    label.text = @"Get things done. 💪\n\nAdd a new item by tapping +";
    label.textColor = [UIColor labelColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont preferredFontForTextStyle:@"UIFontTextStyleTitle1"];
    [label sizeToFit];
    
    return label;
}

#pragma mark ListViewModelDelegate Methods

- (void)reloadItemWithName:(NSString *)itemName {
    RLMResults<Item *> *items = [self getItemsByDateDescending];
    NSUInteger index = [items indexOfObjectWhere:@"name == %@", itemName];
    [self.viewControllerDelegate reloadTableViewCellAtIndex:index];
}

@end
