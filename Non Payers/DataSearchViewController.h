//
//  DataSearchViewController.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/19/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResponse.h"

@interface DataSearchViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults *defaults;
    NSString *baseurl;
}


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) SearchResponse *data;
@property (strong, nonatomic) NSMutableArray *myObject;
@property (strong, nonatomic) UIView *keyboardBorder;
@property (strong, nonatomic) IBOutlet UITableView *tableData;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (strong, nonatomic) IBOutlet UITextField *phoneNo;
@property (strong, nonatomic) IBOutlet UITextField *postalCode;
@property (strong, nonatomic) IBOutlet UIButton *phoneClear;
@property (strong, nonatomic) IBOutlet UIButton *postalClear;
@property (assign,nonatomic) int offset;
@property (assign,nonatomic) BOOL isData;
@property (assign,nonatomic) BOOL loaded;
@property (strong, nonatomic) IBOutlet UIButton *callBtn;

@end
