//
//  ViewController.m
//  TypingTutor
//
//  Created by 但 江 on 15/4/4.
//  Copyright (c) 2015年 Dan Thought Studio. All rights reserved.
//

#import "ViewController.h"
#import "BigLetterView.h"

@interface ViewController ()

@property (weak) IBOutlet BigLetterView *bigLetterView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)savePdf:(id)sender {
    [self.bigLetterView savePdf];
}

- (IBAction)cut:(id)sender {
    [self copy:sender];
    self.bigLetterView.string = @"";
}

- (IBAction)copy:(id)sender {
    NSPasteboard *pb = [NSPasteboard generalPasteboard];
    [self.bigLetterView writeToPasteboard:pb];
}

- (IBAction)paste:(id)sender {
    NSPasteboard *pb = [NSPasteboard generalPasteboard];
    if (![self.bigLetterView readFromPasteboard:pb]) {
        NSBeep();
    }
}

@end
