//
//  ViewController.m
//  YBPopupMenuDemo
//
//  Created by LYB on 16/11/8.
//  Copyright © 2016年 LYB. All rights reserved.
//

#import "ViewController.h"
#import "YBPopupMenu.h"
#import "CustomTestCell.h"

#define TITLES @[@"修改", @"删除", @"扫一扫",@"付款"]
#define ICONS  @[@"motify",@"delete",@"saoyisao",@"pay"]
@interface ViewController ()<YBPopupMenuDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *customCellView;

@property (nonatomic, strong) YBPopupMenu *popupMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onPopupClick:(UIButton *)sender {
    [YBPopupMenu showRelyOnView:sender titles:TITLES icons:ICONS menuWidth:120 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.delegate = self;
    }];
}

- (IBAction)onTestClick:(UIButton *)sender {
    [YBPopupMenu showRelyOnView:sender titles:@[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888"] icons:nil menuWidth:100 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.priorityDirection = YBPopupMenuPriorityDirectionLeft;
        popupMenu.borderWidth = 1;
        popupMenu.borderColor = [UIColor redColor];
        popupMenu.arrowPosition = 22;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: self.view];
    
    if (CGRectContainsPoint(self.customCellView.frame, p)) {
        [self showCustomPopupMenuWithPoint:p];
    }else {
        [self showDarkPopupMenuWithPoint:p];
    }
}

- (void)showDarkPopupMenuWithPoint:(CGPoint)point
{
    [YBPopupMenu showAtPoint:point titles:TITLES icons:nil menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.dismissOnSelected = NO;
        popupMenu.isShowShadow = YES;
        popupMenu.delegate = self;
        popupMenu.offset = 10;
        popupMenu.type = YBPopupMenuTypeDark;
        popupMenu.animationManager.style = YBPopupMenuAnimationStyleNone;
        popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }];
}

- (void)showCustomPopupMenuWithPoint:(CGPoint)point
{
    [YBPopupMenu showAtPoint:point titles:TITLES icons:nil menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.dismissOnSelected = YES;
        popupMenu.isShowShadow = YES;
        popupMenu.delegate = self;
        popupMenu.type = YBPopupMenuTypeDefault;
        popupMenu.cornerRadius = 8;
        popupMenu.rectCorner = UIRectCornerTopLeft| UIRectCornerTopRight;
        popupMenu.tag = 100;
        //如果不加这句默认是 UITableViewCellSeparatorStyleNone 的
        popupMenu.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }];
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    //推荐回调
    NSLog(@"点击了 %@ 选项",ybPopupMenu.titles[index]);
}

- (void)ybPopupMenuBeganDismiss:(YBPopupMenu *)ybPopupMenu
{
    if (self.textField.isFirstResponder) {
        [self.textField resignFirstResponder];
    }
}

- (UITableViewCell *)ybPopupMenu:(YBPopupMenu *)ybPopupMenu cellForRowAtIndex:(NSInteger)index
{
    if (ybPopupMenu.tag != 100) {
        return nil;
    }
    static NSString * identifier = @"customCell";
    CustomTestCell * cell = [ybPopupMenu.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomTestCell" owner:self options:nil] firstObject];
    }
    
    cell.titleLabel.text = TITLES[index];
    cell.iconImageView.image = [UIImage imageNamed:ICONS[index]];
    
    switch (index) {
        case 0:
            cell.statusLabel.hidden = NO;
            cell.badge.hidden = YES;
            break;
        case 2:
            cell.statusLabel.hidden = YES;
            cell.badge.hidden = NO;
            break;
        default:
            cell.statusLabel.hidden = YES;
            cell.badge.hidden = YES;
            break;
    }
    
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _popupMenu = [YBPopupMenu showRelyOnView:textField titles:@[@"密码必须为数字、大写字母、小写字母和特殊字符中至少三种的组合，长度不少于8且不大于20"] icons:nil menuWidth:textField.bounds.size.width otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.delegate = self;
        popupMenu.showMaskView = NO;
        popupMenu.priorityDirection = YBPopupMenuPriorityDirectionBottom;
        popupMenu.maxVisibleCount = 1;
        popupMenu.itemHeight = 60;
        popupMenu.borderWidth = 1;
        popupMenu.fontSize = 12;
        popupMenu.dismissOnTouchOutside = YES;
        popupMenu.dismissOnSelected = NO;
        popupMenu.borderColor = [UIColor brownColor];
        popupMenu.textColor = [UIColor brownColor];
        popupMenu.animationManager.style = YBPopupMenuAnimationStyleFade;
        popupMenu.animationManager.duration = 0.15;
    }];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_popupMenu dismiss];
    return YES;
}

@end
