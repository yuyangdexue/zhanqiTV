//
//  BaseViewController.m
//  战旗TV
//
//  Created by 于洋 on 16/2/18.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "BaseViewController.h"
#import "Constants.h"
@interface BaseViewController ()
{
    UIImageView *leftImg;
    UIImageView       *centerImg;
    UIButton *saoBtn ;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor =kColor_Main_Color;
    topView.frame=CGRectMake(0, 0, kDeviceWidth, kMarginTopHeight);
    [self.view addSubview:topView];
    
    leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 60, 32)];
    leftImg.image = [UIImage imageNamed:@"nav_home_logo@2x.png"];
    leftImg.hidden=YES;
    [topView addSubview:leftImg];
    
    centerImg  = [[UIImageView alloc]initWithFrame:CGRectMake(80, 20+(44-26)/2, kDeviceWidth-120, 26)];
    centerImg.image = [UIImage setNewImage:@"nav_home_search@2x.png"];
    centerImg.hidden=YES;
    [topView addSubview:centerImg];
    
    saoBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
    [saoBtn setImage:[UIImage imageNamed:@"nav_home_sao@2x.png"] forState:UIControlStateNormal];
    saoBtn.frame = CGRectMake(kDeviceWidth-40, 20, 44, 44);
    saoBtn.hidden=YES;
    [topView addSubview:saoBtn];
    
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     
  @{NSFontAttributeName:[UIFont systemFontOfSize:16],
    
    
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)showTopView{
    saoBtn.hidden=NO;
    leftImg.hidden=NO;
    centerImg.hidden=NO;
}

- (void)search{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
