//
//  FirstViewController.m
//  NibTest
//
//  Created by Jonathan Yeung on 2015-08-17.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import "FirstViewController.h"
#import "ButtonView.h"
#import "UIView+LayoutConstraints.h"
#import "UIView+NibHelpers.h"
#import "NibLoader.h"
#import "SecondViewController.h"
#import "PickerViewController.h"

@interface FirstViewController () <ButtonViewDelegate, PickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet ButtonView *leftView;
@property (weak, nonatomic) IBOutlet ButtonView *rightView;
@property (weak, nonatomic) IBOutlet ButtonView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *bottomRightView;

@property (weak, nonatomic) IBOutlet ButtonView *containerView;

@property (nonatomic, strong) PickerViewController *pickerViewController;
@property (nonatomic, strong) PickerViewController *pickerViewControllerTwo;

@property (nonatomic, strong) NSDictionary *resultsDictionary;
@property (nonatomic, strong) NSDictionary *resultsDictionaryTwo;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupPickerVc];
    
    self.leftView.view.backgroundColor = [UIColor greenColor];
    self.leftView.delegate = self;
    
    self.rightView.view.backgroundColor = [UIColor blueColor];
    self.rightView.delegate = self;
    
    self.bottomView.view.backgroundColor = [UIColor redColor];
    self.bottomView.delegate = self;
}

#pragma mark - Setup

- (void)setupPickerVc
{
    NSDictionary *dictionary = @{ @(0) : @[@"0", @"1", @"2", @"3", @"4", @"5"]};
    self.pickerViewController = [PickerViewController createPickerViewControllerWithDelegate:self dictionary:dictionary];
    self.pickerViewControllerTwo = [PickerViewController createPickerViewControllerWithDelegate:self dictionary:dictionary];
}

#pragma mark - ButtonViewDelegate

- (void)topButtonTapped:(id)sender
{
    if (sender == self.leftView) {
        
    } else if (sender == self.rightView) {
        
    }
    [self.pickerViewController showPickerViewWithOwner:self
                                          initialValue:@{ @(0) : @"4" }];
}

- (void)bottomButtonTapped
{
    SecondViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SecondViewController class])];
//    BooksViewController *secondViewController = [[BooksViewController alloc] init];
    [self.navigationController pushViewController:secondViewController animated:YES];
    NSLog(@"bottom button tapped");
    
}

#pragma mark - PickerViewControllerDelegate

- (void)pickerViewControllerReturnedWithDictionary:(NSDictionary *)dictionary sender:(id)sender {
    
}

@end
