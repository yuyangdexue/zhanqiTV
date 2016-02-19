//
//  GameListModel.h
//  战旗TV
//
//  Created by 于洋 on 16/2/19.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol Desc
@end

@interface Desc : JSONModel

@end

@protocol GameListModel
@end

@interface GameListModel : JSONModel
@property (nonatomic, strong) NSString<Optional>* id;
@property (nonatomic, strong) NSString<Optional>* name;
@property (nonatomic, strong) NSString<Optional>* gameKey;
@property (nonatomic, strong) NSString<Optional>* spic;
@property (nonatomic, strong) NSString<Optional>* bpic;
@property (nonatomic, strong) NSString<Optional>* icon;
@property (nonatomic, strong) NSString<Optional>* watchs;
@property (nonatomic, strong) Desc<Optional>* desc;
@property (nonatomic, strong) NSString<Optional>* weight;
@property (nonatomic, strong) NSString<Optional>* status;
@property (nonatomic, strong) NSString<Optional>* url;

@end

@protocol MiddleGameListModel
@end
@interface MiddleGameListModel : JSONModel
@property (nonatomic, strong) NSString<Optional>* cnt;
@property (nonatomic, strong) NSArray<Optional,GameListModel>* games;
@end

@interface SuperGameListModel : JSONModel
@property (nonatomic, strong) NSString<Optional>* code;
@property (nonatomic, strong) NSString<Optional>* message;
@property (nonatomic, strong) MiddleGameListModel<Optional>* data;

@end