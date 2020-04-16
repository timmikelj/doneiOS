//
//  ListViewModel.h
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListViewModel : NSObject

- (void)addNewItem:(NSString *)item withCompletionHandler:(void (^)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
