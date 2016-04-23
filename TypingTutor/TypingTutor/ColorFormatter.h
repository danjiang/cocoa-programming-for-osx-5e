//
//  ColorFormatter.h
//  TypingTutor
//
//  Created by 但 江 on 15/4/5.
//  Copyright (c) 2015年 Dan Thought Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface ColorFormatter : NSFormatter

@property (strong) NSColorList *colorList;
- (NSString *)firstColorKeyForPartialString:(NSString *)string;

@end
