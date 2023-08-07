cipheredText = "max vhlm hy max unl wkboxk ingva b nlxw mh ingva fr hpg mktglyxkl"
wordMatches = { "of", "my", "the" }

-- TODO: no support for case sensitivity yet

-- converts letter into number, applies the shift and turns back into letter
function shiftLetter(chr, rot)
    return string.char(
      (string.byte(chr) - 97 + rot) % 26 + 97
    )
end

-- only shift letters, whitespaces are returned right away
function processChar(chr, rot)
    if chr == " " then
        return chr
    else
        return shiftLetter(chr, rot)
    end
end

-- extracts each character, and forwards letters to rotation
function rotateLetters(text, rot)
    result = string.format("%02d", rot) .. ": "
    
    for chr in text:gmatch"." do
        result = result .. processChar(chr, rot)
    end
    
    return result
end

-- TODO: matching not working yet
function processRotation(text, rot)
    result = rotateLetters(text, rot) 

    for _, match in pairs(wordMatches) do
        if string.find(match, result) ~= nil then
            return result .. " <--- MATCH"
        end
    end

    return result
end

-- starts all 25 rotation variants of given text
function createRotation(text)
    resultingLines = {}
    
    for i = 1,25,1 
    do
        table.insert(resultingLines, processRotation(text, i))
    end
    
    return resultingLines
end

function decipher(text)
    return table.concat(createRotation(text), "\n")
end

print("IN: " .. cipheredText)
print("Deciphering...")
print(decipher(cipheredText))
