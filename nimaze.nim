import random

type
  Map* = object
    ## Map object
    ##
    ## A compile-time array of size 1024x1024
    ## that also holds the height and width attributes,
    ## in case that the grid needs to be smaller.
    grid: array[0..66, array[0..66, int]]
    width: int
    height: int
  Direction = enum
    N = 1, S = 2, E = 4, W = 8


proc newMap*(w, h: int): Map {.raises: [OverflowError].} =
  ## Create new map and initialize cells to zeroes
  ##
  ## Raises OverflowError if width or height is higher than the maximum
  var map: Map

  if w > 66 or h > 66:
    raise newException(OverflowError, "Invalid width or height")
  else:
    map.width = w
    map.height = h

  for i in 0..map.width:
    for j in 0..map.height:
      map.grid[i][j] = 0

  return map

proc DX(dir: Direction): int =
  ## DX, DY determine the direction of the recursive descent
  case dir
  of E: return 1
  of W: return -1
  of N: return 0
  of S: return 0
  else: discard

proc DY(dir: Direction): int =
  ## DX, DY determine the direction of the recursive descent
  case dir
  of S: return 1
  of N: return -1
  of E: return 0
  of W: return 0
  else: discard

proc OPPOSITE(dir: Direction): Direction =
  ## OPPOSITE is a helper function we use
  ## because if a passage exists to the west,
  ## there also needs to be a passage to the east in the adjacent cell
  case dir
  of S: return N
  of N: return S
  of E: return W
  of W: return E
  else: discard

proc recursive_descent*(cx: int, cy: int, map: var Map): bool =
  ## Recursive descent algorithm for carving a maze in a grid
  ##
  ## The end result is a `Map` with entries that are
  ## can be represented by `a*1+b*2+c*4+d*8`, where `a, b, c, d`
  ## are either 0 or 1:
  ## 1 means that there is a path in the corresponding direction,
  ## 0 means that there is a wall.
  var directions = [N, S, E, W]
  shuffle[Direction] directions

  var nx, ny: int
  for direction in directions:
    nx = cx + DX(direction)
    ny = cy + DY(direction)

    if ny >= 0 and ny < map.width and nx >= 0 and nx < map.height and map.grid[ny][nx] == 0:
      map.grid[cy][cx] += ord direction
      map.grid[ny][nx] += ord OPPOSITE(direction)
      discard recursive_descent(nx, ny, map)

proc draw_ascii*(map: Map): bool =
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
  import docopt, strutils
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
  try:
    var map = newMap(width, height)
    discard recursive_descent(0, 0, map)
    discard draw_ascii(map)
  except OverflowError:
    let msg = getCurrentExceptionMsg()
    echo msg
