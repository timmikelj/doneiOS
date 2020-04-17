//
//  ImageDownloader.m
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

- (NSString *)pixabayApiKey {
    return @"?key=16082596-94f91776eb4afb13086eb38ea";
}

- (NSString *)encodedSearchStringWith:(NSString *)string {
    NSString *encodedString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    return [NSString stringWithFormat:@"&q=%@", encodedString];
}

- (void)loadFirstImageMatchingString:(NSString *)string
               withCompletionHandler:(void (^)(UIImage * _Nullable))completionHandler
                    withErrorHandler: (void (^)(NSString *errorMessage))errorHandler
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSMutableString *urlString = [NSMutableString string];
        [urlString appendString:@"https://pixabay.com/api/"];
        [urlString appendString:[self pixabayApiKey]];
        [urlString appendString:[self encodedSearchStringWith:string]];
        [urlString appendString:@"&min_width=80"];
        [urlString appendString:@"&min_height=80"];
        [urlString appendString:@"&order=popular"];
        [urlString appendString:@"&lang=en"];
        [urlString appendString:@"&per_page=10"];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURL *url = [NSURL URLWithString:urlString];
        
        if (url == nil) {
            errorHandler(@"invalid pixabay API URL");
            return;
        }
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:10.0];
        
        [request setHTTPMethod:@"GET"];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (error != nil) {
                errorHandler(error.localizedDescription);
                return;
            }
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSArray *arrayOfImages = [json objectForKey:@"hits"];
            if (arrayOfImages.count == 0) {
                return;
            }
            uint32_t randomIndex = arc4random_uniform((int)[arrayOfImages count]);
            NSString *imageUrl = [[arrayOfImages objectAtIndex:randomIndex] objectForKey:@"webformatURL"];
            
            [self loadImageWithUrlString:imageUrl
                     retrievedImageBlock:^(UIImage *image) {
                // got image 🎉
                completionHandler(image);
            } errorBlock:^(NSString *errorMessage) {
                errorHandler(errorMessage);
            }];
        }];
        
        [dataTask resume];
        
    });
    
}

- (void)loadImageWithUrlString:(NSString *)urlString
           retrievedImageBlock:(void (^)(UIImage *image))imageBlock
                    errorBlock: (void (^)(NSString *errorMessage))errorBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURL *url = [NSURL URLWithString:urlString];
        
        if (url == nil) {
            errorBlock(@"invalid image URL");
            return;
        }
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:10.0];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (error != nil) {
                errorBlock(error.localizedDescription);
                return;
            }
            
            UIImage *image = [[UIImage alloc] initWithData:data];
            if (image != nil) {
                imageBlock(image);
            } else {
                errorBlock([NSString stringWithFormat:@"error loading image from: %@", urlString]);
            }
            
        }];
        
        [dataTask resume];
        
    });
}

@end
