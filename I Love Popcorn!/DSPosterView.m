//
// DSPosterView.m
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

#import "DSPosterView.h"
#import "DSPopoverViewController.h"
#import "NSImage+roundedCorners.h"

@implementation DSPosterView

- (void)awakeFromNib {
    self.progressIndicator = [[NSProgressIndicator alloc] initWithFrame:NSRectFromCGRect(CGRectMake(self.frame.size.width/2-10, self.frame.size.height/2-10, 20, 20))];
    self.progressIndicator.style = NSProgressIndicatorSpinningStyle;
    [self.progressIndicator setDisplayedWhenStopped:NO];
    [self.progressIndicator startAnimation:nil];
    [self addSubview:self.progressIndicator];
    
    // Init popover
    DSPopoverViewController *popoverViewController = [[DSPopoverViewController alloc] initWithNibName:@"DSPopoverViewController" bundle:nil];
    self.popover = [[NSPopover alloc] init];
    self.popover.contentViewController = popoverViewController;
    self.popover.behavior = NSPopoverBehaviorTransient;
    self.popover.animates = YES;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (id)copyWithZone:(NSZone *)zone {
    DSPosterView *newImageView = [[DSPosterView alloc] initWithFrame:self.frame];
    newImageView.image = self.image;
    newImageView.normalImage = self.normalImage;
    newImageView.tintedImage = self.tintedImage;
    return newImageView;
}

- (NSImage *)image:(NSImage*)theImage TintedWithColor:(NSColor *)tint
{
    NSImage *image = [theImage copy];
    if (tint) {
        [image lockFocus];
        [tint set];
        NSRect imageRect = {NSZeroPoint, [image size]};
        NSRectFillUsingOperation(imageRect, NSCompositeSourceAtop);
        [image unlockFocus];
    }
    return image;
}

- (void)mouseDown:(NSEvent *)theEvent {
    if ([self.delegate respondsToSelector:@selector(mouseDownOnPoster:)]) [self.delegate mouseDownOnPoster:self];
    if (!self.popover.isShown) [self showMovieInfo];
    else [self hideMovieInfo];
}

-(void)mouseEntered:(NSEvent *)theEvent {
    if ([self.delegate respondsToSelector:@selector(mouseEnteredPoster:)]) [self.delegate mouseEnteredPoster:self];
    [self tintImage];
}

-(void)mouseExited:(NSEvent *)theEvent {
    if ([self.delegate respondsToSelector:@selector(mouseExitedPoster:)]) [self.delegate mouseExitedPoster:self];
    [self untintImage];
}

-(void)updateTrackingAreas
{
    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    NSTrackingArea *trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:opts
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:trackingArea];
}

- (void)resetCursorRects {
    [super resetCursorRects];
    
    NSCursor *pointingHandCursor = [NSCursor pointingHandCursor];
    [self addCursorRect:[self bounds] cursor:pointingHandCursor];
}

- (void)showMovieInfo {
    DSPopoverViewController *popoverViewController = (DSPopoverViewController*)self.popover.contentViewController;
    [popoverViewController setMovie:self.movie];
    popoverViewController.oldPoster = self.normalImage;
    
    [self.popover showRelativeToRect:[self bounds] ofView:self preferredEdge:NSMaxYEdge];
}

- (void)hideMovieInfo {
    [self.popover close];
}

- (void)setPosterUrlString:(NSString *)urlString {
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    if (imageData != nil) {
        NSImage *image = [[NSImage alloc] initWithData:imageData];
        self.normalImage = [image imageWithRoundedCornersRadius:6];
        self.tintedImage = [[self image:image TintedWithColor:[NSColor colorWithCalibratedWhite:1 alpha:.2]] imageWithRoundedCornersRadius:6];
        [self.progressIndicator stopAnimation:nil];
        if ([self.delegate respondsToSelector:@selector(posterViewDidFinishLoadingPoster:)]) [self.delegate posterViewDidFinishLoadingPoster:self];
        [self untintImage];
    }
}

- (void)tintImage {
    self.image = self.tintedImage;
}

- (void)untintImage {
    self.image = self.normalImage;
}

@end
