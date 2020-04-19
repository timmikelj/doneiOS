//
//  ListViewControllerDelegate.h
//  Done
//
//  Created by Tim Mikelj on 17/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ListViewControllerDelegate <NSObject>

- (void)reloadTableViewCellAtIndex:(NSUInteger)index;
- (void)allItemsCompletedWithSuccessMessage:(NSString *)successMessage;

@end
