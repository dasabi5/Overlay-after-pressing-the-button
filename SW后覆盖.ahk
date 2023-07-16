/*
黑钨重工出品 免费开源 请勿商用 侵权必究
更多免费教程尽在QQ群 1群763625227 2群643763519
*/

full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
  try
  {
    if A_IsCompiled
      Jump *JumpAs "%W_ScriptFullPath%" /restart
    else
     Jump *JumpAs "%W_AhkPath%" /restart "%W_ScriptFullPath%"
  }
  ExitApp
}

Process, Priority, , Realtime
#MenuMaskKey vkE8
#WinActivateForce
#InstallKeybdHook
#InstallMouseHook
#Persistent
#NoEnv
#SingleInstance Force
#MaxHotkeysPerInterval 2000
#KeyHistory 2000
SendMode Input
SetBatchLines -1
CoordMode Pixel Screen
CoordMode ToolTip Screen
SetKeyDelay -1, 20
SetWorkingDir %W_ScriptDir%

jumping:=1 ;1为运行 0为暂停
Menu, Tray, NoStandard ;不显示默认的AHK右键菜单
Menu, Tray, Add, 使用教程, 使用教程 ;添加新的右键菜单
Menu, Tray, Add, 暂停运行, 暂停运行 ;添加新的右键菜单
Menu, Tray, Add, 退出软件, 退出软件 ;添加新的右键菜单
return

使用教程:
MsgBox, , 按键后覆盖, 黑钨重工出品 免费开源 请勿商用 侵权必究`n`n默认覆盖字母A和D`n如果需要覆盖其他键位`n根据需求自行更改源代码`n`n更多免费教程尽在QQ群 1群763625227 2群643763519
return

暂停运行:
Critical, On
if (jumping=0)
{
  jumoing:=1
  Hotkey, s, On
  Hotkey, w, On
  Menu, Tray, UnCheck, 暂停运行 ;右键菜单不打勾
}
else
{
  jumping:=0
  Hotkey, s, Off
  Hotkey, w, Off
  Menu, Tray, Check, 暂停运行 ;右键菜单不打勾
}
Critical, Off
return

退出软件:
ExitApp

~$w:: ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<改键改字母成你需要的按键 上
if (热键开关w=0)
{
  return
}
上移动:
热键开关s:=0
if GetKeyState("s", "P")
{
  Send {s Up}
}
Critical On
loop
{
  if !GetKeyState("w", "P")
  {
    if GetKeyState("s", "P")
    {
      反向:=0
      break
    }
    else
    {
      热键开关s:=1
      Critical Off
      return
    }
  }
  else if !GetKeyState("s", "P") and (反向=1)
  {
    反向:=0
  }
  else if GetKeyState("s", "P") and (反向!=1)
  {
    break
  }
}
Send {s Down}
反向:=1
热键开关s:=1
Critical Off
goto 下移动

~$s:: ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<改键改字母成你需要的按键 下
if (热键开关w=0)
{
  return
}
下移动:
热键开关s:=0
if GetKeyState("w", "P")
{
  Send {w Up}
}
loop
{
  Critical On
  if !GetKeyState("s", "P")
  {
    if GetKeyState("w", "P")
    {
      反向:=0
      Critical Off
      break
    }
    else
    {
      Critical Off
      热键开关w:=1
      return
    }
  }
  else if !GetKeyState("w", "P") and (反向=1)
  {
    反向:=0
  }
  else if GetKeyState("w", "P") and (反向!=1)
  {
    break
  }
}
Send {w Down}
反向:=1
热键开关w:=1
Critical Off
goto 上移动
