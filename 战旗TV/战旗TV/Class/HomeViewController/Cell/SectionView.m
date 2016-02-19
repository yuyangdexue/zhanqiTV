//
//  SectionView.m
//  战旗TV
//
//  Created by 于洋 on 16/2/19.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "SectionView.h"
#import "Constants.h"
@interface SectionView ()
{
    UILabel *lable;
}
@end
@implementation SectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, (50*kDeviceFactor-25*kDeviceFactor)/2, 5, 25*kDeviceFactor)];
    line.backgroundColor = kColor_Main_Color;
    [self addSubview:line];
    
    lable = [[UILabel alloc]initWithFrame:CGRectMake(line.frame.origin.x+line.frame.size.width+10, 0, 200, 50*kDeviceFactor)];
    lable.font = [UIFont boldSystemFontOfSize:16];
    lable.textColor  =  [UIColor blackColor];
    [self addSubview:lable];
    
}

- (void)resetTitle:(HomeListModel *)model{
    lable.text =model.title;
}

@end
