//
//  VBHTTPClient.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/19/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCHTTPClient.h"
#define BCHTTPCLIENT_BASE_URL @"https://api.github.com/"

@implementation BCHTTPClient

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if ( self ) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setAuthorizationHeaderWithUsername:@"vojtaBelovsky" password:@"tr1n1t1"];
    }
    return self;
}



+ (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [[self sharedInstance] getPath:path parameters:parameters success:success failure:failure];
}

+ (BCHTTPClient *)sharedInstance {
    static BCHTTPClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:BCHTTPCLIENT_BASE_URL]];
    });
    return instance;
}

@end
