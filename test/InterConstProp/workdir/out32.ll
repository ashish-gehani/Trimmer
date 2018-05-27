; ModuleID = 'workdir/out32.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [13 x i8] c"helloWorld1\0A\00", align 1
@.str.1 = private unnamed_addr constant [13 x i8] c"helloWorld2\0A\00", align 1
@.str.2 = private unnamed_addr constant [13 x i8] c"helloWorld3\0A\00", align 1
@.str.3 = private unnamed_addr constant [13 x i8] c"helloWorld4\0A\00", align 1
@.str.4 = private unnamed_addr constant [13 x i8] c"helloWorld5\0A\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr constant [19 x i8] c"inter32_fileio.txt\00", align 1
@str.1 = private unnamed_addr constant [15 x i8] c"file not found\00"
@str.2 = private unnamed_addr constant [13 x i8] c"branchPruned\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(i8** nocapture readonly %buffer, i8* readnone %line) #0 {
  %1 = load i8*, i8** %buffer, align 8
  %2 = tail call i32 @strcmp(i8* %1, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i64 0, i64 0)) #5
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %51

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8*, i8** %buffer, i64 1
  %6 = load i8*, i8** %5, align 8
  %7 = tail call i32 @strcmp(i8* %6, i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i64 0, i64 0)) #5
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %51

; <label>:9                                       ; preds = %4
  %10 = getelementptr inbounds i8*, i8** %buffer, i64 2
  %11 = load i8*, i8** %10, align 8
  %12 = tail call i32 @strcmp(i8* %11, i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @.str.2, i64 0, i64 0)) #5
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %51

; <label>:14                                      ; preds = %9
  %15 = getelementptr inbounds i8*, i8** %buffer, i64 3
  %16 = load i8*, i8** %15, align 8
  %17 = tail call i32 @strcmp(i8* %16, i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @.str.3, i64 0, i64 0)) #5
  %18 = icmp eq i32 %17, 0
  br i1 %18, label %19, label %51

; <label>:19                                      ; preds = %14
  %20 = getelementptr inbounds i8*, i8** %buffer, i64 4
  %21 = load i8*, i8** %20, align 8
  %22 = tail call i32 @strcmp(i8* %21, i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i64 0, i64 0)) #5
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %24, label %51

; <label>:24                                      ; preds = %19
  %25 = getelementptr inbounds i8*, i8** %buffer, i64 5
  %26 = load i8*, i8** %25, align 8
  %27 = tail call i32 @strcmp(i8* %26, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0)) #5
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %29, label %51

; <label>:29                                      ; preds = %24
  %30 = getelementptr inbounds i8*, i8** %buffer, i64 6
  %31 = load i8*, i8** %30, align 8
  %32 = tail call i32 @strcmp(i8* %31, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0)) #5
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %34, label %51

; <label>:34                                      ; preds = %29
  %35 = getelementptr inbounds i8*, i8** %buffer, i64 7
  %36 = load i8*, i8** %35, align 8
  %37 = tail call i32 @strcmp(i8* %36, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0)) #5
  %38 = icmp eq i32 %37, 0
  br i1 %38, label %39, label %51

; <label>:39                                      ; preds = %34
  %40 = getelementptr inbounds i8*, i8** %buffer, i64 8
  %41 = load i8*, i8** %40, align 8
  %42 = tail call i32 @strcmp(i8* %41, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0)) #5
  %43 = icmp eq i32 %42, 0
  br i1 %43, label %44, label %51

; <label>:44                                      ; preds = %39
  %45 = getelementptr inbounds i8*, i8** %buffer, i64 9
  %46 = load i8*, i8** %45, align 8
  %47 = tail call i32 @strcmp(i8* %46, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0)) #5
  %48 = icmp ne i32 %47, 0
  %49 = icmp ne i8* %line, null
  %or.cond = or i1 %49, %48
  br i1 %or.cond, label %51, label %50

; <label>:50                                      ; preds = %44
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @str.2, i64 0, i64 0))
  br label %51

; <label>:51                                      ; preds = %39, %34, %29, %24, %19, %14, %9, %4, %0, %50, %44
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i8* @getLine(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = tail call i64 @lseek(i32 %fd, i64 0, i32 1) #4
  %2 = sext i32 %size to i64
  %3 = tail call i64 @read(i32 %fd, i8* %line, i64 %2) #4
  %4 = trunc i64 %3 to i32
  %5 = icmp slt i32 %4, 1
  br i1 %5, label %19, label %6

; <label>:6                                       ; preds = %0
  %7 = tail call i64 @strcspn(i8* %line, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0)) #5
  %8 = trunc i64 %7 to i32
  %9 = icmp slt i32 %8, %size
  br i1 %9, label %10, label %14

