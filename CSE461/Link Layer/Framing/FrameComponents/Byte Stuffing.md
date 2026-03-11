- have a speical flag byte value for start/end of frame
- replace ('stuff') the flag with an escape code
 ![[Screenshots/FLAG ESC padding.png]]
# Complication
 we have to scape the escape code too
# Rules
- replace each FLAG in data with ESC FLAG
- replace each ESC in data with ESC ESC
- now any unescaped FAG is the start/end of a frame
# Unstuffing
