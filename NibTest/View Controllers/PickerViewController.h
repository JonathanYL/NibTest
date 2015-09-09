//
//  PickerViewController.h
//  NibTest
//
//  Created by Jonathan Yeung on 2015-08-20.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewControllerDelegate <NSObject>

/*
 * NOTE: the dictionary returned to the parent view controller
 *       will have an NSNumber as a key and an only 1 value as
 *       its return type.
 */

- (void)pickerViewControllerReturnedWithDictionary:(NSDictionary *)dictionary
                                            sender:(id)sender;

@end

@interface PickerViewController : UIViewController

@property (weak, nonatomic) id<PickerViewControllerDelegate> delegate;

/*
 * NOTE: the dictionary must have an NSNumber as a key
 *       from 0...n in ORDER and an array with anything
 *       in it as its value.
 *       key   : represents the column number
 *       value : represents an array which is what is going 
 *               to be displayed in the column
 */

+ (PickerViewController *)createPickerViewControllerWithDelegate:(UIViewController<PickerViewControllerDelegate> *)owner
                                                      dictionary:(NSDictionary *)dictionary;

/*
 * NOTE: the initial value dictionary sent to this method
 *       will have an NSNumber as a key and only 1 value
 *       indicating the initial value to start at for the
 *       column number.
 */

- (void)showPickerViewWithOwner:(UIViewController<PickerViewControllerDelegate> *)owner
                   initialValue:(NSDictionary *)initialValue;

@end
