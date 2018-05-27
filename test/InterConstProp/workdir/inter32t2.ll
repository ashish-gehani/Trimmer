; ModuleID = 'workdir/inter32t2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [13 x i8] c"helloWorld1\0A\00", align 1
@.str.1 = private unnamed_addr constant [13 x i8] c"helloWorld2\0A\00", align 1
@.str.2 = private unnamed_addr constant [13 x i8] c"helloWorld3\0A\00", align 1
@.str.3 = private unnamed_addr constant [13 x i8] c"helloWorld4\0A\00", align 1
@.str.4 = private unnamed_addr constant [13 x i8] c"helloWorld5\0A\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.6 = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@.str.7 = private unnamed_addr constant [19 x i8] c"inter32_fileio.txt\00", align 1
@.str.8 = private unnamed_addr constant [16 x i8] c"file not found\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @branchPruned(i8** %buffer, i8* %line) #0 {
  %1 = getelementptr inbounds i8*, i8** %buffer, i64 0
  %2 = load i8*, i8** %1, align 8
  %3 = call i32 @strcmp(i8* %2, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i32 0, i32 0)) #5
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %53, label %5

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds i8*, i8** %buffer, i64 1
  %7 = load i8*, i8** %6, align 8
  %8 = call i32 @strcmp(i8* %7, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i32 0, i32 0)) #5
  %9 = icmp ne i32 %8, 0
  br i1 %9, label %53, label %10

; <label>:10                                      ; preds = %5
  %11 = getelementptr inbounds i8*, i8** %buffer, i64 2
  %12 = load i8*, i8** %11, align 8
  %13 = call i32 @strcmp(i8* %12, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.2, i32 0, i32 0)) #5
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %53, label %15

; <label>:15                                      ; preds = %10
  %16 = getelementptr inbounds i8*, i8** %buffer, i64 3
  %17 = load i8*, i8** %16, align 8
  %18 = call i32 @strcmp(i8* %17, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.3, i32 0, i32 0)) #5
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %53, label %20

; <label>:20                                      ; preds = %15
  %21 = getelementptr inbounds i8*, i8** %buffer, i64 4
  %22 = load i8*, i8** %21, align 8
  %23 = call i32 @strcmp(i8* %22, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i32 0, i32 0)) #5
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %53, label %25

; <label>:25                                      ; preds = %20
  %26 = getelementptr inbounds i8*, i8** %buffer, i64 5
  %27 = load i8*, i8** %26, align 8
  %28 = call i32 @strcmp(i8* %27, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %53, label %30

; <label>:30                                      ; preds = %25
  %31 = getelementptr inbounds i8*, i8** %buffer, i64 6
  %32 = load i8*, i8** %31, align 8
  %33 = call i32 @strcmp(i8* %32, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %34 = icmp ne i32 %33, 0
  br i1 %34, label %53, label %35

; <label>:35                                      ; preds = %30
  %36 = getelementptr inbounds i8*, i8** %buffer, i64 7
  %37 = load i8*, i8** %36, align 8
  %38 = call i32 @strcmp(i8* %37, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %39 = icmp ne i32 %38, 0
  br i1 %39, label %53, label %40

; <label>:40                                      ; preds = %35
  %41 = getelementptr inbounds i8*, i8** %buffer, i64 8
  %42 = load i8*, i8** %41, align 8
  %43 = call i32 @strcmp(i8* %42, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %44 = icmp ne i32 %43, 0
  br i1 %44, label %53, label %45

; <label>:45                                      ; preds = %40
  %46 = getelementptr inbounds i8*, i8** %buffer, i64 9
  %47 = load i8*, i8** %46, align 8
  %48 = call i32 @strcmp(i8* %47, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %49 = icmp ne i32 %48, 0
  %50 = icmp ne i8* %line, null
  %or.cond = or i1 %49, %50
  br i1 %or.cond, label %53, label %51

; <label>:51                                      ; preds = %45
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.6, i32 0, i32 0))
  br label %53

; <label>:53                                      ; preds = %51, %45, %40, %35, %30, %25, %20, %15, %10, %5, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define i8* @getLine(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = call i64 @lseek(i32 %fd, i64 0, i32 1) #6
  %2 = trunc i64 %1 to i32
  %3 = sext i32 %size to i64
  %4 = call i64 @read(i32 %fd, i8* %line, i64 %3)
  %5 = trunc i64 %4 to i32
  %6 = icmp sle i32 %5, 0
  br i1 %6, label %21, label %7

; <label>:7                                       ; preds = %0
  %8 = call i64 @strcspn(i8* %line, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %9 = trunc i64 %8 to i32
  %10 = icmp slt i32 %9, %size
  br i1 %10, label %11, label %15

; <label>:11                                      ; preds = %7
  %12 = add nsw i32 %9, 1
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds i8, i8* %line, i64 %13
  store i8 0, i8* %14, align 1
  br label %15

; <label>:15                                      ; preds = %11, %7
  %16 = add nsw i32 %2, %9
  %17 = add nsw i32 %16, 1
  %18 = sext i32 %17 to i64
  %19 = call i64 @lseek(i32 %fd, i64 %18, i32 0) #6
  %20 = trunc i64 %19 to i32
  br label %21

; <label>:21                                      ; preds = %0, %15
  %.0 = phi i8* [ %line, %15 ], [ null, %0 ]
  ret i8* %.0
}

; Function Attrs: nounwind
declare i64 @lseek(i32, i64, i32) #3

declare i64 @read(i32, i8*, i64) #2

; Function Attrs: nounwind readonly
declare i64 @strcspn(i8*, i8*) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %buffer = alloca [10 x i8*], align 16
  %line = alloca [1024 x i8], align 16
  %1 = call noalias i8* @malloc(i64 100) #6
  %2 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 0
  store i8* %1, i8** %2, align 16
  %3 = call noalias i8* @malloc(i64 100) #6
  %4 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 1
  store i8* %3, i8** %4, align 8
  %5 = call noalias i8* @malloc(i64 100) #6
  %6 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 2
  store i8* %5, i8** %6, align 16
  %7 = call noalias i8* @malloc(i64 100) #6
  %8 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 3
  store i8* %7, i8** %8, align 8
  %9 = call noalias i8* @malloc(i64 100) #6
  %10 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 4
  store i8* %9, i8** %10, align 16
  %11 = call noalias i8* @malloc(i64 100) #6
  %12 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 5
  store i8* %11, i8** %12, align 8
  %13 = call noalias i8* @malloc(i64 100) #6
  %14 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 6
  store i8* %13, i8** %14, align 16
  %15 = call noalias i8* @malloc(i64 100) #6
  %16 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 7
  store i8* %15, i8** %16, align 8
  %17 = call noalias i8* @malloc(i64 100) #6
  %18 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 8
  store i8* %17, i8** %18, align 16
  %19 = call noalias i8* @malloc(i64 100) #6
  %20 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 9
  store i8* %19, i8** %20, align 8
  %21 = call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.7, i32 0, i32 0), i32 0)
  %22 = icmp slt i32 %21, 0
  br i1 %22, label %23, label %25

; <label>:23                                      ; preds = %0
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.8, i32 0, i32 0))
  br label %25

