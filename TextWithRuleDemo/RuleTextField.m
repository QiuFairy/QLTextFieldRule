//
//  RuleTextField.m
//  TextWithRuleDemo
//
//  Created by qiu on 16/6/2.
//  Copyright © 2016年 QiuFairy. All rights reserved.
//

#import "RuleTextField.h"


@interface RuleTextField ()<UITextFieldDelegate,UIAlertViewDelegate>

@end

@implementation RuleTextField

//绑定事件

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = self;
        if (self.textFieldType == QLTextFieldTypeNone) {
            self.StrMaxNum = MAXFLOAT;
        }
    }
    return self;
}

//如果输入超过规定的字数StrMaxNum，就不再让输入
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location>=self.StrMaxNum){
        return  NO;
    }else{
        return YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if([self isConformthisRule:self.textFieldType textFieldStr:textField.text]){
        [self ShowAlertView:@"符合条件"];
    }else{
        [self ShowAlertView:@"不符合条件"];
    }
}

-(BOOL)isConformthisRule:(TextFieldType)textFileType textFieldStr:(NSString *)textFieldStr{
    if (textFileType == QLTextFieldTypeNone) {
        return YES;
    }else if (textFileType == QLTextFieldTypeNum){
        //全是数字
        return [self isConformthisRule4StrNum:textFieldStr];
    }else if(textFileType == QLTextFieldTypeStrOrNum){
        //首字母大写，可以有数字，字母，下划线组成
        return [self isConformthisRule4StrOrNum:textFieldStr];
    }else if (textFileType == QLTextFieldTypeStrAndNum){
        //字符串中必须有数字和字母组成
        return [self ishasMustConformthisRule4StrAndNum:textFieldStr];
    }else if(textFileType == QLTextFieldTypeBigStr){
        //字符串中必须有数字和字母组成，并且首字母必须是大写的字母
        return [self ishasMustConformthisRule4BigStr:textFieldStr];
    }
    return YES;
}

#pragma mark --全是数字
/**
 *  @author QiuFairy, 16-06-02 15:06:40
 *
 *  判断字符串是否全是数字
 *
 *  @param str 输入的字符串
 *
 *  @return yes or no
 */
- (BOOL) isConformthisRule4StrNum: (NSString *) str{
    if (!str) {
        return NO;
    }
    NSString *patternStr = [NSString stringWithFormat:@"^\\d{%ld,%ld}$",self.StrMinNum,self.StrMaxNum];
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:patternStr
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}

#pragma mark --首字母大写，可以有数字，字母，下划线组成
/**
 *  @author QiuFairy, 16-06-02 15:06:26
 *
 *  判断字符串是否是首字母大写，可以有数字，字母，下划线组成
 *
 *  @param str 输入的字符串
 *
 *  @return yes or no
 */

- (BOOL) isConformthisRule4StrOrNum: (NSString *) str{
    if (!str) {
        return NO;
    }
    NSString *patternStr = [NSString stringWithFormat:@"^(\\b[A-Z][a-zA-Z0-9_]).{%ld,%ld}$",self.StrMinNum-2,self.StrMaxNum-2];
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:patternStr
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}

#pragma mark --字符串中必须有数字和字母组成
/**
 *  @author QiuFairy, 16-06-02 16:06:08
 *
 *  此方法是用来检测:字符串中必须有数字和字母组成
 *
 *  ^(?![^a-zA-Z]+$)(?!\\D+$).{8,15}$
 *
 *  @param str 输入的字符串
 *
 *  @return yes or no
 */

- (BOOL) ishasMustConformthisRule4StrAndNum: (NSString *) str{
    if (!str) {
        return NO;
    }
    NSString *patternStr = [NSString stringWithFormat:@"^(?![^a-zA-Z]+$)(?!\\D+$).{%ld,%ld}$",self.StrMinNum,self.StrMaxNum];
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:patternStr
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}

#pragma mark --字符串中必须有数字和字母组成，并且首字母必须是大写的字母
/**
 *  @author QiuFairy, 16-06-02 16:06:33
 *
 *  此方法是用来检测:字符串中必须有数字和字母组成，并且首字母必须是大写的字母
 *
 
 *  Note:此处无正则表达式，故只能先取出第一个字符来进行判定是否是大写
 
 *  @param str 输入的字符串
 *
 *  @return yes or no
 */
- (BOOL) ishasMustConformthisRule4BigStr: (NSString *) str{
    if (!str) {
        return NO;
    }
    if ([str isEqualToString:@""]) {
        return NO;
    }
    //用isupper来判断第一个字母是不是大写
    char ch = [str characterAtIndex:0];
    if(!isupper(ch)){
        return NO;
    }
    
    NSString *patternStr = [NSString stringWithFormat:@"^(?!\\D+$).{%ld,%ld}$",self.StrMinNum,self.StrMaxNum];
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:patternStr
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}

-(void)ShowAlertView:(NSString *)ShowStr{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:ShowStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

@end
