cam = Camera()
cam.x = 0
cam.y = 0

function cam:update(dt)
    cam:lookAt(Player.x * 4, Player.y * 4)
    cam.x = Player.x * 4
    cam.y = Player.y * 4
    
    cameraHideOffSet()
end