//
//  LanguageProcessor.h
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NaturalLanguage/NaturalLanguage.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanguageProcessor : NSObject

/// Evaluates a string and returns an array of NSString verbs and array of NSString nouns
- (void)findNounsAndVerbsInAString:(NSString *)string
             withCompletionHandler:(nonnull void (^)(NSArray * _Nullable nouns,
                                                     NSArray * _Nullable verbs))completionHandler;

@end

NS_ASSUME_NONNULL_END
