//
//  GameListCell.m
//  战旗TV
//
//  Created by 于洋 on 16/2/19.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "GameListCell.h"
#import "Constants.h"
@interface GameListCell ()
{
    UIImageView *coverImg;
    UILabel *lable;
}
@end
@implementation GameListCell

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup{
    UIView *bgView  = [[UIView alloc]initWithFrame:CGRectMake(0, 10, (kDeviceWidth-40)/3, ((kDeviceWidth-40)/3)*240/170+40)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    coverImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.width*240/170)];
    [bgView addSubview:coverImg];
    
    lable  = [UILabel labelWithRect:CGRectMake(0, bgView.frame.size.width*240/170+10, bgView.frame.size.width, 30) text:nil textColor:[UIColor blackColor] fontSize:16 textAlignment:NSTextAlignmentCenter];
    [bgView addSubview:lable];
}

- (void)resetModel:(GameListModel *)model{
    [coverImg setImageWithURL:[NSURL URLWithString:model.spic] placeholderImage:[UIImage imageNamed:@""]];
    lable.text = model.name;
}

@end
