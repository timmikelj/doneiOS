//
//  ListModel.m
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "ListModel.h"
#import "RealmWrapper.h"
#import "LanguageProcessor.h"
#import "ImageDownloader.h"
#import "Item.h"
#import <Realm.h>

@interface ListModel()

@property (strong, nonatomic) RealmWrapper *realmWrapper;
@property (strong, nonatomic) LanguageProcessor *languageProcessor;
@property (strong, nonatomic) ImageDownloader *imageDownloader;

@end

@implementation ListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.realmWrapper = [RealmWrapper new];
        self.languageProcessor = [LanguageProcessor new];
        self.imageDownloader = [ImageDownloader new];
    }
    return self;
}

- (void)addNewItemWithName:(NSString *)name withCompletionHandler:(void (^)(void))completionHandler {
    
    Item *item;
    item = [[Item alloc] init];
    item.name = name;
    item.timeStamp = [[NSDate alloc] init];
    
    [self.realmWrapper addItem:item withCompletionHandler:^{
        completionHandler();
    }];
    
    [self processAddedItem:item];
}

- (void)removeItem:(Item *)item {
    [self.realmWrapper removeItem:item];
}

- (void)toggleItemCompletion:(Item *)item withCompletionHandler:(void (^)(void))completionHandler {
    [self.realmWrapper toggleItemCompletion:item withCompletionHandler:^{
        completionHandler();
    }];
}

#pragma mark Private methods
- (void)processAddedItem:(Item *)item {
    
        RLMThreadSafeReference *itemReference = [RLMThreadSafeReference referenceWithThreadConfined:item];
        
        [self.languageProcessor findNounsAndVerbsInAString:item.name
                                     withCompletionHandler:^(NSArray * _Nonnull nouns, NSArray * _Nonnull verbs) {
            
            NSString *searchString = [[NSString alloc] init];
            
            // Prefer noun search string over verb for now
            if (nouns.count > 0) {
                searchString = nouns.firstObject;
            } else if (verbs.count > 0) {
                searchString = verbs.firstObject;
            }
            
                if (searchString.length > 0) {
                
                [self.imageDownloader loadFirstImageMatchingString:searchString
                                             withCompletionHandler:^(UIImage * _Nullable image) {

                            RLMRealm *realm = [RLMRealm defaultRealm];
                            Item *item = [realm resolveThreadSafeReference:itemReference];
                            if (!item) {
                                return;
                            }
                            [realm beginWriteTransaction];
                            item.imageData = UIImagePNGRepresentation(image);
                            [realm commitWriteTransaction];
                            
                            [self.viewModelDelegate reloadItemWithName:item.name];
                }
                                                  withErrorHandler:^(NSString * _Nonnull errorMessage) {
                    // Decide how to handle the error in the future
                    // Option 1) if manage to retrieve imageUrl could save that to realm and try fetching it when when item is loaded in table view cell
                    // Option 2) could render/load a default image and save that to realm
                    // Option 3) could try to repeat the same query and request to fetch an image
                    NSLog(@"%@", errorMessage);
                }];
            }
        }];
}

@end
