vim.g.mapleader = " "  -- must be set before lazy loads plugins
require("arty.lazy")   -- plugins on rtp first
require("arty")        -- then settings/remaps
