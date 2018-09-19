//
//  Constant.h
//  SanjayMittalBhajan
//
//  Created by Punit on 31/07/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constant : NSObject
+(void)executequery:(NSString *)strurl strpremeter:(NSString*)premeter withblock:(void(^)(NSData *,NSError*))block;
//globally it can be accessed & execute query is argument name and type object name

@end
