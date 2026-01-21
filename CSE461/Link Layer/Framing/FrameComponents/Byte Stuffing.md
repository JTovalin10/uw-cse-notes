- have a speical flag byte value for start/end of frame
- replace ('stuff') the flag with an escape code
 ![[Screenshot 2026-01-20 at 4.26.09 PM.png]]
# Complication
 we have to scape the escape code too
# Rules
- replace each FLAG in data with ESC FLAG
- replace each ESC in data with ESC ESC
- now any unescaped FAG is the start/end of a frame
![[Screenshot 2026-01-20 at 4.27.18 PM.png]]
# Unstuffing
![[Screenshot 2026-01-20 at 4.27.46 PM.png]]