//
//  RealmWrapper.m
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "RealmWrapper.h"

@implementation RealmWrapper

- (void)addItem:(Item *)item toRealm:(RLMRealm *)realm withCompletionHandler:(void (^)(void))completionHandler {
    [realm transactionWithBlock:^{
        [realm addObject:item];
        completionHandler();
    }];
}

- (void)removeItem:(Item *)item fromRealm:(RLMRealm *)realm withCompletionHandler:(void (^)(void))completionHandler {
    if (!item) {
        return;
    }
    [realm beginWriteTransaction];
    [realm deleteObject:item];
    [realm commitWriteTransaction];
    completionHandler();
}

- (void)toggleItemCompletion:(Item *)item inRealm:(RLMRealm *)realm withCompletionHandler:(void (^)(void))completionHandler {
    if (!item) {
        return;
    }
    [realm beginWriteTransaction];
    item.completed = !item.completed;
    [realm commitWriteTransaction];
    completionHandler();
}

@end
