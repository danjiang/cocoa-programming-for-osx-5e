//
//  StretchView.m
//  DrawingFun
//
//  Created by 但 江 on 15/4/3.
//  Copyright (c) 2015年 Dan Thought Studio. All rights reserved.
//

#import "StretchView.h"

@interface StretchView ()

@property (strong) NSBezierPath *path;
@property NSPoint downPoint;
@property NSPoint currentPoint;

@end

@implementation StretchView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        srandom((unsigned)time(NULL));
        
        self.path = [NSBezierPath bezierPath];
        self.path.lineWidth = 3.0;
        NSPoint p = [self randomPoint];
        [self.path moveToPoint:p];
        int i;
        for (i = 0; i < 15; i++) {
            p = [self randomPoint];
            [self.path lineToPoint:p];
        }
        [self.path closePath];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    NSRect bounds = self.bounds;
    [[NSColor greenColor] setFill];
    [NSBezierPath fillRect:bounds];
    
    [[NSColor whiteColor] setStroke];
    [self.path stroke];
    
    if (self.image) {
        NSRect imageRect;
        imageRect.origin = NSZeroPoint;
        imageRect.size = self.image.size;
        NSRect drawingRect = [self currentRect];
        [self.image drawInRect:drawingRect fromRect:imageRect operation:NSCompositeSourceOver fraction:self.alphaValue];
    }
}

- (NSPoint)randomPoint {
    NSPoint result;
    NSRect r = self.bounds;
    result.x = r.origin.x + random() % (int)r.size.width;
    result.y = r.origin.y + random() % (int)r.size.height;
    return result;
}

- (void)setImage:(NSImage *)image {
    _image = image;
    NSSize imageSize = image.size;
    self.downPoint = NSZeroPoint;
    self.currentPoint = NSMakePoint(self.downPoint.x + imageSize.width, self.downPoint.y + imageSize.height);
    [self setNeedsDisplay:YES];
}

#pragma mark - Events

- (void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"mouseDown: %ld", [theEvent clickCount]);
    NSPoint p = [theEvent locationInWindow];
    self.downPoint = [self convertPoint:p fromView:nil];
    self.currentPoint = self.downPoint;
    [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)theEvent {
    NSPoint p = [theEvent locationInWindow];
    NSLog(@"mouseDragged: %@", NSStringFromPoint(p));
    self.currentPoint = [self convertPoint:p fromView:nil];
    [self autoscroll:theEvent];
    [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)theEvent {
    NSLog(@"mouseUp:");
    NSPoint p = [theEvent locationInWindow];
    self.currentPoint = [self convertPoint:p fromView:nil];
    [self setNeedsDisplay:YES];
}

- (NSRect)currentRect {
    float minX = MIN(self.downPoint.x, self.currentPoint.x);
    float maxX = MAX(self.downPoint.x, self.currentPoint.x);
    float minY = MIN(self.downPoint.y, self.currentPoint.y);
    float maxY = MAX(self.downPoint.y, self.currentPoint.y);
    return NSMakeRect(minX, minY, maxX - minX, maxY - minY);
}

@end
