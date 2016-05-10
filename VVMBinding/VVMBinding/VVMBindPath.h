//
//  VVMBindPath.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVMBindPath : NSObject

@property (nonatomic, weak) id parent;
@property (nonatomic, copy) NSString* keyPath;

+ (VVMBindPath*)path:(id)parent :(NSString*)keyPath;

@end
