//
//  BigLetterView.m
//  TypingTutor
//
//  Created by 但 江 on 15/4/4.
//  Copyright (c) 2015年 Dan Thought Studio. All rights reserved.
//

#import "BigLetterView.h"

@interface BigLetterView ()

@property (strong) NSEvent *mouseDownEvent;

@end

@implementation BigLetterView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self registerForDraggedTypes:@[NSPasteboardTypeString]];
        NSLog(@"initializing view");
        [self prepareAttributes];
        _bgColor = [NSColor yellowColor];
        _string = @"";
    }
    return self;
}

- (BOOL)isOpaque {
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect {
    NSRect bounds = self.bounds;
    if (self.highlighted) {
        NSGradient *gr = [[NSGradient alloc] initWithStartingColor:[NSColor whiteColor] endingColor:self.bgColor];
        [gr drawInRect:bounds relativeCenterPosition:NSZeroPoint];
    } else {
        [self.bgColor set];
        [NSBezierPath fillRect:bounds];
    }
    if (self.window.firstResponder == self) {
        [[NSColor keyboardFocusIndicatorColor] set];
        [NSBezierPath setDefaultLineWidth:4.0];
        [NSBezierPath strokeRect:bounds];
    }
    [self drawStringCenteredIn:bounds];
}

- (void)setBgColor:(NSColor *)bgColor {
    _bgColor = bgColor;
    [self setNeedsDisplay:YES];
}

- (void)setString:(NSString *)string {
    _string = string;
    NSLog(@"The string is now %@", string);
    [self setNeedsDisplay:YES];
}

- (BOOL)acceptsFirstResponder {
    NSLog(@"Accepting");
    return YES;
}

- (BOOL)resignFirstResponder {
    NSLog(@"Resigning");
    [self setNeedsDisplay:YES];
    return YES;
}

- (BOOL)becomeFirstResponder {
    NSLog(@"Becoming");
    [self setNeedsDisplay:YES];
    return YES;
}

- (void)keyDown:(NSEvent *)theEvent {
    [self interpretKeyEvents:@[theEvent]];
}

- (void)insertText:(id)insertString {
    self.string = insertString;
}

- (void)insertTab:(id)sender {
    [self.window selectKeyViewFollowingView:self];
}

- (void)insertBacktab:(id)sender {
    [self.window selectKeyViewPrecedingView:self];
}

- (void)deleteBackward:(id)sender {
    self.string = @"";
}

- (void)prepareAttributes {
    self.attributes = [NSMutableDictionary dictionary];
    self.attributes[NSFontAttributeName] = [NSFont userFontOfSize:75];
    self.attributes[NSForegroundColorAttributeName] = [NSColor redColor];
}

- (void)drawStringCenteredIn:(NSRect)r {
    NSSize strSize = [self.string sizeWithAttributes:self.attributes];
    NSPoint strOrigin;
    strOrigin.x = r.origin.x + (r.size.width - strSize.width) / 2;
    strOrigin.y = r.origin.y + (r.size.height - strSize.height) / 2;
    [self.string drawAtPoint:strOrigin withAttributes:self.attributes];
}

- (void)savePdf {
    __block NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setAllowedFileTypes:@[@"pdf"]];
    
    [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
        if (result == NSOKButton) {
            NSRect r = self.bounds;
            NSData *data = [self dataWithPDFInsideRect:r];
            NSError *error;
            BOOL successful = [data writeToURL:panel.URL options:0 error:&error];
            if (!successful) {
                NSAlert *a = [NSAlert alertWithError:error];
                [a runModal];
            }
        }
        panel = nil;
    }];
}

#pragma mark - Pasteboard

- (void)writeToPasteboard:(NSPasteboard *)pb {
    [pb clearContents];
    [pb writeObjects:@[self.string]];
}

- (BOOL)readFromPasteboard:(NSPasteboard *)pb {
    NSArray *classes = @[[NSString class]];
    NSArray *objects = [pb readObjectsForClasses:classes options:nil];
    if (objects.count > 0) {
        NSString *value = objects[0];
        if (value.length == 1) {
            self.string = value;
            return YES;
        }
    }
    return NO;
}

#pragma mark - Drag

- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)flag {
    return NSDragOperationCopy | NSDragOperationDelete;
}

- (void)mouseDown:(NSEvent *)theEvent {
    self.mouseDownEvent = theEvent;
}

- (void)mouseDragged:(NSEvent *)theEvent {
    NSPoint down = [self.mouseDownEvent locationInWindow];
    NSPoint drag = [theEvent locationInWindow];
    float distance = hypot(down.x - drag.x, down.y - drag.y);
    if (distance < 3) {
        return;
    }
    if (self.string.length == 0) {
        return;
    }
    NSSize s = [self.string sizeWithAttributes:self.attributes];
    NSImage *anImage = [[NSImage alloc] initWithSize:s];
    
    NSRect imageBounds;
    imageBounds.origin = NSZeroPoint;
    imageBounds.size = s;
    
    [anImage lockFocus];
    [self drawStringCenteredIn:imageBounds];
    [anImage unlockFocus];
    
    NSPoint p = [self convertPoint:down fromView:nil];
    
    p.x = p.x - s.width / 2;
    p.y = p.y - s.height / 2;
    
    NSPasteboard *pb = [NSPasteboard pasteboardWithName:NSDragPboard];
    
    [self writeToPasteboard:pb];
    
    [self dragImage:anImage at:p offset:NSZeroSize event:theEvent pasteboard:pb source:self slideBack:YES];
}

- (void)draggedImage:(NSImage *)image endedAt:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    if (operation == NSDragOperationDelete) {
        self.string = @"";
    }
}

#pragma mark - Dragging Destination

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    NSLog(@"draggingEntered:");
    if ([sender draggingSource] == self) {
        return NSDragOperationNone;
    }
    self.highlighted = YES;
    [self setNeedsDisplay:YES];
    return NSDragOperationCopy;
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
    NSDragOperation op = [sender draggingSourceOperationMask];
    NSLog(@"operation mask = %ld", op);
    if ([sender draggingSource] == self) {
        return NSDragOperationNone;
    }
    return NSDragOperationCopy;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender {
    NSLog(@"draggingExited");
    self.highlighted = NO;
    [self setNeedsDisplay:YES];
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    return YES;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    NSPasteboard *pb = [sender draggingPasteboard];
    if (![self readFromPasteboard:pb]) {
        NSLog(@"Error: Could not read from dragging pasteboard");
        return NO;
    }
    return YES;
}

- (void)concludeDragOperation:(id<NSDraggingInfo>)sender {
    NSLog(@"concludeDragOperation:");
    self.highlighted = NO;
    [self setNeedsDisplay:YES];
}

@end
