//
// DSPopoverViewController.h
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

#import <Cocoa/Cocoa.h>
#import "YIFYMovie.h"

@interface DSPopoverViewController : NSViewController <NSPopoverDelegate>

@property (strong) NSString *theTitle;

@property (strong) NSImage *oldPoster;

@property (strong) IBOutlet NSImageView *poster;

@property (strong) IBOutlet NSTextField *movieTitle;

@property (strong) IBOutlet NSTextField *ratingLabel;

@property (strong) IBOutlet NSLevelIndicator *ratingIndicator;

@property (strong) IBOutlet NSTextField *movieYear;

@property (strong) IBOutlet NSTextField *moviePlot;

@property (strong) IBOutlet NSTextField *genreLabel;

@property (strong) IBOutlet NSTextField *ratingInfoLabel;

@property (strong) IBOutlet NSButton *imdbButton;
@property (strong) NSString *imdbUrlString;

@property (strong) IBOutlet NSButton *downloadButton;
@property (strong) NSString *downloadUrlString;

@property (strong) IBOutlet NSButton *trailerButton;
@property (strong) NSString *trailerUrlString;

@property (strong) IBOutlet NSProgressIndicator *progressIndicator;

@property (strong) IBOutlet NSImageView *qualityImageView;

@property (strong) IBOutlet NSTextField *seedsAndPeers;

@property (strong) IBOutlet NSTextField *filesize;

@property (strong) IBOutlet NSTextField *runtime;

- (void)setMovie:(YIFYMovie*)movie;

- (IBAction)downloadMovie:(id)sender;
- (IBAction)showImdb:(id)sender;
- (IBAction)playTrailer:(id)sender;

@end
