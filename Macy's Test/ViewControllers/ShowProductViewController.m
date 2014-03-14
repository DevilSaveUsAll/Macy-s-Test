//
//  ShowProductViewController.m
//  Macy's Test
//
//  Created by Danny on 3/14/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import "ShowProductViewController.h"
#import "ProductDatabase.h"
#import "Product.h"
#import "ProductInfoViewController.h"
#import "UpdateProductViewController.h"

@interface ShowProductViewController () {
    BOOL touched;
}

@end

@implementation ShowProductViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Products";
}

- (void)viewDidAppear:(BOOL)animated {
    /* i am initializing the list of products here so when i hit back from the updated view controller it would update the data */
    [self.spinner startAnimating];
    self.listOfProducts = [[ProductDatabase database] getListOfProducts];
    [self.tableShowProduct reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfProducts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"productCell";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
        cell = self.cellProduct;
    }
    cell.delegate = self;
    cell.tag = indexPath.row;
    Product *product = [self.listOfProducts objectAtIndex:[indexPath row]];
    [cell updateProductCell:product];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Product *product = [self.listOfProducts objectAtIndex:indexPath.row];
    ProductInfoViewController *infoViewController = [[ProductInfoViewController alloc] initWithProduct:product];
    [self.navigationController pushViewController:infoViewController animated:YES];
    infoViewController = nil;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        [self.spinner stopAnimating];
    }
}

#pragma mark - ProductCell Delegate

- (void)productCellTouched:(NSString *)imageName {
    self.viewImageContainer.hidden = NO;
    self.imageViewFullImage.image = [UIImage imageNamed:imageName];
    [self makeFullImageAppear];
}

- (void)updateProduct:(int)cellTag {
    Product *product = [self.listOfProducts objectAtIndex:cellTag];
    UpdateProductViewController *updateViewController = [[UpdateProductViewController alloc] initWithProduct:product];
    [self.navigationController pushViewController:updateViewController animated:YES];
    updateViewController = nil;
}

- (void)deleteProduct:(NSString *)productId {
    [[ProductDatabase database] deleteFromDatabaseWithId:productId];
    self.listOfProducts = [[ProductDatabase database] getListOfProducts];
    [self.tableShowProduct reloadData];
    /* i know we can have an animation by deleting a row, but to save time here, I won't write one */
}

#pragma mark - Touch Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    touched = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    touched = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    touched = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touched) {
        [self makeFullImageDisappear];
    }
    touched = NO;
}

#pragma mark - Utilities/Animations

- (void)makeFullImageAppear {
    self.imageViewFullImage.hidden = NO;
    [self bounceView:self.viewImageContainer fadeInBgdView:nil];
}


- (void)makeFullImageDisappear {
    [self popOutView:self.viewImageContainer completion:nil];
}

/* these are some animation methods that I used in my last projects */
- (void) bounceView:(UIView *)view
{
    view.layer.transform = CATransform3DMakeScale(0.3, 0.3, 1.0);
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.3],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.95],
                              [NSNumber numberWithFloat:1.0], nil];
    
    bounceAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0],
                                [NSNumber numberWithFloat:0.4],
                                [NSNumber numberWithFloat:0.7],
                                [NSNumber numberWithFloat:0.9],
                                [NSNumber numberWithFloat:1.0], nil];
    
    bounceAnimation.timingFunctions = [NSArray arrayWithObjects:
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    bounceAnimation.duration = 0.5;
    [view.layer addAnimation:bounceAnimation forKey:@"bounce"];
    
    view.layer.transform = CATransform3DIdentity;
}

- (void) bounceView:(UIView *)view fadeInBgdView:(UIView *)bgdView completion:(void (^)(BOOL))completed {
    view.alpha = 0;
    bgdView.alpha = 0;
    [UIView animateWithDuration:0.15 animations:^{
        view.alpha = 0.99f;
        bgdView.alpha = 0.99f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35 animations:^{
            view.alpha = 1.f;
            bgdView.alpha = 1.f;
        } completion:completed];
    }];
    [self bounceView:view];
}

- (void) bounceView:(UIView *)view fadeInBgdView:(UIView *)bgdView {
    [self bounceView:view fadeInBgdView:bgdView completion:nil];
}

- (void) popOutView:(UIView *)view completion:(void (^)(void))completed {
    [UIView animateWithDuration:0.3f animations:^{
        view.alpha = 0.f;
        //view.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    } completion:^(BOOL finished) {
        view.transform = CGAffineTransformIdentity;
        if (finished && completed) {
            completed();
        }
    }];
}


@end
