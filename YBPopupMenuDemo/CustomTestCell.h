//
//  CustomTestCell.h
//  YBPopupMenuDemo
//
//  Created by lyb on 2017/12/20.
//  Copyright © 2017年 LYB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *badge;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
