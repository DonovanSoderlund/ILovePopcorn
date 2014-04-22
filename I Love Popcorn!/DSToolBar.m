//
// DSToolBarController.m
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

#import "DSToolBar.h"

@implementation DSToolBar

@synthesize delegate;

- (IBAction)searchBarAction:(id)sender {
    // Call delegate method
    if ([self.delegate respondsToSelector:@selector(searchFieldDidChange:)])
        [self.delegate searchFieldDidChange:self.searchField];
}

- (IBAction)genrePopupButtonAction:(id)sender {
    // Call delegate method
    if ([self.delegate respondsToSelector:@selector(genrePopupButtonDidChange:)])
        [self.delegate genrePopupButtonDidChange:self.genrePopup];
}

- (IBAction)qualityPopupButtonAction:(id)sender {
    // Call delegate method
    if ([self.delegate respondsToSelector:@selector(qualityPopupButtonDidChange:)])
        [self.delegate qualityPopupButtonDidChange:self.qualityPopup];
}

- (IBAction)sortPopupButtonAction:(id)sender {
    // Call delegate method
    if ([self.delegate respondsToSelector:@selector(sortingPopupButtonDidChange:)])
        [self.delegate sortingPopupButtonDidChange:self.sortPopup];
}

- (IBAction)ratingSliderAction:(id)sender {
    [self updateRatingSlider];
    // Call delegate method
    if ([self.delegate respondsToSelector:@selector(ratingSliderDidChange:)])
        [self.delegate ratingSliderDidChange:self.ratingSlider];
}

- (void)updateRatingSlider {
    [self.ratingToolbarItem setLabel:[NSString stringWithFormat:@"Rating: %@", self.ratingString]];
}

- (NSString*)searchString {
    return self.searchField.stringValue;
}

- (NSString*)genreString {
    return self.genrePopup.selectedItem.title;
}

- (NSString*)qualityString {
    return self.qualityPopup.selectedItem.title;
}

- (NSString*)sortString {
    return self.sortPopup.selectedItem.title;
}

- (NSString*)ratingString {
    return !self.ratingSlider.integerValue?@"All":[NSString stringWithFormat:@"%ld", self.ratingSlider.integerValue];
}

- (void)startProgressIndicator {
    [self.progressIndicator startAnimation:nil];
}

- (void)stopProgressIndicator {
    [self.progressIndicator stopAnimation:nil];
}

@end
