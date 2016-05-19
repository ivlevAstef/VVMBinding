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
#import "VVMUIPickerReverseObserver.h"
#import "VVMUIImageViewReverseObserver.h"
#import "VVMUISegmentedControlReverseObserver.h"

@implementation VVMObserverFabric

+ (id)createByBind:(VVMObserverBind*)bind withInitial:(BOOL)initial {
    VVMObserver* observer = nil;
    
    observer = observer ?: [self checkCreateTextFieldObserverByBind:bind];
    observer = observer ?: [self checkCreateSwitchObserverByBind:bind];
    observer = observer ?: [self checkCreateSliderObserverByBind:bind];
    observer = observer ?: [self checkCreatePickerObserverByBind:bind];
    observer = observer ?: [self checkCreateImageViewObserverByBind:bind];
    observer = observer ?: [self checkCreateSegmentedObserverByBind:bind];
    
    observer = observer ?: [self createKVObserverByBind:bind];
    
    if (initial && nil != observer) {
        [observer initial];
        VVMLogDebug(@"Initial bind:%@", bind);
    }
    
    bind.observer = observer;
    return observer;
}

////////////// Check/Create methods

//////// UITextField
+ (BOOL)checkOnTextFieldByBindPath:(VVMBindPath*)bindPath {
    return [bindPath vvmIsKindOfClass:[UITextField class] AndValue:@"text"];
}
+ (id)checkCreateTextFieldObserverByBind:(VVMObserverBind*)bind {
    if ([self checkOnTextFieldByBindPath:bind.path]) {
        UITextField* textField = [bind.path vvmObjectKindOfClass:[UITextField class]];
        VVMLogDebug(@"Create UITextField observer for bind:%@", bind);
        
        return [[VVMUITextFieldObserver alloc] initByBind:bind UseTextField:textField];
    }
    
    return nil;
}

//////// UISwitch
+ (BOOL)checkOnSwitchByBindPath:(VVMBindPath*)bindPath {
    return [bindPath vvmIsKindOfClass:[UISwitch class] AndValue:@"on"] ||
           [bindPath vvmIsKindOfClass:[UISwitch class] AndValue:@"isOn"];
}
+ (id)checkCreateSwitchObserverByBind:(VVMObserverBind*)bind {
    if ([self checkOnSwitchByBindPath:bind.path]) {
        UISwitch* uiSwitch = [bind.path vvmObjectKindOfClass:[UISwitch class]];
        VVMLogDebug(@"Create UISwitch observer for bind:%@", bind);
        
        return [[VVMUISwitchObserver alloc] initByBind:bind UseSwitch:uiSwitch];
        
    }
    
    if ([self checkOnSwitchByBindPath:bind.callPath]) {
        UISwitch* uiSwitch = [bind.callPath vvmObjectKindOfClass:[UISwitch class]];
        VVMLogDebug(@"Create UISwitch reverse observer for bind:%@", bind);
        
        return [[VVMUISwitchReverseObserver alloc] initByBind:bind UseSwitch:uiSwitch];
    }
    
    return nil;
}

//////// UISlider
+ (BOOL)checkOnSliderByBindPath:(VVMBindPath*)bindPath {
    return [bindPath vvmIsKindOfClass:[UISlider class] AndValue:@"value"];
}
+ (id)checkCreateSliderObserverByBind:(VVMObserverBind*)bind {
    if ([self checkOnSliderByBindPath:bind.path]) {
        UISlider* slider = [bind.path vvmObjectKindOfClass:[UISlider class]];
        VVMLogDebug(@"Create UISlider observer for bind:%@", bind);
        
        return [[VVMUISliderObserver alloc] initByBind:bind UseSlider:slider];
    }
    
    if ([self checkOnSliderByBindPath:bind.callPath]) {
        UISlider* slider = [bind.callPath vvmObjectKindOfClass:[UISlider class]];
        VVMLogDebug(@"Create UISlider reverse observer for bind:%@", bind);
        
        return [[VVMUISliderReverseObserver alloc] initByBind:bind UseSlider:slider];
    }
    
    return nil;
}

//////// UIImageView
+ (BOOL)checkOnImageViewByBindPath:(VVMBindPath*)bindPath {
  return [bindPath vvmIsKindOfClass:[UIImageView class] AndValue:@"image"];
}
+ (id)checkCreateImageViewObserverByBind:(VVMObserverBind*)bind {
  if ([self checkOnImageViewByBindPath:bind.callPath]) {
    UIImageView* imageView = [bind.callPath vvmObjectKindOfClass:[UIImageView class]];
    VVMLogDebug(@"Create UIImageView reverse observer for bind:%@", bind);
    
    return [[VVMUIImageViewReverseObserver alloc] initByBind:bind UseImageView:imageView];
  }
  
  return nil;
}

//////// UIPickerView
+ (BOOL)checkOnPickerByBindPath:(VVMBindPath*)bindPath {
    return [bindPath vvmIsKindOfClass:[UIPickerView class]];
}
+ (id)checkCreatePickerObserverByBind:(VVMObserverBind*)bind {
    if ([self checkOnPickerByBindPath:bind.callPath]) {
        UIPickerView* picker = [bind.callPath vvmObjectKindOfClass:[UIPickerView class]];
        VVMLogDebug(@"Create UIPickerView reverse observer for bind:%@", bind);
        
        return [[VVMUIPickerReverseObserver alloc] initByBind:bind UsePicker:picker];
    }
    
    return nil;
}

//////// UISegmentedControl
+ (BOOL)checkOnSegmentedByBindPath:(VVMBindPath*)bindPath {
    return [bindPath vvmIsKindOfClass:[UISegmentedControl class]];
}
+ (id)checkCreateSegmentedObserverByBind:(VVMObserverBind*)bind {
    if ([self checkOnSegmentedByBindPath:bind.callPath]) {
        UISegmentedControl* segmented = [bind.callPath vvmObjectKindOfClass:[UISegmentedControl class]];
        VVMLogDebug(@"Create UIPickerView reverse observer for bind:%@", bind);
        
        return [[VVMUISegmentedControlReverseObserver alloc] initByBind:bind UseSegmentedControl:segmented];
    }
    
    return nil;
}

//////// Key Value Observer
+ (id)createKVObserverByBind:(VVMObserverBind*)bind {
    VVMLogDebug(@"Create KVO observer for bind:%@", bind);
    
    return [[VVMKVObserver alloc] initByBind:bind];
}

@end
