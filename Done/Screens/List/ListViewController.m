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
#import "HapticFeedback.h"
#import "SuccessViewController.h"
#import "AppConstants.h"

@interface ListViewController ()

@property (strong, nonatomic, nonnull) ListViewModel *viewModel;
@property (strong, nonatomic) HapticFeedback *hapticFeedback;

@end

@implementation ListViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [self setup];
    [super viewDidLoad];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setup {
    self.hapticFeedback = [HapticFeedback new];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appEnteredForeground)
                                                 name:AppEnteredForegroundNotification
                                               object:nil];
    
    self.viewModel = [ListViewModel new];
    self.viewModel.viewControllerDelegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil]
         forCellReuseIdentifier:[ListTableViewCell reuseIdentifier]];
}

- (void)appEnteredForeground {
    [self.tableView reloadData];
}

#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel.items.count > 0) {
        self.tableView.backgroundView = nil;
        return self.viewModel.items.count;
    } else {
        [self showEmptyTableMessage];
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = (ListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[ListTableViewCell reuseIdentifier]
                                                                                   forIndexPath:indexPath];
    
    Item *item = [self.viewModel.items objectAtIndex:indexPath.row];
    [cell configureWithItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.hapticFeedback tapped];
    [self.viewModel toggleItemCompletionAtIndex:indexPath.row
                          withCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
        });
    }];
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.hapticFeedback tapped];
        
        __weak typeof(self) weakSelf = self;
        [self.viewModel removeItemAtIndex:indexPath.row withCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                          withRowAnimation:UITableViewRowAnimationLeft];
                if ([weakSelf.viewModel.items count] == 0) {
                    [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            });
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.viewModel getViewForPixabayInfoForView:self.view];
}

#pragma mark - Actions
- (IBAction)addTapped:(UIBarButtonItem *)sender {
    [self.hapticFeedback tapped];
    UIAlertController *alert = [[AlertHelper alloc] createAlertAddNewItemWithTitle:@"Add a new item"
                                                                 addedNewItemBlock:^(NSString * _Nonnull itemName) {
        
        __weak typeof(self) weakSelf = self;
        [self.viewModel addNewItemWithName:itemName withCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil]
                                          withRowAnimation:UITableViewRowAnimationAutomatic];
                if ([weakSelf.viewModel.items count] == 1) {
                    [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            });
        }];
    }];
    
    [self presentViewController:alert animated:true completion:nil];
}

#pragma mark - Private methods
- (void)showEmptyTableMessage {
    self.tableView.backgroundView = [self.viewModel emptyListLabelForView:self.view];
}

#pragma mark - ListViewDelegate methods

- (void)reloadTableViewCellAtIndex:(NSUInteger)index {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:index inSection:0], nil]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    });
}

- (void)allItemsCompletedWithSuccessMessage:(NSString *)successMessage {
    SuccessViewController *successViewController = [[SuccessViewController alloc] initWithSuccessMessage:successMessage];
    [self presentViewController:successViewController animated:true completion:nil];
}

@end

