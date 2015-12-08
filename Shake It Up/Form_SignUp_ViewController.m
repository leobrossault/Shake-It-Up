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

@interface Form_SignUp_ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameForm;
@property (weak, nonatomic) IBOutlet UITextField *lastNameForm;
@property (weak, nonatomic) IBOutlet UITextField *adressForm;
@property (weak, nonatomic) IBOutlet UITextField *mailForm;
@property (weak, nonatomic) IBOutlet UILabel *indicForm;
@property (strong, nonatomic) UIDatePicker *datePicker;


@property (weak, nonatomic) IBOutlet UIView *validateBtn;
@property (nonatomic, strong) CAShapeLayer *line;
@property (nonatomic, strong) CALayer *point;
@property (weak, nonatomic) IBOutlet UIImageView *icoValidate;
@property (weak, nonatomic) IBOutlet UILabel *labelValidate;


@property (nonatomic, strong) NavigationController *navigation;

@end

@implementation Form_SignUp_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation = self.navigationController;
    [self.navigation showMenu];
    [self.navigation resetColorMenu];
    
    self.datePicker = [[UIDatePicker alloc]init];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    
    self.indicForm.hidden = true;
    
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
    
    self.line.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    [self.line setFrame:CGRectMake(208, 48, 25, 2.5)];
    [self.validateBtn.layer addSublayer:self.line];
    
    self.point = [CALayer layer];
    [self.point setMasksToBounds:YES];
    self.point.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    [self.point setCornerRadius: 3.0f];
    self.point.frame = CGRectMake(208, 46.7, 6, 2.5);
    self.point.opacity = 0;
    
    [self.validateBtn.layer addSublayer: self.point];
    
    // Resign responder
//    UITapGestureRecognizer *resign = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignResponder:)];
//    [resign setNumberOfTapsRequired: 1];
//    [self.view addGestureRecognizer:resign];
}

- (void)viewDidAppear:(BOOL)animated {
    POPSpringAnimation *animLine = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeStart];
    animLine.springSpeed = 10;
    animLine.springBounciness = 20.f;
    animLine.toValue = @(0.0);
    [self.line pop_addAnimation:animLine forKey:@"widthLine"];
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.2);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        self.point.opacity = 1;
    });
    
    POPSpringAnimation *animPoint = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
    animPoint.beginTime = CACurrentMediaTime() + 0.3;
    animPoint.springSpeed = 10;
    animPoint.springBounciness = 20.f;
    animPoint.fromValue = @(0.0);
    animPoint.toValue = @(-10.0);
    [self.point pop_addAnimation:animPoint forKey:@"leftPoint"];
    
    [UIView animateWithDuration: 0.3f animations:^{
        self.icoValidate.alpha = 1;
        CGRect frameIcoBtn = self.icoValidate.frame;
        frameIcoBtn.origin.y = self.icoValidate.frame.origin.y - 10;
        self.icoValidate.frame = frameIcoBtn;
        
        self.labelValidate.alpha = 1;
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

//- (void)goForm:(UITapGestureRecognizer *) recognizer {
//    [self performSegueWithIdentifier:@"goForm" sender:recognizer];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
