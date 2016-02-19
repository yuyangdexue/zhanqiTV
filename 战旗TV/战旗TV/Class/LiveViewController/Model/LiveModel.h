//
//  LiveModel.h
//  战旗TV
//
//  Created by 于洋 on 16/2/19.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "HomeListModel.h"


@protocol MiddleLiveModel
@end
@interface MiddleLiveModel : JSONModel
@property (nonatomic, strong) NSString<Optional>* cnt;
@property (nonatomic, strong) NSArray<Optional,Lists>* rooms;

@end


@interface SuperLiveModel : JSONModel
@property (nonatomic, strong) NSString<Optional>* code;
@property (nonatomic, strong) NSString<Optional>* message;
@property (nonatomic, strong) MiddleLiveModel <Optional>* data;
@end