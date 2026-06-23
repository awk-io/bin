-- backup.lua: A simple script to copy a file with a timestamp

local function get_timestamp()
    -- Get the current time and format it as YYYY-MM-DD_HH-MM-SS
    return os.date("%Y-%m-%d_%H-%M-%S")
end

local function backup_file(source_path)
    -- Check if the source file exists
    local file = io.open(source_path, "r")
    if not file then
        print("Error: File '" .. source_path .. "' not found.")
        return false
    end
    local content = file:read("*all")  -- Read the entire file
    file:close()

    -- Create the backup filename
    local timestamp = get_timestamp()
    local backup_path = source_path .. ".backup_" .. timestamp

    -- Write the backup file
    local backup_file = io.open(backup_path, "w")
    backup_file:write(content)
    backup_file:close()

    print("Backup created successfully: " .. backup_path)
    return true
end

-- === MAIN EXECUTION ===
local source = "data.txt"
backup_file(source)
