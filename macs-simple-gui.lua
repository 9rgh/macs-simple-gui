local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")



local currentFOV = 90

local crosshairEnabled = true
local crosshairSize = 32
local crosshairTransparency = 0

local fpsBoostEnabled = false


local BASE_WIDTH = 410
local BASE_HEIGHT = 500

local MIN_WIDTH = 310
local MIN_HEIGHT = 380

local MAX_WIDTH = 750
local MAX_HEIGHT = 800



local RED = Color3.fromRGB(255, 0, 0)
local DARK_RED = Color3.fromRGB(75, 0, 0)
local BLACK = Color3.fromRGB(5, 5, 5)
local DARK = Color3.fromRGB(12, 12, 12)



local gui = Instance.new("ScreenGui")
gui.Name = "PvPSettings"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 100
gui.Enabled = false
gui.Parent = playerGui


local window = Instance.new("Frame")

window.Name = "SettingsWindow"
window.Size = UDim2.fromOffset(
	BASE_WIDTH,
	BASE_HEIGHT
)

window.Position = UDim2.new(
	1,
	-430,
	0.5,
	-250
)

window.BackgroundColor3 = BLACK
window.BorderColor3 = RED
window.BorderSizePixel = 2

window.Active = true
window.ClipsDescendants = false

window.Parent = gui



local content = Instance.new("Frame")

content.Name = "Content"

content.Size = UDim2.fromOffset(
	BASE_WIDTH,
	BASE_HEIGHT
)

content.Position = UDim2.fromOffset(0, 0)

content.BackgroundTransparency = 1
content.BorderSizePixel = 0

content.Parent = window



local uiScale = Instance.new("UIScale")
uiScale.Name = "AutoScale"
uiScale.Scale = 1
uiScale.Parent = content

local function updateUIScale()

	local windowSize = window.AbsoluteSize

	local widthScale =
		windowSize.X / BASE_WIDTH

	local heightScale =
		windowSize.Y / BASE_HEIGHT

	local scale =
		math.min(
			widthScale,
			heightScale
		)

	scale = math.clamp(
		scale,
		0.75,
		1.7
	)

	uiScale.Scale = scale

end

window:GetPropertyChangedSignal(
	"AbsoluteSize"
):Connect(updateUIScale)



local function makeLabel(
	text,
	x,
	y,
	width,
	height,
	size
)

	local label = Instance.new("TextLabel")

	label.Size =
		UDim2.fromOffset(
			width,
			height
		)

	label.Position =
		UDim2.fromOffset(
			x,
			y
		)

	label.BackgroundTransparency = 1

	label.Text = text
	label.TextColor3 = RED
	label.TextSize = size or 15

	label.Font =
		Enum.Font.GothamBold

	label.TextXAlignment =
		Enum.TextXAlignment.Left

	label.Parent = content

	return label

end

local function makeButton(
	text,
	x,
	y,
	width,
	height
)

	local button = Instance.new("TextButton")

	button.Size =
		UDim2.fromOffset(
			width,
			height
		)

	button.Position =
		UDim2.fromOffset(
			x,
			y
		)

	button.BackgroundColor3 = DARK

	button.BorderColor3 = RED
	button.BorderSizePixel = 1

	button.Text = text
	button.TextColor3 = RED
	button.TextSize = 13

	button.Font =
		Enum.Font.GothamBold

	button.Parent = content

	return button

end



local title = makeLabel(
	"SETTINGS",
	15,
	5,
	300,
	45,
	23
)

title.Active = true

local topLine = Instance.new("Frame")

topLine.Size =
	UDim2.fromOffset(
		380,
		2
	)

topLine.Position =
	UDim2.fromOffset(
		15,
		50
	)

topLine.BackgroundColor3 = RED
topLine.BorderSizePixel = 0

topLine.Parent = content



makeLabel(
	"FOV",
	20,
	65,
	100,
	30,
	18
)

local fovValue = makeLabel(
	"90",
	350,
	65,
	40,
	30,
	18
)

fovValue.TextXAlignment =
	Enum.TextXAlignment.Right

