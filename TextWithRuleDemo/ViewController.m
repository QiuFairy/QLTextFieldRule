//
//  ViewController.m
//  TextWithRuleDemo
//
//  Created by qiu on 16/6/2.
//  Copyright © 2016年 QiuFairy. All rights reserved.
//

#import "ViewController.h"

#import "RuleTextField.h"

#define SWidth [UIScreen mainScreen].bounds.size.width-40

@interface ViewController ()

@property (nonatomic, strong) RuleTextField *ruletextFieldNone;
@property (nonatomic, strong) RuleTextField *ruletextFieldNum;
@property (nonatomic, strong) RuleTextField *ruletextFieldStrOrNum;
@property (nonatomic, strong) RuleTextField *ruletextFieldStrAndNum;
@property (nonatomic, strong) RuleTextField *ruletextFieldBigStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"输入区间是6-8位";
    
    self.ruletextFieldNone = [self createTextFieldFrame:CGRectMake(20, 100, SWidth, 44) textPla:@"ruletextFieldNone:无限制" textFType:QLTextFieldTypeNone TextStrMinNum:0 textStrMaxNum:MAXFLOAT];
    self.ruletextFieldNum = [self createTextFieldFrame:CGRectMake(20, 180, SWidth, 44) textPla:@"ruletextFieldNum:只能输入数字" textFType:QLTextFieldTypeNum TextStrMinNum:6 textStrMaxNum:8];
    self.ruletextFieldStrOrNum = [self createTextFieldFrame:CGRectMake(20, 260, SWidth, 44) textPla:@"ruletextFieldStrOrNum:首字母大写，由数字，字母，下划线组成" textFType:QLTextFieldTypeStrOrNum TextStrMinNum:6 textStrMaxNum:8];
    self.ruletextFieldStrAndNum = [self createTextFieldFrame:CGRectMake(20, 340, SWidth, 44) textPla:@"ruletextFieldStrAndNum:字符串中必须有数字和字母" textFType:QLTextFieldTypeStrAndNum TextStrMinNum:6 textStrMaxNum:8];
    self.ruletextFieldBigStr = [self createTextFieldFrame:CGRectMake(20, 420, SWidth, 44) textPla:@"ruletextFieldBigStr:首字母大写，必须包含数字，字母" textFType:QLTextFieldTypeBigStr TextStrMinNum:6 textStrMaxNum:8];
}
-(RuleTextField *)createTextFieldFrame:(CGRect)TextRect textPla:(NSString *)textPla textFType:(TextFieldType)textFType TextStrMinNum:(NSInteger)StrMinNum textStrMaxNum:(NSInteger)StrMaxNum{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(TextRect.origin.x, TextRect.origin.y-30, TextRect.size.width, 25)];
    label.numberOfLines = 2;
    label.adjustsFontSizeToFitWidth = YES;
    label.text = textPla;
    [self.view addSubview:label];
    
    RuleTextField *ruleTextField = [[RuleTextField alloc]initWithFrame:TextRect];
    ruleTextField.borderStyle = UITextBorderStyleRoundedRect;
//    ruleTextField.placeholder = textPla;
    [self.view addSubview:ruleTextField];
    ruleTextField.textFieldType = textFType;
    ruleTextField.StrMinNum = StrMinNum;
    ruleTextField.StrMaxNum = StrMaxNum;
    return ruleTextField;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.ruletextFieldNone resignFirstResponder];
    [self.ruletextFieldNum resignFirstResponder];
    [self.ruletextFieldStrOrNum resignFirstResponder];
    [self.ruletextFieldStrAndNum resignFirstResponder];
    [self.ruletextFieldBigStr resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
