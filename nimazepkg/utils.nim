type
  Map* = object
    ## Map object
    ##
    ## A compile-time array of size 1024x1024
    ## that also holds the height and width attributes,
    ## for smaller grids.
    grid*: array[0..1024, array[0..1024, int]]
    width*: int
    height*: int
  Direction* = enum
    N = 1, S = 2, E = 4, W = 8


proc newMap*(w, h: int): Map {.raises: [OverflowError].} =
  ## Create new map and initialize cells to zeroes
  ##
  ## Raises OverflowError if width or height is higher than the maximum.
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

proc DX*(dir: Direction): int =
  ## DX, DY determine the direction for path carving algorithms.
  case dir
  of E: return 1
  of W: return -1
  of N: return 0
  of S: return 0
  else: discard

proc DY*(dir: Direction): int =
  ## DX, DY determine the direction for path carving algorithms.
  case dir
  of S: return 1
  of N: return -1
  of E: return 0
  of W: return 0
  else: discard

proc OPPOSITE*(dir: Direction): Direction =
  ## OPPOSITE is useful for obvious reasons.
  case dir
  of S: return N
  of N: return S
  of E: return W
  of W: return E
  else: discard
