//
//  UpdateProductViewController.m
//  Macy's Test
//
//  Created by Danny on 3/14/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import "UpdateProductViewController.h"
#import "ProductDatabase.h"

@interface UpdateProductViewController ()

@end

@implementation UpdateProductViewController

#pragma mark - View lifecycle

- (id)initWithProduct:(Product *)product {
    if (self = [super init]) {
        self.product = product;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateImage];
    self.navigationItem.title = @"Update Product";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utilities

- (void)updateImage {
    self.imageViewProduct.image = [UIImage imageNamed:self.product.productPhotoName];
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect frame = self.view.frame;
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGFloat newHeight;
    
    if (self.textFieldType > TypeChangeName) {
        newHeight = keyboardSize.height - CGRectGetHeight(self.textFieldRegularPrice.frame);
        [self.view setFrame:CGRectMake(0,-newHeight,width,height)];
    }
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    CGRect frame = self.view.frame;
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    [self.view setFrame:CGRectMake(0,0,width,height)];
}

#pragma mark - IB Methods

- (IBAction)updateProduct:(id)sender {
    NSString *productName = self.textFieldName.text;
    float productRegularPrice = [self.textFieldRegularPrice.text floatValue];
    float productSalePrice = [self.textFieldSalePrice.text floatValue];
    NSString *productDescription = self.textFieldDescription.text;
    
    [[ProductDatabase database] updateToDataBaseWithName:productName withRegularPrice:productRegularPrice withSalePrice:productSalePrice withDescription:productDescription withProductId:self.product];
    
    self.textFieldName.text = @"";
    self.textFieldRegularPrice.text = @"";
    self.textFieldSalePrice.text = @"";
    self.textFieldDescription.text = @"";
    
}

#pragma mark - Touch Methods 

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.textFieldType = TypeChangeNone;
    [self.view endEditing:YES];
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    switch (textField.tag) {
        case TypeChangeName:
            self.textFieldType = TypeChangeName;
            break;
            
        case TypeChangeRegularPrice:
            self.textFieldType = TypeChangeRegularPrice;
            break;
            
        case TypeChangeSalePrice:
            self.textFieldType = TypeChangeSalePrice;
            break;
            
        case TypeChangeDescription:
            self.textFieldType = TypeChangeDescription;
            break;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.textFieldType = TypeChangeNone;
    return YES;
}

@end
