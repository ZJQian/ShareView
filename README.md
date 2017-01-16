# ShareView
针对ShareSDK做的一个分享的view，包括微信，微博，QQ等



调用很简单：


ShareView *share = [[ShareView alloc]initWithTitleNameArray:@[@"QQ",@"QQ空间",@"微信",@"朋友圈",@"微信收藏",@"微博",@"邮件",@"短信"] imageArray:@[@"qq",@"qq_zone",@"weixin",@"weixinquan",@"weixin_fav",@"weibo",@"email",@"sms"]];
            
[share show];
