//
//  ASCLoginViewController.m
//  Web_Service_Exemplo
//
//  Created by Alex De Souza Campelo Lima on 9/22/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCLoginViewController.h"
#import "ASCMainScreenViewController.h"

@interface ASCLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation ASCLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _password.secureTextEntry = YES;
    [self retrieveLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) alertStatusMessage:(NSString*) msg Title:(NSString*) title Tag: (int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title
                                                        message: msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

- (IBAction)sendLogin:(id)sender {
    
    
    NSInteger success = 0;
    
    @try {
        if ([[self.user text] isEqualToString:@""] || [[self.password text] isEqualToString:@""])
        {
            [self alertStatusMessage:@"Please enter Email and Password" Title:@"Sign in failed" Tag:0];
        }
        else
        {
            
            NSString *post = [[NSString alloc] initWithFormat:@"username=%@&password=%@",[self.user text],[self.password text]];
            NSLog(@"PostData: %@",post);
            
            NSString* address = [NSString stringWithFormat:@"http://%@:8888/jsonlogin.php", _ip];
            NSLog(@"address %@", address);
            
            NSURL *url = [NSURL URLWithString:address];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength
           forHTTPHeaderField: @"Content-Length"];
            [request setValue:@"application/json"
           forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded"
           forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            //NSLog(@"error %@", error);
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                
                NSString *responseData = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSLog(@"ae");
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:urlData options: NSJSONReadingMutableContainers error: &error];
                
                success = [jsonData[@"success"] integerValue];
                
                NSLog(@"success: %ld", (long) success);
                
                if (success == 1) {
                    NSLog(@"Login SUCESS");
                }
                else
                {
                    NSString *error_msg = (NSString*) jsonData[@"error_message"];
                    
                    [self alertStatusMessage:error_msg Title:@"Sign in Failed! " Tag:0];
                }
            }
            else
            {
                [self alertStatusMessage:@"Connection Failed" Title:@"Access Failed" Tag:0];
            }
        
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception: %@",exception);
        
        [self alertStatusMessage:@"Sign in Failed" Title:@"Error!" Tag:0];
        
    }
    @finally {
        
        if (success) {
            [self saveLogin];
            [self presentViewController:[[ASCMainScreenViewController alloc] init] animated:YES completion:nil];
        }
        
    }
}

-(IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

-(void) saveLogin
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [prefs setObject:self.user.text forKey:@"username"];
    [prefs setObject:self.password.text  forKey:@"password"];
    
    [prefs synchronize];
    
}

-(void) retrieveLogin
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    self.user.text = [prefs stringForKey:@"username"];
    self.password.text = [prefs stringForKey:@"password"];

}

@end
