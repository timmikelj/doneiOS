//
//  SuccessViewController.m
//  Done
//
//  Created by Tim Mikelj on 18/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "SuccessViewController.h"
#import "UIImage+Extensions.h"

@interface SuccessViewController ()

@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UILabel *successLabel;

@property (strong, nonatomic) CAEmitterLayer *particleEmitter;
@property NSString *successMessage;

@end

@implementation SuccessViewController

- (instancetype)initWithSuccessMessage:(NSString *)successMessage{
    
    self = [super init];
    if (self) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Success" bundle:nil];
        self = [storyboard instantiateViewControllerWithIdentifier:@"SuccessViewController"];
        self.successMessage = successMessage;
        self.particleEmitter = [CAEmitterLayer layer];
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.closeButton.layer.cornerRadius = self.closeButton.frame.size.height/2;
    self.successLabel.text = self.successMessage;
    [self makeHappiness];
}

- (IBAction)closeTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark Private methods

- (void)makeHappiness {
    self.particleEmitter.emitterPosition = CGPointMake(self.view.center.x, -50);
    self.particleEmitter.emitterSize = CGSizeMake(self.view.frame.size.width, 10);
    self.particleEmitter.emitterShape = kCAEmitterLayerLine;
    self.particleEmitter.renderMode = kCAEmitterLayerUnordered;
    
    CAEmitterCell *yellowCell = [self makeEmitterCellWithColor:[UIColor yellowColor]];
     CAEmitterCell *greenCell = [self makeEmitterCellWithColor:[UIColor greenColor]];
     CAEmitterCell *orangeCell = [self makeEmitterCellWithColor:[UIColor orangeColor]];
    
    self.particleEmitter.emitterCells = [NSArray arrayWithObjects:yellowCell, greenCell, orangeCell, nil];
    [self.view.layer addSublayer:self.particleEmitter];
    [self.view.layer setNeedsDisplay];
    
    self.particleEmitter.beginTime = CACurrentMediaTime();
    
}

- (CAEmitterCell *)makeEmitterCellWithColor:(UIColor *)color {
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.yAcceleration = 50;
    cell.birthRate = 10;
    cell.lifetime = 5;
    cell.lifetimeRange = 0;
    cell.velocity = 200;
    cell.velocityRange = 100;
    cell.emissionLongitude = M_PI;
    cell.emissionLatitude = 0;
    cell.emissionRange = M_PI / 4;
    cell.spin = 4;
    cell.spinRange = 10;
    cell.color = [color CGColor];
    
    UIImage *emitterImage = [[UIImage imageNamed:@"emitterCell.png"] tintColor:color];
    
    cell.contents = (id)[emitterImage CGImage];
    return cell;
}

@end
