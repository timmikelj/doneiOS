//
//  LanguageProcessor.m
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "LanguageProcessor.h"

@interface LanguageProcessor()

@property NLTagger *tagger;

@end

@implementation LanguageProcessor

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tagger = [[NLTagger alloc] initWithTagSchemes:[NSArray arrayWithObject:NLTagSchemeLexicalClass]];
    }
    return self;
}

- (void)findNounsAndVerbsInAString:(NSString *)string
               withCompletionBlock:(nonnull void (^)(NSArray * _Nonnull, NSArray * _Nonnull))completionBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        self.tagger.string = string;
        
        NSMutableArray *verbs = [NSMutableArray array];
        NSMutableArray *nouns = [NSMutableArray array];
        
        [self.tagger enumerateTagsInRange:[string rangeOfString:string]
                                     unit:NLTokenUnitWord
                                   scheme:NLTagSchemeLexicalClass
                                  options:NLTaggerOmitPunctuation
                               usingBlock:^(NLTag  _Nullable tag, NSRange tokenRange, BOOL * _Nonnull stop) {
            
            if ([tag isEqual: @"Verb"]) {
                [verbs addObject:[string substringWithRange:tokenRange]];
            }
            
            if ([tag isEqual: @"Noun"]) {
                [nouns addObject:[string substringWithRange:tokenRange]];
            }
        }];
        
        completionBlock([NSArray arrayWithArray:nouns],
                        [NSArray arrayWithArray:verbs]);
        
    });
}

@end
