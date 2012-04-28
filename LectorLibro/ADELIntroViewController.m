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
    /*
    [DatabaseHelper openDefaultDocumentUsingBlock:^(UIManagedDocument *document){
        dispatch_queue_t fetchQ = dispatch_queue_create("LibrosDataIntoDocument Fetcher", NULL);
        dispatch_async(fetchQ, ^{
            [document.managedObjectContext performBlock:^{
                NSLog(@"Persiste data");
            }];
        });
    }];
    */
    [[[self introView] spinner] stopAnimating];
}

- (void)fetchData
{
    //TODO Retrieve data
    [self updateCoreDataDatabase];
}

@end
