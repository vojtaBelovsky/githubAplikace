//
//  BCIssueTitleLabel.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/5/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueTitleLabel.h"
#import <CoreText/CoreText.h>
#import "BCIssueCell.h"

#define EMPTY_STRING      @"         "
#define LINE_BREAK_MODE   NSLineBreakByWordWrapping
#define TITLE_FONT_COLOR  [UIColor colorWithRed:.26 green:.26 blue:.26 alpha:1.00]

@implementation BCIssueTitleLabel

- (id)initWithFont:(UIFont*)font
{
  self = [super init];
  if (self) {
    [self setNumberOfLines:0];
    [self setFont:font];
    [self setFontColor:TITLE_FONT_COLOR];
    [self setLineHeight:LINE_HEIGHT];
//    [self setLineBreakMode:LINE_BREAK_MODE];
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

-(void)setText:(NSString *)text{
  text = [[NSString alloc] initWithFormat:@"%@%@",EMPTY_STRING,text];
  [super setText:text];
}

-(CGSize)sizeOfLabelWithWidth:(CGFloat)width{
  return [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(width, 2000) lineBreakMode:LINE_BREAK_MODE];
}

+(CGSize)sizeOfLabelWithText:(NSString*)text font:(UIFont*)font width:(CGFloat)width{
  text = [[NSString alloc] initWithFormat:@"%@%@",EMPTY_STRING,text];
  CGSize sizeOfTitle;
  sizeOfTitle = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, 2000) lineBreakMode:LINE_BREAK_MODE];
//  int titleLineHeight = sizeOfTitle.height;
//  int numberOfLines = sizeOfTitle.width/width+1;
//  sizeOfTitle = CGSizeMake(width, numberOfLines*titleLineHeight);
  return sizeOfTitle;
}

-(NSString *)getLastLineOfStringInLabel
{
  NSString *text = [self text];
  UIFont   *font = [self font];
  CGRect    rect = [self frame];
  
  CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
  NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
  [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
  
  
  CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
  
  CGMutablePathRef path = CGPathCreateMutable();
  CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
  
  CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
  
  NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
  NSMutableArray *linesArray = [[NSMutableArray alloc]init];
  
  for (id line in lines)
  {
    CTLineRef lineRef = (__bridge CTLineRef )line;
    CFRange lineRange = CTLineGetStringRange(lineRef);
    NSRange range = NSMakeRange(lineRange.location, lineRange.length);
    
    NSString *lineString = [text substringWithRange:range];
    [linesArray addObject:lineString];
  }
  
  return (NSString *)[linesArray lastObject];
}

+(NSString *)getLastLineInLabelFromText:(NSString *)givenText
{
  BCIssueTitleLabel *label = [[BCIssueTitleLabel alloc] initWithFont:CELL_TITLE_FONT];
  [label setText:givenText];
  CGRect labelFrame = CGRectZero;
  labelFrame.size = [BCIssueTitleLabel sizeOfLabelWithText:givenText font:CELL_TITLE_FONT width:ISSUE_WIDTH-2*OFFSET];
  [label setFrame:labelFrame];
  
  NSString *text = [label text];
  UIFont   *font = [label font];
  CGRect    rect = [label frame];
  
  CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
  NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
  [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
  
  
  CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
  
  CGMutablePathRef path = CGPathCreateMutable();
  CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
  
  CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
  
  NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
  NSMutableArray *linesArray = [[NSMutableArray alloc]init];
  
  for (id line in lines)
  {
    CTLineRef lineRef = (__bridge CTLineRef )line;
    CFRange lineRange = CTLineGetStringRange(lineRef);
    NSRange range = NSMakeRange(lineRange.location, lineRange.length);
    
    NSString *lineString = [text substringWithRange:range];
    [linesArray addObject:lineString];
  }
  
  return (NSString*)[linesArray lastObject];
}

@end
