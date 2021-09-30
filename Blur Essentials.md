# Blur Essentials

Blur Essentials is a **.lua script** that brings quality of life enhancing functions that make it easier, smoother and more convenient to develop BlurEngine games.

Every function is preceded with the `es_` prefix.

# Function usages

## `type(object)`

Returns the real type of a blur object.

### Parameters:

#### object

### Returns:

**`string type`** - can be "string", "tile", "texture", "guiobject", etc.

## `makeGUI(parent, settings)`

Creates a **GUI** or **GUIObject** and automatically sets it's properties to the ones specified in settings. This function helps with readability and overall code aesthetic.

### Parameters:

#### parent

Set to an existing **GUI** or`"root"` if you want the new GUI element to be a **GUI** instead of a **GUIObject**.

#### settings

A dictionary containing the key property and the value. Here you can set the **BlurEngine** builtin properties alongside with:

`Type` - the **GUI** or **GUIObject** type (eg. "GUI", "Button")

`Hidden` - if set to true, the GUI element won't be registered by default

### Returns:

##### `GUI Gui` or `GUIObject Gui`

### Example:

```lua
exampleGUI = es_makeGUI("root", {
	["Type"] = "GUI",
	["Position"] = Vector(100, 100),
	["Size"] = Vector(300,200)
})

exampleButton = es_makeGUI(exampleGUI, {
	["Type"] = "Button",
	["Position"] = Vector(100, 75),
	["Size"] = Vector(100,75)
})
```

## `tween(object, property, startPos, endPos, time, tweeningStyle, smoothness)`

Allows you to interpolate a GUI or Tile's **Vector** property.

### Parameters:

#### object

The Tile, GUI or GUIObject you wish to tween.

#### property

The **Vector** Property (Size, Position) to tween.

#### startPos, endPos

The 2 **Vectors** to tween between.

#### time

How long the movement takes

#### tweeningStyle (default:linear)

The easing style to be used.

**Default: linear**

All easing functions come from: https://www.love2d.org/forums/viewtopic.php?p=198129#p198129

- `linear` 
- `quadin` 
- `cosinout` 
- `inout`
- `inoutfast`
- `exponential`
- `bounce`
- `outback`
- `inback`
- `elastic`

#### smoothness

Decides how smooth the tweening will be. 1 = no tweening, instant snap

`Amount of position updates = 1 / smoothness`

**Default: 0.001**

### Example:

```lua
es_tween(exampleTile, "Position", Vector(0,0), Vector(3, 3), 3)
es_tween(exampleGUI, "Size", Vector(100,75), Vector(200,150), 3, "bounce", 0.02)
```

