# TubeForge

<div align="center">
  <img src="https://github.com/user-attachments/assets/86ba4b00-c1d6-4e87-8497-45f0cd15f3fb" alt="favicon" />
</div>

![Best](https://github.com/user-attachments/assets/a1cf3806-1fca-4b1d-bd4b-908dcfe7f839)

# YouTube Revive for iOS 7-10

## Project Overview
This project is my attempt to revive the outdated YouTube app on iOS 7-10 devices. Using the **Invidious API**, I’m injecting a locally hosted page into the YouTube client to bring it back to life. The goal is to replace old YouTube features with modern alternatives, without breaking your ancient iPhone. 🚀

### How It Works
- **Class Hooking**: I’m hooking into YouTube's classes, deleting them, and swapping them with localhost pages.
- **Localhost Pages**: These pages are fetched using a script called `tubeforge`. This script runs when YouTube launches and locates its bundle. During installation, a folder named `web` it contains HTML and PHP pages that will be displayed in the app.
- **Instance Selection**: Once installed and respringed , the tweak will allow you to select which Invidious instance to use (or you can host your own, but make sure the API is enabled).

### Requirements
- iOS 7-10 device
- **adv-cmds** (to install ps)
- **PHP**
- **Cephei**
- **Lighttpd**
- YouTube app (obviously)
  
### Installation
1. Add my repo to **Cydia**: `https://ahmadjerjawi.github.io`
2. Search for `tubeforge` and install.
3. Once installed, go to the app’s settings to configure the Invidious instances you want to use.

### Debugging
Good news, I haven’t removed the debugging lines, so you can still debug as you work with it! 🔧  
Also, instead of installing directly, you can **compile it from theos to  .deb** file if you prefer doing it that way.

### A Side Project
This project is something I’m doing on the weekends. Between school and everything else, it’s my hobby project—so don't expect it to be perfect. 😉


