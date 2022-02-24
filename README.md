
## Macos
Try:
```
gcc src/main.c src/sokol-util/sokol.m -o test-app -DSOKOL_METAL -fobjc-arc -I src/sokol -I src/sokol-utill -framework Metal -framework Cocoa -framework MetalKit -framework Quartz -framework AudioToolbox
```
```
./test-app
```

and try:
Try:
```
gcc src/main2d.c src/sokol-util/sokol.m -o test-app -DSOKOL_METAL -fobjc-arc -I src/sokol -I src/sokol-utill -framework Metal -framework Cocoa -framework MetalKit -framework Quartz -framework AudioToolbox
```
```
./test-app
```

## Windows
Try:
```
cl src\main.c src\sokol-util\sokol.c /DSOKOL_D3D11 /I..src\sokol /I..\sokol-util
```

and try:
```
cl src\main2d.c src\sokol-util\sokol.c /DSOKOL_D3D11 /I..src\sokol /I..\sokol-util
```