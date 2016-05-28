//
//  VVMUISegmentedControlReverseObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 19/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMUISegmentedControlReverseObserver.h"
#import "VVMLogger.h"

@interface VVMUISegmentedControlReverseObserver ()

@property (nonatomic, weak) UISegmentedControl* segmentedControl;

@end

@implementation VVMUISegmentedControlReverseObserver

- (id)initByBind:(VVMObserverBind*)bind UseSegmentedControl:(UISegmentedControl*)segmentedControl {
    VVMLogAssert(nil != bind && nil != segmentedControl);
    
    self = [super initByBind:bind];
    if (self) {
        self.segmentedControl = segmentedControl;
    }
    
    return self;
}

- (void)setValue:(NSArray*)newValue {
    __strong typeof(self.segmentedControl) segmentedControl = self.segmentedControl;
    if (nil == segmentedControl) {
        return;
    }
    
    if ([newValue isKindOfClass:[NSArray class]] || nil == newValue) {
        [segmentedControl removeAllSegments];
        
        if (nil != newValue) {
            for( NSUInteger index = 0; index < newValue.count; index++){
                id object = [newValue objectAtIndex:index];
                if ([object isKindOfClass:[NSString class]]) {
                    [segmentedControl insertSegmentWithTitle:object atIndex:index animated:NO];
                } else if ([object isKindOfClass:[UIImage class]]) {
                    [segmentedControl insertSegmentWithImage:object atIndex:index animated:NO];
                } else {
                    VVMLogError(@"Incorrect segment object %@ - for UISegmentedControl", object);
                }
            }
        }
        
        [self.bind observerNotify:YES withNewValue:newValue];
    } else {
        VVMLogError(@"VVM UISegmentedControl segments can't updated, because incorrect type.");
        [self.bind observerNotify:NO withNewValue:newValue];
    }
}

@end
