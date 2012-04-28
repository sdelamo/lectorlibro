//
//  Libro.h
//  LectorLibro
//
//  Created by Sergio del Amo Caballero on 4/28/12.
//  Copyright (c) 2012 Softamo S.L.U. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Libro : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSData * thumbnail;
@property (nonatomic, retain) NSString * bookId;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSSet *pages;
@end

@interface Libro (CoreDataGeneratedAccessors)

- (void)addPagesObject:(NSManagedObject *)value;
- (void)removePagesObject:(NSManagedObject *)value;
- (void)addPages:(NSSet *)values;
- (void)removePages:(NSSet *)values;

@end
