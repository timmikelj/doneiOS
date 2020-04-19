//
//  ItemAlertController.m
//  Done
//
//  Created by Tim Mikelj on 16/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "AlertHelper.h"
#import "HapticFeedback.h"

@interface AlertHelper()

@property UIAlertController *alert;
@property (strong, nonatomic) HapticFeedback *hapticFeedback;

@end

@implementation AlertHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hapticFeedback = [HapticFeedback new];
    }
    return self;
}

- (UIAlertController *)createAlertAddNewItemWithTitle:(NSString *)title addedNewItemBlock:(void (^)(NSString *itemName))addNewItem {
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
        textField.placeholder = @"Type in here";
    }];
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *itemText = self.alert.textFields.firstObject.text;
        [self.hapticFeedback tapped];
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
        [self.hapticFeedback tapped];
        [self.alert dismissViewControllerAnimated:true completion:nil];
    }];
}

@end
