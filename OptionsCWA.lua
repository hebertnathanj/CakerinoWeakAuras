-- Based on the code used in Luxthos WeakAuras (https://wago.io/p/Luxthos). Any code not mine cited with credit to original creator.
-- CakerinoWA v0.5
CWA = CWA or {}

local this = aura_env
local config = this.config
local CLASS = this.id:gsub("Options | CakerinoWA |", "")
local RESOURCES_GROUP = "Resources | CakerinoWA | " .. CLASS
local MAIN_GROUP = "Main | CakerinoWA | " .. CLASS

local function SetRegionSize(region, region_width, region_height)
    region:SetRegionWidth(region_width)
    region:SetRegionHeight(region_height)
end

local function GetMainIcons(active_regions)
    local active_icons = #active_regions

    if active_icons <= 0 then return end

    return min(active_icons, config.main.icons_max)
end

local function GetMainWidth(main_icons)
    if not main_icons then
        main_icons = GetMainIcons()
    end
    local main_width = config.main.width
    local main_spacing = config.main.spacing
    return (main_icons * (main_width + main_spacing))
end

function CWA.GrowMain(new_positions, active_regions)
    local active_icons = #active_regions

    if active_icons <= 0 then return end

    local main_width = config.main.width
    local main_height = config.main.height
    local main_spacing = config.main.spacing
    local max_icons = min(active_icons, config.main.icons_max)
    local icon_width = GetMainWidth(max_icons) + main_spacing

    local x,y
    local x_offset = ((icon_width - main_width) / 2)
    local y_offset = main_spacing

    for i, regionData in ipairs(active_regions) do        
        x = (i - 1) * (main_width + main_spacing) - x_offset + main_spacing
        y = -y_offset
        SetRegionSize(regionData.region, main_width, main_height)
        new_positions[i]= {x, y}

        if i == max_icons then break end
    end
end

function CWA.GrowResource(new_positions, active_regions)
    local active_bars = #active_regions

    if active_bars <= 0 then return end
    local region_group = WeakAuras.GetRegion(MAIN_GROUP)
    
    local max_icons = min(config.main.icons_max)
    local main_width = GetMainWidth(max_icons)
    local resource_height = config.essentials.resource.height
    local main_spacing = config.main.spacing


    local resource_width = ((main_width + main_spacing) / active_bars) - main_spacing
    local x, y
    local x_offset = (main_width - resource_width) / 2
    local y_offset = (config.main.height / 2) + main_spacing + (resource_height / 2)

    for i, region_data in ipairs(active_regions) do
        x = (i - 1) * (resource_width + main_spacing) - x_offset
        y = y_offset
        SetRegionSize(region_data.region, resource_width, resource_height)
        new_positions[i] = {x, y}
    end
end

function CWA.GrowPower(new_positions, active_regions)
    local active_bars = #active_regions
    if active_bars <= 0 then return end

    local max_icons = min(config.main.icons_max)
    local main_width = GetMainWidth(max_icons)
    local power_height = config.essentials.power.height
    local main_spacing = config.main.spacing


    local power_width = ((main_width + main_spacing) / active_bars) - main_spacing
    local x, y
    local x_offset = (main_width - power_width) / 2
    local y_offset = (config.main.height / 2) + main_spacing + (power_height / 2)

    for i, region_data in ipairs(active_regions) do
        x = (i - 1) * (power_width + main_spacing) - x_offset
        y = y_offset
        SetRegionSize(region_data.region, power_width, power_height)
        new_positions[i] = {x, y}
    end
end

function CWA.GrowCastBar(new_positions, active_regions)
    local show_cast_bar = config.essentials.cast_bar.show
    if not show_cast_bar then return end

    local active_bars = #active_regions
    if active_bars <= 0 then return end

    local max_icons = min(config.main.icons_max)
    local main_width = GetMainWidth(max_icons)
    local cast_bar_height = config.essentials.cast_bar.height
    local main_spacing = config.main.spacing


    local cast_bar_width = ((main_width + main_spacing) / active_bars) - main_spacing
    local x, y
    local x_offset = (main_width - cast_bar_width) / 2
    local y_offset = (config.main.height / 2) + main_spacing + (cast_bar_height / 2)

    for i, region_data in ipairs(active_regions) do
        x = (i - 1) * (cast_bar_width + main_spacing) - x_offset
        y = y_offset
        SetRegionSize(region_data.region, cast_bar_width, cast_bar_height)
        new_positions[i] = {x, y}
    end
end

--Determines how utility icons grow
function CWA.GrowUtilities(new_positions, active_regions)
    local active_icons = #active_regions

    if active_icons <= 0 then return end

    --need to grow the utlitlies on the top right of the frame above the resource bars

end

--Function determines how tracker icons grow
function CWA.GrowTrackers(new_positions, active_regions)
    local active_icons = #active_regions

    if active_icons <= 0 then return end

    local tracker_width = config.trackers.width
    local tracker_height = config.trackers.height
    local tracker_spacing = config.trackers.spacing
    local main_spacing = config.essentials.spacing
end



