//
//  DatabaseHelper.m
//  adelsierranorte
//
//  Created by Sergio del Amo Caballero on 4/24/12.
//  Copyright (c) 2012 Softamo S.L.U. All rights reserved.
//

#import "DatabaseHelper.h"

static NSMutableDictionary *managedDocumentDictionary = nil;
static BOOL debug = YES;

@implementation DatabaseHelper

+ (void)openDefaultDocumentUsingBlock:(completion_block_t)completionBlock
{
    [DatabaseHelper openDocument:DEFAULT_DATABASE usingBlock:completionBlock];
}

+ (void)openDocument:(NSString *)documentName usingBlock:(completion_block_t)completionBlock
{
    // Try to retrieve the relevant UIManagedDocument from managedDocumentDictionary
    UIManagedDocument *doc = [managedDocumentDictionary objectForKey:documentName];

    // If UIManagedObject was not retrieved, create it
    if (!doc) {
        if(debug) NSLog(@"UIManagedObject was not retrieved, create it");
        // Get URL for this document -> "<Documents Directory>/<documentName>" 
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:documentName];
    
        // Create UIManagedDocument with this URL
        doc = [[UIManagedDocument alloc] initWithFileURL:url];
    
        // Add to managedDocumentDictionary
        [managedDocumentDictionary setObject:doc forKey:documentName];
    }

    
    if(![[NSFileManager defaultManager] fileExistsAtPath:[doc.fileURL path]]) {
        if(debug) NSLog(@"File does not exist at path");
        [doc saveToURL:doc.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            completionBlock(doc);
        }];
    } else if (doc.documentState == UIDocumentStateClosed) {
        if(debug) NSLog(@"UIDocumentStateClosed");
        [doc openWithCompletionHandler:^(BOOL success) {
            completionBlock(doc);
        }];
    } else if (doc.documentState == UIDocumentStateNormal) {
        if(debug) NSLog(@"UIDocumentStateNormal");
        completionBlock(doc);
    }
    
}



@end
