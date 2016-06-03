//
//  RuleTextField.h
//  TextWithRuleDemo
//
//  Created by qiu on 16/6/2.
//  Copyright © 2016年 QiuFairy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    QLTextFieldTypeNone,//随便写
    QLTextFieldTypeNum,//只有数字
    QLTextFieldTypeStrOrNum,//首字母大写，由数字，字母，下划线组成
    QLTextFieldTypeStrAndNum,//字符串中必须有数字和字母
    QLTextFieldTypeBigStr,//首字母大写，必须包含数字，字母
} TextFieldType;

@interface RuleTextField : UITextField

//在这个里面可以直接写方法
//textfield的类型
@property (nonatomic)TextFieldType textFieldType;


@property (nonatomic) NSInteger StrMinNum;//最少几位
@property (nonatomic) NSInteger StrMaxNum;//最多几位


@end
