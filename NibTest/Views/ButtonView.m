//
//  ButtonView.m
//  NibTest
//
//  Created by Jonathan Yeung on 2015-08-17.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import "ButtonView.h"
#import "NibLoader.h"
#import "UIView+LayoutConstraints.h"

@interface ButtonView ()

@end

@implementation ButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"frame");
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"coder");
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"supp");
}

#pragma mark - Setup
- (void)setup
{
    [NibLoader loadNibForName:NSStringFromClass([self class]) owner:self];
    self.view.frame = self.bounds;
    [self addSubview:self.view];
}

#pragma mark - IBActions

- (IBAction)topButtonTapped:(id)sender
{
    [self.delegate topButtonTapped:sender];
}

- (IBAction)bottomButtonTapped:(id)sender
{
    [self.delegate bottomButtonTapped];
}

@end
