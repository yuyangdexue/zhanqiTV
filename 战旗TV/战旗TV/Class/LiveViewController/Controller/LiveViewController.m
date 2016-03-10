//
//  LiveViewController.m
//  战旗TV
//
//  Created by 于洋 on 16/2/18.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "LiveViewController.h"
#import "LibiaryAPI.h"
#import "LiveModel.h"
#import "HomeCell.h"
#import "RoomDetailController.h"
#define IDENTIFIER_CELL @"homeMenuCell"
@interface LiveViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    SuperLiveModel *superLiveModel;
    UICollectionView *_collectionView;
}
@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self showTopView];
    [self initCollectionView];
    [LibiaryAPI  httpGET:AppURL_Live headerWithUserInfo:YES parameters:nil successBlock:^(int code, NSDictionary *dictResp) {
        superLiveModel = [[SuperLiveModel alloc]initWithDictionary:dictResp error:nil];
        if ([superLiveModel.code intValue]==0) {
            [_collectionView reloadData];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    // Do any additional setup after loading the view.
}

- (void)initCollectionView{
    UICollectionViewFlowLayout *layout =
    [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset= UIEdgeInsetsMake(0, 0, 0, 10);
    // layout.headerReferenceSize = CGSizeMake(kDeviceWidth, 170 * kDeviceFactor);
    //    layout.footerReferenceSize = CGSizeMake(kDeviceWidth, 57 * kDeviceFactor);
    
    _collectionView = [[UICollectionView alloc]
                       initWithFrame:CGRectMake(0, kMarginTopHeight, kDeviceWidth,
                                                kDeviceHeight - kTabBarHeight -kMarginTopHeight)
                       collectionViewLayout:layout];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.bounces = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.backgroundColor = [UIColor colorWithHexRGBString:@"f6f6f6"];
    _collectionView.showsVerticalScrollIndicator = NO;
    
    [_collectionView registerClass:[HomeCell class]
        forCellWithReuseIdentifier:IDENTIFIER_CELL];
    
    
    [self.view addSubview:_collectionView];
}


#pragma mark - CollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    //    return _menuSource.items.count;
    return  superLiveModel.data.rooms.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return CGSizeMake(kDeviceWidth / 2-10, 135*kDeviceFactor);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_CELL
                                              forIndexPath:indexPath];
    [cell resetModel:  [superLiveModel.data.rooms objectAtIndex:indexPath.row]];
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    RoomDetailController *rvc = [[RoomDetailController alloc]initWithVideoId: ((Lists *)[superLiveModel.data.rooms objectAtIndex:indexPath.row]).videoId];
    [self.navigationController pushViewController:rvc animated:YES];

    
    
}


@end
