--[[
Approaches to managing side effects / branching:
1. Every semantics (defn) table takes functions of state as values
2. The semantics table exposes properties which have no syntactic analogue, defined as functions of state
        * e.g., semantics.is_large_jump()
        * One way to organize this: All such properties are predicates (i.e., Booleans)

A production rule is modeled as an element of a syntax table.  For example, the entry
syntax.clause = {
        syntax.verb,
        syntax.noun
}
represents the production rule CLAUSE -> (VERB)(NOUN).

Because of the way Lua tables work, it is not possible to assign multiple production rules with the same left-hand sides using this mechanism.

Instead, we allow the use of **named** attributes of the syntax entries to represent conditional production rules.
This alternative mechanism is, in turn, based on the fact that entries of the syntax table may be either functions or tables.  Functions in this context are interpreted as "update-return" switches, and are required to have the type State -> SyntaxElement -> { SyntaxElement }.
--]]

local function expand_nonterminal(nt, state)
	if type(nt) == "thread" then
		-- Resume coroutine and recurse
                while coroutine.status(nt) ~= "dead" do
                        local rule = coroutine.resume(nt)
                end
	elseif type(nt) == "table" then
		-- Add ipairs(nt) to state and recurse
	end
end

local function expand_list(list, state)
        for idx, elem in ipairs(list) do
                list[-idx] = expand_node(elem, state)
        end
end
--[[
Cases:
1. rule == nil.  Here, we use ipairs(nt) (i.e., the "list part" of nt) as the RHS of the rule.
2. type(rule) == "function".  Here, the RHS is rule(state, nt).
3. type(rule) == "string".  Here, RHS = nt[rule].
--]]
local function produce(nt, state, rule)
	if rule == nil then
		return nt
	elseif type(rule) == "function" then
		return rule(state, nt)
	elseif type(rule) == "string" then
		return nt[rule]
	end
end

local syntax, semantics = {}, {}
syntax.terminal = {} -- Sentinel

local function Or(options)
	-- Indeterminacy is represented through coroutines
	return coroutine.create(function()
		for k, v in pairs(options) do
			coroutine.yield(k, v)
		end
	end)
end

local function Return(ret, update)
	local updater = function(_) end
	if type(update) == "function" then
		updater = update
	elseif type(update) == "table" then
		updater = function(state)
			vim.tbl_extend("force", state, update)
		end
	end
	return function(state, _) -- State functions are required to take 2 args
		updater(state)
		return ret
	end
end

local default_mt = {
	__index = function(tbl, _)
		return tbl[1]
	end,
}

local function Defn(tbl)
	return setmetatable(tbl, default_mt)
end

syntax.noun = Or({
	block = Defn({ "b", large = "B" }),
	call = Defn({ "x", large = "X" }),
	class = Defn({ "C", large = "M" }),
	comment = Defn({ "c", large = "m" }),
	conditional = Defn({ "i", large = "I" }),
	frame = Defn({ "d", large = "D" }),
	["function"] = Defn({ "f", large = "F" }),
	loop = Defn({ "l", large = "L" }),
	parameter = Defn({ "a", large = "A" }),
	scopename = Defn({ "P" }),
	statement = Defn({ "S" }),
})

syntax.adjective = Or({
	inner = Defn({ "i" }),
	outer = Defn({ "a" }),
	large = Return(nil, {
		[syntax.noun] = function(_, node)
			return node.large
		end,
	}),
	small = Return(nil, syntax.noun),
})

syntax.verb = Or({
	peek_definition = { Return("pd", { modes = { "n", "v" } }) },
	swap = { Return("gx", { modes = { "n", "o" } }) },
	select = { Return(nil, { modes = { "o", "v" } }) },
	["goto"] = { Return(nil, { modes = { "n", "v" } }) },
})

syntax.preposition = Or({
	next = { "]" },
	previous = { "[" },
})

syntax.adjective_phrase = { syntax.adjective, syntax.noun }
syntax.prepositional_phrase = { syntax.preposition, syntax.adjective_phrase }
syntax.action = { syntax.verb, syntax.prepositional_phrase }
