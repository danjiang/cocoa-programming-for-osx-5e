//
//  ViewController.m
//  KvcFun
//
//  Created by 但 江 on 15/3/26.
//  Copyright (c) 2015年 Dan Thought Studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign) int fido;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setValue:[NSNumber numberWithInt:5] forKey:@"fido"];
    NSNumber *n = [self valueForKey:@"fido"];
    NSLog(@"fido = %@", n);
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)incrementFido:(id)sender {
    [self setFido:[self fido] + 1];
}

@end
