//
//  MSSegmentControl.m
//  MSSegmentControl
//
//  Created by Masud Shuvo on 5/23/17.
//  Copyright © 2017 Masud Shuvo. All rights reserved.
//


#import "MSSegmentControl.h"
#define INITIAL_PADDING 0
#define GAP_WIDTH       2

@interface MSSegmentControl()

@property (nonatomic, strong) UIImageView *segmentControlBackgroundImageView;

@end

@implementation MSSegmentControl

- (instancetype)initWithFrame:(CGRect)frame withButtons:(NSArray *)buttonArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonArray = buttonArray;
        self.segmentControlBackgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.segmentControlBackgroundImageView];
    }
    return self;
}

- (void)setSegmentBackgroundImage:(UIImage *)segmentBackgroundImage {
    _segmentBackgroundImage = segmentBackgroundImage;
    _segmentControlBackgroundImageView.image = _segmentBackgroundImage;
}

- (void)setButtonArray:(NSArray *)buttonArray {
    _buttonArray = buttonArray;
    
    if (self.frame.size.width == 0) {
        return;
    }
    
    [self setupButtons];
}

- (void)setSelectedButton:(NSInteger)selectedButton {
    _selectedButton = selectedButton;
    [self selectButtonAtIndex:_selectedButton];
}

- (void)selectButtonAtIndex:(NSInteger)index {
    [_buttonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *segmentButton = (UIButton *)obj;
        if (idx == index) {
            [segmentButton setSelected:YES];
        } else {
            [segmentButton setSelected:NO];
        }
    }];
}

- (void)setupButtons {
    if (_buttonArray.count == 0) {
        return;
    }
    __block float buttonsXPosition = INITIAL_PADDING;
    __block float buttonWidth = (self.frame.size.width - (INITIAL_PADDING * 2) - GAP_WIDTH * (_buttonArray.count - 1)) / _buttonArray.count;
    
    [_buttonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *segmentButton = (UIButton *)obj;
        segmentButton.frame = CGRectMake(buttonsXPosition, INITIAL_PADDING, buttonWidth, self.frame.size.height - (INITIAL_PADDING * 2));
        segmentButton.tag = idx;
        segmentButton.clipsToBounds = YES;
        [segmentButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:segmentButton];
        buttonsXPosition += (buttonWidth + GAP_WIDTH);
    }];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(msSegmentControl:didSelectButtonIndex:)]) {
        self.selectedButton = sender.tag;
        [self.delegate msSegmentControl:self didSelectButtonIndex:sender.tag];
        
    }
}

@end
