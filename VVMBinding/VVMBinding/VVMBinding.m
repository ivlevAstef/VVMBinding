//
//  VVMBinding.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMBinding.h"

#import "VVMBind.h"
#import "VVMKVObserver.h"

@interface VVMBinding ()

@property (nonatomic, strong) NSMapTable<VVMBindPath*, VVMBindBase*>* binds;

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
    assert(nil != parent && nil != keyPath && nil != parent2 && nil != keyPath2);
    
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
    VVMBind* bindObj = [VVMBind createByPath:path withCallPath:path2];
    
    VVMBindBase* baseBindObj = [self.binds objectForKey:path2];
    if (nil != baseBindObj) {
        [baseBindObj copyTo:bindObj];
        [baseBindObj unbind];
    }
    
    [self.binds setObject:bindObj forKey:path2];
    [VVMKVObserver createFor:bindObj];
    
    if (initial) {
        [bindObj initial];
    }
}

- (VVMBindBase*)baseBindByPath:(VVMBindPath*)path {
    VVMBindBase* result = [self.binds objectForKey:path];
    
    if (nil == result) {
        result = [VVMBindBase createByPath:path];
        [self.binds setObject:result forKey:path];
    }
    
    return result;
}

+ (id<IVVMBind>)bindObject:(id)parent keyPath:(NSString*)keyPath {
    VVMBindPath* path = [VVMBindPath path:parent :keyPath];
    return [[self defaultBinding] baseBindByPath:path];
}

@end
