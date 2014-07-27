//
//  JADSKScrollingNode.m
//  FirstLetters
//
//  Created by Jennifer Dobson on 7/25/14.
//  Copyright (c) 2014 Jennifer Dobson. All rights reserved.
//

#import "JADSKScrollingNode.h"


@interface JADSKScrollingNode()

@property (nonatomic) CGFloat minYPosition;
@property (nonatomic) CGFloat maxYPosition;
@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;

@end


static const CGFloat kScrollDuration = .3;

@implementation JADSKScrollingNode

-(id)init
{
    self = [super init];
    
    if (self)
    {
        _yMargin = 0;
    }
    return self;
    
}


-(CGFloat) minYPosition
{
    CGFloat minPosition =(self.scene.frame.size.height - [self calculateAccumulatedFrame].size.height - self.yMargin);
    
    return minPosition;
}

-(CGFloat) maxYPosition
{
    return 0;
}

-(void)scrollToBottom
{
    self.position = CGPointMake(0, self.maxYPosition);
    
}

-(void)scrollToTop
{
    self.position = CGPointMake(0, self.minYPosition);
    
}

-(void)enableScrollingOnView:(UIView*)view
{
    if (!_gestureRecognizer) {
        _gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
        [view addGestureRecognizer:self.gestureRecognizer];
    }
}

-(void)disableScrollingOnView:(UIView*)view
{
    if (_gestureRecognizer) {
        [view removeGestureRecognizer:_gestureRecognizer];
        _gestureRecognizer = nil;
    }
}

-(void)handlePanFrom:(UIPanGestureRecognizer*)recognizer
{
    
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:recognizer.view];
        CGPoint pos = self.position;
        CGPoint p = mult(velocity, kScrollDuration);
        
        CGPoint newPos = CGPointMake(pos.x + p.x, pos.y - p.y);
        newPos = [self constrainStencilNodesContainerPosition:newPos];
        
        SKAction *moveTo = [SKAction moveTo:newPos duration:kScrollDuration];
        [moveTo setTimingMode:SKActionTimingEaseOut];
        [self runAction:moveTo];
    }
}



-(void)panForTranslation:(CGPoint)translation
{
    self.position = CGPointMake(0, self.position.y+translation.y);
}

- (CGPoint)constrainStencilNodesContainerPosition:(CGPoint)position {
    
    CGPoint retval = position;
    
    retval.x = 0;
    
    retval.y = MAX(retval.y, self.minYPosition);
    retval.y = MIN(retval.y, self.maxYPosition);
    
    
    return retval;
}


CGPoint mult(const CGPoint v, const CGFloat s) {
	return CGPointMake(v.x*s, v.y*s);
}


@end
