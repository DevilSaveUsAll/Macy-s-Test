//
//  CreateProductViewController.m
//  Macy's Test
//
//  Created by Danny on 3/14/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import "CreateProductViewController.h"
#import "Product.h" 
#import "ProductDatabase.h"

@interface CreateProductViewController ()

@end

@implementation CreateProductViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createTempData];
    self.navigationItem.title = @"Create a Product";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utilties

- (void)createTempData {
    self.productsToCreate = [[NSMutableArray alloc] init];
    /* get the path for the plist that we are using */
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ProductData" ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    for (int i = 0; i < data.count; i++) {
        NSDictionary *list = [data objectForKey:[NSString stringWithFormat:@"Product%d",i+1]];
        Product *product = [[Product alloc] init];
        product.productId = list[@"id"];
        product.productName = list[@"name"];
        product.productDescription = list[@"description"];
        product.productRegularPrice = [list[@"Regular Price"] floatValue];
        product.productSalePrice = [list[@"Sale Price"] floatValue];
        product.productPhotoName = list[@"photoName"];
        product.colors = list[@"Colors"];
        product.stores = list[@"stores"];
        [self.productsToCreate addObject:product];
    }
    /* refreshes the table once we have all the data */
    [self.tableCreateProduct reloadData];
}

#pragma mark - UITableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productsToCreate.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Tap to create object #%d",indexPath.row+1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[ProductDatabase database] saveEntry:[self.productsToCreate objectAtIndex:indexPath.row]];
}

@end
