-- Simple FiveM Anti-DDoS Script
-- Works with any ESX-based server

local connectionAttempts = {}
local maxConnectionsPerSec = 5    -- Allow 5 joins per second
local resetInterval = 1000        -- 1 second
local bannedIPs = {}

function banIP(ip)
    bannedIPs[ip] = true
    print("[Anti-DDoS] IP banned: " .. ip)
end

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    local src = source
    deferrals.defer()

    local ip = GetPlayerEndpoint(src)
    if ip then
        if bannedIPs[ip] then
            deferrals.done("Your IP has been temporarily banned for excessive connection attempts.")
            CancelEvent()
            return
        end

        local now = os.time()
        connectionAttempts[ip] = connectionAttempts[ip] or {count = 0, last = now}

        if now - connectionAttempts[ip].last <= 1 then
            connectionAttempts[ip].count = connectionAttempts[ip].count + 1
        else
            connectionAttempts[ip].count = 1
            connectionAttempts[ip].last = now
        end

        if connectionAttempts[ip].count > maxConnectionsPerSec then
            print("[Anti-DDoS] Rapid connection detected from " .. ip)
            banIP(ip)
            deferrals.done("Too many connection attempts! Please try again later.")
            CancelEvent()
            return
        end
    end
    deferrals.done()
end)

-- Optional cleanup every few seconds
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        connectionAttempts = {}
    end
end)

print("[Anti-DDoS] Script loaded successfully.")
