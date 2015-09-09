//
//  UIView+LayoutConstrain.m
//
//  Created by Alex Christodoulou on 2013-06-12.
//  Copyright (c) 2013 Xtreme Labs Inc. All rights reserved.
//

#import "UIView+LayoutConstraints.h"


@implementation UIView (LayoutConstraints)

+ (NSLayoutConstraint *)constraintForView:(UIView *)view1 toView:(UIView *)view2 withSameAttribute:(NSLayoutAttribute)attribute
{
    return [UIView contrain:view1 to:view2 forAttribute:attribute withConstant:0.0f];
}

+ (NSLayoutConstraint *)contrain:(UIView *)view1 to:(UIView *)view2 forAttribute:(NSLayoutAttribute)attribute withConstant:(CGFloat)constant
{
    return [NSLayoutConstraint constraintWithItem:view1
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:view2
                                        attribute:attribute
                                       multiplier:1.0
                                         constant:constant];
}

+ (NSArray *)constraintsForView:(UIView *)view1 toView:(UIView *)view2 withSameAttributes:(NSLayoutAttribute)attribute1, ... NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray * contraints = [NSMutableArray array];
    
    NSLayoutAttribute attribute;
    va_list argumentList;
    if (attribute1) // The first argument isn't part of the varargs list,
    {                                   // so we'll handle it separately.
        [contraints addObject:[UIView constraintForView:view1 toView:view2 withSameAttribute:attribute1]];
        va_start(argumentList, attribute1); // Start scanning for arguments after firstObject.
        while ((attribute = va_arg(argumentList, NSLayoutAttribute))) // As many times as we can get an argument of type "id"
            [contraints addObject:[UIView constraintForView:view1 toView:view2 withSameAttribute:attribute]]; // that isn't nil, add it to self's contents.
        va_end(argumentList);
    }
    
    return contraints;
}

- (void)constrainChildView:(UIView *)view withSameAttribute:(NSLayoutAttribute)attribute withConstant:(CGFloat)constant
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self attribute:attribute multiplier:1.0f constant:constant];
    [self addConstraint:constraint];
}

- (void)constrainAttribute:(NSLayoutAttribute)attribute toConstant:(CGFloat)constant
{
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:constant];
    constraint.priority = 1000;
    [self addConstraint:constraint];
}

- (void)constrainChildViewToLeftTopRightBottom:(UIView *)view
{
    [self constrainChildView:view withSameAttributes:NSLayoutAttributeLeading,NSLayoutAttributeTop,NSLayoutAttributeTrailing,NSLayoutAttributeBottom, nil];
}

- (void)constrainChildView:(UIView *)view withSameAttribute:(NSLayoutAttribute)attribute
{
    [self addConstraint:[UIView constraintForView:view toView:self withSameAttribute:attribute]];
}

- (void)constrainChildView:(UIView *)view withSameAttributes:(NSLayoutAttribute)attribute1, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list argumentList;
    NSLayoutAttribute attribute;
    if (attribute1) {
        [self constrainChildView:view withSameAttribute:attribute1];
        va_start(argumentList, attribute1);
        while ((attribute = va_arg(argumentList, NSLayoutAttribute))){
            [self constrainChildView:view withSameAttribute:attribute];
        }
        va_end(argumentList);
    }
}

- (void)constrainChildViews:(NSArray *)views withSameAttribute:(NSLayoutAttribute)attribute relatedBy:(NSLayoutRelation)relation withConstant:(CGFloat)constant
{
    for (UIView *view in views) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:attribute relatedBy:relation toItem:self attribute:attribute multiplier:1.0f constant:constant]];
    }
}

- (void)constrainChildViews:(NSArray *)views withSameAttribute:(NSLayoutAttribute)attribute withConstant:(CGFloat)constant
{
    [self constrainChildViews:views withSameAttribute:attribute relatedBy:NSLayoutRelationEqual withConstant:constant];
}

+ (void)disableTranslateAutoresizingMaskIntoContraintsForViews:(UIView *)view1, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list argumentList;
    UIView *view;
    if (view1) {
        view1.translatesAutoresizingMaskIntoConstraints = NO;
        va_start(argumentList, view1);
        while ((view = va_arg(argumentList, UIView*))){
            view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        va_end(argumentList);
    }
}

+ (void)disableTranslateAutoresizingMaskIntoContraintsForViewsWithArray:(NSArray *)viewArray
{
    for (UIView *view in viewArray) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
}

