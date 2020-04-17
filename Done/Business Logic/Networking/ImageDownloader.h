//
//  ImageDownloader.h
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageDownloader : NSObject

/// Using Pixabay API finds finds and downloads first image matching given string
- (void)loadFirstImageMatchingString:(NSString *)string
               withCompletionHandler:(void (^)(UIImage * _Nullable image))completionHandler
                    withErrorHandler: (void (^)(NSString *errorMessage))errorHandler;

@end

NS_ASSUME_NONNULL_END
