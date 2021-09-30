include("essentials.lua")

exampleTile = tile.new(Vector(0,0), texture.load("crate.png"))


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

event.link("mouseClick", "mouseClick", function(key, state)
	if state ~= BUTTON_PRESS then return end
	es_tween(exampleTile, "Position", Vector(0,0), Vector(3, 3), 3)
	es_tween(exampleGUI, "Size", Vector(100,75), Vector(200,150), 3, es_EASING_BOUNCE, 0.02)
end)