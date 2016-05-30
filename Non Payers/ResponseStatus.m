//
//  ResponseStatus.m
//  Non Payers
//
//  Created by Workspace Infotech on 10/20/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "ResponseStatus.h"

@implementation ResponseStatus

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if([propertyName isEqualToString:@"msg"])
        return YES;
    
    return NO;
}


+(BOOL)propertyIsIgnored:(NSString*)propertyName
{
    
    return NO;
}

@end
