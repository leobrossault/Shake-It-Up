//
//  Form_SignUp_ViewController.m
//  Shake It Up
//
//  Created by BROSSAULT Leo on 02/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Form_SignUp_ViewController.h"
#import "NavigationController.h"
#import <pop/POP.h>
#import "User.h"
#import "Form_Validate_ViewController.h"

@interface Form_SignUp_ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameForm;
@property (weak, nonatomic) IBOutlet UITextField *lastNameForm;
@property (weak, nonatomic) IBOutlet UITextField *adressForm;
@property (weak, nonatomic) IBOutlet UITextField *mailForm;
@property (weak, nonatomic) IBOutlet UITextField *cityForm;
@property (weak, nonatomic) IBOutlet UILabel *indicForm;
@property (strong, nonatomic) UIDatePicker *datePicker;


@property (weak, nonatomic) IBOutlet UIView *validateBtn;
@property (nonatomic, strong) CAShapeLayer *line;
@property (nonatomic, strong) CALayer *point;
@property (weak, nonatomic) IBOutlet UIImageView *icoValidate;
@property (weak, nonatomic) IBOutlet UILabel *labelValidate;


@property (nonatomic, strong) NavigationController *navigation;
@property (nonatomic, strong) User *userObject;
@property (weak, nonatomic) IBOutlet UIButton *skipForm;

@end

@implementation Form_SignUp_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation = (NavigationController *)self.navigationController;
    [self.navigation showMenu];
    [self.navigation resetColorMenu];
    
    self.datePicker = [[UIDatePicker alloc]init];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    
    self.userObject = [User sharedUser];
    
    // Textfields
    CGRect firstNameFrame = self.firstNameForm.frame;
    firstNameFrame.size.height = 45;
    self.firstNameForm.frame = firstNameFrame;
    self.firstNameForm.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    
    CGRect lastNameFrame = self.lastNameForm.frame;
    lastNameFrame.size.height = 45;
    self.lastNameForm.frame = lastNameFrame;
    self.lastNameForm.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    
    CGRect adressFrame = self.adressForm.frame;
    adressFrame.size.height = 45;
    self.adressForm.frame = adressFrame;
    self.adressForm.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    
    CGRect cityFrame = self.cityForm.frame;
    cityFrame.size.height = 45;
    self.cityForm.frame = cityFrame;
    self.cityForm.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    
    CGRect mailFrame = self.mailForm.frame;
    mailFrame.size.height = 45;
    self.mailForm.frame = mailFrame;
    self.mailForm.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    
    
    // Bottom Btn
    self.line = [CAShapeLayer layer];
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint: CGPointMake(0, 0)];
    [linePath addLineToPoint: CGPointMake(25, 0)];
    self.line.path = linePath.CGPath;
    self.line.fillColor = nil;
    self.line.lineWidth = 2.5;
    self.line.strokeStart = 1;
    self.line.strokeEnd = 1;
    self.line.lineCap = kCALineCapRound;
    self.line.opacity = 0.3;
    
    self.line.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    [self.line setFrame:CGRectMake(210, 48, 25, 2.5)];
    [self.validateBtn.layer addSublayer:self.line];
    
    self.point = [CALayer layer];
    [self.point setMasksToBounds:YES];
    self.point.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    [self.point setCornerRadius: 3.0f];
    self.point.frame = CGRectMake(210, 46.7, 6, 2.5);
    self.point.opacity = 0;
    
    [self.validateBtn.layer addSublayer: self.point];
    
    UITapGestureRecognizer *tapValidate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(submitForm:)];
    [tapValidate setNumberOfTapsRequired: 1];
    [self.validateBtn addGestureRecognizer:tapValidate];
}

