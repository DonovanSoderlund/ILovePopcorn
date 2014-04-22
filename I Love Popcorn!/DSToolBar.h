//
// DSToolBarController.h
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

#import <Foundation/Foundation.h>

@protocol DSToolbarDelegate <NSToolbarDelegate>

- (void)searchFieldDidChange:(NSSearchField*)searchField;
- (void)genrePopupButtonDidChange:(NSPopUpButton*)genrePopupButton;
- (void)qualityPopupButtonDidChange:(NSPopUpButton*)qualityPopupButton;
- (void)sortingPopupButtonDidChange:(NSPopUpButton*)sortingPopupButton;
- (void)ratingSliderDidChange:(NSSlider*)ratingSlider;

@end

@interface DSToolBar : NSToolbar

@property (strong) IBOutlet NSSearchField *searchField;
@property (strong) IBOutlet NSPopUpButton *genrePopup;
@property (strong) IBOutlet NSPopUpButton *qualityPopup;
@property (strong) IBOutlet NSPopUpButton *sortPopup;
@property (strong) IBOutlet NSSlider *ratingSlider;
@property (strong) IBOutlet NSProgressIndicator *progressIndicator;

@property (strong) IBOutlet NSToolbarItem *ratingToolbarItem;

@property (nonatomic) NSString *searchString;
@property (nonatomic) NSString *genreString;
@property (nonatomic) NSString *qualityString;
@property (nonatomic) NSString *sortString;
@property (nonatomic) NSString *ratingString;

- (void)updateRatingSlider;

@property(nonatomic, assign) id<DSToolbarDelegate> delegate;

- (void)startProgressIndicator;
- (void)stopProgressIndicator;

@end


