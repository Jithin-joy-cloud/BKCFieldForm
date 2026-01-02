BKCFieldForm – Offline-First Mobile Data Collection
I developed this Flutter application for Building Knowledge Canada to solve a critical problem for field supervisors working in remote construction sites with little to no internet connectivity.

The Problem
Supervisors needed to collect high-quality site data, but cloud-based apps would often crash or lose data when the internet dropped out in remote areas. They were forced to go back to paper forms, which caused delays and data entry errors.

My Solution
I built a mobile productivity app designed to work offline-first. Using ObjectBox, the app saves all data locally on the device immediately. Once the supervisor returns to an area with internet, they can sync all their offline work to the central server with one tap.

Key Features:
Resilient Data Storage: Integrated ObjectBox for high-performance local NoSQL storage, ensuring zero data loss during network outages.

Excel Integration: Built a feature to import and read data from Excel sheets to auto-populate form fields, saving supervisors time and reducing typing errors.

Local PDF Generation: Supervisors can generate a professional PDF report of their data directly on their phone to share or store immediately.

Dynamic Configuration: Used Firebase Remote Config to manage app settings and form versions remotely without needing to push a new update to the app store.

State Management: Used the Provider pattern to keep the app fast and the code easy to maintain.

Tech Stack
Framework: Flutter

Language: Dart

Local Database: ObjectBox

Cloud Services: Firebase (Remote Config)

State Management: Provider

Networking: HTTP package for REST API communication

Project Structure
lib/models: Data structures for field forms and Excel mapping.

lib/providers: Logic for managing app state and offline-to-online syncing.

lib/services: PDF generation and Firebase integration logic.
