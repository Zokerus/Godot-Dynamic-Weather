# Godot Dynamic Weather

A modular, dynamic weather and sky system for **Godot 4.4** – customizable, extensible, and optimized for real-time use.  
This addon provides a flexible **day/night cycle**, editor integration, and runtime debugging tools.

---

## ✨ Features (Phase 1)

- Day/Night cycle with configurable `seconds_per_day`
- Adjustable sunrise/sunset hours and max sun altitude
- Automatic sun binding (via Inspector or group `"Sun"`)
- Public API for time control and signals
- Editor Dock for interactive control in the Godot editor
- In-game Debug Overlay (toggle via **F10**)
- Demo scene with WeatherManager integration

---

## 📦 Installation

1. Copy the folder `addons/godot_dynamic_weather/` into your project.  
2. In Godot, go to **Project → Project Settings → Plugins** and enable  
   **Godot Dynamic Weather**.  
3. The editor dock will appear on the right: 🌤 *Weather Manager*.  

---

## 🚀 Quickstart

1. Add a `WeatherManager.tscn` node to your scene.  
   - Or add a `Node3D` and attach `WeatherManager.gd`.  
   - Assign a `DirectionalLight3D` as **Sun** or add the light to group `"Sun"`.  
2. (Optional) Add `WeatherOverlay.tscn` to your scene for in-game debugging.  
3. Press **Play**: the sun moves according to the day/night cycle.  

---

## 🛠 API Overview

### Properties
- `time_of_day: float` – current time in hours (0.0–24.0)  
- `seconds_per_day: float` – length of one in-game day in real seconds  
- `sunrise_hour: float` – sunrise time (default: 6.0)  
- `sunset_hour: float` – sunset time (default: 18.0)  
- `max_altitude: float` – max sun angle at noon (default: 60°)  
- `auto_advance: bool` – if true, time runs automatically  

### Methods
- `setTimeOfDay(value: float)` – jump to a given time  
- `setTimescale(day_length_seconds: float)` – change day length  
- `pause()` / `resume()` – stop/resume time progression  
- `jump_to(event: String)` – jump to `"sunrise"`, `"noon"`, `"sunset"`, `"midnight"`  

### Signals
- `time_changed(time: float)` – emitted whenever time updates  
- `sunrise` / `sunset` – emitted at configured times  

---

## 🧪 Demo

A demo scene is included to test:  
- Editor Dock interaction (slider, toggle, buttons)  
- In-game Debug Overlay (**F10**)  
- Time jump buttons (Sunrise, Noon, Sunset, Midnight)  

---

## 📖 Roadmap

- **Phase 1**: Foundation (done ✅)  
- **Phase 2**: Atmosphere & Stars  
- **Phase 3**: Moon phases  
- **Phase 4**: Clouds  
- **Phase 5**: Rain & Snow  
- **Phase 6**: Wind  
- **Phase 7**: Thunderstorms  
- **Phase 8**: Presets & Release  

---

## 📜 License

MIT License – free to use, modify, and distribute.  