//
//  AppDelegate.m
//  Zhihu
//
//  Created by Fay on 15/12/9.
//  Copyright © 2015年 Fay. All rights reserved.
//

#import "AppDelegate.h"
#import "PageViewController.h"
#import "LeftMenuViewController.h"
#import "SWRevealViewController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.firstStart = YES;
    
    [self setMainViewController];
    
    //设置分享Appkey
    [UMSocialData setAppKey:kUMAppkey];
    
    //开启QQ、微信、新浪分享
    [UMSocialQQHandler setQQWithAppId:@"1105176776" appKey:@"yh5mzFBO9RFZPjYr" url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:nil appSecret:nil url:@"http://www.umeng.com/social"];

    
    [self judgeFirst];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  判断是否是第一次打开页面
 */
-(void)judgeFirst {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        NSLog(@"first");
    
    }else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstStart"];
        NSLog(@"Not first");
    }

}

/**
 *  设置主控制器
 */
-(void)setMainViewController {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    PageViewController *main = [[PageViewController alloc]init];
    
    UINavigationController *naviVc = [[UINavigationController alloc]initWithRootViewController:main];
    naviVc.navigationBarHidden = YES;
    
    [self.window makeKeyAndVisible];
    
    //[self.window showLanuchPageAndSetUmeng];
    
    LeftMenuViewController *sideVc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"left"];
    SWRevealViewController *swVc = [[SWRevealViewController alloc]initWithRearViewController:sideVc frontViewController:naviVc];
    swVc.rearViewRevealWidth = 250;
    self.window.rootViewController = swVc;

}

@end
