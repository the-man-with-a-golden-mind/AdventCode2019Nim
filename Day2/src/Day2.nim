import strutils
import tables

let input = open("input.txt")
let step = 4

proc readFileAsSequence(): seq[string] = 
  readAll(input).string.split(",")

proc getABC(s: var seq[string], i: int): Table[string, int] =
      let a:int = parseInt(s[i + 1])
      let b:int = parseInt(s[i + 2])
      let c:int = parseInt(s[i + 3])
      {"a": a,"b": b, "c": c}.toTable

proc parse(seqToParse: var seq[string]): seq[string] = 
  var function: string = ""
  var endOfStream: bool = false
  var iter: int = 0
  let seqLength = seqToParse.len
  while function != "99" and endOfStream == false:
    if iter <= (seqLength - 1):
      function = seqToParse[iter]
      if function == "1":
        let abc = getABC(seqToParse, iter)
        let aa:int = parseInt(seqToParse[abc["a"]])
        let bb:int = parseInt(seqToParse[abc["b"]])
        seqToParse[abc["c"]] = intToStr(aa + bb)
        iter = iter + step
      elif function  == "2":
        let abc = getABC(seqToParse, iter)
        let aa:int = parseInt(seqToParse[abc["a"]])
        let bb:int = parseInt(seqToParse[abc["b"]])
        seqToParse[abc["c"]] = intToStr(aa * bb)
        iter = iter + step
      elif function != "99":
        echo("WRONG DATA")
        echo(seqToParse[iter])
        endOfStream = true
    else: 
      endOfStream = true
  seqToParse

proc search(searchVal: string, seqToSearch: seq[string], minMax: seq[int]): Table[string, int] =
  let minVal = minMax[0]
  let maxVal = minMax[1]
  for a in minVal..maxVal:
    for b in minVal..maxVal:
      var pureSeq = seqToSearch
      pureSeq[1] = intToStr(a)
      pureSeq[2] = intToStr(b)
      let checkValue: string = parse(pureSeq)[0]
      if checkValue == searchVal:
        return {"a": a, "b": b}.toTable

when isMainModule:
  var file1 = readFileAsSequence()
  var file2 = file1
  file1[1] = "12"
  file1[2] = "2"
  let parsed: seq[string] = parse(file1)
  let answear1 = parsed[0]
  echo(answear1)
  let searchedAB: Table[string, int] = search("19690720", file2, @[0, 99]) 
  let answear2 = 100 * searchedAB["a"] + searchedAB["b"]
  echo(answear2)
