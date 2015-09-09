//
//  CollapsibleTableViewCell.m
//  NibTest
//
//  Created by Jonathan Yeung on 2015-09-03.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import "CollapsibleTableViewCell.h"
#import "UIView+Fold.h"

@interface CollapsibleTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *titleContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation CollapsibleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentContainerView.backgroundColor = [UIColor blueColor];
    self.withDetails = NO;
    self.heightConstraint.constant = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setWithDetails:(BOOL)withDetails {
    _withDetails = withDetails;
    
    if (withDetails) {
        self.heightConstraint.priority = 250;
    } else {
        self.heightConstraint.priority = 999;
    }
}

@end
