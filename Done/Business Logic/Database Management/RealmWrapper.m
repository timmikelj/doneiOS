//
//  RealmWrapper.m
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "RealmWrapper.h"

@interface RealmWrapper ()

@property RLMRealm *realm;

@end

@implementation RealmWrapper

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.realm = [RLMRealm defaultRealm];
    }
    return self;
}

- (void)addItem:(Item *)item withCompletionHandler:(void (^)(void))completionHandler {
    [self.realm transactionWithBlock:^{
        [self.realm addObject:item];
        completionHandler();
    }];
}

@end
