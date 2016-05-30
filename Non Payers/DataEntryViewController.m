//
//  DataEntryViewController.m
//  Non Payers
//
//  Created by Workspace Infotech on 10/19/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "DataEntryViewController.h"
#import "JSONHTTPClient.h"
#import "ToastView.h"

@interface DataEntryViewController ()

@end

@implementation DataEntryViewController

- (void)viewDidLoad {
    
    defaults = [NSUserDefaults standardUserDefaults];
    baseurl = [defaults objectForKey:@"baseurl"];
    
    [super viewDidLoad];
   // self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
   // [self.navigationItem.backBarButtonItem setAction:@selector(performBackNavigation:)];
    
    self.backBtn = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStyleDone target:self action:@selector(home:)];
    self.navigationItem.leftBarButtonItem=self.backBtn;
    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    
    [self.view addGestureRecognizer:self.singleTap];
    
    self.keyboardBorder=[[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,1)];
    [self.keyboardBorder setBackgroundColor:[UIColor orangeColor]];
    
    self.phoneNo.inputAccessoryView = self.keyboardBorder;
    self.postCode.inputAccessoryView = self.keyboardBorder;

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d/MMMM/yyyy hh:mm a";
    
    self.datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width,200)];
    
    [self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [self.datePicker addTarget:self action:@selector(updateTextFieldDate:)     forControlEvents:UIControlEventValueChanged];
    
    self.timeOfIncident.inputView = self.datePicker;
    self.autoPop = YES;
    
    self.timeOfIncident.text = [formatter stringFromDate:[NSDate date]];
    
    [self populateAdvice];
}

