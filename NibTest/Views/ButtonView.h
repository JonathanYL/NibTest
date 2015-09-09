//
//  ButtonView.h
//  NibTest
//
//  Created by Jonathan Yeung on 2015-08-17.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonViewDelegate <NSObject>

- (void)topButtonTapped:(id)sender;
- (void)bottomButtonTapped;

@end

@interface ButtonView : UIView

@property (nonatomic, strong) IBOutlet UIView *view;

@property (nonatomic, weak) id<ButtonViewDelegate> delegate;

@end
