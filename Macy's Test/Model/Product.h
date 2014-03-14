//
//  Product.h
//  Macy's Test
//
//  Created by Danny on 3/13/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productDescription;
@property (nonatomic, copy) NSString *productPhotoName;
@property (nonatomic) NSArray *colors;
@property (nonatomic) NSDictionary *stores;
@property (nonatomic, assign) float productRegularPrice;
@property (nonatomic, assign) float productSalePrice;

@end
