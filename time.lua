local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- 检查并销毁现有界面
local existingGui = playerGui:FindFirstChild("TimerGui")
if existingGui then
    existingGui:Destroy()
end

-- 创建主屏幕界面
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TimerGui"
screenGui.Parent = playerGui

-- 颜色定义
local COLOR_BG = Color3.fromRGB(20, 20, 20)  -- 纯黑背景
local COLOR_MAIN = Color3.fromRGB(120, 0, 200)  -- 主紫色
local COLOR_TEXT = Color3.fromRGB(200, 150, 255)  -- 浅紫文字
local COLOR_STROKE = Color3.fromRGB(150, 50, 220)  -- 紫色描边

-- 创建主框架（黑色背景+紫色描边）
local FramMain = Instance.new("Frame")
FramMain.Name = "FrameMain"
FramMain.Size = UDim2.new(0, 450, 0, 220)  -- 稍微缩小尺寸
FramMain.Position = UDim2.new(0, 50, 0, 50)
FramMain.BackgroundColor3 = COLOR_BG
FramMain.Active = true
FramMain.Draggable = true
FramMain.Visible = false
FramMain.Parent = screenGui

-- 圆角+描边
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = FramMain

local stroke = Instance.new("UIStroke")
stroke.Color = COLOR_STROKE
stroke.Thickness = 2
stroke.Parent = FramMain

-- 设置标签（黑色背景+紫色文字）
local settingsLabel = Instance.new("TextLabel")
settingsLabel.Name = "SettingsLabel"
settingsLabel.Size = UDim2.new(1, -20, 0, 40)  -- 缩小高度
settingsLabel.Position = UDim2.new(0, 10, 0, 5)
settingsLabel.Text = "设置面板"
settingsLabel.TextScaled = true
settingsLabel.BackgroundColor3 = COLOR_BG
settingsLabel.TextColor3 = COLOR_TEXT
settingsLabel.Parent = FramMain

-- 标签描边
local labelStroke = Instance.new("UIStroke")
labelStroke.Color = COLOR_STROKE
labelStroke.Thickness = 1
labelStroke.Parent = settingsLabel

-- 滚动框架（黑色背景）
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Name = "ScrollingFrame"
scrollingFrame.Size = UDim2.new(1, -20, 0.7, -10)
scrollingFrame.Position = UDim2.new(0, 10, 0.2, 5)
scrollingFrame.BackgroundColor3 = COLOR_BG
scrollingFrame.BorderSizePixel = 0
scrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
scrollingFrame.ScrollBarThickness = 5
scrollingFrame.Parent = FramMain

-- 功能框架（透明背景）
local FrameAllFeatures = Instance.new("Frame")
FrameAllFeatures.Name = "FrameAllFeatures"
FrameAllFeatures.Size = UDim2.new(1, -20, 0, 150)
FrameAllFeatures.Position = UDim2.new(0, 10, 0.2, 5)
FrameAllFeatures.BackgroundTransparency = 1
FrameAllFeatures.Parent = FramMain

-- UI布局
local uiLayout = Instance.new("UIListLayout")
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 5)
uiLayout.Parent = FrameAllFeatures

-- 创建紫色小按钮的函数
local function createSmallButton(name, text)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, 0, 0, 35)  -- 更小的按钮高度
    button.Text = text
    button.TextScaled = true
    button.BackgroundColor3 = COLOR_BG  -- 黑色背景
    button.TextColor3 = COLOR_TEXT     -- 紫色文字
    button.AutoButtonColor = false     -- 禁用默认点击效果
    
    -- 圆角
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = button
    
    -- 描边
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = COLOR_STROKE
    btnStroke.Thickness = 1.5
    btnStroke.Parent = button
    
    -- 悬停效果
    button.MouseEnter:Connect(function()
        btnStroke.Thickness = 2.5
        button.TextColor3 = Color3.fromRGB(230, 180, 255)  -- 更亮的紫色
    end)
    
    button.MouseLeave:Connect(function()
        btnStroke.Thickness = 1.5
        button.TextColor3 = COLOR_TEXT
    end)
    
    -- 点击效果
    button.MouseButton1Down:Connect(function()
        button.TextColor3 = Color3.fromRGB(180, 100, 255)
    end)
    
    button.MouseButton1Up:Connect(function()
        button.TextColor3 = Color3.fromRGB(230, 180, 255)
    end)
    
    return button
