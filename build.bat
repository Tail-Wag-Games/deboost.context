@echo off
setlocal

cl /DDEBUG /c /Zi /Fo%~dp0fcontextd.obj /Fd%~dp0fcontext.pdb /I%~dp0include/fcontext %~dp0source/stack.c
lib /out:%~dp0fcontextd.lib %~dp0fcontextd.obj

cl /DNDEBUG /O2 /c /Fo%~dp0fcontext.obj /I%~dp0include/fcontext %~dp0source/stack.c
lib /out:%~dp0fcontext.lib %~dp0fcontext.obj

del %~dp0*.obj