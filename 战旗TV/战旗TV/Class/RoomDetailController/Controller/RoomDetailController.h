//
//  RoomDetailController.h
//  战旗TV
//
//  Created by 于洋 on 16/2/19.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"
#import "AdModel.h"
@interface RoomDetailController : UIViewController

- (instancetype)initWithModel:(Lists *)model;
- (instancetype)initWithRoomModel:(RoomModel *)model;
- (instancetype)initWithVideoId:(NSString *)vid;

@end
