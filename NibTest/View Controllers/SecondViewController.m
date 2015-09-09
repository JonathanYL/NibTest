//
//  SecondViewController.m
//  NibTest
//
//  Created by Jonathan Yeung on 2015-08-28.
//  Copyright (c) 2015 Jonathan Yeung. All rights reserved.
//

#import "SecondViewController.h"

#import "FormField.h"
#import "FormFactory.h"
#import "CollapsibleTableViewCell.h"
#import "PartnerModel.h"

@interface SecondViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableSet *expandedIndexPaths;
@property (nonatomic, strong) NSArray *partnerModels;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPartnerModels];
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([CollapsibleTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"cell"];
    self.expandedIndexPaths = [NSMutableSet set];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.f;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = @"Foldable UITableViewCells";
}

#pragma mark - Setup

- (void)createPartnerModels {
    PartnerModel *partnerModel1 = [[PartnerModel alloc] initWithImage:[UIImage imageNamed:@"aeroplan"] title:@"Aeroplan Promo" descriptionText:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."];
    PartnerModel *partnerModel2 = [[PartnerModel alloc] initWithImage:[UIImage imageNamed:@"td"] title:@"TD Canada Trust" descriptionText:@"Ut enim ad minim veniam"];
    self.partnerModels = @[partnerModel1, partnerModel2];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([self.expandedIndexPaths containsObject:indexPath]) {
        [self.expandedIndexPaths removeObject:indexPath];
         [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        [self.expandedIndexPaths addObject:indexPath];
         [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.partnerModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollapsibleTableViewCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    PartnerModel *partnerModel = self.partnerModels[indexPath.row];
    cell.titleLabel.text = partnerModel.title;
    cell.contentLabel.text = @"nventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.";
    cell.partnerImageView.image = partnerModel.iconImage;
    cell.descriptionLabel.text = partnerModel.descriptionText;
    cell.withDetails = [self.expandedIndexPaths containsObject:indexPath];
    [cell.contentView layoutIfNeeded];
    return cell;
}

@end
