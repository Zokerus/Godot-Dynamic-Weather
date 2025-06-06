# 🌦️ Dynamic Weather Addon for Godot 4.4

A modular, extensible dynamic weather and sky system for **Godot Engine 4.4**.  
Designed to simulate realistic day/night cycles, weather transitions, and atmospheric effects for real-time applications and games.

---

## ✨ Features (planned)

- ⛅ Fully dynamic day/night system
- 🌧️ Real-time weather transitions (rain, snow, fog, storms)
- ⚡ Lightning & thunder effects
- 🌤️ Animated cloud layers (2D & volumetric fakes)
- 🧪 Wet surface simulation via material shader
- 🕹️ GDScript API and (optional) Editor tools
- 💡 Easily integratable into any 3D Godot project

---

## 🗺️ Roadmap

See the [GitHub Projects tab](https://github.com/users/Zokerus/projects/6) for detailed tasks and progress.

---

## 🚀 Getting Started

This addon is in early development. For now, clone the repo into your Godot project’s `addons/` directory:

```bash
git clone https://github.com/Zokerus/Godot-Dynamic-Weather addons/dynamic_weather

## 📁 Projektstruktur

res://
├── addons/
│   └── godot_dynamic_weather/       # Hauptverzeichnis des Plugins
│       ├── plugin.cfg               # Plugin-Definition für Godot
│       ├── dynamic_weather.gd       # Zentrales Plugin-Skript (Autoload oder Einstiegspunkt)
│       ├── weather_manager.tscn     # Wetterkontroll-Node mit Referenz zur Sonne
│       └── weather_manager.gd       # Kontrollskript
├── demo/
│   └── demo_scene.tscn              # Testszene zur Demonstration des Addons
├── LICENSE                          # MIT-Lizenz
└── README.md                        # Projektbeschreibung und Anleitung
