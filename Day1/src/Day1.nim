import strutils
import math

let input = open("input.txt")

proc calculateMass(moduleMass: int): int =
  floorDiv(moduleMass, 3) - 2

func calculateFuelMass(moduleMass: int, acc: int): int =
  if moduleMass >= 0:
    let newMass: int = calculateMass(moduleMass)
    calculateFuelMass(newMass, acc + newMass)
  else:
    acc

when isMainModule:
  var modulesMass: int = 0
  var modulesMassWithFuel: int = 0
  for line in input.lines:
    let lineInt = parseInt(line.string)
    modulesMass = modulesMass + calculateMass(lineInt)
    modulesMassWithFuel = modulesMassWithFuel + calculateFuelMass(lineInt, 0)
  echo(modulesMass)
  echo(modulesMassWithFuel)
