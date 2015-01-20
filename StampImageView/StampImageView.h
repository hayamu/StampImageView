//
//  StampImageView.h
//  StampImageView
//
//  Created by Norihiko Hayasaka on 2014/02/01.
//  Copyright (c) 2014 Norihiko Hayasaka. All rights reserved.
//

#import <Foundation/Foundation.h>


#define ROTATE_ADJUST   0.73f
#define DEFAULT_SIZE    160
#define MIN_IMAGE_SIZE  20


@class StampImageView;

@protocol StampImageViewDelegate<NSObject>
@optional
- (void) setStampImageView : (id) v;
- (void) checkLongPressGesture;
@end

@interface StampImageView : UIImageView
{
    id<StampImageViewDelegate> delegate;

    CGFloat stamp_size;

    CGFloat border_color_R;
    CGFloat border_color_G;
    CGFloat border_color_B;

	CGFloat startX;
	CGFloat startY;
	CGFloat startX_before;
	CGFloat startY_before;
    CGFloat image_scale;

    CGFloat rotate;

    CGAffineTransform currentTransForm;
}

@property (nonatomic) id delegate;

- (void) addStampImage : (UIImage *) image;
- (void) removeStampImageView;

- (void) setBorder;
- (void) deleteBorder;
- (void) setBorderColor : (CGFloat) r
                color_g : (CGFloat) g
                color_b : (CGFloat) b;
@end


