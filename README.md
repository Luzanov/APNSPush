<p align="center">
    <img src="https://img.shields.io/badge/os-macOS-green.svg?style=flat" alt="macOS">
    <img src="https://img.shields.io/badge/os-linux-green.svg?style=flat" alt="Linux">
    <img src="https://img.shields.io/badge/license-Apache2-blue.svg?style=flat" alt="Apache 2">
</p>

# APNSPush

This is a short sample which demonstrate how to send Remote Notification with Token-Based Connection. It only supports authentication via JSON Web Tokens. There are no plans to support the old certificate authentication.

Tested on Linux and macOS.

## Prerequisites

### Swift

* Swift Open Source `swift-5.2.2-RELEASE`

### macOS

* macOS 10.15.6 (*Catalina*) or higher.
* Xcode Version 11.6 (11E708) or higher.

### Linux

* Ubuntu 20.04
* The appropriate **libssl-dev** package is required to be installed when building.

## Build

To build `APNSPush` from the command line:

```
% cd <path-to-clone>
% swift build
```
## Using APNSPush demo

### Before starting

To do encrypted token the `CryptorECC` framework is used. So import the framework by the following:
```swift
import CryptorECC
```

On Linux you also need to import the `FoundationNetworking` framework. 
```swift
#if os(Linux)
import FoundationNetworking
#endif
```

### Setup your data

Setup all constants

```swift
let topic = "<YOUR APP'S BUNDLE ID>"
let deviceToken = "<YOUR DEVICE TOKEN>"
let keyId = "<YOUR PRIVATE KEY ID>"
let teamId = "<YOUR TEAM ID>"
let privateKey = """
<YOUR PRIVATE KEY>
"""
```

#### Example

```swift
let topic = "com.my.app"
let deviceToken = "d4b81026a7820061ea16b6c1e2af08232fc8a89e22da99014d373500968c0372"
let keyId = "M78TT8HMLH"
let teamId = "3Q904AZ8Q5"
let privateKey = """
-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIPrlm+dsMBLI/3F1PzOgcHobGUeBBbWI2mZ4ovFVQEdHoAoGCCqGSM49
AwEHoUQDQgAEEfpCdAXtmycSyHqPJGDob7wbQZXL3FfAdpeGToYKsxtZFmzITkZY
aW4IXyQbvtSd7pKGuUoybvZbTdeFuSAQpg==
-----END EC PRIVATE KEY-----
"""
```
