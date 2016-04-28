//
//  LCityPickerView.m
//  cityPicker
//
//  Created by tih on 16/3/25.
//  Copyright © 2016年 TOSHIBA. All rights reserved.
//
#import "LCityPickerView.h"
@interface LCityPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic) UIView *backBlurView;
@property (nonatomic) UIPickerView *pickerView;
@property (nonatomic) NSLayoutConstraint *constraints3;

@property (nonatomic,assign)NSInteger numOfList;
//省
@property (strong, nonatomic) NSArray *provinceArr;
//市
@property (strong, nonatomic) NSArray *cityArr;
//县
@property (strong, nonatomic) NSArray *areaArr;

@property (nonatomic,copy)NSString *nowRegion;
@property (nonatomic,copy)NSString *nowProvince;
@property (nonatomic,copy)NSString *nowCity;
@property (nonatomic,copy)NSString *nowArea;
@end

@implementation LCityPickerView

-(instancetype)initWithNumOfList:(NSInteger)num AndAfterPickerBlock:(LCityPickerViewBlock)didPicker{
    if (self = [super init]) {
        
        self.numOfList = num>=3? 3:2;
        self.didPicker = didPicker;
        [self creatBackBlurView];
        
        self.pickerView = [[UIPickerView alloc]init];
        self.pickerView.backgroundColor = [UIColor whiteColor];
        self.pickerView.delegate =self;
        self.pickerView.dataSource = self;
        [self addSubview:self.pickerView];
        self.provinceArr = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]]  ;

        self.cityArr = self.provinceArr[0][@"cities"];
        self.areaArr = self.cityArr[0][@"areas"];
        self.nowProvince = self.provinceArr[0][@"state"];

        NSArray *constraints1 = [NSLayoutConstraint
                                 constraintsWithVisualFormat:@"H:|-0-[_pickerView]-0-|"
                                 options:0
                                 metrics:nil
                                 views:NSDictionaryOfVariableBindings(_pickerView)];
        NSLayoutConstraint *constraints2 = [NSLayoutConstraint
                                            constraintWithItem:self.pickerView
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self
                                            attribute:NSLayoutAttributeBottom
                                            multiplier:1.0
                                            constant:0];
        constraints2.priority = UILayoutPriorityDefaultHigh;
        NSLayoutConstraint *constraints3 = [NSLayoutConstraint
                                            constraintWithItem:self.pickerView
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self
                                            attribute:NSLayoutAttributeHeight
                                            multiplier:0.4
                                            constant:0];
        self.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint :constraints3];
        [self addConstraints:constraints1];
        [self addConstraint:constraints2];
        self.translatesAutoresizingMaskIntoConstraints=NO;


    }

    return self;
}
-(void)creatBackBlurView{
 
    UIView *backView = [[UIView alloc]init];
    backView.translatesAutoresizingMaskIntoConstraints = NO;
    backView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    
    [self addSubview:backView];

    NSArray *constraints1 = [NSLayoutConstraint
                             constraintsWithVisualFormat:@"H:|-0-[backView]-0-|"
                             options:0
                             metrics:nil
                             views:NSDictionaryOfVariableBindings(backView)];
    NSArray *constraints2 = [NSLayoutConstraint
                             constraintsWithVisualFormat:@"V:|-0-[backView]-0-|"
                             options:0
                             metrics:nil
                             views:NSDictionaryOfVariableBindings(backView)];
    [self addConstraints:constraints1];
    [self addConstraints:constraints2];
    UISwipeGestureRecognizer * down = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hidePickerView)];
    down.direction = UISwipeGestureRecognizerDirectionDown;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePickerView)];
    [backView addGestureRecognizer:tap];
    
    
}
-(void)layoutSubviews{
    NSLog(@"%@",NSStringFromCGRect(self.bounds));

}
-(void)showInView:(UIView *)superView{
    
    [superView addSubview:self];

    NSArray *layout4self1 = [NSLayoutConstraint
                             constraintsWithVisualFormat:@"H:|-0-[self]-0-|"
                             options:0
                             metrics:nil
                             views:NSDictionaryOfVariableBindings(self)];
    NSLayoutConstraint *layout4self2 = [NSLayoutConstraint
                                        constraintWithItem:self
                                        attribute:NSLayoutAttributeHeight
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:superView
                                        attribute:NSLayoutAttributeHeight
                                        multiplier:1.0
                                        constant:0];
    NSLayoutConstraint* _layout4self4 = [NSLayoutConstraint
                                            constraintWithItem:self
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:superView
                                            attribute:NSLayoutAttributeTop
                                            multiplier:1.0
                                            constant:0];
    _layout4self4.priority = UILayoutPriorityDefaultHigh-1;
    [superView addConstraints:layout4self1];

    [superView addConstraint:layout4self2];

    
    [superView addConstraint:_layout4self4];
    

    NSLayoutConstraint *constraints3 = [NSLayoutConstraint
                                        constraintWithItem:self.pickerView
                                        attribute:NSLayoutAttributeBottom
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:0];
    constraints3.priority = UILayoutPriorityDefaultHigh-1;
    [self addConstraint:constraints3];

    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        constraints3.priority = UILayoutPriorityDefaultHigh+1;
        [self layoutIfNeeded];
    }];

}
-(void)hidePickerView{
    if (self.superview) {
        [self layoutIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
            _constraints3.priority = UILayoutPriorityDefaultHigh-1;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];

    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (_numOfList==2) {
        switch (component) {
            case 0:
                return self.provinceArr[row][@"state"];
                break;
            case 1:
                return self.cityArr[row][@"city"];
                break;
                
            default:
                break;
        }
    }
        if (_numOfList==3) {
            switch (component) {
                case 0:
                    return self.provinceArr[row][@"state"];
                    break;
                case 1:
                    return self.cityArr[row][@"city"];
                    break;
                case 2:
                    return self.areaArr[row];
                    break;
                    
                default:
                    break;
            }
        }
        return @"";
    
}

    
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (_numOfList==2) {
        switch (component) {
            case 0:
                self.nowProvince = self.provinceArr[row][@"state"];
                self.cityArr = self.provinceArr[row][@"cities"];
                [pickerView reloadComponent:1];
                if (_cityArr.count>0) {
                    self.nowCity = self.cityArr[0][@"city"];
                }
                [pickerView selectRow:0 inComponent:1 animated:NO];
                
                break;
            case 1:
                self.nowCity = self.cityArr[row][@"city"];
                break;
                
            default:
                break;
        }
        if (self.didPicker) {
            self.didPicker(self.nowProvince,self.nowCity,nil);
            
        }
    }
    if (_numOfList==3) {
        switch (component) {
            case 0:
                self.nowProvince = self.provinceArr[row][@"state"];
                self.cityArr = self.provinceArr[row][@"cities"];
                [pickerView reloadComponent:1];
                if (_cityArr.count>0) {
                    self.nowCity = self.cityArr[0][@"city"];
                }
                [pickerView selectRow:0 inComponent:1 animated:NO];
                
                self.areaArr = self.cityArr[0][@"areas"];
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:NO];
                if (_areaArr.count>0) {
                    self.nowArea = self.areaArr[0];
                }else{
                    self.nowArea = @"";
                }
                break;
            case 1:
                self.nowCity = self.cityArr[row][@"city"];
                self.areaArr = self.cityArr[row][@"areas"];
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:NO];
                if (_areaArr.count>0) {
                    self.nowArea = self.areaArr[0];
                }
                break;
            case 2:
                    self.nowArea = self.areaArr.count>0?self.areaArr[row]:@"";
                break;
            default:
                break;
        }
        
        self.didPicker(self.nowProvince,self.nowCity,self.nowArea);
    }
    
}
/*
 
     __    ____      __
    / /   / __ \    / /
   / /   / / / /   / /
  / /___/ /_/ /\__/ /
 /_____/____,/\___ /
 
 
 
 */


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_numOfList==2) {
        switch (component) {
            case 0:
                return self.provinceArr.count;
                break;
            case 1:
                return self.cityArr.count;
                break;
                
            default:
                break;
        }
    }
    if (_numOfList==3) {
        switch (component) {
            case 0:
                return self.provinceArr.count;
                break;
            case 1:
                return self.cityArr.count;
                break;
            case 2:
                if (_areaArr==nil) {
                    return 0;
                }
                return self.areaArr.count;
                
                break;
                
            default:
                break;
        }
    }
        return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _numOfList;
}





@end
