//
//  XMCityPicker.h
//  CityPickerDemo
//
//  Created by hxm on 2017/4/27.
//  Copyright © 2017年 Justming. All rights reserved.
//
/*
 
 使用介绍：
    1.导入头文件
    #import "XMCityPicker.h"
 
    2.创建城市选择器
    XMCityPicker * picker; = [[XMCityPicker alloc] initWithFrame:CGRectMake(0, HEIGHT-200, WIDTH, 200)];
 
    3.参数设置
    背景颜色、字体颜色、字体大小、取消和确定按钮颜色
 
    4.设置代理
    picker.delegate = self;
 
    5.实现代理方法
    - (void)getProvince:(NSString *)province andCity:(NSString *)city andDistrict:(NSString *)district;
 
    
    GitHub地址：https://github.com/Justming/XMCityPicker.git
 
 
 */
#import <UIKit/UIKit.h>

@protocol XMCityPickerDelegate <NSObject>

/**
 获取选择的省市区(县)

 @param province 省
 @param city 市
 @param district 县区
 */
- (void)getProvince:(NSString *)province andCity:(NSString *)city andDistrict:(NSString *)district;

@end

@interface XMCityPicker : UIView

/**
 背景颜色，默认 whiteColor
 */
@property (nonatomic, strong) UIColor * backColor;

/**
 字体颜色，默认 blackColor
 */
@property (nonatomic, strong) UIColor * titleColor;

/**
 字体大小，默认 15
 */
@property (nonatomic, assign) CGFloat  fontSize;

/**
 取消按钮颜色，默认 grayColor
 */
@property (nonatomic, strong) UIColor * cancelColor;

/**
 确定按钮颜色，默认 redColor
 */
@property (nonatomic, strong) UIColor * confirmColor;


@property (nonatomic, weak) id <XMCityPickerDelegate> delegate;


@end
