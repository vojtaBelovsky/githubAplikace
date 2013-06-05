//
//  VBHTTPClient.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/19/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCHTTPClient.h"
#import "BCUser.h"
#import "UIAlertView+errorAlert.h"

#define BCHTTPCLIENT_BASE_URL @"https://api.github.com/"

@implementation BCHTTPClient

- (id)initWithBaseURL:(NSURL *)url UserName:(NSString *)userName andPassword:(NSString *)password {
    self = [super initWithBaseURL:url];
    if ( self ) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setAuthorizationHeaderWithUsername:userName password:password];
        [self setParameterEncoding:AFJSONParameterEncoding];
    }
    return self;
}

+ (void)patchPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [[self sharedInstance] patchPath:path parameters:parameters success:success failure:failure];
}

+ (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [[self sharedInstance] postPath:path parameters:parameters success:success failure:failure];
}

+ (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [[self sharedInstance] getPath:path parameters:parameters success:success failure:failure];
}

+ (BCHTTPClient *)sharedInstance{//NSUserDefaults - puzit pro ukladani hesla a uziv. jmena
    static BCHTTPClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *credentials = [userDefaults objectForKey:@"credentials"];
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:BCHTTPCLIENT_BASE_URL] UserName:[credentials valueForKey:@"login"] andPassword:[credentials valueForKey:@"password"]];
    });
    return instance;
}

@end
