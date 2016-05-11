//
//  VVMObserverFabric.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMObserverFabric.h"
#import "VVMLogger.h"

#import "VVMKVObserver.h"

#import "VVMUITextFieldObserver.h"
#import "VVMUISwitchObserver.h"
#import "VVMUISliderObserver.h"
#import "VVMUIPickerDataSourceObserver.h"

@implementation VVMObserverFabric

+ (id)createByBind:(VVMObserverBind*)bind withInitial:(BOOL)initial {
    VVMObserver* observer = nil;
    
    if ([self path:bind.path isKindOf:[UITextField class] andValue:@"text"]) {
        UITextField* textField = [self path:bind.path getObjectKindOf:[UITextField class]];
        observer = [[VVMUITextFieldObserver alloc] initByBind:bind UseTextField:textField];
        VVMLogDebug(@"Create UITextField observer for bind:%@", bind);
        
    } else if ([self path:bind.path isKindOf:[UISwitch class] andValue:@"on"] ||
               [self path:bind.path isKindOf:[UISwitch class] andValue:@"isOn"]) {
        UISwitch* uiSwitch = [self path:bind.path getObjectKindOf:[UISwitch class]];
        observer = [[VVMUISwitchObserver alloc] initByBind:bind UseSwitch:uiSwitch];
        VVMLogDebug(@"Create UISwitch observer for bind:%@", bind);
        
    } else if ([self path:bind.path isKindOf:[UISlider class] andValue:@"value"]) {
        UISlider* slider = [self path:bind.path getObjectKindOf:[UISlider class]];
        observer = [[VVMUISliderObserver alloc] initByBind:bind UseSlider:slider];
        VVMLogDebug(@"Create UISlider observer for bind:%@", bind);
        
    } else if ([self path:bind.callPath isKindOf:[UIPickerView class] andValue:@"dataSource"]) {
        UIPickerView* picker = [self path:bind.callPath getObjectKindOf:[UIPickerView class]];
        observer = [[VVMUIPickerDataSourceObserver alloc] initByBind:bind UsePicker:picker];
        VVMLogDebug(@"Create UIPickerView observer for bind:%@", bind);
        
    } else {
        observer = [[VVMKVObserver alloc] initByBind:bind];
        VVMLogDebug(@"Create KVO observer for bind:%@", bind);
    }
    
    if (initial && nil != observer) {
        [observer initial];
        VVMLogDebug(@"Initial bind:%@", bind);
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
