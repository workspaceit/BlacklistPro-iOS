//
//  SignInViewController.m
//  Non Payers
//
//  Created by Workspace Infotech on 10/19/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "SignInViewController.h"
#import "ToastView.h"
#import "JSONHTTPClient.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    baseurl = [defaults objectForKey:@"baseurl"];

    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:self.singleTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShowOrHide:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShowOrHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

-(void)keyboardDidShowOrHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height;
    self.view.frame = newFrame;
    
    
    
    [UIView commitAnimations];
}



- (IBAction)signIn:(id)sender {
    
    [self.loading startAnimating];
    self.mainContainer.hidden = YES;
    
    if([self.username.text isEqual:@""])
    {
        [ToastView showToastInParentView:self.view withText:@"Insert a username first" withDuaration:2.0];
        [self.loading stopAnimating];
        self.mainContainer.hidden = NO;
    }
    else if ([self.password.text isEqualToString:@""])
    {
        [ToastView showToastInParentView:self.view withText:@"Insert your password" withDuaration:2.0];
        [self.loading stopAnimating];
        self.mainContainer.hidden = NO;
    }
    else
    {
        NSLog(@"%@",[NSString stringWithFormat:@"%@app/login/authenticate",baseurl]);
        
        [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@app/login/authenticate",baseurl] bodyString:[NSString stringWithFormat:@"user_name=%@&password=%@",self.username.text,self.password.text]
                                       completion:^(NSDictionary *json, JSONModelError *err) {
                                           
                                           NSLog(@"%@",err);
                                           
                                           NSError* error = nil;
                                           self.response = [[SignInResponse alloc] initWithDictionary:json error:&error];
                                           
                                           NSLog(@"%@",self.response);
                                           
                                           if(error)
                                           {
                                               [ToastView showToastInParentView:self.view withText:@"Server Unreachable" withDuaration:2.0];
                                           }
                                           else
                                           {
                                           
                                           
                                              
                                               
                                               
                                               if(self.response.responseStat.status){
                                                   
                                                   [defaults setValue:[NSString stringWithFormat:@"%@",self.response.responseData.accessToken] forKey:@"access_token"];
                                                   [self performSegueWithIdentifier:@"next" sender:self];
                                               }
                                               else
                                               {
                                                   [ToastView showToastInParentView:self.view withText:@"Username or Password incorrect" withDuaration:2.0];
                                               }
                                           }
                                           
                                           [self.loading stopAnimating];
                                           self.mainContainer.hidden = NO;
                                           
                                       }];
        
    }
    
   

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
