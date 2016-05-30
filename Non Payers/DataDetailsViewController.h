//
//  DataDetailsViewController.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/19/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataDetailsViewController : UIViewController

@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phoneNo;
@property (strong, nonatomic) IBOutlet UILabel *postalCode;
@property (strong, nonatomic) IBOutlet UILabel *pickUpLocation;
@property (strong, nonatomic) IBOutlet UILabel *nonPayer;
@property (strong, nonatomic) IBOutlet UILabel *stars;
@property (strong, nonatomic) IBOutlet UILabel *timeOfIncident;
@property (strong, nonatomic) IBOutlet UILabel *incidentNote;
@property (strong, nonatomic) IBOutlet UILabel *advice;
@property (strong, nonatomic) IBOutlet UILabel *excellentCustomer;
@property (strong, nonatomic) IBOutlet UILabel *excellentStars;

@property (strong, nonatomic) NSString *name_;
@property (strong, nonatomic) NSString *phoneNo_;
@property (strong, nonatomic) NSString *postalCode_;
@property (strong, nonatomic) NSString *pickUpLocation_;
@property (strong, nonatomic) NSString *nonPayer_;
@property (strong, nonatomic) NSString *stars_;
@property (strong, nonatomic) NSString *excellentCustomer_;
@property (strong, nonatomic) NSString *excellentStars_;
@property (strong, nonatomic) NSString *timeOfIncident_;
@property (strong, nonatomic) NSString *incidentNote_;
@property (strong, nonatomic) NSString *advice_;


@end
