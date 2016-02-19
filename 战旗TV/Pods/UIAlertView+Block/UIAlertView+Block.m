//
//  UIAlertView+Block.m
//  UIAlertView+Block
//
//  Created by Jonghwan Hyeon on 8/14/14.
//  Copyright (c) 2014 Jonghwan Hyeon. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

@interface UIAlertView () <UIAlertViewDelegate>

@property (copy, nonatomic) void (^block)(UIAlertView *UIAlertView, NSInteger buttonIndex);

@end

@implementation UIAlertView (Block)

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
{
    self = [self initWithTitle:title message:message
                      delegate:nil
             cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (self) {
        for (NSString *otherButtonTitle in otherButtonTitles) {
            [self addButtonWithTitle:otherButtonTitle];
        }
    }

    return self;
}

- (instancetype)initWithMessage:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
              otherButtonTitles:(NSArray *)otherButtonTitles
{
    NSString *title = [NSBundle mainBundle].localizedInfoDictionary[@"CFBundleDisplayName"];
    return [self initWithTitle:title message:message
             cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString *)otherButtonTitle
{
    return [self initWithTitle:title message:message
             cancelButtonTitle:cancelButtonTitle
             otherButtonTitles:@[otherButtonTitle]];
}

- (instancetype)initWithMessage:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
               otherButtonTitle:(NSString *)otherButtonTitle
{
    return [self initWithMessage:message
             cancelButtonTitle:cancelButtonTitle
             otherButtonTitles:@[otherButtonTitle]];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
{
    return [self initWithTitle:title message:message
             cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
}

- (instancetype)initWithMessage:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
{
    return [self initWithMessage:message
               cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
}

- (void)setBlock:(void (^)(UIAlertView *, NSInteger))block
{
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIAlertView *, NSInteger))block
{
    return objc_getAssociatedObject(self, @selector(block));
}

- (void)showUsingBlock:(void (^)(UIAlertView *, NSInteger))block
{
    self.delegate = self;
    self.block = block;

    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.block) {
        self.block(alertView, buttonIndex);
    }
}

@end