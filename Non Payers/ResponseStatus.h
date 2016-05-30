//
//  ResponseStatus.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/20/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "JSONModel.h"

@interface ResponseStatus : JSONModel

@property (assign, nonatomic) BOOL status;
@property (strong, nonatomic) NSString <Optional> *msg;

+(BOOL)propertyIsOptional:(NSString*)propertyName;
+(BOOL)propertyIsIgnored:(NSString*)propertyName;


@end
