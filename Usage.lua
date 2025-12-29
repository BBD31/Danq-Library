local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/BBD31/Danq-Library/refs/heads/main/Library.lua"))()

local ToggleKey = Enum.KeyCode.R

local Window = Library:Window({
	Title = "Danq-Library",
	Size = UDim2.new(0, 320, 0, 250),
	ToggleGuiVisiblity = ToggleKey,
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
	Mode = "Hold", -- Hold, Toggle, if you want to toggle the GUI, the ToggleGui function will always toggle it, even when once mode at keybind is enabled.
	Callback = function(Value, PressedKey)
		print("KeyBind:", Value, PressedKey)
	end
})

local SettingsTab = Window:AddTab({Title = "Settings"})

SettingsTab:AddLabel({
	Title = "Settings",
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

SettingsTab:AddKeybind({
	Title = "Toggle Gui Bind",
	Default = Enum.KeyCode.R,
	Mode = "Toggle",
	Callback = function(Value, PressedKey)
		Library:SetToggleKey(PressedKey)
	end
})
Library:Notify({
	Title = "123",
	Text = "Notify",
	Duration = 10
})


