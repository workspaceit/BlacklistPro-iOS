//
//  AuthCredential.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/20/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "JSONModel.h"
#import "AppCredential.h"

@interface AuthCredential : AppCredential

@property (strong, nonatomic) NSString  *accessToken;

+(BOOL)propertyIsOptional:(NSString*)propertyName;
+(BOOL)propertyIsIgnored:(NSString*)propertyName;

@end
