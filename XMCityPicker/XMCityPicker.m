//
//  XMCityPicker.m
//  CityPickerDemo
//
//  Created by hxm on 2017/4/27.
//  Copyright © 2017年 Justming. All rights reserved.
//

#import "XMCityPicker.h"
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface XMCityPicker ()<UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation XMCityPicker
{
    UIPickerView * _pickerView;
    
    NSMutableArray * _provinces;
    NSMutableArray * _cities;
    NSMutableArray * _districts;
    
    NSInteger p;
    NSInteger c;
    NSInteger d;
    
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self addControlButton];
        [self initPickerView];
    }
    
    return self;
}

/**
 添加控制按钮
 */
- (void)addControlButton{
    UIToolbar * toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    [self addSubview:toolBar];
    
    UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    cancelItem.tintColor = self.cancelColor;
    UIBarButtonItem * confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
    confirmItem.tintColor = self.confirmColor;
    
    UIBarButtonItem * flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray * itemArray = @[cancelItem, flexItem, confirmItem];
    [toolBar setItems:itemArray];
}

/**
 创建pickerView
 */
- (void)initPickerView{
    
    _provinces = [NSMutableArray new];
    _cities = [NSMutableArray new];
    _districts = [NSMutableArray new];
    [self getDataSource];
    
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, self.bounds.size.width, self.bounds.size.height-40)];
    _pickerView.backgroundColor = self.backColor;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self addSubview:_pickerView];
    
}

#pragma mark - 确定/取消
- (void)cancel{
    
    [self removeFromSuperview];
    
}
- (void)confirm{
    
    [self.delegate getProvince:_provinces[p] andCity:_cities[p][c] andDistrict:_districts[p][c][d]];
    [self cancel];
}

#pragma mark - 从plist文件获取数据源
- (void)getDataSource{
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil];
    NSArray * array = [NSArray arrayWithContentsOfFile:path];
    
    for (int i=0; i<array.count; i++) {
        
        //获取省列表
        NSDictionary * provinceDic = array[i];
        [_provinces addObject:provinceDic.allKeys[0]];  //省OK
        
        //所有市列表
        NSArray * citiesArray = provinceDic.allValues[0];
        
        NSMutableArray * cityArray = [NSMutableArray new];     //存放某个省的所有市名称
        NSMutableArray * districtsArray = [NSMutableArray new];
        for (int j=0; j<citiesArray.count; j++) {
            //某一个市 获取市名称
            NSDictionary * cityDic = citiesArray[j];
            NSString * cityKey = cityDic.allKeys[0];
            [cityArray addObject:cityKey];              //市OK
            
            //获取某个市下的所有区
            NSArray * districtArray = cityDic[cityKey];
            [districtsArray addObject:districtArray];       //区OK
        }
        [_cities addObject:cityArray];
        [_districts addObject:districtsArray];
    }
}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return _provinces.count;
    }
    if (component == 1) {
        return [_cities[p] count];
    }
    if (component == 2) {
        return [_districts[p][c] count];
    }
    return 0;
}


#pragma mark -  UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    
    return WIDTH / 3.0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 40.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH/3, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = self.titleColor;
    label.font = [UIFont systemFontOfSize:self.fontSize];
    
    if (component == 0) {
        label.text = _provinces[row];
    }
    if (component == 1) {
        label.text = _cities[p][row];
    }
    if (component == 2) {
        label.text = _districts[p][c][row];
    }
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        p = row;
        c = 0;
        d = 0;
        [pickerView reloadAllComponents];
    }
    if (component == 1) {
        c = row;
        d = 0;
        [pickerView reloadComponent:2];
    }
    if (component == 2) {
        d = row;
    }
    
}

#pragma mark - getter
- (UIColor *)backColor {
    if (!_backColor) {
        return [UIColor whiteColor];
    }
    return _backColor;
}

- (UIColor *)titleColor {
    if (!_titleColor) {
        return [UIColor blackColor];
    }
    return _titleColor;
}
- (CGFloat)fontSize {
    if (!_fontSize || _fontSize == 0) {
        return 15;
    }
    return _fontSize;
}
- (UIColor *)cancelColor {
    if (!_cancelColor) {
        return [UIColor grayColor];
    }
    return _cancelColor;
}
- (UIColor *)confirmColor {
    if (!_confirmColor) {
        return [UIColor redColor];
    }
    return _confirmColor;
}

@end
