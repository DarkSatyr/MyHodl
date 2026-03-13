# MyHodl

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)
![iOS](https://img.shields.io/badge/iOS-17%2B-black.svg)
![License](https://img.shields.io/badge/license-MPL--2.0-green.svg)

A privacy-first crypto portfolio tracker for iOS built with **SwiftUI**
and **Clean Architecture**.

MyHodl is an experimental open-source project focused on building a
modern, modular iOS architecture for financial applications. The goal of
the project is to demonstrate a scalable SwiftUI architecture while
providing a useful cryptocurrency portfolio tracker.

------------------------------------------------------------------------

## Features

-   Portfolio tracking
-   Real-time price updates
-   Native SwiftUI interface
-   Clean Architecture
-   Offline-first design
-   Local storage using SwiftData
-   Modular repository architecture
-   Asset search and management

------------------------------------------------------------------------

## Architecture

MyHodl follows a layered architecture inspired by Clean Architecture
principles.

    SwiftUI Views
          ↓
    ViewModels
          ↓
    UseCases
          ↓
    Repositories
          ↓
    DataSources
          ↓
    SwiftData / API

Key principles:

-   Separation of concerns
-   Dependency inversion
-   Modular feature structure
-   Testable domain layer
-   Offline-first architecture

------------------------------------------------------------------------

## Project Structure

    MyHodl
     ├ App
     │
     ├ Features
     │   ├ Dashboard
     │   ├ Holdings
     │   └ AssetEditor
     │
     ├ Domain
     │   ├ Entities
     │   └ UseCases
     │
     ├ Data
     │   ├ Repositories
     │   └ API
     │
     └ Core
         ├ Networking
         └ Storage

------------------------------------------------------------------------

## Installation

Clone the repository:

    git clone https://github.com/DarkSatyr/MyHodl.git

Open the project in Xcode and run the app.

Requirements:

-   Xcode 15+
-   iOS 17+
-   Swift 5.9+

------------------------------------------------------------------------

## Roadmap

v0.2 - Portfolio charts - Asset search improvements

v0.3 - Price alerts - Improved asset management

v1.0 - Wallet integrations - Export reports - Multi-device sync

------------------------------------------------------------------------

## Contributing

Contributions are welcome.

To contribute:

1.  Fork the repository
2.  Create a feature branch
3.  Make your changes
4.  Submit a Pull Request

Please open an issue before starting large changes.

------------------------------------------------------------------------

## License

This project is licensed under the **Mozilla Public License 2.0
(MPL-2.0)**.

See the LICENSE file for details.

------------------------------------------------------------------------

## Trademark

MyHodl and the MyHodl logo are trademarks of the MyHodl Project.

The name, logo, and branding are not covered by the open-source license
and may not be used for derivative applications without permission.

------------------------------------------------------------------------

## Official App

The official MyHodl iOS application is distributed only through the
Apple App Store.

Open-source builds of this repository may differ from the official
release and may not include all production features.

------------------------------------------------------------------------

## Project Status

MyHodl is currently an experimental open-source project.

Future commercial versions of the application may include additional
functionality not available in this repository.

------------------------------------------------------------------------

## Author

Maintained by:

DarkSatyr

GitHub: https://github.com/DarkSatyr
