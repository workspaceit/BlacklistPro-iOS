//
//  AppDelegate.m
//  Non Payers
//
//  Created by Workspace Infotech on 10/19/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   
     [[UINavigationBar appearance] setTranslucent:NO];
     [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
     [[UITabBar appearance] setTintColor:[UIColor colorWithRed:10.00/255.00 green:80.00/255.00 blue:150.00/255.00 alpha:1]];
     [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:10.00/255.00 green:80.00/255.00 blue:150.00/255.00 alpha:1]];
     [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
     [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           nil, NSShadowAttributeName,
                                                          [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:25.0], NSFontAttributeName, nil]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:@"http://27.147.149.178:9030/nonpayers/public/index.php/" forKey:@"baseurl"];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if([defaults objectForKey:@"access_token"])
    {
        
        NSLog(@"%@app/login/authenticate/accesstoken?%@",[defaults objectForKey:@"baseurl"],[NSString stringWithFormat:@"access_token=%@",[defaults objectForKey:@"access_token"]]);
        
        [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@app/login/authenticate/accesstoken",[defaults objectForKey:@"baseurl"]] bodyString:[NSString stringWithFormat:@"access_token=%@",[defaults objectForKey:@"access_token"]]
                                       completion:^(NSDictionary *json, JSONModelError *err) {
                                           
                                           
                                           
                                           NSError* error = nil;
                                           self.response = [[SignInResponse alloc] initWithDictionary:json error:&error];
                                           
                                           NSLog(@"%@",error);
                                           
                                           if(error)
                                           {
                                               [ToastView showToastInParentView:self.window withText:@"Server Unreachable" withDuaration:2.0];
                                           }
                                           
                                           
                                           if(self.response.responseStat.status){
                                               
                                               NSLog(@"%@",self.response);
                                               
                                                                                             
                                               self.authCredential = self.response.responseData;
                                               
                                               UINavigationController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"dashboard"];
                                               self.window.rootViewController = rootViewController;
                                               [self.window makeKeyAndVisible];
                                               
                                               
                                               
                                               
                                           }
                                           else
                                           {
                                               UINavigationController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"login"];
                                               self.window.rootViewController = rootViewController;

                                               [self.window makeKeyAndVisible];
                                           }
                                           
                                       }];
        
        
        
    }
    else
    {
        UINavigationController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"login"];
        self.window.rootViewController = rootViewController;
        
        [self.window makeKeyAndVisible];
        
    }

    
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

@end
