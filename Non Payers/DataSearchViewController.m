//
//  DataSearchViewController.m
//  Non Payers
//
//  Created by Workspace Infotech on 10/19/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "DataSearchViewController.h"
#import "JSONHTTPClient.h"
#import "ToastView.h"
#import "DataDetailsViewController.h"

@interface DataSearchViewController ()

@end

@implementation DataSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    baseurl = [defaults objectForKey:@"baseurl"];
    
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    self.keyboardBorder=[[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,1)];
    [self.keyboardBorder setBackgroundColor:[UIColor orangeColor]];
    
     self.phoneNo.inputAccessoryView = self.keyboardBorder;
     self.postalCode.inputAccessoryView = self.keyboardBorder;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
   
    
    self.myObject = [[NSMutableArray alloc] init];
    self.offset = 0;
    self.loaded = false;
    self.tableData.hidden = YES;
    
    
    //[self getData:self.offset];
    
   
}




-(void) viewDidAppear:(BOOL)animated{
    
    UIColor *color = [UIColor whiteColor];
    self.phoneNo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone Number" attributes:@{NSForegroundColorAttributeName:color}];
    self.postalCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Postal Code" attributes:@{NSForegroundColorAttributeName:color}];
    
}


- (IBAction)call:(id)sender {
    
     NSLog(@"Call");
      NSString *callTextFiel = [NSString stringWithFormat:@"tel:%@", self.phoneNo.text];
    
    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:callTextFiel]];
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callTextFiel]];
    
}

- (IBAction)search:(id)sender {
    
    if(![self.phoneNo.text isEqualToString:@"" ]|| ![self.postalCode.text isEqualToString:@""])
    {
        self.myObject = [[NSMutableArray alloc] init];
        self.offset = 0;
        [self getData:self.offset];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    float reload_distance = 10;
    if(y > h + reload_distance) {
        
        
        if(self.isData && self.loaded)
        {
            
            self.loaded = false;
            [self getData:self.offset];
            
            NSLog(@"load more rows");
        }
        
        
    }
    
}

-(void) getData:(int) offset{
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@app/search/client?%@",baseurl,[NSString stringWithFormat:@"offset=%d&phone_number=%@&post_code=%@&limit=%d",offset,self.phoneNo.text,self.postalCode.text,10]]);
    
    
    [self.loading startAnimating];
    [self.view endEditing:YES];
    
    [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@app/search/client",baseurl] bodyString:[NSString stringWithFormat:@"offset=%d&phone_number=%@&post_code=%@&limit=%d",offset,self.phoneNo.text,self.postalCode.text,10]
                                   completion:^(NSDictionary *json, JSONModelError *err) {
                                       
                                       NSLog(@"%@",err);
                                       
                                       NSError* error = nil;
                                       self.data = [[SearchResponse alloc] initWithDictionary:json error:&error];
                                       
                                        NSLog(@"%@",error);
                                       
                                       
                                       if(self.data.responseStat.status){
                                           
                                           NSLog(@"%lu",(unsigned long)self.data.responseData.count);
                                          
                                           
                                           if(self.data.responseData.count>0)
                                           {
                                               for(int i=0;i<self.data.responseData.count;i++)
                                               {
                                                   [self.myObject addObject:self.data.responseData[i]];
                                               }
                                                    self.isData = true;
                                                   
                                           }
                                           else
                                           {
                                               self.isData = false;
                                           }
                                           
                                           if(self.myObject.count > 0)
                                           {
                                               self.tableData.hidden = NO;
                                           }
                                           else
                                           {
                                               self.tableData.hidden = YES;
                                           }
                                           
                                           
                                         
                                           NSLog(@"%@",self.data);
                                           
                                          
                                           self.loaded = true;
                                           self.offset++;
                                           [self.tableData reloadData];
                                           
                                           
                                       }
                                       else
                                       {
                                           self.isData = false;
                                           self.loaded = false;
                                       }
                                       
                                       [self.loading stopAnimating];
                                       
                                       
                                       
                                   }];
}


- (IBAction)phaneChange:(id)sender {
    
    self.phoneClear.hidden = ([self.phoneNo.text isEqual:@""])? YES : NO;
    self.callBtn.hidden = ([self.phoneNo.text isEqual:@""])? YES : NO;
    
}

- (IBAction)postalChange:(id)sender {
    
    self.postalClear.hidden = ([self.postalCode.text isEqual:@""]) ? YES : NO;


}

- (IBAction)phoneClear:(id)sender {
    
    self.phoneNo.text = @"";
    self.phoneClear.hidden = YES;
    self.callBtn.hidden =  YES;
    self.myObject = [[NSMutableArray alloc] init];
    [self.tableData reloadData];
    
    
}

- (IBAction)postalClear:(id)sender {
    
    self.postalCode.text = @"";
    self.postalClear.hidden = YES;
    self.myObject = [[NSMutableArray alloc] init];
    [self.tableData reloadData];
}



- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

-(void)keyboardDidShow:(NSNotification *)notification
{
    
    [self.view addGestureRecognizer:self.singleTap];
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [self.view removeGestureRecognizer:self.singleTap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myObject.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    Client *data = self.myObject[indexPath.row];
    
    cell.textLabel.text = data.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Phone:%@ Postal Code:%@",data.phoneNumber,data.postCode];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"next"]) {
        
        DataDetailsViewController *details =[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableData indexPathForSelectedRow];
        
        Client* data = self.myObject[indexPath.row];
        details.name_ = data.name;
        details.phoneNo_ = data.phoneNumber;
        details.advice_ = data.advice.name;
        details.postalCode_ = data.postCode;
        details.pickUpLocation_ = data.pickupLocation;
        details.excellentCustomer_ = (data.excellentCustomer)? @"YES" : @"NO";
        details.excellentStars_ = [NSString stringWithFormat:@"%d",data.excellentStars];
        details.nonPayer_ = (data.nonPayer)? @"YES" : @"NO";
        details.stars_ = [NSString stringWithFormat:@"%d",data.stars];
        details.incidentNote_ = data.incidentNote;
        details.timeOfIncident_ = data.timeOfIncident;
        
        
        
        
    }

}


@end
