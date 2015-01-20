//
//  MainViewController.h
//  StampImageView
//
//  Created by Norihiko Hayasaka on 2014/02/01.
//  Copyright (c) 2014 Norihiko Hayasaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StampImageView.h"


@interface MainViewController : UIViewController

@property (nonatomic) StampImageView *stampImage;
@property (nonatomic) IBOutlet UIImageView *backImage;

@end
