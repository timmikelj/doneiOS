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

@property (strong, nonatomic, nonnull) ListViewModel *viewModel;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [self setup];
    [super viewDidLoad];
}

- (void)setup {
    self.viewModel = [ListViewModel new];
    [self.tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil]
         forCellReuseIdentifier:[ListTableViewCell reuseIdentifier]];
}

#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = (ListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[ListTableViewCell reuseIdentifier]
                                                                                   forIndexPath:indexPath];
    
    Item *item = [self.viewModel.items objectAtIndex:indexPath.row];
    [cell configureWithItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}


// create alert with text field to add a new item
- (IBAction)addTapped:(UIBarButtonItem *)sender {
     __weak typeof(self) weakSelf = self;
    [self.viewModel addNewItemWithName:@"BOOM" withCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        });
    }];
}

@end

