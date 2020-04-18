//
//  HapticFeedback.m
//  Done
//
//  Created by Tim Mikelj on 18/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "HapticFeedback.h"
#import <UIKit/UIImpactFeedbackGenerator.h>

@interface HapticFeedback()

@property UIImpactFeedbackGenerator *feedbackGenerator;

@end

@implementation HapticFeedback

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    }
    return self;
}

- (void)tapped {
    [self.feedbackGenerator impactOccurred];
}

@end
