#basic example for animating functions.
t = 0
def setup():
    size(800, 800)

def draw():
    background(255)
    fill(0)
    global t
    
    #converts standard graphical coordinate system to right-handed system with origin at the center.
    translate(width/2, height/2)
    scale(1, -1)
    t += 0.01
    
    #graphing some equations based on t.
    
    fill(0, 0, 255)
    ellipse(100*cos(t), 0, 20, 20)
    
    fill(255, 0, 0)
    ellipse(0, 100*sin(t), 20, 20)
    
    fill(200, 0, 200)
    ellipse(100*cos(t), 100*sin(t), 20, 20)
    
    fill(0, 200, 0)
    ellipse(50*t, 100*exp(-t)*sin(2*t), 5, 5)
    
    fill(0, 255, 0)
    ellipse(50*t, 100*sin(2*t), 5, 5)
    
