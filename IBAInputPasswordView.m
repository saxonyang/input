//
//  IBAInputPasswordView.m
//  IBABoss
//
//  Created by yangyilin on 2018/3/19.
//  Copyright © 2018年 IBA. All rights reserved.
//

#import "IBAInputPasswordView.h"

@interface IBAInputPasswordView () <UITextViewDelegate>
@property (nonatomic ,copy) NSString *mathValue;
@property (nonatomic ,copy) void(^resultBlock)(BOOL isMatched ,NSString *input);
@property (nonatomic ,assign) NSInteger numCount;
@property (nonatomic ,assign) NSInteger currenCount;
@property (nonatomic ,assign) BOOL isMath;
@end


@implementation IBAInputPasswordView

- (instancetype)initWithFrame:(CGRect)frame numCount:(NSInteger)count mathValue:(NSString *)value result:(void(^)(BOOL isMatched ,NSString *input))result {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.numCount = count;
        self.mathValue = value;
        _resultBlock = result;
        [self creatNum];
    }
    return self;
}

- (void)creatNum {
    CGFloat btnX = 0.0,btnWith = (self.frame.size.width - (self.numCount - 1)*5)/self.numCount,btnHeight = self.frame.size.height;
    for (int i = 0; i < self.numCount; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor hexColor:@"F1F1F1"];
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btn setImage:[self selectImageWithSize:CGSizeMake(btnWith, btnHeight)] forState:UIControlStateSelected];
        btn.frame = CGRectMake(btnX, 0, btnWith, btnHeight);
        btnX += 5 + btn.frame.size.width;
        btn.tag = i + 1;
        [self addSubview:btn];
    }
    UITextView *textV = [[UITextView alloc]init];
    textV.frame = self.frame;
    textV.backgroundColor = [UIColor clearColor];
    textV.delegate = self;
    textV.tintColor =[UIColor clearColor];
    textV.textColor = [UIColor clearColor];
    textV.returnKeyType = UIReturnKeyDone;
    textV.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:textV];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.currenCount == self.numCount) {
        if ([textView.text isEqualToString:self.mathValue]) {
            self.resultBlock(YES ,textView.text);
        } else {
            self.resultBlock(NO ,textView.text);
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (text.length == 1 && ![text isEqualToString:@" "] && self.currenCount < self.numCount) {
        self.currenCount ++;
        UIButton *btn = [self viewWithTag:self.currenCount];
        btn.selected = YES;
        return YES;
    } else if ([text isEqualToString:@""] && self.currenCount > 0) {
        UIButton *btn = [self viewWithTag:self.currenCount];
        btn.selected = NO;
        self.currenCount --;
        return YES;
    } else if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return NO;
}


- (UIImage *)selectImageWithSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    // 绘图
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextAddArc(con, size.width/2, size.height/2, 8, 0, M_PI * 2, 1);
    CGContextSetFillColorWithColor(con, [UIColor blackColor].CGColor);
    CGContextFillPath(con);
    // 从图片上下文中获取绘制的图片
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    return im;
}

- (NSString *)mathValue {
    if (!_mathValue) {
        _mathValue = @"";
    }
    return _mathValue;
}

- (NSInteger)numCount {
    if (!_numCount) {
        _numCount = 0;
    }
    return _numCount;
}

- (NSInteger)currenCount {
    if (!_currenCount) {
        _currenCount = 0;
    }
    return _currenCount;
}

- (BOOL)isMath {
    if (!_isMath) {
        _isMath = NO;
    }
    return _isMath;
}
@end
