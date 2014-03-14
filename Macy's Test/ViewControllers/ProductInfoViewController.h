//
//  ProductInfoViewController.h
//  Macy's Test
//
//  Created by Danny on 3/14/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductInfoViewController : UIViewController

@property (nonatomic) Product *product;

@property (nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (nonatomic) IBOutlet UILabel *labelProductName;
@property (nonatomic) IBOutlet UILabel *labelProductRegularPrice;
@property (nonatomic) IBOutlet UILabel *labelProductSalePrice;
@property (nonatomic) IBOutlet UILabel *labelProductDescription;
@property (nonatomic) IBOutlet UILabel *labelProductColors;
@property (nonatomic) IBOutlet UILabel *labelProductStores;

- (id)initWithProduct:(Product *)product;


@end
