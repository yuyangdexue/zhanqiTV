//
//  NSString+BFKit.m
//  BFKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE
//  SOFTWARE.

#import "NSString+BFKit.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (BFKit)

+ (NSString *)searchInString:(NSString *)string
                   charStart:(char)start
                     charEnd:(char)end {
  int inizio = 0, stop = 0;
  for (int i = 0; i < [string length]; i++) {
    if ([string characterAtIndex:i] == start) {
      inizio = i + 1;
      i += 1;
    }
    if ([string characterAtIndex:i] == end) {
      stop = i;
      break;
    }
  }
  stop -= inizio;
  NSString *string2 =
      [[string substringFromIndex:inizio - 1] substringToIndex:stop + 1];

  return string2;
}

- (NSString *)searchCharStart:(char)start charEnd:(char)end {
  int inizio = 0, stop = 0;
  for (int i = 0; i < [self length]; i++) {
    if ([self characterAtIndex:i] == start) {
      inizio = i + 1;
      i += 1;
    }
    if ([self characterAtIndex:i] == end) {
      stop = i;
      break;
    }
  }
  stop -= inizio;
  NSString *string =
      [[self substringFromIndex:inizio - 1] substringToIndex:stop + 1];

  return string;
}

- (NSString *)MD5 {
  if (self == nil || [self length] == 0)
    return nil;

  unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
  CC_MD5([self UTF8String],
         (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
  NSMutableString *ms = [NSMutableString string];
  for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
    [ms appendFormat:@"%02x", (int)(digest[i])];
  }
  return [ms copy];
}

- (NSString *)SHA1 {
  if (self == nil || [self length] == 0)
    return nil;

  unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
  CC_SHA1([self UTF8String],
          (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
  NSMutableString *ms = [NSMutableString string];
  for (i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
    [ms appendFormat:@"%02x", (int)(digest[i])];
  }
  return [ms copy];
}

- (NSString *)SHA256 {
  if (self == nil || [self length] == 0)
    return nil;

  unsigned char digest[CC_SHA256_DIGEST_LENGTH], i;
  CC_SHA256([self UTF8String],
            (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding],
            digest);
  NSMutableString *ms = [NSMutableString string];
  for (i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
    [ms appendFormat:@"%02x", (int)(digest[i])];
  }
  return [ms copy];
}

- (NSString *)SHA512 {
  if (self == nil || [self length] == 0)
    return nil;

  unsigned char digest[CC_SHA512_DIGEST_LENGTH], i;
  CC_SHA512([self UTF8String],
            (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding],
            digest);
  NSMutableString *ms = [NSMutableString string];
  for (i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
    [ms appendFormat:@"%02x", (int)(digest[i])];
  }
  return [ms copy];
}

- (BOOL)hasString:(NSString *)substring {
  return !([self rangeOfString:substring].location == NSNotFound);
}

- (BOOL)isMobilePhone {
  if (!self || [self length] != 11 ) {
    return NO;
  }
    return YES;
//  NSString *mobileRegEx = @"^1[2345678][0-9]{9}$";
//  NSPredicate *regExPredicate =
//      [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegEx];
//  return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

- (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSInteger length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
       
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
           
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                NSString *JYM1 =@"10x98765432";
                BOOL isRight=NO;
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    isRight=YES;
                    return isRight;
                   // return YES;// 检测ID的校验位
                }else {
                    isRight=NO;
                    //return NO;
                }
                M = [JYM1 substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    isRight=YES;
                    return isRight;
                    // return YES;// 检测ID的校验位
                }else {
                    isRight=NO;
                    //return NO;
                }
                return isRight;
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}

- (BOOL)isIDCard {
  if (!self || [self length] == 0) {
    return NO;
  }
  return YES;
    //return [self validateIDCardNumber:self];
}

- (BOOL)isFormattingPassword {
    
    if ([self length]<6||[self length]>18) {
        
        return NO;
    }
    return YES;
    
//  if (!self || [self length] == 0) {
//    return NO;
//  }
//  NSString *mobileRegEx = @"^[a-zA-Z0-9]{6,18}+$";
//  NSPredicate *regExPredicate =
//      [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegEx];
//  return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

- (BOOL)isEmail {
  NSString *emailRegEx =
      @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
      @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
      @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
      @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
      @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
      @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
      @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";

  NSPredicate *regExPredicate =
      [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
  return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

+ (BOOL)isEmail:(NSString *)email {
  NSString *emailRegEx =
      @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
      @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
      @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
      @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
      @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
      @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
      @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";

  NSPredicate *regExPredicate =
      [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
  return [regExPredicate evaluateWithObject:[email lowercaseString]];
}

+ (NSString *)convertToUTF8Entities:(NSString *)string {
  NSString *isoEncodedString = [[[[[[[[[[[[[[[[[[[[[[[[[[[
      [[[[[[[string stringByReplacingOccurrencesOfString:@"%27" withString:@"'"]
          stringByReplacingOccurrencesOfString:[@"%e2%80%99" capitalizedString]
                                    withString:@"’"]
          stringByReplacingOccurrencesOfString:[@"%2d" capitalizedString]
                                    withString:@"-"]
          stringByReplacingOccurrencesOfString:[@"%c2%ab" capitalizedString]
                                    withString:@"«"]
          stringByReplacingOccurrencesOfString:[@"%c2%bb" capitalizedString]
                                    withString:@"»"]
          stringByReplacingOccurrencesOfString:[@"%c3%80" capitalizedString]
                                    withString:@"À"]
          stringByReplacingOccurrencesOfString:[@"%c3%82" capitalizedString]
                                    withString:@"Â"]
      stringByReplacingOccurrencesOfString:[@"%c3%84" capitalizedString]
                                withString:@"Ä"]
      stringByReplacingOccurrencesOfString:[@"%c3%86" capitalizedString]
                                withString:@"Æ"]
      stringByReplacingOccurrencesOfString:[@"%c3%87" capitalizedString]
                                withString:@"Ç"]
      stringByReplacingOccurrencesOfString:[@"%c3%88" capitalizedString]
                                withString:@"È"]
      stringByReplacingOccurrencesOfString:[@"%c3%89" capitalizedString]
                                withString:@"É"]
      stringByReplacingOccurrencesOfString:[@"%c3%8a" capitalizedString]
                                withString:@"Ê"]
      stringByReplacingOccurrencesOfString:[@"%c3%8b" capitalizedString]
                                withString:@"Ë"]
      stringByReplacingOccurrencesOfString:[@"%c3%8f" capitalizedString]
                                withString:@"Ï"]
      stringByReplacingOccurrencesOfString:[@"%c3%91" capitalizedString]
                                withString:@"Ñ"]
      stringByReplacingOccurrencesOfString:[@"%c3%94" capitalizedString]
                                withString:@"Ô"]
      stringByReplacingOccurrencesOfString:[@"%c3%96" capitalizedString]
                                withString:@"Ö"]
      stringByReplacingOccurrencesOfString:[@"%c3%9b" capitalizedString]
                                withString:@"Û"]
      stringByReplacingOccurrencesOfString:[@"%c3%9c" capitalizedString]
                                withString:@"Ü"]
      stringByReplacingOccurrencesOfString:[@"%c3%a0" capitalizedString]
                                withString:@"à"]
      stringByReplacingOccurrencesOfString:[@"%c3%a2" capitalizedString]
                                withString:@"â"]
      stringByReplacingOccurrencesOfString:[@"%c3%a4" capitalizedString]
                                withString:@"ä"]
      stringByReplacingOccurrencesOfString:[@"%c3%a6" capitalizedString]
                                withString:@"æ"]
      stringByReplacingOccurrencesOfString:[@"%c3%a7" capitalizedString]
                                withString:@"ç"]
      stringByReplacingOccurrencesOfString:[@"%c3%a8" capitalizedString]
                                withString:@"è"]
      stringByReplacingOccurrencesOfString:[@"%c3%a9" capitalizedString]
                                withString:@"é"]
      stringByReplacingOccurrencesOfString:[@"%c3%af" capitalizedString]
                                withString:@"ï"]
      stringByReplacingOccurrencesOfString:[@"%c3%b4" capitalizedString]
                                withString:@"ô"]
      stringByReplacingOccurrencesOfString:[@"%c3%b6" capitalizedString]
                                withString:@"ö"]
      stringByReplacingOccurrencesOfString:[@"%c3%bb" capitalizedString]
                                withString:@"û"]
      stringByReplacingOccurrencesOfString:[@"%c3%bc" capitalizedString]
                                withString:@"ü"]
      stringByReplacingOccurrencesOfString:[@"%c3%bf" capitalizedString]
                                withString:@"ÿ"]
      stringByReplacingOccurrencesOfString:@"%20"
                                withString:@" "];

  return isoEncodedString;
}

- (NSString *)sentenceCapitalizedString {
  if (![self length]) {
    return [NSString string];
  }
  NSString *uppercase = [[self substringToIndex:1] uppercaseString];
  NSString *lowercase = [[self substringFromIndex:1] lowercaseString];

  return [uppercase stringByAppendingString:lowercase];
}

- (NSString *)dateFromTimestamp {
  NSString *year = [self substringToIndex:4];
  NSString *month = [[self substringFromIndex:5] substringToIndex:2];
  NSString *day = [[self substringFromIndex:8] substringToIndex:2];
  NSString *hours = [[self substringFromIndex:11] substringToIndex:2];
  NSString *minutes = [[self substringFromIndex:14] substringToIndex:2];

  return [NSString
      stringWithFormat:@"%@/%@/%@ %@:%@", day, month, year, hours, minutes];
}

- (NSString *)urlEncode {
  NSMutableString *output = [NSMutableString string];
  const unsigned char *source = (const unsigned char *)[self UTF8String];
  int sourceLen = (int)strlen((const char *)source);
  for (int i = 0; i < sourceLen; ++i) {
    const unsigned char thisChar = source[i];

    if (thisChar == ' ') {
      [output appendString:@"+"];
    } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' ||
               thisChar == '~' || (thisChar >= 'a' && thisChar <= 'z') ||
               (thisChar >= 'A' && thisChar <= 'Z') ||
               (thisChar >= '0' && thisChar <= '9')) {
      [output appendFormat:@"%c", thisChar];
    } else {
      [output appendFormat:@"%%%02X", thisChar];
    }
  }

  return output;
}

- (NSDate *)string2Date:(NSString *)format {
  NSDateFormatter *formatter = [NSDateFormatter new];
  NSTimeZone *timeZone = [NSTimeZone localTimeZone];
  [formatter setTimeZone:timeZone];
  [formatter setDateFormat:format];
  return [formatter dateFromString:self];
}

@end
