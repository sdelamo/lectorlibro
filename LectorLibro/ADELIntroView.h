//
//  ADELIntroView.h
//  adelsierranorte
//
//  Created by Sergio del Amo Caballero on 4/26/12.
//  Copyright (c) 2012 Softamo S.L.U. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADELIntroView : UIView
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, weak) IBOutlet UIButton *segueButton;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;

@property (nonatomic, weak) IBOutlet UITextField *username;
@property (nonatomic, weak) IBOutlet UITextField *password;
@end
