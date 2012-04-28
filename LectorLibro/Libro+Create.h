//
//  Libro+Create.h
//  LectorLibro
//
//  Created by Sergio del Amo Caballero on 4/28/12.
//  Copyright (c) 2012 Softamo S.L.U. All rights reserved.
//

#import "Libro.h"

@interface Libro (Create)

+ (Libro *)libroWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl author:(NSString *)author bookIdentifier:(NSString *)bookId  inManagedObjectContext:(NSManagedObjectContext *)context;
@end
