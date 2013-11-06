//
//  main.m
//  DeterminantOfAnyRank
//
//  Created by Sandip Saha on 30/07/13.
//  Copyright (c) 2013 Sandip Saha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Matrix.h"
#define RANK 7

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSDate *startTime = [NSDate date];
        // initializing matrix
        // If any change in matrix , you should update RANK macro also
        double array[RANK*RANK]={02,05,11,01,06,02,05,
                                 07,9,03,02,12,9,8,
                                 01,00,01,03,13,07,03,
                                 02,02,05,07,06,06,02,
                                 9,01,07,02,00,04,06,
                                 03,05,00,01,8,00,9,
                                 04,13,02,05,07,06,03};
        
               
        // Display original matrix
        printf("Original matrix ...\n");
        for(int i=0;i<RANK;i++)
        {
            for(int j=0;j<RANK;j++)
            {
                printf("%2.0lf ",array[i*RANK+j]);
            }
            printf("\n");
        }
               
        
        Matrix *matrix = [[Matrix alloc] init];
        
        [matrix setMatrix:array];
        [matrix setRank:RANK];
        
        printf("\nDeterminant of the above matrix :: %12.0lf\n",[matrix determinantExecutor]);
        
        NSDate *endTime = [NSDate date];
        
        double secondsBetween = [endTime timeIntervalSinceDate:startTime];
        
        printf("Time taken :: %lf",secondsBetween);

        
    }
    return 0;
}


