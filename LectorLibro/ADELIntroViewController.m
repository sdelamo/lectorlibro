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
#import "ASIFormDataRequest.h"

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
    self.introView.spinner.hidesWhenStopped = YES;
    self.introView.segueButton.hidden = NO;
    
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
                    NSString *imageURL = [book objectForKey:@"imageURL"];                                
                    [Libro libroWithTitle:title imageUrl:imageURL author:author bookIdentifier:bookIdentifier inManagedObjectContext:document.managedObjectContext];
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

    //self.introView.segueButton.hidden = NO;
}

- (void)fetchData
{
    NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://piccapp.es:8080/allBooks"]];
    if(data) {
        books =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        [self updateCoreDataDatabase];
    }
}

- (IBAction)login:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"http://piccapp.es:8080/login"];
    
    ASIFormDataRequest *form = [ASIFormDataRequest requestWithURL:url];
    [form addPostValue:self.introView.username.text forKey:@"email"];
    [form addPostValue:self.introView.password.text forKey:@"passwd"];
    [form setCompletionBlock:^{
        
        NSString *res = form.responseString;
        if ([res isEqualToString:@"ok"]){
            
            NSLog(@"%@", res);
            [self fetchData];
        }
    }];
    
    [form startAsynchronous];
    /*
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    [theRequest setHTTPMethod:@"POST"];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [body length]];    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];


    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if( theConnection ) {
        webData = [[NSMutableData data] retain];
    } else {
        NSLog(@"theConnection is NULL");
    }
    */    
    //Set your NSURLRequest: Use requestWithURL:(NSURL *)theURL to initialise the request.
    
    //    If you need to specify a POST request and/or HTTP headers, use NSMutableURLRequest with
    
        /*
    (void)setHTTPMethod:(NSString *)method
    (void)setHTTPBody:(NSData *)data
    (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field
    Send your request in 2 ways using NSURLConnection:
    
Synchronously: (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error
    
    This returns a NSData variable that you can process.*/
}


@end
