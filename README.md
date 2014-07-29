SpriteKitScrollingNode
======================

Example app that demonstrates subclassing SKNode to make a scrolling node on an SKScene.

This app launches a game in landscape mode.  The view is instaniated programmatically, so there are no nib files or storyboards.

To use the JADSKScrollingNode on your own scene, call JADSKScrollingNode's `enableScrollingOnView:` method in the implementation of your scene's `didMoveToView` method and call the `disableScrollingOnView` method on your implementation of the scene's `willMoveFromView` method.  JADSKScrollingNode's `enableScrollingOnView` and `disableScrollingOnView` adds and removes the `UIPanGestureRecognizer` from the `SKView` that contains the scene.