local fovSlider = Instance.new("Frame")

fovSlider.Size =
	UDim2.fromOffset(
		370,
		6
	)

fovSlider.Position =
	UDim2.fromOffset(
		20,
		105
	)

fovSlider.BackgroundColor3 =
	DARK_RED

fovSlider.BorderSizePixel = 0
fovSlider.Active = true

fovSlider.Parent = content

local fovFill = Instance.new("Frame")

fovFill.Size =
	UDim2.new(
		(currentFOV - 70) / 50,
		0,
		1,
		0
	)

fovFill.BackgroundColor3 = RED
fovFill.BorderSizePixel = 0
fovFill.Parent = fovSlider

local fovKnob = Instance.new("Frame")

fovKnob.Size =
	UDim2.fromOffset(
		14,
		14
	)

fovKnob.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

fovKnob.Position =
	UDim2.new(
		(currentFOV - 70) / 50,
		0,
		0.5,
		0
	)

fovKnob.BackgroundColor3 = RED
fovKnob.BorderSizePixel = 0
fovKnob.Parent = fovSlider

makeLabel(
	"70",
	20,
	115,
	40,
	20,
	12
)

local fovMax = makeLabel(
	"120",
	345,
	115,
	45,
	20,
	12
)

fovMax.TextXAlignment =
	Enum.TextXAlignment.Right


makeLabel(
	"CROSSHAIR",
	20,
	150,
	200,
	30,
	18
)

local imageBox = Instance.new("TextBox")

imageBox.Size =
	UDim2.fromOffset(
		260,
		36
	)

imageBox.Position =
	UDim2.fromOffset(
		20,
		185
	)

imageBox.BackgroundColor3 = DARK

imageBox.BorderColor3 = RED
imageBox.BorderSizePixel = 1

imageBox.Text = ""

imageBox.PlaceholderText =
	"Roblox Image ID"

imageBox.TextColor3 = RED
imageBox.PlaceholderColor3 = DARK_RED

imageBox.TextSize = 13
imageBox.Font = Enum.Font.Gotham

imageBox.ClearTextOnFocus = false

imageBox.Parent = content

local applyButton = makeButton(
	"APPLY",
	290,
	185,
	100,
	36
)

local crosshairToggle = makeButton(
	"CROSSHAIR: ON",
	20,
	235,
	170,
	35
)



makeLabel(
	"SIZE",
	215,
	238,
	60,
	25,
	13
)

local sizeValue = makeLabel(
	"32",
	350,
	238,
	40,
	25,
	13
)

sizeValue.TextXAlignment =
	Enum.TextXAlignment.Right

local sizeSlider = Instance.new("Frame")

sizeSlider.Size =
	UDim2.fromOffset(
		370,
		6
	)

sizeSlider.Position =
	UDim2.fromOffset(
		20,
		280
	)

sizeSlider.BackgroundColor3 =
	DARK_RED

sizeSlider.BorderSizePixel = 0
sizeSlider.Active = true

sizeSlider.Parent = content

local sizeFill = Instance.new("Frame")

sizeFill.Size =
	UDim2.new(
		(crosshairSize - 8) / 92,
		0,
		1,
		0
	)

sizeFill.BackgroundColor3 = RED
sizeFill.BorderSizePixel = 0
sizeFill.Parent = sizeSlider

local sizeKnob = Instance.new("Frame")

sizeKnob.Size =
	UDim2.fromOffset(
		14,
		14
	)

sizeKnob.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

sizeKnob.Position =
	UDim2.new(
		(crosshairSize - 8) / 92,
		0,
		0.5,
		0
	)

sizeKnob.BackgroundColor3 = RED
sizeKnob.BorderSizePixel = 0
sizeKnob.Parent = sizeSlider



makeLabel(
	"TRANSPARENCY",
	20,
	310,
	180,
	30,
	15
)

local transparencyValue = makeLabel(
	"0%",
	345,
	310,
	45,
	30,
	15
)

transparencyValue.TextXAlignment =
	Enum.TextXAlignment.Right

local transparencySlider =
	Instance.new("Frame")

