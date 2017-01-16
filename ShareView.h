//
//  ShareView.h
//  AppointmentVaccine
//
//  Created by ZJQ on 2016/12/19.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView


/**
 初始化
 titleNameArray  名字数组
 imageArray      图片数组
 */
- (instancetype)initWithTitleNameArray:(NSArray *)titleNameArray imageArray:(NSArray *)imageArray;

/**
 显示
 */
- (void)show;


@end
