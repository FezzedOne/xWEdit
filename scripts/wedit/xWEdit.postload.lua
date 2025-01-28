--- xWEdit material/matmod/liquid post-processor ---

if xsb then
    sb.logInfo("[xWEdit] xClient v" .. xsb.version() .. " detected.")
else
    sb.logInfo("[xWEdit] OpenStarbound or similar detected.")
end

local function contains(array, item)
    for _, v in ipairs(array) do
        if item == v then return true end
    end
    return false
end

local function splitPath(path)
    local lastSlash = path:match("^.*()/")

    if lastSlash then
        local directory = path:sub(1, lastSlash)
        local filename = path:sub(lastSlash + 1)
        return directory, filename
    else
        return "", path
    end
end

local function cropTile(pieceConfig, imagePath)
    local imageSize = assets.image(imagePath):size()
    local returnArray = jarray({})
    returnArray[1] = pieceConfig.texturePosition[1]
    returnArray[2] = imageSize[2] - (pieceConfig.texturePosition[2] + pieceConfig.textureSize[2])
    returnArray[3] = pieceConfig.texturePosition[1] + pieceConfig.textureSize[1]
    returnArray[4] = imageSize[2] - pieceConfig.texturePosition[2]
    return returnArray
end

local function cropDirective(cropArray)
    return "?crop="
        .. tostring(cropArray[1])
        .. ";"
        .. tostring(cropArray[2])
        .. ";"
        .. tostring(cropArray[3])
        .. ";"
        .. tostring(cropArray[4])
end

if not xsb then return end

do
    local materialPaths = assets.byExtension("material")
    local materialListPath = "/interface/wedit/materialPicker/materials.json"
    local materialList = jarray({})
    for _, path in ipairs(materialPaths) do
        local status, error = pcall(function()
            local directory, fileName = splitPath(path)
            local config = assets.json(path)
            -- Use the appropriate material template config to get the material's representative image.
            local texturePath = config.renderParameters and config.renderParameters.texture or "/interface/x.png"
            if config.renderTemplate then
                local renderTemplate = assets.json(config.renderTemplate)
                texturePath = texturePath:sub(1, 1) == "/" and texturePath or (directory .. texturePath)
                if assets.exists(texturePath) then
                    texturePath = texturePath
                        .. cropDirective(cropTile(renderTemplate.pieces[renderTemplate.representativePiece], texturePath))
                else
                    texturePath = "/interface/x.png"
                end
            else
                texturePath = "/interface/x.png" -- Special case for materials without a render template, such as `copperladder`.
            end
            table.insert(
                materialList,
                jobject({
                    name = config.materialName,
                    id = config.materialId,
                    buttonImage = texturePath,
                })
            )
        end)
        if not status then
            sb.logWarn("[xWEdit] Error adding material at '%s'; skipping material!\n  Error: %s", path, error)
        end
    end
    table.sort(materialList, function(a, b) return a.id < b.id end)
    local status, error = pcall(function()
        -- Add all metamaterials, excluding `metamaterial:empty` (already added later by the material interface script) and
        -- `metamaterial:null` (used by the game to indicated unloaded chunks and therefore not placeable).
        local metamaterialIcon = "/items/materials/dirt.png?saturation=50?hueshift="
        local metamaterialList = { -- List of all engine-supplied metamaterials (except `metamaterial:empty` and `metamaterial:null`).
            {65533, "metamaterial:structure"},
            {65527, "metamaterial:biome"},
            {65528, "metamaterial:biome1"},
            {65529, "metamaterial:biome2"},
            {65530, "metamaterial:biome3"},
            {65531, "metamaterial:biome4"},
            {65532, "metamaterial:biome5"},
            {65526, "metamaterial:boundary"},
            {65500, "metamaterial:objectsolid"},
            {65501, "metamaterial:objectplatform"},
        }
        local metamaterialConfig = assets.json("/metamaterials.config")
        for _, mm in ipairs(metamaterialConfig) do
            table.insert(metamaterialList, {mm.materialId, "metamaterial:" .. mm.name})
        end
        table.sort(metamaterialList, function(a, b) return a[1] < b[1] end)
        for n, mm in ipairs(metamaterialList) do
            local colourShift = tostring((n * 15) % 360)
            table.insert(
                materialList,
                jobject({
                    name = mm[2],
                    id = mm[1],
                    buttonImage = metamaterialIcon .. colourShift,
                })
            )
        end
    end)
    if not status then sb.logWarn("[xWEdit] Error adding metamaterials, skipping!\n  Error: %s", error) end
    assets.erase(materialListPath)
    assets.add(materialListPath, materialList)
    sb.logInfo("[xWEdit] Found and added %s %s.", #materialList, #materialList == 1 and "material" or "materials")
end

do
    local matmodPaths = assets.byExtension("matmod")
    local matmodListPath = "/interface/wedit/matmodPicker/matmods.json"
    local matmodList = jarray({})
    for _, path in ipairs(matmodPaths) do
        local status, error = pcall(function()
            local directory, fileName = splitPath(path)
            local config = assets.json(path)
            -- Use the appropriate material template config to get the matmod's representative image.
            local texturePath = config.renderParameters and config.renderParameters.texture or "/interface/x.png"
            if config.renderTemplate then
                local renderTemplate = assets.json(config.renderTemplate)
                texturePath = texturePath:sub(1, 1) == "/" and texturePath or (directory .. texturePath)
                if assets.exists(texturePath) then
                    texturePath = texturePath
                        .. cropDirective(cropTile(renderTemplate.pieces[renderTemplate.representativePiece], texturePath))
                else
                    texturePath = "/interface/x.png"
                end
            else
                texturePath = "/interface/x.png" -- Special case for matmods without a render template.
            end
            table.insert(
                matmodList,
                jobject({
                    name = config.modName,
                    id = config.modId,
                    buttonImage = texturePath,
                })
            )
        end)
        if not status then
            sb.logWarn("[xWEdit] Error adding matmod at '%s'; skipping matmod!\n  Error: %s", path, error)
        end
    end
    table.sort(matmodList, function(a, b) return a.id < b.id end)
    assets.erase(matmodListPath)
    assets.add(matmodListPath, matmodList)
end

do
    local liquidPaths = assets.byExtension("liquid")
    local liquidListPath = "/interface/wedit/liquidPicker/liquids.json"
    local liquidList = jarray({})
    for _, path in ipairs(liquidPaths) do
        local status, error = pcall(function()
            local directory, fileName = splitPath(path)
            local config = assets.json(path)
            local texturePath = config.texture
            texturePath = texturePath:sub(1, 1) == "/" and texturePath or (directory .. texturePath)
            if assets.exists(config.texture) then
                texturePath = texturePath .. "?crop=0;0;12;12"
            else
                texturePath = "/interface/x.png"
            end
            table.insert(
                liquidList,
                jobject({
                    name = config.name,
                    liquidId = config.liquidId,
                    buttonImage = texturePath,
                })
            )
        end)
        if not status then
            sb.logWarn("[xWEdit] Error adding liquid at '%s'; skipping liquid!\n  Error: %s", path, error)
        end
    end
    table.sort(liquidList, function(a, b) return a.liquidId < b.liquidId end)
    assets.erase(liquidListPath)
    assets.add(liquidListPath, liquidList)
end
