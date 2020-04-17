//
//  ListTableViewCell.m
//  Done
//
//  Created by Tim Mikelj on 15/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "ListTableViewCell.h"

@interface ListTableViewCell()

@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemAddedTimeAgoLabel;
@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UIButton *checkBoxButton;

@property (strong, atomic) Item *item;

@end

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureWithItem:(Item *)item {
    self.item = item;
    self.itemNameLabel.text = item.name;
    [self.checkBoxButton setBackgroundImage:[self getImageForItemCompletedStatus:item.completed] forState:normal];
    [self.checkBoxButton setTintColor:[UIColor labelColor]];
    
    UIImage *itemImage = [UIImage imageWithData:item.imageData];
    if (itemImage != nil) {
        [self.itemImageView setImage:itemImage];
        self.itemImageView.layer.cornerRadius = self.itemImageView.frame.size.height/2;
        [self.itemImageView setHidden:false];
    } else {
        [self.itemImageView setHidden:true];
    }
}

- (UIImage *)getImageForItemCompletedStatus:(BOOL)completed {
    return completed == YES
    ? [UIImage imageNamed:@"done"]
    : [UIImage imageNamed:@"notDone"];
}

- (IBAction)checkBoxTapped:(UIButton *)sender {
    // update completed status in realm & update UI
}

+ (NSString *)reuseIdentifier {
    return @"ListTableViewCell";
}
@end
