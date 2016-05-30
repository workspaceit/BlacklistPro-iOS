//
//  DataEntryViewController.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/19/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntryResponse.h"
#import "AdviceResponse.h"

@interface DataEntryViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults *defaults;
    NSString *baseurl;
}

@property (strong, nonatomic) UIBarButtonItem *backBtn;
@property (strong, nonatomic) UIView *keyboardBorder;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (nonatomic, strong) EntryResponse *response;
@property (nonatomic, strong) AdviceResponse *responseAdvice;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (strong, nonatomic) IBOutlet UITableView *tableData;
@property (strong, nonatomic) IBOutlet UITextField *phoneNo;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *postCode;
@property (strong, nonatomic) IBOutlet UITextField *pickUpLocation;
@property (strong, nonatomic) IBOutlet UISwitch *nonPayer;
@property (strong, nonatomic) IBOutlet UITextField *timeOfIncident;
@property (strong, nonatomic) IBOutlet UITextField *incidentNote;
@property (strong, nonatomic) IBOutlet UIButton *advice;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) IBOutlet UIScrollView *mainContainer;
@property (strong, nonatomic) IBOutlet UIButton *star1;
@property (strong, nonatomic) IBOutlet UIButton *star2;
@property (strong, nonatomic) IBOutlet UIButton *star3;
@property (strong, nonatomic) IBOutlet UIButton *star4;
@property (strong, nonatomic) IBOutlet UIButton *star5;
@property (strong, nonatomic) IBOutlet UIView *starContainer;
@property (strong, nonatomic) IBOutlet UISwitch *excellentCustomer;
@property (strong, nonatomic) IBOutlet UIButton *estar1;
@property (strong, nonatomic) IBOutlet UIButton *estar2;
@property (strong, nonatomic) IBOutlet UIButton *estar3;
@property (strong, nonatomic) IBOutlet UIButton *estar4;
@property (strong, nonatomic) IBOutlet UIButton *estar5;
@property (strong, nonatomic) IBOutlet UIView *estarContainer;

@property (assign, nonatomic) BOOL autoPop;
@property (assign, nonatomic) int starValue;
@property (assign, nonatomic) int estarValue;
@property (assign, nonatomic) int adviceId;
@property (assign, nonatomic) int nonPayerValue;
@property (assign, nonatomic) int excellentCustomerValue;

@end
