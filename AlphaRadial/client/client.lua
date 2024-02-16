local menuOn = false

-------------------AlphaEnFolie ----------------------------------

local keybindControls = {
	["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166
}

local ouvert = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local keybindControl = keybindControls["F5"] -- Touche du Menu [F5]
        if IsControlPressed(0, keybindControl) then

            menuOn = true -- Menu = True [laissez sur true [lol]]
            SendNUIMessage({
                type = 'init',
                resourceName = GetCurrentResourceName()
            })
            
            SetCursorLocation(0.5, 0.5) -- Position de la souris à l'ouverture
            SetNuiFocus(true, true)  -- Souris
           -- SetNuiFocusKeepInput(true) -- Bouger avec là souris

            PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1) -- Bruit quand tu ouvre le menu

            IsDisabledControlJustPressed(0, 55)
            IsDisabledControlJustPressed(0, 76)
            IsDisabledControlJustPressed(0, 102)
            IsDisabledControlJustPressed(0, 143)
            IsDisabledControlJustPressed(0, 142)
            ClearPedSecondaryTask(PlayerPedId())

            while menuOn == true do Citizen.Wait(100) end
            Citizen.Wait(100)
            while IsControlPressed(0, keybindControl) do Citizen.Wait(100) end
            
        end
    end
end)

RegisterNUICallback('closemenu', function(data, cb)  -- Menu Fermer
    menuOn = false  -- Menu = False [laissez sur false [lol]]
    SetNuiFocus(false, false) -- Souris
    SetNuiFocusKeepInput(false) -- Bouger avec là souris
    DisableAllControlActions(0)
    ClearPedSecondaryTask(PlayerPedId())
    SendNUIMessage({
        type = 'destroy'
    })
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1) --Bruit quand tu ferme le menu
    cb('ok')
end)

RegisterNUICallback('openmenu', function(data) -- Menu Ouvert
    menuOn = false -- Menu = False [laissez sur false [lol]]
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    ClearPedSecondaryTask(PlayerPedId())
    SendNUIMessage({
        type = 'destroy'
    })

    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    if data.id == 'settings' then
        ClearPedSecondaryTask(PlayerPedId())
        ExecuteCommand("car jsred") -- ExecuteCommand

    elseif data.id == 'carte' then
        ClearPedSecondaryTask(PlayerPedId())
        print('By AlphaEnFolie')
        -- TriggerServerEvent(djfkjf) -- Event

    elseif data.id == 'aide' then
        ClearPedSecondaryTask(PlayerPedId())
        ExempleAlpha() -- Function

    end

end)

Citizen.CreateThread(function()
    while true do 
        local poids = 75
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin.bags_1 == 96 or skin.bags_1 == 95 or skin.bags_1 == 92 or skin.bags_1 == 91 or skin.bags_1 == 55 or skin.bags_1 == 54 or skin.bags_1 == 51 or skin.bags_1 == 50 or skin.bags_1 == 11 or skin.bags_1 == 9 then 
                poids = 125
            end
        end)

        TriggerServerEvent("BackUtils:setWeight", poids)

        Citizen.Wait(5000)
    end
end)

function ExempleAlpha()

    local ModelHash = `adder` -- Modele
    if not IsModelInCdimage(ModelHash) then return end
    RequestModel(ModelHash) -- Demander le modèle
    while not HasModelLoaded(ModelHash) do -- Attend que le modèle se charge
      Wait(0)
    end
    local MyPed = PlayerPedId()
    local Vehicle = CreateVehicle(ModelHash, GetEntityCoords(MyPed), GetEntityHeading(MyPed), true, false) -- Crée un véhicle sur votre postion
    SetModelAsNoLongerNeeded(ModelHash) -- supprime le modèle de la mémoire du jeu car nous n'en avons plus besoin

end