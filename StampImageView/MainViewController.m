//
//  MainViewController.m
//  StampImageView
//
//  Created by Norihiko Hayasaka on 2014/02/01.
//  Copyright (c) 2014 Norihiko Hayasaka. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) addImage:(id)sender
{
    if(_stampImage != nil) {
        [ _stampImage deleteBorder ];
    }

    _stampImage = [[StampImageView alloc] init];
    [ _stampImage setBorderColor:0.3f color_g:0.3f color_b:0.7f ];
    [ _stampImage addStampImage : [UIImage imageNamed:@"Sample.png"] ];

    _stampImage.delegate = self;
    
    [ self.view insertSubview: _stampImage belowSubview : _backImage ];
}


#pragma mark <StampImageViewDelegate> Methods
- (void) setStampImageView : (id) v
{
    if(_stampImage != nil) {
        [ _stampImage deleteBorder ];
    }
    
    _stampImage = v;
    [ self.view insertSubview: _stampImage belowSubview : _backImage ];
}

- (void) checkLongPressGesture
{
    [ _stampImage removeStampImageView ];
    _stampImage = nil;
}



@end
