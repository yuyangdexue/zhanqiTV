//
//  GameSubListViewController.h
//  战旗TV
//
//  Created by 于洋 on 16/3/9.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "BaseViewController.h"
#import "GameListModel.h"
@interface GameSubListViewController : BaseViewController

- (instancetype)initWithGameId:(GameListModel *)model;
@end
