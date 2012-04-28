//
//  ADELIntroViewController.m
//  adelsierranorte
//
//  Created by Sergio del Amo Caballero on 4/26/12.
//  Copyright (c) 2012 Softamo S.L.U. All rights reserved.
//

#import "ADELIntroViewController.h"
#import "ADELIntroView.h"
#import "DatabaseHelper.h"
#import "Libro+Create.h"
#import "Page+Create.h"

@interface ADELIntroViewController ()

@property (nonatomic, weak) IBOutlet ADELIntroView *introView;

@end

@implementation ADELIntroViewController
@synthesize introView = _introView;

- (void)setIntroView:(ADELIntroView *)introView 
{
    _introView = introView;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData];
}

- (void)updateCoreDataDatabase
{
    NSLog(@"%@",books);
    [DatabaseHelper openDefaultDocumentUsingBlock:^(UIManagedDocument *document) { 
        dispatch_queue_t fetchQ = dispatch_queue_create("LibrosDataIntoDocument Fetcher", NULL);
        dispatch_async(fetchQ, ^{
            [document.managedObjectContext performBlock:^{
                // Delete all objects from the database
                [DatabaseHelper deleteAllObjects:@"Page" inManagedObjectContext:document.managedObjectContext];
                [DatabaseHelper deleteAllObjects:@"Libro" inManagedObjectContext:document.managedObjectContext];
                
                for(id book in books) {
                    NSString *bookIdentifier = [book objectForKey:@"_id"];
                    NSString *title = [book objectForKey:@"title"];        
                    NSString *author = [book objectForKey:@"author"];
                    [Libro libroWithTitle:title author:author bookIdentifier:bookIdentifier inManagedObjectContext:document.managedObjectContext];
                    NSArray *pages = [book objectForKey:@"pages"];
                    for(id page in pages) {

                        NSString *content = [page objectForKey:@"content"];
                        NSNumber *number = [page objectForKey:@"number"];         
                        //NSLog(@"Number %@", number);
                        [Page pageWithHTML:content number:number bookId:bookIdentifier inManagedObjectContext:document.managedObjectContext];
                    }        
                }
            }];
        });
    }];

    [[[self introView] spinner] stopAnimating];
}

- (void)fetchData
{
    NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://piccapp.es:8080/allBooks"]];
    books =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    [self updateCoreDataDatabase];
}

@end
