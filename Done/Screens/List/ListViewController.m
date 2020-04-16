//
//  ViewController.m
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "ListViewController.h"
#import "ListViewModel.h"

@interface ListViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic, nonnull) ListViewModel *viewModel;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [self setup];
    [super viewDidLoad];
}

- (void)setup {
    self.viewModel = [ListViewModel new];
}

- (IBAction)addTapped:(UIBarButtonItem *)sender {
    [self.viewModel addNewItem:@"string" withCompletionHandler:^{
        NSLog(@"success");
    }];
}


@end

