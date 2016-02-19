//
//  Utilities.h
//  战旗TV
//
//  Created by 于洋 on 16/2/18.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utilities : NSObject

@end


@interface NSDictionary (Helper)

- (id)kObjectForKey:(id)aKey;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


@end

@interface NSMutableDictionary (Helper)

- (void)kSetObject:(id)obj forKey:(id)key;

@end

@interface NSArray (Helper)

+ (NSArray *)arrWithJsonString:(NSString *)jsonString;


+ (NSString*)arrToJson:(NSArray *)dic;

@end

@interface NSString (Helper)


+ ( NSMutableAttributedString * )HTMLFromString:(NSString *)string;


@end

@interface UILabel (Helper)

+ (UILabel *)labelWithRect:(CGRect)rect
                      text:(NSString *)text
                 textColor:(UIColor *)textColor
                  fontSize:(CGFloat)fontSize
             textAlignment:(NSTextAlignment)textAlignment;

+ (CGSize)sizeWithText:(NSString *)text
                  font:(UIFont *)font
               maxSize:(CGSize)maxSize;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (CGSize)boundingRectWithSize:(CGSize)size;
+ (CGFloat)getStingWidth:(NSString *)string;

@end

@interface UIView (Helper)

- (void)addLabelWithRect:(CGRect)rect
                    text:(NSString *)text
               textColor:(UIColor *)textColor
                fontSize:(CGFloat)fontSize
                     tag:(NSInteger)tag
           textAlignment:(NSTextAlignment)textAlignment;

- (void)addEdgingViewWithRect:(CGRect)rect
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)width
                    viewColor:(UIColor *)viewColor
                      viewTag:(int)tag;

-(UIView *)addHospitalViewWithRect:(CGRect)rect Dic:(NSDictionary *)dic andTag:(int )tag;

+ (void)cornerView:(UIView *)view andUpLeft:(UIRectCorner )upleft andUpRight:(UIRectCorner )upright andBottomLeft:(UIRectCorner )bottomleft  andBottomRight:(UIRectCorner )bottomright andSizeMake:(int) cornerlayerSize;


+ (UIView *)getNewButtonWithImage:(UIImage *)img title:(NSString *)title clickAction:(SEL)clickAction ViewController:(id)viewController;

@end

@interface UITextField (Helper)

+ (UITextField *)textFieldWithRect:(CGRect)rect
                              text:(NSString *)text
                       placeholder:(NSString *)placeholder
                         textColor:(UIColor *)textColor
                          fontSize:(CGFloat)fontSize
                     textAlignment:(NSTextAlignment)textAlignment;

- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;

@end

@interface UIButton (Helper)
/**
 *   rect :             按钮尺寸位置
 *   title :            文字
 *   color  :           文字颜色
 *   imageColor :       图片颜色
 *   clickAction :      响应事件
 *   viewController:    控制器
 *   font   :           字体大小
 *   contentEdgeInsets :内容内边距
 *   radius   :         圆角
 */
+ (UIButton *)ButtonWithRect:(CGRect)rect
                       title:(NSString *)title
                  titleColor:(UIColor *)color
    BackgroundImageWithColor:(UIColor *)imageColor
                 clickAction:(SEL)clickAction
              viewController:(id)viewController
                   titleFont:(CGFloat)font contentEdgeInsets:(UIEdgeInsets )contentEdgeInsets;
/**
 *  Description
 *  @param rect              按钮尺寸位置
 *  @param title             文字
 *  @param color             文字颜色
 *  @param imageColor        图片颜色
 *  @param clickAction       响应事件
 *  @param viewController    控制器
 *  @param font              字体大小
 *  @param contentEdgeInsets 内容内边距
 *  @param radius            圆角
 *
 *  @return
 */
+ (UIButton *)ButtonWithRect:(CGRect)rect
                       title:(NSString *)title
                  titleColor:(UIColor *)color
    BackgroundImageWithColor:(UIColor *)imageColor
                 clickAction:(SEL)clickAction
              viewController:(id)viewController
                   titleFont:(CGFloat)font contentEdgeInsets:(UIEdgeInsets )contentEdgeInsets cornerRadius:(float)radius;

/**
 *  描述：
 *  @param rect            按钮尺寸位置
 *  @param title           文字
 *  @param color           文字颜色
 *  @param clickAction     响应事件
 *  @param image           按钮图片
 *  @param viewController  控制器
 *  @param font            字体大小
 *  @param titleEdgeInsets 文字内边距
 */
+ (UIButton *)ButtonWithRect:(CGRect)rect
                       title:(NSString *)title
                  titleColor:(UIColor *)color
                 clickAction:(SEL)clickAction
                       image:(NSString *)image
              viewController:(id)viewController
                   titleFont:(CGFloat)font
             titleEdgeInsets:(UIEdgeInsets )titleEdgeInsets;
@end

@interface UIImageView (Helper)
+ (UIImageView *)ImageViewWithRect:(CGRect)rect imageName:(NSString *)name tag:(int )tag parentId:(id)body;

- (void)fillImage;
- (void)changeCircleCornerRadius:(CGFloat )cornerRadius andborderWidth:(CGFloat)width;
- (UIImage *)imageWithColor:(UIColor *)color image:(NSString *)image;
- (UIImage *)imageWithColor:(UIColor *)color UIImage:(UIImage *)image;

@end





@interface UIImage (Helper)
/**
 纯色UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 剪切图片，从图片中心向边缘最大区域
 */
+ (UIImage *)getCutImageSize:(CGSize)size
               originalImage:(UIImage *)originalImage;

+(UIImage *)setNewImage:(NSString *)name;

/**
 修改图片处理后旋转的问题
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

@end

@interface NSDate (Helper)

+ (NSDate *)FromString:(NSString *)string;


+ (NSDate*) convertDateFromString:(NSString*)uiDate;
@end



@interface UITableView (Helper)

- (void)UIEdgeInsetsZero;

@end


@interface UITableViewCell(Helper)

- (void)setEdgeInsetsZero;

@end
