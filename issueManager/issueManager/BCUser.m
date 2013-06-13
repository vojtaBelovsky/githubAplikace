//
//  BCUser.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCUser.h"
#import "BCHTTPClient.h"
#import "UIAlertView+errorAlert.h"

@implementation BCUser

- (id)initWithUser:(BCUser *)user
{
    self = [super init];
    if (self) {
        _userId = user.userId;
        _userLogin = user.userLogin;
        _avatarUrl = user.avatarUrl;
        _htmlUrl = user.htmlUrl;
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userLogin": @"login",
             @"userId": @"id",
             @"avatarUrl" : @"avatar_url",
             @"htmlUrl": @"html_url"
             };
}

+ (NSValueTransformer *)avatarUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)htmlUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (BCUser *)sharedInstanceChangeableWithUser:(BCUser *)changeUser succes:(void(^)(BCUser *user))succes failure:(void(^)(NSError *error))failure{
    static BCUser *instance = nil;
    if(changeUser == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[BCHTTPClient sharedInstance] getPath:@"user" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *userInDict = responseObject;
              BCUser *chosenUser = [MTLJSONAdapter modelOfClass:[BCUser class] fromJSONDictionary:userInDict error:nil];
              instance = chosenUser;
              succes ( chosenUser );
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              onceToken++;
              failure ( error );
            }];
        });
    }else{
        instance = changeUser;
    }

    return instance;
}

@end
