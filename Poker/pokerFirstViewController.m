//
//  pokerFirstViewController.m
//  Poker
//
//  Created by Jack Hammons on 2/26/14.
//  Copyright (c) 2014 Jack Hammons. All rights reserved.
//

#import "pokerFirstViewController.h"
#import <Firebase/Firebase.h>
#import <FirebaseSimpleLogin/FirebaseSimpleLogin.h>

@interface pokerFirstViewController ()

@end

@implementation pokerFirstViewController


NSArray *gameArray;
NSMutableArray *tempGameArray;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tempGameArray = [[NSMutableArray alloc] init];
    self.gameNumbers = [[NSMutableArray alloc] init];
    
    
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [arrayPaths objectAtIndex:0];
    NSString *passwordFilePath = [docDirectory stringByAppendingString:@"/password.txt"];
    NSString *userFilePath = [docDirectory stringByAppendingString:@"/user.txt"];
    
    //[@"email@this.com" writeToFile:userFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    //[@"suchSecret" writeToFile:passwordFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    self.password = [NSString stringWithContentsOfFile:passwordFilePath encoding:NSUTF8StringEncoding error:nil];
    self.userID = [NSString stringWithContentsOfFile:userFilePath encoding:NSUTF8StringEncoding error:nil];

    NSLog(@"%@",self.userID);
    NSLog(@"%@",self.password);
    
    
    //CHECK IF THE USERID AND PASSWORD ARE nil

    
    self.userIDcom = [[self.userID stringByReplacingOccurrencesOfString:@"@" withString:@""] stringByReplacingOccurrencesOfString:@"." withString:@""];

    
    NSString *url = [@"https://glaring-fire-2983.firebaseio.com/users/" stringByAppendingString:self.userIDcom];
    
    NSLog(@"%@",url);
    
    NSString *gameUrl = @"https://glaring-fire-2983.firebaseio.com/games";
    self.gameRef = [[Firebase alloc] initWithUrl: gameUrl];
    
    
    self.ref = [[Firebase alloc] initWithUrl: url];
    
    FirebaseSimpleLogin* authClient = [[FirebaseSimpleLogin alloc] initWithRef:self.ref];
    
    //try to log the user in
    [authClient loginWithEmail:self.userID andPassword:self.password withCompletionBlock:^(NSError* error, FAUser* user) {
        
        if (error != nil) {
            //the user could not be logged in
            
            
            //Looks like we need you to enter your auth info
            NSString *enteredPassword = @"";
            NSString *enteredUserID = @"";
            
            //thanks, lets see if that's any good
            
            [authClient loginWithEmail:enteredUserID andPassword:enteredPassword withCompletionBlock:^(NSError* error, FAUser* user) {
                
                
                
                
            }];
            
            
            [authClient createUserWithEmail:@"super@email.com" password:@"this" andCompletionBlock:^(NSError *error, FAUser *user) {
                NSLog(@"New User Created");//code
            }];
            
        }
        else {
            NSLog(@"LOGGED IN");
            // We are now logged in
        }
    }];
    

    
    
}




- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    
    [self.ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSLog(@"%@",snapshot.value[@"currentGames"]);
        
        NSArray * allKeys = [snapshot.value[@"currentGames"] allKeys];
        NSLog(@"Counts : %lu", (unsigned long)[allKeys count]);
        self.games = [snapshot.value[@"currentGames"] copy];
        
        [tempGameArray removeAllObjects];
        [self.gameNumbers removeAllObjects];
        
        
        for(id key in allKeys){
            NSLog(@"%@", key);
            [self.gameNumbers addObject:key];
            [tempGameArray addObject:self.games[key][@"opponent"]];
        }
        
        gameArray = [tempGameArray copy];

        
        [self.tabler reloadData];
        
    }];
    
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [gameArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [gameArray objectAtIndex:indexPath.row];
    
    
    [self.gameRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSLog(@"%@",snapshot.value[self.gameNumbers[indexPath.row]]);
        NSLog(@"%@",snapshot.value[self.gameNumbers[indexPath.row]][@"holdsPoke"]);
        
        if ([snapshot.value[self.gameNumbers[indexPath.row]][@"holdsPoke"]  isEqualToString: self.userIDcom]) {
            
            cell.textLabel.textColor = [UIColor redColor];
            
            
        }else{
            cell.textLabel.textColor = [UIColor blueColor];
        }
        
        
    }];
    
    
    
    
    
    
    
    return cell;
}













- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bigolbutton:(id)sender {
    
    
}
@end
