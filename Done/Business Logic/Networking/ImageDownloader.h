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

/// Using search string Pixabay API finds and downloads a list of up to 10 image URLs(depending on how many images are available) and selects random image out of those 10 to download
- (void)loadFirstImageMatchingString:(NSString *)string
               withCompletionHandler:(void (^)(UIImage * _Nullable image))completionHandler
                    withErrorHandler: (void (^)(NSString *errorMessage))errorHandler;

@end

NS_ASSUME_NONNULL_END
