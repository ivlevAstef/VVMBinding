//
//  VVMLogger.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#ifndef VVMLogger_h
#define VVMLogger_h

#define VVMLog(LEVEL, STRING,...) NSLog(@"[VVM] " LEVEL @": " STRING, ##__VA_ARGS__)

#define VVMLogError(STRING,...) VVMLog(@"Error", STRING, ##__VA_ARGS__)
#define VVMLogWarning(STRING,...) VVMLog(@"Warning", STRING, ##__VA_ARGS__)
#define VVMLogDebug(STRING,...) VVMLog(@"Debug", STRING, ##__VA_ARGS__)
#define VVMLogTrace(STRING,...) VVMLog(@"Trace", STRING, ##__VA_ARGS__)

#define VVMLogAssert(CONDITION) assert(CONDITION)

#endif /* VVMLogger_h */
