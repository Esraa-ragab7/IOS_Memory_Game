//
//  ViewController.h
//  IOS_Memory_Game
//
//  Created by Tagipedia on 11/29/17.
//  Copyright © 2017 Tagipedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *all;
@property (weak, nonatomic) IBOutlet UIView *gameViewPuz;
@property (weak, nonatomic) IBOutlet UIImageView *sampleImageView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (weak, nonatomic) NSString* gameMode;

- (IBAction)backAction:(id)sender;

@end

