//
//  UIView+NibHelpers.m
//  WhatsGood
//
//  Created by Jonathan Yeung on 2015-03-07.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import "UIView+NibHelpers.h"

#import <Foundation/Foundation.h>
#import "NibLoader.h"
#import "UIView+LayoutConstraints.h"

@implementation NSLayoutConstraint (NibHelpers)

- (NSLayoutConstraint *)constraintByReplacingView:(UIView *)viewToReplace withView:(UIView *)replacingView {
    UIView *firstItem = self.firstItem;
    UIView *secondItem = self.secondItem;
    
    if (self.firstItem == viewToReplace) {
        firstItem = replacingView;
    } else if (self.secondItem == viewToReplace) {
        secondItem = replacingView;
    }
    
    return [NSLayoutConstraint constraintWithItem:firstItem
                                        attribute:self.firstAttribute
                                        relatedBy:self.relation
                                           toItem:secondItem
                                        attribute:self.secondAttribute
                                       multiplier:self.multiplier
                                         constant:self.constant];
}

@end

@implementation UIView (NibHelpers)

- (void)configureWithPlaceholderView:(UIView *)placeholderView {
    self.frame = placeholderView.frame;
    
    for (NSLayoutConstraint *constraint in placeholderView.constraints) {
        if ([placeholderView.subviews containsObject:constraint.firstItem] || [placeholderView.subviews containsObject:constraint.secondItem]) {
            continue;
        }
        
        [self addConstraint:[constraint constraintByReplacingView:placeholderView withView:self]];
    }
    
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        [placeholderView.superview addConstraint:[constraint constraintByReplacingView:placeholderView withView:self]];
    }
}

- (id)loadNibForName:(NSString *)name andReplacePlaceholderView:(UIView *)placeholderView {
    UIView *newView = [NibLoader loadNibForName:name owner:self];
    [self addSubview:newView];
    [UIView disableTranslateAutoresizingMaskIntoContraintsForViews:newView, nil];
    [newView configureWithPlaceholderView:placeholderView];
    return newView;
}

@end
