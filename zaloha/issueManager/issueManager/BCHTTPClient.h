//
//  VBHTTPClient.h
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/19/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

#define CREDENTIALS @"credentials"
#define LOGIN       @"login"
#define PASSWORD    @"password"

@class BCUser;

@interface BCHTTPClient : AFHTTPClient

+ (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)patchPath:(NSString *)path
       parameters:(NSDictionary *)parameters
          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (BCHTTPClient *)sharedInstance;
//+ (BCHTTPClient *)sharedInstanceWithUserName:(NSString *)userName andPassword:(NSString *)password;

@end
