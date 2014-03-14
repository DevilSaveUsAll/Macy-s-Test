//
//  ProductCell.h
//  Macy's Test
//
//  Created by Danny on 3/13/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@protocol ProductCellDelegate <NSObject>

- (void)productCellTouched:(NSString *)imageName;
- (void)deleteProduct:(NSString *)productId;
- (void)updateProduct:(int)cellTag;

@end

@interface ProductCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel *labelName;
@property (nonatomic) IBOutlet UILabel *labelRegularPrice;
@property (nonatomic) IBOutlet UILabel *labelSalePrice;
@property (nonatomic) IBOutlet UILabel *labelDescription;
@property (nonatomic) IBOutlet UIButton *buttonProduct;
@property (nonatomic) IBOutlet UIButton *buttonDelete;
@property (nonatomic) IBOutlet UIButton *buttonUpdate;
@property (nonatomic) NSString *imageName;
@property (nonatomic) NSString *productId;
@property (nonatomic) id <ProductCellDelegate> delegate;

- (void)updateProductCell:(Product *)product;
- (IBAction)productTouched:(id)sender;
- (IBAction)deleteProduct:(id)sender;
- (IBAction)updateProduct:(id)sender;

@end
