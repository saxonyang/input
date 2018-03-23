//
//  IBAInputPasswordView.h
//  IBABoss
//
//  Created by yangyilin on 2018/3/19.
//  Copyright © 2018年 IBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBAInputPasswordView : UIView 

- (instancetype)initWithFrame:(CGRect)frame numCount:(NSInteger)count mathValue:(NSString *)value result:(void(^)(BOOL isMatched ,NSString *input))result;
@end
