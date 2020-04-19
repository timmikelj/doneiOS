//
//  RealmWrapper.h
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

NS_ASSUME_NONNULL_BEGIN

@interface RealmWrapper : NSObject

- (void)addItem:(Item *)item toRealm:(RLMRealm *)realm withCompletionHandler:(void (^)(void))completionHandler;
- (void)removeItem:(Item *)item fromRealm:(RLMRealm *)realm withCompletionHandler:(void (^)(void))completionHandler;
- (void)toggleItemCompletion:(Item *)item inRealm:(RLMRealm *)realm withCompletionHandler:(void (^)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
