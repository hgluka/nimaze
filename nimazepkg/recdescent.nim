import random, utils


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
