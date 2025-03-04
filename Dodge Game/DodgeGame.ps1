# 2D Dodging Game
# Use Left and Right arrow keys to move
# Avoid the falling balls!

# Game Settings
$windowWidth = 50
$windowHeight = 20
$playerChar = "P"
$ballChar = "O"

# Player initial position
$playerX = [math]::Floor($windowWidth / 2)
$playerY = $windowHeight - 1

# Balls tracking
$balls = @()

# Score tracking
$score = 0

# Function to draw the game screen
function Draw-Screen {
    Clear-Host
    
    # Create empty screen
    $screen = New-Object 'char[,]' $windowWidth, $windowHeight
    for ($x = 0; $x -lt $windowWidth; $x++) {
        for ($y = 0; $y -lt $windowHeight; $y++) {
            $screen[$x, $y] = ' '
        }
    }
    
    # Draw player
    $screen[$playerX, $playerY] = $playerChar

    # Draw balls
    foreach ($ball in $balls) {
        $screen[$ball.X, $ball.Y] = $ballChar
    }
    
    # Render screen
    for ($y = 0; $y -lt $windowHeight; $y++) {
        $row = ""
        for ($x = 0; $x -lt $windowWidth; $x++) {
            $row += $screen[$x, $y]
        }
        Write-Host $row
    }
    
    # Draw score
    Write-Host "Score: $score" -ForegroundColor Green
    Write-Host "Use Left and Right Arrow keys to move" -ForegroundColor Yellow
}

# Function to handle player movement
function Handle-PlayerMovement {
    param($key)
    
    switch ($key) {
        'LeftArrow' { 
            if ($script:playerX -gt 0) { 
                $script:playerX-- 
            }
        }
        'RightArrow' { 
            if ($script:playerX -lt ($windowWidth - 1)) { 
                $script:playerX++ 
            }
        }
    }
}

# Function to spawn balls
function Spawn-Ball {
    $newBall = @{
        X = Get-Random -Minimum 0 -Maximum $windowWidth
        Y = 0
    }
    $balls.Add($newBall)
}

# Function to update ball positions
function Update-Balls {
    $script:balls = $balls | ForEach-Object {
        $_.Y++
        $_
    }
    
    # Remove balls that go off screen
    $script:balls = $balls | Where-Object { $_.Y -lt $windowHeight }
}

# Function to check for collisions
function Check-Collision {
    foreach ($ball in $balls) {
        if ($ball.X -eq $script:playerX -and $ball.Y -eq $script:playerY) {
            return $true
        }
    }
    return $false
}

# Main game loop
function Start-Game {
    $script:score = 0
    $script:balls = @()
    $running = $true
    
    # Prepare for key input
    $host.UI.RawUI.FlushInputBuffer()
    
    while ($running) {
        # Handle input
        if ($host.UI.RawUI.KeyAvailable) {
            $key = $host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').VirtualKeyCode
            switch ($key) {
                37 { Handle-PlayerMovement -key 'LeftArrow' }
                39 { Handle-PlayerMovement -key 'RightArrow' }
            }
        }
        
        # Spawn balls randomly
        if ((Get-Random -Minimum 0 -Maximum 10) -eq 0) {
            Spawn-Ball
        }
        
        # Update ball positions
        Update-Balls
        
        # Draw screen
        Draw-Screen
        
        # Check for collisions
        if (Check-Collision) {
            Write-Host "Game Over! Final Score: $score" -ForegroundColor Red
            $running = $false
            break
        }
        
        # Increment score
        $script:score++
        
        # Pause to control game speed
        Start-Sleep -Milliseconds 200
    }
    
    # Wait for key press to exit
    Write-Host "Press any key to exit..." -ForegroundColor Cyan
    $host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown') | Out-Null
}

# Start the game
Start-Game