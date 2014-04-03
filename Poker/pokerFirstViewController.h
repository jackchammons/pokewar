//
//  pokerFirstViewController.h
//  Poker
//
//  Created by Jack Hammons on 2/26/14.
//  Copyright (c) 2014 Jack Hammons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>



@interface pokerFirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tabler;
- (IBAction)bigolbutton:(id)sender;
@property NSString *userID; 
@property NSString *password;
@property (strong, nonatomic) NSString *userIDcom;
@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) Firebase *gameRef;
@property (strong, nonatomic) NSDictionary *games;
@property (strong, nonatomic) NSMutableArray *gameNumbers;

@end
