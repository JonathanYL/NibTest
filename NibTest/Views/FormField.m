//
//  FormField.m
//  NibTest
//
//  Created by Jonathan Yeung on 2015-08-28.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import "FormField.h"

#import "FormBehaviour.h"
#import "NibLoader.h"

@interface FormField () <UITextFieldDelegate>

@property (nonatomic, strong) FormBehaviour *formBehaviour;

@property (nonatomic) NSInteger characterLimit;
@property (nonatomic, readwrite) BOOL isValid;

@end

@implementation FormField

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [NibLoader loadNibForName:NSStringFromClass([self class]) owner:self];
    self.view.frame = self.bounds;
    [self addSubview:self.view];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self styleViews];
    self.inputField.delegate = self;
    [self.inputField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)styleViews {
    self.errorLabel.textColor = [UIColor redColor];
    self.errorLabel.font = [UIFont systemFontOfSize:8.f];
    self.inputField.textColor = [UIColor grayColor];
    self.inputField.font = [UIFont systemFontOfSize:13.f];
}

#pragma mark - Public

- (void)setupWithBehaviour:(FormBehaviour *)behaviour
           placeholderText:(NSString *)placeholderText
                 errorText:(NSString *)errorText
            characterLimit:(NSInteger)characterLimit
              keyboardType:(UIKeyboardType)keyboardType
             returnKeyType:(UIReturnKeyType)returnKeyType
                  isSecure:(BOOL)isSecure
                  delegate:(id<FormFieldDelegate>)delegate
{
    self.formBehaviour = behaviour;
    self.inputField.placeholder = placeholderText;
    self.errorLabel.text = errorText;
    self.characterLimit = characterLimit;
    self.inputField.keyboardType = keyboardType;
    self.inputField.returnKeyType = returnKeyType;
    self.delegate = delegate;
}

- (BOOL)validate {
    return [self checkValidityWithText:self.inputField.text];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // think this handled by pickers.
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self checkValidityWithText:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self checkValidityWithText:textField.text];
    [self.delegate formFieldDidReturnWithReturnKeyType:self.inputField.returnKeyType
                                                sender:self];
    
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    textField.text = self.formBehaviour.whileTypingStringBehaviour(textField.text);
    self.errorLabel.hidden = YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.characterLimit == 0) {
        return YES;
    }
    
    if(range.length + range.location > textField.text.length) {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= self.characterLimit;
}

#pragma mark - Helpers

- (BOOL)checkValidityWithText:(NSString *)text {
    self.isValid = self.formBehaviour.finishedTypingStringBehaviour(text);
    self.errorLabel.hidden = self.isValid;
    return self.isValid;
}

@end
