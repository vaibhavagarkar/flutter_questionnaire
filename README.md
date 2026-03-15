# Flutter Questionnaire App

A Flutter interview assignment app built with GetX, offline storage, and a clean layered structure.

## Project Summary

This application includes:

- Register, login, and logout flow
- Questionnaire listing and submission flow
- Offline storage for users and submissions
- Submission history with date, time, latitude, and longitude
- GetX-based navigation and state handling

## Tech Stack

- Flutter
- GetX
- sqflite
- shared_preferences
- geolocator

## Architecture

The project is organized with a clean structure using:

- `core`
- `data`
- `domain`
- `modules`
- `routes`

This keeps UI, state, data access, and business logic separated and easier to maintain.

## Development Version

This project was developed with:

- Flutter `3.41.2`
- Dart `3.11.0`
- DevTools `2.54.1`

## Notes

- Location permission is requested at app startup.
- Questionnaire data is currently served from a local mock data source.
- User session is stored with `shared_preferences`.
- Structured offline data is stored with `sqflite`.
