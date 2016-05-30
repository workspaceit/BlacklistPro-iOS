//
//  DashboardViewController.m
//  Non Payers
//
//  Created by Workspace Infotech on 10/19/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "DashboardViewController.h"
#import "JSONHTTPClient.h"
#import "JSONModelLib.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    defaults = [NSUserDefaults standardUserDefaults];
    baseurl = [defaults objectForKey:@"baseurl"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
    
    self.response = [[Response alloc] initFromURLWithString:[NSString stringWithFormat:@"%@app/logout",baseurl]
                                                     completion:^(JSONModel *model, JSONModelError *err) {
                                                         
                                                         
                                                         NSLog(@"DAta %@ %@",self.response,err);
                                                         
                                                        [self performSegueWithIdentifier:@"logout" sender:self];

                                                         
                                                         
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
