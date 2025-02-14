<div align="center">
  <img src="https://github.com/user-attachments/assets/86ba4b00-c1d6-4e87-8497-45f0cd15f3fb" alt="favicon" />
</div>

![Best](https://github.com/user-attachments/assets/a1cf3806-1fca-4b1d-bd4b-908dcfe7f839)

# TubeForge - YouTube Revive for iOS 7-10
**Note:**
Due to the emergence of a better solution that utilizes proxying instead of a custom GUI, this project might not meet current expectations. Consider exploring more recent alternatives if you're looking to revive legacy YouTube functionality on older iOS devices.

**Overview:**
TubeForge was designed to revive the outdated YouTube app on iOS 7-10 devices by leveraging the Invidious API. The approach involves:

- **Class Hooking:** Intercepting YouTube's native classes and replacing them with locally hosted HTML/PHP pages.
- **Localhost Pages:** Utilizing the `tubeforge` script to load and display modern web pages inside the YouTube app.
- **Instance Selection:** Allowing users to choose an Invidious instance (local or public) for fetching content.

**Current Status:**
- The project is **not maintained** and is likely **not working properly**.
- While improvements were being developed, a better alternative was released that opts for proxying the content instead of creating a new GUI—this new method is generally considered superior.
- For further discussions and alternatives, check out the [r/legacyjailbreak](https://www.reddit.com/r/legacyjailbreak) subreddit.

**Installation (when it was active):**
1. **Repository Addition:** Add the repo to Cydia: `https://repo.ahmadjerjawi.github.io`
2. **Package Installation:** Search for and install `tubeforge`.
3. **Configuration:** After installation and a respring, configure your desired Invidious instance through the tweak’s settings.

**Requirements:**
- iOS 7-10 device
- YouTube App (compatible version)
- **adv-cmds** (for installing utilities like `ps`)
- PHP
- Cephei framework
- Lighttpd
- An operational Invidious instance (local or public)


