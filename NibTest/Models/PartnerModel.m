//
//  PartnerModel.m
//  NibTest
//
//  Created by Jonathan Yeung on 2015-09-07.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import "PartnerModel.h"

@implementation PartnerModel

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
              descriptionText:(NSString *)descriptionText {
    self = [super init];
    if (self) {
        self.iconImage = image;
        self.title = title;
        self.descriptionText = descriptionText;
    }
    return self;
}

@end
