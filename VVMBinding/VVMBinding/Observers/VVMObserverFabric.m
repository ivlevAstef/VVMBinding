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
#import "VVMUISwitchReverseObserver.h"
#import "VVMUISliderObserver.h"
#import "VVMUISliderReverseObserver.h"
#import "VVMUIPickerDataSourceObserver.h"

@implementation VVMObserverFabric

+ (id)createByBind:(VVMObserverBind*)bind withInitial:(BOOL)initial {
    VVMObserver* observer = nil;
    
    observer = observer ?: [self checkCreateTextFieldObserverByBind:bind];
    observer = observer ?: [self checkCreateSwitchObserverByBind:bind];
    observer = observer ?: [self checkCreateSliderObserverByBind:bind];
    observer = observer ?: [self checkCreatePickerObserverByBind:bind];
    
    observer = observer ?: [self createKVObserverByBind:bind];
    
    if (initial && nil != observer) {
        [observer initial];
        VVMLogDebug(@"Initial bind:%@", bind);
    }
    
    bind.observer = observer;
    return observer;
}

////////////// Check/Create methods

+ (BOOL)checkOnTextFieldByBindPath:(VVMBindPath*)bindPath {
    return [self path:bindPath isKindOf:[UITextField class] andValue:@"text"];
}
+ (id)checkCreateTextFieldObserverByBind:(VVMObserverBind*)bind {
    if ([self checkOnTextFieldByBindPath:bind.path]) {
        UITextField* textField = [self path:bind.path getObjectKindOf:[UITextField class]];
        VVMLogDebug(@"Create UITextField observer for bind:%@", bind);
        
        return [[VVMUITextFieldObserver alloc] initByBind:bind UseTextField:textField];
    }
    
    return nil;
}

+ (BOOL)checkOnSwitchByBindPath:(VVMBindPath*)bindPath {
    return [self path:bindPath isKindOf:[UISwitch class] andValue:@"on"] ||
           [self path:bindPath isKindOf:[UISwitch class] andValue:@"isOn"];
}
+ (id)checkCreateSwitchObserverByBind:(VVMObserverBind*)bind {
    if ([self checkOnSwitchByBindPath:bind.path]) {
        UISwitch* uiSwitch = [self path:bind.path getObjectKindOf:[UISwitch class]];
        VVMLogDebug(@"Create UISwitch observer for bind:%@", bind);
        
        return [[VVMUISwitchObserver alloc] initByBind:bind UseSwitch:uiSwitch];
        
    }
    
    if ([self checkOnSwitchByBindPath:bind.callPath]) {
        UISwitch* uiSwitch = [self path:bind.callPath getObjectKindOf:[UISwitch class]];
        VVMLogDebug(@"Create UISwitch reverse observer for bind:%@", bind);
        
        return [[VVMUISwitchReverseObserver alloc] initByBind:bind UseSwitch:uiSwitch];
    }
    
    return nil;
}

+ (BOOL)checkOnSliderByBindPath:(VVMBindPath*)bindPath {
    return [self path:bindPath isKindOf:[UISlider class] andValue:@"value"];
}
+ (id)checkCreateSliderObserverByBind:(VVMObserverBind*)bind {
    if ([self checkOnSliderByBindPath:bind.path]) {
        UISlider* slider = [self path:bind.path getObjectKindOf:[UISlider class]];
        VVMLogDebug(@"Create UISlider observer for bind:%@", bind);
        
        return [[VVMUISliderObserver alloc] initByBind:bind UseSlider:slider];
    }
    
    if ([self checkOnSliderByBindPath:bind.callPath]) {
        UISlider* slider = [self path:bind.callPath getObjectKindOf:[UISlider class]];
        VVMLogDebug(@"Create UISlider reverse observer for bind:%@", bind);
        
        return [[VVMUISliderReverseObserver alloc] initByBind:bind UseSlider:slider];
    }
    
    return nil;
}

+ (BOOL)checkOnPickerByBindPath:(VVMBindPath*)bindPath {
    return [self path:bindPath isKindOf:[UIPickerView class] andValue:@"dataSource"];
}
+ (id)checkCreatePickerObserverByBind:(VVMObserverBind*)bind {
    if ([self checkOnPickerByBindPath:bind.callPath]) {
        UIPickerView* picker = [self path:bind.callPath getObjectKindOf:[UIPickerView class]];
        VVMLogDebug(@"Create UIPickerView observer for bind:%@", bind);
        
        return [[VVMUIPickerDataSourceObserver alloc] initByBind:bind UsePicker:picker];
    }
    
    return nil;
}

+ (id)createKVObserverByBind:(VVMObserverBind*)bind {
    VVMLogDebug(@"Create KVO observer for bind:%@", bind);
    
    return [[VVMKVObserver alloc] initByBind:bind];
}

////////////// Support methods

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
