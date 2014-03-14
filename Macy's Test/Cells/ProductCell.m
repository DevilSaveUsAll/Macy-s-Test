//
//  ProductCell.m
//  Macy's Test
//
//  Created by Danny on 3/13/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import "ProductCell.h"
#import "Product.h"

@implementation ProductCell

/* update cell using date from our product */
- (void)updateProductCell:(Product *)product {
    self.labelName.text = [NSString stringWithFormat:@"%@",product.productName];
    self.labelRegularPrice.text = [NSString stringWithFormat:@"$%0.2f",product.productRegularPrice];
    self.labelSalePrice.text = [NSString stringWithFormat:@"$%0.2f",product.productSalePrice];
    self.labelDescription.text = [NSString stringWithFormat:@"%@",product.productDescription];
    self.imageName = product.productPhotoName;
    self.productId = product.productId;
    [self.buttonProduct setImage:[UIImage imageNamed:product.productPhotoName] forState:UIControlStateNormal];
}

#pragma mark - IB Methods

- (IBAction)productTouched:(id)sender {
    if ([self.delegate respondsToSelector:@selector(productCellTouched:)]) {
        [self.delegate productCellTouched:self.imageName];
    }
}

- (IBAction)updateProduct:(id)sender {
    if ([self.delegate respondsToSelector:@selector(updateProduct:)]) {
        [self.delegate updateProduct:self.tag];
    }
}

- (IBAction)deleteProduct:(id)sender {
    if ([self.delegate respondsToSelector:@selector(deleteProduct:)]) {
        [self.delegate deleteProduct:self.productId];
    }
}

@end
