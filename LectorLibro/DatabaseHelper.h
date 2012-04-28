//
//  DatabaseHelper.h
//  adelsierranorte
//
//  Created by Sergio del Amo Caballero on 4/24/12.
//  Copyright (c) 2012 Softamo S.L.U. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_DATABASE @"database"

typedef void (^completion_block_t)(UIManagedDocument *managedDocument);

@interface DatabaseHelper : NSObject

+ (void)openDefaultDocumentUsingBlock:(completion_block_t)completionBlock;

+ (void)openDocument:(NSString *)name usingBlock:(completion_block_t)completionBlock;


@end