; <label>:10                                      ; preds = %6
  %11 = shl i64 %7, 32
  %sext1 = add i64 %11, 4294967296
  %12 = ashr exact i64 %sext1, 32
  %13 = getelementptr inbounds i8, i8* %line, i64 %12
  store i8 0, i8* %13, align 1
  br label %14

; <label>:14                                      ; preds = %10, %6
  %15 = add i64 %7, %1
  %16 = shl i64 %15, 32
  %sext = add i64 %16, 4294967296
  %17 = ashr exact i64 %sext, 32
  %18 = tail call i64 @lseek(i32 %fd, i64 %17, i32 0) #4
  br label %19

; <label>:19                                      ; preds = %0, %14
  %.0 = phi i8* [ %line, %14 ], [ null, %0 ]
  ret i8* %.0
}

; Function Attrs: nounwind
declare i64 @lseek(i32, i64, i32) #2

declare i64 @read(i32, i8* nocapture, i64) #3

; Function Attrs: nounwind readonly
declare i64 @strcspn(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %line = alloca [1024 x i8], align 16
  %1 = tail call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.7, i64 0, i64 0), i32 0) #4
  %2 = icmp slt i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([15 x i8], [15 x i8]* @str.1, i64 0, i64 0))
  br label %4

; <label>:4                                       ; preds = %3, %0
  %5 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i64 0, i64 0
  %6 = tail call i64 @lseek(i32 %1, i64 0, i32 1) #4
  %7 = call i64 @read(i32 %1, i8* %5, i64 1024) #4
  %8 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i64 0, i64 12
  store i8 0, i8* %8, align 4
  %9 = tail call i64 @lseek(i32 %1, i64 12, i32 0) #4
  %10 = tail call i64 @lseek(i32 %1, i64 0, i32 1) #4
  %11 = call i64 @read(i32 %1, i8* %5, i64 1024) #4
  store i8 0, i8* %8, align 4
  %12 = tail call i64 @lseek(i32 %1, i64 24, i32 0) #4
  %13 = tail call i64 @lseek(i32 %1, i64 0, i32 1) #4
  %14 = call i64 @read(i32 %1, i8* %5, i64 1024) #4
  store i8 0, i8* %8, align 4
  %15 = tail call i64 @lseek(i32 %1, i64 36, i32 0) #4
  %16 = tail call i64 @lseek(i32 %1, i64 0, i32 1) #4
  %17 = call i64 @read(i32 %1, i8* %5, i64 1024) #4
  store i8 0, i8* %8, align 4
  %18 = tail call i64 @lseek(i32 %1, i64 48, i32 0) #4
  %19 = tail call i64 @lseek(i32 %1, i64 0, i32 1) #4
  %20 = call i64 @read(i32 %1, i8* %5, i64 1024) #4
  store i8 0, i8* %8, align 4
  %21 = tail call i64 @lseek(i32 %1, i64 60, i32 0) #4
  %22 = tail call i64 @lseek(i32 %1, i64 0, i32 1) #4
  %23 = call i64 @read(i32 %1, i8* %5, i64 1024) #4
  %24 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i64 0, i64 1
  store i8 0, i8* %24, align 1
  %25 = tail call i64 @lseek(i32 %1, i64 61, i32 0) #4
  %26 = tail call i64 @lseek(i32 %1, i64 0, i32 1) #4
  %27 = call i64 @read(i32 %1, i8* %5, i64 1024) #4
  store i8 0, i8* %24, align 1
  %28 = tail call i64 @lseek(i32 %1, i64 62, i32 0) #4
  %29 = tail call i64 @lseek(i32 %1, i64 0, i32 1) #4
  %30 = call i64 @read(i32 %1, i8* %5, i64 1024) #4
  store i8 0, i8* %24, align 1
  %31 = tail call i64 @lseek(i32 %1, i64 63, i32 0) #4
  %32 = tail call i64 @lseek(i32 %1, i64 0, i32 1) #4
  %33 = call i64 @read(i32 %1, i8* %5, i64 1024) #4
  store i8 0, i8* %24, align 1
  %34 = tail call i64 @lseek(i32 %1, i64 64, i32 0) #4
  %35 = tail call i64 @lseek(i32 %1, i64 0, i32 1) #4
  %36 = call i64 @read(i32 %1, i8* %5, i64 1024) #4
  store i8 0, i8* %24, align 1
  %37 = tail call i64 @lseek(i32 %1, i64 65, i32 0) #4
  %38 = tail call i64 @lseek(i32 %1, i64 0, i32 1) #4
  %39 = call i64 @read(i32 %1, i8* %5, i64 1024) #4
  %puts.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @str.2, i64 0, i64 0)) #4
  ret i32 0
}

