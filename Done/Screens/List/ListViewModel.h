//
//  ListViewModel.h
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "ListViewModelDelegate.h"
#import "ListViewControllerDelegate.h"
#import <Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListViewModel : NSObject <ListViewModelDelegate>

@property RLMResults<Item *> *items;

@property (weak, nonatomic) id<ListViewControllerDelegate> viewControllerDelegate;

- (void)addNewItemWithName:(NSString *)name withCompletionHandler:(void (^)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
