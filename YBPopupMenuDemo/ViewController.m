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
@interface ViewController ()<YBPopupMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onPopupClick:(UIButton *)sender {
    [YBPopupMenu showRelyOnView:sender titles:TITLES icons:ICONS menuWidth:120 delegate:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: self.view];
    
    YBPopupMenu *popupMenu = [YBPopupMenu showAtPoint:p titles:TITLES icons:nil menuWidth:110 delegate:nil];
    popupMenu.dismissOnSelected = NO;
    popupMenu.isShowShadow = YES;
    popupMenu.delegate = self;
    popupMenu.offset = 10;
    popupMenu.type = YBPopupMenuTypeDark;
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    NSLog(@"点击了 %@ 选项",TITLES[index]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
