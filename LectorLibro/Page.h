//
//  Page.h
//  LectorLibro
//
//  Created by Sergio del Amo Caballero on 4/28/12.
//  Copyright (c) 2012 Softamo S.L.U. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Libro;

@interface Page : NSManagedObject

@property (nonatomic, retain) NSString * html;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) Libro *book;

@end
