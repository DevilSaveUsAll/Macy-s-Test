//
//  ShowProductViewController.h
//  Macy's Test
//
//  Created by Danny on 3/14/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCell.h"

@interface ShowProductViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,ProductCellDelegate>

@property (nonatomic) IBOutlet ProductCell *cellProduct;
@property (nonatomic) IBOutlet UITableView *tableShowProduct;
@property (nonatomic) IBOutlet UIView *viewImageContainer;
@property (nonatomic) IBOutlet UIImageView *imageViewFullImage;
@property (nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic) NSArray *listOfProducts;


@end
