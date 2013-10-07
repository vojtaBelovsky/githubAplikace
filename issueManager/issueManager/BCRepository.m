//
//  BCRepository.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepository.h"
#import "BCHTTPClient.h"
#import "BCUser.h"
#import "BCMilestone.h"
#import "BCOrg.h"
#import "UIAlertView+errorAlert.h"


@implementation BCRepository

- (id)initNoRepositories
{
  self = [super init];
  if (self) {
    _repositoryId = 0;
    _name = NO_REPOSITORIES;
    _issuesUrl = nil;
    _owner = nil;
  }
  return self;
}

- (BOOL)isEqual:(id)other {
  if (other == self)
    return YES;
  if (!other || ![other isKindOfClass:[self class]])
    return NO;
  return [self isEqualToRepository:other];
}

- (BOOL)isEqualToRepository:(BCRepository *)repo {
  if (self == repo)
    return YES;
  if (![(id)[self name] isEqual:[repo name]])
    return NO;
  if (![[self repositoryId] isEqual:[repo repositoryId]])
    return NO;
  return YES;
}

- (NSUInteger)hash {
  NSUInteger hash = 0;
  hash += [[self name] hash];
  hash += [[self repositoryId] hash];
  return hash;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"repositoryId": @"id",
             @"name": @"name",
             @"issuesUrl": @"issues_url",
             @"openIssues" : @"open_issues"
             };
}

+ (NSValueTransformer *)ownerJSONTransformer{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:BCUser.class];
}

+ (NSValueTransformer *)issuesUrlJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        NSString *newStr = [[NSString alloc] initWithString:[str substringToIndex:[str length]-[@"{/number}" length]]];
        return [newStr substringFromIndex:[@"https://api.github.com/" length]];
    } reverseBlock:^(NSString *str) {
        return [[NSString alloc] initWithFormat:@"%@%@%@",@"https://api.github.com/", str, @"{/number}"];
    }];
}

+ (void)getAllRepositoriesFromOrg:(BCOrg *)org WithSuccess:(void (^)(NSMutableArray *allRepositories))success failure:(void(^) (NSError *error)) failure{
  __block NSString *path = [[NSString alloc] initWithFormat:@"orgs/%@/repos", org.orgLogin];
  __block NSMutableArray *allRepositories = [[NSMutableArray alloc] init];
  __block NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  __block int page = 1;
  
  __block void (^myFailureBlock) (AFHTTPRequestOperation *response, NSError *error) = [^(AFHTTPRequestOperation *operation, NSError *error) {
    failure(error);
  } copy];
  
  __block void (^mySuccessBlock) (AFHTTPRequestOperation *operation, id responseObject);
  mySuccessBlock = [^(AFHTTPRequestOperation *operation, id responseObject) {
    NSArray *response = [NSArray arrayWithArray:responseObject];
    for (NSDictionary *object in response) {
      BCRepository *repo = [MTLJSONAdapter modelOfClass:[BCRepository class] fromJSONDictionary:object error:nil];
      [allRepositories addObject:repo];
    }
    if ([response count]) {
      page++;
      [params setObject:[[NSString alloc] initWithFormat:@"%d", page] forKey:@"page"];
      [[BCHTTPClient sharedInstance] getPath:@"user/repos" parameters:params success:mySuccessBlock failure:myFailureBlock];
    }else{
      success ( allRepositories );
      mySuccessBlock = nil;
    }
  } copy];
  
  [[BCHTTPClient sharedInstance] getPath:path parameters:nil success:mySuccessBlock failure:myFailureBlock];
}

+ (void)getAllRepositoriesOfUserWithSuccess:(void (^)(NSMutableArray *repositories))success failure:(void(^) (NSError *error))failure{
  __block int page = 1;
  __block NSMutableArray *allRepositories = [[NSMutableArray alloc] init];
  __block NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  __block void (^myFailureBlock) (AFHTTPRequestOperation *response, NSError *error) = [^(AFHTTPRequestOperation *operation, NSError *error) {
    failure(error);
  } copy];

  __block void (^mySuccessBlock) (AFHTTPRequestOperation *operation, id responseObject);
  mySuccessBlock = [^(AFHTTPRequestOperation *operation, id responseObject) {
    NSArray *response = [NSArray arrayWithArray:responseObject];
    for (NSDictionary *object in response) {
      BCRepository *repo = [MTLJSONAdapter modelOfClass:[BCRepository class] fromJSONDictionary:object error:nil];
      [allRepositories addObject:repo];
    }
    if ([response count]) {
      page++;
      [params setObject:[[NSString alloc] initWithFormat:@"%d", page] forKey:@"page"];
      [[BCHTTPClient sharedInstance] getPath:@"user/repos" parameters:params success:mySuccessBlock failure:myFailureBlock];
    }else{
      success ( allRepositories );
      mySuccessBlock = nil;
    }
  } copy];
  
  [[BCHTTPClient sharedInstance] getPath:@"user/repos" parameters:params success:mySuccessBlock failure:myFailureBlock];
}

+(void)getAllMilestonesOfRepository:(BCRepository *)repository withSuccess:(void(^)(NSMutableArray *allMilestones))success failure:(void(^) (NSError * error))failure{
    NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/milestones",repository.owner.userLogin,repository.name];
    [[BCHTTPClient sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *milestonesInDictionaries = [[NSMutableArray alloc] initWithArray:responseObject];
        NSMutableArray *milestones = [[NSMutableArray alloc] init];
        for(NSDictionary *object in milestonesInDictionaries){
            [milestones addObject:[MTLJSONAdapter modelOfClass:[BCMilestone class] fromJSONDictionary:object error:nil]];
        }
        success ( milestones );
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      failure(error);
    }];
}

+(void)getAllCollaboratorsOfRepository:(BCRepository *)repository withSuccess:(void(^)(NSArray *allCollaborators))success failure:(void(^) (NSError * error))failure{
    NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/collaborators",repository.owner.userLogin,repository.name];
    [[BCHTTPClient sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *collaboratorsInDictionaries = [[NSMutableArray alloc] initWithArray:responseObject];
        NSMutableArray *collaborators = [[NSMutableArray alloc] init];
        for(NSDictionary *object in collaboratorsInDictionaries){
            [collaborators addObject:[MTLJSONAdapter modelOfClass:[BCUser class] fromJSONDictionary:object error:nil]];
        }
        success ( collaborators );
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail");
    }];
}

@end