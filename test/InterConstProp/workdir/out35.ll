; ModuleID = 'workdir/out35.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private constant [12 x i8] c"helloWorld0\00", align 1
@.str.2 = private constant [12 x i8] c"helloWorld1\00", align 1
@.str.4 = private unnamed_addr constant [19 x i8] c"inter35_fileio.txt\00", align 1
@0 = internal constant [2 x i8] c"1\00"
@str.2 = private unnamed_addr constant [15 x i8] c"file not found\00"
@str.3 = private unnamed_addr constant [18 x i8] c"branchNotPruned 0\00"
@str.4 = private unnamed_addr constant [18 x i8] c"branchNotPruned 1\00"

; Function Attrs: nounwind uwtable
define void @branchNotPruned(i8* nocapture readonly %buffer) #0 {
  %1 = tail call i32 @strcmp(i8* %buffer, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0)) #5
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.3, i64 0, i64 0))
  br label %8

; <label>:4                                       ; preds = %0
  %5 = tail call i32 @strcmp(i8* %buffer, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0)) #5
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %8

; <label>:7                                       ; preds = %4
  %puts1 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.4, i64 0, i64 0))
  br label %8

; <label>:8                                       ; preds = %4, %7, %3
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readonly %argv) #0 {
  %buffer = alloca [100 x i8], align 16
  %1 = tail call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.4, i64 0, i64 0), i32 0) #4
  %2 = icmp slt i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([15 x i8], [15 x i8]* @str.2, i64 0, i64 0))
  br label %4

; <label>:4                                       ; preds = %3, %0
  %5 = getelementptr inbounds i8*, i8** %argv, i64 1
  %6 = load i8*, i8** %5, align 8
  %7 = tail call i32 @strcmp(i8* %6, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @0, i64 0, i64 0)) #5
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %11

; <label>:9                                       ; preds = %4
  %10 = tail call i64 @lseek(i32 %1, i64 11, i32 0) #4
  br label %11

; <label>:11                                      ; preds = %4, %9
  %12 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i64 0, i64 0
  %13 = call i64 @read(i32 %1, i8* %12, i64 11) #4
  %sext = shl i64 %13, 32
  %14 = ashr exact i64 %sext, 32
  %15 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i64 0, i64 %14
  store i8 0, i8* %15, align 1
  %16 = call i32 @strcmp(i8* %12, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0)) #5
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %19

; <label>:18                                      ; preds = %11
  %puts.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.3, i64 0, i64 0)) #4
  br label %branchNotPruned_clone.exit

; <label>:19                                      ; preds = %11
  %20 = call i32 @strcmp(i8* %12, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0)) #5
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %22, label %branchNotPruned_clone.exit

; <label>:22                                      ; preds = %19
  %puts1.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.4, i64 0, i64 0)) #4
  br label %branchNotPruned_clone.exit

branchNotPruned_clone.exit:                       ; preds = %18, %19, %22
  ret i32 0
}

declare i32 @open(i8* nocapture readonly, i32, ...) #2

; Function Attrs: nounwind
declare i64 @lseek(i32, i64, i32) #3

declare i64 @read(i32, i8* nocapture, i64) #2

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(i8* nocapture readonly %buffer) #0 {
  %1 = tail call i32 @strcmp(i8* %buffer, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0)) #5
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.3, i64 0, i64 0))
  br label %8

; <label>:4                                       ; preds = %0
  %5 = tail call i32 @strcmp(i8* %buffer, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0)) #5
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %8

; <label>:7                                       ; preds = %4
  %puts1 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.4, i64 0, i64 0))
  br label %8

; <label>:8                                       ; preds = %4, %7, %3
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
