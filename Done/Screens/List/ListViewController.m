//
//  ViewController.m
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "ListViewController.h"
#import "ListViewModel.h"
#import "AlertHelper.h"

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
    self.viewModel.viewControllerDelegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] init];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.viewModel removeItemAtIndex:indexPath.row];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationLeft];
        });
    }
}

#pragma mark - Actions
- (IBAction)addTapped:(UIBarButtonItem *)sender {
    
    UIAlertController *alert = [[AlertHelper alloc] createAlertAddNewItemWithTitle:@"Add a new item"
                                                                 addedNewItemBlock:^(NSString * _Nonnull itemName) {
        
        __weak typeof(self) weakSelf = self;
        [self.viewModel addNewItemWithName:itemName withCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil]
                                          withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        }];
    }];
    
    [self presentViewController:alert animated:true completion:nil];
}

#pragma mark - ListViewDelegate methods

- (void)reloadTableViewCellAtIndex:(NSUInteger)index {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:index inSection:0], nil]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    });
}

@end

