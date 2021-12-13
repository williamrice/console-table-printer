

ConsoleTablePrinter = {}

local ConsoleTablePrinter_mt = Class(ConsoleTablePrinter)

addModEventListener(ConsoleTablePrinter)

function ConsoleTablePrinter:new()
    self.baseTable = g_currentMission -- current mission as default because it's most common
    self.depth = 1 -- default depth as 1 incase you forget to set it
    self.baseTablePool = {
        ["g_currentMission"] = g_currentMission,
        ["g_gui"] = g_gui
    }
    self.depthPool = {
        ["1"] = 1,
        ["2"] = 2,
        ["3"] = 3
    }
end

function ConsoleTablePrinter:loadMap()
    ConsoleTablePrinter:new()
    addConsoleCommand('setBaseTable', 'Sets the base table', 'setBaseTable', self )
    addConsoleCommand('setDepth', 'Sets the depth for the print recursively', 'setDepth', self)
    addConsoleCommand('printTable', 'Prints table inside base table', 'printTable', self)
end

function ConsoleTablePrinter:printTable(args)
    print("!!!!!!!!!!!!!" .. tostring(self.baseTable)) -- debug only

    local argTable = {}
    local printTable = {}

    if args == nil then
        DebugUtil.printTableRecursively(self.baseTable, "-", 0 , self.depth)
        return 
    end

    for word in string.gmatch(args, '([^.]+)') do
        table.insert(argTable, word)
    end

    for i, v in ipairs(argTable) do 
        print("i is : " .. tostring(i) .. " ::: " .. "v is " .. v) -- debug
        if i == 1 then
            printTable = self.baseTable[v]
        end
        if i == 2 then
            printTable = printTable[v]
        end
        if i == 3 then
            printTable = printTable[v]
        end
        if i == 4 then
            printTable = printTable[v]
        end
        if i == 5 then
            printTable = printTable[v]
        end
    end
    
    DebugUtil.printTableRecursively(printTable, "-", 0 , self.depth)
end

function ConsoleTablePrinter:setBaseTable(args)
    self.baseTable = self.baseTablePool[args]
    print("Print table set to " .. args) 
end

function ConsoleTablePrinter:setDepth(args)
    self.depth = self.depthPool[args]
    print("Depth set to " .. tostring(self.depth)) 
end