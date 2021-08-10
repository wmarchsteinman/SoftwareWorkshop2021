#modified from Dan Shiffman's CodingTrain example

minRange = -2.5
maxRange = 2.5
def setup():
    size(500, 500)
    pixelDensity(1)

#modifies the pixels array representing the screen directly.
def draw():
    loadPixels()
    for i in range(width):
        for j in range(height):

            a = map(i, 0, width, minRange, maxRange)
            b = map(j, 0, height, minRange, maxRange)
            iter = 50
            n = 0
            z = 0
            origA = a
            origB = b
            #iterate points to generate elements of the mandelbrot set.
            while (n < iter):
                a2 = a*a - b*b
                twoAB = 2 * a * b
                a = origA + a2
                b = origB + twoAB
            
                if (abs(a+b)>25):
                    break
                n += 1
                
            #color members of the set by iterations
            bright = map(n, 0, iter, 0, 255)
            if n == iter:
                bright = 0
                
            #color all values
            blu = map(a, minRange, maxRange, 0, 255)
            re = map(b, minRange, maxRange, 0, 255)
            blu = 0
            re = 0
            pix = (i + j * width)
            pixels[pix] = color(blu,bright,re,255)
            
    updatePixels()

#use keys to change the range of real or imaginary values generated.
def keyPressed():
    global minRange, maxRange
    if (keyCode == 37):
        minRange -= 0.5
    if (keyCode == 39):
        minRange += 0.5
    if (keyCode == 38):
        maxRange -= 0.5
    if (keyCode == 40):
        maxRange += 0.5