; <label>:25                                      ; preds = %23, %0
  %26 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %27 = call i8* @getLine(i32 %21, i8* %26, i32 1024)
  %28 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 0
  %29 = load i8*, i8** %28, align 16
  %30 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %31 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %32 = call i64 @strlen(i8* %31) #5
  %33 = add i64 %32, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %29, i8* %30, i64 %33, i32 1, i1 false)
  %34 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %35 = call i8* @getLine(i32 %21, i8* %34, i32 1024)
  %36 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 1
  %37 = load i8*, i8** %36, align 8
  %38 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %39 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %40 = call i64 @strlen(i8* %39) #5
  %41 = add i64 %40, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %37, i8* %38, i64 %41, i32 1, i1 false)
  %42 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %43 = call i8* @getLine(i32 %21, i8* %42, i32 1024)
  %44 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 2
  %45 = load i8*, i8** %44, align 16
  %46 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %47 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %48 = call i64 @strlen(i8* %47) #5
  %49 = add i64 %48, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %45, i8* %46, i64 %49, i32 1, i1 false)
  %50 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %51 = call i8* @getLine(i32 %21, i8* %50, i32 1024)
  %52 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 3
  %53 = load i8*, i8** %52, align 8
  %54 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %55 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %56 = call i64 @strlen(i8* %55) #5
  %57 = add i64 %56, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %53, i8* %54, i64 %57, i32 1, i1 false)
  %58 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %59 = call i8* @getLine(i32 %21, i8* %58, i32 1024)
  %60 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 4
  %61 = load i8*, i8** %60, align 16
  %62 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %63 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %64 = call i64 @strlen(i8* %63) #5
  %65 = add i64 %64, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %61, i8* %62, i64 %65, i32 1, i1 false)
  %66 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %67 = call i8* @getLine(i32 %21, i8* %66, i32 1024)
  %68 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 5
  %69 = load i8*, i8** %68, align 8
  %70 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %71 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %72 = call i64 @strlen(i8* %71) #5
  %73 = add i64 %72, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %69, i8* %70, i64 %73, i32 1, i1 false)
  %74 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %75 = call i8* @getLine(i32 %21, i8* %74, i32 1024)
  %76 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 6
  %77 = load i8*, i8** %76, align 16
  %78 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %79 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %80 = call i64 @strlen(i8* %79) #5
  %81 = add i64 %80, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %77, i8* %78, i64 %81, i32 1, i1 false)
  %82 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %83 = call i8* @getLine(i32 %21, i8* %82, i32 1024)
  %84 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 7
  %85 = load i8*, i8** %84, align 8
  %86 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %87 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %88 = call i64 @strlen(i8* %87) #5
  %89 = add i64 %88, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %85, i8* %86, i64 %89, i32 1, i1 false)
  %90 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %91 = call i8* @getLine(i32 %21, i8* %90, i32 1024)
  %92 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 8
  %93 = load i8*, i8** %92, align 16
  %94 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %95 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %96 = call i64 @strlen(i8* %95) #5
  %97 = add i64 %96, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %93, i8* %94, i64 %97, i32 1, i1 false)
  %98 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %99 = call i8* @getLine(i32 %21, i8* %98, i32 1024)
  %100 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 9
  %101 = load i8*, i8** %100, align 8
  %102 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %103 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %104 = call i64 @strlen(i8* %103) #5
  %105 = add i64 %104, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %101, i8* %102, i64 %105, i32 1, i1 false)
  %106 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i32 0, i32 0
  %107 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %108 = call i8* @getLine(i32 %21, i8* %107, i32 1024)
  call void @branchPruned(i8** %106, i8* %108)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

declare i32 @open(i8*, i32, ...) #2

; Function Attrs: nounwind readonly
declare i64 @strlen(i8*) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
