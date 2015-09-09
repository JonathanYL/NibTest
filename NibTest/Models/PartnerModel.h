//
//  PartnerModel.h
//  NibTest
//
//  Created by Jonathan Yeung on 2015-09-07.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PartnerModel : NSObject

@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptionText;

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
              descriptionText:(NSString *)descriptionText;

@end
