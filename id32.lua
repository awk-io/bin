-- filename_formatter.lua
-- A clean utility to format, sanitize, and rename files

local function sanitize_filename(filename)
    -- Remove invalid characters for Windows/Linux filenames
    -- Replaces: / \ : * ? " < > | with underscores
    local invalid_chars = '[%/%\\%:%*%?%"%<%>%|]'
    return filename:gsub(invalid_chars, '_')
end

local function add_timestamp(filename)
    -- Insert timestamp before the file extension
    -- Example: "report.pdf" -> "report_2026-06-23.pdf"
    local timestamp = os.date("%Y-%m-%d")
    local base, ext = filename:match("^(.+)(%..+)$")
    
    if base and ext then
        return base .. "_" .. timestamp .. ext
    else
        -- No extension found, just append timestamp
        return filename .. "_" .. timestamp
    end
end

local function add_counter(filename, counter)
    -- Add a zero-padded counter before the extension
    -- Example: "image.jpg" -> "image_001.jpg"
    local base, ext = filename:match("^(.+)(%..+)$")
    local counter_str = string.format("%03d", counter)
    
    if base and ext then
        return base .. "_" .. counter_str .. ext
    else
        return filename .. "_" .. counter_str
    end
end

local function to_lowercase(filename)
    -- Convert entire filename to lowercase
    return filename:lower()
end

local function replace_spaces(filename, replacement)
    -- Replace spaces with underscores or dashes
    replacement = replacement or "_"
    return filename:gsub("%s+", replacement)
end

-- ============================================
-- EXAMPLE USAGE
-- ============================================

local original = "My Final Report 2026.pdf"
print("Original:  " .. original)

-- Chain multiple formatting functions together
local formatted = original
formatted = sanitize_filename(formatted)      -- Remove invalid chars
formatted = replace_spaces(formatted, "_")    -- Spaces -> underscores
formatted = to_lowercase(formatted)           -- All lowercase
formatted = add_timestamp(formatted)          -- Add today's date

print("Formatted: " .. formatted)

-- Example: Adding a counter for batch processing
print("\n--- Batch Rename Example ---")
local batch_files = {
    "photo.jpg",
    "photo.jpg", 
    "photo.jpg"
}

for i, filename in ipairs(batch_files) do
    local new_name = add_counter(filename, i)
    print(filename .. " -> " .. new_name)
end

-- Example: Preview actual file rename (commented out for safety)
-- os.rename("old_name.txt", "new_name.txt")
