TappyPlane
===========

Flappy Bird Clone using resources from [Kenney](http://opengameart.org/content/tappy-plane)

Added bodyWithEdgeChainFromPath by using [SKPhysicsBody Path Generator](http://dazchong.com/spritekit/)

I don't like the Flappy Bird control style (constant tap to fly). I prefer Jetpack Joyride style (tap to go up, release to drop). I've implemented both styles in this game. Currently it is a compiler flag. Once I feel the game is closer to done I might make it a user preference. To change it, go into the Build Settings and Search/Find Preprocessor Macros. There you will find a macro titled FLAP. Set FLAP=1 for Flappy Bird controls. Set FLAP=0 for Jetpack Joyride controls.

I finally tested this on a iPhone 6 - my assets aren't large enough - errgh.