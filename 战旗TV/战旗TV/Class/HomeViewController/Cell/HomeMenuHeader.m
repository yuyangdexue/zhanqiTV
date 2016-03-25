//
//  HomeMenuHeader.m
//  战旗TV
//
//  Created by 于洋 on 16/2/19.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "HomeMenuHeader.h"
#import "CycleScrollView.h"
#import "Constants.h"
#import "AdModel.h"
#import "SectionView.h"
#import "RoomDetailController.h"
#import "RootViewController.h"
@interface HomeMenuHeader ()
{
    SectionView *sectionView;
}
@property (nonatomic , retain) CycleScrollView *mainScorllView;
@end
@implementation HomeMenuHeader



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
       // [self setup];
    }
    return self;
}

- (void)setup{
    
    sectionView= [[SectionView alloc]initWithFrame:CGRectMake(0, 170*kDeviceFactor, kDeviceWidth, 50*kDeviceFactor)];
    [self addSubview:sectionView];
    
}

- (void)resetTitle:(HomeListModel *)model{
    [sectionView resetTitle:model];
}

- (void)resetArray:(NSArray *)array{
    NSMutableArray *viewsArray = [@[] mutableCopy];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 170*kDeviceFactor)];
        AdModel *model = obj;
        [img setImageWithURL:[NSURL URLWithString: model.spic] placeholderImage:[UIImage imageNamed:@""]];
        [viewsArray addObject:img];
        
    }];
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 170*kDeviceFactor) animationDuration:2];

    
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return viewsArray.count;
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        RoomDetailController  *rvc = [[RoomDetailController alloc]initWithRoomModel:((AdModel *)[array objectAtIndex:pageIndex]).room];
        [self.viewController.navigationController pushViewController:rvc animated:YES];

        NSLog(@"点击了第%d个",pageIndex);
    };
      [self addSubview:self.mainScorllView];

}

@end
