//
//  SuccessViewController.h
//  Done
//
//  Created by Tim Mikelj on 18/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuccessViewController : UIViewController

- (instancetype)init __attribute__ ((unavailable("init unavailable. Please use initWithSuccessMessage")));

- (instancetype)initWithSuccessMessage:(NSString *)successMessage;

@end

NS_ASSUME_NONNULL_END
