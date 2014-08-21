//
//  JADPartScrollingScene.m
//  SpriteKitScrollingNode
//
//  Created by Jennifer Dobson on 8/16/14.
//  Copyright (c) 2014 Jennifer Dobson. All rights reserved.
//

#import "JADPartScrollingScene.h"
#import "JADSKScrollingNode.h"
#import "JADViewController.h"

@interface JADPartScrollingScene()

@property (nonatomic, strong) JADSKScrollingNode* scrollingNode;

@end


static const CGFloat kScrollingNodeXPosition = 300;
static const CGFloat kScrollingNodeYPosition = 300;
static const CGFloat kScrollingNodeWidth = 300;
static const CGFloat kScrollingNodeHeight = 300;



@implementation JADPartScrollingScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        
        SKSpriteNode *rectNode = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size:(CGSize){kScrollingNodeWidth,kScrollingNodeHeight}];
        rectNode.position = (CGPoint){kScrollingNodeXPosition,kScrollingNodeYPosition};
        
        SKSpriteNode *maskNode = [rectNode copy];
        
        SKCropNode* cropNode = [SKCropNode node];
        cropNode.maskNode = maskNode;
        [cropNode addChild:rectNode];
        
        _scrollingNode = [[JADSKScrollingNode alloc] initWithSize:(CGSize){kScrollingNodeWidth,kScrollingNodeHeight}];
        _scrollingNode.position = CGPointMake(kScrollingNodeXPosition, kScrollingNodeYPosition);
        
        [rectNode addChild:_scrollingNode];
        [self addChild:cropNode];
        
        SKLabelNode *topLabelNode = [[SKLabelNode alloc] init];
        topLabelNode.text = @"Top";
        topLabelNode.position = CGPointMake(0, 500-50);
        
        SKLabelNode *bottomLabelNode = [[SKLabelNode alloc] init];
        bottomLabelNode.text = @"Bottom";
        bottomLabelNode.position = CGPointMake(0, 50);
        
        SKSpriteNode *node1 = [[SKSpriteNode alloc] initWithColor:[UIColor redColor] size:CGSizeMake(100, 100)];
        SKSpriteNode *node2 = [node1 copy];
        SKSpriteNode *node3 = [node1 copy];
        
        
        node1.position = CGPointMake(0, 150);
        node2.position = CGPointMake(0, 260);
        node3.position = CGPointMake(0, 370);
        
        [_scrollingNode addChild:topLabelNode];
        [_scrollingNode addChild:bottomLabelNode];
        [_scrollingNode addChild:node1];
        [_scrollingNode addChild:node2];
        [_scrollingNode addChild:node3];
        
        
        SKLabelNode* otherSceneNode = [SKLabelNode node];
        otherSceneNode.text = @"Switch To Full Scrolling Scene";
        otherSceneNode.name = @"OtherSceneNode";
        otherSceneNode.position = (CGPoint){800,100};
        [self addChild:otherSceneNode];
    }
    return self;
}


-(void)didMoveToView:(SKView *)view
{
    
    [_scrollingNode enableScrollingOnView:view];
    [_scrollingNode scrollToTop];
    
}

-(void)willMoveFromView:(SKView *)view
{
    [_scrollingNode disableScrollingOnView:view];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touchedNode = [self nodeAtPoint:location];
    NSString* nodeName = touchedNode.name;
    /*
    if ([touchedNode isKindOfClass:[SKSpriteNode class]]) {
        SKAction *blueAction = [SKAction colorizeWithColor:[UIColor blueColor] colorBlendFactor:1 duration:.5];
        SKAction *redAction = [SKAction colorizeWithColor:[UIColor redColor] colorBlendFactor:1 duration:.5];
        [touchedNode runAction:[SKAction sequence:@[blueAction,redAction]]];
    }
    else if ([nodeName isEqualToString:@"OtherSceneNode"])
        [self.viewController presentFullScrollingScene];
    */
    if ([nodeName isEqualToString:@"OtherSceneNode"])
        [self.viewController presentFullScrollingScene];
    

}

@end
