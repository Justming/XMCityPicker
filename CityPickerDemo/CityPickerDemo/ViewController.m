//
//  ViewController.m
//  CityPickerDemo
//
//  Created by hxm on 2017/4/27.
//  Copyright © 2017年 Justming. All rights reserved.
//

#import "ViewController.h"
#import "XMCityPicker.h"

#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()<XMCityPickerDelegate>

@end
@implementation ViewController
{
    XMCityPicker * _picker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCityPicker];
}

- (void)addCityPicker{
    
    _picker = [[XMCityPicker alloc] initWithFrame:CGRectMake(0, HEIGHT-200, WIDTH, 200)];
    _picker.delegate = self;
    [self.view addSubview:_picker];
}


/**
 获取省市区代理方法
 */
- (void)getProvince:(NSString *)province andCity:(NSString *)city andDistrict:(NSString *)district{
    
    NSLog(@"%@--%@--%@", province, city, district);
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (!_picker.superview) {
        [self addCityPicker];
    }
    
    
}
@end
