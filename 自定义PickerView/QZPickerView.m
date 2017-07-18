//
//  QZPickerView.m
//  自定义PickerView
//
//  Created by QingzhouSong on 16/7/28.
//  Copyright © 2016年 宋青洲. All rights reserved.
//

#import "QZPickerView.h"

#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define PICKERVIEW_HEIGHT           256


#import "QZPickerView.h"

@interface QZPickerView () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger selectRow;
}

@property (retain, nonatomic) UIView *baseView;

@end

@implementation QZPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-PICKERVIEW_HEIGHT, SCREEN_WIDTH, PICKERVIEW_HEIGHT)];
        _baseView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_baseView];
        
        UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 0, 40, 40)];
        [btnOK setTitle:@"确定" forState:UIControlStateNormal];
        [btnOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnOK addTarget:self action:@selector(pickerViewBtnOK:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:btnOK];
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(pickerViewBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:btnCancel];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, PICKERVIEW_HEIGHT-40)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [_baseView addSubview:_pickerView];
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPickerView)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

#pragma mark - UIPickerViewDataSource

//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//每列对应多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arrPickerData.count;
}

//每行显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _arrPickerData[row];
}


#pragma mark - UIPickerViewDelegate

//选中pickerView的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectRow = row;
}

#pragma mark - Private Menthods

//弹出pickerView
- (void)popPickerView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }];
    
}

//取消pickerView
- (void)dismissPickerView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }];
}

//确定
- (void)pickerViewBtnOK:(id)sender
{
    if (self.selectBlock) {
        self.selectBlock(_arrPickerData[selectRow]);
    }
    [self dismissPickerView];
}

//取消
- (void)pickerViewBtnCancel:(id)sender
{
    if (self.selectBlock) {
        self.selectBlock(nil);
    }
    
    [self dismissPickerView];
    
}

- (void)drawRect:(CGRect)rect

{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect currentBounds = self.bounds;
    
    CGGradientRef backgroundGradient;
    
    size_t num_locations = 2;
    
    CGFloat locations[2] = { 0.0, 1.0 };
    
    CGFloat components[8] = { 0.0, 0.0, 0.0, 0.0, // Start color
        
        0.0, 0.0, 0.0, 0.6
        
    }; // End color
    
    CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
    
    backgroundGradient = CGGradientCreateWithColorComponents (rgbColorspace, components, locations, num_locations);
    
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds));
    
    CGContextDrawRadialGradient (context, backgroundGradient, centerPoint, 0.0, centerPoint, currentBounds.size.width, kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(backgroundGradient);
    
}
@end
