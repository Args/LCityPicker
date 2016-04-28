//
//  ViewController.m
//  LCityPicker
//
//  Created by tih on 16/4/28.
//  Copyright © 2016年 TOSHIBA. All rights reserved.
//

#import "LCityPickerView.h"
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (retain,nonatomic) UILabel *titleLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createPick)];
    [_imageView addGestureRecognizer:tap];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 68)];
    _titleLabel.backgroundColor = [UIColor grayColor];
    _titleLabel.textColor =[UIColor whiteColor];
    _titleLabel.textAlignment =1;
    _titleLabel.text = @"北京-通州";
    
    [self.view addSubview:_titleLabel];
}
-(void)createPick{
    LCityPickerView *pick  =[[LCityPickerView alloc]initWithNumOfList:3 AndAfterPickerBlock:^(NSString *province, NSString *city, NSString *area) {
        if (!area){
            _titleLabel.text = [NSString stringWithFormat:@"%@-%@",province,city];

        }else{
            _titleLabel.text = [NSString stringWithFormat:@"%@-%@-%@",province,city,area];

        }
    }];
    [pick showInView:self.view];
}

@end
