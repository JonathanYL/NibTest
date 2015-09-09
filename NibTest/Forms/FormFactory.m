//
//  FormFactory.m
//  NibTest
//
//  Created by Jonathan Yeung on 2015-08-28.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import "FormFactory.h"

#import "FormField.h"
#import "FormBehaviour.h"

@implementation FormFactory

+ (void)setupCapitalizedNonEmptyFormField:(FormField *)formField
                            returnKeyType:(UIReturnKeyType)returnKeyType
                                 delegate:(id<FormFieldDelegate>)delegate {
    
    FormBehaviour *formBehaviour = [FormBehaviour instanceWithWhileTypingStringBehaviour:^NSString *(NSString *string) {
        return [string uppercaseString];
    } finishedTypingStringBehaviour:^BOOL(NSString *string) {
        return (string.length != 0);
    }];
    
    
    [formField setupWithBehaviour:formBehaviour
                  placeholderText:@"capitalized"
                        errorText:@"fill this in"
                   characterLimit:10
                     keyboardType:UIKeyboardTypeDefault
                    returnKeyType:returnKeyType
                         isSecure:NO
                         delegate:delegate];
}

@end
