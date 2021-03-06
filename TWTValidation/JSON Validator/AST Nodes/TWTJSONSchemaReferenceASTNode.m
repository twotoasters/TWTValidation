//
//  TWTJSONSchemaReferenceASTNode.m
//  TWTValidation
//
//  Created by Jill Cohen on 1/29/15.
//  Copyright (c) 2015 Two Toasters, LLC.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <TWTValidation/TWTJSONSchemaReferenceASTNode.h>

@implementation TWTJSONSchemaReferenceASTNode

- (void)acceptProcessor:(id<TWTJSONSchemaASTProcessor>)processor
{
    [processor processReferenceNode:self];
}


- (NSArray *)childrenReferenceNodes
{
    NSMutableArray *nodes = [[super childrenReferenceNodes] mutableCopy];
    [nodes addObject:self];

    // If the referent is not in the same tree as the reference node, add its children
    if (self.filePath) {
        [nodes addObjectsFromArray:self.referentNode.childrenReferenceNodes];
    }

    return nodes;
}


- (NSSet *)validTypes
{
    return self.referentNode.validTypes;
}


- (BOOL)isTypeSpecified
{
    return YES;
}


- (NSString *)fullReferencePath
{
    NSMutableString *path = [[NSMutableString alloc] init];
    
    if (self.filePath) {
        [path appendString:self.filePath];
    }

    if (self.referencePathComponents.count) {
       [path appendString:[self.referencePathComponents componentsJoinedByString:@"/"]];
    }

    return path;
}

@end
