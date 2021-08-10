#this is meant to represent a vector field.
vectorList = [[[(3, 5*sin(2*PI*j/50), 0) for i in range(0, 50)] for j in range(50)] for k in range(50)]

#for drawing points in the field.
point = [5, 0, 0]
pointList = [point]

#angles for rotation
angleXY = 0
angleXZ = 0
angleYZ = 0

#variables to track mouse movement
xStartM = 0
yStartM = 0

#flags for rotation
rotateXYL = False
rotateXYR = False

#initialize 3D canvas, create points to show.
def setup():
    size(800, 800, P3D)
    frameRate(30)
    global pointList
    
    #generate 400 random points in an 800x800x100 cube.
    for i in range(0, 400):
        pointList.append([random(-width/2, width/2), random(-height/2, height/2), random(-100, 100)])        
    
#draw function; loops at the frame rate.
def draw():
    global angleXY, pointList
    background(0)
    lights()
    fill(255)
    #move to center of screen
    translate(width/2, height/2, 0)
    #if the right keys are pressed, the flag is set and we rotate about Z-axis.
    if (rotateXYR):
        angleXY += 0.1
    if (rotateXYL):
        angleXY -= 0.1
        
    #apply rotation
    rotateZ(angleXY)
    rotateY(angleXZ)
    rotateX(angleYZ)
    
    #for each point, move it to its location in the space centered at the middle of the screen
    #then apply the movePoint() function
    #pushMatrix and popMatrix apply the translate transformation locally only an individual point.
    for i in range(len(pointList)):
        pushMatrix()
        fill(255)
        translate(pointList[i][0], pointList[i][1], pointList[i][2])
        noStroke()
        sphere(2)
        popMatrix()
        movePoint(pointList[i])

#when a key is pressed down
def keyPressed():
    global rotateXYL, rotateXYR
    if (keyCode == 37): #if it's left arrow...
        rotateXYL = not rotateXYL
    if (keyCode == 39): #if it's right arrow...
        rotateXYR = not rotateXYR

#when the mouse is pressed, track its initial location.
def mousePressed():
    global xStartM, yStartM
    xStartM = mouseX
    yStartM = mouseY

#when the mouse is released, use its ending location to determine rotation about the X and Y axes.
def mouseReleased():
    global xStartM, yStartM, angleXZ, angleYZ
    diffX = mouseX - xStartM
    diffY = mouseY - yStartM
    
    if diffX < 0:
        angleXZ += map(diffX, -width, 0, -2*PI, 0)
    else:
        angleXZ += map(diffX, 0, width, 0, 2*PI)
        
    if diffY < 0:
        angleYZ -= map(diffY, -width, 0, -2*PI, 0)
    else:
        angleYZ -= map(diffY, 0, width, 0, 2*PI)
    
#use the vector field to change the velocity at a point.
#try to wrap around if off screen.
def movePoint(p):
    global vectorList
    convertX = int(p[0]/len(vectorList))
    convertY = int(p[1]/len(vectorList[convertX]))
    convertZ = int(p[2]/len(vectorList[convertX][convertY]))
    p[0] += vectorList[convertX][convertY][convertZ][0]
    p[1] += vectorList[convertX][convertY][convertZ][1]
    p[2] += vectorList[convertX][convertY][convertZ][2]
    if (p[0]>width/2):
        p[0] = -width/2
    if (p[0]<-width/2):
        p[0] = width/2
    if (p[1]>height/2):
        p[0] = -height/2
    if (p[0]<-height/2):
        p[0] = height/2
    
