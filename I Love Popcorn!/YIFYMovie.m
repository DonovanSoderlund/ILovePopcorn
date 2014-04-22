//
// YIFYMovie.m
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

#import "YIFYMovie.h"

@interface YIFYMovie ()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation YIFYMovie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    self.dictionary = dictionary;
    self.shouldAnimate = YES;
    return self;
}

+ (NSArray*)movieListFromDictionary:(NSDictionary *)dictionary {
    NSMutableArray *movieList = [[NSMutableArray alloc] init];
    if ([dictionary objectForKey:@"MovieList"]) {
        for (NSDictionary *currentMovieDictionary in [dictionary objectForKey:@"MovieList"]) {
            [movieList addObject:[[YIFYMovie alloc] initWithDictionary:currentMovieDictionary]];
        }
    }
    return movieList;
}

- (NSString*)movieTitle {
    return [self.dictionary objectForKey:@"MovieTitleClean"];
}

- (NSString*)movieID {
    return [self.dictionary objectForKey:@"MovieID"];
}

- (NSString*)movieCoverUrlString {
    return [self.dictionary objectForKey:@"CoverImage"];
}

- (NSInteger)movieRating {
    NSString *rating = [self.dictionary objectForKey:@"MovieRating"];
    return rating.integerValue;
}

- (id)objectForKey:(id)key {
    return [self.dictionary objectForKey:key];
}

@end
