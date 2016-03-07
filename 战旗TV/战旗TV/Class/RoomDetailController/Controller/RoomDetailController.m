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



#define  kHeght  kDeviceWidth*9/16
@interface RoomDetailController (){
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
//@property (nonatomic ,strong)  UIButton *stateButton;
//@property (nonatomic ,strong) UILabel *timeLabel;
//@property (nonatomic ,strong)  id playbackTimeObserver;
//@property (nonatomic ,strong)  UISlider *videoSlider;
//@property (nonatomic ,strong)  UIProgressView *videoProgress;

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
    [self createBasicConfig];
    [self createNav];

    [self playVideo];
}

- (void)createNav{
    navView  = [[NavgationView alloc]initWithFrame:CGRectMake(0, 0, kDeviceHeight, 44) viewController:self];
    //navView.backgroundColor =[UIColor greenColor];
    [self.view addSubview:navView];
    CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
    navView.layer.transform = transform;
    navView.center  = CGPointMake(kDeviceWidth-24, self.view.center.y);
   navView.hidden=YES;
}

- (void)customBack{
    _playerView.frame = CGRectMake(0, 20, kHeght, kDeviceWidth);
    navView.hidden=YES;
    
       [UIView animateWithDuration:0.3 animations:^{
       // CATransform3D transform = CATransform3DMakeRotation(-M_PI/2 , 0, 0, 1.0);
        //
        _playerView.layer.transform  =myTransform  ;
        _swtichBtn.alpha =0 ;
        _playerView.center  = CGPointMake(kDeviceWidth/2, 20+kHeght/2);
     
        
    } completion:^(BOOL finished) {
        _playerView.center = self.view.center;
         _swtichBtn.alpha =1;
        _swtichBtn.hidden=NO;
        _playerView.center  = CGPointMake(kDeviceWidth/2, 20+kHeght/2);
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
    
    _playerView=[[PlayerView alloc]initWithFrame:CGRectMake(0, 20, kDeviceWidth, kHeght)];
    //_playerView.backgroundColor = [UIColor redColor];
       myTransform = _playerView.layer.transform;
    [self.view addSubview:_playerView];
    
    _swtichBtn  =  [UIButton ButtonWithRect:CGRectMake(kDeviceWidth-60,kHeght-10 , 50, 40) title:@"switch" titleColor:[UIColor whiteColor] BackgroundImageWithColor:[UIColor clearColor] clickAction:@selector(swtichAction) viewController:self titleFont:14 contentEdgeInsets:UIEdgeInsetsZero];
    [self.view addSubview:_swtichBtn];
    
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];

    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.player replaceCurrentItemWithPlayerItem:nil];
}

- (void)playVideo{
    NSMutableString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,_vid] ];
     filePath=[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *videoUrl = [NSURL URLWithString: filePath ];
    
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
  //  [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
//    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player = _player;
    [self.playerView.player play];
}


////===============================================================
//- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
//    
//    __weak typeof(self) weakSelf = self;
//    self.playbackTimeObserver = [self.playerView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
//        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
//        [weakSelf.videoSlider setValue:currentSecond animated:YES];
//        NSString *timeString = [weakSelf convertTime:currentSecond];
//        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeString,_totalTime];
//    }];
//}
//
//// KVO方法
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    AVPlayerItem *playerItem = (AVPlayerItem *)object;
//    if ([keyPath isEqualToString:@"status"]) {
//        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
//            NSLog(@"AVPlayerStatusReadyToPlay");
//            self.stateButton.enabled = YES;
//            CMTime duration = self.playerItem.duration;// 获取视频总长度
//            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
//            _totalTime = [self convertTime:totalSecond];// 转换成播放时间
//            [self customVideoSlider:duration];// 自定义UISlider外观
//            NSLog(@"movie total duration:%f",CMTimeGetSeconds(duration));
//            [self monitoringPlayback:self.playerItem];// 监听播放状态
//        } else if ([playerItem status] == AVPlayerStatusFailed) {
//            NSLog(@"AVPlayerStatusFailed");
//        }
//    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
//        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
//        NSLog(@"Time Interval:%f",timeInterval);
//        CMTime duration = _playerItem.duration;
//        CGFloat totalDuration = CMTimeGetSeconds(duration);
//        [self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
//    }
//}
//
//- (NSTimeInterval)availableDuration {
//    NSArray *loadedTimeRanges = [[self.playerView.player currentItem] loadedTimeRanges];
//    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
//    float startSeconds = CMTimeGetSeconds(timeRange.start);
//    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
//    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
//    return result;
//}
//
//- (void)customVideoSlider:(CMTime)duration {
//    self.videoSlider.maximumValue = CMTimeGetSeconds(duration);
//    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
//    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    [self.videoSlider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
//    [self.videoSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
//}
//
//- (IBAction)stateButtonTouched:(id)sender {
//    if (!_played) {
//        [self.playerView.player play];
//        [self.stateButton setTitle:@"Stop" forState:UIControlStateNormal];
//    } else {
//        [self.playerView.player pause];
//        [self.stateButton setTitle:@"Play" forState:UIControlStateNormal];
//    }
//    _played = !_played;
//}
//
//- (IBAction)videoSlierChangeValue:(id)sender {
//    UISlider *slider = (UISlider *)sender;
//    NSLog(@"value change:%f",slider.value);
//    
//    if (slider.value == 0.000000) {
//        __weak typeof(self) weakSelf = self;
//        [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
//            [weakSelf.playerView.player play];
//        }];
//    }
//}
//
//- (IBAction)videoSlierChangeValueEnd:(id)sender {
//    UISlider *slider = (UISlider *)sender;
//    NSLog(@"value end:%f",slider.value);
//    CMTime changedTime = CMTimeMakeWithSeconds(slider.value, 1);
//    
//    __weak typeof(self) weakSelf = self;
//    [self.playerView.player seekToTime:changedTime completionHandler:^(BOOL finished) {
//        [weakSelf.playerView.player play];
//        [weakSelf.stateButton setTitle:@"Stop" forState:UIControlStateNormal];
//    }];
//}
//
//- (void)updateVideoSlider:(CGFloat)currentSecond {
//    [self.videoSlider setValue:currentSecond animated:YES];
//}
//
//
//- (void)moviePlayDidEnd:(NSNotification *)notification {
//    NSLog(@"Play end");
//    
//    __weak typeof(self) weakSelf = self;
//    [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
//        [weakSelf.videoSlider setValue:0.0 animated:YES];
//        [weakSelf.stateButton setTitle:@"Play" forState:UIControlStateNormal];
//    }];
//}
//
//- (NSString *)convertTime:(CGFloat)second{
//    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
//    if (second/3600 >= 1) {
//        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
//    } else {
//        [[self dateFormatter] setDateFormat:@"mm:ss"];
//    }
//    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
//    return showtimeNew;
//}
//
//- (NSDateFormatter *)dateFormatter {
//    if (!_dateFormatter) {
//        _dateFormatter = [[NSDateFormatter alloc] init];
//    }
//    return _dateFormatter;
//}

- (void)dealloc {
    NSLog(@"释放");
//    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
//    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
//    [self.playerLayer.player removeTimeObserver:self.playbackTimeObserver];
}


@end
