//
//  TutorController.m
//  TypingTutor
//
//  Created by 但 江 on 15/4/4.
//  Copyright (c) 2015年 Dan Thought Studio. All rights reserved.
//

#import "TutorController.h"
#import "BigLetterView.h"
#import "ColorFormatter.h"

@interface TutorController () <NSTextFieldDelegate>

@property (weak) IBOutlet BigLetterView *inLetterView;
@property (weak) IBOutlet BigLetterView *outLetterView;
@property (copy) NSArray *letters;
@property int lastIndex;
@property (strong) NSTimer *timer;

@end

@implementation TutorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.letters = @[@"a", @"s", @"d", @"f", @"j", @"k", @"l", @";"];
    srandom((unsigned)time(NULL));
    self.timeLimit = 5;
    
    [self showAnotherLetter];
}

- (IBAction)stopGo:(id)sender {
    [self resetElapsedTime];
    if (self.timer == nil) {
        NSLog(@"Starting");
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(checkThem:) userInfo:nil repeats:YES];
    } else {
        NSLog(@"Stopping");
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)showAnotherLetter {
    int x = self.lastIndex;
    while (x == self.lastIndex) {
        x = (int)(random() % self.letters.count);
    }
    self.lastIndex = x;
    self.outLetterView.string = self.letters[x];
    
    [self resetElapsedTime];
}

- (void)checkThem:(NSTimer *)aTimer {
    if ([self.inLetterView.string isEqualToString:self.outLetterView.string]) {
        [self showAnotherLetter];
    }
    [self updateElapsedTime];
    if (self.elapsedTime >= self.timeLimit) {
        NSBeep();
        [self resetElapsedTime];
    }
}

- (void)resetElapsedTime {
    self.startTime = [NSDate timeIntervalSinceReferenceDate];
}

- (void)updateElapsedTime {
    [self willChangeValueForKey:@"elapsedTime"];
    self.elapsedTime = [NSDate timeIntervalSinceReferenceDate] - self.startTime;
    [self didChangeValueForKey:@"elapsedTime"];
}

- (BOOL)control:(NSControl *)control didFailToFormatString:(NSString *)string errorDescription:(NSString *)error {
    NSLog(@"TutorController told that formatting of %@ failed %@", string, error);
    return NO;
}

@end
