//
//  Response.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/22/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "JSONModel.h"
#import "ResponseStatus.h"

@interface Response : JSONModel

@property (strong,nonatomic) ResponseStatus *responseStat;


+(BOOL)propertyIsOptional:(NSString*)propertyName;
+(BOOL)propertyIsIgnored:(NSString*)propertyName;

@end
