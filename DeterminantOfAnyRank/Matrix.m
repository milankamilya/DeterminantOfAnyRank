//
//  Matrix.m
//  DeterminantOfAnyRank
//
//  Created by Sandip Saha on 30/07/13.
//  Copyright (c) 2013 Sandip Saha. All rights reserved.
//

#import "Matrix.h"

@implementation Matrix


/************** setter and getter methods for instance data member ****************/

- (void) setMatrix:(double*)inputMatrix
{
    matrix = inputMatrix ;
}

- (double*) matrix
{
    return matrix;
}

- (void) setRank:(int)inputRank
{
    rank = inputRank;
}

- (int) rank
{
    return rank ;
}

/*************** End of setter and getter methods for instance data member *********/

/*************** Definition of instance methods ************************************/




/* Task of determinantExecutor ::
 
     Task 1. check rank == 2 ,
             1.1. If yes ,calculated determinant in a simple way
 
     Task 2. check rank == 3
             2.1. If yes , call determinantOfRankThree: method
 
     Task 3. For other rank do the followings ::
             3.1. call each number's co-factor. ( for only the top row of the matrix )
             3.2. multiple each number with it's co-factor and give appropriate sign
             3.3. add them 
 
     Task 4. return determinant
 
 */
- (double) determinantExecutor
{
    
    double determinant = 0.0;
    
    // Task 1. check rank == 2 ,
    //         1.1. If yes , calculated determinant in a simple way

    if (rank == 2) {
        
        determinant = matrix[0]*matrix[3]-matrix[1]*matrix[2];
        return (determinant);
        
    } else if (rank == 3) {
        
        // Task 2. check rank == 3
        //         2.1. If yes , call determinantOfRankThree: method
        
        [self determinantOfRankThree:matrix];
        
    } else {
        
        // Task 3. For other rank do the followings ::
        
        
        
        double value = 0.0;
        for(int i=0; i < rank ;i++){
            
            //         3.1. call each number's co-factor. ( for only the top row of the matrix )
            value = [self determinantOfRankAny:matrix
                                    rowAbandon:0
                                    colAbandon:i
                                     rankTaken:rank-1] ;
            
            //         3.2. multiple each number with it's co-factor and give appropriate sign
            value = value * pow(-1,i) * matrix[i] ;
            
            //         3.3. add them 
            determinant = determinant + value;
            
            /*
             printf(" value of a[%d][] rank = %d is %6.0lf  sign = %1.0lf\n",i,rank,value,pow(-1, rank - i));
             */
        }
    }

    // Task 4. return determinant
    return determinant;
    
}




/* Task of determinantOfRankAny ::
 

 Task 1. check rank == 3
         1.1. If yes , call matrixMinimizer: method to minimize the matrix 
         1.2. call determinantOfRankThree: method with minimized matrix
 
 Task 2. For other rank do the followings ::
         2.1. call matrixMinimizer: method to minimize the matrix 
         2.2. call each number's co-factor. ( for only the top row of the matrix )
         2.3. multiple each number with it's co-factor and give appropriate sign
         2.4. add them
 
 Task 3. return determinant
 
 */
- (double) determinantOfRankAny:(double*)arrayTaken
                     rowAbandon:(int) rowAbandon
                     colAbandon:(int) colAbandon
                      rankTaken:(int) rankTaken
{
    double determinant = 0.0;
    
    
    if (rankTaken == 3) {
        
        // Task 1. check rank == 3

        //         1.1. If yes , call matrixMinimizer: method to minimize the matrix
        double *array = [self matrixMinimizer:arrayTaken
                                   rowAbandon:rowAbandon
                                   colAbandon:colAbandon
                                    rankTaken:rankTaken];
        
        //         1.2. call determinantOfRankThree: method with minimized matrix
        determinant = [self determinantOfRankThree:array ];
        /*return [self determinantOfRankThreeFromRankAnyMethod:arrayTaken
                                                  rowAbandon:rowAbandon
                                                  colAbandon:colAbandon
                                                   rankTaken:rankTaken];
         */
        
    } else {
        
        // Task 2. For other rank do the followings ::

        //         2.1. call matrixMinimizer: method to minimize the matrix
        double *array = [self matrixMinimizer:arrayTaken
                                   rowAbandon:rowAbandon
                                   colAbandon:colAbandon
                                    rankTaken:rankTaken];
        /*
        //#  create new 2d matrix
        for(int i=0,k=0;i<rankTaken;i++,k++)
        {
            if(i == rowAbandon){
                k++;
            }
            for(int j=0,l=0;j<rankTaken;j++,l++)
            {
                if(j == colAbandon){
                    l++;
                }
                
                array[i*rankTaken+j] = arrayTaken[k*(rankTaken+1)+l];
                printf("%2.0lf ",array[i*rankTaken+j]);
            }
            printf("\n");
        }*/
        
        double value = 0.0;
        //#  evaluate value
        for(int i=0; i < rankTaken;i++)
        {
            //         2.2. call each number's co-factor. ( for only the top row of the matrix )
             value = [self determinantOfRankAny:array
                                     rowAbandon:0
                                     colAbandon:i
                                      rankTaken:rankTaken-1] ;
            
            //         2.3. multiple each number with it's co-factor and give appropriate sign
            value = value * pow(-1,i) * array[i] ;
            
            //         2.4. add them
            determinant = determinant + value;
            
            /*
             printf(" value of a[%d][] rank = %d is %6.0lf  sign = %1.0lf\n",i,rankTaken,value,pow(-1, rankTaken - i));
             */
        }
    }
    
    // Task 3. return determinant
    return determinant;
}




/* Task of determinantOfRankThree ::
 
      Task 1. calculate determinant manually from the matrix 3*3
 
      Task 2. return determinant
 
 */
- (double) determinantOfRankThree:(double*) array
{
    // Task 1. calculate determinant manually from the matrix 3*3
    double determinant=array[0]*array[4]*array[8]+array[1]*array[5]*array[6]+array[2]*array[3]*array[7];
    determinant = determinant - array[2]*array[4]*array[6] - array[0]*array[5]*array[7] - array[1]*array[3]*array[8];
    
    //  Task 2. return determinant
    return determinant;
}




/* Task of matrixMinimizer ::
 
        Task 1. allocate space for the minimized matrix
 
        Task 2. build the new matrix by skipping the rowAbandon and colAbandon
 
        Task 3. return pointer to minimized matrix
 
 */
- (double*) matrixMinimizer:(double*)matrixTaken
                 rowAbandon:(int) rowAbandon
                 colAbandon:(int) colAbandon
                  rankTaken:(int) rankTaken
{
    // Task 1. allocate space for the minimized matrix
    double *minimizedMatrix = (double*)calloc(rankTaken*rankTaken, sizeof(double));
    
    // Task 2. build the new matrix by skipping the rowAbandon and colAbandon
    for(int i=0,k=0;i<rankTaken;i++,k++)
    {
        // skip the row 
        if(i == rowAbandon){
            k++;
        }
        for(int j=0,l=0;j<rankTaken;j++,l++)
        {
            // skip the column
            if(j == colAbandon){
                l++;
            }
            minimizedMatrix[i*rankTaken+j] = matrixTaken[k*(rankTaken+1)+l];
        }
    }
    
    // Task 3. return pointer to minimized matrix
    return minimizedMatrix;
}

/*************** End of Definition of instance methods ************************************/


@end