transparencySlider.Size =
	UDim2.fromOffset(
		370,
		6
	)

transparencySlider.Position =
	UDim2.fromOffset(
		20,
		350
	)

transparencySlider.BackgroundColor3 =
	DARK_RED

transparencySlider.BorderSizePixel = 0
transparencySlider.Active = true

transparencySlider.Parent = content

local transparencyFill =
	Instance.new("Frame")

transparencyFill.Size =
	UDim2.new(
		0,
		0,
		1,
		0
	)

transparencyFill.BackgroundColor3 = RED
transparencyFill.BorderSizePixel = 0

transparencyFill.Parent =
	transparencySlider

local transparencyKnob =
	Instance.new("Frame")

transparencyKnob.Size =
	UDim2.fromOffset(
		14,
		14
	)

transparencyKnob.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

transparencyKnob.Position =
	UDim2.new(
		0,
		0,
		0.5,
		0
	)

transparencyKnob.BackgroundColor3 =
	RED

transparencyKnob.BorderSizePixel = 0

transparencyKnob.Parent =
	transparencySlider



makeLabel(
	"PERFORMANCE",
	20,
	380,
	200,
	30,
	18
)

local fpsButton = makeButton(
	"FPS BOOST: OFF",
	20,
	420,
	370,
	38
)


local crosshairGui =
	Instance.new("ScreenGui")

crosshairGui.Name =
	"CustomCrosshair"

crosshairGui.ResetOnSpawn =
	false

crosshairGui.IgnoreGuiInset =
	true

crosshairGui.DisplayOrder =
	999999

crosshairGui.Parent =
	playerGui



local crosshair =
	Instance.new("ImageLabel")

crosshair.Name =
	"Crosshair"

crosshair.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

crosshair.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

crosshair.Size =
	UDim2.fromOffset(
		crosshairSize,
		crosshairSize
	)

crosshair.BackgroundTransparency =
	1


crosshair.Image =
	"rbxassetid://6031091002"

crosshair.ImageTransparency =
	crosshairTransparency

crosshair.Visible =
	crosshairEnabled

crosshair.Parent =
	crosshairGui



local function updateCrosshair()

	crosshair.Visible =
		crosshairEnabled

	crosshair.Size =
		UDim2.fromOffset(
			crosshairSize,
			crosshairSize
		)

	crosshair.ImageTransparency =
		math.clamp(
			crosshairTransparency,
			0,
			1
		)

end



applyButton.MouseButton1Click:Connect(
	function()

		local id =
			imageBox.Text:gsub(
				"%s+",
				""
			)

		if id == "" then
			return
		end

		local image

		if string.sub(
			id,
			1,
			13
		) == "rbxassetid://" then

			image = id

		elseif tonumber(id) then

			image =
				"rbxassetid://" ..
				id

		else

			warn(
				"Invalid Roblox Image ID"
			)

			return
		end

		-- 立即套用
		crosshair.Image = image

		-- 立即刷新
		updateCrosshair()

	end
)



crosshairToggle.MouseButton1Click:Connect(
	function()

		crosshairEnabled =
			not crosshairEnabled

		crosshairToggle.Text =
			crosshairEnabled
			and "CROSSHAIR: ON"
			or "CROSSHAIR: OFF"

		updateCrosshair()

	end
)



local function getPercent(
	mouseX,
	slider
)

	local startX =
		slider.AbsolutePosition.X

	local width =
		slider.AbsoluteSize.X

	return math.clamp(
		(mouseX - startX) / width,
		0,
		1
	)

end



local fovDragging = false

local function updateFOV(mouseX)

	local percent =
		getPercent(
			mouseX,
			fovSlider
		)

	currentFOV =
		math.round(
			70 + percent * 50
		)

	local camera =
		Workspace.CurrentCamera

	if camera then

		camera.FieldOfView =
			currentFOV

	end

	fovValue.Text =
		tostring(
			currentFOV
		)

	fovFill.Size =
		UDim2.new(
			percent,
			0,
			1,
			0
		)

	fovKnob.Position =
		UDim2.new(
			percent,
			0,
			0.5,
			0
		)

