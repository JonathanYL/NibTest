//
//  PickerViewController.m
//  NibTest
//
//  Created by Jonathan Yeung on 2015-08-20.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import "PickerViewController.h"
#import "UIView+LayoutConstraints.h"

@interface PickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSDictionary *pickerDictionary;
@property (strong, nonatomic) NSMutableDictionary *resultsDictionary;

@property (weak, nonatomic) IBOutlet UIView *windowedView;
@property (weak, nonatomic) IBOutlet UIView *pickerContainerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerViewBottomConstraint;

@end

@implementation PickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self pickerView] setDelegate:self];
    self.resultsDictionary = [NSMutableDictionary new];
}

#pragma mark - Helpers

- (BOOL)dictionaryIsValid:(NSDictionary *)dictionary
{
    for (id key in dictionary) {
        if (![key isKindOfClass:[NSNumber class]] && ![[dictionary objectForKey:key] isKindOfClass:[NSArray class]]) {
            return NO;
        }
    }
    return YES;
}

- (NSInteger)indexOfValue:(id)value forKey:(NSNumber *)key
{
    NSArray *values = self.pickerDictionary[key];
    for (NSInteger i=0;i<values.count;i++) {
        if ([value isEqual:values[i]]) {
            return i;
        }
    }
    return NSNotFound;
}

- (void)updateResultDictionaryWithValue:(NSNumber *)value forKey:(NSNumber *)key
{
    [self.resultsDictionary setObject:value forKey:key];
}

#pragma mark - IBActions

- (IBAction)doneButtonTapped:(id)sender {
    [self.delegate pickerViewControllerReturnedWithDictionary:self.resultsDictionary sender:self];
    [self hidePickerViewWithAnimationCompletion:^{
        [self.view removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [[self.pickerDictionary allKeys] count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerDictionary[@(component)] count];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *arrayColumn = self.pickerDictionary[@(component)];
    return (NSString *)arrayColumn[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSArray *arrayColumn = self.pickerDictionary[@(component)];
    [self updateResultDictionaryWithValue:arrayColumn[row] forKey:@(component)];
}

#pragma mark - Public

+ (PickerViewController *)createPickerViewControllerWithDelegate:(UIViewController<PickerViewControllerDelegate> *)owner
                                                      dictionary:(NSDictionary *)dictionary
{
    PickerViewController *pickerViewController = [[PickerViewController alloc] initWithNibName:NSStringFromClass([PickerViewController class]) bundle:nil];
    pickerViewController.delegate = owner;
    pickerViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [pickerViewController setPickerDictionary:dictionary];
    [owner addChildViewController:pickerViewController];
    [pickerViewController didMoveToParentViewController:owner];
    return pickerViewController;
}

- (void)showPickerViewWithOwner:(UIViewController<PickerViewControllerDelegate> *)owner
                   initialValue:(NSDictionary *)initialValue
{
    [owner.view addSubview:self.view];
    [owner.view constrainChildViewToLeftTopRightBottom:self.view];
    [self setInitialValue:initialValue];
    self.pickerViewBottomConstraint.constant = 0;
    [self showPickerViewWithAnimationCompletion:nil];
}

#pragma mark - Private

- (void)showPickerViewWithAnimationCompletion:(void (^)())completion
{
    self.pickerViewBottomConstraint.constant = 0;
    [UIView animateWithDuration:0.4 animations:^{
        self.windowedView.alpha = 0.3;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)hidePickerViewWithAnimationCompletion:(void (^)())completion
{
    self.pickerViewBottomConstraint.constant = -self.pickerViewHeightConstraint.constant;
    [UIView animateWithDuration:0.4 animations:^{
        self.windowedView.alpha = 0.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)setPickerDictionary:(NSDictionary *)pickerDictionary
{
    if ([self dictionaryIsValid:pickerDictionary]) {
        _pickerDictionary = pickerDictionary;
        [self.pickerView reloadAllComponents];
    }
}

- (void)setInitialValue:(NSDictionary *)initialValue
{
    NSArray *keys = [initialValue allKeys];
    for (NSNumber *key in keys) {
        NSInteger selectedIndex = [self indexOfValue:initialValue[key] forKey:key];
        if (selectedIndex != NSNotFound) {
            [self.resultsDictionary addEntriesFromDictionary:initialValue];
            [self.pickerView selectRow:selectedIndex inComponent:[key integerValue] animated:YES];
        }
    }
}

@end
