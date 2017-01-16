//
//  ShareView.m
//  AppointmentVaccine
//
//  Created by ZJQ on 2016/12/19.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#define CELL_IDENTIFY     @"cellIdentify"


#import "ShareView.h"

#import "AppDelegate.h"
#import "ShareCell.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface ShareView ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    UIView *                 _darkView;
    UIView *                 _bottomView;
    NSArray *                _titleNameArray;
    NSArray *                _imageArray;
}
@end
@implementation ShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithTitleNameArray:(NSArray *)titleNameArray imageArray:(NSArray *)imageArray{
    
    if (self = [super init]) {
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.frame = CGRectMake(0, 0, NZ_DEVICE_WIDTH, NZ_DEVICE_HEIGHT);
        [app.window addSubview:self];
        
        _titleNameArray = titleNameArray;
        _imageArray = imageArray;
        
        UIView *darkView = [[UIView alloc]init];
        darkView.backgroundColor =RGBA(0, 0, 0, 0.5);
        darkView.alpha = 0;
        darkView.frame = CGRectMake(0, 0, NZ_DEVICE_WIDTH, NZ_DEVICE_HEIGHT);
        [self addSubview:darkView];
        _darkView = darkView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [_darkView addGestureRecognizer:tap];
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor whiteColor];
        bottomView.frame = CGRectMake(0, NZ_DEVICE_HEIGHT, NZ_DEVICE_WIDTH, 200);
        [self addSubview:bottomView];
        _bottomView = bottomView;
        
        UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, NZ_DEVICE_WIDTH, 40)];
        shareLabel.backgroundColor = [UIColor whiteColor];
        shareLabel.text = @"分享到";
        shareLabel.textAlignment = NSTextAlignmentCenter;
        shareLabel.font = [UIFont systemFontOfSize:15];
        [_bottomView addSubview:shareLabel];
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 55, NZ_DEVICE_WIDTH, 80) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [bottomView addSubview:collectionView];
        [collectionView registerClass:[ShareCell class] forCellWithReuseIdentifier:CELL_IDENTIFY];
        [collectionView setShowsHorizontalScrollIndicator:NO];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, collectionView.bottom+15, NZ_DEVICE_WIDTH, 1)];
        line.backgroundColor = COLORHEX(0xe6e6e6);
        [_bottomView addSubview:line];
        
        UIButton *cancelShare = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelShare setTitle:@"取消分享" forState:UIControlStateNormal];
        [cancelShare.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelShare setTitleColor:COLORHEX(0x818181) forState:UIControlStateNormal];
        cancelShare.frame  =CGRectMake(0, line.bottom, NZ_DEVICE_WIDTH, _bottomView.height-line.bottom);
        [cancelShare addTarget:self action:@selector(cancelShare) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:cancelShare];
        
    }
    
    return self;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(70, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 15, 0, 0);
}

- (void)show{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _darkView.alpha = 1;
        CGRect frame = _bottomView.frame;
        frame.origin.y -=frame.size.height;
        _bottomView.frame = frame;
    } completion:nil];
}

- (void)hidden{
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _darkView.alpha = 0;
        CGRect frame = _bottomView.frame;
        frame.origin.y += frame.size.height;
        _bottomView.frame = frame;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

- (void)tapClick{
    
    [self hidden];
    
}
- (void)cancelShare{

    [self hidden];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleNameArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFY forIndexPath:indexPath];
    
    cell.imgView.image = [UIImage imageNamed:_imageArray[indexPath.item]];
    cell.nameLabel.text = _titleNameArray[indexPath.item];
    
    return cell;
}
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@被点击了",_titleNameArray[indexPath.item]);
    [self hidden];
    NSArray* imageArray = @[@"http://7xkjw3.com1.z0.glb.clouddn.com/szjz/64.png"];
    // （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://7xkjw3.com1.z0.glb.clouddn.com/szjz/64.png"]）
    if (imageArray) {
        //
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@""
                                         images:imageArray
                                            url:[NSURL URLWithString:@""]
                                          title:@""
                                           type:SSDKContentTypeAuto];
        
        SSDKPlatformType type = -1;
        switch (indexPath.item) {
            case 0:
            {
                type = SSDKPlatformSubTypeQQFriend;
            }
                break;
            case 1:
            {
                type = SSDKPlatformSubTypeQZone;
            }
                break;
            case 2:
            {
                type = SSDKPlatformSubTypeWechatSession;
            }
                break;
            case 3:
            {
                type = SSDKPlatformSubTypeWechatTimeline;
            }
                break;
            case 4:
            {
                type = SSDKPlatformSubTypeWechatFav;
            }
                break;
            case 5:
            {
                type = SSDKPlatformTypeSinaWeibo;
            }
                break;
            case 6:
            {
                type = SSDKPlatformTypeMail;
            }
                break;
            case 7:
            {
                type = SSDKPlatformTypeSMS;
            }
                break;
                
        }
        
        [ShareSDK share:type parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
           
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
                    break;
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@",error.userInfo[@"error_message"]]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                }
                    break;
                default:
                    break;
            }
        }];
        
        
        
    }
    
   
}



@end
