//
//  MSSegmentControl.h
//  MSSegmentControl
//
//  Created by Masud Shuvo on 5/23/17.
//  Copyright © 2017 Reve System. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSSegmentControlDelegate;

@interface MSSegmentControl : UIView

@property (nonatomic, weak) id <MSSegmentControlDelegate> delegate;
@property (nonatomic, strong) NSArray *buttonArray;
@property (nonatomic, assign) NSInteger selectedButton;
@property (nonatomic, strong) UIImage *segmentBackgroundImage;

- (instancetype)initWithFrame:(CGRect)frame withButtons:(NSArray *)buttonArray;

@end

@protocol MSSegmentControlDelegate <NSObject>

- (void)msSegmentControl:(MSSegmentControl *)msSegmentControl didSelectButtonIndex:(NSInteger)buttonIndex;

@end
