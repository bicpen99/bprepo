@echo off
setlocal enableDelayedExpansion

pushd C:\Users\jgilstrap\Documents\occformsreports\visual basic

for %%f in (*) do (
   set "filename=%%~f"

   for %%A in (a b c d e f g h i j k l m n o p q s t r u v x y z) do (
      set "filename=!filename:%%A=%%A!"
   )
    ren "%%f" "!filename!" >nul 2>&1
)
endlocal