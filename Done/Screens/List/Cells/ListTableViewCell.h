//
//  ListTableViewCell.h
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListTableViewCell : UITableViewCell

- (void)configureWithItem:(Item *)item;

+ (NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
