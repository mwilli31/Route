/*
 * Copyright (c) 2015 Sinch AB. All rights reserved.
 *
 * See LICENSE file for license terms and information.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
An opaque protocol representing a parsed phone number.

Example usage:

- It be passed as an argument when creating a Sinch Verification
instance

- It can be passed as an argument to the PhoneNumberUtil formatting
  functions.

*/
@protocol SINPhoneNumber <NSObject, NSCopying>

/**
 * Country calling code according to the International
 * Telecommunication Union (ITU).
 *
 * (Sometimes also referred to as country dial in code.)
 */
@property (nonatomic, strong, readonly) NSNumber *countryCode;

/**
 * If a phone number was parsed from user input, the raw input may be
 * preserved and accessiable via this property.
 */
@property (nonatomic, strong, readonly, nullable) NSString *rawInput;

@end

NS_ASSUME_NONNULL_END
