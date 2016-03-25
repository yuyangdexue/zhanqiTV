//
//  RootViewController.m
//  战旗TV
//
//  Created by 于洋 on 16/2/18.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "RootViewController.h"
#import "Constants.h"
#import "TabbarModel.h"
#import "BaseViewController.h"
#import "LibiaryAPI.h"

@interface RootViewController ()

@end

@implementation RootViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    //self.tabBar.tintColor=kColor_Main_Color;
    [self initSubView];
    // Do any additional setup after loading the view.
}

- (void)initSubView{
    
    NSMutableArray *controllers = [NSMutableArray array];
    
    TabbarSourceModel *sourceModel =[ [TabbarSourceModel alloc]initWithDictionary:[LibiaryAPI initWithFileName:@"rootTabs" extension:@"json"] error:nil];
    
      for (TabbarModel *tabModel in sourceModel.items) {
          BaseViewController *vc =
          (BaseViewController *)[LibiaryAPI viewControllerWithKey:tabModel.key];
          for (TabbarModel *model in tabModel.subitems) {
              UITabBarItem *customItem = [[UITabBarItem alloc]initWithTitle:model.title image: [UIImage imageNamed:model.image] selectedImage:[UIImage imageNamed:model.image_hl]];
              customItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
              [customItem setTitlePositionAdjustment:UIOffsetMake(0, -5)];
              [customItem setTitleTextAttributes:@{
                                                   NSFontAttributeName : [UIFont boldSystemFontOfSize:12.0]
                                                   } forState:UIControlStateNormal];
              
              vc.tabBarItem = customItem;
          }
            [controllers addObject:vc];
       

        
    }
    
    self.viewControllers = controllers;
    
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
