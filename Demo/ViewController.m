//
//  ViewController.m
//  Demo
//
//  Created by yfc on 17/5/17.
//  Copyright © 2017年 yfc. All rights reserved.
//

#import "ViewController.h"
#import "BlockDynamicPasswordButton.h"
#import "BlockPickerView.h"
#import "config.h"
#import "BlockDatePickerView.h"
@interface ViewController ()
{
    BlockPickerView * pickerView;
    BlockDatePickerView *datePickerView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //
    //1.封装动态密码按钮
    //参数说明：MaxTouchDownNum：最多能点击的次数  TimeInterval：多少秒后才可以点 ClickedAction：点击按钮的响应事件
    //
    BlockDynamicPasswordButton *_dynamicButton = [[BlockDynamicPasswordButton alloc]initWithFrame:CGRectMake(80, 80, 80, 30) andMaxTouchDownNum:15 andTimeInterval:10 andClickedAction:^(int touchUpNum) {
        NSLog(@"提交页面获取到的点击次数%d",touchUpNum);
    }];
    _dynamicButton.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_dynamicButton];
    _dynamicButton.centerX = SCREEN_WIDTH_NEW/2;

    //
    //2.按钮调用封装的UIPickerView
    //
    //
    UIButton *pickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pickerButton addTarget:self action:@selector(pickerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [pickerButton setTitle:@"按钮调用封装的UIPickerView" forState:UIControlStateNormal];
    [pickerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    pickerButton.frame = CGRectMake(0, 200, SCREEN_WIDTH_NEW, 34);
    [self.view addSubview:pickerButton];

    //
    //3.textFiled调用封装的DatePickerView
    //
    //
    UIButton *dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateButton addTarget:self action:@selector(dateTextFiledAction:) forControlEvents:UIControlEventTouchUpInside];
    [dateButton setTitle:@"调用封装的datePickerView" forState:UIControlStateNormal];
    [dateButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    dateButton.frame = CGRectMake(0, 260, SCREEN_WIDTH_NEW, 34);
    [self.view addSubview:dateButton];

}

- (void)pickerButtonAction:(UIButton *)btn{
    //
    //说明：数据源是一个字典 key是@"array" ，value是一个数组，数组里是多个字典（必须有一个key是@"valueForShow"，用作展示）
    //
    if (!pickerView) {
        pickerView = [[BlockPickerView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT_NEW,SCREEN_WIDTH_NEW,225) doneAction:^(id result) {
            NSLog(@"选中的是%@",result);
        }];
        NSDictionary *dicc = @{@"array":@[@{@"valueForShow":@"111"},
                                          @{@"valueForShow":@"222"}]};
        [pickerView setDataSource:dicc];
    }
    [pickerView show];

}

- (void)dateTextFiledAction:(UIButton *)btn{
    if (!datePickerView) {
        datePickerView = [[BlockDatePickerView alloc]initWithFrame:CGRectMake(0,APPLICATION.window.height,SCREEN_WIDTH_NEW,225)];
        
        [datePickerView setDoneAction:^(id result) {
            NSLog(@"选中的是%@",result);
        }];
    }

    [datePickerView show];

}


@end
