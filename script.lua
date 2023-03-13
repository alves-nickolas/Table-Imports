function character_replacer(teststring,characterin,characterout) --replaces a given character sequence occurring on a string
    initialposition, finalposition = string.find(teststring, characterout)
    if type(initialposition)=="number" and type(finalposition)=="number"then
        return character_replacer(teststring:sub(1,initialposition-1) .. characterin .. teststring:sub(finalposition+1,#teststring),characterin,characterout)
    else 
        return teststring
    end
end

function csv_to_tabular(filename) --picks a file and converts it to LaTeX's tabular format 
    local str = ""
    local filein = assert(io.open(filename,"r"))
    local linenumber = 1
    for line in filein:lines() do 
        if linenumber > 1 then 
            str = str .. "\\\\%\n"
        end
        str = str .. character_replacer(line," & ",",")
        linenumber = linenumber + 1
    end
    filein:close()
    str = str .. "%" --adds a final % sign to comment extra spaces
    local fileout = assert(io.open("output.tex","w"))
    fileout:write(str)
    fileout:close()
    --return str
end

function tsv_to_tabular(filename) --picks a file and converts it to LaTeX's tabular format 
    local str = ""
    local filein = assert(io.open(filename,"r"))
    local linenumber = 1
    for line in filein:lines() do 
        if linenumber > 1 then 
            str = str .. "\\\\%\n"
        end
        str = str .. character_replacer(line," & ","\t")
        linenumber = linenumber + 1
    end
    filein:close()
    str = str .. "%" --adds a final % sign to comment extra spaces
    local fileout = assert(io.open("output.tex","w"))
    fileout:write(str)
    fileout:close()
    --return str
end