
require_relative "world"


plan =     ["#############################",
            "#        x            x    ##",
            "#                   x       #",
            "#         #####             #",
            "##          #   #  x  ##    #",
            "###           ##     #   x  #",
            "#         x ###      #      #",
            "#   ####                    #",
            "#   ##                      #",
            "#    #                 ###  #",
            "#    #             xxx      #",
            "#############################"]

legend = {"#"=>Wall, "x" => Critter}

world = World.new(plan,legend)

500.times do
  system("clear")
  world.turn
  print world
  sleep 0.1
end

