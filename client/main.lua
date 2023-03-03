local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local OD_PData = {}
OuDayas = nil
Citizen.CreateThread(function()
	while OuDayas == nil do
		TriggerEvent('OuDayasLIB:OuDayasgetSharedObject', function(oudayasobj)
			OuDayas = oudayasobj
		end)
		Citizen.Wait(1)
	end
	while OuDayas.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	OD_PData = OuDayas.GetPlayerData()
end)
RegisterNetEvent('OuDayasLIB:setJob')
AddEventHandler('OuDayasLIB:setJob', function(job)
	OD_PData.job = job
	Citizen.Wait(5000)
end)


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function table.empty (self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

local Charset = {}

-- numeri
--for i = 48,  57 do table.insert(Charset, string.char(i)) end
-- lettere maiuscole
--for i = 65,  90 do table.insert(Charset, string.char(i)) end
-- lettere minuscole
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomString(length)
	math.randomseed(GetGameTimer())

	if length > 0 then
		return GetRandomString(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

Citizen.CreateThread(function()
	if Config.Debug then
		print("OD_Control: Debug on")
	end
	local RemovePedList	 	= Config.Peds.Removing.list
	local RemoveVehList 	= Config.Vehicles.Removing.list
	local RemoveWeaponList 	= Config.Weapons.Removing.general.list
	local listdispatch 		= Config.Vehicles.dispatch
	if Config.Vehicles.Removing.enabled == true then
		if not table.empty(RemoveVehList) then
			if Config.Debug then
				print("[OD_Control - Remove vehicles]: state: on")
			end
			OuDayas.SetRemoveVehicle(Config.Vehicles.Removing.enabled)
			OuDayas.RemoveVehicleInArea(RemoveVehList)
			if Config.Debug then
				for k,v in ipairs(RemoveVehList) do
					print("Veicolo da rimuovere: " .. RemoveVehList[k])
				end
			end
		else
			if Config.Debug then
				print("[OD_Control - Removing vehicles]: setting disabled - reason: list empty")
			end
			OuDayas.SetRemoveVehicle(false)
		end
	end
	Citizen.Wait(500)
	if Config.Weapons.Removing.general.enabled == true then
		if not table.empty(RemoveWeaponList) then
			OuDayas.SetRemoveWeaponFromPlayers(true)
			OuDayas.RemoveWeaponFromPlayer(RemoveWeaponList)
			if Config.Debug then
				for _,v in ipairs(RemoveWeaponList) do
					print("armi da rimuovere: " .. v)
				end
			end
		elseif table.empty(RemoveWeaponList) then
			if Config.Debug then
				print("[OD_Control - Removing general weapons] setting: disabled - reason: table empty")
			end
			OuDayas.SetRemoveVehicle(false)
		end
	end
	Citizen.Wait(500)
	if Config.Vehicles.Removing.CopVeh.enabled == true then
		if Config.Debug then
			print("[OD_Control - Removing cops and cops vehicles]: state: true")
		end
		OuDayas.RemoveCopsVeh(
			Config.Vehicles.Removing.CopVeh.enabled,
			Config.Vehicles.Removing.CopVeh.range )
	elseif Config.Vehicles.Removing.CopVeh.enabled == false then
		if Config.Debug then
			print("[OD_Control - Removing cops and cops vehicles]: state: false")
		end
		OuDayas.RemoveCopsVeh(
			Config.Vehicles.Removing.CopVeh.enabled,
			Config.Vehicles.Removing.CopVeh.range )
	end
	Citizen.Wait(500)
	OuDayas.SetPedDensity(Config.Peds.Frequency.peds, Config.Peds.Frequency.vehicles.traffic, Config.Peds.Frequency.vehicles.parked )
	OuDayas.NPCDropWeapons(Config.Peds.Drops.weapons)
	Citizen.Wait(500)
	
	if not table.empty(listdispatch) then
		OuDayas.DispatchService(listdispatch)
		if Config.Debug then
			print("[OD_Control - dispatch services]: Setting now")
			for k, v in pairs(listdispatch) do
				print("Dispatch: " .. k .. " = " .. tostring(listdispatch[k].active) )
			end
		end
	end
	Citizen.Wait(500)
	if Config.Peds.Removing.enabled == true then
		if not table.empty(RemovePedList) then
			if Config.Debug then
				print("[OD_Control - remove peds in area]: state: true")
			end
			OuDayas.SetRemoveNPCInArea(true)
			OuDayas.RemoveNPCInArea(RemovePedList, Config.Peds.Removing.range)
		elseif table.empty(RemovePedList) then
			if Config.Debug then
				print("[OD_Control - remove peds in area]: setting to false - reason: table empty")
			end
			OuDayas.SetRemoveNPCInArea(false)
		end
	elseif Config.Peds.Removing.enabled == false then
		OuDayas.SetRemoveNPCInArea(false)
	end


end)
-- Removing weapon system

local hasBeenInPoliceVehicle = false

local alreadyHaveWeapon = {}

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(100)
		if Config.Weapons.Removing.CopsVehicle.enabled then
			if(IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
				if(not hasBeenInPoliceVehicle) then
					hasBeenInPoliceVehicle = true
				end
			else
				if(hasBeenInPoliceVehicle) then
					for i,k in pairs(Config.Weapons.Removing.CopsVehicle.list) do
						if(not alreadyHaveWeapon[i]) then
							TriggerServerEvent("OD_Control:CopsWeaponaskDropWeapon", k)
						end
					end
					hasBeenInPoliceVehicle = false
				end
			end
		end
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if Config.Weapons.Removing.CopsVehicle.enabled then
			if(not IsPedInAnyVehicle(GetPlayerPed(-1))) then
				for i=1,#Config.Weapons.Removing.CopsVehicle.list do
					if(HasPedGotWeapon(GetPlayerPed(-1), Config.Weapons.Removing.CopsVehicle.list[i], false)==1) then
						alreadyHaveWeapon[i] = true
					else
						alreadyHaveWeapon[i] = false
					end
				end
			end
			Citizen.Wait(5000)
		end
	end

end)
RegisterNetEvent("OD_Control:copsweapondrop")
AddEventHandler("OD_Control:copsweapondrop", function(wea)
	RemoveWeaponFromPed(GetPlayerPed(-1), wea)
end)

if Config.Vehicles.WindowsControl.enabled then
	Citizen.CreateThread( function()
		while true do
			Citizen.Wait(5)
			local PlayerPed = GetPlayerPed( -1 )
			local vehicle = GetVehiclePedIsIn( GetPlayerPed( -1 ), false )
			if IsPedInAnyVehicle( GetPlayerPed( -1 ), false ) then
				if IsControlJustPressed( 1, 27--[[Keys["TOP"] ]] ) then
				for id = -1, 6 do
					if GetPedInVehicleSeat(vehicle, id) == PlayerPed then
						OuDayas.VehWindowsState(GetPlayerPed(-1), id+1, false)
					end
				end
				elseif IsControlJustPressed( 1, 173 --[[Keys["DOWN"] ]] ) then
					for id = -1, 6 do
						if GetPedInVehicleSeat(vehicle, id) == PlayerPed then
							OuDayas.VehWindowsState(GetPlayerPed(-1), id+1, true)
						end
					end
				end
			end
		end
	end)
end
if Config.Vehicles.IndicatorLights.enabled then
	local vehicleState = {
		indicator = {
		  left = false,
		  right = false
		}
	}
	Citizen.CreateThread( function()
		while true do
			Citizen.Wait(10)
			if IsPedInAnyVehicle( GetPlayerPed( -1 ), false ) then
			local pressedLeft  = IsControlJustPressed( 1, Config.Vehicles.IndicatorLights.IndicateLeft ) or false
			local pressedRight = IsControlJustPressed( 1, Config.Vehicles.IndicatorLights.IndicateRight ) or false
				if pressedLeft or pressedRight then
					local vehicle = GetVehiclePedIsIn( GetPlayerPed( -1 ), false )
					if GetPedInVehicleSeat( vehicle, - 1 ) == GetPlayerPed( -1 ) then
						if pressedLeft then
							vehicleState.indicator.left = not vehicleState.indicator.left
							TriggerServerEvent( "OuDayasLIB:SetVehicleIndicator", 1, vehicleState.indicator.left )
						end
						if pressedRight then
							vehicleState.indicator.right = not vehicleState.indicator.right
							TriggerServerEvent( "OuDayasLIB:SetVehicleIndicator", 0, vehicleState.indicator.right )
						end
					end
				end
			end
		end
	end)
end
