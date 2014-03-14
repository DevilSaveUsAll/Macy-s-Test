//
//  ProductDatabase.h
//  Macy's Test
//
//  Created by Danny on 3/13/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class Product;

@interface ProductDatabase : NSObject {
  sqlite3 *database;
}

+ (ProductDatabase *)database;
- (void)createTable:(NSString *)tableName
             withId:(NSString *)objectId
           withName:(NSString *)name
    withDescription:(NSString *)description
   withRegularPrice:(NSString *)regularPrice
      withSalePrice:(NSString *)salePrice
   withProductPhoto:(NSString *)photo
         withColors:(NSString *)colors
         withStores:(NSString *)stores;

- (void)saveEntry:(Product *)product;
- (NSArray *)getListOfProducts;
- (void)openDB;
- (void)deleteFromDatabaseWithId:(NSString *)productId;
- (void)updateToDataBaseWithName:(NSString *)productName withRegularPrice:(float)regularPrice withSalePrice:(float)salePrice withDescription:(NSString *)productDescription withProductId:(Product *)product;

@end
