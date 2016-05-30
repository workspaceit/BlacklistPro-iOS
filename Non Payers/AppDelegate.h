//
//  AppDelegate.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/19/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONHTTPClient.h"
#import "SignInResponse.h"
#import "ToastView.h"
#import "AuthCredential.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SignInResponse *response;
@property (strong, nonatomic) AuthCredential *authCredential;


@end

