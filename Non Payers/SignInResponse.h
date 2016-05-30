//
//  SignInResponse.h
//  Non Payers
//
//  Created by Workspace Infotech on 10/20/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "JSONModel.h"
#import "ResponseStatus.h"
#import "AuthCredential.h"


@interface SignInResponse : JSONModel

@property (strong,nonatomic) ResponseStatus *responseStat;
@property (strong,nonatomic) AuthCredential <Optional> *responseData;

@end
