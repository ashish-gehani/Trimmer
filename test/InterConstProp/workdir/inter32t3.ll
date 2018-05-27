; ModuleID = 'workdir/inter32t3.bc'
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
@0 = constant [66 x i8] c"helloWorld1\0AhelloWorld2\0AhelloWorld3\0AhelloWorld4\0AhelloWorld5\0A\0A\0A\0A\0A\0A\00"
@1 = constant [2 x i8] c"\0A\00"
@2 = constant [13 x i8] c"helloWorld1\0A\00"
@3 = constant [66 x i8] c"helloWorld2\0AhelloWorld3\0AhelloWorld4\0AhelloWorld5\0A\0A\0A\0A\0A\0AWorld5\0A\0A\0A\0A\0A\0A\00"
@4 = constant [2 x i8] c"\0A\00"
@5 = constant [13 x i8] c"helloWorld2\0A\00"
@6 = constant [66 x i8] c"helloWorld3\0AhelloWorld4\0AhelloWorld5\0A\0A\0A\0A\0A\0AWorld5\0A\0A\0A\0A\0A\0AWorld5\0A\0A\0A\0A\0A\0A\00"
@7 = constant [2 x i8] c"\0A\00"
@8 = constant [13 x i8] c"helloWorld3\0A\00"
@9 = constant [66 x i8] c"helloWorld4\0AhelloWorld5\0A\0A\0A\0A\0A\0AWorld5\0A\0A\0A\0A\0A\0AWorld5\0A\0A\0A\0A\0A\0AWorld5\0A\0A\0A\0A\0A\0A\00"
@10 = constant [2 x i8] c"\0A\00"
@11 = constant [13 x i8] c"helloWorld4\0A\00"
@12 = constant [66 x i8] c"helloWorld5\0A\0A\0A\0A\0A\0AWorld5\0A\0A\0A\0A\0A\0AWorld5\0A\0A\0A\0A\0A\0AWorld5\0A\0A\0A\0A\0A\0AWorld5\0A\0A\0A\0A\0A\0A\00"
@13 = constant [2 x i8] c"\0A\00"
@14 = constant [13 x i8] c"helloWorld5\0A\00"
@15 = constant [13 x i8] c"\0A\0A\0A\0A\0AWorld5\0A\00"
@16 = constant [2 x i8] c"\0A\00"
@17 = constant [2 x i8] c"\0A\00"
@18 = constant [13 x i8] c"\0A\0A\0A\0A\0AWorld5\0A\00"
@19 = constant [2 x i8] c"\0A\00"
@20 = constant [2 x i8] c"\0A\00"
@21 = constant [13 x i8] c"\0A\0A\0A\0A\0AWorld5\0A\00"
@22 = constant [2 x i8] c"\0A\00"
@23 = constant [2 x i8] c"\0A\00"
@24 = constant [13 x i8] c"\0A\0A\0A\0A\0AWorld5\0A\00"
@25 = constant [2 x i8] c"\0A\00"
@26 = constant [2 x i8] c"\0A\00"
@27 = constant [2 x i8] c"\0A\00"
@28 = constant [2 x i8] c"\0A\00"
@29 = constant [2 x i8] c"\0A\00"
@30 = constant [13 x i8] c"helloWorld1\0A\00"
@31 = constant [13 x i8] c"helloWorld1\0A\00"
@32 = constant [13 x i8] c"helloWorld2\0A\00"
@33 = constant [13 x i8] c"helloWorld2\0A\00"
@34 = constant [13 x i8] c"helloWorld3\0A\00"
@35 = constant [13 x i8] c"helloWorld3\0A\00"
@36 = constant [13 x i8] c"helloWorld4\0A\00"
@37 = constant [13 x i8] c"helloWorld4\0A\00"
@38 = constant [13 x i8] c"helloWorld5\0A\00"
@39 = constant [13 x i8] c"helloWorld5\0A\00"
@40 = constant [2 x i8] c"\0A\00"
@41 = constant [2 x i8] c"\0A\00"
@42 = constant [2 x i8] c"\0A\00"
@43 = constant [2 x i8] c"\0A\00"
@44 = constant [2 x i8] c"\0A\00"
@45 = constant [2 x i8] c"\0A\00"
@46 = constant [2 x i8] c"\0A\00"
@47 = constant [2 x i8] c"\0A\00"
@48 = constant [2 x i8] c"\0A\00"
@49 = constant [2 x i8] c"\0A\00"

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
  %27 = call i8* @getLine_clone(i32 %21, i8* %26, i32 1024)
  %28 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 0
  %29 = load i8*, i8** %28, align 16
  %30 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %31 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %32 = getelementptr [13 x i8], [13 x i8]* @2, i64 0, i64 0
  %33 = call i64 @strlen(i8* %32) #5
  %34 = add i64 12, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %29, i8* %30, i64 13, i32 1, i1 false)
  %35 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %36 = call i8* @getLine_clone.3(i32 %21, i8* %35, i32 1024)
  %37 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 1
  %38 = load i8*, i8** %37, align 8
  %39 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %40 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %41 = getelementptr [13 x i8], [13 x i8]* @5, i64 0, i64 0
  %42 = call i64 @strlen(i8* %41) #5
  %43 = add i64 12, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %38, i8* %39, i64 13, i32 1, i1 false)
  %44 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %45 = call i8* @getLine_clone.5(i32 %21, i8* %44, i32 1024)
  %46 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 2
  %47 = load i8*, i8** %46, align 16
  %48 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %49 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %50 = getelementptr [13 x i8], [13 x i8]* @8, i64 0, i64 0
  %51 = call i64 @strlen(i8* %50) #5
  %52 = add i64 12, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %47, i8* %48, i64 13, i32 1, i1 false)
  %53 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %54 = call i8* @getLine_clone.7(i32 %21, i8* %53, i32 1024)
  %55 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 3
  %56 = load i8*, i8** %55, align 8
  %57 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %58 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %59 = getelementptr [13 x i8], [13 x i8]* @11, i64 0, i64 0
  %60 = call i64 @strlen(i8* %59) #5
  %61 = add i64 12, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %56, i8* %57, i64 13, i32 1, i1 false)
  %62 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %63 = call i8* @getLine_clone.9(i32 %21, i8* %62, i32 1024)
  %64 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 4
  %65 = load i8*, i8** %64, align 16
  %66 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %67 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %68 = getelementptr [13 x i8], [13 x i8]* @14, i64 0, i64 0
  %69 = call i64 @strlen(i8* %68) #5
  %70 = add i64 12, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %65, i8* %66, i64 13, i32 1, i1 false)
  %71 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %72 = call i8* @getLine_clone.11(i32 %21, i8* %71, i32 1024)
  %73 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 5
  %74 = load i8*, i8** %73, align 8
  %75 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %76 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %77 = getelementptr [2 x i8], [2 x i8]* @17, i64 0, i64 0
  %78 = call i64 @strlen(i8* %77) #5
  %79 = add i64 1, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %74, i8* %75, i64 2, i32 1, i1 false)
  %80 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %81 = call i8* @getLine_clone.13(i32 %21, i8* %80, i32 1024)
  %82 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 6
  %83 = load i8*, i8** %82, align 16
  %84 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %85 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %86 = getelementptr [2 x i8], [2 x i8]* @20, i64 0, i64 0
  %87 = call i64 @strlen(i8* %86) #5
  %88 = add i64 1, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %83, i8* %84, i64 2, i32 1, i1 false)
  %89 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %90 = call i8* @getLine_clone.15(i32 %21, i8* %89, i32 1024)
  %91 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 7
  %92 = load i8*, i8** %91, align 8
  %93 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %94 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %95 = getelementptr [2 x i8], [2 x i8]* @23, i64 0, i64 0
  %96 = call i64 @strlen(i8* %95) #5
  %97 = add i64 1, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %92, i8* %93, i64 2, i32 1, i1 false)
  %98 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %99 = call i8* @getLine_clone.17(i32 %21, i8* %98, i32 1024)
  %100 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 8
  %101 = load i8*, i8** %100, align 16
  %102 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %103 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %104 = getelementptr [2 x i8], [2 x i8]* @26, i64 0, i64 0
  %105 = call i64 @strlen(i8* %104) #5
  %106 = add i64 1, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %101, i8* %102, i64 2, i32 1, i1 false)
  %107 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %108 = call i8* @getLine_clone.19(i32 %21, i8* %107, i32 1024)
  %109 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 9
  %110 = load i8*, i8** %109, align 8
  %111 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %112 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %113 = getelementptr [2 x i8], [2 x i8]* @29, i64 0, i64 0
  %114 = call i64 @strlen(i8* %113) #5
  %115 = add i64 1, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %110, i8* %111, i64 2, i32 1, i1 false)
  %116 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i32 0, i32 0
  %117 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %118 = call i8* @getLine_clone.21(i32 %21, i8* %117, i32 1024)
  call void @branchPruned_clone(i8** %116, i8* null)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

