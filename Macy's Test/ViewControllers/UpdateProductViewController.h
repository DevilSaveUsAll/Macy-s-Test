//
//  UpdateProductViewController.h
//  Macy's Test
//
//  Created by Danny on 3/14/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

typedef NS_ENUM(NSInteger, TextFieldTypes) {
    TypeChangeNone = 0,
    TypeChangeName,
    TypeChangeRegularPrice,
    TypeChangeSalePrice,
    TypeChangeDescription
};

@interface UpdateProductViewController : UIViewController <UITextFieldDelegate>

- (id)initWithProduct:(Product *)product;

@property (nonatomic) Product *product;
@property (nonatomic) IBOutlet UITextField *textFieldName;
@property (nonatomic) IBOutlet UITextField *textFieldRegularPrice;
@property (nonatomic) IBOutlet UITextField *textFieldSalePrice;
@property (nonatomic) IBOutlet UITextField *textFieldDescription;
@property (nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (nonatomic) TextFieldTypes textFieldType;

- (IBAction)updateProduct:(id)sender;

@end
