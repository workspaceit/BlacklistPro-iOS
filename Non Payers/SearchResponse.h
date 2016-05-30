//
//  SearchResponse.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/20/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "JSONModel.h"
#import "ResponseStatus.h"
#import "Client.h"

@interface SearchResponse : JSONModel

@property (strong,nonatomic) ResponseStatus *responseStat;
@property (strong,nonatomic) NSArray <Client> *responseData;

+(BOOL)propertyIsOptional:(NSString*)propertyName;
+(BOOL)propertyIsIgnored:(NSString*)propertyName;


@end
