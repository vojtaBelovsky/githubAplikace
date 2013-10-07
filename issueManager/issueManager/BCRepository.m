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
#import "BCLabel.h"
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

+(void)getAllLabelsOfRepository:(BCRepository *)repository withSuccess:(void(^)(NSArray *allLables))success failure:(void(^) (NSError * error))failure{
    NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/labels",repository.owner.userLogin,repository.name];
    [[BCHTTPClient sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *labelsInDictionaries = [[NSMutableArray alloc] initWithArray:responseObject];
        NSMutableArray *labels = [[NSMutableArray alloc] init];
        for(NSDictionary *object in labelsInDictionaries){
            [labels addObject:[MTLJSONAdapter modelOfClass:[BCLabel class] fromJSONDictionary:object error:nil]];
        }
        success ( labels );
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail");
    }];
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

//+ (void)getAllRepositoriesFromUser:(BCUser *)user WithSuccess:(void (^)(NSArray *allRepositories))success failure:(void(^) (NSError *error)) failure{
//    NSString *path = [[NSString alloc] initWithFormat:@"/users/%@/repos", user.userLogin];
//    [[BCHTTPClient sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
//        
//        NSArray *response = [NSArray arrayWithArray:responseObject];
//        NSMutableArray *repositories = [NSMutableArray arrayWithCapacity:([response count]+1)];
//        [repositories addObject:user];
//        for (NSDictionary *object in response) {
//            [repositories addObject:[MTLJSONAdapter modelOfClass:[BCRepository class] fromJSONDictionary:object error:nil]];
//        }
//        success ( repositories );
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        [UIAlertView showWithError:error];
//    }];
//}

@end