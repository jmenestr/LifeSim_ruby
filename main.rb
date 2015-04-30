
require_relative "world"


plan =     ["#############################",
            "#        x            x    ##",
            "#  **               x       #",
            "#         #####             #",
            "##          #   #  x  ##    #",
            "###           ##     #   x  #",
            "#         x ###      #      #",
            "#   ####                    #",
            "#   ##                      #",
            "#    #         **      ###  #",
            "#    #         **  xxx      #",
            "#############################"]

legend = {"#"=>Wall, "x" => Critter, "*" => Plant}

world = World.new(plan,legend)

until world.critters.empty? do
  system("cls")
  world.turn
  print world
  sleep 0.1
end

