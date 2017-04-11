# login
## 使用shareSDK第三方登录
1. 通过pod集成第三方ShareSDk 需要获取appid和appkey 集成的其他平台如qq,wx等,也需要知道其相关信息
2. 程序启动时,启动shareSDK服务
~~~
//注册shareSDK第三方平台登录
    NSString *shareSDKAppkey = @"";//项目中需要如实填写
    [ShareSDK registerApp:shareSDKAppkey activePlatforms:@[@(SSDKPlatformTypeQQ),@(SSDKPlatformTypeWechat)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType) {
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
                case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
         NSString*  QQAppID             ;
        NSString*  QQAppKey            ;
        NSString*  WeChatID            ;
        NSString*  WeChatAppSecret      ;
        //以上参数 在实际使用时需要赋值
        switch (platformType) {
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:QQAppID appKey:QQAppKey authType:SSDKAuthTypeBoth];
                break;
                case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:WeChatID appSecret:WeChatAppSecret];
                break;
            default:
                break;
        }
    }];
    
    在需要第三方登录的页面,使用扩展中的方法,我个人觉得这个方法好用一些
    
   //这个扩展方法要更好用些
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        //绑定用户信息
        //参数1:关联ID，能够标识用户在应用中的唯一标识
        //参数2:用户信息
        //参数3:用于将自定义数据传递到用户信息中 //这里该是idcode
        associateHandler (user.uid, user, user);
        NSLog(@"dd%@",user.rawData);//原始数据
        NSLog(@"dd%@",user.credential);//为nil表示未授权
        //获取用户信息后,可以发给服务器
        
        
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        switch (state) {
            case SSDKResponseStateBegin:
                NSLog(@"开始授权");
                break;
            case SSDKResponseStateSuccess:
                NSLog(@"授权成功");
                  [[NSNotificationCenter defaultCenter]postNotificationName:@"login" object:nil];
                break;
            case SSDKResponseStateFail:
                NSLog(@"授权失败");
                break;
            case SSDKResponseStateCancel:
                NSLog(@"授权取消");
                break;
            default:
                break;
        }
    }];
 ~~~
    
    另外需要注意的两点是:
    1. 允许应用使用http协议
    2. 填写对应的scheme
   
    
