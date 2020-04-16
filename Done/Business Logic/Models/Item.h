//
//  Item.h
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import <Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface Item : RLMObject

@property NSString *name;
@property NSDate *timeStamp;
@property BOOL completed;
@property NSData *imageData;

@end

NS_ASSUME_NONNULL_END
