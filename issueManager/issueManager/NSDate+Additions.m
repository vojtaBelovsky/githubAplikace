/**
 * Copyright (c) 2013, Tapmates s.r.o. (www.tapmates.com).
 *
 * All rights reserved. This source code can be used only for purposes specified
 * by the given license contract signed by the rightful deputy of Tapmates s.r.o.
 * This source code can be used only by the owner of the license.
 *
 * Any disputes arising in respect of this agreement (license) shall be brought
 * before the Municipal Court of Prague.
 *
 */

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

- (NSString*)stringDifferenceFromNow {
  NSTimeInterval interval = [self timeIntervalSinceNow];
  double minutes = ((double)interval) / 60.0f;
  if (minutes > 0) {
    
    if ( minutes < 60.0f ) {
      return [NSString stringWithFormat:NSLocalizedString(@"Due in %d minutes", @""), (int)minutes];
    }
    if ( minutes < 1440.0f ) {
      return [NSString stringWithFormat:NSLocalizedString(@"Due in %d hours", @""), (int)(minutes / 60.0f)];
    }
    if ( minutes < 43200.0f ) {
      return [NSString stringWithFormat:NSLocalizedString(@"Due in %d days", @""), (int)(minutes / 1440.0f)];
    }
    if ( minutes < 525600.0f ) {
      return [NSString stringWithFormat:NSLocalizedString(@"Due in %d months", @""), (int)(minutes / 43200.0f)];
    }
    
    return [NSString stringWithFormat:NSLocalizedString(@"Due in %d years", @""), (int)(minutes / 525600.0f)];
  }else{
    minutes = fabs(minutes);
    
    if ( minutes < 60.0f ) {
      return [NSString stringWithFormat:NSLocalizedString(@"Passed by %d minutes", @""), (int)(minutes / 60.0f)];
    }
    if ( minutes < 1440.0f ) {
      return [NSString stringWithFormat:NSLocalizedString(@"Passed by %d hours", @""), (int)(minutes / 60.0f)];
    }
    if ( minutes < 43200.0f ) {
      return [NSString stringWithFormat:NSLocalizedString(@"Passed by %d days", @""), (int)(minutes / 1440.0f)];
    }
    if ( minutes < 525600.0f ) {
      return [NSString stringWithFormat:NSLocalizedString(@"Passed by %d months", @""), (int)(minutes / 43200.0f)];
    }
    
    return [NSString stringWithFormat:NSLocalizedString(@"Passed byt %d years", @""), (int)(minutes / 525600.0f)];
  }
}

- (NSString*)stringDifferenceFromNowDetailStyle {
  
  NSTimeInterval interval = fabsf([self timeIntervalSinceNow]);
  double minutes = ((double)interval) / 60.0;
  
  if ( minutes < 2.0 ) {
    return NSLocalizedString(@"1 min", @"");
  } else if ( minutes < 60.0 ) {
    return [NSString stringWithFormat:NSLocalizedString(@"%d mins", @""), (int)minutes];
  } else if ( minutes < 120.0 ) {
    return NSLocalizedString(@"1 hour", @"");
  } else if ( minutes < 1440.0 ) {
    return [NSString stringWithFormat:NSLocalizedString(@"%d hours", @""), (int)(minutes / 60.0f)];
  } else if ( minutes < 2880.0 ) {
    return NSLocalizedString(@"1 day", @"");
  } else if ( minutes < 43200.0 ) {
    return [NSString stringWithFormat:NSLocalizedString(@"%d days", @""), (int)(minutes / 1440.0f)];
  } else if ( minutes < 86400.0 ) {
    return NSLocalizedString(@"1 month", @"");
  } else if ( minutes < 525600.0 ) {
    return [NSString stringWithFormat:NSLocalizedString(@"%d months", @""), (int)(minutes / 43200.0f)];
  } else if ( minutes < 1051200.0 ) {
    return NSLocalizedString(@"1 year", @"");
  } else {
    return [NSString stringWithFormat:NSLocalizedString(@"%d years", @""), (int)(minutes / 525600.0f)];
  }
  
  
}

@end
