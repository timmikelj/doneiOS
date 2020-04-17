//
//  ListViewModelDelegate.h
//  Done
//
//  Created by Tim Mikelj on 17/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/RLMThreadSafeReference.h>

@protocol ListViewModelDelegate <NSObject>

- (void)reloadItemWithName:(NSString *)itemName;

@end
