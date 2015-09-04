/*
 * HYJDrawingView: https://github.com/acerbetti/HYJDrawingView
 *
 * Copyright (c) 2013 Stefano Acerbetti
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#import <UIKit/UIKit.h>

#define HYJDrawingViewVersion   1.0.0

typedef enum {
    HYJDrawingToolTypePen,
    HYJDrawingToolTypeLine,
    HYJDrawingToolTypeRectagleStroke,
    HYJDrawingToolTypeRectagleFill,
    HYJDrawingToolTypeEllipseStroke,
    HYJDrawingToolTypeEllipseFill,
    HYJDrawingToolTypeEraser,
    HYJDrawingToolTypeText,
    HYJDrawingToolTypeMultilineText
} HYJDrawingToolType;

typedef NS_ENUM(NSUInteger, HYJDrawingMode) {
    HYJDrawingModeScale,
    HYJDrawingModeOriginalSize
};

@protocol HYJDrawingViewDelegate, HYJDrawingTool;

@interface HYJDrawingView : UIView<UITextViewDelegate>

@property (nonatomic, assign) HYJDrawingToolType drawTool;
@property (nonatomic, assign) id<HYJDrawingViewDelegate> delegate;

// public properties
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat lineAlpha;
@property (nonatomic, assign) HYJDrawingMode drawMode;

// get the current drawing
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, readonly) NSUInteger undoSteps;

// load external image
- (void)loadImage:(UIImage *)image;
- (void)loadImageData:(NSData *)imageData;

// erase all
- (void)clear;

// undo / redo
- (BOOL)canUndo;
- (void)undoLatestStep;

- (BOOL)canRedo;
- (void)redoLatestStep;

/**
 @discussion Discards the tool stack and renders them to prev_image, making the current state the 'start' state.
 (Can be called before resize to make content more predictable)
 */
- (void)commitAndDiscardToolStack;

@end

#pragma mark - 

@interface HYJDrawingView (Deprecated)
@property (nonatomic, strong) UIImage *prev_image DEPRECATED_MSG_ATTRIBUTE("Use 'backgroundImage' instead.");
@end

#pragma mark -

@protocol HYJDrawingViewDelegate <NSObject>

@optional
- (void)drawingView:(HYJDrawingView *)view willBeginDrawUsingTool:(id<HYJDrawingTool>)tool;
- (void)drawingView:(HYJDrawingView *)view didEndDrawUsingTool:(id<HYJDrawingTool>)tool;

@end
