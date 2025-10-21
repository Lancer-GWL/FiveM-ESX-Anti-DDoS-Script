-- Config: Choose your framework here ('esx' or 'qbcore')
local framework = 'esx'

local connectionAttempts = {}
local maxConnectionsPerSec = 5 -- Allow 5 joins per second
local resetInterval = 1000 -- 1 second
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

        -- Additional framework-specific integration can go here
        if framework == 'esx' then
            -- ESX specific code if needed
        elseif framework == 'qbcore' then
            -- QBCore specific code if needed
        end
    end

    deferrals.done()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000) -- Clear connection attempts every 30 seconds
        connectionAttempts = {}
    end
end)

print("[Anti-DDoS] Script loaded successfully for framework: " .. framework)
