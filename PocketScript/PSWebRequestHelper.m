//
//  PSWebRequestHelper.m
//  PocketScript
//
//  Created by Andrew Brandt on 10/24/14.
//  Copyright (c) 2014 Andrew Brandt. All rights reserved.
//

#import "PSWebRequestHelper.h"
#import "RxOrder.h"

@implementation PSWebRequestHelper

static PSWebRequestHelper *singleton;
static NSString* const URL = @"";

- (void)postNewRxOrder: (RxOrder *)order {
    NSURL *url = [NSURL URLWithString:URL];
    NSData *payload;
    //needs to build payload from order object
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [request setHTTPMethod:@"POST"];
    //needs content-type
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *dataTask = [urlSession uploadTaskWithRequest:request fromData:payload completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        
        if (responseStatusCode == 200 && data) {
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                //update UI
            });
        }
        
    }];
    [dataTask resume];
}

#pragma mark - TODO provide correct dispatch method for singleton initialization

+ (PSWebRequestHelper *)sharedInstance {
    if (!singleton) {
        singleton = [PSWebRequestHelper new];
    }
    return singleton;
}

@end
