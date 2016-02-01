; ModuleID = 'Test2_2.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [11 x i8] c"staticFile\00", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"open\00", align 1
@.str2 = private unnamed_addr constant [18 x i8] c"buffer value %s \0A\00", align 1
@.str3 = private unnamed_addr constant [20 x i8] c"bytes returned %d \0A\00", align 1
@0 = constant [85 x i8] c"Pakistan has lost the series to NZ due to some substandard captaincy from Azhar ali\0A\00"

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %buffer = alloca [15 x i8], align 1
  %1 = call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0), i32 0)
  %2 = icmp eq i32 %1, -1
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  call void @perror(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str1, i32 0, i32 0))
  br label %20

; <label>:4                                       ; preds = %0
  %5 = bitcast [15 x i8]* %buffer to i8*
  %6 = getelementptr [85 x i8], [85 x i8]* @0, i64 0, i64 0
  call void @memcpy(i8* %5, i8* %6, i64 10)
  %7 = alloca i64
  store i64 10, i64* %7
  %8 = load i64, i64* %7
  %9 = getelementptr inbounds [15 x i8], [15 x i8]* %buffer, i32 0, i32 0
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str2, i32 0, i32 0), i8* %9)
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str3, i32 0, i32 0), i64 %8)
  %12 = bitcast [15 x i8]* %buffer to i8*
  %13 = getelementptr [85 x i8], [85 x i8]* @0, i64 0, i64 0
  call void @memcpy(i8* %12, i8* %13, i64 10)
  %14 = alloca i64
  store i64 10, i64* %14
  %15 = load i64, i64* %14
  %16 = getelementptr inbounds [15 x i8], [15 x i8]* %buffer, i32 0, i32 0
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str2, i32 0, i32 0), i8* %16)
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str3, i32 0, i32 0), i64 %15)
  %19 = call i32 @close(i32 %1)
  br label %20

; <label>:20                                      ; preds = %4, %3
  %.0 = phi i32 [ 2, %3 ], [ 0, %4 ]
  ret i32 %.0
}

declare i32 @open(i8*, i32, ...) #1

declare void @perror(i8*) #1

declare i64 @read(i32, i8*, i64) #1

declare i32 @printf(i8*, ...) #1

declare i32 @close(i32) #1

declare void @memcpy(i8*, i8*, i64)

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
