function lines_from(file)
    lines = {}
    for line in io.lines(file) do 
        lines[#lines + 1] = line
    end
    return lines
end

function split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function valid_length(string, expected_length)
    return string.len(string) == expected_length
end

function is_between(string, lower, upper)
    if tonumber(string) < lower then
        return false
    end
    
    if tonumber(string) > upper then
        return false
    end
    
    return true
end

function valid_height(height)
    if string.find(height, "cm") ~= nil then
        return is_between(height:sub(1,-3), 150, 193)
    elseif string.find(height, "in") ~= nil then
        return is_between(height:sub(1,-3), 59, 76)
    end

    return false
end

function valid_hair_color(color)
    if string.find(color, "#") == nil then
        return false
    end

    for i = 1, #color do
        c = color:sub(i,i)
        if not string.find ("#0123456789abcdef",c) then
            return false
        end
    end

    return true 
end

function puzzle_one()
    lines = lines_from('input')

    valid_passports = 0
    current_passport = {}

    required_fields = {"byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"}

    for k,v in pairs(lines) do
        
        if v  == "\r" then     
            valid = true

            -- is present?
            for k,v in pairs(required_fields) do
                if current_passport[v] == nil then
                    valid = false
                end
            end

            if valid then 
                valid_passports = valid_passports + 1
            end
            
            current_passport = {}
        end

        line_components = split(v, " ")

        for k,v in pairs(line_components) do
            component_parts = split(v, ":")
            current_passport[component_parts[1]] = component_parts[2]
        end
        
    end
    print("Solution for puzzle one: ", valid_passports)
end

function puzzle_two()
    lines = lines_from('input')

    valid_passports = 0
    current_passport = {}

    required_fields = {"byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"}

    for k,v in pairs(lines) do
        
        if v  == "\r" then     
            valid = true

            -- is present?
            for k,v in pairs(required_fields) do
                if current_passport[v] == nil then
                    valid = false
                end
            end

            -- is valid?
            if valid then
                if not valid_length(current_passport["byr"], 4) or not is_between(current_passport["byr"], 1920, 2002) then
                    valid = false
                elseif not valid_length(current_passport["iyr"], 4) or not is_between(current_passport["iyr"], 2010, 2020) then
                    valid = false 
                elseif not valid_length(current_passport["eyr"], 4) or not is_between(current_passport["eyr"], 2020, 2030) then
                    valid = false 
                elseif not valid_height(current_passport["hgt"]) then
                    valid = false 
                elseif not valid_length(current_passport["hcl"], 7) or not valid_hair_color(current_passport["hcl"]) then
                    valid = false 
                elseif not string.find("amb-blu-brn-gry-grn-hzl-oth", current_passport["ecl"]) then
                    valid = false 
                elseif not valid_length(current_passport["pid"], 9) then
                    valid = false 
                end
            end

            if valid then 
                valid_passports = valid_passports + 1
            end
            
            current_passport = {}
        end

        line_components = split(v, " ")

        for k,v in pairs(line_components) do
            component_parts = split(v, ":")

            if component_parts[2] ~= nil then
                current_passport[component_parts[1]] = string.gsub(component_parts[2], "%s+", "")
            end
        end
        
    end
    print("Solution for puzzle two: ", valid_passports)
end

puzzle_one()
puzzle_two()

