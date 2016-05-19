//
//  VVMUIImageViewReverseObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 19/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMUIImageViewReverseObserver.h"
#import "VVMLogger.h"
#import "VVMTransformation.h"

@interface VVMUIImageViewReverseObserver ()

@property (nonatomic, weak) UIImageView* imageView;

@end

@implementation VVMUIImageViewReverseObserver

- (id)initByBind:(VVMObserverBind*)bind UseImageView:(UIImageView*)imageView {
  VVMLogAssert(nil != bind && nil != imageView);
  
  self = [super initByBind:bind];
  if (self) {
    self.imageView = imageView;
  }
  
  return self;
}

- (void)update:(id)newValue {
  if ([newValue isKindOfClass:[NSString class]]) {
    newValue = [VVMTransformation NSStringToUIImage](newValue);
  }
  
  if ([newValue isKindOfClass:[UIImage class]] || nil == newValue) {
    [self setImage:newValue];
  } else {
    VVMLogError(@"VVM UIImageView.image can't updated, because incorrect type.");
  }
  
}

- (void)setImage:(UIImage*)image {
  __strong typeof(self.imageView) imageView = self.imageView;
  if (nil == imageView) {
    return;
  }
  
  [imageView setImage:image];
}

@end