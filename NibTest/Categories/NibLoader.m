//
//  NibLoader.m
//  WhatsGood
//
//  Created by Jonathan Yeung on 2015-03-07.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import "NibLoader.h"
#import "UIView+LayoutConstraints.h"

@implementation NibLoader

+ (id)loadNibForName:(NSString *)nibName owner:(id)owner
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil] firstObject];
}

+ (id)loadViewFromNibName:(NSString *)nibName withPlaceholderView:(UIView *)placeholderView owner:(id)owner
{
    UIView *newView = [NibLoader loadNibForName:nibName owner:owner];
    newView.translatesAutoresizingMaskIntoConstraints = NO;
    [placeholderView addSubview:newView];
    [placeholderView constrainChildViewToLeftTopRightBottom:newView];
    return newView;
}

@end
