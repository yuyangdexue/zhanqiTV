//
//  RoomDetailController.m
//  战旗TV
//
//  Created by 于洋 on 16/2/19.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "RoomDetailController.h"
#import "Constants.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerView.h"
#import "NavgationView.h"
#import "DLTabedSlideView.h"


#define  kHeight  kDeviceWidth*9/16
@interface RoomDetailController ()<DLTabedSlideViewDelegate>{
    BOOL _played;
    NSString *_totalTime;
    NSDateFormatter *_dateFormatter;
    NavgationView *navView;
    CATransform3D myTransform ;
    NSString *_vid;
}

@property (nonatomic ,strong)AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic ,strong) PlayerView*playerView;

@property (strong, nonatomic) DLTabedSlideView *tabedSlideView;


@property (nonatomic ,strong)  UIButton  *swtichBtn;

@end


@implementation RoomDetailController

- (instancetype)initWithVideoId:(NSString *)vid{
    
    self = [super init];
    if (!self)  return nil;
    _vid=vid;
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubChildController];
    [self createBasicConfig];
    [self createNav];

    [self playVideo];
}


- (void)initSubChildController{

    self.tabedSlideView = [[DLTabedSlideView alloc]initWithFrame:CGRectMake(0, kHeight+20,kDeviceWidth, kDeviceHeight)];
    [self.view addSubview:self.tabedSlideView];
    
        self.tabedSlideView.delegate = self;
        self.tabedSlideView.baseViewController = self;
        
        self.tabedSlideView.tabItemSelectedColor = kColor_Main_Color;
        self.tabedSlideView.tabbarTrackColor = [UIColor blackColor];
    self.tabedSlideView.tabItemNormalColor = [UIColor whiteColor];
        self.tabedSlideView.tabbarBackgroundImage = [UIImage  imageWithColor:[UIColor blackColor]];
   
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"简介" image: [UIImage imageNamed:@"ic_broadcastroom_chat_default"] selectedImage: [UIImage imageNamed:@"ic_broadcastroom_chat_pressed"]];
        DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"聊天" image:[UIImage imageNamed:@"ic_broadcastroom_intro_default"]  selectedImage:[UIImage imageNamed:@"ic_broadcastroom_intro_pressed"] ];
        DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"视频" image:[UIImage imageNamed:@"ic_broadcastroom_video_default"]  selectedImage:[UIImage imageNamed:@"ic_broadcastroom_video_pressed"] ];
        DLTabedbarItem *item4 = [DLTabedbarItem itemWithTitle:@"排行" image:[UIImage imageNamed:@"ic_broadcastroom_rank_default"]  selectedImage:[UIImage imageNamed:@"ic_broadcastroom_rank_pressed"] ];
        self.tabedSlideView.tabbarItems = @[item1, item2, item3,item4];
        [self.tabedSlideView buildTabbar];
        self.tabedSlideView.tabbarBottomSpacing = 1.0;
        self.tabedSlideView.selectedIndex = 1;

}
    
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
        return 4;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
        
        UIViewController  * tvc = [UIViewController new];
        return tvc;
}



- (void)createNav{
    navView  = [[NavgationView alloc]initWithFrame:CGRectMake(0, 0, kDeviceHeight, 44) viewController:self];
    [self.view addSubview:navView];
    CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
    navView.layer.transform = transform;
    navView.center  = CGPointMake(kDeviceWidth-24, self.view.center.y);
   navView.hidden=YES;
}




- (void)customBack{
    _playerView.frame = CGRectMake(0, 20, kHeight, kDeviceWidth);
    navView.hidden=YES;
    
       [UIView animateWithDuration:0.3 animations:^{
       // CATransform3D transform = CATransform3DMakeRotation(-M_PI/2 , 0, 0, 1.0);
        //
        _playerView.layer.transform  =myTransform  ;
        _swtichBtn.alpha =0 ;
        _playerView.center  = CGPointMake(kDeviceWidth/2, 20+kHeight/2);
     
        
    } completion:^(BOOL finished) {
        _playerView.center = self.view.center;
         _swtichBtn.alpha =1;
        _swtichBtn.hidden=NO;
        _playerView.center  = CGPointMake(kDeviceWidth/2, 20+kHeight/2);
        self.navigationController.navigationBarHidden=NO;
         [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
    }];

    
}


- (void)swtichAction{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    _playerView.frame = CGRectMake(0, 0, kDeviceHeight, kDeviceWidth);
    _swtichBtn.hidden=YES;
 
     self.navigationController.navigationBarHidden=YES;
    [UIView animateWithDuration:0.3 animations:^{
        CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
        //
        _playerView.layer.transform  =  transform;
         _playerView.center = self.view.center;
        navView.alpha=0;
   
    } completion:^(BOOL finished) {
        _playerView.center = self.view.center;
        
          navView.alpha=1;
        navView.hidden=NO;
    }];
}

- (void)createBasicConfig{
    
    _playerView=[[PlayerView alloc]initWithFrame:CGRectMake(0, 20, kDeviceWidth, kHeight)];
    //_playerView.backgroundColor = [UIColor redColor];
       myTransform = _playerView.layer.transform;
    [self.view addSubview:_playerView];
    
    _swtichBtn  =  [UIButton ButtonWithRect:CGRectMake(kDeviceWidth-44,kHeight-10 , 44, 44) title:@"" titleColor:[UIColor whiteColor] BackgroundImageWithColor:[UIColor clearColor] clickAction:@selector(swtichAction) viewController:self titleFont:14 contentEdgeInsets:UIEdgeInsetsZero];
    [_swtichBtn setImage:[UIImage imageNamed:@"movie_fullscreen"] forState:UIControlStateNormal];
    [self.view addSubview:_swtichBtn];
    
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];

    
}


- (void)playVideo{
    NSMutableString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,_vid] ];
     filePath=[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *videoUrl = [NSURL URLWithString: filePath ];
    
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
//    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player = _player;
    [self.playerView.player play];
}

// KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
           
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
    }
}


- (void)dealloc {
    NSLog(@"释放");
   [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
}


@end
