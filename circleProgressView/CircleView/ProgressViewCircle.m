//
//  ProgressViewCircle.m
//  circleProgressView
//
//  Created by Mati Ur Rab on 12/23/14.
//

#import "ProgressViewCircle.h"

@interface ProgressViewCircle (){
    float _progress;
    CGFloat startAngle;
    CGFloat endAngle;
    CGFloat radius;
    BOOL drawOuterCircle;
}
@end

@implementation ProgressViewCircle

- (id)initWithFrame:(CGRect)frame andRadius:(float) radiusCircle andStrokeColor:(UIColor*) color
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        startAngle = M_PI * 1.5;
        endAngle = startAngle + (M_PI * 2);
        radius = radiusCircle;
        _progressColor = color;
    }
    return self;
}

-(void)setprogress:(float)theProgress {
    _progress = theProgress;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:radius
                      startAngle:startAngle
                        endAngle:(endAngle - startAngle) * (_progress / 100.0) + startAngle
                       clockwise:YES];
    
    bezierPath.lineWidth = radius*2;
    if ([self.progressColor isKindOfClass:[UIColor class]]) {
        [self.progressColor setStroke];
    }
    
    [bezierPath stroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    
    CGContextSetStrokeColorWithColor(context, self.progressColor.CGColor);
    CGRect rectangle = CGRectMake(rect.size.width/2-((radius*2)+2),rect.size.height/2-((radius*2)+2),((radius*2)+2)*2,((radius*2)+2)*2);
    CGContextAddEllipseInRect(context, rectangle);
    CGContextStrokePath(context);
//    CGContextRelease(context);
    
}
@end
