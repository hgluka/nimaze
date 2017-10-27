import unittest, random
import nimazepkg/utils, nimazepkg/recdescent

suite "Test suite for maze generation algorithms.":
  echo "Algorithm test suite starting..."

  setup:
    randomize 42

  test "recursive descent":
    var correct: Map = newMap(10, 10)
    correct.grid = @[@[2,4,14,12,12,12,12,10,4,10,0],
                     @[5,12,9,6,10,6,12,9,6,11,0],
                     @[2,6,14,9,3,5,12,12,9,3,0],
                     @[7,9,3,4,11,6,14,12,10,3,0],
                     @[5,10,5,10,3,3,5,10,1,3,0],
                     @[2,3,6,9,3,3,2,5,12,9,0],
                     @[5,9,3,6,9,3,7,12,12,8,0],
                     @[6,12,9,1,6,9,5,12,12,10,0],
                     @[3,6,12,10,3,6,12,12,12,11,0],
                     @[5,13,8,5,13,9,4,12,12,9,0],
                     @[0,0,0,0,0,0,0,0,0,0,0]]
    var to_test: Map = newMap(10, 10)
    discard recursive_descent(0, 0, to_test)
    check(to_test == correct)

  echo "Algorithm test suite done!\n"
