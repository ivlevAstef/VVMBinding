//
//  VVMBind.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 07/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVMBind : NSObject

+ (instancetype)createFor:(id)obj withKeyPath:(NSString*)keyPath withCallObj:(id)callObj withKeyPath:(NSString*)callKeyPath;

@property (nonatomic, readonly) id obj;
@property (nonatomic, readonly) NSString* keyPath;

@property (nonatomic, readonly, weak) id callObj;
@property (nonatomic, readonly) NSString* callKeyPath;

- (BOOL)check:(id)newValue;
- (id)modification:(id)newValue;
- (void)update:(id)newValue;

@end