end

-- 创建功能按钮
local ButtonGame = createSmallButton("TimerSetting", "定时器设置")
ButtonGame.Parent = FrameAllFeatures

local ButtonCustomTimer = createSmallButton("CustomTimer", "自定义定时器")
ButtonCustomTimer.Parent = FrameAllFeatures

-- 版本标签
local ButtonVersion = Instance.new("TextLabel")
ButtonVersion.Name = "TimerVersion"
ButtonVersion.Size = UDim2.new(1, 0, 0, 30)
ButtonVersion.Text = "定时器版本:1.31"
ButtonVersion.TextScaled = true
ButtonVersion.BackgroundColor3 = COLOR_BG
ButtonVersion.TextColor3 = COLOR_TEXT
ButtonVersion.Parent = FrameAllFeatures

-- 版本标签描边
local versionStroke = Instance.new("UIStroke")
versionStroke.Color = COLOR_STROKE
versionStroke.Thickness = 1
versionStroke.Parent = ButtonVersion

-- 控制按钮样式函数（小型化）
local function createControlButton(name, text)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 50, 0, 50)  -- 更小的控制按钮
    button.Text = text
    button.TextScaled = true
    button.BackgroundColor3 = COLOR_BG  -- 黑色背景
    button.TextColor3 = COLOR_TEXT     -- 紫色文字
    button.AutoButtonColor = false
    
    -- 圆角
    local ctrlCorner = Instance.new("UICorner")
    ctrlCorner.CornerRadius = UDim.new(0, 8)
    ctrlCorner.Parent = button
    
    -- 描边
    local ctrlStroke = Instance.new("UIStroke")
    ctrlStroke.Color = COLOR_STROKE
    ctrlStroke.Thickness = 2
    ctrlStroke.Parent = button
    
    -- 交互效果
    button.MouseEnter:Connect(function()
        ctrlStroke.Thickness = 3
        button.TextColor3 = Color3.fromRGB(230, 180, 255)
    end)
    
    button.MouseLeave:Connect(function()
        ctrlStroke.Thickness = 2
        button.TextColor3 = COLOR_TEXT
    end)
    
    return button
end

-- 创建控制按钮
local lockButton = createControlButton("LockButton", "锁定")
lockButton.Position = UDim2.new(0, 0, 0.45, 0)
lockButton.Parent = screenGui

local VisibleFrameButton = createControlButton("VisibleFrameButton", "隐藏")
VisibleFrameButton.Position = UDim2.new(0, 55, 0.45, 0)
VisibleFrameButton.Parent = screenGui

-- 状态变量
local isLocked = false
local isVisible = false

-- 锁定切换函数
local function toggleLock()
    isLocked = not isLocked
    lockButton.Text = isLocked and "解锁" or "锁定"
end

-- 可见性切换函数
local function toggleVisible()
    isVisible = not isVisible
    FramMain.Visible = not isVisible
    VisibleFrameButton.Text = isVisible and "显示" or "隐藏"
end

-- 按钮事件绑定
lockButton.MouseButton1Click:Connect(function()
    toggleLock()
    FramMain.Draggable = not isLocked
end)

VisibleFrameButton.MouseButton1Click:Connect(toggleVisible)

-- 计时器标签（黑色背景+紫色文字）
local timerLabel = Instance.new("TextLabel")
timerLabel.Name = "TimerLabel"
timerLabel.Size = UDim2.new(0, 160, 0, 50)  -- 稍微缩小
timerLabel.Position = UDim2.new(0, 0, 0.2, -25)
timerLabel.Text = "00:00:00:000"
timerLabel.TextScaled = true
timerLabel.BackgroundColor3 = COLOR_BG
timerLabel.TextColor3 = COLOR_TEXT
timerLabel.Parent = screenGui

