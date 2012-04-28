//
//  Page+Create.m
//  LectorLibro
//
//  Created by Sergio del Amo Caballero on 4/28/12.
//  Copyright (c) 2012 Softamo S.L.U. All rights reserved.
//

#import "Page+Create.h"
#import "Libro+Create.h"

@implementation Page (Create)


+ (Page *)pageWithHTML:(NSString *)html number:(NSNumber *)pageNumber bookId:(NSString *)bookId
                   inManagedObjectContext:(NSManagedObjectContext *)context
{
    Page *page = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Page"];
    request.predicate = [NSPredicate predicateWithFormat:@"number = %@", pageNumber];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches || ([matches count] > 1)) {
        // handle error
    } else if([matches count] == 0) {
        page = [NSEntityDescription insertNewObjectForEntityForName:@"Page" inManagedObjectContext:context];
        page.html = html;
        page.number = pageNumber;
        page.book = [Libro libroWithTitle:nil author:nil bookIdentifier:bookId inManagedObjectContext:context];
    } else {
        page = [matches lastObject];
    }
    return page;
}
@end
