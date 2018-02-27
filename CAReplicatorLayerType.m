//
//  CAReplicatorLayerType.m
//  CALayerDemo
//
//  Created by pengpeng yan on 16/3/14.
//  Copyright © 2016年 peng yan. All rights reserved.
//

#import "CAReplicatorLayerType.h"
@interface CAReplicatorLayerType()
@property(nonatomic,weak)CAReplicatorLayer *replicatorLayer;
@property(nonatomic,weak)UIImageView *imageView;

@end

@implementation CAReplicatorLayerType

- (void)viewDidLoad{
    [super viewDidLoad];
    [self addReplicatorLayer];
    [self addbutton];
    
}

- (void)addbutton{
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(80 + 60 * i, self.view.frame.size.height - 40, 55, 40);
        button.backgroundColor = [UIColor grayColor];
        [button setTitle:[NSString stringWithFormat:@"动画%d",i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        [self.view addSubview:button];
    }
    
}

- (void)buttonAction:(UIButton *)btn{
    [_imageView.layer removeAllAnimations];
    [_replicatorLayer removeAllAnimations];
    [_replicatorLayer removeFromSuperlayer];
    [_imageView removeFromSuperview];
    [self addImageView];
    [self addReplicatorLayer];
    SEL method = NSSelectorFromString([NSString stringWithFormat:@"animation%ld",btn.tag]);
    [self performSelector:method withObject:self];
}

- (void)addReplicatorLayer{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = self.view.bounds;
    replicatorLayer.position = self.view.center;
    replicatorLayer.preservesDepth = YES;
    [replicatorLayer addSublayer:_imageView.layer];
    [self.view.layer addSublayer:replicatorLayer];
    _replicatorLayer = replicatorLayer;

}

- (void)addImageView{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView = imageView;
}


- (void)animation1{
    _imageView.frame = CGRectMake(10, 200, 100, 100);
    _imageView.image = [UIImage imageNamed:@"IMG_1080.jpg"];
    _replicatorLayer.instanceDelay = 1;
    _replicatorLayer.instanceCount = 3;
    _replicatorLayer.instanceTransform = CATransform3DMakeTranslation(120, 0, 0);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"instanceTransform"];
    animation.duration = 2;
    animation.repeatCount = MAXFLOAT;
    animation.autoreverses = YES;
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(100, 0, 0)];
    [_replicatorLayer addAnimation:animation forKey:nil];

}

- (void)animation2{
    _imageView.frame = CGRectMake(172, 200, 20, 20);
    _imageView.backgroundColor = [UIColor orangeColor];
    _imageView.layer.cornerRadius = 10;
    _imageView.layer.masksToBounds = YES;
     _imageView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    CGFloat count = 15.0;
    _replicatorLayer.instanceDelay = 1.0/count;
    _replicatorLayer.instanceCount = count;
    _replicatorLayer.instanceTransform = CATransform3DMakeRotation((2 * M_PI) / count, 0, 0, 1.0);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.fromValue = @(1);
    animation.toValue = @(0.01);
    [_imageView.layer addAnimation:animation forKey:nil];
    
}


- (void)animation3{
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.frame = CGRectMake(20, 650, 15, 15);
    _imageView.backgroundColor = [UIColor orangeColor];
    _imageView.layer.cornerRadius = 7.5;
    _imageView.layer.masksToBounds = YES;
    
    CGFloat count = 30.0;
    CGFloat duration = 3;
    _replicatorLayer.instanceDelay = duration / count;
    _replicatorLayer.instanceCount = count;
    _replicatorLayer.instanceAlphaOffset = 0.1;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 650)];
    [path addLineToPoint:CGPointMake(20, 100)];
    [path addCurveToPoint:CGPointMake(200, 400) controlPoint1:CGPointMake(200, 20) controlPoint2:CGPointMake(20, 400)];
    [path addLineToPoint:CGPointMake(355, 100)];
    [path addLineToPoint:CGPointMake(250, 400)];
    [path addLineToPoint:CGPointMake(400, 500)];
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = CGPathCreateCopyByTransformingPath(path.CGPath, NULL);
    keyFrameAnimation.duration = duration;
    keyFrameAnimation.repeatCount = 20;
    [_imageView.layer addAnimation:keyFrameAnimation forKey:nil];

    
}





@end
