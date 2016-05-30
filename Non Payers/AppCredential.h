//
//  AppCredential.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/20/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "JSONModel.h"
#import "User.h"

@interface AppCredential : JSONModel

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString  *userName;
@property (strong, nonatomic) NSString <Optional>  *password;
@property (strong, nonatomic) User  *user;
@property (strong, nonatomic) NSString  *createdDate;


+(BOOL)propertyIsOptional:(NSString*)propertyName;
+(BOOL)propertyIsIgnored:(NSString*)propertyName;

@end
