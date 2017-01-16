//
//  ShareCell.m
//  AppointmentVaccine
//
//  Created by ZJQ on 2016/12/19.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "ShareCell.h"

@implementation ShareCell




- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews{
    
    UIView *contentView = self.contentView;
    
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.center = CGPointMake(contentView.center.x, contentView.center.y-15);
    imgView.bounds = CGRectMake(0, 0, 40, 40);
    [contentView addSubview:imgView];
    self.imgView = imgView;
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(contentView.left, imgView.bottom+5, contentView.width, 20);
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:label];
    self.nameLabel = label;
}



@end
