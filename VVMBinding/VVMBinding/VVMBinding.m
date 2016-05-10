//
//  VVMBinding.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMBinding.h"
#import "VVMLogger.h"

#import "VVMObserverBind.h"
#import "VVMObserverFabric.h"

@interface VVMBinding ()

@property (nonatomic, strong) NSMapTable<VVMBindPath*, VVMBind*>* binds;

@end

@implementation VVMBinding

+ (instancetype)defaultBinding {
    static dispatch_once_t onceToken;
    static VVMBinding* once = nil;
    dispatch_once(&onceToken, ^{
        once = [VVMBinding new];
    });
    return once;
}

- (id)init {
    self = [super init];
    if (self) {
        self.binds = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory];
    }
    
    return self;
}

+ (void)bind:(id)parent keyPath:(NSString*)keyPath direction:(eVVMBindingDirection)direction initial:(eVVMBindingInitial)initial with:(id)parent2 keyPath:(NSString*)keyPath2 {
    VVMLogAssert(nil != parent && nil != keyPath && nil != parent2 && nil != keyPath2);
    
    VVMBindPath* path = [VVMBindPath path:parent :keyPath];
    VVMBindPath* path2 = [VVMBindPath path:parent2 :keyPath2];
    
    if (eVVMBindingDirection_To == (direction & eVVMBindingDirection_To)) {
        [[self defaultBinding] bind:path with:path2 initial:(eVVMBindingInitial_To == initial)];
    }
    
    if (eVVMBindingDirection_From == (direction & eVVMBindingDirection_From)) {
        [[self defaultBinding] bind:path2 with:path initial:(eVVMBindingInitial_From == initial)];
    }
}

- (void)bind:(VVMBindPath*)path with:(VVMBindPath*)path2 initial:(BOOL)initial {
    VVMObserverBind* observerBindObj = [VVMObserverBind createByPath:path withCallPath:path2];
    
    VVMBind* bindObj = [self.binds objectForKey:path2];
    if (nil != bindObj) {
        [bindObj copyTo:observerBindObj];
        [bindObj unbind];
    }
    
    [self.binds setObject:observerBindObj forKey:path2];
    
    id __attribute__((unused)) unused = [VVMObserverFabric createByBind:observerBindObj withInitial:initial];
    
    VVMLogDebug(@"Bind created for: %@", observerBindObj);
}

- (VVMBind*)baseBindByPath:(VVMBindPath*)path {
    VVMBind* result = [self.binds objectForKey:path];
    
    if (nil == result) {
        result = [VVMBind createByPath:path];
        [self.binds setObject:result forKey:path];
        
        VVMLogDebug(@"Create temp bind. for: %@", result);
    }
    
    return result;
}

+ (id<IVVMBind>)bindObject:(id)parent keyPath:(NSString*)keyPath {
    VVMLogAssert(nil != parent && nil != keyPath);
    
    VVMBindPath* path = [VVMBindPath path:parent :keyPath];
    return [[self defaultBinding] baseBindByPath:path];
}

@end
