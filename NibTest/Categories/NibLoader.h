//
//  NibLoader.h
//  WhatsGood
//
//  Created by Jonathan Yeung on 2015-03-07.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NibLoader : NSObject

+ (id)loadNibForName:(NSString *)nibName owner:(id)owner;

+ (id)loadViewFromNibName:(NSString *)nibName
      withPlaceholderView:(UIView *)placeholderView
                    owner:(id)owner;
@end
