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

@interface ADELIntroViewController () <UITextFieldDelegate>

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
    self.introView.password.delegate = self;
    self.introView.spinner.hidesWhenStopped = YES;
    self.introView.segueButton.hidden = YES;
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
    self.introView.segueButton.hidden = NO;
    self.introView.loginButton.hidden = YES;
    self.introView.username.hidden = YES;
    self.introView.password.hidden = YES;
    

}

- (void)fetchData {
    NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://piccapp.es:8080/allBooks"]];
    if(data) {
        books =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        [self updateCoreDataDatabase];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    textField.hidden = YES;
    [self login:nil];
    return NO;
    
}

- (IBAction)login:(UIButton *)sender {
    [[[self introView] spinner] startAnimating];
    NSURL *url = [NSURL URLWithString:@"http://piccapp.es:8080/login"];
    
    ASIFormDataRequest *form = [ASIFormDataRequest requestWithURL:url];
    [form addPostValue:self.introView.username.text forKey:@"email"];
    [form addPostValue:self.introView.password.text forKey:@"passwd"];
    [form setCompletionBlock:^{
        NSString *res = form.responseString;
        NSLog(@"Response String %@", res);
        if ([res isEqualToString:@"ok"]){
            NSLog(@"%@", res);
            [self fetchData];
        }
    }];
    
    
    [form startAsynchronous];

}


@end
