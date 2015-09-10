//
//  CollapsibleTableViewCell.h
//  NibTest
//
//  Created by Jonathan Yeung on 2015-09-03.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollapsibleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *partnerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *contentContainerView;

@property (weak, nonatomic) IBOutlet UILabel *contentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;


@property (nonatomic, assign) BOOL withDetails;


@end
