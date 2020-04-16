//
//  ListModel.m
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "ListModel.h"
#import "RealmWrapper.h"
#import "LanguageProcessor.h"
#import "ImageDownloader.h"

@interface ListModel()

@property (strong, nonatomic) RealmWrapper *realmWrapper;
@property (strong, nonatomic) LanguageProcessor *languageProcessor;
@property (strong, nonatomic) ImageDownloader *imageDownloader;

@end

@implementation ListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.realmWrapper = [RealmWrapper new];
        self.languageProcessor = [LanguageProcessor new];
        self.imageDownloader = [ImageDownloader new];
    }
    return self;
}

@end
