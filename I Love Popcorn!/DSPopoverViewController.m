//
// DSPopoverViewController.m
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

#import "DSPopoverViewController.h"
#import "YIFYMovie.h"
#import "YIFYAPI.h"
#import "NSImage+roundedCorners.h"

@interface DSPopoverViewController ()

@end

@implementation DSPopoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        
        [self prepareForReuse];
    }
    return self;
}

- (void)awakeFromNib {
    [self prepareForReuse];
    [self.poster setImage:self.oldPoster];
}


- (void)prepareForReuse {
    self.moviePlot.stringValue = @"";
    self.movieTitle.stringValue = @"";
    self.movieYear.stringValue = @"";
    self.ratingInfoLabel.stringValue = @"";
    self.ratingLabel.stringValue = @"";
    self.genreLabel.stringValue = @"";
    self.seedsAndPeers.stringValue = @"";
    self.filesize.stringValue = @"";
    self.runtime.stringValue = @"";
    self.ratingIndicator.integerValue = 0;
    self.qualityImageView.image = nil;
    [self.progressIndicator startAnimation:nil];
}

- (void)setMovie:(YIFYMovie*)movie {
    [self prepareForReuse];
    [YIFYAPI getMovieDetailsWithID:movie.movieID completion:^(id object, NSError *error) {
        if (!error) {
            self.movieTitle.stringValue = [object objectForKey:@"MovieTitleClean"];
            self.ratingLabel.stringValue = [object objectForKey:@"MovieRating"];
            self.ratingIndicator.integerValue = [[object objectForKey:@"MovieRating"] integerValue];
            self.movieYear.stringValue = [object objectForKey:@"MovieYear"];
            self.moviePlot.stringValue = [object objectForKey:@"ShortDescription"];
            
            if ([object objectForKey:@"Genre2"] && [object objectForKey:@"Genre2"] != [NSNull null] && ![[object objectForKey:@"Genre2"] isEqualToString:@"<null>"]) {
                self.genreLabel.stringValue = [NSString stringWithFormat:@"%@, %@", [object objectForKey:@"Genre1"], [object objectForKey:@"Genre2"]];
            }
            else self.genreLabel.stringValue = [object objectForKey:@"Genre1"];
            
            self.ratingInfoLabel.stringValue = [object objectForKey:@"AgeRating"];
            
            [self performSelectorInBackground:@selector(setMoviePosterWithUrl:) withObject:[object objectForKey:@"LargeCover"]];
            
            [self.qualityImageView setImage:[NSImage imageNamed:[object objectForKey:@"Quality"]]];
            
            self.seedsAndPeers.stringValue = [NSString stringWithFormat:@"%@/%@", [object objectForKey:@"TorrentSeeds"], [object objectForKey:@"TorrentPeers"]];
            
            self.filesize.stringValue = [object objectForKey:@"Size"];
            NSInteger runtime = [[object objectForKey:@"MovieRuntime"] integerValue];
            NSInteger hours = runtime/60;
            NSInteger minutes = runtime%60;
            NSString *runtimeString = hours?[NSString stringWithFormat:@"%ldh %ldm", hours,minutes]:[object objectForKey:@"MovieRuntime"];
            self.runtime.stringValue = runtimeString;
            
            self.imdbUrlString = [object objectForKey:@"ImdbLink"];
            self.downloadUrlString = [object objectForKey:@"TorrentMagnetUrl"];
            self.trailerUrlString = [object objectForKey:@"YoutubeTrailerUrl"];
            
        }
    }];
}

- (IBAction)downloadMovie:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:self.downloadUrlString]];
}

- (IBAction)showImdb:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:self.imdbUrlString]];
}

- (IBAction)playTrailer:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:self.trailerUrlString]];
}

- (void)setMoviePosterWithUrl:(NSString*)url {
    NSURL *imageURL = [NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    if (imageData != nil) {
        [self.poster setImage:[[[NSImage alloc] initWithData:imageData] imageWithRoundedCornersRadius:10]];
        [self.progressIndicator stopAnimation:nil];
    }
}


@end
