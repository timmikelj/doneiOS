//
//  ListViewModel.m
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "ListViewModel.h"
#import "ListModel.h"
#import "UIColor+Extensions.h"

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

- (void)removeItemAtIndex:(NSUInteger)index withCompletionHandler:(void (^)(void))completionHandler {
    Item *itemToDelete = [self.items objectAtIndex:index];
    [self.model removeItem:itemToDelete withCompletionHandler:^{
        completionHandler();
    }];
}

- (void)toggleItemCompletionAtIndex:(NSUInteger)index withCompletionHandler:(void (^)(void))completionHandler {
    Item *itemToToggle = [self.items objectAtIndex:index];
    __weak typeof(self) weakSelf = self;
    [self.model toggleItemCompletion:itemToToggle withCompletionHandler:^{
        completionHandler();
        [weakSelf checkItemsCompletionStatus];
    }];
}

- (UILabel *)emptyListLabelForView:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               view.bounds.size.width - 32,
                                                               view.bounds.size.height)];
    label.text = @"Get things done. 💪\n\nAdd a new item by tapping +";
    label.textColor = [UIColor labelColorBackwardsCompatible];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont preferredFontForTextStyle:@"UIFontTextStyleTitle1"];
    [label sizeToFit];
    
    return label;
}

- (UIView *)getViewForPixabayInfoForView:(UIView *)view {
    
    if ([self.items count] == 0) {
        return [UIView new];
    }
    
    UIView *pixabayView = [[UIView alloc] initWithFrame:(CGRectMake(0,
                                                                    0,
                                                                    view.frame.size.width,
                                                                    100))];
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(0,
                                                                80,
                                                                view.frame.size.width,
                                                                20))];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(pixabayView.frame.origin.x,
                                                                 pixabayView.frame.origin.y + 80,
                                                                 pixabayView.frame.size.width,
                                                                 pixabayView.frame.size.height - 80)];
    
    [button addTarget:self action:@selector(openPixabayWebsite) forControlEvents:UIControlEventTouchUpInside];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"images are from Pixabay 🙂";
    label.font = [UIFont preferredFontForTextStyle:@"UIFontTextStyleCaption2"];
    
    [pixabayView addSubview:label];
    [pixabayView addSubview:button];
    [pixabayView layoutIfNeeded];
    return pixabayView;
}

#pragma mark Private Methods

- (void)openPixabayWebsite {
    NSURL *url = [NSURL URLWithString:@"https://pixabay.com"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

- (void)checkItemsCompletionStatus {
    if (self.items.count > 0) {
        NSUInteger completedItemsCount = [[Item objectsWhere:@"completed == true"] count];
        if (self.items.count == completedItemsCount) {
            NSString *successMessage = @"Awesome!\n\nYou are all Done.";
            [self.viewControllerDelegate allItemsCompletedWithSuccessMessage:successMessage];
        }
    }
}

#pragma mark ListViewModelDelegate Methods

- (void)reloadItemWithName:(NSString *)itemName {
    RLMResults<Item *> *items = [self getItemsByDateDescending];
    NSUInteger index = [items indexOfObjectWhere:@"name == %@", itemName];
    [self.viewControllerDelegate reloadTableViewCellAtIndex:index];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    NSLog(@"link tapped");
    return YES;
}

@end
