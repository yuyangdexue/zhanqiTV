//
//  HomeViewController.m
//  战旗TV
//
//  Created by 于洋 on 16/2/18.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "HomeViewController.h"
#import "Constants.h"
#import "HomeCell.h"
#import "HomeMenuHeader.h"
#import "SectionView.h"
#import "LibiaryAPI.h"
#import "AdModel.h"
#import "HomeListModel.h"
#import "RoomDetailController.h"


#define IDENTIFIER_CELL @"homeMenuCell"
#define IDENTIFIER_HEADER @"homeMenuHeader"
#define IDENTIFIER_HEADERSECTION @"homeMenuHeaderSection"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    AdSuperModel *adSuperModel;
    HomeSuperListModel *homeSuperListModel;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTopView];

    
    [self initCollectionView];
    [self getHomeListModel];
    [self getAdModel];
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
    
    [_collectionView registerClass:[HomeMenuHeader class]
  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
         withReuseIdentifier:IDENTIFIER_HEADER];
    
    [_collectionView registerClass:[SectionView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:IDENTIFIER_HEADERSECTION];

    
    [self.view addSubview:_collectionView];
}


#pragma mark - CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return homeSuperListModel.data.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    //    return _menuSource.items.count;
    return ((HomeListModel *)[homeSuperListModel.data objectAtIndex:section] ).lists.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    

    
    return CGSizeMake(kDeviceWidth / 2-10, 135*kDeviceFactor);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return CGSizeMake(kDeviceWidth , 220*kDeviceFactor);
    }
      return CGSizeMake(kDeviceWidth , 50*kDeviceFactor);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section==0) {
            HomeMenuHeader *monthHeader =
            [collectionView dequeueReusableSupplementaryViewOfKind:
             UICollectionElementKindSectionHeader
                                               withReuseIdentifier:IDENTIFIER_HEADER
                                                      forIndexPath:indexPath];

            if (adSuperModel) {
                monthHeader.viewController=self;
                  [monthHeader  resetArray:adSuperModel.data];
            }
          
            if (homeSuperListModel) {
                [monthHeader resetTitle: ((HomeListModel *)[homeSuperListModel.data objectAtIndex:indexPath.section])];
            }
               reusableview = monthHeader;
            
        }
        else{
            SectionView *sectionView =
            [collectionView dequeueReusableSupplementaryViewOfKind:
             UICollectionElementKindSectionHeader
                                               withReuseIdentifier:IDENTIFIER_HEADERSECTION
                                                      forIndexPath:indexPath];
            if (homeSuperListModel) {
                  [sectionView resetTitle: ((HomeListModel *)[homeSuperListModel.data objectAtIndex:indexPath.section])];
            }
          
            reusableview = sectionView;
            
        }
        
      //  [monthHeader initDic:dict];
        
     
    }
    
    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_CELL
                                              forIndexPath:indexPath];
    [cell resetModel: [((HomeListModel *)[homeSuperListModel.data objectAtIndex:indexPath.section]).lists objectAtIndex:indexPath.row]];
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
   NSLog(@"====%@",((Lists *)[((HomeListModel *)[homeSuperListModel.data objectAtIndex:indexPath.section]).lists objectAtIndex:indexPath.row]).videoId);
    RoomDetailController *rvc = [[RoomDetailController alloc]initWithVideoId: ((Lists *)[((HomeListModel *)[homeSuperListModel.data objectAtIndex:indexPath.section]).lists objectAtIndex:indexPath.row]).videoId];
    [self.navigationController pushViewController:rvc animated:YES];
}


#pragma mark http

- (void)getAdModel{
    
    [LibiaryAPI httpGET:AppURL_Banner headerWithUserInfo:YES parameters:nil successBlock:^(int code, NSDictionary *dictResp) {
        
       adSuperModel = [[AdSuperModel alloc]initWithDictionary:dictResp error:nil];
        if ([adSuperModel.code intValue]==0) {
            
            [_collectionView reloadData];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)getHomeListModel{
    
    [LibiaryAPI httpGET:AppURL_Home headerWithUserInfo:YES parameters:nil successBlock:^(int code, NSDictionary *dictResp) {
        
        homeSuperListModel = [[HomeSuperListModel alloc]initWithDictionary:dictResp error:nil];
        if ([homeSuperListModel.code intValue]==0) {
            [_collectionView reloadData];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    
}




@end
