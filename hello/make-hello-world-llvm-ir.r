rebol []

comment {
    The first parser will be in rebol and it will produce the llvm code for hello world

    Input program

    module "hello.c"
    print "Hello World!"

    #"(0)" to #"(FFFF)"	hex forms of characters

}


do-print: funct [ tokens ] [

    value: tokens/2
    length: add 1 length? tokens/2

    return context [
        strings: rejoin [
{@.str = private unnamed_addr constant [} length { x i8] c"} value {\00", align 1
} 
        ]

        call: rejoin [
{%2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([} length { x i8], [} length { x i8]* @.str, i32 0, i32 0))
}
        ]
    ]

]

do-module: func [ tokens ] [

    return rejoin [ 
{; ModuleID = '} tokens/2 {'
source_filename = "} tokens/2 {"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.13.0"
} 
    ]
]




source: {
    module "hello.c"
    print "Hello World!"
}

module: [
{

; === Module ===

}
]

strings: [
{

; === Strings ===

}
] ; constants?


main-header: {; Function Attrs: noinline nounwind ssp uwtable
define i32 @main() #0 ^{
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
}

main: [{

; === Main ===

}]

main-footer: {

  ret i32 0
^}
}


declarations: [{
; === Declarations? ===

declare i32 @printf(i8*, ...) #1
}] ; external?

footer: [{
; === Footer ===

attributes #0 = ^{ noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" ^}
attributes #1 = ^{ "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" ^}

!llvm.module.flags = !^{!0^}
!llvm.ident = !^{!1^}

!0 = !^{i32 1, !"PIC Level", i32 2^}
!1 = !^{!"clang version 4.0.1 (tags/RELEASE_401/final)"^}
}]




foreach line parse/all source "^/" [
    tokens: parse line none

    switch tokens/1 [
        "module"    [ 
            append module do-module tokens ]
        "print"     [ 
            r: do-print tokens 
            append strings r/strings
            append main r/call
        ]
    ]
]

out: copy []

append out rejoin module
append out rejoin strings
append out main-header
append out rejoin main
append out main-footer
append out declarations
append out footer

; print rejoin out

write %my-program.ll out


