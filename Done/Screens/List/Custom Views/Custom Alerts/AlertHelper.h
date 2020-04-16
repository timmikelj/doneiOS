//
//  AddNewItemAlertController.h
//  Done
//
//  Created by Tim Mikelj on 16/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface AlertHelper : NSObject

- (instancetype)init __attribute__ ((unavailable("init unavailable. Please use initAddNewItemWithTitle or initEditItemName")));

- (UIAlertController *)createAlertAddNewItemWithTitle:(NSString *)title withAddNewItemBlock:(void (^)(NSString *itemName))addNewItem;
- (UIAlertController *)createAlertEditItemName:(Item *)item withEditItemBlock:(void (^)(NSString *newItemName))editItem;

@end
