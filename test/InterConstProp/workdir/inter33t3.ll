; ModuleID = 'workdir/inter33t3.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c"branchNotPruned\0A\00", align 1
@.str.2 = private unnamed_addr constant [19 x i8] c"inter31_fileio.txt\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"file not found\0A\00", align 1
@0 = constant [11 x i8] c"helloWorld\00"

; Function Attrs: nounwind uwtable
define void @branchNotPruned(i32 %size, i8* %buffer) #0 {
  %1 = icmp eq i32 %size, 10
  br i1 %1, label %2, label %7

; <label>:2                                       ; preds = %0
  %3 = call i32 @strcmp(i8* %buffer, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %7, label %5

; <label>:5                                       ; preds = %2
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0))
  br label %7

; <label>:7                                       ; preds = %5, %2, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %buffer2 = alloca [100 x i8], align 16
  %1 = getelementptr inbounds i8*, i8** %argv, i64 0
  %2 = load i8*, i8** %1, align 8
  %3 = call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.2, i32 0, i32 0), i32 0)
  %4 = icmp slt i32 %3, 0
  br i1 %4, label %5, label %7

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i32 0, i32 0))
  br label %7

; <label>:7                                       ; preds = %5, %0
  %8 = call i64 @strlen(i8* %2) #4
  %9 = call i64 @read(i32 %3, i8* %2, i64 %8)
  %10 = call i64 @lseek(i32 %3, i64 0, i32 0) #5
  %11 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer2, i32 0, i32 0
  %12 = call i64 @read(i32 %3, i8* %11, i64 100)
  %13 = trunc i64 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer2, i64 0, i64 %14
  store i8 0, i8* %15, align 1
  %16 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer2, i32 0, i32 0
  call void @branchNotPruned_clone(i32 %13, i8* %16)
  ret i32 0
}

declare i32 @open(i8*, i32, ...) #2

declare i64 @read(i32, i8*, i64) #2

; Function Attrs: nounwind readonly
declare i64 @strlen(i8*) #1

; Function Attrs: nounwind
declare i64 @lseek(i32, i64, i32) #3

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(i32 %size, i8* %buffer) #0 {
  %1 = icmp eq i32 %size, 10
  br i1 %1, label %2, label %8

; <label>:2                                       ; preds = %0
  %3 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %4 = call i32 @strcmp(i8* %buffer, i8* %3) #4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %8, label %6

; <label>:6                                       ; preds = %2
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0))
  br label %8

; <label>:8                                       ; preds = %6, %2, %0
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }
attributes #5 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
