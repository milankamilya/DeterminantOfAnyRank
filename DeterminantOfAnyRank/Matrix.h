//
//  Matrix.h
//  DeterminantOfAnyRank
//
//  Created by Sandip Saha on 30/07/13.
//  Copyright (c) 2013 Sandip Saha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Matrix : NSObject
{
    double *matrix;
    int rank;
}

- (void) setMatrix:(double*)inputMatrix;

- (double*) matrix;

- (void) setRank:(int)inputRank;

- (int) rank;

- (double) determinantExecutor;


- (double) determinantOfRankAny:(double*)arrayTaken
                     rowAbandon:(int) rowAbandon
                     colAbandon:(int) colAbandon
                      rankTaken:(int) rankTaken;

- (double) determinantOfRankThree:(double*) array;

- (double*) matrixMinimizer:(double*)arrayTaken
                 rowAbandon:(int) rowAbandon
                 colAbandon:(int) colAbandon
                  rankTaken:(int) rankTaken;
@end
