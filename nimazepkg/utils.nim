import seqUtils

type
  Map* = object
    ## Map object
    ##
    ## A compile-time array of size 1024x1024
    ## that also holds the height and width attributes,
    ## for smaller grids.
    grid*: seq[seq[int]]
    width*: int
    height*: int
  Direction* = enum
    N = 1, S = 2, E = 4, W = 8


proc newMap*(w, h: int): Map =
  ## Create new map and initialize cells to zeroes
  ##
  ## Raises OverflowError if width or height is higher than the maximum.
  result.width = w
  result.height = h

  result.grid = newSeqWith(result.width+1, newSeq[int](result.height+1))

  for i in 0..result.width:
    for j in 0..result.height:
      result.grid[i][j] = 0


proc echoMap*(map: Map): bool =
  stdout.write "@["
  for i in 0..map.width:
    stdout.write "@["
    for j in 0..map.height:
      stdout.write(map.grid[i][j], ",")
    stdout.write("],\n")
  stdout.write "]"


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
