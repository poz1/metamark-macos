//
//  MarkdownConverter.m
//  MetaMark
//
//  Originally developed by Iwaki Satoshi (2018), then forked by Francesco Baldassarri (2020)
//  Markdown Editor Copyright © 2018 Satoshi Iwaki. MetaMark Copyright © 2020 Francesco Baldassarri.
//

#import "MarkdownConverter.h"

@implementation MarkdownConverter

- (instancetype)init {
    self = [super initWithTitle:@"Markdown"
                         format:@"markdown"
                         header:@"markdown-header.txt"
                            css:@"markdown.css"];
    if (self) {
    }
    return self;
}

- (NSString *)formattedStringWithString:(NSString *)string format:(TextConverterFormat)format {
    switch (format) {
        case TextConverterFormatBold:
            return [NSString stringWithFormat:@"**%@**", string];
        case TextConverterFormatItalic:
            return [NSString stringWithFormat:@"*%@*", string];
        case TextConverterFormatBoldItalic:
            return [NSString stringWithFormat:@"***%@***", string];
        case TextConverterFormatStrikeThrough:
            return [NSString stringWithFormat:@"~~%@~~", string];
        case TextConverterFormatH1:
            return [NSString stringWithFormat:@"# %@", string];
        case TextConverterFormatH2:
            return [NSString stringWithFormat:@"## %@", string];
        case TextConverterFormatH3:
            return [NSString stringWithFormat:@"### %@", string];
        case TextConverterFormatH4:
            return [NSString stringWithFormat:@"#### %@", string];
        case TextConverterFormatH5:
            return [NSString stringWithFormat:@"##### %@", string];
        case TextConverterFormatH6:
            return [NSString stringWithFormat:@"###### %@", string];
        case TextConverterFormatCode: {
            return [NSString stringWithFormat:@"```\n%@\n```", string];
        }
        case TextConverterFormatInlineCode: {
            return [NSString stringWithFormat:@" '%@' ", string];
        }
        case TextConverterAddLineSeparator: {
            return [NSString stringWithFormat:@"%@\n---\n", string];
        }
        case TextConverterAddImage: {
            return [NSString stringWithFormat:@"%@\n![Alt, 75%%](url|path)\n", string];
        }
        case TextConverterAddImageWithLink: {
            return [NSString stringWithFormat:@"%@\n[![Alt](url|path)](./somelink)\n", string];
        }
        case TextConverterFormatLink: {
            return [NSString stringWithFormat:@"[%@](url)", string];
        }
        case TextConverterFormatQuote: {
            NSArray<NSString *> *lines = [string componentsSeparatedByString:@"\n"];
            NSMutableString *formattedString = [@"" mutableCopy];
            for (NSString *line in lines) {
                [formattedString appendString:@"> "];
                [formattedString appendString:line];
                [formattedString appendString:@"\n"];
            }
            return formattedString;
        }
        case TextConverterFormatListBulleted: {
            NSArray<NSString *> *lines = [string componentsSeparatedByString:@"\n"];
            NSMutableString *formattedString = [@"" mutableCopy];
            for (NSString *line in lines) {
                [formattedString appendString:@"- "];
                [formattedString appendString:line];
                [formattedString appendString:@"\n"];
            }
            return formattedString;
        }
        case TextConverterFormatTable: {
            NSArray<NSString *> *lines = [string componentsSeparatedByString:@"\n"];
            NSMutableString *formattedString = [@"" mutableCopy];
            for (NSString *line in lines) {
                [formattedString appendString:@"| Column 1 | Column 2 | Column 3 |"];
                [formattedString appendString:@"\n"];
                [formattedString appendString:@"|:----------|:----------|:----------|"];
                [formattedString appendString:@"\n"];
                [formattedString appendString:@"| "];
                [formattedString appendString:line];
                [formattedString appendString:@" | "];
                [formattedString appendString:line];
                [formattedString appendString:@" | "];
                [formattedString appendString:line];
                [formattedString appendString:@" |"];
                [formattedString appendString:@"\n"];
            }
            return formattedString;
        }
        case TextConverterFormatDropdown: {
            NSArray<NSString *> *lines = [string componentsSeparatedByString:@"\n"];
            NSMutableString *formattedString = [@"" mutableCopy];
            for (NSString *line in lines) {
                [formattedString appendString:@"<details>"];
                [formattedString appendString:@"\n"];
                [formattedString appendString:@"<summary>Dropdown Title</summary>"];
                [formattedString appendString:@"\n"];
                [formattedString appendString:line];
                [formattedString appendString:@"\n"];
                [formattedString appendString:@"</details>"];
                [formattedString appendString:@"\n"];
            }
            return formattedString;
        }
        case TextConverterFormatListNumbered: {
            NSArray<NSString *> *lines = [string componentsSeparatedByString:@"\n"];
            NSMutableString *formattedString = [@"" mutableCopy];
            for (NSString *line in lines) {
                [formattedString appendString:@"1. "];
                [formattedString appendString:line];
                [formattedString appendString:@"\n"];
            }
            return formattedString;
        }
        case TextConverterFormatTaskListIncomplete: {
            NSArray<NSString *> *lines = [string componentsSeparatedByString:@"\n"];
            NSMutableString *formattedString = [@"" mutableCopy];
            for (NSString *line in lines) {
                [formattedString appendString:@"- [ ] "];
                [formattedString appendString:line];
                [formattedString appendString:@"\n"];
            }
            return formattedString;
        }
        case TextConverterFormatTaskListComplete: {
            NSArray<NSString *> *lines = [string componentsSeparatedByString:@"\n"];
            NSMutableString *formattedString = [@"" mutableCopy];
            for (NSString *line in lines) {
                [formattedString appendString:@"- [x] "];
                [formattedString appendString:line];
                [formattedString appendString:@"\n"];
            }
            return formattedString;
        }
        default:
            break;
    }
    return string;
}

@end
