//
//  TBPlayerViewController.m
//  TabbarBeyondClick
//
//  Created by lujh on 2017/4/20.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBPlayerViewController.h"
#import "TBLiveChatViewController.h"
#import "AppDelegate.h"
@interface TBPlayerViewController ()

@property(atomic, retain) id<IJKMediaPlayback> player;

@property (nonatomic, strong) UIImageView * loadBlurImage;

@property (nonatomic, strong) UIButton * closeBtn;

@property (nonatomic, strong) TBLiveChatViewController * liveChatVC;
@end

@implementation TBPlayerViewController

- (UIButton *)closeBtn {
    
    if (!_closeBtn) {
        
        UIImage * image = [UIImage imageNamed:@"mg_room_btn_guan_h"];
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:image forState:UIControlStateNormal];
        _closeBtn.frame = CGRectMake(KUIScreenWidth - image.size.width - 12, KUIScreenHeight - image.size.height - 15, image.size.width, image.size.height);
        [_closeBtn addTarget:self action:@selector(closeLive:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
    
}

- (void)closeLive:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self installMovieNotificationObservers];
    
    [self.player prepareToPlay];
    
    UIWindow * window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    [window addSubview:self.closeBtn];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self.player shutdown];
    
    [self removeMovieNotificationObservers];
    
    [self.closeBtn removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化IJKFFMoviePlayerController
    [self initPlayer];
    
    // 创建毛玻璃Image
    [self setUpBlurImage];
    
    // 添加聊天室控制器
    [self addChatVC];
    
}

#pragma mark -初始化IJKFFMoviePlayerController

- (void)initPlayer {
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.model.stream_addr] withOptions:options];
    
    self.player.view.frame = self.view.bounds;
    self.player.shouldAutoplay = YES;
    [self.view addSubview:self.player.view];
    
}

#pragma mark -创建毛玻璃Image

- (void)setUpBlurImage {
    
    self.view.backgroundColor = [UIColor blackColor];
    //添加图片
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.loadBlurImage = imageView;
    
    if ([_model.creator.portrait rangeOfString:@"http"].location != NSNotFound ) {
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:_model.creator.portrait] placeholderImage:[UIImage imageNamed:@"icon"]];
        
    }else {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",IMAGE_HOST,_model.creator.portrait];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"icon"]];
        
    }
    
    [self.view addSubview:imageView];
    
    //  创建需要的毛玻璃特效类型
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //  毛玻璃view 视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    effectView.frame = imageView.bounds;
    [imageView addSubview:effectView];
}

#pragma mark -添加聊天室控制器

- (void)addChatVC {
    
    self.liveChatVC = [[TBLiveChatViewController alloc] init];
    [self addChildViewController:self.liveChatVC];
    [self.view addSubview:self.liveChatVC.view];
    [self.liveChatVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.liveChatVC didMoveToParentViewController:self];
    
    self.liveChatVC.model = self.model;
    
}

- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0,
    //    MPMovieLoadStatePlayable       = 1 << 0,
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded,
    //    MPMovieFinishReasonPlaybackError,
    //    MPMovieFinishReasonUserExited
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    
    //    MPMoviePlaybackStateStopped,
    //    MPMoviePlaybackStatePlaying,
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
    
    self.loadBlurImage.hidden = YES;
    [self.loadBlurImage removeFromSuperview];
}

#pragma mark Install Movie Notifications

/* Register observers for the various movie object notifications. */
-(void)installMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

#pragma mark Remove Movie Notification Handlers

/* Remove the movie notification observers from the movie object. */
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}

@end