-- 计时器描边
local timerStroke = Instance.new("UIStroke")
timerStroke.Color = COLOR_STROKE
timerStroke.Thickness = 2
timerStroke.Parent = timerLabel

-- 彩虹特效函数
local function rainbowEffect(label)
    local hue = 0
    local runService = game:GetService("RunService")
    
    runService.Heartbeat:Connect(function()
        hue = (hue + 1) % 360
        label.TextColor3 = Color3.fromHSV(hue/360, 0.8, 0.9)  -- 降低饱和度
    end)
end

-- 作者标签
local ByIlianLabel = Instance.new("TextLabel")
ByIlianLabel.Name = "ByIlian"
ByIlianLabel.Size = UDim2.new(1, 0, 0, 15)
ByIlianLabel.Position = UDim2.new(0, 0, 0.95, 0)
ByIlianLabel.Text = "由AlexPT汉化的最佳定时器"
ByIlianLabel.TextScaled = true
ByIlianLabel.BackgroundTransparency = 1
ByIlianLabel.TextColor3 = COLOR_TEXT
ByIlianLabel.Parent = timerLabel

rainbowEffect(ByIlianLabel)

-- 创建控制按钮（小型化）
local stopButton = createControlButton("StopButton", "停止")
stopButton.Position = UDim2.new(0, 0, 0.3, 0)
stopButton.Parent = screenGui

local resumeButton = createControlButton("ResumeButton", "启动")
resumeButton.Position = UDim2.new(0, 55, 0.3, 0)
resumeButton.Parent = screenGui

local RemoveGuiButton = createControlButton("RemoveTimerGui", "移除")
RemoveGuiButton.Position = UDim2.new(0, 110, 0.3, 0)
RemoveGuiButton.Parent = screenGui

-- 计时器变量
local runningTimer = false
local hour = 0
local minutes = 0
local seconds = 0
local milliseconds = 0

-- 时间格式化函数
local function formatTime(h, m, s, ms)
    return string.format("%02d:%02d:%02d:%03d", h, m, s, ms)
end

local runService = game:GetService("RunService")

-- 更新计时器函数
local function updateTimer(deltaTime)
    if runningTimer then
        milliseconds = milliseconds + deltaTime * 1000
        
        if milliseconds >= 1000 then
            milliseconds = milliseconds - 1000
            seconds = seconds + 1
            
            if seconds >= 60 then
                seconds = 0
                minutes = minutes + 1
                
                if minutes >= 60 then
                    minutes = 0
                    hour = hour + 1
                end
            end
            
            -- 每秒播放提示音
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://144368233"
            sound.Volume = 0.5
            sound.Parent = timerLabel
            sound:Play()
            game:GetService("Debris"):AddItem(sound, 2)
        end
        
        timerLabel.Text = formatTime(hour, minutes, seconds, math.floor(milliseconds))
    end
end

runService.Heartbeat:Connect(updateTimer)

-- 启动/重置函数
local function startOrResetTimer()
    if runningTimer then
        runningTimer = false
        hour, minutes, seconds, milliseconds = 0, 0, 0, 0
        timerLabel.Text = formatTime(0, 0, 0, 0)
        resumeButton.Text = "启动"
        stopButton.Text = "停止"
    else
        runningTimer = true
        resumeButton.Text = "重置"
        stopButton.Text = "暂停"
    end
end

-- 停止函数
local function stopTimer()
    if runningTimer then
        runningTimer = false
        stopButton.Text = "已暂停"
    end
end

-- 移除界面函数
local function RemoveUi()
    if playerGui:FindFirstChild("TimerGui") then
        playerGui.TimerGui:Destroy()
    end
end

-- 事件绑定
humanoid.Died:Connect(stopTimer)
stopButton.MouseButton1Click:Connect(stopTimer)
resumeButton.MouseButton1Click:Connect(startOrResetTimer)
RemoveGuiButton.MouseButton1Click:Connect(RemoveUi)
