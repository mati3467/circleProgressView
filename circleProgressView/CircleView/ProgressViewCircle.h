//
//  ProgressViewCircle.h
//  circleProgressView
//
//  Created by Mati Ur Rab on 12/23/14.
//

#import <UIKit/UIKit.h>
@interface ProgressViewCircle : UIView

@property (nonatomic,retain) UIColor *progressColor;

-(void)setprogress:(float)theprogress;
- (id)initWithFrame:(CGRect)frame andRadius:(float) radiusCircle andStrokeColor:(UIColor*) color;

@end
