//
//  HomeCell.m
//  战旗TV
//
//  Created by 于洋 on 16/2/19.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "HomeCell.h"
#import "Constants.h"
@interface HomeCell ()
{
    UIImageView *coverImg;
    UILabel  *titleLable;
    UIImageView *genderImg;
    UILabel *nickLable;
    UIImageView *audienceImg;
    UILabel         *audienceLable;
}
@end
@implementation HomeCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if  (!self )  return nil;
   // self.backgroundColor =  [UIColor redColor];
    [self setup];
    return self;
}

- (void)resetModel:(Lists *)model{
    [coverImg setImageWithURL:[NSURL URLWithString:model.spic] placeholderImage:[UIImage imageNamed:@""]];
    titleLable.text = model.title;
    if ([model.gender isEqualToString:@"1"]) {
        // 女
        genderImg.image = [UIImage imageNamed:@"icon_room_female@2x.png"];
    }else if ([model.gender isEqualToString:@"2"]){
        // 男
          genderImg.image = [UIImage imageNamed:@"icon_room_male@2x.png"];
    }
    nickLable.text = model.nickname;
    NSString *online = model.online;
    if (online.length<=4) {
    }else{
        int   w = [online intValue]/10000;
        int   q  = [online intValue]%10000/1000;
        online =  [NSString stringWithFormat:@"%d. %d万", w,q];
      
    }
    audienceLable.text = online;
    audienceLable.frame= CGRectMake(coverImg.frame.size.width+coverImg.frame.origin.x-online.length *8, coverImg.frame.origin.y+coverImg.frame.size.height+5, online.length *8, 12);
    audienceImg.frame=CGRectMake(audienceLable.frame.origin.x-20, coverImg.frame.origin.y+coverImg.frame.size.height+5, 13, 10);

}

- (void)setup{
    
    coverImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, (135-100)*kDeviceFactor/2, kDeviceWidth/2-20, 100*kDeviceFactor)];
    [self addSubview:coverImg];
    
    UIView *shaowView = [[UIView alloc]initWithFrame:CGRectMake(0, 100*kDeviceFactor-20,kDeviceWidth/2-20 , 20)];
    shaowView.backgroundColor = [UIColor blackColor];
    shaowView.alpha = 0.5;
    [coverImg addSubview:shaowView];
    titleLable = [UILabel labelWithRect:CGRectMake(0,  100*kDeviceFactor-20, kDeviceWidth/2-20, 20) text:nil textColor:[UIColor whiteColor] fontSize:14 textAlignment:NSTextAlignmentLeft];
    [coverImg addSubview:titleLable];
    
    genderImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, coverImg.frame.origin.y+coverImg.frame.size.height+5, 13, 13)];
    [self addSubview:genderImg];
    
    nickLable = [UILabel labelWithRect:CGRectMake(genderImg .frame.origin.x+genderImg.frame.size.width+5, coverImg.frame.origin.y+coverImg.frame.size.height+5, 100, 13) text:nil textColor:[UIColor lightGrayColor] fontSize:10 textAlignment:NSTextAlignmentLeft];
    [self addSubview:nickLable];
    
    audienceImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, coverImg.frame.origin.y+coverImg.frame.size.height+5, 13, 10)];
    audienceImg.image =[ UIImage imageNamed:@"room_audience@2x.png"];
    [self addSubview:audienceImg];
    
      audienceLable = [UILabel labelWithRect:CGRectMake(genderImg .frame.origin.x+genderImg.frame.size.width+5, coverImg.frame.origin.y+coverImg.frame.size.height+5, 100, 13) text:nil textColor:[UIColor lightGrayColor] fontSize:10 textAlignment:NSTextAlignmentLeft];
    [self addSubview:audienceLable];
    
}

@end
