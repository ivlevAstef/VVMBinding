//
//  VVMBindPath.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMBindPath.h"

@implementation VVMBindPath

+ (VVMBindPath*)path:(id)parent :(NSString*)keyPath {    
    VVMBindPath* result = [VVMBindPath new];
    result.parent = parent;
    result.keyPath = keyPath;
    
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

@end
