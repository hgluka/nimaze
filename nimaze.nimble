# Package

version       = "0.1.0"
author        = "lucantrop"
description   = "Maze generation in nim"
license       = "MIT"

skipDirs      = @["tests", "bin"]
bin           = @["nimaze"]

# Dependencies

requires "nim >= 0.17.2", "docopt >= 0.6.5"

# Tasks
task test_all, "Run test suite":
  exec r"nim c -o:bin/test_algos -r tests/test_algos.nim"

