# Lemon Squeezy Demo App
This demo SwiftUI app and Xcode target provides a testing environment and example usage for the LemonSqueezy library.

## Setup
You will need to provide your API credentials before you can build and run the app.

1. Create a `.env` file in the Demo App folder (or copy `.env.example` to `.env`)
1. Populate the `.env` file with `LS_API_KEY` value (see `.env.example` for an example)
1. Build the Lemon_SqueezyApp target to create the `Secrets.swift` file which provides your client credentials for the app. You may need to clean the build folder to prevent errors about `Secrets.swift` being missing and then manually re-build.
