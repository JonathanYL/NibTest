//
//  UIView+NibHelpers.h
//  WhatsGood
//
//  Created by Jonathan Yeung on 2015-03-07.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NibHelpers)

- (id)loadNibForName:(NSString *)name andReplacePlaceholderView:(UIView *)placeholderView;

@end
