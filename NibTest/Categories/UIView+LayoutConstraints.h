//
//  UIView+LayoutConstraints.h
//
//  Created by Alex Christodoulou on 2013-06-12.
//  Copyright (c) 2013 Xtreme Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayoutConstraints)

- (void)constrainAttribute:(NSLayoutAttribute) attribute toConstant:(CGFloat)constant;
- (void)constrainChildView:(UIView *)view withSameAttribute:(NSLayoutAttribute)attribute;
- (void)constrainChildView:(UIView *)view withSameAttribute:(NSLayoutAttribute)attribute withConstant:(CGFloat)constant;
- (void)constrainChildView:(UIView *)view withSameAttributes:(NSLayoutAttribute)attribute1, ... NS_REQUIRES_NIL_TERMINATION;
- (void)constrainChildViews:(NSArray *)views withSameAttribute:(NSLayoutAttribute)attribute relatedBy:(NSLayoutRelation)relation withConstant:(CGFloat)constant;
- (void)constrainChildViews:(NSArray *)views withSameAttribute:(NSLayoutAttribute)attribute withConstant:(CGFloat)constant;
- (void)constrainChildViewToLeftTopRightBottom:(UIView *)view;
- (void)constrainViewsVertically:(NSArray *)views withPaddings:(NSArray*)paddings fromBottom:(BOOL)fromBottom;
- (void)constrainViewsVerticallyWithinParent:(NSArray *)views withPaddings:(NSArray *)paddings;
- (void)constrainViewsVerticallyWithinParent:(NSArray *)views withPaddings:(NSArray *)paddings withTopPadding:(CGFloat)topPadding andBottomPadding:(CGFloat)bottomPadding;
- (void)constrainSubviews:(NSArray *)subviews equallyAlongAxis:(UILayoutConstraintAxis)axis;

+ (NSLayoutConstraint *)constraintForView:(UIView *)view1 toView:(UIView *)view2 withSameAttribute:(NSLayoutAttribute)attribute;
+ (NSLayoutConstraint *)contrain:(UIView *)view1 to:(UIView *)view2 forAttribute:(NSLayoutAttribute)attribute withConstant:(CGFloat)constant;
+ (NSArray *)constraintsForView:(UIView *)view1 toView:(UIView *) view2 withSameAttributes:(NSLayoutAttribute)attribute1, ... NS_REQUIRES_NIL_TERMINATION;
+ (void)disableTranslateAutoresizingMaskIntoContraintsForViews:(UIView *)view1, ... NS_REQUIRES_NIL_TERMINATION;
+ (void)disableTranslateAutoresizingMaskIntoContraintsForViewsWithArray:(NSArray *)viewArray;

@end