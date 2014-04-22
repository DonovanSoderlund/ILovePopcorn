//
// DSMovieCollectionViewItem.m
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

#import "DSMovieCollectionViewItem.h"

@interface DSMovieCollectionViewItem ()

@end

@implementation DSMovieCollectionViewItem



- (id)copyWithZone:(NSZone *)zone {
    return [[DSMovieCollectionViewItem alloc] initWithNibName:@"DSMovieCollectionViewItem" bundle:nil];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    YIFYMovie *currentMovie = representedObject;
    
    self.movie = currentMovie;
    
}

- (void)awakeFromNib {    
    if (self.movie) {
        self.posterView.movie = self.movie;
        self.posterView.delegate = self;
        [self setMovieTitle:self.movie.movieTitle];
        [self.posterView performSelectorInBackground:@selector(setPosterUrlString:) withObject:self.movie.movieCoverUrlString];
    }
}

- (void)setMovieTitle:(NSString *)movieTitle {
    self.movieTitleLabel.stringValue = movieTitle;
    self.movieTitleShadow.stringValue = movieTitle;
}

- (void)posterViewDidFinishLoadingPoster:(DSPosterView *)posterView {
    [self.shadowView setHidden:NO];
    [self.progressIndicator stopAnimation:nil];
}

- (void)makePosterNormal {
    [self.shadowView setFrame:NSRectFromCGRect(CGRectMake(12, 27, 128, 172))];
    [self.posterView setFrame:NSRectFromCGRect(CGRectMake(24, 42, 102, 145))];
}

- (void)highlightPoster {
    [self.shadowView setFrame:NSRectFromCGRect(CGRectMake(11, 26, 130, 174))];
    [self.posterView setFrame:NSRectFromCGRect(CGRectMake(22, 40, 106, 149))];
}

- (void)mouseEnteredPoster:(DSPosterView *)posterView {
    if (!self.posterView.popover.isShown) [self highlightPoster];
}

- (void)mouseExitedPoster:(DSPosterView *)posterView {
    [self makePosterNormal];
}

- (void)mouseDownOnPoster:(DSPosterView *)posterView {
    [self makePosterNormal];
}

@end
