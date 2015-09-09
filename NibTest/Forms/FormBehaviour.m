//
//  FormBehaviour.m
//  NibTest
//
//  Created by Jonathan Yeung on 2015-08-28.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import "FormBehaviour.h"

@implementation FormBehaviour

+ (FormBehaviour *)instanceWithWhileTypingStringBehaviour:(WhileTypingStringBlock)stringBehaviour {
    FormBehaviour *formBehaviourWhileTyping = [[FormBehaviour alloc] init];
    formBehaviourWhileTyping.whileTypingStringBehaviour = stringBehaviour;
    return formBehaviourWhileTyping;
}

+ (FormBehaviour *)instanceWithWhileTypingStringBehaviour:(WhileTypingStringBlock)whileTypingStringBehaviour
                            finishedTypingStringBehaviour:(FinishedTypingStringBlock)finishedTypingStringBehaviour {
    FormBehaviour *formBehaviour = [[FormBehaviour alloc] init];
    formBehaviour.whileTypingStringBehaviour = whileTypingStringBehaviour;
    formBehaviour.finishedTypingStringBehaviour = finishedTypingStringBehaviour;
    return formBehaviour;
}
@end
