//
//  StampImageView.m
//  StampImageView
//
//  Created by Norihiko Hayasaka on 2014/02/01.
//  Copyright (c) 2014 Norihiko Hayasaka. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "StampImageView.h"

@implementation StampImageView
@synthesize delegate;

- (void) initParams
{
    self.userInteractionEnabled = YES;
    [self setMultipleTouchEnabled:YES];

    stamp_size = DEFAULT_SIZE;
    startX = 0;
    startY = 0;

    self.image = nil;

    rotate = 0;
    image_scale = 1.0f;
    self.transform = CGAffineTransformMakeRotation(rotate);

    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(onPinch:)];
    [self addGestureRecognizer:pinch];

    UIRotationGestureRecognizer* rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(onRotation:)];
    [self addGestureRecognizer:rotation];

    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
    longPress.minimumPressDuration = 1.0f;
    longPress.allowableMovement = 2.0f;
    [self addGestureRecognizer:longPress];

    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [self addGestureRecognizer:pan];

}


- (void)onPinch : (UIPinchGestureRecognizer *)sender {

    if (sender.state == UIGestureRecognizerStateBegan) {
        currentTransForm = self.transform;
    }

    if ( (sender.state == UIGestureRecognizerStateEnded) ||
        (sender.state == UIGestureRecognizerStateCancelled ) ||
        (sender.state == UIGestureRecognizerStateFailed ) )
    {
        CGRect frame = [self frame];
        startX = startX_before = frame.origin.x;
        startY = startY_before = frame.origin.y;
        stamp_size = frame.size.width;
        if(rotate != 0) {
            stamp_size = (stamp_size * ROTATE_ADJUST);
        }

        return;
    }
    image_scale = [sender scale];
    self.transform = CGAffineTransformConcat(currentTransForm,
                                             CGAffineTransformMakeScale(image_scale, image_scale));
}




- (void) onRotation:(UIRotationGestureRecognizer*) sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        currentTransForm = self.transform;
    }

    if ( (sender.state == UIGestureRecognizerStateEnded) ||
        (sender.state == UIGestureRecognizerStateCancelled ) ||
        (sender.state == UIGestureRecognizerStateFailed ) )
    {
        CGRect frame = [self frame];
        startX = startX_before = frame.origin.x;
        startY = startY_before = frame.origin.y;

        return;
    }

    UIRotationGestureRecognizer* rotation = (UIRotationGestureRecognizer*) sender;
    rotate = rotation.rotation;
    self.transform = CGAffineTransformConcat(currentTransForm, CGAffineTransformMakeRotation(rotate));
}


- (void) onPan:(UIPanGestureRecognizer*) sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        startX_before = startX;
        startY_before = startY;
        currentTransForm = self.transform;
    }
    [ self setBorder ];
    self.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(stamp_size / DEFAULT_SIZE ,
                                                                        stamp_size / DEFAULT_SIZE), 0);

    UIPanGestureRecognizer* pan = (UIPanGestureRecognizer*) sender;
    CGPoint location = [pan translationInView:self];
    startX = startX_before + (location.x*(stamp_size / DEFAULT_SIZE));
    startY = startY_before + (location.y*(stamp_size / DEFAULT_SIZE));

    CGRect frame = [self frame];
    frame.origin.x = startX;
    frame.origin.y = startY;

    [self setFrame:frame];
    self.transform = currentTransForm;
}

- (void) onLongPress:(UILongPressGestureRecognizer*) sender
{
    if ([delegate respondsToSelector:@selector(checkLongPressGesture)]) {
        [ delegate checkLongPressGesture ];
    }
}

- (void) touchesBegan : (NSSet *)touches withEvent : (UIEvent *) event
{
    if ([delegate respondsToSelector:@selector(setStampImageView:)]) {
        [ delegate setStampImageView : self ];
    }

    startX_before = startX;
    startY_before = startY;

    [ self setBorder ];
}

- (void) setBorder
{

    [[self layer] setBorderColor:[[UIColor colorWithRed:border_color_R
                                                  green:border_color_G
                                                   blue:border_color_B
                                                  alpha:1.0f] CGColor]];
    [[self layer] setBorderWidth:1.0f];
}

- (void) deleteBorder
{
    [[self layer] setBorderColor:[[UIColor clearColor] CGColor]];
}

- (void) addStampImage : (UIImage *) image
{
    [ self initParams ];
    [ self setBorder ];

    self.image = image;
    self.frame = CGRectMake( startX, startY, stamp_size, stamp_size );
    self.transform = CGAffineTransformRotate( self.transform, rotate );
}

- (void) removeStampImageView
{
    [ self removeFromSuperview ];
}

- (void) setBorderColor : (CGFloat) r
                color_g : (CGFloat) g
                color_b : (CGFloat) b
{
    border_color_R = r;
    border_color_G = g;
    border_color_B = b;
}



@end
