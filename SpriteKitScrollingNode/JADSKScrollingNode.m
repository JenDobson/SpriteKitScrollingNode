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
@property (nonatomic) CGFloat yOffset;

@end


static const CGFloat kScrollDuration = .3;

@implementation JADSKScrollingNode

/*
-(void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    
    self.maskNode.position = [self maskPositionForNodePosition:position];
}

-(CGPoint)maskPositionForNodePosition:(CGPoint)position
{
    CGPoint oldMaskPosition = self.maskNode.position;
    return CGPointMake( oldMaskPosition.x,-self.position.y+self.parent.frame.size.height/2);
}
 */

-(id)initWithSize:(CGSize)size
{
    self = [super init];
    
    if (self)
    {
        _size = size;
        _yOffset = [self calculateAccumulatedFrame].origin.y;
       
    }
    return self;
    
}

-(void)addChild:(SKNode *)node
{
    [super addChild:node];
    _yOffset = [self calculateAccumulatedFrame].origin.y;
}


-(CGFloat) minYPosition
{
    //CGFloat minPosition =(self.scene.frame.size.height - [self calculateAccumulatedFrame].size.height - self.yMargin);
    //CGFloat minPosition =(self.size.height - [self calculateAccumulatedFrame].size.height);
    CGSize parentSize = self.parent.frame.size;
    
  
    CGFloat minPosition =(parentSize.height - [self calculateAccumulatedFrame].size.height - _yOffset);
    
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
        _gestureRecognizer.delegate = self;
        [view addGestureRecognizer:self.gestureRecognizer];
        
      
        
        /*
        self.maskNode = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:(CGSize){self.parent.frame.size.width,self.parent.frame.size.height}];
        
        self.maskNode.position = CGPointMake(self.parent.frame.size.width/2,self.parent.frame.size.height/2);
         */
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
        
        CGPoint newPos = CGPointMake(pos.x, pos.y - p.y);
        newPos = [self constrainStencilNodesContainerPosition:newPos];
        
        SKAction *moveTo = [SKAction moveTo:newPos duration:kScrollDuration];
        //SKAction *moveMask = [SKAction moveTo:[self maskPositionForNodePosition:newPos] duration:kScrollDuration];
        [moveTo setTimingMode:SKActionTimingEaseOut];
        //[moveMask setTimingMode:SKActionTimingEaseOut];
        [self runAction:moveTo];
        //[self.maskNode runAction:moveMask];
        
    }
    
}



-(void)panForTranslation:(CGPoint)translation
{
    self.position = CGPointMake(self.position.x, self.position.y+translation.y);
}

- (CGPoint)constrainStencilNodesContainerPosition:(CGPoint)position {
    
    CGPoint retval = position;
    
    retval.x = self.position.x;
    
    retval.y = MAX(retval.y, self.minYPosition);
    retval.y = MIN(retval.y, self.maxYPosition);
    
    
    return retval;
}


CGPoint mult(const CGPoint v, const CGFloat s) {
	return CGPointMake(v.x*s, v.y*s);
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    SKNode* grandParent = self.parent.parent;
    
    if (!grandParent) {
        grandParent = self.parent;
    }
    CGPoint touchLocation = [touch locationInNode:grandParent];
    NSLog(@"parent:%@",grandParent);
    NSLog(@"%f,%f",touchLocation.x,touchLocation.y);
    
    if (!CGRectContainsPoint(self.parent.frame,touchLocation)){
        return NO;
    }
    
    return YES;
}

@end
