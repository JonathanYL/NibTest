//
//  FormBehaviour.h
//  NibTest
//
//  Created by Jonathan Yeung on 2015-08-28.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString *(^WhileTypingStringBlock)(NSString *string);
typedef BOOL (^FinishedTypingStringBlock)(NSString *string);

@interface FormBehaviour : NSObject

@property (nonatomic, strong) WhileTypingStringBlock whileTypingStringBehaviour;
@property (nonatomic, strong) FinishedTypingStringBlock finishedTypingStringBehaviour;

+ (FormBehaviour *)instanceWithWhileTypingStringBehaviour:(WhileTypingStringBlock)whileTypingStringBehaviour
                            finishedTypingStringBehaviour:(FinishedTypingStringBlock)finishedTypingStringBehaviour;

@end
