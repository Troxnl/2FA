local function processListingInfo(uid, gems, item, version, shiny, amount, boughtFrom, boughtStatus, class, failMessage, snipeNormal)
    local gemamount = Players.LocalPlayer.leaderstats["💎 Diamonds"].Value
    local snipeMessage ="||".. Players.LocalPlayer.Name .. "||"
    local weburl, webContent, webcolor
    local versionVal = { [1] = "Golden ", [2] = "Rainbow " }
    local versionStr = versionVal[version] or (version == nil and "")
    local mention = (string.find(item, "Huge") or string.find(item, "Titanic")) and "<@" .. userid .. ">" or ""
	
    if boughtStatus then
        webcolor = tonumber(0x00ff00)
            snipeMessage = snipeMessage .. " just sniped ".. amount .."x "
            webContent = mention
        webStatus = "Success!"
        weburl = webhook
        if snipeNormal == true then
            weburl = normalwebhook
            snipeNormal = false
        end
        else
        webcolor = tonumber(0xff0000)
        weburl = webhookFail
        webStatus = failMessage
        snipeMessage = snipeMessage .. " failed to snipe ".. amount .."x "
        if snipeNormal == true then
            snipeNormal = false
        end
        end
    
    snipeMessage = snipeMessage .. "**" .. versionStr
    
    if shiny then
        snipeMessage = snipeMessage .. " Shiny "
    end
    
    snipeMessage = snipeMessage .. item .. "**"
    
    local message1 = {
        ['content'] = webContent,
        ['embeds'] = {
            {
		["author"] = {
			["name"] = "Shaiza",
			["icon_url"] = ""https://cdn.discordapp.com/attachments/1191492866992775208/1191570677652799498/1130472141331120219.png?ex=65a5ebab&is=659376ab&hm=5e8c0e0242fd3c8adc378487398431dc7106d2c86740fc2082187d285fd82d48&",
		},
                ['title'] = snipeMessage,
                ["color"] = webcolor,
                ["timestamp"] = DateTime.now():ToIsoDate(),
                ['fields'] = {
                    {
                        ['name'] = "__Price:__",
                        ['value'] = tostring(gems) .. " 💎",
                    },
                    {
                        ['name'] = "__Bought from:__",
                        ['value'] = "||"..tostring(boughtFrom).."|| ",
                    },
                    {
                        ['name'] = "__Amount:__",
                        ['value'] = tostring(amount) .. "x",
                    },
                    {
                        ['name'] = "__Remaining gems:__",
                        ['value'] = tostring(gemamount) .. " 💎",
                    },      
                    {
                        ['name'] = "__PetID:__",
                        ['value'] = "||"..tostring(uid).."||",
                    },
                },
		["footer"] = {
                        ["icon_url"] = "https://cdn.discordapp.com/attachments/1191492866992775208/1191570677652799498/1130472141331120219.png?ex=65a5ebab&is=659376ab&hm=5e8c0e0242fd3c8adc378487398431dc7106d2c86740fc2082187d285fd82d48&",
                        ["text"] = "Heavily Modified by Shaiza"
		}
            },
        }
    }

    local jsonMessage = http:JSONEncode(message1)
    local success, webMessage = pcall(function()
	http:PostAsync(weburl, jsonMessage)
    end)
    if success == false then
        local response = request({
            Url = weburl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = jsonMessage
        })
    end
end