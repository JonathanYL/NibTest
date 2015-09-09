//
//  FormFactory.h
//  NibTest
//
//  Created by Jonathan Yeung on 2015-08-28.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FormField;
@protocol FormFieldDelegate;

@interface FormFactory : NSObject

+ (void)setupCapitalizedNonEmptyFormField:(FormField *)formField
                            returnKeyType:(UIReturnKeyType)returnKeyType
                                 delegate:(id<FormFieldDelegate>)delegate;

@end
