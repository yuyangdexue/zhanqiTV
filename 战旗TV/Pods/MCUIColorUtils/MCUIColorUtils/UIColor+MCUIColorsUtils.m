// Copyright (c) 2013, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

#import "UIColor+MCUIColorsUtils.h"


@implementation UIColor (MCUIColorsUtils)

//-----------------------------------------------------------------------------
#pragma mark methods for modifying colors
//-----------------------------------------------------------------------------


- (UIColor *) colorWithMultiplier:(CGFloat) multiplier {
    CGFloat * components = (CGFloat *)CGColorGetComponents(self.CGColor);

    return [UIColor colorWithRed:components[0] * multiplier green:components[1] * multiplier blue:components[2] * multiplier alpha:components[3]];
}

+ (UIColor *) colorForHex:(NSString *)hexColor {
	hexColor = [[hexColor stringByTrimmingCharactersInSet:
				 [NSCharacterSet whitespaceAndNewlineCharacterSet]
                 ] uppercaseString];

    // String should be 6 or 7 characters if it includes '#'
    if ([hexColor length] < 6)
		return [UIColor blackColor];

    // strip # if it appears
    if ([hexColor hasPrefix:@"#"])
		hexColor = [hexColor substringFromIndex:1];

    // if the value isn't 6 characters at this point return
    // the color black
    if ([hexColor length] != 6)
        return [UIColor blackColor];

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;

    NSString *rString = [hexColor substringWithRange:range];

    range.location = 2;
    NSString *gString = [hexColor substringWithRange:range];

    range.location = 4;
    NSString *bString = [hexColor substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];

}

+ (UIColor *)colorWithGray:(CGFloat)gray {
    return [UIColor colorWithRed:gray  green:gray  blue:gray  alpha:1.0f];
}

+ (UIColor *)colorWithGray:(CGFloat)gray alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:gray  green:gray  blue:gray  alpha:alpha];
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
}

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

+ (UIColor *)colorWithIntegerGray:(NSUInteger)gray {
    return [UIColor colorWithGray:gray/255.0f];
}

+ (UIColor *)colorWithIntegerGray:(NSUInteger)gray alpha:(CGFloat)alpha {
    return [UIColor colorWithGray:gray/255.0f alpha:alpha];
}

+ (UIColor *)colorWithHexRGB:(NSUInteger)hexRGB {
    return [UIColor colorWithIntegerRed:((hexRGB & 0xFF0000) >> 16) green:((hexRGB & 0x00FF00) >> 8) blue:(hexRGB & 0x0000FF) alpha:1.0f];
}

+ (UIColor *)colorWithHexRGBString:(NSString*)hexRGBString {
    NSUInteger hexRGB = strtoul(([hexRGBString UTF8String] ?: ""), NULL, 16);
    return [UIColor colorWithHexRGB: hexRGB];
}

+ (UIColor *)colorWithHexRGBA:(NSUInteger)hexRGBA {
    return [UIColor colorWithIntegerRed:((hexRGBA & 0xFF000000) >> 24) green:((hexRGBA & 0x00FF0000) >> 16) blue:((hexRGBA & 0x0000FF00) >> 8) alpha:(hexRGBA & 0x000000FF)/255.0f];
}

+ (UIColor *)colorWithHexRGBAString:(NSString*)hexRGBAString {
    if (hexRGBAString) {
        NSUInteger hexRGBA = strtoul(([hexRGBAString UTF8String] ?: ""), NULL, 16);
        return [UIColor colorWithHexRGBA: hexRGBA];
    } else {
        return nil;
    }
}

- (NSString *)hexRGB {
	CGColorRef color = self.CGColor;
	size_t count = CGColorGetNumberOfComponents(color);
	const CGFloat *components = CGColorGetComponents(color);

	static NSString *stringFormat = @"%02x%02x%02x";

	if (count == 2) {
        // Grayscale
		NSUInteger grey = (NSUInteger)(components[0] * (CGFloat)255);
		return [NSString stringWithFormat:stringFormat, grey, grey, grey];
	}
	else if (count == 4) {
        // RGB
		return [NSString stringWithFormat:stringFormat,
                (NSUInteger)(components[0] * (CGFloat)255),
				(NSUInteger)(components[1] * (CGFloat)255),
                (NSUInteger)(components[2] * (CGFloat)255)];
	}

	// Unsupported color space
	return nil;
}

- (NSString *)hexRGBA {
	CGColorRef color = self.CGColor;
	size_t count = CGColorGetNumberOfComponents(color);
	const CGFloat *components = CGColorGetComponents(color);

	static NSString *stringFormat = @"%02x%02x%02x%02x";

	if (count == 2) {
        // Grayscale
		NSUInteger grey = (NSUInteger)(components[0] * (CGFloat)255);
		NSUInteger alpha = (NSUInteger)(components[3] * (CGFloat)255);
		return [NSString stringWithFormat:stringFormat, grey, grey, grey, alpha];
	}
	else if (count == 4) {
        // RGBA
		return [NSString stringWithFormat:stringFormat,
                (NSUInteger)(components[0] * (CGFloat)255),
				(NSUInteger)(components[1] * (CGFloat)255),
				(NSUInteger)(components[2] * (CGFloat)255),
                (NSUInteger)(components[3] * (CGFloat)255)];
	}

	// Unsupported color space
	return nil;
}

@end
