//
//  ProductInfoViewController.m
//  Macy's Test
//
//  Created by Danny on 3/14/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import "ProductInfoViewController.h"

@interface ProductInfoViewController ()

@end

@implementation ProductInfoViewController

#pragma mark - View LifeCycle;

- (id)initWithProduct:(Product *)product {
    if (self = [super init]) {
        self.product = product;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Info";
    [self setUpProductInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utilities

- (void)setUpProductInfo {
    self.labelProductName.text = self.product.productName;
    self.labelProductRegularPrice.text = [NSString stringWithFormat:@"%0.2f",self.product.productRegularPrice];
    self.labelProductSalePrice.text = [NSString stringWithFormat:@"%0.2f",self.product.productSalePrice];
    self.labelProductDescription.text = self.product.productDescription;
    self.imageViewProduct.image = [UIImage imageNamed:self.product.productPhotoName];
    
    NSString *colorString = @"Colors:";
    for (int i = 0; i < self.product.colors.count; i++) {
        colorString = [NSString stringWithFormat:@"%@ %@",colorString, [self.product.colors objectAtIndex:i]];
    }
    
    self.labelProductColors.text = colorString;
    
    NSString *storeString = @"Stores:";
    for (int i = 0;i < self.product.stores.count;i++) {
        NSString *key = [NSString stringWithFormat:@"location%d",i+1];
        NSLog(@"%@",key);
        storeString = [NSString stringWithFormat:@"%@ %@",storeString, [self.product.stores objectForKey:key]];
    }
    self.labelProductStores.text = storeString;
    
}

@end
