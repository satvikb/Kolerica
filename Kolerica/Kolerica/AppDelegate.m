//
//  AppDelegate.m
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import "AppDelegate.h"
#import "Flurry.h"
#import "Storage.h"
@import GoogleMobileAds;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    FlurrySessionBuilder* builder = [[[[[FlurrySessionBuilder new]
                                        withLogLevel:FlurryLogLevelNone]
                                       withCrashReporting:YES]
                                      withSessionContinueSeconds:10]
                                     withAppVersion:@"1.0"];
    
    [Flurry startSession:@"2ZFPWZ4JPH3JPDMPG7V9" withSessionBuilder:builder];
    
    if([Storage getDidCompleteTutorial] == false){
        [Storage setBorderWidth:1];
    }
    
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-2889096611002538~2440342345"];
    return YES;
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
