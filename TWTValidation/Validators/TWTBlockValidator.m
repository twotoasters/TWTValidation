//
//  TWTBlockValidator.m
//  TWTValidation
//
//  Created by Prachi Gauriar on 3/28/2014.
//  Copyright (c) 2014 Two Toasters, LLC.
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

#import <TWTValidation/TWTBlockValidator.h>

@interface TWTBlockValidator ()

@property (nonatomic, copy, readwrite) TWTValidationBlock block;

@end


@implementation TWTBlockValidator

- (instancetype)init
{
    return [self initWithBlock:nil];
}


- (instancetype)initWithBlock:(TWTValidationBlock)block
{
    self = [super init];
    if (self) {
        _block = block;
    }
    
    return self;
}


+ (instancetype)blockValidatorWithBlock:(TWTValidationBlock)block
{
    return [[self alloc] initWithBlock:block];
}


- (instancetype)copyWithZone:(NSZone *)zone
{
    typeof(self) copy = [super copyWithZone:zone];
    copy.block = self.block;
    return copy;
}


- (NSUInteger)hash
{
    return [super hash] ^ [self.block hash];
}


- (BOOL)isEqual:(id)object
{
    if (![super isEqual:object]) {
        return NO;
    }
    
    typeof(self) other = object;
    return [self.block isEqual:other.block];
}


- (BOOL)validateValue:(id)value error:(out NSError *__autoreleasing *)outError
{
    return self.block ? self.block(value, outError) : YES;
}

@end