- (void)home:(UIBarButtonItem*)sender
{
    if( !self.autoPop )
    {
        self.title = @"Data Entry";
        [self.backBtn setTitle:@"< Back"];
        self.mainContainer.hidden = NO;
        self.tableData.hidden = YES;
        self.autoPop = YES;
        [self.view addGestureRecognizer:self.singleTap];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    
    
}

-(void) populateAdvice{
    
    [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@app/advice",baseurl] bodyString:nil
                                   completion:^(NSDictionary *json, JSONModelError *err) {
                                       
                                       NSLog(@"%@",err);
                                       
                                       NSError* error = nil;
                                       self.responseAdvice = [[AdviceResponse alloc] initWithDictionary:json error:&error];
                                       
                                       NSLog(@"%@",error);
                                       
                                       if(error)
                                       {
                                           [ToastView showToastInParentView:self.view withText:@"Server Unreachable" withDuaration:2.0];
                                       }
                                       
                                       
                                       
                                       if(self.responseAdvice.responseStat.status){
                     
                                           
                                           [self.tableData reloadData];
                                           
                                       }
                                       
                                   }];
}

- (void) updateTextFieldDate:(UIDatePicker *)pickerL{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d/MMMM/yyyy hh:mm a";
    
    self.timeOfIncident.text = [formatter stringFromDate:self.datePicker.date];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}



- (IBAction)save:(id)sender {
    
    [self.loading startAnimating];
    self.mainContainer.hidden = YES;
    
    
    if([self.phoneNo.text isEqual:@""])
    {
        [ToastView showToastInParentView:self.view withText:@"Insert a phone no first" withDuaration:2.0];
        [self.loading stopAnimating];
        self.mainContainer.hidden = NO;
    }
    else if ([self.postCode.text isEqualToString:@""])
    {
        [ToastView showToastInParentView:self.view withText:@"Insert your postal code" withDuaration:2.0];
        [self.loading stopAnimating];
        self.mainContainer.hidden = NO;
    }
    else if ([self.pickUpLocation.text isEqualToString:@""])
    {
        [ToastView showToastInParentView:self.view withText:@"Insert your pick up location" withDuaration:2.0];
        [self.loading stopAnimating];
        self.mainContainer.hidden = NO;
    }
    else if([self.timeOfIncident.text isEqual:@""])
    {
        [ToastView showToastInParentView:self.view withText:@"Insert a time of incident" withDuaration:2.0];
        [self.loading stopAnimating];
        self.mainContainer.hidden = NO;
    }
    else if (!self.adviceId)
    {
        [ToastView showToastInParentView:self.view withText:@"Insert an Advice" withDuaration:2.0];
        [self.loading stopAnimating];
        self.mainContainer.hidden = NO;
    }
    else
    {
        NSLog(@"%@",[NSString stringWithFormat:@"%@app/client/create",baseurl]);
        
        self.nonPayerValue = (self.nonPayer.isOn) ? 1 : 0;
        self.starValue = (self.nonPayer.isOn) ? self.starValue :0;
        
        self.excellentCustomerValue = (self.excellentCustomer.isOn) ? 1 : 0;
        self.estarValue = (self.excellentCustomer.isOn) ? self.estarValue :0;
        
        [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@app/client/create",baseurl] bodyString:[NSString stringWithFormat:@"phone_number=%@&name=%@&post_code=%@&pickup_location=%@&non_payer=%d&stars=%d&time_of_incident=%@&incident_note=%@&advice_id=%d&excellent_customer=%d&excellent_stars=%D",self.phoneNo.text,self.name.text,self.postCode.text,self.pickUpLocation.text,self.nonPayerValue,self.starValue,self.timeOfIncident.text,self.incidentNote.text,self.adviceId,self.excellentCustomerValue,self.estarValue]
                                       completion:^(NSDictionary *json, JSONModelError *err) {
                                           
                                           NSLog(@"%@",err);
                                           
                                           NSError* error = nil;
                                           self.response = [[EntryResponse alloc] initWithDictionary:json error:&error];
                                           
                                           
                                           NSLog(@"%@",self.response);
                                           NSLog(@"%@",error);
                                           
                                           if(error)
                                           {
                                               [ToastView showToastInParentView:self.view withText:@"Server Unreachable" withDuaration:2.0];
                                           }
                                           
                                           
                                           [self.loading stopAnimating];
                                           self.mainContainer.hidden = NO;
                                           
                                           if(self.response.responseStat.status){
                                               
                                               [ToastView showToastInParentView:self.view withText:@"Entry Succesfull" withDuaration:2.0];
                                               
                                               self.phoneNo.text = @"";
                                               self.name.text = @"";
                                               self.postCode.text =@"";
                                               self.pickUpLocation.text = @"";
                                               self.starValue = 0;
                                               self.estarValue = 0;
                                               self.timeOfIncident.text =@"";
                                               self.incidentNote.text = @"";
                                               self.advice.titleLabel.text = @"Advice";
                                               self.adviceId = 0;
                                               
                                               [self.star1 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
                                               [self.star2 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
                                               [self.star3 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
                                               [self.star4 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
                                               [self.star5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
                                               
                                               [self.estar1 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
                                               [self.estar2 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
                                               [self.estar3 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
                                               [self.estar4 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
                                               [self.estar5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];

                                               
                                           }
                                           else
                                           {
                                                [ToastView showToastInParentView:self.view withText:self.response.responseStat.msg withDuaration:2.0];
                                           }
                                           
                                       }];
        
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)star1:(id)sender {
    
    NSLog(@"1");
    
    [self.star1 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star2 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.star3 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.star4 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.star5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    
    self.starValue = 1;
    
    
}

- (IBAction)star2:(id)sender {
    
    NSLog(@"2");
    
    [self.star1 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star2 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star3 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.star4 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.star5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    
    self.starValue = 2;

    
}

- (IBAction)star3:(id)sender {
    
    NSLog(@"3");
    
    [self.star1 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star2 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star3 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star4 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.star5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    
    self.starValue = 3;
    
}

- (IBAction)star4:(id)sender {
    
    NSLog(@"4");
    
    [self.star1 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star2 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star3 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star4 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];

    
    self.starValue = 4;
    
}

- (IBAction)star5:(id)sender {
    
    NSLog(@"5");
    
    [self.star1 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star2 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star3 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star4 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.star5 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];

    
    self.starValue = 5;
    
}

- (IBAction)payerChange:(id)sender {
    
    self.starContainer.hidden = (self.nonPayer.isOn) ? NO : YES;
    
    [self.excellentCustomer setOn:self.nonPayer.isOn];
    
    self.estarContainer.hidden = (self.excellentCustomer.isOn) ? NO : YES;
    
    
    if(!self.excellentCustomer.isOn)
    {
        [self.estar1 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
        [self.estar2 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
        [self.estar3 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
        [self.estar4 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
        [self.estar5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
        
        self.estarValue = 0;
    }

    
    if(!self.nonPayer.isOn)
    {
    [self.star1 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.star2 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.star3 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.star4 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.star5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    
    self.starValue = 0;
    }
}

- (IBAction)excellentChange:(id)sender {
    
    self.estarContainer.hidden = (self.excellentCustomer.isOn) ? NO : YES;
    
    
    if(!self.excellentCustomer.isOn)
    {
        [self.estar1 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
        [self.estar2 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
        [self.estar3 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
        [self.estar4 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
        [self.estar5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
        
        self.estarValue = 0;
    }

}

- (IBAction)estar1:(id)sender {
    
    [self.estar1 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar2 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.estar3 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.estar4 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.estar5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    
    self.estarValue = 1;
}

- (IBAction)estar2:(id)sender {
    
    [self.estar1 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar2 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar3 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.estar4 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.estar5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    
    self.estarValue = 2;
    
}

- (IBAction)estar3:(id)sender {
    
    [self.estar1 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar2 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar3 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar4 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    [self.estar5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    
    self.estarValue = 3;
    
}

- (IBAction)estar4:(id)sender {
    
    [self.estar1 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar2 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar3 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar4 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar5 setImage:[UIImage imageNamed:@"star_i"] forState:UIControlStateNormal];
    
    self.estarValue = 4;
    
}

- (IBAction)estar5:(id)sender {
    
    [self.estar1 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar2 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar3 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar4 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    [self.estar5 setImage:[UIImage imageNamed:@"star_a"] forState:UIControlStateNormal];
    
    self.estarValue = 5;
    
}

- (IBAction)advice:(id)sender {
    
    self.tableData.hidden = NO;
    self.mainContainer.hidden = YES;
    self.title = @"Select Advice";
    [self.backBtn setTitle:@"OK"];
    self.autoPop = NO;
    [self.view removeGestureRecognizer:self.singleTap];
}


#pragma mark - table methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.responseAdvice.responseData.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Advice *data = self.responseAdvice.responseData[indexPath.row];
    
    cell.textLabel.text = data.name;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.title = @"Data Entry";
    [self.backBtn setTitle:@"< Back"];
    self.mainContainer.hidden = NO;
    self.tableData.hidden = YES;
    self.autoPop = YES;
    
    Advice *data = self.responseAdvice.responseData[indexPath.row];
    [self.advice setTitle:data.name forState:UIControlStateNormal];
    self.adviceId = data.id;
    
    [self.view addGestureRecognizer:self.singleTap];
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
