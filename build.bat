@echo off
setlocal

ml64 /nologo /c /Fo%~dp0asm/make_x86_64_ms_pe_masm.o /Zd /Zi /I%~dp0asm/ /DBOOST_CONTEXT_EXPORT= %~dp0asm/make_x86_64_ms_pe_masm.asm
ml64 /nologo /c /Fo%~dp0asm/jump_x86_64_ms_pe_masm.o /Zd /Zi /I%~dp0asm/ /DBOOST_CONTEXT_EXPORT= %~dp0asm/jump_x86_64_ms_pe_masm.asm
ml64 /nologo /c /Fo%~dp0asm/ontop_x86_64_ms_pe_masm.o /Zd /Zi /I%~dp0asm/ /DBOOST_CONTEXT_EXPORT= %~dp0asm/ontop_x86_64_ms_pe_masm.asm

cl /DDEBUG /c /Zi /Fo%~dp0fcontextd.obj /Fd%~dp0fcontext.pdb /I%~dp0include/fcontext %~dp0source/stack.c
lib /out:%~dp0fcontextd.lib %~dp0fcontextd.obj

cl /DNDEBUG /O2 /c /Fo%~dp0fcontext.obj /I%~dp0include/fcontext %~dp0source/stack.c
lib /out:%~dp0fcontext.lib %~dp0fcontext.obj %~dp0asm/make_x86_64_ms_pe_masm.o %~dp0asm/jump_x86_64_ms_pe_masm.o %~dp0asm/ontop_x86_64_ms_pe_masm.o

del %~dp0*.obj