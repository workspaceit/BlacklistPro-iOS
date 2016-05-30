//
//  DataDetailsViewController.m
//  Non Payers
//
//  Created by Workspace Infotech on 10/19/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "DataDetailsViewController.h"

@interface DataDetailsViewController ()

@end

@implementation DataDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    self.name.text = [NSString stringWithFormat:@"Name : %@",self.name_];
    self.phoneNo.text = [NSString stringWithFormat:@"Phone Number : %@",self.phoneNo_];
    self.postalCode.text = [NSString stringWithFormat:@"Postal Code : %@",self.postalCode_];
    self.pickUpLocation.text = [NSString stringWithFormat:@"Pick Up Location : %@",self.pickUpLocation_];
    self.excellentCustomer.text = [NSString stringWithFormat:@"Excellent Customer : %@",self.excellentCustomer_];
    self.excellentStars.text = [NSString stringWithFormat:@"Excellent Stars : %@",self.excellentStars_];
    self.nonPayer.text = [NSString stringWithFormat:@"Payment Received : %@",self.nonPayer_];
    self.stars.text = [NSString stringWithFormat:@"Stars : %@",self.stars_];
    self.timeOfIncident.text = [NSString stringWithFormat:@"Time Of Incident : %@",self.timeOfIncident_];
    self.incidentNote.text = [NSString stringWithFormat:@"Incident Note : %@",self.incidentNote_];
    self.advice.text = [NSString stringWithFormat:@"Advice : %@",self.advice_];
    
   }

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    
    [self.view endEditing:YES];
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
