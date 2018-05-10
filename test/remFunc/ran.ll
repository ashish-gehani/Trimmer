; ModuleID = 'test/remFunc/ran.bc'
source_filename = "test/remFunc/ran.bc"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [16 x i8] c"function: func3\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"function: func4\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"function: func5\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"function: func6\00", align 1
@.str.4 = private unnamed_addr constant [16 x i8] c"function: func1\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"function: func2\00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"function: random\00", align 1

; Function Attrs: nounwind uwtable
define void @func3() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i32 0, i32 0))
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind uwtable
define void @func4() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @func5() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.2, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @func6() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @func1() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.4, i32 0, i32 0))
  call void @func3()
  ret void
}

; Function Attrs: nounwind uwtable
define void @func2() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind uwtable
declare void @random() #0

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @func1()
  call void @random()
  ret i32 0
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-svn262614-1~exp1 (branches/release_38)"}
