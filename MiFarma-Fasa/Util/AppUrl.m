//
//  AppUrl.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/20/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "AppUrl.h"


#define KApiKey @"1D2C49CB91C134A76E2AEC6DBFB2A"

#define KServerURL @"http://mifarma.katucms.com"

#define KURIGetStatus @"/api/get-status"
#define KURIGetMarcarStatus @"/api/marcar-status"

#define KURIPostRegisterUser @"/api/register-user"
#define KURIPostUpdateUser @"/api/update-user"
#define KURIPostGetDataUser @"/api/get-data-user"
#define KURIPostGetLoginUser @"/api/login-user"
#define KURIPostFotgotPassword @"/api/forgot-password"

#define KURIPostGetAddress @"/api/get-address"
#define KURIPostCreateAddress @"/api/create-address"
#define KURIPostUpdateAddress @"/api/update-address"
#define KURIPostDeleteAddress @"/api/delete-address"

#define KURIPostUpdateConfig @"/api/update-check-config"


@implementation AppUrl


+ (NSURL *) getApiKey {
    return [NSURL URLWithString:KApiKey];
}

+ (NSString *) getUUID {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs objectForKey:@"UUID"];
}
+ (NSString *) getIdUser {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs objectForKey:@"idUser"];
}
+ (void) setIdUser:(NSString *)idUser {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:idUser forKey:@"idUser"];
}

+ (void) closeSesion{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:nil forKey:@"idUser"];
}


# pragma mark STATUS


# pragma mark - GET STATUS
+ (NSURL *) getStatus {
    NSString *stringURL = [NSString stringWithFormat:@"%@%@/apikey/%@/uuid/%@", KServerURL, KURIGetStatus, KApiKey, [[NSUserDefaults standardUserDefaults] stringForKey:@"UUID"]];
    return [NSURL URLWithString:stringURL];
}

# pragma mark - GET MARCAR STATUS
+ (NSURL *) getMarcarStatus {
    NSString *stringURL = [NSString stringWithFormat:@"%@%@/apikey/%@/uuid/%@", KServerURL, KURIGetMarcarStatus, KApiKey, [[NSUserDefaults standardUserDefaults] stringForKey:@"UUID"]];
    return [NSURL URLWithString:stringURL];
}


# pragma mark USUARIO

+ (NSURL *) getDataUser {
    NSString *stringURL = [NSString stringWithFormat:@"%@%@/apikey/%@", KServerURL, KURIPostGetDataUser, KApiKey];
    return [NSURL URLWithString:stringURL];
}
+ (NSURL *) getLoginUser {
    NSString *stringURL = [NSString stringWithFormat:@"%@%@", KServerURL, KURIPostGetLoginUser];
    return [NSURL URLWithString:stringURL];
}
+ (NSURL *) getCreateUser {
    NSString *stringURL = [NSString stringWithFormat:@"%@%@", KServerURL, KURIPostRegisterUser];
    return [NSURL URLWithString:stringURL];
}
+ (NSURL *) getUpdateUser {
    NSString *stringURL = [NSString stringWithFormat:@"%@%@", KServerURL, KURIPostUpdateUser];
    return [NSURL URLWithString:stringURL];
}
+ (NSURL *) getForgotPassword {
    NSString *stringURL = [NSString stringWithFormat:@"%@%@/apikey/%@", KServerURL, KURIPostFotgotPassword, KApiKey];
    return [NSURL URLWithString:stringURL];
}

#pragma mark ADDRESS

+ (NSURL *) getDataAddress {
    NSString *stringURL = [NSString stringWithFormat:@"%@%@/apikey/%@", KServerURL, KURIPostGetAddress,  KApiKey];
    return [NSURL URLWithString:stringURL];
}

+ (NSURL *) getUpdateAddress {
    NSString *stringURL = [NSString stringWithFormat:@"%@%@/apikey/%@", KServerURL, KURIPostUpdateAddress,  KApiKey];
    return [NSURL URLWithString:stringURL];
}

+ (NSURL *) getCreateAddress {
    NSString *stringURL = [NSString stringWithFormat:@"%@%@/apikey/%@", KServerURL, KURIPostCreateAddress,  KApiKey];
    return [NSURL URLWithString:stringURL];
}

+ (NSURL *) getDeleteAddress {
    NSString *stringURL = [NSString stringWithFormat:@"%@%@/apikey/%@", KServerURL, KURIPostDeleteAddress,  KApiKey];
    return [NSURL URLWithString:stringURL];
}

#pragma mark CONFIG

+ (NSURL *) getUpdateConfig {
    NSString *stringURL = [NSString stringWithFormat:@"%@%@/apikey/%@", KServerURL, KURIPostUpdateConfig,  KApiKey];
    return [NSURL URLWithString:stringURL];
}






#pragma mark - GLOBAL FUNCTION
+ (NSURL *) getGlobalURL {
    return [NSURL URLWithString:KServerURL];
}

@end