- (void)viewDidAppear:(BOOL)animated {
    POPSpringAnimation *animLine = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeStart];
    animLine.springSpeed = 10;
    animLine.springBounciness = 20.f;
    animLine.toValue = @(0.0);
    [self.line pop_addAnimation:animLine forKey:@"widthLine"];
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.2);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        self.point.opacity = 0.3;
    });
    
    POPSpringAnimation *animPoint = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
    animPoint.beginTime = CACurrentMediaTime() + 0.3;
    animPoint.springSpeed = 10;
    animPoint.springBounciness = 20.f;
    animPoint.fromValue = @(0.0);
    animPoint.toValue = @(-10.0);
    [self.point pop_addAnimation:animPoint forKey:@"leftPoint"];
    
    [UIView animateWithDuration: 0.3f animations:^{
        self.icoValidate.alpha = 0.3;
        CGRect frameIcoBtn = self.icoValidate.frame;
        frameIcoBtn.origin.y = self.icoValidate.frame.origin.y - 10;
        self.icoValidate.frame = frameIcoBtn;
        
        self.labelValidate.alpha = 0.3;
        CGRect frameLabelBtn = self.labelValidate.frame;
        frameLabelBtn.origin.x = self.labelValidate.frame.origin.x - 10;
        self.labelValidate.frame = frameLabelBtn;
        
    } completion:^(BOOL finished) {}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Sending data

- (void)submitForm:(id)sender {
    [self.firstNameForm resignFirstResponder];
    [self.lastNameForm resignFirstResponder];
    [self.adressForm resignFirstResponder];
    [self.mailForm resignFirstResponder];

    if ([self.firstNameForm.text length] != 0 && [self.lastNameForm.text length] != 0 && [self.mailForm.text length] != 0 && [self.adressForm.text length] != 0) {
        NSString *firstName = self.firstNameForm.text;
        NSString *lastName = self.lastNameForm.text;
        NSString *mail = self.mailForm.text;
        NSString *adress = self.adressForm.text;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.mailForm.text forKey:@"isRegister"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if ([self validateEmailWithString: self.mailForm.text] == TRUE) {
            NSString *url = [NSString stringWithFormat: @"http://37.187.118.146:8000/api/subscribe/%@/%@/%@/%@/%@/%@", firstName, lastName, @"homme", @"passwd", mail, adress];

            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
            NSURLSession *session = [NSURLSession sharedSession];
            session.configuration.timeoutIntervalForResource = 30;
            [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"error ?");
                    NSLog(@"%@", error.localizedDescription);
                    NSLog(@"%@", error);
                    [UIView animateWithDuration: 0.3f animations:^{
                        self.indicForm.alpha = 1;
                    }];
                    
                    self.indicForm.text = @"La connexion avec le serveur a echouée, essaie plus tard ...";
                } else {
                    self.userObject = [User sharedUser];
                    [self.userObject loadDataUser];
                    [self.userObject loadDataProduct];
                }
            }] resume];
            
            [UIView animateWithDuration: 0.3f animations:^{
                self.indicForm.alpha = 1;
            }];
            
            self.indicForm.text = @"Connexion en cours ...";
            [self performSegueWithIdentifier:@"validateForm" sender:sender];

        } else {
            [UIView animateWithDuration: 0.3f animations:^{
                self.indicForm.alpha = 1;
            }];
            
            self.indicForm.text = @"Le mail est invalide";
        }
    } else {
        [UIView animateWithDuration: 0.3f animations:^{
            self.indicForm.alpha = 1;
        }];
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
    if ([self.firstNameForm.text length] != 0 && [self.lastNameForm.text length] != 0 && [self.mailForm.text length] != 0 && [self.adressForm.text length] != 0) {
        self.point.opacity = 1;
        self.icoValidate.alpha = 1;
        self.labelValidate.alpha = 1;
        self.line.opacity = 1;
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification {
    [UIView animateWithDuration: 0.3f animations:^{
        [self.view setFrame:CGRectMake(0,-110,self.view.frame.size.width,self.view.frame.size.height)];
    }];
}

-(void)keyboardDidHide:(NSNotification *)notification {
    [UIView animateWithDuration: 0.3f animations:^{
        [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"validateForm"]) {
        Form_Validate_ViewController *controller = (Form_Validate_ViewController *)segue.destinationViewController;
        controller.product = self.product;
    }
}

- (IBAction)skipFormAction:(id)sender {
    [self performSegueWithIdentifier:@"validateForm" sender:sender];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
