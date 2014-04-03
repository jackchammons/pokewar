//
//  pokerSecondViewController.h
//  Poker
//
//  Created by Jack Hammons on 2/26/14.
//  Copyright (c) 2014 Jack Hammons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pokerFirstViewController.h"

@interface pokerSecondViewController : UIViewController
- (IBAction)buttonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *presser;
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property (weak, nonatomic) IBOutlet UILabel *theBigLabel;
@property (strong, nonatomic) NSMutableString *suchString;



@property (strong, nonatomic) pokerFirstViewController *firstReference;





@end
