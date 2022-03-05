local pkg = {}

local objs = {
	types = {
		block = { mnemonic = "block", "b" },
		call = { mnemonic = "eXecute", "x" },
		class = { mnemonic = "CLASS", "C" },
		comment = { mnemonic = "comment", "c" },
		conditional = { mnemonic = "_k_onditional", "k" },
		frame = { mnemonic = "FRAME", "F" },
		["function"] = { mnemonic = "function", "f" },
		loop = { mnemonic = "loop", "l" },
		parameter = {
			"a",
			mnemonic = "argument",
		},
		scopename = {
			"P",
			outer = false,
			mnemonic = "package",
		},
		statement = {
			"S",
			inner = false,
		},
	},
	scopes = {
		inner =  "i" ,
		outer =  "a" ,
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
                        objs.descriptions[query] = name .. " (" .. scope .. ")"
                end
        end
end

local actions = {
	select = {},
	GOTO = {
		next = {
			start = {},
			["end"] = {},
		},
		previous = {
			start = {},
			["end"] = {},
		},
	},
	swap = {
		next = {},
		previous = {},
	},
	peek_definition = {},
}



-- PLAN: DFS through actions tree, yielding the full path when we reach a leaf
-- Preprocess obj tree with another DFS to assemble { obj = { desc, binds } table
-- Helper fns:
--      - Check if bind is already taken
--      - Capitalize description

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
