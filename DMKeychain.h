//
//  DMKeychain.h
//  AdGame
//
//  Created by Derek Maurer on 9/22/15.
//  Copyright © 2015 ARJ Holdings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMKeychain : NSObject

+ (void)setAccessIdentifier:(nonnull NSString*)identifier;
+ (nonnull instancetype)shared;

- (void)setObject:(nonnull id)ob forKey:(nonnull NSString*)key;
- (nullable id)objectForKey:(nonnull NSString*)key;

@end
