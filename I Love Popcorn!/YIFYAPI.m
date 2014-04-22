//
// YIFYAPI.m
//
// Copyright (c) 2014 Donovan Söderlund ( http://donovan.se )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "YIFYAPI.h"
#import "AFNetworking.h"
#import "YIFYMovie.h"

@implementation YIFYAPI

+ (void)getMovieListWithNumberOfResults:(NSInteger)limit set:(NSInteger)set quality:(NSString *)quality rating:(NSString *)rating keywords:(NSString *)keywords genre:(NSString *)genre sort:(NSString *)sort completion:(YIFYRequestCompletionBlock)completion {
    
    NSDictionary *parameters = @{@"limit":[NSNumber numberWithInteger:limit], @"set":[NSNumber numberWithInteger:set], @"quality":quality, @"rating":rating, @"keywords":keywords, @"genre":genre, @"sort":sort};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://yts.re/api/list.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion([YIFYMovie movieListFromDictionary:responseObject], nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completion(nil, error);
    }];
}

+ (void)getMovieDetailsWithID:(NSString *)ID completion:(YIFYRequestCompletionBlock)completion {
    
    NSDictionary *parameters = @{@"id":ID};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://yts.re/api/movie.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completion(nil, error);
    }];
}



@end
