
if [[ $1 = 'stages' ]]; then
    clang a.c -S -emit-llvm
    clang a.ll -S
    clang a.s
fi;


if [[ $1 = 'clean' ]]; then 
    echo 'CLEAN!!!' ; 
    rm *.ll *.s
fi;