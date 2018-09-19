//
//  Constant.m
//  SanjayMittalBhajan
//
//  Created by Punit on 31/07/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import "Constant.h"

@implementation Constant

+(void)executequery:(NSString *)strurl strpremeter:(id )parameter withblock:(void (^)(NSData *, NSError *))block{
    //SESSION CREATE
    NSURLSessionConfiguration *defaultconfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];//new session
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:defaultconfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];//queue is storing and retrieve data fifo
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strurl]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    
    [request setHTTPMethod:@"POST"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameter options:0 error:nil];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * response, NSError * error) {
        if (data!=nil) {
            NSLog(@"Response %@",data);
            block(data,error);
        }
        else{
            NSLog(@"error");
            block(nil,error);
        }
    }];
    
    
    [task resume];
}
@end
