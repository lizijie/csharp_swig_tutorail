::Please runing inside Visual Studio Command Prompt

@echo off
set SWIG_BIN=%1
set ROOT_DIR=%CD%
set CS_WRAP_DIR=%ROOT_DIR%\cs_wrap
set C_WRAP_DIR=%ROOT_DIR%\c_wrap
set DLL_DIR=%ROOT_DIR%\dll
set EXAM_DIR=%ROOT_DIR%\test


if "%SWIG_BIN%"=="" goto :NOSWIG

if not exist %CS_WRAP_DIR% md %CS_WRAP_DIR%
if not exist %C_WRAP_DIR% md %C_WRAP_DIR%

echo %SWIG_BIN%
echo %CD%

%SWIG_BIN% -csharp -outdir %CS_WRAP_DIR% -o %C_WRAP_DIR%\mydll_wrap.cxx %DLL_DIR%\interfaces\mydll.i
cl /LD /TC %DLL_DIR%\mydll.c %C_WRAP_DIR%\mydll_wrap.cxx /link /MACHINE:X86 /out:mydll.dll
csc %EXAM_DIR%\test_mydll.cs %CS_WRAP_DIR%\mydll.cs %CS_WRAP_DIR%\mydllPINVOKE.cs /platform:x86

echo running test_mydll.exe
echo.

test_mydll.exe
goto :END

:NOSWIG
echo Please pass swig binary file.
echo build.bat YOUR_PATH\swig.exe

:END

