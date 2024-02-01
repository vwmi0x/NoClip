local noClipEnabled = false

function toggleNoClip()
    noClipEnabled = not noClipEnabled
    SetEntityInvincible(PlayerPedId(), noClipEnabled)
    SetEntityVisible(PlayerPedId(), not noClipEnabled, false)

    if noClipEnabled then
        print("No clip activé")
    else
        print("No clip désactivé")
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 49) then -- correspond a la touche F de ton clavier
            toggleNoClip()
        end
    end
end)