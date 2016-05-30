//
//  SignUpViewController.m
//  Non Payers
//
//  Created by Workspace Infotech on 10/19/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "SignUpViewController.h"
#import "JSONHTTPClient.h"
#import "ToastView.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    baseurl = [defaults objectForKey:@"baseurl"];
    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:self.singleTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

- (IBAction)signUp:(id)sender {
    
    [self.loading startAnimating];
    self.mainContainer.hidden = YES;
    
    if([self.name.text isEqual:@""])
    {
        [ToastView showToastInParentView:self.view withText:@"Insert a username first" withDuaration:2.0];
        [self.loading stopAnimating];
        self.mainContainer.hidden = NO;
    }
    else if ([self.email.text isEqualToString:@""])
    {
        [ToastView showToastInParentView:self.view withText:@"Insert your password" withDuaration:2.0];
        [self.loading stopAnimating];
        self.mainContainer.hidden = NO;
    }
    else if ([self.phoneNumber.text isEqualToString:@""])
    {
        [ToastView showToastInParentView:self.view withText:@"Insert your password" withDuaration:2.0];
        [self.loading stopAnimating];
        self.mainContainer.hidden = NO;
    }
    else if([self.username.text isEqual:@""])
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
        NSLog(@"%@",[NSString stringWithFormat:@"%@app/register/user",baseurl]);
        
        [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@app/register/user",baseurl] bodyString:[NSString stringWithFormat:@"user_name=%@&password=%@&name=%@&address=%@&email=%@&phone_number=%@",self.username.text,self.password.text,self.name.text,self.address.text,self.email.text,self.phoneNumber.text]
                                       completion:^(NSDictionary *json, JSONModelError *err) {
                                           
                                           NSLog(@"%@",err);
                                           
                                           NSError* error = nil;
                                           self.response = [[SignUpResponse alloc] initWithDictionary:json error:&error];
                                           
                                             NSLog(@"%@",error);
                                           NSLog(@"%@",self.response);
                                           
                                           if(error)
                                           {
                                               [ToastView showToastInParentView:self.view withText:@"Server Unreachable" withDuaration:2.0];
                                           }
                                           
                                           
                                           [self.loading stopAnimating];
                                           self.mainContainer.hidden = NO;
                                           
                                           if(self.response.responseStat.status){
                                               
                                               [ToastView showToastInParentView:self.view withText:@"Registration Succesfull" withDuaration:2.0];
                                               self.name.text = @"";
                                               self.email.text = @"";
                                               self.phoneNumber.text = @"";
                                               self.address.text = @"";
                                               self.username.text = @"";
                                               self.password.text = @"";
                                           }
                                           
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
