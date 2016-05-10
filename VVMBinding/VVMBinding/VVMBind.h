//
//  VVMBind.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 07/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVVMBind.h"

@interface VVMBind : NSObject<IVVMBind>

+ (instancetype)createFor:(id)obj withKeyPath:(NSString*)keyPath withCallObj:(id)callObj withKeyPath:(NSString*)callKeyPath initial:(BOOL)initial;

@property (nonatomic, readonly, weak) id obj;
@property (nonatomic, readonly) NSString* keyPath;

@property (nonatomic, readonly, weak) id callObj;
@property (nonatomic, readonly) NSString* callKeyPath;

- (BOOL)check:(id)newValue;
- (id)transformation:(id)newValue;
- (void)update:(id)newValue;

@end
