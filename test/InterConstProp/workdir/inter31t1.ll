; ModuleID = 'workdir/inter31t1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@.str.2 = private unnamed_addr constant [19 x i8] c"inter31_fileio.txt\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"file not found\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @branchPruned(i32 %size, i8* %buffer) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  store i32 %size, i32* %1, align 4
  store i8* %buffer, i8** %2, align 8
  %3 = load i32, i32* %1, align 4
  %4 = icmp eq i32 %3, 10
  br i1 %4, label %5, label %11

; <label>:5                                       ; preds = %0
  %6 = load i8*, i8** %2, align 8
  %7 = call i32 @strcmp(i8* %6, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #3
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %11, label %9

; <label>:9                                       ; preds = %5
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i32 0, i32 0))
  br label %11

; <label>:11                                      ; preds = %9, %5, %0
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
  %4 = call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.2, i32 0, i32 0), i32 0)
  store i32 %4, i32* %fd, align 4
  %5 = load i32, i32* %fd, align 4
  %6 = icmp slt i32 %5, 0
  br i1 %6, label %7, label %9

; <label>:7                                       ; preds = %0
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i32 0, i32 0))
  br label %9

; <label>:9                                       ; preds = %7, %0
  %10 = load i32, i32* %fd, align 4
  %11 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  %12 = call i64 @read(i32 %10, i8* %11, i64 100)
  %13 = trunc i64 %12 to i32
  store i32 %13, i32* %bytes_read, align 4
  %14 = load i32, i32* %bytes_read, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i64 0, i64 %15
  store i8 0, i8* %16, align 1
  %17 = load i32, i32* %bytes_read, align 4
  %18 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  call void @branchPruned(i32 %17, i8* %18)
  ret i32 0
}

declare i32 @open(i8*, i32, ...) #2

declare i64 @read(i32, i8*, i64) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
