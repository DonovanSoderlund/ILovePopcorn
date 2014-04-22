//
// DSMainViewController.m
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

#import "DSMainViewController.h"
#import "DSMovieCollectionViewItem.h"
#import "YIFYAPI.h"

@interface DSMainViewController ()

@end

@implementation DSMainViewController

- (id)init {
    self = [super init];
    
    self.movieList = [[NSMutableArray alloc] init];
    
    return self;
}

- (void)awakeFromNib {
    [self.collectionView setBackgroundColors:[NSArray arrayWithObject:[NSColor colorWithPatternImage:[NSImage imageNamed:@"debut_dark"]]]]; // old tweed
    
    self.collectionView.content = self.movieList;
    self.collectionView.itemPrototype = [[DSMovieCollectionViewItem alloc] initWithNibName:@"DSMovieCollectionViewItem" bundle:nil];
    
    // Load defaults
    [self.toolbar.genrePopup selectItemAtIndex:[[NSUserDefaults standardUserDefaults] integerForKey:@"GenrePopupDefault"]];
    [self.toolbar.qualityPopup selectItemAtIndex:[[NSUserDefaults standardUserDefaults] integerForKey:@"QualityPopupDefault"]];
    [self.toolbar.sortPopup selectItemAtIndex:[[NSUserDefaults standardUserDefaults] integerForKey:@"SortPopupDefault"]];
    [self.toolbar.ratingSlider setIntegerValue:[[NSUserDefaults standardUserDefaults] integerForKey:@"RatingSliderDefault"]];
    [self.toolbar updateRatingSlider];
    
    [self searchForMovies];
}

- (void)searchFieldDidChange:(NSSearchField *)searchField {
    [self searchForMovies];
}

- (void)genrePopupButtonDidChange:(NSPopUpButton *)genrePopupButton {
    [[NSUserDefaults standardUserDefaults] setInteger:genrePopupButton.indexOfSelectedItem
                                               forKey:@"GenrePopupDefault"];
    [self searchForMovies];
}

- (void)qualityPopupButtonDidChange:(NSPopUpButton *)qualityPopupButton {
    [self searchForMovies];
    [[NSUserDefaults standardUserDefaults] setInteger:qualityPopupButton.indexOfSelectedItem
                                               forKey:@"QualityPopupDefault"];
}

- (void)sortingPopupButtonDidChange:(NSPopUpButton *)sortingPopupButton {
    [self searchForMovies];
    [[NSUserDefaults standardUserDefaults] setInteger:sortingPopupButton.indexOfSelectedItem
                                               forKey:@"SortPopupDefault"];
}

- (void)ratingSliderDidChange:(NSSlider *)ratingSlider {
    [self searchForMovies];
    [[NSUserDefaults standardUserDefaults] setInteger:ratingSlider.integerValue
                                               forKey:@"RatingSliderDefault"];
}

- (void)searchForMovies {
    [self.toolbar startProgressIndicator];
    [YIFYAPI getMovieListWithNumberOfResults:50 set:1 quality:self.toolbar.qualityString rating:self.toolbar.ratingString keywords:self.toolbar.searchString genre:self.toolbar.genreString sort:self.toolbar.sortString completion:^(id object, NSError *error) {
        if (!error) {
            self.movieList = object;
            [self.collectionView setContent:self.movieList];
        }
        [self.toolbar stopProgressIndicator];
    }];
}

@end
