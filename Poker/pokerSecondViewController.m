//
//  pokerSecondViewController.m
//  Poker
//
//  Created by Jack Hammons on 2/26/14.
//  Copyright (c) 2014 Jack Hammons. All rights reserved.
//

#import "pokerSecondViewController.h"
#import <Firebase/Firebase.h>

@interface pokerSecondViewController ()

@end

@implementation pokerSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.suchString = [[NSMutableString alloc] init];
    
    
    NSString* url = @"https://glaring-fire-2983.firebaseio.com/games/234/holdsPoke";
    Firebase* dataRef = [[Firebase alloc] initWithUrl:url];
    [dataRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@", snapshot.value);
        NSLog(@"%@", self.firstReference.userIDcom);
        if([snapshot.value  isEqual: self.firstReference.userIDcom]){
            self.theBigLabel.text = @"Poke back!";
            self.presser.hidden=TRUE;
        }else{
            self.theBigLabel.text = @"Wait for them to poke.";
            self.presser.hidden=FALSE;
        }
        
        
        NSLog(@"%@", snapshot.value);
        [self.suchString setString:snapshot.value];
        
    }];
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    NSLog (@"Such string button = %@", self.suchString);
    
    self.labelText.text = @"this is text";
    
}


@end
