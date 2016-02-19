//
//  UIAlertView+Block.h
//  UIAlertView+Block
//
//  Created by Jonghwan Hyeon on 8/14/14.
//  Copyright (c) 2014 Jonghwan Hyeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Block)

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles;

- (instancetype)initWithMessage:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
              otherButtonTitles:(NSArray *)otherButtonTitles;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitle:(NSString *)otherButtonTitle;

- (instancetype)initWithMessage:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
              otherButtonTitle:(NSString *)otherButtonTitle;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle;

- (instancetype)initWithMessage:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle;

- (void)showUsingBlock:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))block;

@end
