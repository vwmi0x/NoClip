local noClipEnabled = false
local noClipSpeed = 5.0
local maxNoClipSpeed = 20.0
local minNoClipSpeed = 1.0

function toggleNoClip()
    noClipEnabled = not noClipEnabled
    local playerPed = PlayerPedId()
    SetEntityInvincible(playerPed, noClipEnabled)
    SetEntityVisible(playerPed, not noClipEnabled, false)

    if noClipEnabled then
        print("No clip activé")
    else
        print("No clip désactivé")
    end
end

function handleNoClip()
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local camRot = GetGameplayCamRot(2)

    local forward = 0.0
    local right = 0.0
    local up = 0.0

    -- Déplacement
    if IsControlPressed(0, 33) then -- Z / Avancer
        forward = 1.0
    end
    if IsControlPressed(0, 34) then -- Q / Gauche
        right = -1.0
    end
    if IsControlPressed(0, 32) then -- S / Reculer
        forward = -1.0
    end
    if IsControlPressed(0, 35) then -- D / Droite
        right = 1.0
    end
    if IsControlPressed(0, 22) then -- ESPACE / Monter
        up = 1.0
    end
    if IsControlPressed(0, 21) then -- SHIFT gauche / Descendre
        up = -1.0
    end

    -- Ajustement de la vitesse avec la molette de la souris
    if IsControlJustPressed(0, 241) then -- Molette souris vers le haut
        noClipSpeed = math.min(maxNoClipSpeed, noClipSpeed + 1)
    end
    if IsControlJustPressed(0, 242) then -- Molette souris vers le bas
        noClipSpeed = math.max(minNoClipSpeed, noClipSpeed - 1)
    end

    local newPos = vector3(
            pos.x + right * noClipSpeed * math.cos(math.rad(camRot.z)) + forward * noClipSpeed * math.sin(math.rad(camRot.z)),
            pos.y + right * noClipSpeed * math.sin(math.rad(camRot.z)) - forward * noClipSpeed * math.cos(math.rad(camRot.z)),
            pos.z + up * noClipSpeed
    )

    SetEntityCoordsNoOffset(playerPed, newPos.x, newPos.y, newPos.z, true, true, true)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 49) then -- Correspond à la touche F de votre clavier
            toggleNoClip()
        end
        if noClipEnabled then
            handleNoClip()
        end
    end
end)
