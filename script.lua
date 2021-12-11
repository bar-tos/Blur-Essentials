include("essentials/essentials.lua")
include("player.lua")

exampleTile = Tile.new(Vector(0,0), Texture.load("crate.png"))

exampleGUI = es_makeGUI("root", {
	["Type"] = "GUI",
	["Position"] = Vector(100, 100),
	["Size"] = Vector(300,200),
	["Enabled"] = true
})

exampleText = es_makeGUI(exampleGUI, {
	["Type"] = "Label",
	["Position"] = Vector(100, 75),
	["Size"] = Vector(100,75),
	["Text"] = "0"
})

event.link("render", "render", function()
	exampleText.Text = es_distance(exampleTile.Position, player.Position)
end)