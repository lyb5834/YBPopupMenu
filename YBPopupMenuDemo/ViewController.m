//
//  ViewController.m
//  YBPopupMenuDemo
//
//  Created by LYB on 16/11/8.
//  Copyright © 2016年 LYB. All rights reserved.
//

#import "ViewController.h"
#import "YBPopupMenu.h"

#define TITLES @[@"修改", @"删除", @"扫一扫",@"付款"]
#define ICONS  @[@"motify",@"delete",@"saoyisao",@"pay"]
@interface ViewController ()<YBPopupMenuDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, strong) YBPopupMenu *popupMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onPopupClick:(UIButton *)sender {
    [YBPopupMenu showRelyOnView:sender titles:TITLES icons:ICONS menuWidth:120 delegate:self];
}

- (IBAction)onTestClick:(UIButton *)sender {
    [YBPopupMenu showRelyOnView:sender titles:@[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888"] icons:nil menuWidth:100 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.priorityDirection = YBPopupMenuPriorityDirectionLeft;
        popupMenu.borderWidth = 1;
        popupMenu.borderColor = [UIColor redColor];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: self.view];
    
    //推荐用这种写法
    [YBPopupMenu showAtPoint:p titles:TITLES icons:nil menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.dismissOnSelected = NO;
        popupMenu.isShowShadow = YES;
        popupMenu.delegate = self;
        popupMenu.offset = 10;
        popupMenu.type = YBPopupMenuTypeDark;
        popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }];
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    NSLog(@"点击了 %@ 选项",TITLES[index]);
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
        popupMenu.dismissOnTouchOutside = NO;
        popupMenu.dismissOnSelected = NO;
        popupMenu.borderColor = [UIColor brownColor];
        popupMenu.textColor = [UIColor brownColor];
    }];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [_popupMenu dismiss];
    return YES;
}

@end
