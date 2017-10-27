import nimazepkg/utils


proc drawAscii*(map: Map): bool =
  ## Draw an ascii representation of a maze to stdout
  ##
  ## We only need to draw south and east walls, because
  ## we are starting in the top-left corner and moving down to the bottom-right
  stdout.write " "
  for i in 0..(map.width*2-1):
    stdout.write "_"
  stdout.write "\n"
  for y in 0..map.height-1:
    stdout.write "|"
    for x in 0..map.width-1:
      stdout.write if ((map.grid[y][x] and ord S) != 0): " "
                   else: "_"
      if ((map.grid[y][x] and ord E) != 0):
        stdout.write if (((map.grid[y][x] or map.grid[y][x+1]) and ord S) != 0): " "
                     else: "_"
      else: stdout.write "|"
    stdout.write "\n"


when isMainModule:
  import docopt, strutils, random

  # Import all algorithm modules here
  import nimazepkg/recdescent

  let doc = """
nimaze 0.1.0 by Luka Hadzi-Djokic

Usage:
  nimaze [-w=<x>|--width=<x>] [-h=<y>|--height=<y>] [-s=<z>|--seed=<z>]
  nimaze --help
  nimaze (-v | --version)

Options:
  -w --width=<x>   Set width of maze [default: 0]
  -h --height=<y>  Set height of maze [default: 0]
  -s --seed=<z>    Set seed for prng [default: 0]
  --help           Show this screen.
  -v --version     Show version.
"""
  let args = docopt(doc, version = "nimaze 0.1.0")

  let width = if parseInt($args["--width"]) != 0: parseInt($args["--width"])
              else: 10
  let height = if parseInt($args["--height"]) != 0: parseInt($args["--height"])
               else: width
  let seed = if parseInt($args["--seed"]) != 0: parseInt($args["--seed"])
             else: random high(int)
  randomize seed
  var map = newMap(width, height)
  discard recursive_descent(0, 0, map)
  discard drawAscii(map)
