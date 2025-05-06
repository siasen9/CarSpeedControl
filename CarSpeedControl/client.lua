local function GetSpeedInKmh(speed)
    return speed * 3.6
end

local function GetVehicleModelName(vehicle)
    return GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped, false)

            if GetPedInVehicleSeat(veh, -1) == ped then -- Nur Fahrer
                local model = GetVehicleModelName(veh)
                local maxSpeed = SpeedLimiterConfig.Vehicles[model]

                if maxSpeed then
                    local currentSpeed = GetSpeedInKmh(GetEntitySpeed(veh))
                    if currentSpeed > maxSpeed then
                        -- Reduziere Geschwindigkeit (bremsen)
                        local newSpeed = maxSpeed / 3.6 -- m/s
                        SetVehicleForwardSpeed(veh, newSpeed)
                    end
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped, false)
            local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
            print("Fahrzeug-Spawnname: " .. model)
        end
    end
end)



-- Debug Funktion 

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(2000)
--         local ped = PlayerPedId()
--         if IsPedInAnyVehicle(ped, false) then
--             local veh = GetVehiclePedIsIn(ped, false)
--             local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
--             print("Fahrzeug-Spawnname: " .. model)
--         end
--     end
-- end)
