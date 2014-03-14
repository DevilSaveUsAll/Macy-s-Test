//
//  CreateProductViewController.h
//  Macy's Test
//
//  Created by Danny on 3/14/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateProductViewController : UIViewController <UITableViewDataSource, UITableViewDataSource>

@property (nonatomic) IBOutlet UITableView *tableCreateProduct;
@property (nonatomic) NSMutableArray *productsToCreate;


@end
