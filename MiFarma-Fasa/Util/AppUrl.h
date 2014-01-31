//
//  AppUrl.h
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/20/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUrl : NSObject

+ (NSURL *) getApiKey;
+ (NSString *) getUUID;
+ (NSString *) getIdUser;
+ (void) setIdUser:(NSString *)idUser;

+ (void) closeSesion;


+ (NSURL *) getStatus;

+ (NSURL *) getDataUser;
+ (NSURL *) getLoginUser;
+ (NSURL *) getCreateUser;
+ (NSURL *) getUpdateUser;
+ (NSURL *) getForgotPassword;


+ (NSURL *) getDataAddress;
+ (NSURL *) getUpdateAddress;
+ (NSURL *) getCreateAddress;
+ (NSURL *) getDeleteAddress;

+ (NSURL *) getUpdateConfig;


@end
