//
//  HomeMenuHeader.h
//  战旗TV
//
//  Created by 于洋 on 16/2/19.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"
@interface HomeMenuHeader : UICollectionReusableView
@property (nonatomic,weak) UIViewController *viewController;
- (void)resetArray:(NSArray *)array;

- (void)resetTitle:(HomeListModel *)model;
@end
