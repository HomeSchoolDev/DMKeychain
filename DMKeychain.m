//
//  DMKeychain.m
//  AdGame
//
//  Created by Derek Maurer on 9/22/15.
//  Copyright © 2015 ARJ Holdings. All rights reserved.
//

#import "DMKeychain.h"
#import "DMKeychainItemWrapper.h"

static DMKeychain *sharedKeychain = nil;

@interface DMKeychain ()

@property (nonatomic, strong) NSString *identifier;

@end

@implementation DMKeychain

#pragma mark Init

+ (nonnull instancetype)shared {
    @synchronized(self) {
        if (!sharedKeychain)
            NSLog(@"You haven't called setAccessIdentifier: yet. Please call it before doing anything else.");

        return sharedKeychain;
    }
}

+ (void)setAccessIdentifier:(nonnull NSString*)identifier {
    if (sharedKeychain) sharedKeychain = nil;
    sharedKeychain = [[DMKeychain alloc] initWithIdentifier:identifier];
}

- (id)initWithIdentifier:(NSString*)identifier {
    self = [super init];
    
    if (self) {
        self.identifier = identifier;
    }
    
    return self;
}

#pragma mark JsonAccessMethods

- (NSData*)jsonData {
    DMKeychainItemWrapper *wrapper = [[DMKeychainItemWrapper alloc] initWithIdentifier:self.identifier accessGroup:nil];
    [wrapper setObject:self.identifier forKey:(id)kSecAttrService];
    NSString *jsonString = [wrapper objectForKey:(NSString*)kSecValueData];
    
    if (jsonString && ![jsonString isEqualToString:@""]) return [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    return nil;
}

- (void)setJsonData:(NSData*)data {
    if (data) {
        DMKeychainItemWrapper *wrapper = [[DMKeychainItemWrapper alloc] initWithIdentifier:self.identifier accessGroup:nil];
        [wrapper setObject:self.identifier forKey:(id)kSecAttrService];
        [wrapper setObject:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] forKey:(NSString*)kSecValueData];
    }
    else {
        NSLog(@"Couldn't write JSON to keychain because it was nil");
    }
}

- (void)setObject:(nonnull id)ob forKey:(nonnull NSString*)key {
    NSData *jsonData = [self jsonData];
    NSMutableDictionary *json = nil;
    
    if (jsonData) {
        NSError *jsonError = nil;
        json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
        if (jsonError) NSLog(@"Failed to create JSON object from JSON data with error: %@", jsonError);
    }
    else {
        json = [[NSMutableDictionary alloc] init];
    }
    
    if (json) {
        [json setObject:ob forKey:key];
        
        NSError *jsonError = nil;
        NSData *newJsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&jsonError];
        
        if (jsonError) NSLog(@"Failed to serialize JSON object to NSData with error: %@", jsonError);
        else [self setJsonData:newJsonData];
    }
}

- (nullable id)objectForKey:(nonnull NSString*)key {
    NSData *jsonData = [self jsonData];
    
    if (jsonData) {
        NSError *jsonError = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
        
        if (jsonError) NSLog(@"Failed to create JSON object from JSON data with error: %@", jsonError);
        else return [json objectForKey:key];
    }
    
    return nil;
}

@end
