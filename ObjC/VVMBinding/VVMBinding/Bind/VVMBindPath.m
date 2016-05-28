//
//  VVMBindPath.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMBindPath.h"
#import "VVMLogger.h"

@implementation VVMBindPath

+ (VVMBindPath*)path:(id)parent :(NSString*)keyPath {    
    VVMBindPath* result = [VVMBindPath new];
    result.parent = parent;
    result.keyPath = keyPath;
    
    VVMLogTrace(@"Create Bind path for: %@.%@", result.parent, result.keyPath);
    
    return result;
}

- (BOOL)isEqual:(VVMBindPath*)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[VVMBindPath class]]) {
        return NO;
    }
    
    return self.parent == object.parent && [self.keyPath isEqualToString:object.keyPath];
}

- (NSUInteger)hash {
    return [self.parent hash] ^ [self.keyPath hash];
}

- (id)vvmObjectKindOfClass:(Class)aClass {
    NSArray<NSString*>* separatedPath = [self.keyPath componentsSeparatedByString:@"."];
  
    id iter = self.parent;
    for (NSUInteger index = 0; index <=separatedPath.count; index++) {
        if ([iter isKindOfClass:aClass]) {
            return iter;
        }
        
        if (index < separatedPath.count) {
            iter = [iter valueForKey:[separatedPath objectAtIndex:index]];
        }
    }
  
  return nil;
}

- (BOOL)vvmIsKindOfClass:(Class)aClass {
  return (nil != [self vvmObjectKindOfClass:aClass]);
}

- (BOOL)vvmIsKindOfClass:(Class)aClass AndValue:(NSString*)valuePath {
    NSArray<NSString*>* separatedPath = [self.keyPath componentsSeparatedByString:@"."];

    id iter = self.parent;
    for(NSUInteger index = 0; index <= separatedPath.count; index++) {
        if ([iter isKindOfClass:aClass]) {
            NSArray<NSString*>* separatedPathTail = [separatedPath subarrayWithRange:NSMakeRange(index, [separatedPath count] - index)];

            return [valuePath isEqualToString:[separatedPathTail componentsJoinedByString:@"."]];
        }
    
        if (index < separatedPath.count) {
            iter = [iter valueForKey:[separatedPath objectAtIndex:index]];
        }
    }

    return FALSE;
}

@end
