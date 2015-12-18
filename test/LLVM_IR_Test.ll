target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@0 = constant [54 x i8] c"LLVM Is an Intermediate Language created at Illinois\0A\00"

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = getelementptr [54 x i8], [54 x i8]* @0, i64 0, i64 0
  %buffer = alloca [15 x i8], align 1
  %2 = bitcast [15 x i8]* %buffer to i8*  
  %3 = call i32 (i8*, ...) @printf(i8* %1)
  call void @memcpy(i8* %1, i8* %2, i64 4)   
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

declare void @memcpy(i8*, i8*, i64)


attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
