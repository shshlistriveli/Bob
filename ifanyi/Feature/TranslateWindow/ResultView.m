//
//  ResultView.m
//  ifanyi
//
//  Created by ripper on 2019/11/13.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "ResultView.h"

@implementation ResultView

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor mm_colorWithHexString:@"#EEEEEE"].CGColor;
    self.layer.borderColor = [NSColor mm_colorWithHexString:@"#EEEEEE"].CGColor;
    self.layer.borderWidth = 1;
    
    self.scrollView = [NSScrollView mm_make:^(NSScrollView *  _Nonnull scrollView) {
        [self addSubview:scrollView];
        scrollView.wantsLayer = YES;
        scrollView.backgroundColor = NSColor.mm_randomColor;
        scrollView.hasVerticalScroller = YES;
        scrollView.hasHorizontalScroller = NO;
        scrollView.autohidesScrollers = YES;
        self.textView = [NSTextView mm_make:^(NSTextView * _Nonnull textView) {
            [textView setDefaultParagraphStyle:[NSMutableParagraphStyle mm_anyMake:^(NSMutableParagraphStyle *  _Nonnull style) {
                style.lineHeightMultiple = 1.2;
                style.paragraphSpacing = 5;
            }]];
            textView.string = @"我相信这世界上，有些人有些事有些爱，在见到的第一次，就注定要羁绊一生，就注定像一棵树一样，生长在心里，生生世世。我相信这世界上，有些人有些事有些爱，在见到的第一次，就注定要羁绊一生，就注定像一棵树一样，生长在心里，生生世世。";

            textView.editable = NO;
            textView.font = [NSFont systemFontOfSize:14];
            textView.textColor = [NSColor mm_colorWithHexString:@"#333333"];
            textView.alignment = NSTextAlignmentJustified;
            textView.textContainerInset = CGSizeMake(16, 12);
            textView.backgroundColor = [NSColor mm_colorWithHexString:@"#EEEEEE"];
            [textView setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
        }];
        scrollView.documentView = self.textView;
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.inset(0);
            make.bottom.inset(26);
        }];
    }];
    
    self.audioButton = [NSButton mm_make:^(NSButton * _Nonnull button) {
        [self addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeToggle];
        button.image = [NSImage imageNamed:@"audio"];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(9.5);
            make.bottom.inset(3);
            make.width.height.equalTo(@26);
        }];
        mm_weakify(self)
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            mm_strongify(self)
            if (self.audioActionBlock) {
                self.audioActionBlock(self);
            }
            return RACSignal.empty;
        }]];
    }];
    
    self.textCopyButton = [NSButton mm_make:^(NSButton * _Nonnull button) {
        [self addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeToggle];
        button.image = [NSImage imageNamed:@"copy"];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.audioButton.mas_right).offset(1.5);
            make.bottom.equalTo(self.audioButton);
            make.width.height.equalTo(@26);
        }];
        mm_weakify(self)
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            mm_strongify(self)
            if (self.copyActionBlock) {
                self.copyActionBlock(self);
            }
            return RACSignal.empty;
        }]];
    }];
    
    // 将scrollview放到最上层
    [self addSubview:self.scrollView];
}

@end