end

fovSlider.InputBegan:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			fovDragging = true

			updateFOV(
				input.Position.X
			)

		end

	end
)



local sizeDragging = false

local function updateSize(mouseX)

	local percent =
		getPercent(
			mouseX,
			sizeSlider
		)

	crosshairSize =
		math.round(
			8 + percent * 92
		)

	sizeValue.Text =
		tostring(
			crosshairSize
		)

	sizeFill.Size =
		UDim2.new(
			percent,
			0,
			1,
			0
		)

	sizeKnob.Position =
		UDim2.new(
			percent,
			0,
			0.5,
			0
		)

	updateCrosshair()

end

sizeSlider.InputBegan:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			sizeDragging = true

			updateSize(
				input.Position.X
			)

		end

	end
)



local transparencyDragging = false

local function updateTransparency(mouseX)

	local percent =
		getPercent(
			mouseX,
			transparencySlider
		)

	crosshairTransparency =
		percent

	transparencyValue.Text =
		math.round(
			percent * 100
		) .. "%"

	transparencyFill.Size =
		UDim2.new(
			percent,
			0,
			1,
			0
		)

	transparencyKnob.Position =
		UDim2.new(
			percent,
			0,
			0.5,
			0
		)

	updateCrosshair()

end

transparencySlider.InputBegan:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			transparencyDragging = true

			updateTransparency(
				input.Position.X
			)

		end

	end
)



UserInputService.InputChanged:Connect(
	function(input)

		if input.UserInputType ~=
			Enum.UserInputType.MouseMovement then
			return
		end

		if fovDragging then

			updateFOV(
				input.Position.X
			)

		end

		if sizeDragging then

			updateSize(
				input.Position.X
			)

		end

		if transparencyDragging then

			updateTransparency(
				input.Position.X
			)

		end

	end
)

UserInputService.InputEnded:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			fovDragging = false
			sizeDragging = false
			transparencyDragging = false

		end

	end
)



local function optimizeObject(object)

	if object:IsA(
		"ParticleEmitter"
	) then

		object.Rate =
			math.min(
				object.Rate,
				10
			)

	elseif object:IsA("Trail") then

		object.Lifetime =
			math.min(
				object.Lifetime,
				0.15
			)

	elseif object:IsA("Beam") then

		object.Segments =
			math.min(
				object.Segments,
				2
			)

	elseif object:IsA(
		"PointLight"
	)
	or object:IsA(
		"SpotLight"
	)
	or object:IsA(
		"SurfaceLight"
	) then

		object.Shadows = false

	end

end

local function setFPSBoost(enabled)

	fpsBoostEnabled =
		enabled

	if enabled then

		Lighting.GlobalShadows =
			false

		Lighting.EnvironmentDiffuseScale =
			0

		Lighting.EnvironmentSpecularScale =
			0

		for _, object in ipairs(
			Workspace:GetDescendants()
		) do

			optimizeObject(
				object
			)

		end

	else

		Lighting.GlobalShadows =
			true

		Lighting.EnvironmentDiffuseScale =
			1

		Lighting.EnvironmentSpecularScale =
			1

	end

	fpsButton.Text =
		fpsBoostEnabled
		and "FPS BOOST: ON"
		or "FPS BOOST: OFF"

end

fpsButton.MouseButton1Click:Connect(
	function()

		setFPSBoost(
			not fpsBoostEnabled
		)

	end
)



local dragging = false
local dragStart
local startPosition

title.InputBegan:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			dragging = true

			dragStart =
				input.Position

			startPosition =
				window.Position

		end

	end
)

UserInputService.InputChanged:Connect(
	function(input)

		if not dragging then
			return
		end

		if input.UserInputType ~=
			Enum.UserInputType.MouseMovement then
			return
		end

		local delta =
			input.Position -
			dragStart

		window.Position =
			UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset
					+ delta.X,

				startPosition.Y.Scale,
				startPosition.Y.Offset
					+ delta.Y
			)

	end
)

UserInputService.InputEnded:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			dragging = false

		end

	end
)



