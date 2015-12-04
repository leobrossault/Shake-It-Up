//
//  Form_SignUp_ViewController.m
//  Shake It Up
//
//  Created by BROSSAULT Leo on 02/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Form_SignUp_ViewController.h"

@interface Form_SignUp_ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameForm;
@property (weak, nonatomic) IBOutlet UITextField *lastNameForm;
@property (weak, nonatomic) IBOutlet UITextField *adressForm;
@property (weak, nonatomic) IBOutlet UITextField *mailForm;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *indicForm;

@end

@implementation Form_SignUp_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datePicker = [[UIDatePicker alloc]init];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    
    self.indicForm.hidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Sending data

- (IBAction)submitForm:(id)sender {
    [self.firstNameForm resignFirstResponder];
    [self.lastNameForm resignFirstResponder];
    [self.adressForm resignFirstResponder];
    [self.mailForm resignFirstResponder];
    
    if ([self.firstNameForm.text length] != 0 && [self.lastNameForm.text length] != 0 && [self.mailForm.text length] != 0 && [self.adressForm.text length] != 0) {
        NSString *firstName = self.firstNameForm.text;
        NSString *lastName = self.lastNameForm.text;
        NSString *mail = self.mailForm.text;
        NSString *adress = self.adressForm.text;
        
        if ([self validateEmailWithString: self.mailForm.text] == TRUE) {
            NSLog(@"%@/%@/%@", firstName, lastName, mail);
    
            NSString *url = [NSString stringWithFormat: @"http://172.18.34.89:8000/api/subscribe/%@/%@/%@/%@/%@/%@", firstName, lastName, @"homme", @"passwd", mail, adress];
    
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
            NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [conn start];
        } else {
            self.indicForm.text = @"Le mail est invalide";
        }
    } else {
        self.indicForm.hidden = false;
    }
}

- (BOOL) validateEmailWithString:(NSString*)checkString {
    
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", laxString];
    return [emailTest evaluateWithObject:checkString];
}

#pragma Check URL availibility

// If URL return response
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.indicForm.textColor = [UIColor colorWithRed:0.463 green:0.863 blue:0.035 alpha:1];
    self.indicForm.text = @"Les données ont bien été enregistrées !";
}

// If URL fail
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.indicForm.text = @"La connexion avec le serveur a echouée, essaie plus tard ...";
}

#pragma Hide Keyboard

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
