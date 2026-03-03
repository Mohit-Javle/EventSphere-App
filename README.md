# 🌐 EventSphere — Premium Event Management UI

EventSphere is a production-grade, high-fidelity Flutter application designed for modern event management and networking. This repository contains the **complete frontend implementation**, featuring over 40+ polished screens, a custom glassmorphism design system, and a "Zero-Static" architecture ready for backend integration.

---

## ✨ Top-Tier Features

### 💎 Premium UI/UX
- **Glassmorphic Design**: Extensive use of BackdropFilters, subtle borders, and glowing gradients for a high-end tech aesthetic.
- **Micro-Animations**: Powered by `flutter_animate`, the app features smooth hero transitions, scaling effects, and interactive UI feedback.
- **Theme-Ready**: Built from the ground up with a flexible Dark Theme system (Background: `#0D0D14`).

### 🚀 Zero-Static Architecture
Unlike standard mockups, the UI is built to handle real data flow:
- **Shimmer States**: Every data-heavy widget includes custom shimmer skeletons for a premium loading experience.
- **Empty States**: Beautifully illustrated "No Data" screens with actionable call-to-actions.
- **Service Layer**: Pre-built boilerplate for Firebase Auth and Firestore integration.

### 📍 Smart Features
- **Location Engine**: Integrated location services (Geolocator) for dynamic area detection in headers and discovery maps.
- **Smart QR Tickets**: Custom-designed digital tickets with functional QR code generation.
- **Advanced Discovery**: Interactive map-based discovery with price-tag markers and multi-layered search filters.

---

## 🛠 Tech Stack

- **Framework**: Flutter (Material 3)
- **State Management**: `Provider` (Clean separation of UI and Logic)
- **Navigation**: `GoRouter` (Declarative, deep-link ready routing)
- **Style**: Google Fonts (Clash Display for Headings, DM Sans for Body)
- **Icons**: `Lucide Icons` for a modern, consistent look.
- **Persistence**: `SharedPreferences` for auth/onboarding state storage.

---

## 📁 Project Structure

```text
lib/
├── models/       # Type-safe Data Models (JSON serialized)
├── providers/    # App-state management (Auth, Events, Location)
├── routes/       # Centralized GoRouter configuration
├── services/     # Firebase/API Service layer
├── shared/       # Core Design System (Icons, Colors, Widgets)
└── screens/      # 40+ High-Fidelity Screens
```

---

## 🚦 Getting Started

### Prerequisites
- Flutter SDK (Channel Stable)
- Dart SDK

### Installation
1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

---

## 🎨 Branding
The app is fully branded as **EventSphere** with a custom-designed interconnected sphere logo, symbolizing the core mission of **Connecting. Experience. Remembering.**

---

Designed with ❤️ by **EventSphere Team**
