//
//  ViewController.m
//  Macy's Test
//
//  Created by Danny on 3/13/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import "MainViewController.h"
#import "CreateProductViewController.h"
#import "ShowProductViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Macys";
}

#pragma mark - IBMethods 

- (IBAction)createButtonClicked:(id)sender {
    CreateProductViewController *createProductViewController = [[CreateProductViewController alloc] init];
    [self.navigationController pushViewController:createProductViewController animated:YES];
    createProductViewController = nil;
}

- (IBAction)showButtonClicked:(id)sender {
    ShowProductViewController *showProductViewController = [[ShowProductViewController alloc] init];
    [self.navigationController pushViewController:showProductViewController animated:YES];
    showProductViewController = nil;
}

@end
