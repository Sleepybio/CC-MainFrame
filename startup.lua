local files = {
    {
        ["filenames"] = "main.lua",
        ["link"] = ""
    }
}

for i=1, files do
    print(string.format("%s is being updated!", files[i].filename))
    local data = http.get(files[i].link)

    local oldData
    local newData

    if fs.exists(files[i].filename) then
        oldinfo = fs.open(files[i].filename)
        oldData = oldinfo.readAll()
        oldinfo.close()
    else
        oldinfo = nil
    end

    newData = data.readAll()

    newinfo = fs.open(files[i].filename)
    newinfo.write(newdata)
    newinfo.close()

    if oldData == newData then
        print("No Changes Were Made.")
    elseif oldData ~= nil then
        local newBytes = (#newData-#oldData)
        print(string.format("Total Bytes Added: %s", newBytes))
    else
        print("New File Added!")
    end
end

shell.run(files[1].filename)