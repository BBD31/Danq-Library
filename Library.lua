--[[
 ______   _______  _        _______         _       _________ ______   _______  _______  _______
(  __  \ (  ___  )( (    /|(  ___  )       ( \      \__   __/(  ___ \ (  ____ )(  ___  )(  ____ )|\     /|
| (  \  )| (   ) ||  \  ( || (   ) |       | (         ) (   | (   ) )| (    )|| (   ) || (    )|( \   / )
| |   ) || (___) ||   \ | || |   | | _____ | |         | |   | (__/ / | (____)|| (___) || (____)| \ (_) /
| |   | ||  ___  || (\ \) || |   | |(_____)| |         | |   |  __ (  |     __)|  ___  ||     __)  \   /
| |   ) || (   ) || | \   || | /\| |       | |         | |   | (  \ \ | (\ (   | (   ) || (\ (      ) (
| (__/  )| )   ( || )  \  || (_\ \ |       | (____/\___) (___| )___) )| ) \ \__| )   ( || ) \ \__   | |
(______/ |/     \||/    )_)(____\/_)       (_______/\_______/|/ \___/ |/   \__/|/     \||/   \__/   \_/

Library written in Lua(u) for GUI development
Released in 28.12.25 by BBD31 (GitHub) or qwayrr
]]--

local Library = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")

Library.Themes = {
	Dark = {
		MainBg = Color3.fromRGB(25, 25, 30),
		TopBar = Color3.fromRGB(45, 85, 135),
		TabBar = Color3.fromRGB(30, 30, 35),
		TabInactive = Color3.fromRGB(40, 75, 120),
		TabActive = Color3.fromRGB(55, 95, 145),
		ElementBg = Color3.fromRGB(35, 35, 42),
		Border = Color3.fromRGB(50, 50, 60),
		Accent = Color3.fromRGB(45, 85, 135),
		AccentHover = Color3.fromRGB(55, 105, 165),
		Text = Color3.fromRGB(240, 240, 240),
		TextDim = Color3.fromRGB(180, 180, 180),
		ToggleOn = Color3.fromRGB(106, 178, 255),
		ToggleOff = Color3.fromRGB(41, 76, 112)
	},
	Light = {
		MainBg = Color3.fromRGB(240, 240, 245),
		TopBar = Color3.fromRGB(100, 140, 200),
		TabBar = Color3.fromRGB(220, 220, 230),
		TabInactive = Color3.fromRGB(153, 153, 170),
		TabActive = Color3.fromRGB(100, 140, 200),
		ElementBg = Color3.fromRGB(250, 250, 255),
		Border = Color3.fromRGB(200, 200, 210),
		Accent = Color3.fromRGB(100, 140, 200),
		AccentHover = Color3.fromRGB(120, 160, 220),
		Text = Color3.fromRGB(20, 20, 20),
		TextDim = Color3.fromRGB(100, 100, 100),
		ToggleOn = Color3.fromRGB(76, 166, 255),
		ToggleOff = Color3.fromRGB(66, 66, 66)
	},
	Purple = {
		MainBg = Color3.fromRGB(25, 20, 30),
		TopBar = Color3.fromRGB(100, 60, 140),
		TabBar = Color3.fromRGB(30, 25, 35),
		TabInactive = Color3.fromRGB(80, 50, 110),
		TabActive = Color3.fromRGB(110, 70, 150),
		ElementBg = Color3.fromRGB(35, 30, 42),
		Border = Color3.fromRGB(60, 50, 70),
		Accent = Color3.fromRGB(100, 60, 140),
		AccentHover = Color3.fromRGB(120, 80, 160),
		Text = Color3.fromRGB(240, 240, 240),
		TextDim = Color3.fromRGB(180, 180, 180),
		ToggleOn = Color3.fromRGB(191, 127, 255),
		ToggleOff = Color3.fromRGB(64, 43, 86)
	}
}

Library.CurrentTheme = Library.Themes.Dark
Library.ThemedObjects = {}

local function CreateInstance(ClassName, Properties)
	local Instance = Instance.new(ClassName)

	for Property, Value in pairs(Properties) do
		Instance[Property] = Value

		if typeof(Value) == "Color3" then
			for ThemeKey, ThemeColor in pairs(Library.CurrentTheme) do
				if Value == ThemeColor then
					table.insert(Library.ThemedObjects, {
						Instance = Instance,
						Property = Property,
						ThemeKey = ThemeKey
					})
					break
				end
			end
		end
	end
	
	return Instance
end

function Library:SetTheme(ThemeName)
	local Theme = Library.Themes[ThemeName]
	if not Theme then 
		return 
	end
	Library.CurrentTheme = Theme
	
	for _, ThemeObject in ipairs(Library.ThemedObjects) do
		if ThemeObject.Instance and ThemeObject.Instance.Parent and ThemeObject.Property then
			ThemeObject.Instance[ThemeObject.Property] = Theme[ThemeObject.ThemeKey]
		end
	end
	return {}
end

function Library:Window(Config)
	local Title = Config.Title
	local Size = Config.Size or UDim2.new(0, 300, 0, 200)
	local Theme = Library.CurrentTheme

	local Gui = CreateInstance("ScreenGui", {
		Name = "Danq Library",
		Parent = game.CoreGui or LocalPlayer:FindFirstChild("PlayerGui"),
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	})

	local Main = CreateInstance("Frame", {
		Name = "Main",
		Parent = Gui,
		Active = true,
		BackgroundColor3 = Theme.MainBg,
		BorderSizePixel = 1,
		BorderColor3 = Theme.TopBar,
		Position = UDim2.new(0.3, 0, 0.3, 0),
		Size = Size,
		ClipsDescendants = false
	})

	CreateInstance("UICorner", {
		Parent = Main, 
		CornerRadius = UDim.new(0, 2)
	})

	local TopBar = CreateInstance("Frame", {
		Name = "TopBar",
		Parent = Main,
		BackgroundColor3 = Theme.TopBar,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 28)
	})

	CreateInstance("UICorner", {
		Parent = TopBar, 
		CornerRadius = UDim.new(0, 2)
	})

	local TitleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = TopBar,
		Text = "▼ " .. Title,
		Font = Enum.Font.Code,
		TextSize = 14,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 8, 0, 0),
		Size = UDim2.new(1, -60, 1, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center
	})

	local MinimizeBtn = CreateInstance("TextButton", {
		Name = "MinimizeBtn",
		Parent = TopBar,
		Text = "-",
		BackgroundTransparency = 1,
		Font = Enum.Font.Code,
		TextSize = 16,
		TextColor3 = Color3.fromRGB(220, 220, 220),
		BackgroundColor3 = Theme.Accent,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -52, 0, 6),
		Size = UDim2.new(0, 22, 0, 16)
	})

	CreateInstance("UICorner", {
		Parent = MinimizeBtn, 
		CornerRadius = UDim.new(0, 2)
	})

	local CloseBtn = CreateInstance("TextButton", {
		Name = "CloseBtn",
		Parent = TopBar,
		Text = "×",
		BackgroundTransparency = 1,
		Font = Enum.Font.Code,
		TextSize = 18,
		TextColor3 = Color3.fromRGB(220, 220, 220),
		BackgroundColor3 = Theme.Accent,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -26, 0, 6),
		Size = UDim2.new(0, 22, 0, 16)
	})

	CreateInstance("UICorner", {
		Parent = CloseBtn, 
		CornerRadius = UDim.new(0, 2)
	})

	local Minimized = false
	local SavedSize = Main.Size

	local TabHolder = CreateInstance("Frame", {
		Name = "TabHolder",
		Parent = Main,
		BackgroundColor3 = Theme.TabBar,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 28),
		Size = UDim2.new(1, 0, 0, 26)
	})

	local ScrollTab = CreateInstance("ScrollingFrame", {
		Name = "ScrollTab",
		Parent = TabHolder,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 0,
		Size = UDim2.new(1, 0, 1, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.X
	})

	CreateInstance("UIListLayout", {
		Parent = ScrollTab,
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 2),
		SortOrder = Enum.SortOrder.LayoutOrder
	})

	CreateInstance("UIPadding", {
		Parent = ScrollTab,
		PaddingLeft = UDim.new(0, 6),
		PaddingTop = UDim.new(0, 3)
	})

	local ContentContainer = CreateInstance("Frame", {
		Name = "ContentContainer",
		Parent = Main,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 54),
		Size = UDim2.new(1, 0, 1, -54)
	})

	local ResizeCorner = CreateInstance("Frame", {
		Name = "ResizeCorner",
		Parent = Main,
		BackgroundColor3 = Theme.TopBar,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -10, 1, -10),
		Size = UDim2.new(0, 10, 0, 10),
		ZIndex = 10
	})

	CreateInstance("UICorner", {
		Parent = ResizeCorner, 
		CornerRadius = UDim.new(0, 2)
	})

	MinimizeBtn.MouseButton1Click:Connect(function()
		Minimized = not Minimized

		if Minimized then
			SavedSize = Main.Size
			TabHolder.Visible = false
			ContentContainer.Visible = false
			ResizeCorner.Visible = false
			Main.Size = UDim2.new(Main.Size.X.Scale, Main.Size.X.Offset, 0, 28)
			MinimizeBtn.Text = "+"
			TitleLabel.Text = "▶ " .. Title
		else
			Main.Size = SavedSize
			TabHolder.Visible = true
			ContentContainer.Visible = true
			ResizeCorner.Visible = true
			MinimizeBtn.Text = "-"
			TitleLabel.Text = "▼ " .. Title
		end
	end)

	CloseBtn.MouseButton1Click:Connect(function()
		Gui:Destroy()
	end)

	MinimizeBtn.MouseEnter:Connect(function()
		MinimizeBtn.BackgroundColor3 = Library.CurrentTheme.AccentHover
	end)

	MinimizeBtn.MouseLeave:Connect(function()
		MinimizeBtn.BackgroundColor3 = Library.CurrentTheme.Accent
	end)

	CloseBtn.MouseEnter:Connect(function()
		CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
	end)

	CloseBtn.MouseLeave:Connect(function()
		CloseBtn.BackgroundColor3 = Library.CurrentTheme.Accent
	end)

	local Dragging, DragStart, StartPos

	TopBar.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = true
			DragStart = Input.Position
			StartPos = Main.Position
		end
	end)

	TopBar.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
			local Delta = Input.Position - DragStart
			Main.Position = UDim2.new(
				StartPos.X.Scale, 
				StartPos.X.Offset + Delta.X, 
				StartPos.Y.Scale, 
				StartPos.Y.Offset + Delta.Y
			)
		end
	end)

	local Resizing, ResizeStart, ResizeStartSize

	local ResizeDetector = CreateInstance("TextButton", {
		Parent = ResizeCorner,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 10, 1, 10),
		Position = UDim2.new(0, -5, 0, -5),
		Text = "",
		ZIndex = 11
	})

	ResizeDetector.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Resizing = true
			ResizeStart = Input.Position
			ResizeStartSize = Main.Size
		end
	end)

	ResizeDetector.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Resizing = false
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if Resizing and Input.UserInputType == Enum.UserInputType.MouseMovement then
			local Delta = Input.Position - ResizeStart
			local NewWidth = math.max(250, ResizeStartSize.X.Offset + Delta.X)
			local NewHeight = math.max(150, ResizeStartSize.Y.Offset + Delta.Y)
			Main.Size = UDim2.new(0, NewWidth, 0, NewHeight)

			if not Minimized then
				SavedSize = Main.Size
			end
		end
	end)

	local Tabs = {}
	local ActiveTab

	local function SwitchTab(Tab)
		if ActiveTab then
			ActiveTab.Button.BackgroundColor3 = Library.CurrentTheme.TabInactive
			ActiveTab.Content.Visible = false
		end

		ActiveTab = Tab
		Tab.Button.BackgroundColor3 = Library.CurrentTheme.TabActive
		Tab.Content.Visible = true
	end

	local WindowObject = {}

	function WindowObject:AddTab(TabData)
		local TabName = TabData.Title

		local TabButton = CreateInstance("TextButton", {
			Parent = ScrollTab,
			Text = TabName,
			Font = Enum.Font.Code,
			TextSize = 13,
			TextColor3 = Theme.Text,
			BackgroundColor3 = Theme.TabInactive,
			Size = UDim2.new(0, 80, 0, 20),
			BorderSizePixel = 0,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextScaled = false,
			TextWrapped = false,
			TextTruncate = Enum.TextTruncate.None,
			RichText = false
		})

		local function ResizeTab()
			local TextBounds = TextService:GetTextSize(
				TabButton.Text,
				TabButton.TextSize,
				TabButton.Font,
				Vector2.new(1000, 100)
			)
			local Padding = 20
			TabButton.Size = UDim2.new(0, math.max(TextBounds.X + Padding, 60), 0, 26)
		end

		ResizeTab()
		TabButton:GetPropertyChangedSignal("Text"):Connect(ResizeTab)

		CreateInstance("UICorner", {
			Parent = TabButton, 
			CornerRadius = UDim.new(0, 2)
		})

		local Content = CreateInstance("ScrollingFrame", {
			Parent = ContentContainer,
			Visible = false,
			Active = true,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarThickness = 0,
			ScrollBarImageColor3 = Theme.TopBar,
			Size = UDim2.new(1, 0, 1, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ClipsDescendants = true,
		})

		CreateInstance("UIListLayout", {
			Parent = Content,
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder
		})

		CreateInstance("UIPadding", {
			Parent = Content,
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10),
			PaddingTop = UDim.new(0, 10),
			PaddingBottom = UDim.new(0, 10)
		})

		local TabObject = {
			Button = TabButton, 
			Content = Content
		}

		function TabObject:AddLabel(Info)
			local Label = CreateInstance("TextLabel", {
				Parent = Content,
				Text = Info.Title,
				Font = Enum.Font.Code,
				TextColor3 = Info.TextColor or Theme.TextDim,
				TextSize = 13,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 22),
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center
			})

			return Label
		end

		function TabObject:AddButton(Info)
			local Button = CreateInstance("TextButton", {
				Parent = Content,
				Text = Info.Title,
				Font = Enum.Font.Code,
				TextSize = 13,
				TextColor3 = Theme.Text,
				BackgroundColor3 = Theme.Accent,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 24)
			})

			CreateInstance("UICorner", {
				Parent = Button, 
				CornerRadius = UDim.new(0, 2)
			})

			Button.MouseButton1Click:Connect(function()
				if Info.Callback then 
					Info.Callback() 
				end
			end)

			Button.MouseEnter:Connect(function()
				Button.BackgroundColor3 = Library.CurrentTheme.AccentHover
			end)

			Button.MouseLeave:Connect(function()
				Button.BackgroundColor3 = Library.CurrentTheme.Accent
			end)

			return Button
		end

		function TabObject:AddToggle(Info)
			local ToggleState = Info.Default or false

			local Container = CreateInstance("Frame", {
				Parent = Content,
				BackgroundColor3 = Theme.ElementBg,
				BorderSizePixel = 1,
				BorderColor3 = Theme.Border,
				Size = UDim2.new(1, 0, 0, 24)
			})

			CreateInstance("UICorner", {
				Parent = Container, 
				CornerRadius = UDim.new(0, 2)
			})

			local ToggleButton = CreateInstance("TextButton", {
				Parent = Container,
				Text = "",
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0)
			})

			local Label = CreateInstance("TextLabel", {
				Parent = ToggleButton,
				Text = Info.Title,
				Font = Enum.Font.Code,
				TextSize = 13,
				TextColor3 = Theme.Text,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 28, 0, 0),
				Size = UDim2.new(1, -40, 1, 0),
				TextXAlignment = Enum.TextXAlignment.Left
			})

			local InitialColor
			if ToggleState then
				InitialColor = Theme.ToggleOn
			else
				InitialColor = Theme.ToggleOff
			end

			local StatusIndicator = CreateInstance("Frame", {
				Parent = ToggleButton,
				BackgroundColor3 = InitialColor,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 6, 0.2, 0),
				Size = UDim2.new(0, 15, 0, 15)
			})

			CreateInstance("UICorner", {
				Parent = StatusIndicator, 
				CornerRadius = UDim.new(0, 2)
			})

			ToggleButton.MouseButton1Click:Connect(function()
				ToggleState = not ToggleState
				if ToggleState then
					StatusIndicator.BackgroundColor3 = Library.CurrentTheme.ToggleOn
				else
					StatusIndicator.BackgroundColor3 = Library.CurrentTheme.ToggleOff
				end
				if Info.Callback then 
					Info.Callback(ToggleState) 
				end
			end)

			return Container
		end

		function TabObject:AddDropdown(Info)
			local Multi = Info.Multi or false
			local MaxVisible = 5
			local Options = Info.Options or {}
			local GuiRoot = Gui
			local SelectedSet = {}
			local SelectedSingle = nil

			if Multi then
				if Info.Default then
					local Defaults = type(Info.Default) == "table" and Info.Default or {Info.Default}
					for _, V in ipairs(Defaults) do
						if type(V) == "number" and Options[V] then
							SelectedSet[V] = true
						elseif type(V) == "string" then
							for Idx, Name in ipairs(Options) do
								if Name == V then
									SelectedSet[Idx] = true
								end
							end
						end
					end
				end
			else
				if Info.Default then
					if type(Info.Default) == "number" and Options[Info.Default] then
						SelectedSingle = Info.Default
					elseif type(Info.Default) == "string" then
						for Idx, Name in ipairs(Options) do
							if Name == Info.Default then
								SelectedSingle = Idx
								break
							end
						end
					end
				else
					SelectedSingle = 1
				end
			end

			local Container = CreateInstance("Frame", {
				Parent = Content,
				BackgroundColor3 = Theme.ElementBg,
				BorderColor3 = Theme.Border,
				BorderSizePixel = 1,
				Size = UDim2.new(1, 0, 0, 24),
				ClipsDescendants = false,
				ZIndex = 1,
			})

			CreateInstance("UICorner", {
				Parent = Container, 
				CornerRadius = UDim.new(0, 6)
			})

			local Header = CreateInstance("TextButton", {
				Parent = Container,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -22, 1, 0),
				Text = "",
				TextColor3 = Theme.Text,
				Font = Enum.Font.Code,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				AutoButtonColor = false,
				ZIndex = 2,
			})

			CreateInstance("UIPadding", {
				Parent = Header, 
				PaddingLeft = UDim.new(0, 8)
			})

			local Arrow = CreateInstance("TextLabel", {
				Parent = Container,
				Text = "▼",
				TextColor3 = Theme.TextDim,
				Font = Enum.Font.Code,
				TextSize = 12,
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -5, 0.5, 0),
				Size = UDim2.new(0, 20, 0, 20),
				ZIndex = 2,
			})

			local function BuildHeader()
				if Multi then
					local List = {}
					for Idx, _ in pairs(SelectedSet) do
						if Options[Idx] then 
							table.insert(List, Options[Idx]) 
						end
					end
					if #List == 0 then
						return (Info.Title or "") .. ": None"
					end
					return (Info.Title or "") .. ": " .. table.concat(List, ", ")
				else
					return (Info.Title or "") .. ": " .. (Options[SelectedSingle] or "None")
				end
			end

			Header.Text = BuildHeader()

			local Dropdown = CreateInstance("Frame", {
				Parent = GuiRoot,
				BackgroundColor3 = Theme.ElementBg,
				BorderColor3 = Theme.TopBar,
				BorderSizePixel = 1,
				Visible = false,
				ClipsDescendants = true,
				ZIndex = 100,
			})

			CreateInstance("UICorner", {
				Parent = Dropdown, 
				CornerRadius = UDim.new(0, 6)
			})

			local Scroll = CreateInstance("ScrollingFrame", {
				Parent = Dropdown,
				Active = true,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ScrollBarThickness = 6,
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 101,
			})

			CreateInstance("UIListLayout", {
				Parent = Scroll, 
				Padding = UDim.new(0, 2), 
				SortOrder = Enum.SortOrder.LayoutOrder
			})

			local OptionButtons = {}

			local function RefreshHighlights()
				for I, Btn in ipairs(OptionButtons) do
					if Multi then
						Btn.BackgroundColor3 = SelectedSet[I] and Library.CurrentTheme.Accent or Library.CurrentTheme.ElementBg
					else
						Btn.BackgroundColor3 = (SelectedSingle == I) and Library.CurrentTheme.Accent or Library.CurrentTheme.ElementBg
					end
				end
			end

			for I, Opt in ipairs(Options) do
				local BtnColor
				if Multi then
					BtnColor = SelectedSet[I] and Theme.Accent or Theme.ElementBg
				else
					BtnColor = (SelectedSingle == I) and Theme.Accent or Theme.ElementBg
				end

				local Btn = CreateInstance("TextButton", {
					Parent = Scroll,
					Text = Opt,
					Font = Enum.Font.Code,
					TextSize = 13,
					TextColor3 = Theme.Text,
					BackgroundColor3 = BtnColor,
					BorderSizePixel = 0,
					Size = UDim2.new(1, -8, 0, 22),
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 102,
					AutoButtonColor = false,
				})

				CreateInstance("UIPadding", {
					Parent = Btn, 
					PaddingLeft = UDim.new(0, 8)
				})

				table.insert(OptionButtons, Btn)

				Btn.MouseEnter:Connect(function()
					if (Multi and not SelectedSet[I]) or (not Multi and SelectedSingle ~= I) then
						Btn.BackgroundColor3 = Library.CurrentTheme.AccentHover
					end
				end)

				Btn.MouseLeave:Connect(function()
					RefreshHighlights()
				end)

				Btn.MouseButton1Click:Connect(function()
					if Multi then
						if SelectedSet[I] then 
							SelectedSet[I] = nil 
						else 
							SelectedSet[I] = true 
						end
						Header.Text = BuildHeader()
						RefreshHighlights()
						if Info.Callback then
							local Res = {}
							for Id, _ in pairs(SelectedSet) do
								table.insert(Res, Options[Id])
							end
							Info.Callback(Res)
						end
					else
						SelectedSingle = I
						Header.Text = BuildHeader()
						RefreshHighlights()
						if Info.Callback then 
							Info.Callback(Options[SelectedSingle]) 
						end
						Dropdown.Visible = false
						Arrow.Text = "▼"
					end
				end)
			end

			local Opened = false
			local RenderConn = nil
			local Blocker = nil

			local function OpenDropdown()
				Opened = true
				Dropdown.Visible = true
				Arrow.Text = "▲"
				Content.ScrollingEnabled = false

				local AbsPos = Container.AbsolutePosition
				local AbsSize = Container.AbsoluteSize
				local ListHeight = math.min(#Options, MaxVisible) * 22
				local Viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
				local BottomY = AbsPos.Y + AbsSize.Y + ListHeight + 4

				if BottomY > Viewport.Y then
					Dropdown.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y - ListHeight - 4)
				else
					Dropdown.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y + AbsSize.Y + 2)
				end

				Dropdown.Size = UDim2.new(0, AbsSize.X, 0, ListHeight)
				Scroll.CanvasSize = UDim2.new(0, 0, 0, #Options * 22)
				RefreshHighlights()

				RenderConn = RunService.RenderStepped:Connect(function()
					local Ap = Container.AbsolutePosition
					local Asz = Container.AbsoluteSize
					local ListH = math.min(#Options, MaxVisible) * 22
					local Vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
					local By = Ap.Y + Asz.Y + ListH + 4

					if By > Vp.Y then
						Dropdown.Position = UDim2.new(0, Ap.X, 0, Ap.Y - ListH - 4)
					else
						Dropdown.Position = UDim2.new(0, Ap.X, 0, Ap.Y + Asz.Y + 2)
					end

					Dropdown.Size = UDim2.new(0, Asz.X, 0, ListH)
				end)

				Blocker = CreateInstance("TextButton", {
					Parent = GuiRoot,
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0, 0, 0, 0),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 50,
					AutoButtonColor = false,
					Text = "",
				})

				Blocker.MouseButton1Click:Connect(function()
					Dropdown.Visible = false
					Arrow.Text = "▼"
					Opened = false
					Content.ScrollingEnabled = true
					if RenderConn then 
						RenderConn:Disconnect()
						RenderConn = nil 
					end
					if Blocker then 
						Blocker:Destroy()
						Blocker = nil 
					end
				end)
			end

			local function CloseDropdown()
				Opened = false
				Dropdown.Visible = false
				Arrow.Text = "▼"
				Content.ScrollingEnabled = true
				if RenderConn then 
					RenderConn:Disconnect()
					RenderConn = nil 
				end
				if Blocker then 
					Blocker:Destroy()
					Blocker = nil 
				end
			end

			Header.MouseButton1Click:Connect(function()
				if Opened then
					CloseDropdown()
				else
					OpenDropdown()
				end
			end)

			return Container
		end

		function TabObject:AddSlider(Info)
			local Min = Info.Min
			local Max = Info.Max 
			local Default = Info.Default
			local Suffix = Info.Suffix or ""
			local CurrentValue = Default

			local Container = CreateInstance("Frame", {
				Parent = Content,
				BackgroundColor3 = Theme.ElementBg,
				BorderSizePixel = 1,
				BorderColor3 = Theme.Border,
				Size = UDim2.new(1, 0, 0, 50)
			})

			CreateInstance("UICorner", {
				Parent = Container, 
				CornerRadius = UDim.new(0, 2)
			})

			local Label = CreateInstance("TextLabel", {
				Parent = Container,
				Text = Info.Title,
				Font = Enum.Font.Code,
				TextSize = 13,
				TextColor3 = Theme.Text,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 8, 0, 2),
				Size = UDim2.new(0.6, 0, 0, 16),
				TextXAlignment = Enum.TextXAlignment.Left
			})

			local ValueBox = CreateInstance("TextBox", {
				Parent = Container,
				Text = tostring(Default)..Suffix,
				Font = Enum.Font.Code,
				TextSize = 13,
				TextColor3 = Theme.Text,
				BackgroundColor3 = Theme.MainBg,
				BackgroundTransparency = 0,
				Position = UDim2.new(0.65, 0, 0, 2),
				Size = UDim2.new(0.35, -8, 0, 16),
				TextXAlignment = Enum.TextXAlignment.Center
			})

			CreateInstance("UICorner", {
				Parent = ValueBox, 
				CornerRadius = UDim.new(0, 2)
			})

			local SliderBack = CreateInstance("Frame", {
				Parent = Container,
				BackgroundColor3 = Theme.MainBg,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 8, 0, 22),
				Size = UDim2.new(1, -16, 0, 12)
			})

			CreateInstance("UICorner", {
				Parent = SliderBack, 
				CornerRadius = UDim.new(0, 2)
			})

			local SliderFill = CreateInstance("Frame", {
				Parent = SliderBack,
				BackgroundColor3 = Theme.Accent,
				BorderSizePixel = 0,
				Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)
			})

			CreateInstance("UICorner", {
				Parent = SliderFill, 
				CornerRadius = UDim.new(0, 2)
			})

			local SliderButton = CreateInstance("TextButton", {
				Parent = SliderBack,
				Text = "",
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0)
			})

			local Dragging = false

			local function UpdateSlider(Value)
				CurrentValue = math.clamp(Value, Min, Max)
				SliderFill.Size = UDim2.new((CurrentValue - Min) / (Max - Min), 0, 1, 0)
				ValueBox.Text = tostring(CurrentValue)..Suffix
				if Info.Callback then 
					Info.Callback(CurrentValue) 
				end
			end

			SliderButton.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
					Dragging = true 
				end
			end)

			SliderButton.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
					Dragging = false 
				end
			end)

			UserInputService.InputChanged:Connect(function(Input)
				if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
					local MousePos = Input.Position.X
					local SliderPos = SliderBack.AbsolutePosition.X
					local SliderSize = SliderBack.AbsoluteSize.X
					local RelativePos = math.clamp((MousePos - SliderPos) / SliderSize, 0, 1)
					local Value = math.floor(Min + (Max - Min) * RelativePos)
					UpdateSlider(Value)
				end
			end)

			ValueBox.Focused:Connect(function()
				ValueBox.Text = ""
			end)

			ValueBox.FocusLost:Connect(function()
				local Text = tonumber(ValueBox.Text)
				if Text then
					UpdateSlider(Text)
				else
					UpdateSlider(CurrentValue)
				end
			end)

			return Container
		end

		function TabObject:AddInput(Info)
			local Container = CreateInstance("Frame", {
				Parent = Content,
				BackgroundColor3 = Theme.ElementBg,
				BorderSizePixel = 1,
				BorderColor3 = Theme.Border,
				Size = UDim2.new(1, 0, 0, 24)
			})

			CreateInstance("UICorner", {
				Parent = Container, 
				CornerRadius = UDim.new(0, 2)
			})

			local Label = CreateInstance("TextLabel", {
				Parent = Container,
				Text = Info.Title,
				Font = Enum.Font.Code,
				TextSize = 13,
				TextColor3 = Theme.Text,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 8, 0, 0),
				Size = UDim2.new(0.4, -8, 1, 0), 
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 2
			})

			local Input = CreateInstance("TextBox", {
				Parent = Container,
				Text = Info.Text or "",
				Font = Enum.Font.Code,
				TextSize = 13,
				TextColor3 = Theme.Text,
				BackgroundColor3 = Theme.MainBg,
				BackgroundTransparency = 0, 
				PlaceholderText = Info.PlaceholderText,
				PlaceholderColor3 = Theme.TextDim,
				ClearTextOnFocus = Info.ClearTextOnFocus,
				Position = UDim2.new(0.4, 8, 0, 3),
				Size = UDim2.new(0.6, -8, 1, -6), 
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 2
			})

			CreateInstance("UIPadding", {
				Parent = Input,
				PaddingLeft = UDim.new(0, 4)
			})

			CreateInstance("UICorner", {
				Parent = Input, 
				CornerRadius = UDim.new(0, 6)
			})

			Input.FocusLost:Connect(function()
				if Info.Callback then 
					Info.Callback(Input.Text) 
				end
			end)

			return Container
		end	

		function TabObject:AddColorPicker(Info)
			local CurrentColor = Info.Default
			local H, S, V = Color3.toHSV(CurrentColor)
			local Expanded = false
			local OriginalColor = CurrentColor
			local OriginalH, OriginalS, OriginalV = H, S, V

			local Container = CreateInstance("Frame", {
				Parent = Content,
				BackgroundColor3 = Theme.ElementBg,
				BorderSizePixel = 1,
				BorderColor3 = Theme.Border,
				Size = UDim2.new(1, 0, 0, 24),
				ClipsDescendants = true,
				ZIndex = 1
			})

			CreateInstance("UICorner", {
				Parent = Container, 
				CornerRadius = UDim.new(0, 2)
			})

			local Header = CreateInstance("TextButton", {
				Parent = Container,
				Text = "",
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 24),
				ZIndex = 2
			})

			local Label = CreateInstance("TextLabel", {
				Parent = Header,
				Text = Info.Title,
				Font = Enum.Font.Code,
				TextSize = 13,
				TextColor3 = Theme.Text,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 8, 0, 0),
				Size = UDim2.new(1, -50, 1, 0),
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 2
			})

			local ColorDisplay = CreateInstance("Frame", {
				Parent = Header,
				BackgroundColor3 = CurrentColor,
				BorderSizePixel = 1,
				BorderColor3 = Theme.Border,
				Position = UDim2.new(1, -40, 0, 4),
				Size = UDim2.new(0, 34, 0, 16),
				ZIndex = 2
			})

			CreateInstance("UICorner", {
				Parent = ColorDisplay, 
				CornerRadius = UDim.new(0, 2)
			})

			local PickerFrame = CreateInstance("Frame", {
				Parent = Container,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 8, 0, 30),
				Size = UDim2.new(1, -16, 0, 140),
				ZIndex = 2
			})

			local SV = CreateInstance("Frame", {
				Parent = PickerFrame,
				Size = UDim2.new(0, 100, 0, 100),
				BackgroundColor3 = Color3.fromHSV(H, 1, 1),
				BorderColor3 = Theme.Border,
				ZIndex = 3
			})

			CreateInstance("UICorner", {
				Parent = SV, 
				CornerRadius = UDim.new(0, 2)
			})

			local Sat = CreateInstance("Frame", {
				Parent = SV, 
				Size = UDim2.new(1, 0, 1, 0), 
				BackgroundColor3 = Color3.new(1, 1, 1)
			})

			local G1 = Instance.new("UIGradient", Sat)
			G1.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0), 
				NumberSequenceKeypoint.new(1, 1)
			}

			local Val = CreateInstance("Frame", {
				Parent = SV, 
				Size = UDim2.new(1, 0, 1, 0), 
				BackgroundColor3 = Color3.new(0, 0, 0)
			})

			local G2 = Instance.new("UIGradient", Val)
			G2.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 1), 
				NumberSequenceKeypoint.new(1, 0)
			}
			G2.Rotation = 90

			local SVDot = CreateInstance("Frame", {
				Parent = SV,
				Size = UDim2.new(0, 8, 0, 8),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BorderColor3 = Color3.new(0, 0, 0),
				ZIndex = 10
			})

			CreateInstance("UICorner", {
				Parent = SVDot, 
				CornerRadius = UDim.new(0, 2)
			})

			local Hue = CreateInstance("Frame", {
				Parent = PickerFrame,
				Position = UDim2.new(0, 108, 0, 0),
				Size = UDim2.new(0, 8, 0, 100),
				BorderColor3 = Theme.Border,
				ZIndex = 3
			})

			CreateInstance("UICorner", {
				Parent = Hue, 
				CornerRadius = UDim.new(0, 2)
			})

			local HueGradient = Instance.new("UIGradient", Hue)
			HueGradient.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
				ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
				ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
				ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
				ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
			}
			HueGradient.Rotation = 90

			local HueDot = CreateInstance("Frame", {
				Parent = Hue,
				Size = UDim2.new(1, 0, 0, 3),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BorderColor3 = Color3.new(0, 0, 0),
				ZIndex = 10
			})

			CreateInstance("UICorner", {
				Parent = HueDot, 
				CornerRadius = UDim.new(0, 100)
			})

			local InfoBox = CreateInstance("TextLabel", {
				Parent = PickerFrame,
				Position = UDim2.new(0, 125, 0, 0),
				Size = UDim2.new(1, -125, 0, 100),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				Font = Enum.Font.Code,
				TextSize = 12,
				TextColor3 = Theme.Text,
				ZIndex = 5
			})

			local ApplyBtn = CreateInstance("TextButton", {
				Parent = PickerFrame,
				Text = "Apply",
				Font = Enum.Font.Code,
				TextSize = 13,
				TextColor3 = Theme.Text,
				BackgroundColor3 = Theme.Accent,
				Size = UDim2.new(0.5, -4, 0, 22),
				Position = UDim2.new(0, 0, 1, -2),
				AnchorPoint = Vector2.new(0, 1),
				BorderSizePixel = 0,
				ZIndex = 5
			})

			CreateInstance("UICorner", {
				Parent = ApplyBtn, 
				CornerRadius = UDim.new(0, 2)
			})

			local CancelBtn = CreateInstance("TextButton", {
				Parent = PickerFrame,
				Text = "Cancel",
				Font = Enum.Font.Code,
				TextSize = 13,
				TextColor3 = Theme.Text,
				BackgroundColor3 = Theme.Accent,
				Size = UDim2.new(0.5, -4, 0, 22),
				Position = UDim2.new(1, 0, 1, -2),
				AnchorPoint = Vector2.new(1, 1),
				BorderSizePixel = 0,
				ZIndex = 5
			})

			CreateInstance("UICorner", {
				Parent = CancelBtn, 
				CornerRadius = UDim.new(0, 2)
			})

			local function Update()
				CurrentColor = Color3.fromHSV(H, S, V)
				ColorDisplay.BackgroundColor3 = CurrentColor
				SV.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
				SVDot.Position = UDim2.new(S, -4, 1 - V, -4)
				HueDot.Position = UDim2.new(0, 0, H * 100 / 100, -1)
				local R = math.floor(CurrentColor.R * 255)
				local G = math.floor(CurrentColor.G * 255)
				local B = math.floor(CurrentColor.B * 255)
				local Hex = string.format("#%02X%02X%02X", R, G, B)
				InfoBox.Text = "H: "..math.floor(H * 360).."\nS: "..math.floor(S * 100).."%\nV: "..math.floor(V * 100).."%\n\nR: "..R.."\nG: "..G.."\nB: "..B.."\nHEX: "..Hex
			end

			local DraggingSV = false
			local DraggingH = false

			SV.InputBegan:Connect(function(I)
				if I.UserInputType == Enum.UserInputType.MouseButton1 or I.UserInputType == Enum.UserInputType.Touch then 
					DraggingSV = true 
				end
			end)

			Hue.InputBegan:Connect(function(I)
				if I.UserInputType == Enum.UserInputType.MouseButton1 or I.UserInputType == Enum.UserInputType.Touch then 
					DraggingH = true 
				end
			end)

			UserInputService.InputEnded:Connect(function(I)
				if I.UserInputType == Enum.UserInputType.MouseButton1 or I.UserInputType == Enum.UserInputType.Touch then 
					DraggingSV = false 
					DraggingH = false 
				end
			end)

			UserInputService.InputChanged:Connect(function(I)
				if I.UserInputType ~= Enum.UserInputType.MouseMovement and I.UserInputType ~= Enum.UserInputType.Touch then 
					return 
				end
				if DraggingSV then
					local X = math.clamp((I.Position.X - SV.AbsolutePosition.X) / SV.AbsoluteSize.X, 0, 1)
					local Y = math.clamp((I.Position.Y - SV.AbsolutePosition.Y) / SV.AbsoluteSize.Y, 0, 1)
					S = X
					V = 1 - Y
					Update()
				elseif DraggingH then
					local Y = math.clamp((I.Position.Y - Hue.AbsolutePosition.Y) / Hue.AbsoluteSize.Y, 0, 1)
					H = Y
					Update()
				end
			end)

			ApplyBtn.MouseButton1Click:Connect(function()
				OriginalColor = CurrentColor
				OriginalH, OriginalS, OriginalV = H, S, V
				Expanded = false
				Container.Size = UDim2.new(1, 0, 0, 24)
				Container.ClipsDescendants = true
				if Info.Callback then 
					Info.Callback(CurrentColor) 
				end
			end)

			CancelBtn.MouseButton1Click:Connect(function()
				CurrentColor = OriginalColor
				H, S, V = OriginalH, OriginalS, OriginalV
				SVDot.Position = UDim2.new(S, -4, 1 - V, -4)
				HueDot.Position = UDim2.new(0, 0, H * 100 / 100, -1)
				ColorDisplay.BackgroundColor3 = CurrentColor
				Update()
				Expanded = false
				Container.Size = UDim2.new(1, 0, 0, 24)
				Container.ClipsDescendants = true
				if Info.Callback then 
					Info.Callback(CurrentColor) 
				end
			end)

			Header.MouseButton1Click:Connect(function()
				Expanded = not Expanded
				Container.Size = Expanded and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 24)
				Container.ClipsDescendants = not Expanded
				if not Expanded then
					OriginalColor = CurrentColor
					OriginalH, OriginalS, OriginalV = H, S, V
				end
			end)

			Update()
			return Container
		end
		
		function TabObject:AddKeybind(Info)
			local CurrentKey = Info.Default or Enum.KeyCode.E
			local Mode = Info.Mode or "Toggle"
			local IsWaiting = false
			local IsListening = false
			local ToggleState = false
			local IsHolding = false
			local CallbackFunc = Info.Callback

			local Container = CreateInstance("Frame", {
				Parent = Content,
				BackgroundColor3 = Theme.ElementBg,
				BorderSizePixel = 1,
				BorderColor3 = Theme.Border,
				Size = UDim2.new(1, 0, 0, 24)
			})

			CreateInstance("UICorner", {
				Parent = Container, 
				CornerRadius = UDim.new(0, 2)
			})

			local Label = CreateInstance("TextLabel", {
				Parent = Container,
				Text = Info.Title,
				Font = Enum.Font.Code,
				TextSize = 13,
				TextColor3 = Theme.Text,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 8, 0, 0),
				Size = UDim2.new(0.4, -8, 1, 0),
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 2
			})

			local ModeButton = CreateInstance("TextButton", {
				Parent = Container,
				Text = Mode,
				Font = Enum.Font.Code,
				TextSize = 11,
				TextColor3 = Theme.Text,
				BackgroundColor3 = Theme.MainBg,
				Position = UDim2.new(0.4, 18, 0, 3),
				Size = UDim2.new(0.25, -4, 1, -6),
				BorderSizePixel = 0,
				ZIndex = 2
			})

			CreateInstance("UICorner", {
				Parent = ModeButton, 
				CornerRadius = UDim.new(0, 2)
			})

			local KeyButton = CreateInstance("TextButton", {
				Parent = Container,
				Text = CurrentKey.Name,
				Font = Enum.Font.Code,
				TextSize = 13,
				TextColor3 = Theme.Text,
				BackgroundColor3 = Theme.MainBg,
				Position = UDim2.new(0.65, 20, 0, 3),
				Size = UDim2.new(0.25, -4, 1, -6),
				BorderSizePixel = 0,
				ZIndex = 2
			})

			CreateInstance("UICorner", {
				Parent = KeyButton, 
				CornerRadius = UDim.new(0, 2)
			})

			ModeButton.MouseButton1Click:Connect(function()
				if Mode == "Toggle" then
					Mode = "Hold"
				elseif Mode == "Hold" then
					Mode = "Once"
				else
					Mode = "Toggle"
				end
				ModeButton.Text = Mode
				ToggleState = false
				IsHolding = false
			end)

			KeyButton.MouseButton1Click:Connect(function()
				if not IsListening then
					IsListening = true
					KeyButton.Text = "..."
					KeyButton.BackgroundColor3 = Library.CurrentTheme.MainBg
				end
			end)

			KeyButton.MouseEnter:Connect(function()
				if not IsListening then
					KeyButton.BackgroundColor3 = Library.CurrentTheme.MainBg
				end
			end)

			KeyButton.MouseLeave:Connect(function()
				if not IsListening then
					KeyButton.BackgroundColor3 = Library.CurrentTheme.MainBg
				end
			end)

			UserInputService.InputBegan:Connect(function(Input, GameProcessed)
				if IsListening then
					if Input.UserInputType == Enum.UserInputType.Keyboard then
						CurrentKey = Input.KeyCode
						KeyButton.Text = CurrentKey.Name
						KeyButton.BackgroundColor3 = Library.CurrentTheme.MainBg
						IsListening = false
					end
				elseif not GameProcessed and Input.KeyCode == CurrentKey and not IsWaiting then
					if Mode == "Toggle" then
						ToggleState = not ToggleState
						IsWaiting = true

						task.spawn(function()
							if CallbackFunc then
								CallbackFunc(ToggleState)
							end
						end)
						KeyButton.Text = CurrentKey.Name
						IsWaiting = false
					elseif Mode == "Hold" then
						if not IsHolding then
							IsHolding = true
							task.spawn(function()
								if CallbackFunc then
									CallbackFunc(true)
								end
							end)
						end
					elseif Mode == "Once" then
						IsWaiting = true
						local OnceState = true
						task.spawn(function()
							if CallbackFunc then
								CallbackFunc(OnceState)
							end
						end)
						KeyButton.Text = CurrentKey.Name
						IsWaiting = false
					end
				end
			end)

			UserInputService.InputEnded:Connect(function(Input, GameProcessed)
				if not GameProcessed and Input.KeyCode == CurrentKey then
					if Mode == "Hold" and IsHolding then
						IsHolding = false
						task.spawn(function()
							if CallbackFunc then
								CallbackFunc(false)
							end
						end)
					end
				end
			end)

			return Container
		end
		
		TabButton.MouseButton1Click:Connect(function()
			SwitchTab(TabObject)
		end)

		if not ActiveTab then
			SwitchTab(TabObject)
		end

		table.insert(Tabs, TabObject)
		return TabObject
	end

	return WindowObject
end


return Library
