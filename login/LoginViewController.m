
//
//  LoginViewController.m
//  login
//
//  Created by 黄家树 on 2017/4/11.
//  Copyright © 2017年 huangjiashu. All rights reserved.
//

#import "LoginViewController.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//集成ShareSDK

/**
 qq登录

 @param sender qq登录按钮
 */
- (IBAction)qqlogin:(UIButton *)sender {
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
}

/**
 微信登录

 @param sender 微信登录
 */
- (IBAction)wxlogin:(UIButton *)sender {
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        //绑定用户信息
        //参数1:关联ID，能够标识用户在应用中的唯一标识
        //参数2:用户信息
        //参数3:用于将自定义数据传递到用户信息中 //这里该是idcode
        associateHandler (user.uid, user, user);
        NSLog(@"dd%@",user.rawData);//原始数据
        NSLog(@"dd%@",user.credential);//为nil表示未授权
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
