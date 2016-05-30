//
//  SignInViewController.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/19/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignInResponse.h"

@interface SignInViewController : UIViewController
{
    NSUserDefaults *defaults;
    NSString *baseurl;
}


@property (nonatomic, strong) SignInResponse *response;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIScrollView *mainContainer;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end
