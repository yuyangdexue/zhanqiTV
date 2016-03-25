//
//  HomeListModel.h
//  战旗TV
//
//  Created by 于洋 on 16/2/19.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol Lists
@end
@interface Lists : JSONModel
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
@property (nonatomic, strong) NSString<Optional>* liveTime;
@property (nonatomic, strong) NSString<Optional>* userGroup;
@property (nonatomic, strong) NSString<Optional>* allowRecord;
@property (nonatomic, strong) NSString<Optional>* allowVideo;
@property (nonatomic, strong) NSString<Optional>* publishUrl;
@property (nonatomic, strong) NSString<Optional>* videoId;
@property (nonatomic, strong) NSString<Optional>* chatStatus;
@property (nonatomic, strong) NSString<Optional>* roomNotice;
@property (nonatomic, strong) NSString<Optional>* anchorNotice;
@property (nonatomic, strong) NSString<Optional>* roomDesc;
@property (nonatomic, strong) NSString<Optional>* roomCover;
@property (nonatomic, strong) NSString<Optional>* roomCoverType;
@property (nonatomic, strong) NSString<Optional>* editTime;
@property (nonatomic, strong) NSString<Optional>* addTime;
@property (nonatomic, strong) NSString<Optional>* gameName;
@property (nonatomic, strong) NSString<Optional>* gameUrl;
@property (nonatomic, strong) NSString<Optional>* gameIcon;
@property (nonatomic, strong) NSString<Optional>* follows;
@property (nonatomic, strong) NSString<Optional>* videoIdKey;
@end


@protocol Anchors
@end

@interface Anchors : JSONModel
@property (nonatomic, strong) NSString<Optional>* nickname;
@property (nonatomic, strong) NSString<Optional>* url;
@property (nonatomic, strong) NSString<Optional>* color;
@end

@protocol HomeListModel
@end

@interface HomeListModel : JSONModel
@property (nonatomic, strong) NSString<Optional>* id;
@property (nonatomic, strong) NSString<Optional>* keyword;
@property (nonatomic, strong) NSString<Optional>* title;
@property (nonatomic, strong) NSString<Optional>* icon;
@property (nonatomic, strong) NSString<Optional>* rtype;
@property (nonatomic, strong) NSString<Optional>* channelIds;
@property (nonatomic, strong) NSString<Optional>* roomIds;
@property (nonatomic, strong) NSString<Optional>* gameIds;
@property (nonatomic, strong) NSString<Optional>* customLink;
@property (nonatomic, strong) NSString<Optional>* moreUrl;
@property (nonatomic, strong) NSString<Optional>* nums;
@property (nonatomic, strong) NSString<Optional>* weight;
@property (nonatomic, strong) NSArray<Optional,Anchors>* anchors;
@property (nonatomic, strong) NSArray<Optional,Lists>* lists;

@end
@interface HomeSuperListModel : JSONModel
@property (nonatomic, strong) NSString<Optional>* code;
@property (nonatomic, strong) NSString<Optional>* message;
@property (nonatomic, strong) NSArray<Optional,HomeListModel>* data;
@end