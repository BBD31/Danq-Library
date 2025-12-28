local Library = require(game.ReplicatedStorage.Library)

local Window = Library:Window({
	Title = "Debug",
	Size = UDim2.new(0,320,0,250),
	ToggleGuiVisiblity = Enum.KeyCode.R
})

local MainTab = Window:AddTab({Title = "Main"})

MainTab:AddLabel({
	Title = "Hello, world"
})

MainTab:AddButton({
	Title = "Button",
	Callback = function()
		print("Button clicked!")
	end
})

MainTab:AddInput({
	Title = "Input",
	Text = "123",
	PlaceholderText = "Input",
	Callback = function(text)
		print("Float:", text)
	end
})

MainTab:AddToggle({
	Title = "Toggle",
	Default = false,
	Callback = function(state)
		print("Toggle:", state)
	end
})

local aa = MainTab:AddToggle({
	Title = "True State Toggle",
	Default = true,
	Callback = function(state)
		print("Toggle:", state)
	end
})

MainTab:AddDropdown({
	Title = "Drop Down",
	Options = {"Neck", "Hurts", "Knee", "Guard"},
	Default = 2,
	Multi = false,
	Callback = function(selected)
		print("Selected:", selected)
	end
})

MainTab:AddDropdown({
	Title = "Multi Drop Down",
	Options = {"Neck", "Hurts", "Knee", "Guard"},
	Default = {1,2},
	Multi = true,
	Callback = function(selected)
		print("Selected:", selected)
	end
})

MainTab:AddColorPicker({
	Title = "Pick Color",
	Default = Color3.fromRGB(255, 255, 255),
	Callback = function(color)
		print("Color: ", color)
	end
})

MainTab:AddSlider({
	Title = "Slider",
	Min = 0,
	Max = 100,
	Default = 50,
	Suffix = "%",
	Callback = function(value)
		print("Slider value:", value)
	end
})

MainTab:AddKeybind({
	Title = "KeyBind",
	Default = Enum.KeyCode.E,
	Mode = "Once",
	Callback = function(key)
		print("KeyBind:", key)
	end
})

local SettingsTab = Window:AddTab({Title = "Settings"})

SettingsTab:AddLabel({
	Title = "Theme Settings",
	TextColor = Color3.fromRGB(0, 255, 234)
})

SettingsTab:AddDropdown({
	Title = "Theme Manager",
	Options = {"Dark", "Purple", "Light"},
	Default = 1,
	Multi = false,
	Callback = function(selected)
		Library:SetTheme(selected)
	end
})
