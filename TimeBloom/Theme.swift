import SwiftUI

// By creating a custom Theme struct, we can easily manage and use our new color palette
// throughout the entire application, ensuring consistency.

struct Theme {
    // These names MUST match the names of the Color Sets you create in your Asset Catalog.
    static let background = Color("AppBackgroundColor")
    static let primaryButton = Color("AppPrimaryButtonColor")
    
    static let text = Color.black
    static let buttonText = Color.white
}

/*
 *******************************************************************
 *!! IMPORTANT !! - HOW TO ADD YOUR CUSTOM COLORS:
 *******************************************************************
 *
 * This is the most common source of errors. Please follow these steps exactly.
 *
 * 1. In Xcode, go to your 'Assets.xcassets' file.
 *
 * 2. Click the '+' button at the bottom and select 'Color Set'.
 *
 * 3. Name the new color set EXACTLY 'AppBackgroundColor' (without quotes).
 *
 * 4. With 'AppBackgroundColor' selected, look at the Attributes Inspector on the right.
 * For the 'Any Appearance' swatch:
 * - Set 'Content' to 'sRGB'.
 * - Set 'Input Method' to '8-bit Hexadecimal'.
 * - In the 'Hex' field, enter 'ecfbe8'.
 *
 * 5. Repeat the process: create ANOTHER Color Set named EXACTLY 'AppPrimaryButtonColor'.
 *
 * 6. For this new color set, in the 'Hex' field, enter '1a8b62'.
 *
 * Your app will now correctly use your custom colors. If the background is still
 * white, it means the names do not match exactly.
 *
 *******************************************************************
 */
