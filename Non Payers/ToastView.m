//
//  ToastView.m
//  Abshr
//
//  Created by Workspace Infotech on 5/5/15.
//  Copyright (c) 2015 Workspace Infotech. All rights reserved.
//

#import "ToastView.h"

@interface ToastView ()
@property (strong, nonatomic, readonly) UILabel *textLabel;
@end
@implementation ToastView
@synthesize textLabel = _textLabel;

float const ToastHeight = 60.0f;
float const ToastGap = 10.0f;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, self.frame.size.width - 10.0, self.frame.size.height - 10.0)];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.numberOfLines = 2;
        _textLabel.font = [UIFont systemFontOfSize:20.0];
        _textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_textLabel];
        
    }
    return _textLabel;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textLabel.text = text;
}

+ (void)showToastInParentView: (UIView *)parentView withText:(NSString *)text withDuaration:(float)duration;
{
    
    //Count toast views are already showing on parent. Made to show several toasts one above another
    int toastsAlreadyInParent = 0;
    for (UIView *subView in [parentView subviews]) {
        if ([subView isKindOfClass:[ToastView class]])
        {
            toastsAlreadyInParent++;
        }
    }
    
    CGRect parentFrame = parentView.frame;
    
    float yOrigin = parentFrame.size.height - (60.0+ ToastHeight * toastsAlreadyInParent + ToastGap * toastsAlreadyInParent);
    
    CGRect selfFrame = CGRectMake(parentFrame.origin.x, yOrigin, parentFrame.size.width, ToastHeight);
    ToastView *toast = [[ToastView alloc] initWithFrame:selfFrame];
    
    toast.backgroundColor = [UIColor blackColor];
    toast.alpha = 1.0f;
    toast.layer.cornerRadius = 1.0;
    toast.text = text;
    
    [parentView addSubview:toast];
    
    [UIView animateWithDuration:0.4 animations:^{
        toast.alpha = 0.8f;
        toast.textLabel.alpha = 1.0f;
    }completion:^(BOOL finished) {
        if(finished){
            
        }
    }];
    
    
    [toast performSelector:@selector(hideSelf) withObject:nil afterDelay:duration];
    
}

- (void)hideSelf
{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0.0;
        self.textLabel.alpha = 0.0;
    }completion:^(BOOL finished) {
        if(finished){
            [self removeFromSuperview];
        }
    }];
}

@end
