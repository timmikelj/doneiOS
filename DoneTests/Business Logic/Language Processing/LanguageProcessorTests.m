//
//  DoneTests.m
//  DoneTests
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LanguageProcessor.h"

@interface LanguageProcessorTests : XCTestCase

@property (strong, nonatomic) LanguageProcessor *sut;

@end

@implementation LanguageProcessorTests

- (void)setUp {
    self.sut = [[LanguageProcessor alloc] init];
}

- (void)testEvaluateStringFindsANoun {
    
    NSString *stringToEvaluate = @"Go to Barcelona";
    XCTestExpectation *stringEvaluated = [self expectationWithDescription:@"string evaluated"];
    
    [self.sut findNounsAndVerbsInAString:stringToEvaluate withCompletionHandler:^(NSArray * _Nullable nouns, NSArray * _Nullable verbs) {
        
        XCTAssertEqualObjects(nouns, @[@"Barcelona"]);
        [stringEvaluated fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error != nil) {
             XCTFail();
        }
    }];
}

- (void)testEvaluateStringFindsPronounsAndAppendsItToNounsArray {
    
    NSString *stringToEvaluate = @"pick him up";
    XCTestExpectation *stringEvaluated = [self expectationWithDescription:@"string evaluated"];
    
    [self.sut findNounsAndVerbsInAString:stringToEvaluate withCompletionHandler:^(NSArray * _Nullable nouns, NSArray * _Nullable verbs) {
        
        XCTAssertEqualObjects(nouns, @[@"him"]);
        [stringEvaluated fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error != nil) {
             XCTFail();
        }
    }];
}

- (void)testEvaluateStringFindsAVerb {
    
    NSString *stringToEvaluate = @"Go for a run";
    XCTestExpectation *stringEvaluated = [self expectationWithDescription:@"string evaluated"];
    
    [self.sut findNounsAndVerbsInAString:stringToEvaluate withCompletionHandler:^(NSArray * _Nullable nouns, NSArray * _Nullable verbs) {
        
        XCTAssertEqualObjects(verbs, @[@"Go"]);
        [stringEvaluated fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error != nil) {
             XCTFail();
        }
    }];
}

- (void)testEvaluateStringFindsMultipleVerbsAndNous {
    
    NSString *stringToEvaluate = @"Go for a run and pick mum up from the airport";
    XCTestExpectation *stringEvaluated = [self expectationWithDescription:@"string evaluated"];
    
    [self.sut findNounsAndVerbsInAString:stringToEvaluate withCompletionHandler:^(NSArray * _Nullable nouns, NSArray * _Nullable verbs) {
        
        NSArray *expectedVerbs = [NSArray arrayWithObjects:@"Go", @"pick", nil];
        NSArray *expectedNouns = [NSArray arrayWithObjects:@"run", @"mum", @"airport", nil];
        
        XCTAssertEqualObjects(verbs, expectedVerbs);
        XCTAssertEqualObjects(nouns, expectedNouns);
        [stringEvaluated fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error != nil) {
             XCTFail();
        }
    }];
}



@end
