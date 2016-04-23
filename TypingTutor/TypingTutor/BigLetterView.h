//
//  BigLetterView.h
//  TypingTutor
//
//  Created by 但 江 on 15/4/4.
//  Copyright (c) 2015年 Dan Thought Studio. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BigLetterView : NSView

@property (nonatomic, strong) NSColor *bgColor;
@property (nonatomic, copy) NSString *string;
@property (strong) NSMutableDictionary *attributes;
@property BOOL highlighted;

- (void)prepareAttributes;
- (void)savePdf;
- (void)writeToPasteboard:(NSPasteboard *)pb;
- (BOOL)readFromPasteboard:(NSPasteboard *)pb;

@end
