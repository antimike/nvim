-- Functions to help organize correspondence between keybindings (what the user actually does) and functionality exposed by plugins
-- Keybindings consist of mappings from keys to **capabilities**, which are then mapped separately to **providers**, i.e., functions and/or commands provided by plugins


Capability = {
    new = function(self, tab)
        self = tab
        self.name = assert(self.name)
        self.providers = self.providers or {}
        return self
    end,
}
Plugin = {
    __index = Plugin,
}

function Plugin:new (props)
    local function setDefault (name, val)
        props[name] = props[name] or val
    end
    setDefault("opts", {})
    setDefault("capabilities", {})
    setmetatable(props, Plugin)
    return props
end

local function register_option(name, val)
    table[name] = val
end

table.insert(register, plugin.priority, plugin.capabilities)        -- Higher priority --> higher likelihood plugin is used
for c, t in pairs(plugin.capabilities) do
    register_provider(c, t)
end

-- Types of datastructures to support:
-- 1. "Keymaps": { n = { ["<leader>"] = { f = { _capabilities = navigate.search, b = "buffers" }}}}
-- 2. "Capability" maps: { explore = {...}, search = {...}}
function makeBindings(keymap, opts)
    local function bind_with_prefix(mode, prefix, rhs, map)
        for lhs, expr in pairs(map) do
            if type(expr) == "table" then
                bind_with_prefix()
    local opts = {noremap = true}
    for mode, map in pairs(keymap) do
        
    end
end


