local pkg = {}
local utils = require("utils")

local objs = {
	types = {
		block = { "b" },
		call = { "x" },
		class = { "C" },
		comment = { "c" },
		conditional = { "i" },
		frame = { "F" },
		["function"] = { "f" },
		loop = { "l" },
		parameter = { "a" },
		scopename = { "P", outer = false },
		statement = { "S" },
	},
	scopes = {
		inner = "i",
		outer = "a",
	},
	mnemonics = {
		block = "_b_lock",
		call = "e_x_ecute",
		class = "_C_lass",
		comment = "_c_omment",
		conditional = "_i_f",
		frame = "_F_rame",
		["function"] = "_f_unction",
		loop = "_l_oop",
		parameter = "_a_rgument",
		scopename = "_P_ackage",
		statement = "_S_tatement",
	},
}

-- Assemble complete queries and corresponding keybinds with English descriptions
objs.queries, objs.descriptions = {}, {}
local query
for name, info in pairs(objs.types) do
	for scope, keymod in pairs(objs.scopes) do
		if info[scope] ~= false then
			-- TODO: Add uniqueness check / implement multiple keybinds
			query = "@" .. name .. "." .. scope
			objs.queries[query] = keymod .. info[1]
			objs.descriptions[query] = objs.mnemonics[name] .. " (" .. scope .. ")"
		end
	end
end

local actions = {
	modes = {
		select = {"v", "o"},
		swap = {"v", "n"},
		["goto"] = {"v", "o"},
		peek_definition = {"n"},
	},
	select = "",
	["goto"] = {
                next = "]",
                previous = "[",
	},
	types = {
		select = "",
		["goto"] = {
			next = {
				"]",
				start = "",
				["end"] = string.upper,
			},
			previous = {
				"[",
				start = string.upper,
				["end"] = "",
			},
		},
		swap = {
			"gx",
			previous = string.upper,
			next = "",
		},
		peek_definition = {
			"gd",
		},
	},
	descriptions = {
		select = "Select",
		["goto"] = "GOTO",
		swap = "Swap",
		peek_definition = "Peek defn:",
		next = "next",
		previous = "previous",
	},
	keys = {
		select = "",
		["goto"] = {
			next = "]",
			previous = "[",
		},
		swap = {},
	},
}


local function document_action(prefixes, description, content)
        local new_prefixes, children = {}, {}
        if type(content) ~= "table" then
                for prefix in prefixes do
                        wk.register({
                                [prefix .. tostring(content)] = description
                        })
                end
        else
                for k, v in pairs(content) do
                        if type(k) == "number" then
                                table.insert(newprefixes, prefix .. v)
                        else
                end
        end
        for name, key in pairs(children) do
                if type(name) == "number" then
                        wk.register({
                                [key] = {name = descriptions[action],}
                        }, {prefix = prefix})
                else
                end
        end
        for verb, children in pairs(action) do
                if type(verb) == "number" then
                        wk_tree[children] = {description}

                end
        end
end
-- PLAN: DFS through actions tree, yielding the full path when we reach a leaf
-- Preprocess obj tree with another DFS to assemble { obj = { desc, binds } table
-- Helper fns:
--      - Check if bind is already taken
--      - Capitalize description
-- Need to construct:
--      - Table of hierarchical descriptions for each mode
--      - Tables to pass to TS config

textobjects_select = {
	["@function.outer"] = "Function (outer)",
	["@function.inner"] = "Function (inner)",
	["@class.outer"] = "Class (outer)",
	["@class.inner"] = "Class (inner)",
	["@parameter.inner"] = "Param (inner)",
	["@parameter.outer"] = "Param (outer)",
	_modes = { "v", "o" },
}

textobjects_goto_next_start = {
	["@function.outer"] = "GOTO next function (start)",
	["@class.outer"] = "GOTO next class (start)",
	["@parameter.outer"] = "GOTO next parameter (start)",
}
textobjects_goto_next_end = {
	["@function.outer"] = "GOTO next function (end)",
	["@class.outer"] = "GOTO next class (end)",
	["@parameter.outer"] = "GOTO next parameter (end)",
}
textobjects_goto_previous_start = {
	["@function.outer"] = "GOTO previous function (start)",
	["@class.outer"] = "GOTO previous class (start)",
	["@parameter.outer"] = "GOTO previous parameter (start)",
}
textobjects_goto_previous_end = {
	["@function.outer"] = "GOTO previous function (end)",
	["@class.outer"] = "GOTO previous class (end)",
	["@parameter.outer"] = "GOTO previous parameter (end)",
}

textobjects_swap_next = {
	["@parameter.inner"] = "Swap next param",
}
textobjects_swap_previous = {
	["@parameter.inner"] = "Swap previous param",
}

textobjects_peek_definition_code = {
	["@function.outer"] = "Peek func defn",
	["@class.outer"] = "Peek class defn",
}
textobjects_select = {
	["af"] = "@function.outer",
	["if"] = "@function.inner",
	["ac"] = "@class.outer",
	["ic"] = "@class.inner",
	["ia"] = "@parameter.inner",
	["aa"] = "@parameter.outer",
}

textobjects_goto_next_start = {
	["]m"] = "@function.outer",
	["]]"] = "@class.outer",
	["ga"] = "@parameter.outer",
}
textobjects_goto_next_end = {
	["]M"] = "@function.outer",
	["]["] = "@class.outer",
	["gA"] = "@parameter.outer",
}
textobjects_goto_previous_start = {
	["[m"] = "@function.outer",
	["[["] = "@class.outer",
	["gpa"] = "@parameter.outer",
}
textobjects_goto_previous_end = {
	["[M"] = "@function.outer",
	["[]"] = "@class.outer",
	["gpA"] = "@parameter.outer",
}

textobjects_swap_next = {
	["<Leader>xp"] = "@parameter.inner",
}
textobjects_swap_previous = {
	["<Leader>xP"] = "@parameter.inner",
}

textobjects_peek_definition_code = {
	["<Leader>lpf"] = "@function.outer",
	["<Leader>lpc"] = "@class.outer",
}

return pkg
