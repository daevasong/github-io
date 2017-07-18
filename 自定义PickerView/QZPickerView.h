//
//  QZPickerView.h
//  自定义PickerView
//
//  Created by QingzhouSong on 16/7/28.
//  Copyright © 2016年 宋青洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QZPickerView : UIView

typedef void (^MyBasicBlock)(id result);

@property (retain, nonatomic) NSArray *arrPickerData;
@property (retain, nonatomic) UIPickerView *pickerView;

@property (nonatomic, copy) MyBasicBlock selectBlock;

- (void)popPickerView;
@end
