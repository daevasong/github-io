//
//  ViewController.m
//  自定义PickerView
//
//  Created by QingzhouSong on 16/7/28.
//  Copyright © 2016年 宋青洲. All rights reserved.
//

#import "ViewController.h"
#import "QZPickerView.h"
@interface ViewController ()
{
    QZPickerView *ycPickerView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arrData = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
    
    ycPickerView = [[QZPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    ycPickerView.arrPickerData = arrData;
    [ycPickerView.pickerView selectRow:3 inComponent:0 animated:YES]; //pickerview默认选中行
    [self.view addSubview:ycPickerView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 35)];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"测试PickerView" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    __block ViewController *blockSelf = self;
    ycPickerView.selectBlock = ^(NSString *str){
        if (str.length > 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:str preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancelAction];
            [alert addAction:okAction];
            [blockSelf presentViewController:alert animated:YES completion:nil];
        }
    };
}



- (void)btnTest:(id)sender
{
    [ycPickerView popPickerView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
