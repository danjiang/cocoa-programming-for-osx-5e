//
//  ViewController.m
//  Departments
//
//  Created by 但 江 on 15/4/6.
//  Copyright (c) 2015年 Dan Thought Studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak) IBOutlet NSBox *box;
@property (weak) IBOutlet NSPopUpButton *popUp;
@property (strong) NSManagedObjectContext *moc;

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

- (IBAction)changeViewController:(id)sender {
    [self performSegueWithIdentifier:@"DepartmentToEmployee" sender:sender];
}

@end
