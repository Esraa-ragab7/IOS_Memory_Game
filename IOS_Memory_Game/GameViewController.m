//
//  ViewController.m
//  IOS_Memory_Game
//
//  Created by Tagipedia on 11/29/17.
//  Copyright © 2017 Tagipedia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    float gameViewWidth;
    NSMutableArray* blocksArr;
    NSMutableArray* centersArr;
    
    float blockWidth ;
    int timeCount;
    NSTimer* gameTimer;
    CGPoint empty;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    
    _sampleImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@Sample.jpg",_gameMode]];
    
    [super viewDidAppear:YES];
    [_gameViewPuz layoutIfNeeded];
    gameViewWidth = _gameViewPuz.frame.size.width;
    NSLog(@"game %f  %f" , gameViewWidth, _gameViewPuz.frame.size.height);
    [self makeBlocksAction];
    [self randomizeAction];
    timeCount = 60;
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                        target:self
                                      selector:@selector(timerAction)
                                      userInfo:nil
                                       repeats:YES];
}
-(void)timerAction{
    if(timeCount>0)
    {
        timeCount--;
        _timerLabel.text = [NSString stringWithFormat:@"%d\"",timeCount];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)makeBlocksAction
{  
    blocksArr = [NSMutableArray new];
    centersArr = [NSMutableArray new];
    
    
    blockWidth = gameViewWidth / 4;
    float xCen = blockWidth / 2;
    float yCen = blockWidth / 2;
    int imgNum = 1;
    
    
    for( int i = 0; i < 4 ; i++)
    {
        for(int v=0; v<4; v++)
        {
            CGPoint newCen = CGPointMake( xCen, yCen);
            CGRect blockFrame = CGRectMake(0, 0, blockWidth-3, blockWidth-3);
            UIImageView* block = [[UIImageView alloc] initWithFrame:blockFrame];
            NSString* imgName = [NSString stringWithFormat:@"%@_%02d.jpg", _gameMode, imgNum];
            block.image = [UIImage imageNamed:imgName];
            block.center = newCen;
            [_gameViewPuz addSubview:block];
            
            [blocksArr addObject:block];
            [centersArr addObject:[NSValue valueWithCGPoint:newCen]];
            
            xCen += blockWidth;
            imgNum++;
        }
        yCen += blockWidth;
        xCen = blockWidth / 2;
    }
    
}

- (void)randomizeAction
{
    [[blocksArr objectAtIndex:15] removeFromSuperview];
    [blocksArr removeObjectAtIndex:15];
    
    //randomize their locations
    int mod = 16;
    for( UIImageView* any in blocksArr)
    {
        any.userInteractionEnabled = true;
        int randomIndex = arc4random() % mod;
        any.center = [[centersArr objectAtIndex:randomIndex] CGPointValue];
        
        [centersArr removeObjectAtIndex:randomIndex];
        mod--;
    }
    // one center is still in the array
    empty = [[centersArr objectAtIndex:0] CGPointValue];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* mytouch = [[touches allObjects] objectAtIndex:0];
    UIView* touchView = mytouch.view;
    
    if( [blocksArr containsObject:touchView])
    {
        // lets calculate the distancs between this view's center and the empty center
        float xDif = touchView.center.x - empty.x;
        float yDif = touchView.center.y - empty.y;
        
        float distance = sqrt(pow(xDif,2) + pow(yDif, 2));
        
        if( distance == blockWidth)
        {
            CGPoint tempCen = touchView.center;

            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:.5];
            touchView.center = empty;

            empty = tempCen;
        }
    }
    
    
    
    
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
