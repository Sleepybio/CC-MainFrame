function initPeripherals()
    local peripherals = peripheral.getNames()
    local devices = {}
    for i=1, #peripherals do
        local type = peripheral.getType(peripherals[i])

        if type == "modem" then
            local isWireless = peripheral.wrap(peripherals[i]).isWireless()
            table.insert(devices, { ["name"] = peripherals[i], ["type"] = type, ["isWireless"] = isWireless })
        else
            table.insert(devices, { ["name"] = peripherals[i], ["type"] = type })
        end
    end

    return devices
end

return { initPeripherals = initperipherals }