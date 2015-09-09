//
//  FormField.h
//  NibTest
//
//  Created by Jonathan Yeung on 2015-08-28.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FormField;
@class FormBehaviour;

@protocol FormFieldDelegate <NSObject>

- (void)formFieldDidReturnWithReturnKeyType:(UIReturnKeyType)returnKeyType
                                     sender:(FormField *)sender;

@end

@interface FormField : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (nonatomic, weak) id<FormFieldDelegate> delegate;

- (void)setupWithBehaviour:(FormBehaviour *)behaviour
           placeholderText:(NSString *)placeholderText
                 errorText:(NSString *)errorText
            characterLimit:(NSInteger)characterLimit
              keyboardType:(UIKeyboardType)keyboardType
             returnKeyType:(UIReturnKeyType)returnKeyType
                  isSecure:(BOOL)isSecure
                  delegate:(id<FormFieldDelegate>)delegate;
- (BOOL)validate;

@end
