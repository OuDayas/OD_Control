--[[

   ____            _____                                     _____                   _                    _ 
  / __ \          |  __ \                                   / ____|                 | |                  | |
 | |  | |  _   _  | |  | |   __ _   _   _    __ _   ___    | |        ___    _ __   | |_   _ __    ___   | |
 | |  | | | | | | | |  | |  / _` | | | | |  / _` | / __|   | |       / _ \  | '_ \  | __| | '__|  / _ \  | |
 | |__| | | |_| | | |__| | | (_| | | |_| | | (_| | \__ \   | |____  | (_) | | | | | | |_  | |    | (_) | | |
  \____/   \__,_| |_____/   \__,_|  \__, |  \__,_| |___/    \_____|  \___/  |_| |_|  \__| |_|     \___/  |_|
                                     __/ |                                                                  
                                    |___/      __    __        ___                                          
                                       \ \    / /   /_ |      / _ \                                         
                                        \ \  / /     | |     | | | |                                        
                                         \ \/ /      | |     | | | |                                        
                                          \  /       | |  _  | |_| |                                        
                                           \/        |_| (_)  \___/                                         
                                                                                                            
                                                                                                            

]]

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

Config = {}



Config.Debug = false

Config.Peds = 
{
    Frequency =
    {
        peds = 1.0,
        vehicles =
        {
            traffic = 0.75,
            parked  = 0.75
        }
    },
    --Se gli npc alla morte droppano le loro armi
    Drops =
    {
        weapons = false -- false = drop disabled / true = drop enabled
    },
    -- Elimina tutti gli npc nella lista in un certo range
    Removing =
    {
        enabled = true,
        range = 500.0, -- 400.0/500.0 ok
        list =
        {
            
            --[[ esempio
            {
                hashed = true,
                hashkey = "-681004504"
            },
            {
                hashed = false,
                name = "a_m_m_hillbilly_01"
            }
            --]]
        }
    }
}
Config.Vehicles =
{
    WindowsControl =
    {
        enabled = true,
        RollUPKey = Keys["TOP"],
        RollDOWNKey = Keys["DOWN"]
    },
    IndicatorLights =
    {
        enabled = true,
        IndicateLeft = Keys["LEFT"],
        IndicateRight = Keys["RIGHT"],
    },
    Removing =
    {
        enabled = true,
        range = 0.0,
        list =
        {
            -- vehicle name:
            -- es: "rumpo", "rumpo2"
        },
        CopVeh =
        {
            enabled = true,
            range = 400.0 --400.0/500.0 ok
        }
    },
    dispatch =
    {
        -- true = dispatch disabled / false = dispatch enabled
        [1]  = { active = false },
        [2]  = { active = false },
        [3]  = { active = false },
        [4]  = { active = false },
        [5]  = { active = false },
        [6]  = { active = false },
        [7]  = { active = false },
        [8]  = { active = false },
        [9]  = { active = false },
        [10] = { active = false },
        [11] = { active = false },
        [12] = { active = false },
        [13] = { active = false },
        [14] = { active = false },
        [15] = { active = false },
        [16] = { active = false },
        --[[ Dispatch types:
            1  = DT_Invalid,
            2  = DT_PoliceAutomobile,
            3  = DT_PoliceHelicopter,
            4  = DT_FireDepartment,
            5  = DT_SwatAutomobile,
            6  = DT_AmbulanceDepartment,
            7  = DT_PoliceRiders,
            8  = DT_PoliceVehicleRequest,
            9  = DT_PoliceRoadBlock,
            10 = DT_PoliceAutomobileWaitPulledOver,
            11 = DT_PoliceAutomobileWaitCruising,
            12 = DT_Gangs,
            13 = DT_SwatHelicopter,
            14 = DT_PoliceBoat,
            15 = DT_ArmyVehicle,
            16 = DT_BikerBackup ]]
    }
}

Config.Weapons =
{
    Removing =
    {
        --  Rimuove le armi selezionate quando si esce da un veicolo della polizia
        CopsVehicle =
        {
            enabled = true,
            list =
            {
                487013001,--0x1D073A89, -- ShotGun
                0x83BF0278, -- Carbine
                0x5FC3C11,  -- Sniper
            }
        },
        general =
        {
            -- se abilitato qualsiasi giocatore che ha un'arma presente nella lista verrà automaticamente eliminata
            enabled = true,
            list =
            {
                -- weapon hash:
                -- ex: -1716189206, 487013001
            }
        }
    }
}

--[[
    Weapon hashes:
    https://wiki.gtanet.work/index.php?title=Weapons_Models
    https://gtahash.ru/weapons/?page=2
    ex:
    487013001   = shotgun
    0x1D073A89  = ShotGun

    FiveM NPC ped list:
    https://docs.fivem.net/docs/game-references/ped-models/
    https://wiki.gtanet.work/index.php?title=Peds
]]