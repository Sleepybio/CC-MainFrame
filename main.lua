-- Importing Functionalities
local utils = require("function")
local config = utils.config
local DB = config.init()

local running = true

-- Main Loop --

while running do
    -- Main handling Functionality
    local x=parallel.waitForAny(utils.listen,utils.drawUI)
    print(x)
end