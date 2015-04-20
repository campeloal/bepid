//
//  PhysicsCategories.h
//  Space Escape
//
//  Created by Alex De Souza Campelo Lima on 10/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#ifndef Space_Escape_PhysicsCategories_h
#define Space_Escape_PhysicsCategories_h

typedef NS_ENUM(NSUInteger, CollyderType){
    CollyderTypePlayer = 1 << 0,
    CollyderTypeEnemy = 1 << 1,
    CollyderTypeBulletPlayer = 1 << 2,
    CollyderTypeBulletEnemy = 1 << 3
};

#endif
