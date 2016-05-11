//
//  VVMObserver.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 11/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMObserverBind.h"

@interface VVMObserver : NSObject

- (id)initByBind:(VVMObserverBind*)bind;

- (void)initial;

@property (nonatomic, readonly, weak) VVMObserverBind* bind;

- (void)update:(id)newValue;

@end
