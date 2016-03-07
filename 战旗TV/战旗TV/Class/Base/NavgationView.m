//
//  NavgationView.m
//  战旗TV
//
//  Created by 于洋 on 16/2/22.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "NavgationView.h"
#import "Constants.h"
@interface NavgationView (){
    UIButton *leftBtn;
   
}

@property (nonatomic,weak) UIViewController  *viewController;
@end
@implementation NavgationView


- (instancetype)initWithFrame:(CGRect)frame viewController:(id )viewController{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    _viewController = viewController;
    [self setup];
    return self;
}

- (void)setup{
    
    leftBtn  =  [UIButton ButtonWithRect:CGRectMake(10, 10, 40, 40) title:@"返回" titleColor:[UIColor  whiteColor] BackgroundImageWithColor:[UIColor clearColor] clickAction:@selector(customBack) viewController:_viewController titleFont:14 contentEdgeInsets:UIEdgeInsetsZero];
    
    [self addSubview:leftBtn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
