//
//  JADViewController.m
//  SpriteKitScrollingNode
//
//  Created by Jennifer Dobson on 7/25/14.
//  Copyright (c) 2014 Jennifer Dobson. All rights reserved.
//

#import "JADViewController.h"
#import "JADMainScene.h"

#import <SpriteKit/SpriteKit.h>

@interface JADViewController()

@property (nonatomic, strong) SKScene* mainScene;

@end


@implementation JADViewController


-(void)loadView
{
    CGRect viewFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    SKView* view = [[SKView alloc] initWithFrame:viewFrame];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SKView* skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    CGSize contentSize = CGSizeMake(skView.bounds.size.width,skView.bounds.size.height);
    
    _mainScene = [JADMainScene sceneWithSize:contentSize];
    _mainScene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:_mainScene];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotate
{
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskLandscape;
    }
}


@end
