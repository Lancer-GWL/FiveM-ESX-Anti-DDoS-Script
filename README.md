# FiveM-ESX-QBCore-Anti-DDoS-Script
A simple anti-DDoS protection script designed to prevent excessive connection attempts on FiveM servers. Supports both ESX and QBCore frameworks with a customizable option.

## Features
Limits connection attempts to 5 per second per IP

Temporarily bans IPs spamming connection requests

Supports ESX and QBCore frameworks

Easy to configure for your preferred framework

Periodic cleanup of connection attempt counters

## Installation
Place the fxmanifest.lua and server.lua files in a resource folder inside your FiveM server's resources directory.

Add start <resource-folder-name> to your server configuration file (server.cfg).

Restart your server or start the resource manually.

## Usage
The script automatically monitors player connection attempts upon startup.

## Framework Selection
In server.lua, set the framework variable to your server's framework:

lua
local framework = 'esx' -- or 'qbcore'
The script uses the native FiveM connection event, so it works with both frameworks seamlessly. Framework-specific adjustments can be added in the configuration section.

If an IP exceeds 5 connection attempts within one second, it will be temporarily banned until the script resets the counters.

## Configuration
Adjust these parameters in server.lua:

maxConnectionsPerSec — maximum allowed connections per IP per second (default: 5)

resetInterval — interval in milliseconds to reset connection counts (default: 1000 ms)

framework — set to 'esx' or 'qbcore' depending on your server setup

## How it works
On player connect, the script fetches the player's IP.

It tracks connection attempts within the last second.

IPs with excessive rapid connections are banned temporarily.

Counters reset every 30 seconds automatically.


## 📜 License
This resource is released for public and educational use under the MIT license. Attribution to Lancer is appreciated. Do not resell or repackage without permission.

## 📞 Support
💬 Discord: https://discord.gg/fbxZaRBjHh
