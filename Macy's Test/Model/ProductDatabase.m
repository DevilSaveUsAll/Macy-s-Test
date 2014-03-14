//
//  ProductDatabase.m
//  Macy's Test
//
//  Created by Danny on 3/13/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import "ProductDatabase.h"
#import "Product.h"

@implementation ProductDatabase

static ProductDatabase *sharedDatabase;

#pragma mark - Initialization

/* turns this class into a singleton */
+ (ProductDatabase *)database {
    if (sharedDatabase == nil) {
        sharedDatabase = [[ProductDatabase alloc] init];
    }
    return sharedDatabase;
}

- (id)init {
    if (self = [super init]) {
        /* initiate database */
        [self openDB];
        [self createTable:@"Products" withId:@"id" withName:@"name" withDescription:@"description" withRegularPrice:@"regularPrice" withSalePrice:@"salePrice" withProductPhoto:@"productPhoto" withColors:@"colors" withStores:@"stores"];
    }
    return self;
}

#pragma mark - Utilities

- (NSString *)filePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"product.sql"];
}

- (void)openDB {
    if (sqlite3_open([[self filePath] UTF8String], &database) != SQLITE_OK) {
        /* if database has an error close it */
        sqlite3_close(database);
        NSAssert(0, @"Database failed to open");
    }
    else {
        NSLog(@"database opened successfully");
    }
}

- (NSString *)convertArrayIntoJSONString:(NSArray *)array {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSArray *)convertJSONStringIntoArray:(NSString *)jsonString {
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dataArray;
}

- (NSString *)convertDictionaryIntoJSONString:(NSDictionary *)dictionary {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSDictionary *)convertJSONStringIntoDictionary:(NSString *)jsonString {
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dataDictionary;
}

#pragma mark - sql3 METHODS

- (void)createTable:(NSString *)tableName
                    withId:(NSString *)objectId
                    withName:(NSString *)name
                    withDescription:(NSString *)description
                    withRegularPrice:(NSString *)regularPrice
                    withSalePrice:(NSString *)salePrice
                    withProductPhoto:(NSString *)photo
                    withColors:(NSString *)colors
                    withStores:(NSString *)stores {
  
    char *err;
    NSString *query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' TEXT PRIMARY KEY, '%@' TEXT, '%@' TEXT, '%@' FLOAT, '%@' FLOAT, '%@' TEXT, '%@' TEXT,'%@' TEXT);",tableName,objectId,name,description,regularPrice,salePrice,photo,colors,stores];
  
    /* create the table with our query*/
    if (sqlite3_exec(database, [query UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Could not create table");
    }
    else {
        NSLog(@"Table created successfully");
    }
}

- (void)saveEntry:(Product *)product {
    /* just making new variables to make code more readable, the other way is to use the dot syntax on the query string */
    NSString *objectId = product.productId;
    NSString *name = product.productName;
    NSString *description = product.productDescription;
    NSString *photoName = product.productPhotoName;
    float regularPrice = product.productRegularPrice;
    float salePrice = product.productSalePrice;
    NSArray *colors = product.colors;
    NSDictionary *stores = product.stores;
  
    /* convert array and diction into strings, because you cannot save arrays or dictionary into sqlite db */
    NSString *colorsJSONString = [self convertArrayIntoJSONString:colors];
    NSString *storesJSONString = [self convertDictionaryIntoJSONString:stores];

    NSString *query = [NSString stringWithFormat:@"INSERT INTO Products ('id','name','description','regularPrice','salePrice', 'productPhoto','colors','stores') VALUES ('%@','%@','%@','%f','%f','%@','%@','%@')",objectId,name,description,regularPrice,salePrice,photoName,colorsJSONString,storesJSONString];
    
    char *err;
    if (sqlite3_exec(database, [query UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Could not update table");
    }
    else {
        NSLog(@"updated table");
    }
}

- (NSArray *)getListOfProducts {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Products"];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            Product *product = [[Product alloc] init];
            
            char *objectChar = (char *) sqlite3_column_text(statement, 0);
            NSString *objectId = [[NSString alloc] initWithUTF8String:objectChar];
            
            char *nameChar = (char *) sqlite3_column_text(statement, 1);
            NSString *name = [[NSString alloc] initWithUTF8String:nameChar];
            
            char *descrptionChar = (char *) sqlite3_column_text(statement, 2);
            NSString *description = [[NSString alloc] initWithUTF8String:descrptionChar];
            
            float regularPrice = (float)sqlite3_column_double(statement, 3);
            float salePrice = (float)sqlite3_column_double(statement, 4);
            
            char *productPhotoChar = (char *)sqlite3_column_text(statement, 5);
            NSString *productPhotoName = [NSString stringWithUTF8String:productPhotoChar];
            
            char *colorsStringChar = (char *)sqlite3_column_text(statement, 6);
            NSString *colorString = [NSString stringWithUTF8String:colorsStringChar];
            
            char *storesStringChar = (char *)sqlite3_column_text(statement, 7);
            NSString *storeString = [NSString stringWithUTF8String:storesStringChar];
            
            product.productId = objectId;
            product.productName = name;
            product.productDescription = description;
            product.productRegularPrice = regularPrice;
            product.productSalePrice = salePrice;
            product.productPhotoName = productPhotoName;
            product.colors = [self convertJSONStringIntoArray:colorString];
            product.stores = [self convertJSONStringIntoDictionary:storeString];
            
            [tempArray addObject:product];
        }
    }
    return [tempArray copy];
}

- (void)deleteFromDatabaseWithId:(NSString *)productId {
    NSString *query = [NSString stringWithFormat:@"DELETE FROM Products WHERE id = '%@'",productId];
    
    char *err;
    if (sqlite3_exec(database, [query UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Could not delete row");
    }
    else {
        NSLog(@"deleted");
    }
}

- (void)updateToDataBaseWithName:(NSString *)productName withRegularPrice:(float)regularPrice withSalePrice:(float)salePrice withDescription:(NSString *)productDescription withProductId:(Product *)product {
    if (!productName) {
        productName = product.productName;
    }
    
    if (!regularPrice) {
        regularPrice = product.productRegularPrice;
    }
    
    if (!salePrice) {
        salePrice = product.productSalePrice;
    }
    
    if (!productDescription) {
        productDescription = product.productDescription;
    }
    
    NSString *query = [NSString stringWithFormat:@"UPDATE Products set name = '%@', description = '%@', regularPrice = '%f', salePrice = '%f' WHERE id = '%@'",productName, productDescription,regularPrice,salePrice,product.productId];
    
    char *err;
    if (sqlite3_exec(database, [query UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Could not update row");
    }
    else {
        NSLog(@"updated");
    }
}

@end