- (void)constrainViewsVertically:(NSArray*)views withPaddings:(NSArray *)paddings fromBottom:(BOOL)fromBottom
{
    if ([views count] < [paddings count] - 1) {
        if ([paddings count] < 1) {
            NSLog(@"Padding information not available, using 0 padding");
            paddings = @[@0];
        } else {
            NSLog(@"Not enough padding objects, using first object");
            paddings = @[[paddings objectAtIndex:0]];
        }
    }
    
    if (views.count < 2) {
        NSLog(@"Cannot constrain a single view vertically");
        return;
    }
    
    
    CGFloat padding = 0;
    if ([paddings count] == 1) {
        padding = [[paddings objectAtIndex:0] floatValue];
    }
    
    for (int i = 0; i < views.count - 1; i++) {
        UIView * view1 = [views objectAtIndex:i];
        UIView * view2 = [views objectAtIndex:i+1];
        
        if ([paddings count] != 1) {
            padding = [[paddings objectAtIndex:i] floatValue];
        }
        
        if (fromBottom) {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:padding]];
        } else {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:padding]];
        }
    }
}

- (void)constrainViewsVerticallyWithinParent:(NSArray *)views withPaddings:(NSArray *)paddings
{
    [self constrainViewsVertically:views withPaddings:paddings fromBottom:NO];
    [self constrainChildView:[views firstObject] withSameAttribute:NSLayoutAttributeTop];
    [self constrainChildView:[views lastObject] withSameAttribute:NSLayoutAttributeBottom];
}

- (void)constrainViewsVerticallyWithinParent:(NSArray *)views withPaddings:(NSArray *)paddings withTopPadding:(CGFloat)topPadding andBottomPadding:(CGFloat)bottomPadding
{
    
    [self constrainViewsVertically:views withPaddings:paddings fromBottom:NO];
    [self constrainChildView:[views firstObject] withSameAttribute:NSLayoutAttributeTop withConstant:topPadding];
    [self constrainChildView:[views lastObject] withSameAttribute:NSLayoutAttributeBottom withConstant:-bottomPadding];
}

//Inspired by https://github.com/jrturton/UIView-Autolayout v0.2.0

- (void)constrainSubviews:(NSArray *)subviews equallyAlongAxis:(UILayoutConstraintAxis)axis
{
    NSLayoutAttribute attributeForView;
    NSLayoutAttribute edgeAttributeToPin;
    NSLayoutAttribute oppositeEdgeAttribute;
    NSLayoutAttribute sizeAttributeToPin;
    
    switch (axis) {
        case UILayoutConstraintAxisHorizontal:
            attributeForView = NSLayoutAttributeCenterX;
            edgeAttributeToPin = NSLayoutAttributeLeft;
            oppositeEdgeAttribute = NSLayoutAttributeRight;
            sizeAttributeToPin = NSLayoutAttributeWidth;
            break;
        case UILayoutConstraintAxisVertical:
            attributeForView = NSLayoutAttributeCenterY;
            edgeAttributeToPin = NSLayoutAttributeTop;
            oppositeEdgeAttribute = NSLayoutAttributeBottom;
            sizeAttributeToPin = NSLayoutAttributeHeight;
            break;
        default:
            break;
    }
    
    if (subviews.count < 1) {
        NSLog(@"no subviews to constrain");
        return;
    }
    
    UIView *firstSubview = [subviews firstObject];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:firstSubview attribute:sizeAttributeToPin relatedBy:NSLayoutRelationEqual toItem:self attribute:sizeAttributeToPin multiplier:1.0/subviews.count constant:0]];
    [self constrainChildView:firstSubview withSameAttribute:NSLayoutAttributeLeft];
    
    if (subviews.count >= 2) {
        for (int i = 0; i < subviews.count - 1; i++) {
            UIView * view1 = [subviews objectAtIndex:i];
            UIView * view2 = [subviews objectAtIndex:i+1];
            
            [self addConstraint:[NSLayoutConstraint constraintWithItem:view2 attribute:edgeAttributeToPin relatedBy:NSLayoutRelationEqual toItem:view1 attribute:oppositeEdgeAttribute multiplier:1.0 constant:0.0f]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:view2 attribute:sizeAttributeToPin relatedBy:NSLayoutRelationEqual toItem:firstSubview attribute:sizeAttributeToPin multiplier:1.0 constant:0.0f]];
        }
    }
}

@end