declare i32 @open(i8*, i32, ...) #2

; Function Attrs: nounwind readonly
declare i64 @strlen(i8*) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #4

; Function Attrs: nounwind uwtable
define i8* @getLine_clone(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = call i64 @lseek(i32 %fd, i64 0, i32 1) #6
  %2 = trunc i64 0 to i32
  %3 = sext i32 1024 to i64
  %4 = call i64 @read(i32 %fd, i8* %line, i64 1024)
  %5 = trunc i64 65 to i32
  %6 = icmp sle i32 65, 0
  br i1 false, label %23, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr [66 x i8], [66 x i8]* @0, i64 0, i64 0
  %9 = getelementptr [2 x i8], [2 x i8]* @1, i64 0, i64 0
  %10 = call i64 @strcspn(i8* %8, i8* %9) #5
  %11 = trunc i64 11 to i32
  %12 = icmp slt i32 11, 1024
  br i1 true, label %13, label %17

; <label>:13                                      ; preds = %7
  %14 = add nsw i32 11, 1
  %15 = sext i32 12 to i64
  %16 = getelementptr inbounds i8, i8* %line, i64 12
  store i8 0, i8* %16, align 1
  br label %17

; <label>:17                                      ; preds = %13, %7
  %18 = add nsw i32 0, 11
  %19 = add nsw i32 11, 1
  %20 = sext i32 12 to i64
  %21 = call i64 @lseek(i32 %fd, i64 12, i32 0) #6
  %22 = trunc i64 12 to i32
  br label %23

; <label>:23                                      ; preds = %17, %0
  %.0 = phi i8* [ %line, %17 ], [ null, %0 ]
  ret i8* %.0
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.3(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = call i64 @lseek(i32 %fd, i64 0, i32 1) #6
  %2 = trunc i64 12 to i32
  %3 = sext i32 1024 to i64
  %4 = call i64 @read(i32 %fd, i8* %line, i64 1024)
  %5 = trunc i64 53 to i32
  %6 = icmp sle i32 53, 0
  br i1 false, label %23, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr [66 x i8], [66 x i8]* @3, i64 0, i64 0
  %9 = getelementptr [2 x i8], [2 x i8]* @4, i64 0, i64 0
  %10 = call i64 @strcspn(i8* %8, i8* %9) #5
  %11 = trunc i64 11 to i32
  %12 = icmp slt i32 11, 1024
  br i1 true, label %13, label %17

; <label>:13                                      ; preds = %7
  %14 = add nsw i32 11, 1
  %15 = sext i32 12 to i64
  %16 = getelementptr inbounds i8, i8* %line, i64 12
  store i8 0, i8* %16, align 1
  br label %17

; <label>:17                                      ; preds = %13, %7
  %18 = add nsw i32 12, 11
  %19 = add nsw i32 23, 1
  %20 = sext i32 24 to i64
  %21 = call i64 @lseek(i32 %fd, i64 24, i32 0) #6
  %22 = trunc i64 24 to i32
  br label %23

; <label>:23                                      ; preds = %17, %0
  %.0 = phi i8* [ %line, %17 ], [ null, %0 ]
  ret i8* %.0
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.5(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = call i64 @lseek(i32 %fd, i64 0, i32 1) #6
  %2 = trunc i64 24 to i32
  %3 = sext i32 1024 to i64
  %4 = call i64 @read(i32 %fd, i8* %line, i64 1024)
  %5 = trunc i64 41 to i32
  %6 = icmp sle i32 41, 0
  br i1 false, label %23, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr [66 x i8], [66 x i8]* @6, i64 0, i64 0
  %9 = getelementptr [2 x i8], [2 x i8]* @7, i64 0, i64 0
  %10 = call i64 @strcspn(i8* %8, i8* %9) #5
  %11 = trunc i64 11 to i32
  %12 = icmp slt i32 11, 1024
  br i1 true, label %13, label %17

; <label>:13                                      ; preds = %7
  %14 = add nsw i32 11, 1
  %15 = sext i32 12 to i64
  %16 = getelementptr inbounds i8, i8* %line, i64 12
  store i8 0, i8* %16, align 1
  br label %17

; <label>:17                                      ; preds = %13, %7
  %18 = add nsw i32 24, 11
  %19 = add nsw i32 35, 1
  %20 = sext i32 36 to i64
  %21 = call i64 @lseek(i32 %fd, i64 36, i32 0) #6
  %22 = trunc i64 36 to i32
  br label %23

; <label>:23                                      ; preds = %17, %0
  %.0 = phi i8* [ %line, %17 ], [ null, %0 ]
  ret i8* %.0
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.7(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = call i64 @lseek(i32 %fd, i64 0, i32 1) #6
  %2 = trunc i64 36 to i32
  %3 = sext i32 1024 to i64
  %4 = call i64 @read(i32 %fd, i8* %line, i64 1024)
  %5 = trunc i64 29 to i32
  %6 = icmp sle i32 29, 0
  br i1 false, label %23, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr [66 x i8], [66 x i8]* @9, i64 0, i64 0
  %9 = getelementptr [2 x i8], [2 x i8]* @10, i64 0, i64 0
  %10 = call i64 @strcspn(i8* %8, i8* %9) #5
  %11 = trunc i64 11 to i32
  %12 = icmp slt i32 11, 1024
  br i1 true, label %13, label %17

; <label>:13                                      ; preds = %7
  %14 = add nsw i32 11, 1
  %15 = sext i32 12 to i64
  %16 = getelementptr inbounds i8, i8* %line, i64 12
  store i8 0, i8* %16, align 1
  br label %17

; <label>:17                                      ; preds = %13, %7
  %18 = add nsw i32 36, 11
  %19 = add nsw i32 47, 1
  %20 = sext i32 48 to i64
  %21 = call i64 @lseek(i32 %fd, i64 48, i32 0) #6
  %22 = trunc i64 48 to i32
  br label %23

; <label>:23                                      ; preds = %17, %0
  %.0 = phi i8* [ %line, %17 ], [ null, %0 ]
  ret i8* %.0
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.9(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = call i64 @lseek(i32 %fd, i64 0, i32 1) #6
  %2 = trunc i64 48 to i32
  %3 = sext i32 1024 to i64
  %4 = call i64 @read(i32 %fd, i8* %line, i64 1024)
  %5 = trunc i64 17 to i32
  %6 = icmp sle i32 17, 0
  br i1 false, label %23, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr [66 x i8], [66 x i8]* @12, i64 0, i64 0
  %9 = getelementptr [2 x i8], [2 x i8]* @13, i64 0, i64 0
  %10 = call i64 @strcspn(i8* %8, i8* %9) #5
  %11 = trunc i64 11 to i32
  %12 = icmp slt i32 11, 1024
  br i1 true, label %13, label %17

; <label>:13                                      ; preds = %7
  %14 = add nsw i32 11, 1
  %15 = sext i32 12 to i64
  %16 = getelementptr inbounds i8, i8* %line, i64 12
  store i8 0, i8* %16, align 1
  br label %17

; <label>:17                                      ; preds = %13, %7
  %18 = add nsw i32 48, 11
  %19 = add nsw i32 59, 1
  %20 = sext i32 60 to i64
  %21 = call i64 @lseek(i32 %fd, i64 60, i32 0) #6
  %22 = trunc i64 60 to i32
  br label %23

; <label>:23                                      ; preds = %17, %0
  %.0 = phi i8* [ %line, %17 ], [ null, %0 ]
  ret i8* %.0
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.11(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = call i64 @lseek(i32 %fd, i64 0, i32 1) #6
  %2 = trunc i64 60 to i32
  %3 = sext i32 1024 to i64
  %4 = call i64 @read(i32 %fd, i8* %line, i64 1024)
  %5 = trunc i64 5 to i32
  %6 = icmp sle i32 5, 0
  br i1 false, label %23, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr [13 x i8], [13 x i8]* @15, i64 0, i64 0
  %9 = getelementptr [2 x i8], [2 x i8]* @16, i64 0, i64 0
  %10 = call i64 @strcspn(i8* %8, i8* %9) #5
  %11 = trunc i64 0 to i32
  %12 = icmp slt i32 0, 1024
  br i1 true, label %13, label %17

; <label>:13                                      ; preds = %7
  %14 = add nsw i32 0, 1
  %15 = sext i32 1 to i64
  %16 = getelementptr inbounds i8, i8* %line, i64 1
  store i8 0, i8* %16, align 1
  br label %17

; <label>:17                                      ; preds = %13, %7
  %18 = add nsw i32 60, 0
  %19 = add nsw i32 60, 1
  %20 = sext i32 61 to i64
  %21 = call i64 @lseek(i32 %fd, i64 61, i32 0) #6
  %22 = trunc i64 61 to i32
  br label %23

; <label>:23                                      ; preds = %17, %0
  %.0 = phi i8* [ %line, %17 ], [ null, %0 ]
  ret i8* %.0
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.13(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = call i64 @lseek(i32 %fd, i64 0, i32 1) #6
  %2 = trunc i64 61 to i32
  %3 = sext i32 1024 to i64
  %4 = call i64 @read(i32 %fd, i8* %line, i64 1024)
  %5 = trunc i64 4 to i32
  %6 = icmp sle i32 4, 0
  br i1 false, label %23, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr [13 x i8], [13 x i8]* @18, i64 0, i64 0
  %9 = getelementptr [2 x i8], [2 x i8]* @19, i64 0, i64 0
  %10 = call i64 @strcspn(i8* %8, i8* %9) #5
  %11 = trunc i64 0 to i32
  %12 = icmp slt i32 0, 1024
  br i1 true, label %13, label %17

; <label>:13                                      ; preds = %7
  %14 = add nsw i32 0, 1
  %15 = sext i32 1 to i64
  %16 = getelementptr inbounds i8, i8* %line, i64 1
  store i8 0, i8* %16, align 1
  br label %17

; <label>:17                                      ; preds = %13, %7
  %18 = add nsw i32 61, 0
  %19 = add nsw i32 61, 1
  %20 = sext i32 62 to i64
  %21 = call i64 @lseek(i32 %fd, i64 62, i32 0) #6
  %22 = trunc i64 62 to i32
  br label %23

; <label>:23                                      ; preds = %17, %0
  %.0 = phi i8* [ %line, %17 ], [ null, %0 ]
  ret i8* %.0
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.15(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = call i64 @lseek(i32 %fd, i64 0, i32 1) #6
  %2 = trunc i64 62 to i32
  %3 = sext i32 1024 to i64
  %4 = call i64 @read(i32 %fd, i8* %line, i64 1024)
  %5 = trunc i64 3 to i32
  %6 = icmp sle i32 3, 0
  br i1 false, label %23, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr [13 x i8], [13 x i8]* @21, i64 0, i64 0
  %9 = getelementptr [2 x i8], [2 x i8]* @22, i64 0, i64 0
  %10 = call i64 @strcspn(i8* %8, i8* %9) #5
  %11 = trunc i64 0 to i32
  %12 = icmp slt i32 0, 1024
  br i1 true, label %13, label %17

; <label>:13                                      ; preds = %7
  %14 = add nsw i32 0, 1
  %15 = sext i32 1 to i64
  %16 = getelementptr inbounds i8, i8* %line, i64 1
  store i8 0, i8* %16, align 1
  br label %17

; <label>:17                                      ; preds = %13, %7
  %18 = add nsw i32 62, 0
  %19 = add nsw i32 62, 1
  %20 = sext i32 63 to i64
  %21 = call i64 @lseek(i32 %fd, i64 63, i32 0) #6
  %22 = trunc i64 63 to i32
  br label %23

; <label>:23                                      ; preds = %17, %0
  %.0 = phi i8* [ %line, %17 ], [ null, %0 ]
  ret i8* %.0
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.17(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = call i64 @lseek(i32 %fd, i64 0, i32 1) #6
  %2 = trunc i64 63 to i32
  %3 = sext i32 1024 to i64
  %4 = call i64 @read(i32 %fd, i8* %line, i64 1024)
  %5 = trunc i64 2 to i32
  %6 = icmp sle i32 2, 0
  br i1 false, label %23, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr [13 x i8], [13 x i8]* @24, i64 0, i64 0
  %9 = getelementptr [2 x i8], [2 x i8]* @25, i64 0, i64 0
  %10 = call i64 @strcspn(i8* %8, i8* %9) #5
  %11 = trunc i64 0 to i32
  %12 = icmp slt i32 0, 1024
  br i1 true, label %13, label %17

; <label>:13                                      ; preds = %7
  %14 = add nsw i32 0, 1
  %15 = sext i32 1 to i64
  %16 = getelementptr inbounds i8, i8* %line, i64 1
  store i8 0, i8* %16, align 1
  br label %17

; <label>:17                                      ; preds = %13, %7
  %18 = add nsw i32 63, 0
  %19 = add nsw i32 63, 1
  %20 = sext i32 64 to i64
  %21 = call i64 @lseek(i32 %fd, i64 64, i32 0) #6
  %22 = trunc i64 64 to i32
  br label %23

; <label>:23                                      ; preds = %17, %0
  %.0 = phi i8* [ %line, %17 ], [ null, %0 ]
  ret i8* %.0
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.19(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = call i64 @lseek(i32 %fd, i64 0, i32 1) #6
  %2 = trunc i64 64 to i32
  %3 = sext i32 1024 to i64
  %4 = call i64 @read(i32 %fd, i8* %line, i64 1024)
  %5 = trunc i64 1 to i32
  %6 = icmp sle i32 1, 0
  br i1 false, label %23, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr [2 x i8], [2 x i8]* @27, i64 0, i64 0
  %9 = getelementptr [2 x i8], [2 x i8]* @28, i64 0, i64 0
  %10 = call i64 @strcspn(i8* %8, i8* %9) #5
  %11 = trunc i64 0 to i32
  %12 = icmp slt i32 0, 1024
  br i1 true, label %13, label %17

; <label>:13                                      ; preds = %7
  %14 = add nsw i32 0, 1
  %15 = sext i32 1 to i64
  %16 = getelementptr inbounds i8, i8* %line, i64 1
  store i8 0, i8* %16, align 1
  br label %17

; <label>:17                                      ; preds = %13, %7
  %18 = add nsw i32 64, 0
  %19 = add nsw i32 64, 1
  %20 = sext i32 65 to i64
  %21 = call i64 @lseek(i32 %fd, i64 65, i32 0) #6
  %22 = trunc i64 65 to i32
  br label %23

; <label>:23                                      ; preds = %17, %0
  %.0 = phi i8* [ %line, %17 ], [ null, %0 ]
  ret i8* %.0
}

; Function Attrs: nounwind uwtable
define i8* @getLine_clone.21(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = call i64 @lseek(i32 %fd, i64 0, i32 1) #6
  %2 = trunc i64 65 to i32
  %3 = sext i32 1024 to i64
  %4 = call i64 @read(i32 %fd, i8* %line, i64 1024)
  %5 = trunc i64 0 to i32
  %6 = icmp sle i32 0, 0
  br i1 true, label %21, label %7

; <label>:7                                       ; preds = %0
  %8 = call i64 @strcspn(i8* %line, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %9 = trunc i64 %8 to i32
  %10 = icmp slt i32 %9, 1024
  br i1 %10, label %11, label %15

; <label>:11                                      ; preds = %7
  %12 = add nsw i32 %9, 1
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds i8, i8* %line, i64 %13
  store i8 0, i8* %14, align 1
  br label %15

; <label>:15                                      ; preds = %11, %7
  %16 = add nsw i32 65, %9
  %17 = add nsw i32 %16, 1
  %18 = sext i32 %17 to i64
  %19 = call i64 @lseek(i32 %fd, i64 %18, i32 0) #6
  %20 = trunc i64 %19 to i32
  br label %21

; <label>:21                                      ; preds = %15, %0
  %.0 = phi i8* [ %line, %15 ], [ null, %0 ]
  ret i8* null
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(i8** %buffer, i8* %line) #0 {
  %1 = getelementptr inbounds i8*, i8** %buffer, i64 0
  %2 = load i8*, i8** %1, align 8
  %3 = getelementptr [13 x i8], [13 x i8]* @30, i64 0, i64 0
  %4 = getelementptr [13 x i8], [13 x i8]* @31, i64 0, i64 0
  %5 = call i32 @strcmp(i8* %3, i8* %4) #5
  %6 = icmp ne i32 0, 0
  br i1 false, label %74, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds i8*, i8** %buffer, i64 1
  %9 = load i8*, i8** %8, align 8
  %10 = getelementptr [13 x i8], [13 x i8]* @32, i64 0, i64 0
  %11 = getelementptr [13 x i8], [13 x i8]* @33, i64 0, i64 0
  %12 = call i32 @strcmp(i8* %10, i8* %11) #5
  %13 = icmp ne i32 0, 0
  br i1 false, label %74, label %14

; <label>:14                                      ; preds = %7
  %15 = getelementptr inbounds i8*, i8** %buffer, i64 2
  %16 = load i8*, i8** %15, align 8
  %17 = getelementptr [13 x i8], [13 x i8]* @34, i64 0, i64 0
  %18 = getelementptr [13 x i8], [13 x i8]* @35, i64 0, i64 0
  %19 = call i32 @strcmp(i8* %17, i8* %18) #5
  %20 = icmp ne i32 0, 0
  br i1 false, label %74, label %21

; <label>:21                                      ; preds = %14
  %22 = getelementptr inbounds i8*, i8** %buffer, i64 3
  %23 = load i8*, i8** %22, align 8
  %24 = getelementptr [13 x i8], [13 x i8]* @36, i64 0, i64 0
  %25 = getelementptr [13 x i8], [13 x i8]* @37, i64 0, i64 0
  %26 = call i32 @strcmp(i8* %24, i8* %25) #5
  %27 = icmp ne i32 0, 0
  br i1 false, label %74, label %28

; <label>:28                                      ; preds = %21
  %29 = getelementptr inbounds i8*, i8** %buffer, i64 4
  %30 = load i8*, i8** %29, align 8
  %31 = getelementptr [13 x i8], [13 x i8]* @38, i64 0, i64 0
  %32 = getelementptr [13 x i8], [13 x i8]* @39, i64 0, i64 0
  %33 = call i32 @strcmp(i8* %31, i8* %32) #5
  %34 = icmp ne i32 0, 0
  br i1 false, label %74, label %35

; <label>:35                                      ; preds = %28
  %36 = getelementptr inbounds i8*, i8** %buffer, i64 5
  %37 = load i8*, i8** %36, align 8
  %38 = getelementptr [2 x i8], [2 x i8]* @40, i64 0, i64 0
  %39 = getelementptr [2 x i8], [2 x i8]* @41, i64 0, i64 0
  %40 = call i32 @strcmp(i8* %38, i8* %39) #5
  %41 = icmp ne i32 0, 0
  br i1 false, label %74, label %42

; <label>:42                                      ; preds = %35
  %43 = getelementptr inbounds i8*, i8** %buffer, i64 6
  %44 = load i8*, i8** %43, align 8
  %45 = getelementptr [2 x i8], [2 x i8]* @42, i64 0, i64 0
  %46 = getelementptr [2 x i8], [2 x i8]* @43, i64 0, i64 0
  %47 = call i32 @strcmp(i8* %45, i8* %46) #5
  %48 = icmp ne i32 0, 0
  br i1 false, label %74, label %49

; <label>:49                                      ; preds = %42
  %50 = getelementptr inbounds i8*, i8** %buffer, i64 7
  %51 = load i8*, i8** %50, align 8
  %52 = getelementptr [2 x i8], [2 x i8]* @44, i64 0, i64 0
  %53 = getelementptr [2 x i8], [2 x i8]* @45, i64 0, i64 0
  %54 = call i32 @strcmp(i8* %52, i8* %53) #5
  %55 = icmp ne i32 0, 0
  br i1 false, label %74, label %56

; <label>:56                                      ; preds = %49
  %57 = getelementptr inbounds i8*, i8** %buffer, i64 8
  %58 = load i8*, i8** %57, align 8
  %59 = getelementptr [2 x i8], [2 x i8]* @46, i64 0, i64 0
  %60 = getelementptr [2 x i8], [2 x i8]* @47, i64 0, i64 0
  %61 = call i32 @strcmp(i8* %59, i8* %60) #5
  %62 = icmp ne i32 0, 0
  br i1 false, label %74, label %63

; <label>:63                                      ; preds = %56
  %64 = getelementptr inbounds i8*, i8** %buffer, i64 9
  %65 = load i8*, i8** %64, align 8
  %66 = getelementptr [2 x i8], [2 x i8]* @48, i64 0, i64 0
  %67 = getelementptr [2 x i8], [2 x i8]* @49, i64 0, i64 0
  %68 = call i32 @strcmp(i8* %66, i8* %67) #5
  %69 = icmp ne i32 0, 0
  %70 = icmp ne i1 false, false
  %71 = icmp ne i8* null, null
  %or.cond = or i1 false, false
  br i1 false, label %74, label %72

; <label>:72                                      ; preds = %63
  %73 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.6, i32 0, i32 0))
  br label %74

; <label>:74                                      ; preds = %72, %63, %56, %49, %42, %35, %28, %21, %14, %7, %0
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