declare i32 @open(i8* nocapture readonly, i32, ...) #3

; Function Attrs: nounwind uwtable
define i8* @getLine_clone(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = tail call i64 @lseek(i32 %fd, i64 0, i32 1) #4
  %2 = tail call i64 @read(i32 %fd, i8* %line, i64 1024) #4
  %3 = getelementptr inbounds i8, i8* %line, i64 12
  store i8 0, i8* %3, align 1
  %4 = tail call i64 @lseek(i32 %fd, i64 12, i32 0) #4
  ret i8* %line
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.3(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = tail call i64 @lseek(i32 %fd, i64 0, i32 1) #4
  %2 = tail call i64 @read(i32 %fd, i8* %line, i64 1024) #4
  %3 = getelementptr inbounds i8, i8* %line, i64 12
  store i8 0, i8* %3, align 1
  %4 = tail call i64 @lseek(i32 %fd, i64 24, i32 0) #4
  ret i8* %line
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.5(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = tail call i64 @lseek(i32 %fd, i64 0, i32 1) #4
  %2 = tail call i64 @read(i32 %fd, i8* %line, i64 1024) #4
  %3 = getelementptr inbounds i8, i8* %line, i64 12
  store i8 0, i8* %3, align 1
  %4 = tail call i64 @lseek(i32 %fd, i64 36, i32 0) #4
  ret i8* %line
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.7(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = tail call i64 @lseek(i32 %fd, i64 0, i32 1) #4
  %2 = tail call i64 @read(i32 %fd, i8* %line, i64 1024) #4
  %3 = getelementptr inbounds i8, i8* %line, i64 12
  store i8 0, i8* %3, align 1
  %4 = tail call i64 @lseek(i32 %fd, i64 48, i32 0) #4
  ret i8* %line
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.9(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = tail call i64 @lseek(i32 %fd, i64 0, i32 1) #4
  %2 = tail call i64 @read(i32 %fd, i8* %line, i64 1024) #4
  %3 = getelementptr inbounds i8, i8* %line, i64 12
  store i8 0, i8* %3, align 1
  %4 = tail call i64 @lseek(i32 %fd, i64 60, i32 0) #4
  ret i8* %line
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.11(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = tail call i64 @lseek(i32 %fd, i64 0, i32 1) #4
  %2 = tail call i64 @read(i32 %fd, i8* %line, i64 1024) #4
  %3 = getelementptr inbounds i8, i8* %line, i64 1
  store i8 0, i8* %3, align 1
  %4 = tail call i64 @lseek(i32 %fd, i64 61, i32 0) #4
  ret i8* %line
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.13(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = tail call i64 @lseek(i32 %fd, i64 0, i32 1) #4
  %2 = tail call i64 @read(i32 %fd, i8* %line, i64 1024) #4
  %3 = getelementptr inbounds i8, i8* %line, i64 1
  store i8 0, i8* %3, align 1
  %4 = tail call i64 @lseek(i32 %fd, i64 62, i32 0) #4
  ret i8* %line
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.15(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = tail call i64 @lseek(i32 %fd, i64 0, i32 1) #4
  %2 = tail call i64 @read(i32 %fd, i8* %line, i64 1024) #4
  %3 = getelementptr inbounds i8, i8* %line, i64 1
  store i8 0, i8* %3, align 1
  %4 = tail call i64 @lseek(i32 %fd, i64 63, i32 0) #4
  ret i8* %line
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.17(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = tail call i64 @lseek(i32 %fd, i64 0, i32 1) #4
  %2 = tail call i64 @read(i32 %fd, i8* %line, i64 1024) #4
  %3 = getelementptr inbounds i8, i8* %line, i64 1
  store i8 0, i8* %3, align 1
  %4 = tail call i64 @lseek(i32 %fd, i64 64, i32 0) #4
  ret i8* %line
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.19(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = tail call i64 @lseek(i32 %fd, i64 0, i32 1) #4
  %2 = tail call i64 @read(i32 %fd, i8* %line, i64 1024) #4
  %3 = getelementptr inbounds i8, i8* %line, i64 1
  store i8 0, i8* %3, align 1
  %4 = tail call i64 @lseek(i32 %fd, i64 65, i32 0) #4
  ret i8* %line
}

; Function Attrs: nounwind uwtable
define noalias i8* @getLine_clone.21(i32 %fd, i8* nocapture %line, i32 %size) #0 {
  %1 = tail call i64 @lseek(i32 %fd, i64 0, i32 1) #4
  %2 = tail call i64 @read(i32 %fd, i8* %line, i64 1024) #4
  ret i8* null
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(i8** nocapture readnone %buffer, i8* nocapture readnone %line) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.2, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
