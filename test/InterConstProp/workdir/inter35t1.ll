; ModuleID = 'workdir/inter35t1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [12 x i8] c"helloWorld0\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"branchNotPruned 0\0A\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloWorld1\00", align 1
@.str.3 = private unnamed_addr constant [19 x i8] c"branchNotPruned 1\0A\00", align 1
@.str.4 = private unnamed_addr constant [19 x i8] c"inter35_fileio.txt\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"file not found\0A\00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c"1\00", align 1

; Function Attrs: nounwind uwtable
define void @branchNotPruned(i8* %buffer) #0 {
  %1 = alloca i8*, align 8
  store i8* %buffer, i8** %1, align 8
  %2 = load i8*, i8** %1, align 8
  %3 = call i32 @strcmp(i8* %2, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0)) #4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %7, label %5

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %14

; <label>:7                                       ; preds = %0
  %8 = load i8*, i8** %1, align 8
  %9 = call i32 @strcmp(i8* %8, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0)) #4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %13, label %11

; <label>:11                                      ; preds = %7
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.3, i32 0, i32 0))
  br label %13

; <label>:13                                      ; preds = %11, %7
  br label %14

; <label>:14                                      ; preds = %13, %5
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %buffer = alloca [100 x i8], align 16
  %fd = alloca i32, align 4
  %bytes_read = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.4, i32 0, i32 0), i32 0)
  store i32 %4, i32* %fd, align 4
  %5 = load i32, i32* %fd, align 4
  %6 = icmp slt i32 %5, 0
  br i1 %6, label %7, label %9

; <label>:7                                       ; preds = %0
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i32 0, i32 0))
  br label %9

; <label>:9                                       ; preds = %7, %0
  %10 = load i8**, i8*** %3, align 8
  %11 = getelementptr inbounds i8*, i8** %10, i64 1
  %12 = load i8*, i8** %11, align 8
  %13 = call i32 @strcmp(i8* %12, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.6, i32 0, i32 0)) #4
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %18, label %15

; <label>:15                                      ; preds = %9
  %16 = load i32, i32* %fd, align 4
  %17 = call i64 @lseek(i32 %16, i64 11, i32 0) #5
  br label %18

; <label>:18                                      ; preds = %15, %9
  %19 = load i32, i32* %fd, align 4
  %20 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  %21 = call i64 @read(i32 %19, i8* %20, i64 11)
  %22 = trunc i64 %21 to i32
  store i32 %22, i32* %bytes_read, align 4
  %23 = load i32, i32* %bytes_read, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i64 0, i64 %24
  store i8 0, i8* %25, align 1
  %26 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  call void @branchNotPruned(i8* %26)
  ret i32 0
}

declare i32 @open(i8*, i32, ...) #2

; Function Attrs: nounwind
declare i64 @lseek(i32, i64, i32) #3

declare i64 @read(i32, i8*, i64) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }
attributes #5 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
