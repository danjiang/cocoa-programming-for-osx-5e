//
//  ViewController.m
//  DrawingFun
//
//  Created by 但 江 on 15/4/3.
//  Copyright (c) 2015年 Dan Thought Studio. All rights reserved.
//

#import "ViewController.h"
#import "StretchView.h"

@interface ViewController ()

@property (weak) IBOutlet StretchView *stretchView;

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

- (IBAction)showOpenPanel:(id)sender {
    __block NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setAllowedFileTypes:[NSImage imageFileTypes]];
    [panel beginSheetModalForWindow:self.stretchView.window completionHandler:^(NSInteger result) {
        if (result == NSOKButton) {
            NSImage *image = [[NSImage alloc] initWithContentsOfURL:panel.URL];
            self.stretchView.image = image;
        }
        panel = nil;
    }];
}

@end
