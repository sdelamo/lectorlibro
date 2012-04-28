//
//  Libro+Create.m
//  LectorLibro
//
//  Created by Sergio del Amo Caballero on 4/28/12.
//  Copyright (c) 2012 Softamo S.L.U. All rights reserved.
//

#import "Libro+Create.h"

@implementation Libro (Create)

+ (Libro *)libroWithTitle:(NSString *)title author:(NSString *)author bookIdentifier:(NSString *)bookId
                   inManagedObjectContext:(NSManagedObjectContext *)context
{
    Libro *libro = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Libro"];
    request.predicate = [NSPredicate predicateWithFormat:@"bookId = %@", bookId];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *libros = [context executeFetchRequest:request error:&error];
    
    if(!libros || ([libros count] > 1)) {
        // handle error
    } else if(![libros count]) {
        libro = [NSEntityDescription insertNewObjectForEntityForName:@"Libro" inManagedObjectContext:context];
        libro.title = title;
        libro.author = author;        
        libro.bookId = bookId;
    } else {
        libro = [libros lastObject];
    }
    return libro;
}

@end
