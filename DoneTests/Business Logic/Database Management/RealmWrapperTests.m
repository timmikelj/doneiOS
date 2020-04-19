//
//  RealmWrapperTests.m
//  DoneTests
//
//  Created by Tim Mikelj on 19/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RealmWrapper.h"

@interface RealmWrapperTests : XCTestCase

@property (strong, nonatomic) RealmWrapper *sut;

@end

@implementation RealmWrapperTests

- (void)setUp {
    self.sut = [RealmWrapper new];
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.inMemoryIdentifier = self.name;
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

- (Item *)testToDoItem {
    Item *item = [Item new];
    item.name = @"new to do item";
    item.timeStamp = [NSDate date];
    return item;
}

- (void)testAddItem {

    RLMRealm *testRealm = [RLMRealm defaultRealm];
    Item *item = [self testToDoItem];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"realm object added"];
    
    [self.sut addItem:item toRealm:testRealm withCompletionHandler:^{
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            XCTFail();
        }
    }];
    
    Item *realmItem = [Item allObjectsInRealm:testRealm][0];
    
    XCTAssertEqual([[Item allObjectsInRealm:testRealm] count], 1);
    
    XCTAssertEqualObjects(realmItem.name, item.name);
    XCTAssertEqualObjects(realmItem.timeStamp, item.timeStamp);
    XCTAssertEqualObjects(realmItem.imageData, item.imageData);
    XCTAssertEqual(realmItem.completed, item.completed);
}

- (void)testRemoveItem {
    
    RLMRealm *testRealm = [RLMRealm defaultRealm];
    Item *item = [self testToDoItem];
    
    XCTestExpectation *expectation1 = [self expectationWithDescription:@"realm object added"];
    XCTestExpectation *expectation2 = [self expectationWithDescription:@"realm object removed"];
    
    [self.sut addItem:item toRealm:testRealm withCompletionHandler:^{
        [expectation1 fulfill];
    }];
    
    [self.sut removeItem:item fromRealm:testRealm withCompletionHandler:^{
        [expectation2 fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            XCTFail();
        }
    }];
    
    XCTAssertEqual([[Item allObjectsInRealm:testRealm] count], 0);
}

- (void)testToggleItemCompletion {
    
    RLMRealm *testRealm = [RLMRealm defaultRealm];
    Item *item = [self testToDoItem];
    
    XCTestExpectation *expectation1 = [self expectationWithDescription:@"realm object added"];
    XCTestExpectation *expectation2 = [self expectationWithDescription:@"realm object edited"];
    
    [self.sut addItem:item toRealm:testRealm withCompletionHandler:^{
        [expectation1 fulfill];
    }];
    
    [self.sut toggleItemCompletion:item inRealm:testRealm withCompletionHandler:^{
        [expectation2 fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            XCTFail();
        }
    }];
    
    Item *realmItem = [Item allObjectsInRealm:testRealm][0];
    
    XCTAssertEqual([[Item allObjectsInRealm:testRealm] count], 1);
    
    XCTAssertEqualObjects(realmItem.name, item.name);
    XCTAssertEqualObjects(realmItem.timeStamp, item.timeStamp);
    XCTAssertEqualObjects(realmItem.imageData, item.imageData);
    XCTAssertEqual(realmItem.completed, YES);
}

@end
