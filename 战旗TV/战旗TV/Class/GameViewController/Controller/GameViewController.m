//
//  GameViewController.m
//  战旗TV
//
//  Created by 于洋 on 16/2/18.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "GameViewController.h"
#import "GameListModel.h"
#import "LibiaryAPI.h"
#import "GameListCell.h"
#import "GameSubListViewController.h"
#import "Constants.h"
#define IDENTIFIER_CELL @"homeMenuCell"
@interface GameViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    SuperGameListModel *superGameListModel;
    UICollectionView *_collectionView;
    NSMutableArray *arr;
    NSInteger _page;
}

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    arr = [[NSMutableArray alloc]init];
    [self showTopView];
    [self initCollectionView];
    [_collectionView triggerPullToRefresh];
  
    
    // Do any additional setup after loading the view.
}

- (void )loadDataPageIndex:(NSInteger )page top:(BOOL) isTop{
    [LibiaryAPI httpGET:AppURL_Game  parametersUrl:[NSString stringWithFormat:@"%ld.json",page]   headerWithUserInfo:YES parameters:nil successBlock:^(int code, NSDictionary *dictResp) {
        
        superGameListModel  = [[SuperGameListModel alloc]initWithDictionary:dictResp error:nil];
        if ([superGameListModel.code integerValue]==0) {
            
            if (isTop) {
                [arr removeAllObjects];
                [arr addObjectsFromArray:superGameListModel.data.games];
                [_collectionView.pullToRefreshView stopAnimating];
            }
            else{
                [arr addObjectsFromArray:superGameListModel.data.games];
                
               
                
                [_collectionView.infiniteScrollingView stopAnimating];

            }
            [_collectionView reloadData];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)loadTop{
    _page = 1;
    [self  loadDataPageIndex:_page top:YES];
}

- (void)loadMore{
     _page += 1;
      [self  loadDataPageIndex:_page top:NO];
}

- (void)initCollectionView{
    UICollectionViewFlowLayout *layout =
    [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing =10;
    layout.sectionInset= UIEdgeInsetsMake(0, 10, 0, 10);
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
    
    [_collectionView registerClass:[GameListCell class]
        forCellWithReuseIdentifier:IDENTIFIER_CELL];
    
    
    [self.view addSubview:_collectionView];
    
    __weak   GameViewController *weakSelf =self;
    
    [_collectionView  addPullToRefreshWithActionHandler:^{
        [weakSelf loadTop];
    }];
    
    [_collectionView addInfiniteScrollingWithActionHandler:^{
        
        [weakSelf loadMore];
    }];
    
}

#pragma mark - CollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    //    return _menuSource.items.count;
    return arr.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return CGSizeMake((kDeviceWidth-40)/3, (kDeviceWidth-40)/3*240/170+50);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GameListCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_CELL
                                              forIndexPath:indexPath];
    [cell resetModel:  [arr objectAtIndex:indexPath.row]];
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    GameSubListViewController *gameList = [[GameSubListViewController alloc]initWithGameId:[arr objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:gameList animated:YES];
    
}



@end
