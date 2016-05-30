//
//  Client.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/20/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "JSONModel.h"
#import "Advice.h"

@protocol Client

@end

@interface Client : JSONModel


@property (strong, nonatomic) NSString  *phoneNumber;
@property (strong, nonatomic) NSString  *name;
@property (strong, nonatomic) NSString  *postCode;
@property (strong, nonatomic) NSString  *pickupLocation;
@property (assign, nonatomic) BOOL excellentCustomer;
@property (assign, nonatomic) int excellentStars;
@property (assign, nonatomic) BOOL nonPayer;
@property (assign, nonatomic) int stars;
@property (strong, nonatomic) NSString  *incidentNote;
@property (strong, nonatomic) Advice  *advice;
@property (strong, nonatomic) NSString  *timeOfIncident;


+(BOOL)propertyIsOptional:(NSString*)propertyName;
+(BOOL)propertyIsIgnored:(NSString*)propertyName;



@end
