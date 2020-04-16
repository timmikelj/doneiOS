//
//  ItemAlertController.m
//  Done
//
//  Created by Tim Mikelj on 16/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "AlertHelper.h"

@interface AlertHelper()

@property UIAlertController *alert;

@end

@implementation AlertHelper

- (UIAlertController *)createAlertAddNewItemWithTitle:(NSString *)title withAddNewItemBlock:(void (^)(NSString *itemName))addNewItem {
    self.alert = [UIAlertController alertControllerWithTitle:title
                                                     message:@""
                                              preferredStyle:UIAlertControllerStyleAlert];
    
    [self configureAddNewItemWithBlock:^(NSString *itemName) {
        addNewItem(itemName);
    }];
    return self.alert;
}

- (UIAlertController *)createAlertEditItemName:(Item *)item withEditItemBlock:(void (^)(NSString *))editItem {
    self.alert = [UIAlertController alertControllerWithTitle:@"Edit item"
                                                     message:@""
                                              preferredStyle:UIAlertControllerStyleAlert];
    return self.alert;
}

#pragma mark - Private methods
- (void)configureAddNewItemWithBlock:(void (^)(NSString *itemName))addNewItem {
    
    [self.alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Please type in here";
    }];
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *itemText = self.alert.textFields.firstObject.text;
        if (![itemText isEqualToString:@""]) {
            addNewItem(itemText);
        } else {
            return;
        }
    }];
    
    [self.alert addAction:[self alertCancelAction]];
    [self.alert addAction:addAction];
}

- (UIAlertAction *)alertCancelAction {
    return [UIAlertAction actionWithTitle:@"Cancel"
                                    style:UIAlertActionStyleDestructive
                                  handler:^(UIAlertAction * _Nonnull action) {
        [self.alert dismissViewControllerAnimated:true completion:nil];
    }];
}

@end
