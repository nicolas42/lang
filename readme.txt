http://clang.llvm.org/get_started.html

clang -S -emit-llvm <input.c>
clang <input.ll>

git add . ; git commit -m "" ; git push

What is the simplest program that I can write?


---------------------------------------------------------------------------------------------

Stages

    preprocessor -> compiler -> assembler -> linker -> executable file

Stage Flags

    -E -S -c (none)    
    -E go up to preprocessor step, -S assembly step, -c compilation step, (none) or all steps.

    -emit-llvm      emit llvm instead of x86 code

Preprocessor note

    To avoid constant name collisions put all constants in one file or use #undef to control the scope of the preprocessor

    #define FOO 4
    x = FOO;        → x = 4;
    #undef FOO


---------------------------------------------------------------------------------------------


=== Misc Links ===

    LLVM
    video - LLVM IR tutorial https://www.youtube.com/watch?v=m8G_S5LwlTo
    llvm IR examples https://releases.llvm.org/2.6/docs/tutorial/JITTutorial1.html
    llvm IR lecture 2017 https://llvm.org/devmtg/2017-06/1-Davis-Chisnall-LLVM-2017.pdf

    LLVM language reference https://llvm.org/docs/LangRef.html
    kaleidoscope tutorial LLVM IR https://llvm.org/docs/tutorial/


---------------------------------------------------------------------------------------------

=== Clang info from 'man clang' ===


    Stage Selection Options
        -E     Run the preprocessor stage.

        -fsyntax-only
                Run the preprocessor, parser and type checking stages.

        -S     Run the previous stages as well as LLVM generation and optimiza-
                tion stages and target-specific code  generation,  producing  an
                assembly file.

        -c     Run  all  of  the above, plus the assembler, generating a target
                ".o" object file.

        no stage selection option
                If no stage selection option is specified, all stages above  are
                run,  and  the linker is run to combine the results into an exe-
                cutable or shared library.


   Code Generation Options
       -O0, -O1, -O2, -O3, -Ofast, -Os, -Oz, -Og, -O, -O4
              Specify which optimization level to use:
                 -O0 Means "no optimization": this level compiles the  fastest
                 and generates the most debuggable code.

                 -O1 Somewhere between -O0 and -O2.

                 -O2  Moderate  level of optimization which enables most opti-
                 mizations.

                 -O3 Like -O2, except that it enables optimizations that  take
                 longer  to  perform  or  that may generate larger code (in an
                 attempt to make the program run faster).

                 -Ofast Enables all the  optimizations  from  -O3  along  with
                 other  aggressive  optimizations that may violate strict com-
                 pliance with language standards.

                 -Os Like -O2 with extra optimizations to reduce code size.

                 -Oz Like -Os (and thus -O2), but reduces code size further.

                 -Og Like -O1. In future versions, this option  might  disable
                 different optimizations in order to improve debuggability.

                 -O Equivalent to -O2.

                 -O4 and higher
                     Currently equivalent to -O3



       -g, -gline-tables-only, -gmodules
              Control  debug information output.  Note that Clang debug infor-
              mation works best at -O0.  When more than  one  option  starting
              with -g is specified, the last one wins:
                 -g Generate debug information.

                 -gline-tables-only  Generate  only  line table debug informa-
                 tion. This allows for symbolicated backtraces  with  inlining
                 information, but does not include any information about vari-
                 ables, their locations or types.

                 -gmodules Generate debug information that  contains  external
                 references  to  types defined in Clang modules or precompiled
                 headers instead of emitting redundant debug type  information
                 into  every  object file.  This option transparently switches
                 the Clang module format to object file containers  that  hold
                 the  Clang  module together with the debug information.  When
                 compiling a program that uses Clang  modules  or  precompiled
                 headers, this option produces complete debug information with
                 faster compile times and much smaller object files.

                 This option should not be used when building static libraries
                 for  distribution  to  other  machines because the debug info
                 will contain references to the module cache  on  the  machine
                 the object files in the library were built on.



---------------------------------------------------------------------------------------------


