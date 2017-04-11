//
//  AppDelegate.m
//  login
//
//  Created by 黄家树 on 2017/4/11.
//  Copyright © 2017年 huangjiashu. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <WXApi.h>
#import "LoginViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate{
    BOOL _login;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
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
    
    
    //梳理用户登录流程
    //0.创建主窗口并使其可见
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    
    //1.判断用户是否登录 根据登录状态 切换根控制器是登录注册界面 还是登录后的正常显示页面
    if (_login) {
        //已登录
//        self.window.rootViewController =
        //打开socket
    }else{
        //未登录 切换到登录注册界面
        UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = [storyBorad instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //关闭socket
    }
    
    //2.可以注册个用户登录和退出的通知 在这里做些响应处理
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:@"login" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitLogion) name:@"exitLogin" object:nil];
    
    
    
    return YES;
}


/**
 收到登录的通知
 */
-(void)login{
    //这里可以做些额外的操作
    //切换到登录后界面
    self.window.rootViewController = [[ViewController alloc]init];
    //重新打开socket
}

/**
 收到退出登录的通知
 */
-(void)exitLogion{
    //关闭socket
    //删除
    //切换到登录注册界面
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
