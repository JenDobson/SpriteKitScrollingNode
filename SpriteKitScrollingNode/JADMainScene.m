//
//  JADMainScene.m
//  SpriteKitScrollingNode
//
//  Created by Jennifer Dobson on 7/25/14.
//  Copyright (c) 2014 Jennifer Dobson. All rights reserved.
//

#import "JADMainScene.h"
#import "JADSKScrollingNode.h"


@interface JADMainScene()

@property (nonatomic, strong) JADSKScrollingNode* scrollingNode;

@end

@implementation JADMainScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        _scrollingNode = [JADSKScrollingNode node];
        _scrollingNode.position = CGPointMake(0, 0);
        _scrollingNode.yMargin = 50;
        
        [self addChild:_scrollingNode];
        
        SKLabelNode *topLabelNode = [[SKLabelNode alloc] init];
        topLabelNode.text = @"Top";
        topLabelNode.position = CGPointMake(50, 2000-50);
        
        SKLabelNode *bottomLabelNode = [[SKLabelNode alloc] init];
        bottomLabelNode.text = @"Bottom";
        bottomLabelNode.position = CGPointMake(50, 50);
        
        SKSpriteNode *node1 = [[SKSpriteNode alloc] initWithColor:[UIColor redColor] size:CGSizeMake(100, 100)];
        SKSpriteNode *node2 = [node1 copy];
        SKSpriteNode *node3 = [node1 copy];
        
        
        node1.position = CGPointMake(100, 500);
        node2.position = CGPointMake(100, 1000);
        node3.position = CGPointMake(100, 1500);
        
        [_scrollingNode addChild:topLabelNode];
        [_scrollingNode addChild:bottomLabelNode];
        [_scrollingNode addChild:node1];
        [_scrollingNode addChild:node2];
        [_scrollingNode addChild:node3];
        
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
    if ([touchedNode isKindOfClass:[SKSpriteNode class]]) {
        SKAction *blueAction = [SKAction colorizeWithColor:[UIColor blueColor] colorBlendFactor:1 duration:.5];
        SKAction *redAction = [SKAction colorizeWithColor:[UIColor redColor] colorBlendFactor:1 duration:.5];
        [touchedNode runAction:[SKAction sequence:@[blueAction,redAction]]];
    }
}
@end
