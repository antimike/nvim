-- Functions to help organize correspondence between keybindings (what the user actually does) and functionality exposed by plugins
-- Keybindings consist of mappings from keys to **capabilities**, which are then mapped separately to **providers**, i.e., functions and/or commands provided by plugins

local pkg = {}
local func = require("utils.func")

--- Construct a recursive, stateful iterator.
-- @param mark :: ctx -> state -> callback -> result
-- @param accum :: ctx -> state -> state
--  Can be further decomposed into state extractor + state reducer
-- @param init_state
-- @return Unary function which recurses into its argument in the manner
-- prescribed by (mark, accum), beginning with initial state init_state
function pkg.recursor(mark, accum, init_state)
    local function recurse(obj, state)
        state = accum(state, obj)
        mark(obj, state, recurse)
    end
    return function (obj)
        recurse(obj, init_state)
    end
end

-- * Some iterable structure it :: obj -> (prod :: inv -> ctrl -> obj | leaf | null, inv, init)
-- * A reducer red :: state -> state -> state
-- * Keeping full state history in order to unroll recursion is inefficient,
-- so...
-- * Construct "recursion graph" directly on-stack (locally)?
-- * More concrete, easy-to-understand interface / summary:
--  "reduce for graphs"
--  Each path through a datastructure gets reduced to a final result
-- * `paths` iterator
--  paths :: base -> dest -> (prod ::
--  Different ways of "slicing" or "factoring" recursive descent differ based on
--  control and state parameters:
--      * Breadth-first: ctrl -> depth, state -> (bfs(d-1), curr_it)
--      * Depth-first: ctrl -> curr_node, state -> it_stack
--      * "Algebra of iterators:" iterators "multiply" noncommutatively

function pkg.iterator_dual(it_fn)
    return func.with_default(func.conjugate_by_cycle(it_fn), nil)
end

-- fn
-- (s_0, c_0)
--> fn(s_0, c_0) = c_1, s_1
--> fn(s_1, c_1) = c_2, s_2
--> ...
--> fn(s_n, c_n) = nil, s_{n+1}

-- "state" for one iterator becomes "ctrl" for the next





return pkg
