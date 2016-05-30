//
//  User.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/20/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "JSONModel.h"

@interface User : JSONModel

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString  *name;
@property (strong, nonatomic) NSString  *address;
@property (strong, nonatomic) NSString  *email;
@property (strong, nonatomic) NSString  *phoneNumber;
@property (strong, nonatomic) NSString  *createdDate;


+(BOOL)propertyIsOptional:(NSString*)propertyName;
+(BOOL)propertyIsIgnored:(NSString*)propertyName;

@end
