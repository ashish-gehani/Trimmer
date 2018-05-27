; ModuleID = 'workdir/inter31t3.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@.str.2 = private unnamed_addr constant [19 x i8] c"inter31_fileio.txt\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"file not found\0A\00", align 1
@0 = constant [11 x i8] c"helloWorld\00"
@1 = constant [11 x i8] c"helloWorld\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(i32 %size, i8* %buffer) #0 {
  %1 = icmp eq i32 %size, 10
  br i1 %1, label %2, label %7

; <label>:2                                       ; preds = %0
  %3 = call i32 @strcmp(i8* %buffer, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #3
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %7, label %5

; <label>:5                                       ; preds = %2
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i32 0, i32 0))
  br label %7

; <label>:7                                       ; preds = %5, %2, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %buffer = alloca [100 x i8], align 16
  %1 = call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.2, i32 0, i32 0), i32 0)
  %2 = icmp slt i32 %1, 0
  br i1 %2, label %3, label %5

; <label>:3                                       ; preds = %0
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i32 0, i32 0))
  br label %5

; <label>:5                                       ; preds = %3, %0
  %6 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  %7 = call i64 @read(i32 %1, i8* %6, i64 100)
  %8 = trunc i64 10 to i32
  %9 = sext i32 10 to i64
  %10 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i64 0, i64 10
  store i8 0, i8* %10, align 1
  %11 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  call void @branchPruned_clone(i32 10, i8* %11)
  ret i32 0
}

declare i32 @open(i8*, i32, ...) #2

declare i64 @read(i32, i8*, i64) #2

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(i32 %size, i8* %buffer) #0 {
  %1 = icmp eq i32 10, 10
  br i1 true, label %2, label %9

; <label>:2                                       ; preds = %0
  %3 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %4 = getelementptr [11 x i8], [11 x i8]* @1, i64 0, i64 0
  %5 = call i32 @strcmp(i8* %3, i8* %4) #3
  %6 = icmp ne i32 0, 0
  br i1 false, label %9, label %7

; <label>:7                                       ; preds = %2
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i32 0, i32 0))
  br label %9

; <label>:9                                       ; preds = %7, %2, %0
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
