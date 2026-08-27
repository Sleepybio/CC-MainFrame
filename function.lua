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

function find(devices, targetDevice)
    if not devices or targetDevice then return error("No table of devices or target device has been provided!") end
    for i=1, #devices do
        if targetDevice == devices[i].type then
            return devices[i].type
        end
    end
end

function findName(devices, targetDevice)
    if not devices or targetDevice then return error("No table of devices or target device has been provided!") end
    for i=1, #devices do
        if targetDevice == devices[i].name then
            return devices[i].name
        end
    end
end

function listen()
    local e={os.pullEvent()}
    print(e[1])
end

local config = {
    ["init"] = function ()
        -- retrieving the config settings
        local data
        if fs.exists("/.data/config") then
            local file = fs.open("/.data/config","r")
            data=textutils.unserialise(file.readAll())
            file.close()
        else
            data={}
            local file = fs.open("/.data/config","w")
            file.write(textutils.serialise(data))
            file.close()
        end
        return data
    end,

    ["append"] = function (data,newDB)
        -- Appending "data"
        if not data then return error("No Data to Append!") end
        local DB
        local file
        
        if not newDB then
            file = fs.open("/.data/config","r")
            DB = textutils.unserialise(file.readAll())
            file.close()

            table.insert(DB,data)
        else
            DB=data
        end

        file = fs.open("/.data/config","w")
        file.write(textutils.serialise(DB))
        file.close()

        return DB
    end
}

--User interface

local function clear()
    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)
end

local function prompt(prompt,color)
    if not prompt then return error("No Prompt has been given, arg #1!") end
    if color then
        term.setTextColor(color)
        term.write(prompt.." ")
        term.setTextColor(colors.white)
    else
        term.write(prompt.." ")
    end
    local input = read()
    return input
end

local function write(text,color)
    term.setTextColor(color)
    term.write(text)
    term.setTextColor(colors.white)
end

function drawUI()
    -- Draws User Interface #barebones rn
    local motd = {
        "Have a fun day ruling the world!",
        "Fucking Idiot....",
        "Nuclear warfare everywhere!"
        "Why did that break?"
    }

    clear()
    write(motd[math.random(1,#motd)],colors.yellow)
end

return { initPeripherals = initPeripherals, find = find, findName = findName, config = config, listen = listen, drawUI = drawUI}