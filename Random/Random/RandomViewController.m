//
//  ViewController.m
//  Random
//
//  Created by 但 江 on 15/3/23.
//  Copyright (c) 2015年 Dan Thought Studio. All rights reserved.
//

#import "RandomViewController.h"

@interface RandomViewController ()

@property (weak) IBOutlet NSTextField *textField;
@property NSInteger count;

@end

@implementation RandomViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _count = 0;
    }
    return self;
}

- (void)awakeFromNib {
    NSDate *now = [NSDate date];
    self.textField.objectValue = now;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)seed:(id)sender {
    srandom((unsigned)time(NULL));
    self.textField.stringValue = @"Generator seeded";
}

- (IBAction)generate:(id)sender {
    int generated;
    generated = (int)(random() % 100) + 1;
    
    NSLog(@"generated = %d", generated);
    
    self.textField.intValue = generated;
}

@end
