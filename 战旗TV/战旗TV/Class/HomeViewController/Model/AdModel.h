//
//  AdModel.h
//  战旗TV
//
//  Created by 于洋 on 16/2/19.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol IsStar
@end

@interface IsStar : JSONModel
@property (nonatomic, strong) NSString<Optional>* isWeek;
@property (nonatomic, strong) NSString<Optional>* isMonth;
@end;

@protocol RoomModel
@end

@interface RoomModel : JSONModel

@property (nonatomic, strong) NSString<Optional>* id;
@property (nonatomic, strong) NSString<Optional>* uid;
@property (nonatomic, strong) NSString<Optional>* nickname;
@property (nonatomic, strong) NSString<Optional>* gender;
@property (nonatomic, strong) NSString<Optional>* avatar;
@property (nonatomic, strong) NSString<Optional>* code;
@property (nonatomic, strong) NSString<Optional>* domain;
@property (nonatomic, strong) NSString<Optional>* url;
@property (nonatomic, strong) NSString<Optional>* title;
@property (nonatomic, strong) NSString<Optional>* gameId;
@property (nonatomic, strong) NSString<Optional>* spic;
@property (nonatomic, strong) NSString<Optional>* bpic;
@property (nonatomic, strong) NSString<Optional>* template;
@property (nonatomic, strong) NSString<Optional>* online;
@property (nonatomic, strong) NSString<Optional>* weight;
@property (nonatomic, strong) NSString<Optional>* status;
@property (nonatomic, strong) NSString<Optional>* level;
@property (nonatomic, strong) NSString<Optional>* hotsLevel;
@property (nonatomic, strong) NSString<Optional>* type;
@property (nonatomic, strong) NSString<Optional>* liveTime;
@property (nonatomic, strong) NSString<Optional>* userGroup;
@property (nonatomic, strong) NSString<Optional>* allowRecord;
@property (nonatomic, strong) NSString<Optional>* allowVideo;
@property (nonatomic, strong) NSString<Optional>* publishUrl;
@property (nonatomic, strong) NSString<Optional>* videoId;
@property (nonatomic, strong) NSString<Optional>* chatStatus;
@property (nonatomic, strong) NSString<Optional>* roomNotice;
@property (nonatomic, strong) NSString<Optional>* anchorNotice;
@property (nonatomic, strong) NSString<Optional>* roomCover;
@property (nonatomic, strong) NSString<Optional>* roomCoverType;
@property (nonatomic, strong) NSString<Optional>* editTime;
@property (nonatomic, strong) NSString<Optional>* addTime;
@property (nonatomic, strong) NSString<Optional>* gameName;
@property (nonatomic, strong) NSString<Optional>* gameUrl;
@property (nonatomic, strong) NSString<Optional>* gameIcon;
@property (nonatomic, strong) NSString<Optional>* gameBpic;
@property (nonatomic, strong) NSString<Optional>* videoIdKey;
@property (nonatomic, strong) NSString<Optional>* fansTitle;
@property (nonatomic, strong) NSString<Optional>* follows;
@property (nonatomic, strong) NSString<Optional>* fans;
@property (nonatomic, strong) IsStar<Optional>* isStar;
@property (nonatomic, strong) NSString<Optional>* bonus;
@end

@protocol AdModel
@end
@interface AdModel : JSONModel

@property (nonatomic, strong) NSString<Optional>* id;
@property (nonatomic, strong) NSString<Optional>* position;
@property (nonatomic, strong) NSString<Optional>* roomId;
@property (nonatomic, strong) NSString<Optional>* matchId;
@property (nonatomic, strong) NSString<Optional>* gameId;
@property (nonatomic, strong) NSString<Optional>* spic;
@property (nonatomic, strong) NSString<Optional>* bpic;
@property (nonatomic, strong) NSString<Optional>* title;
@property (nonatomic, strong) NSString<Optional>* url;
@property (nonatomic, strong) NSString<Optional>* contents;
@property (nonatomic, strong) NSString<Optional>* startTime;
@property (nonatomic, strong) NSString<Optional>* endTime;
@property (nonatomic, strong) NSString<Optional>* weight;
@property (nonatomic, strong) NSString<Optional>* positionType;
@property (nonatomic, strong) RoomModel<Optional>* room;
@end

@interface AdSuperModel : JSONModel
@property (nonatomic, strong) NSString<Optional>* code;
@property (nonatomic, strong) NSString<Optional>* message;
@property (nonatomic, strong) NSArray<Optional,AdModel>* data;
@end

