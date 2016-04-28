//
//  LCityPickerView.h
//  cityPicker
//
//  Created by tih on 16/3/25.
//  Copyright © 2016年 TOSHIBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCityPickerView : UIView

typedef void (^LCityPickerViewBlock)(NSString *province,NSString *city,NSString *area);

@property (nonatomic,copy) LCityPickerViewBlock didPicker;
/**
 *  初始化
 *
 *  @param num       多少列数据（两列为省市，三列为省市区）
 *  @param didPicker 回调数据
 *
 *  @return 初始化返回自己
 */
-(instancetype)initWithNumOfList:(NSInteger)num AndAfterPickerBlock:(LCityPickerViewBlock)didPicker;


/**
 *  出现
 *
 *  @param superView 显示在哪个View，一般为viewController的self.view
 */
-(void)showInView:(UIView*)superView;



/**
 *  隐藏
 */
-(void)hidePickerView;
@end
