//
//  VVMObserverFabric.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMObserverFabric.h"

#import "VVMInitialObserver.h"

#import "VVMKVObserver.h"
#import "VVMUITextFieldObserver.h"
#import "VVMUISwitchObserver.h"

#import <UIKit/UIKit.h>

@implementation VVMObserverFabric

+ (id)createByBind:(VVMObserverBind*)bind withInitial:(BOOL)initial {
    if (initial) {
        id __attribute__((unused)) unused = [[VVMInitialObserver alloc] initByBind:bind];
    }
    
    id observer = nil;
    
    if ([self path:bind.path isKindOf:[UITextField class] andValue:@"text"]) {
        UITextField* textField = [self path:bind.path getObjectKindOf:[UITextField class]];
        observer = [[VVMUITextFieldObserver alloc] initByBind:bind UseTextField:textField];
        
    } else if ([self path:bind.path isKindOf:[UISwitch class] andValue:@"on"] ||
               [self path:bind.path isKindOf:[UISwitch class] andValue:@"isOn"]) {
        UISwitch* uiSwitch = [self path:bind.path getObjectKindOf:[UISwitch class]];
        observer = [[VVMUISwitchObserver alloc] initByBind:bind UseSwitch:uiSwitch];
        
    } else {
        observer = [[VVMKVObserver alloc] initByBind:bind];
    }
    
    bind.observer = observer;
    return observer;
}

+ (id)path:(VVMBindPath*)path getObjectKindOf:(Class)class {
    NSArray<NSString*>* separatedPath = [path.keyPath componentsSeparatedByString:@"."];
    
    id iter = path.parent;
    for (NSString* subpath in separatedPath) {
        if ([iter isKindOfClass:class]) {
            return iter;
        }
        iter = [iter valueForKey:subpath];
    }
    
    return nil;
}

+ (BOOL)path:(VVMBindPath*)path isKindOf:(Class)class andValue:(NSString*)value {
    NSArray<NSString*>* separatedPath = [path.keyPath componentsSeparatedByString:@"."];
    
    id iter = path.parent;
    for(NSUInteger index = 0; index < separatedPath.count; index++) {
        if ([iter isKindOfClass:class]) {
            NSArray<NSString*>* separatedPathTail = [separatedPath subarrayWithRange:NSMakeRange(index, [separatedPath count] - index)];
            
            if ([value isEqualToString:[separatedPathTail componentsJoinedByString:@"."]]) {
                return TRUE;
            }
            
            return FALSE;
        }
        
        iter = [iter valueForKey:[separatedPath objectAtIndex:index]];
    }
    
    return FALSE;
}

@end
