# EduSwap Flutter

**A mobile interface for discovering skills and learning from one another.**

## Features

Home feed, discovery, matching, chat, notifications, leaderboard, profile and video room screens. Sample data lives in `lib/data/mock_data.dart`.

**Status:** interface demo. This repository contains `lib/` and `pubspec.yaml`; platform scaffolding, a production backend and live calling services are not included.

## Requirements

Flutter with Dart `>=3.2.0 <4.0.0`. Android development requires an Android SDK and device/emulator; web development requires a supported browser.

## Quick start

```bash
git clone https://github.com/Muqimovdavronbek/EsuSwap_demo.git
cd EsuSwap_demo
flutter doctor
```

Back up `lib/` and `pubspec.yaml` before generating the missing platform files:

```bash
flutter create --project-name eduswap_flutter_app --platforms=android,web .
flutter pub get
flutter devices
flutter run
```

For web: `flutter run -d chrome`. For an Android package: `flutter build apk --release`.

## Usage

Follow the introduction screens, browse skill cards and use the bottom navigation to explore matching, chat and profile screens. Update `mock_data.dart` to change demo content.

## Project layout

| Directory | Purpose |
| --- | --- |
| `lib/screens/` | Application screens |
| `lib/components/` | Reusable UI |
| `lib/models/` | Data models |
| `lib/theme/` | Theme configuration |
| `lib/app/` | Navigation shell |

## Contributing

Describe the affected screen, expected behavior and reproduction steps. Include relevant Flutter analysis/build output, and identify whether a feature is a mockup or connected to a real service.
