; ModuleID = 'Test6_2.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str1 = private unnamed_addr constant [11 x i8] c"staticFile\00", align 1
@.str2 = private unnamed_addr constant [5 x i8] c"open\00", align 1
@.str3 = private unnamed_addr constant [18 x i8] c"buffer value %s \0A\00", align 1
@.str4 = private unnamed_addr constant [20 x i8] c"bytes returned %d \0A\00", align 1
@0 = constant [85 x i8] c"Pakistan has lost the series to NZ due to some substandard captaincy from Azhar ali\0A\00"

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %buffer = alloca [15 x i8], align 1
  %n = alloca i32, align 4
  %1 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0), i32* %n)
  %2 = call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str1, i32 0, i32 0), i32 0)
  %3 = icmp eq i32 %2, -1
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  call void @perror(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str2, i32 0, i32 0))
  br label %30

; <label>:5                                       ; preds = %0
  %6 = bitcast [15 x i8]* %buffer to i8*
  %7 = getelementptr [85 x i8], [85 x i8]* @0, i64 0, i64 0
  call void @memcpy(i8* %6, i8* %7, i64 10)
  %8 = alloca i64
  store i64 10, i64* %8
  %9 = load i64, i64* %8
  %10 = getelementptr inbounds [15 x i8], [15 x i8]* %buffer, i32 0, i32 0
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str3, i32 0, i32 0), i8* %10)
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str4, i32 0, i32 0), i64 %9)
  %13 = load i32, i32* %n, align 4
  %14 = sext i32 %13 to i64
  %15 = call i64 @lseek(i32 %2, i64 %14, i32 0) #3
  %16 = bitcast [15 x i8]* %buffer to i8*
  %17 = call i64 @read(i32 %2, i8* %16, i64 10)
  %18 = getelementptr inbounds [15 x i8], [15 x i8]* %buffer, i32 0, i32 0
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str3, i32 0, i32 0), i8* %18)
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str4, i32 0, i32 0), i64 %17)
  %21 = call i64 @lseek(i32 %2, i64 10, i32 0) #3
  %22 = bitcast [15 x i8]* %buffer to i8*
  %23 = getelementptr [85 x i8], [85 x i8]* @0, i64 0, i64 10
  call void @memcpy(i8* %22, i8* %23, i64 10)
  %24 = alloca i64
  store i64 10, i64* %24
  %25 = load i64, i64* %24
  %26 = getelementptr inbounds [15 x i8], [15 x i8]* %buffer, i32 0, i32 0
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str3, i32 0, i32 0), i8* %26)
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str4, i32 0, i32 0), i64 %25)
  %29 = call i32 @close(i32 %2)
  br label %30

; <label>:30                                      ; preds = %5, %4
  %.0 = phi i32 [ 2, %4 ], [ 0, %5 ]
  ret i32 %.0
}

declare i32 @__isoc99_scanf(i8*, ...) #1

declare i32 @open(i8*, i32, ...) #1

declare void @perror(i8*) #1

declare i64 @read(i32, i8*, i64) #1

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind
declare i64 @lseek(i32, i64, i32) #2

declare i32 @close(i32) #1

declare void @memcpy(i8*, i8*, i64)

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
