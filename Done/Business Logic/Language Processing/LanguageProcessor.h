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

/// Evalues a string and returns an array of NSString verbs and array of NSString nouns
- (void)findNounsAndVerbsInAString:(NSString *)string
               withCompletionBlock:(void (^)(NSArray *nouns, NSArray *verbs))completionBlock;

@end

NS_ASSUME_NONNULL_END
