//
//  Page+Create.h
//  LectorLibro
//
//  Created by Sergio del Amo Caballero on 4/28/12.
//  Copyright (c) 2012 Softamo S.L.U. All rights reserved.
//

#import "Page.h"

@interface Page (Create)
+ (Page *)pageWithHTML:(NSString *)html number:(NSNumber *)pageNumber bookId:(NSString *)bookId
inManagedObjectContext:(NSManagedObjectContext *)context;
@end
