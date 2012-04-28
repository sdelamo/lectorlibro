//
//  ADELIntroViewController.h
//  adelsierranorte
//
//  Created by Sergio del Amo Caballero on 4/26/12.
//  Copyright (c) 2012 Softamo S.L.U. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ApplicationXML;

@interface ADELIntroViewController : UIViewController <NSXMLParserDelegate>
{
    NSString *json;
}

- (void)fetchData;
@end
