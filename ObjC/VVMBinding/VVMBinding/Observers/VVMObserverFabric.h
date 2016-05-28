//
//  VVMObserverFabric.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVMObserverBind.h"

@interface VVMObserverFabric : NSObject

+ (id)createByBind:(VVMObserverBind*)bind withInitial:(BOOL)initial;

@end
