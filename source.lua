--Made by: @kcz1_o (roblox)



local players = game:GetService("Players")

local player = players.LocalPlayer

local config = {
	teleportCooldown = 1.85, --if you set value lower 1.85, you can be kicked
	
	--i will add it soon
	--targetCoins = {
	--	"BeachBall"
	--};
}

local lastTeleportClock = os.clock() --dont touch

function getCharacter()
	local character = player.Character

	if character then
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart then
			return character, humanoidRootPart
		end
	end
end

function collectCoin(coin)
	repeat
		local character, humanoidRootPart = getCharacter()

		if character and humanoidRootPart then
			humanoidRootPart.Position = coin.Position + Vector3.new(0, -1+math.random()*2, 0)
		end
	until not coin:FindFirstChild("TouchInterest")
end

function goToLobby()
	local character, humanoidRootPart = getCharacter()

	if character and humanoidRootPart then
		humanoidRootPart.Position = Vector3.new(14.35, 504.82, -38.25) --not automatic because spawnLocation is not basePart
	end
end

function getCoinContainer()
	for _,v in ipairs(workspace:GetChildren()) do
		local coinContainer = v:FindFirstChild("CoinContainer")

		if coinContainer then
			return coinContainer
		end
	end
end

while true do
	local coinContainer = getCoinContainer()

	if os.clock()-lastTeleportClock >= config.teleportCooldown and coinContainer then
		for _, coin in ipairs(coinContainer:GetChildren()) do
			if coin:FindFirstChild("TouchInterest") then
				collectCoin(coin)

				lastTeleportClock = os.clock()

				break
			end
		end

		goToLobby()
	else
		goToLobby()
	end
end
