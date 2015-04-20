//
//  CarsCollectionViewController.h
//  semiNovos
//
//  Created by Alex De Souza Campelo Lima on 10/7/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarsCollectionViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property UICollectionView *collectionView;
@property NSMutableArray *carPhotos;

-(void) addCarPhoto: (UIImage *) carPhoto;

@end