local rightResize =
	Instance.new("Frame")

rightResize.Name =
	"RightBottomResize"

rightResize.Size =
	UDim2.fromOffset(
		22,
		22
	)

rightResize.Position =
	UDim2.new(
		1,
		-22,
		1,
		-22
	)

rightResize.BackgroundTransparency =
	1

rightResize.Active = true
rightResize.Parent = window

local leftResize =
	Instance.new("Frame")

leftResize.Name =
	"LeftBottomResize"

leftResize.Size =
	UDim2.fromOffset(
		22,
		22
	)

leftResize.Position =
	UDim2.new(
		0,
		0,
		1,
		-22
	)

leftResize.BackgroundTransparency =
	1

leftResize.Active = true
leftResize.Parent = window



local resizing = false
local resizeType = nil

local resizeStart
local resizeStartSize
local resizeStartPosition

local function beginResize(
	kind,
	input
)

	resizing = true
	resizeType = kind

	resizeStart =
		input.Position

	resizeStartSize =
		window.AbsoluteSize

	resizeStartPosition =
		window.Position

end

rightResize.InputBegan:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			beginResize(
				"RIGHT",
				input
			)

		end

	end
)

leftResize.InputBegan:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			beginResize(
				"LEFT",
				input
			)

		end

	end
)



UserInputService.InputChanged:Connect(
	function(input)

		if not resizing then
			return
		end

		if input.UserInputType ~=
			Enum.UserInputType.MouseMovement then
			return
		end

		local delta =
			input.Position -
			resizeStart


		if resizeType == "RIGHT" then

			local width =
				math.clamp(
					resizeStartSize.X
						+ delta.X,

					MIN_WIDTH,
					MAX_WIDTH
				)

			local height =
				math.clamp(
					resizeStartSize.Y
						+ delta.Y,

					MIN_HEIGHT,
					MAX_HEIGHT
				)

			window.Size =
				UDim2.fromOffset(
					width,
					height
				)


		elseif resizeType == "LEFT" then

			local width =
				math.clamp(
					resizeStartSize.X
						- delta.X,

					MIN_WIDTH,
					MAX_WIDTH
				)

			local height =
				math.clamp(
					resizeStartSize.Y
						+ delta.Y,

					MIN_HEIGHT,
					MAX_HEIGHT
				)

			local widthDifference =
				resizeStartSize.X
				- width

			window.Size =
				UDim2.fromOffset(
					width,
					height
				)

			window.Position =
				UDim2.new(
					resizeStartPosition.X.Scale,

					resizeStartPosition.X.Offset
						+ widthDifference,

					resizeStartPosition.Y.Scale,

					resizeStartPosition.Y.Offset
				)

		end

	end
)

UserInputService.InputEnded:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			resizing = false
			resizeType = nil

		end

	end
)



local closeText =
	Instance.new("TextLabel")

closeText.Size =
	UDim2.fromOffset(
		380,
		25
	)

closeText.Position =
	UDim2.fromOffset(
		15,
		465
	)

closeText.BackgroundTransparency =
	1

closeText.Text =
	"Mac's simple GUI, Press M to close"

closeText.TextColor3 =
	Color3.fromRGB(
		180,
		0,
		0
	)

closeText.TextSize = 14

closeText.Font =
	Enum.Font.Gotham

closeText.TextXAlignment =
	Enum.TextXAlignment.Center

closeText.Parent =
	content



UserInputService.InputBegan:Connect(
	function(input, gameProcessed)

		if gameProcessed then
			return
		end

		if input.KeyCode ==
			Enum.KeyCode.M then

			gui.Enabled =
				not gui.Enabled

			if gui.Enabled then

				UserInputService.MouseBehavior =
					Enum.MouseBehavior.Default

				UserInputService.MouseIconEnabled =
					true

			end

		end

	end
)



local camera =
	Workspace.CurrentCamera

if camera then
	camera.FieldOfView =
		currentFOV
	
end

local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
    Title = "Loaded",
    Text = "Mac's simple GUI loaded!",
    Duration = 5
})end
end

updateUIScale()
updateCrosshair()