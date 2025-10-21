# FiveM-ESX-Anti-DDoS-Script
A simple anti-DDoS protection script designed to work with any ESX-based FiveM server. It limits the number of connection attempts per second from a single IP address and temporarily bans IPs that exceed the threshold.

# Features
Limits connection attempts to 5 per second per IP

-Temporarily bans IPs spamming connection requests

-Easy integration with ESX servers

-Periodic cleanup of connection attempt counters

# Installation
-Place the fxmanifest.lua and server.lua files in a new resource folder inside your FiveM server's resources directory.

-Add start <resource-folder-name> to your server configuration file (server.cfg).

-Restart your server or start the resource manually.

# Usage
The script automatically activates and monitors player connection attempts upon startup. No additional configuration is needed by default.

If an IP exceeds 5 connection attempts within one second, it will be banned temporarily from connecting until the script resets the counters.

# Configuration
You can adjust the following parameters in server.lua:

maxConnectionsPerSec — maximum allowed connections per IP per second (default: 5)

resetInterval — interval in milliseconds to reset connection counts (default: 1000 ms)

# How it works
When a player tries to connect, the script checks the player's IP.

It tracks the number of connect attempts in the last second.

If exceeded, the IP is banned and denied further connections temporarily.

The script clears all connection attempts every 30 seconds automatically.


## 📜 License
This resource is released for public and educational use under the MIT license. Attribution to Lancer is appreciated. Do not resell or repackage without permission.

## 📞 Support
💬 Discord: https://discord.gg/fbxZaRBjHh
