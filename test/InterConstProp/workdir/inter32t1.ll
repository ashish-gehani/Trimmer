; ModuleID = 'workdir/inter32t1.bc'
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
  %1 = alloca i8**, align 8
  %2 = alloca i8*, align 8
  store i8** %buffer, i8*** %1, align 8
  store i8* %line, i8** %2, align 8
  %3 = load i8**, i8*** %1, align 8
  %4 = getelementptr inbounds i8*, i8** %3, i64 0
  %5 = load i8*, i8** %4, align 8
  %6 = call i32 @strcmp(i8* %5, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i32 0, i32 0)) #5
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %67, label %8

; <label>:8                                       ; preds = %0
  %9 = load i8**, i8*** %1, align 8
  %10 = getelementptr inbounds i8*, i8** %9, i64 1
  %11 = load i8*, i8** %10, align 8
  %12 = call i32 @strcmp(i8* %11, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i32 0, i32 0)) #5
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %67, label %14

; <label>:14                                      ; preds = %8
  %15 = load i8**, i8*** %1, align 8
  %16 = getelementptr inbounds i8*, i8** %15, i64 2
  %17 = load i8*, i8** %16, align 8
  %18 = call i32 @strcmp(i8* %17, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.2, i32 0, i32 0)) #5
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %67, label %20

; <label>:20                                      ; preds = %14
  %21 = load i8**, i8*** %1, align 8
  %22 = getelementptr inbounds i8*, i8** %21, i64 3
  %23 = load i8*, i8** %22, align 8
  %24 = call i32 @strcmp(i8* %23, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.3, i32 0, i32 0)) #5
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %67, label %26

; <label>:26                                      ; preds = %20
  %27 = load i8**, i8*** %1, align 8
  %28 = getelementptr inbounds i8*, i8** %27, i64 4
  %29 = load i8*, i8** %28, align 8
  %30 = call i32 @strcmp(i8* %29, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i32 0, i32 0)) #5
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %67, label %32

; <label>:32                                      ; preds = %26
  %33 = load i8**, i8*** %1, align 8
  %34 = getelementptr inbounds i8*, i8** %33, i64 5
  %35 = load i8*, i8** %34, align 8
  %36 = call i32 @strcmp(i8* %35, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %67, label %38

; <label>:38                                      ; preds = %32
  %39 = load i8**, i8*** %1, align 8
  %40 = getelementptr inbounds i8*, i8** %39, i64 6
  %41 = load i8*, i8** %40, align 8
  %42 = call i32 @strcmp(i8* %41, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %43 = icmp ne i32 %42, 0
  br i1 %43, label %67, label %44

; <label>:44                                      ; preds = %38
  %45 = load i8**, i8*** %1, align 8
  %46 = getelementptr inbounds i8*, i8** %45, i64 7
  %47 = load i8*, i8** %46, align 8
  %48 = call i32 @strcmp(i8* %47, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %49 = icmp ne i32 %48, 0
  br i1 %49, label %67, label %50

; <label>:50                                      ; preds = %44
  %51 = load i8**, i8*** %1, align 8
  %52 = getelementptr inbounds i8*, i8** %51, i64 8
  %53 = load i8*, i8** %52, align 8
  %54 = call i32 @strcmp(i8* %53, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %55 = icmp ne i32 %54, 0
  br i1 %55, label %67, label %56

; <label>:56                                      ; preds = %50
  %57 = load i8**, i8*** %1, align 8
  %58 = getelementptr inbounds i8*, i8** %57, i64 9
  %59 = load i8*, i8** %58, align 8
  %60 = call i32 @strcmp(i8* %59, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %61 = icmp ne i32 %60, 0
  br i1 %61, label %67, label %62

; <label>:62                                      ; preds = %56
  %63 = load i8*, i8** %2, align 8
  %64 = icmp ne i8* %63, null
  br i1 %64, label %67, label %65

; <label>:65                                      ; preds = %62
  %66 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.6, i32 0, i32 0))
  br label %67

; <label>:67                                      ; preds = %65, %62, %56, %50, %44, %38, %32, %26, %20, %14, %8, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define i8* @getLine(i32 %fd, i8* %line, i32 %size) #0 {
  %1 = alloca i8*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  %offset = alloca i32, align 4
  %bytes_read = alloca i32, align 4
  %idx = alloca i32, align 4
  store i32 %fd, i32* %2, align 4
  store i8* %line, i8** %3, align 8
  store i32 %size, i32* %4, align 4
  %5 = load i32, i32* %2, align 4
  %6 = call i64 @lseek(i32 %5, i64 0, i32 1) #6
  %7 = trunc i64 %6 to i32
  store i32 %7, i32* %offset, align 4
  %8 = load i32, i32* %2, align 4
  %9 = load i8*, i8** %3, align 8
  %10 = load i32, i32* %4, align 4
  %11 = sext i32 %10 to i64
  %12 = call i64 @read(i32 %8, i8* %9, i64 %11)
  %13 = trunc i64 %12 to i32
  store i32 %13, i32* %bytes_read, align 4
  %14 = load i32, i32* %bytes_read, align 4
  %15 = icmp sle i32 %14, 0
  br i1 %15, label %16, label %17

; <label>:16                                      ; preds = %0
  store i8* null, i8** %1, align 8
  br label %40

; <label>:17                                      ; preds = %0
  %18 = load i8*, i8** %3, align 8
  %19 = call i64 @strcspn(i8* %18, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0)) #5
  %20 = trunc i64 %19 to i32
  store i32 %20, i32* %idx, align 4
  %21 = load i32, i32* %idx, align 4
  %22 = load i32, i32* %4, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %30

; <label>:24                                      ; preds = %17
  %25 = load i32, i32* %idx, align 4
  %26 = add nsw i32 %25, 1
  %27 = sext i32 %26 to i64
  %28 = load i8*, i8** %3, align 8
  %29 = getelementptr inbounds i8, i8* %28, i64 %27
  store i8 0, i8* %29, align 1
  br label %30

; <label>:30                                      ; preds = %24, %17
  %31 = load i32, i32* %2, align 4
  %32 = load i32, i32* %offset, align 4
  %33 = load i32, i32* %idx, align 4
  %34 = add nsw i32 %32, %33
  %35 = add nsw i32 %34, 1
  %36 = sext i32 %35 to i64
  %37 = call i64 @lseek(i32 %31, i64 %36, i32 0) #6
  %38 = trunc i64 %37 to i32
  store i32 %38, i32* %offset, align 4
  %39 = load i8*, i8** %3, align 8
  store i8* %39, i8** %1, align 8
  br label %40

; <label>:40                                      ; preds = %30, %16
  %41 = load i8*, i8** %1, align 8
  ret i8* %41
}

; Function Attrs: nounwind
declare i64 @lseek(i32, i64, i32) #3

declare i64 @read(i32, i8*, i64) #2

; Function Attrs: nounwind readonly
declare i64 @strcspn(i8*, i8*) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %buffer = alloca [10 x i8*], align 16
  %line = alloca [1024 x i8], align 16
  %fd = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = call noalias i8* @malloc(i64 100) #6
  %5 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 0
  store i8* %4, i8** %5, align 16
  %6 = call noalias i8* @malloc(i64 100) #6
  %7 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 1
  store i8* %6, i8** %7, align 8
  %8 = call noalias i8* @malloc(i64 100) #6
  %9 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 2
  store i8* %8, i8** %9, align 16
  %10 = call noalias i8* @malloc(i64 100) #6
  %11 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 3
  store i8* %10, i8** %11, align 8
  %12 = call noalias i8* @malloc(i64 100) #6
  %13 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 4
  store i8* %12, i8** %13, align 16
  %14 = call noalias i8* @malloc(i64 100) #6
  %15 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 5
  store i8* %14, i8** %15, align 8
  %16 = call noalias i8* @malloc(i64 100) #6
  %17 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 6
  store i8* %16, i8** %17, align 16
  %18 = call noalias i8* @malloc(i64 100) #6
  %19 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 7
  store i8* %18, i8** %19, align 8
  %20 = call noalias i8* @malloc(i64 100) #6
  %21 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 8
  store i8* %20, i8** %21, align 16
  %22 = call noalias i8* @malloc(i64 100) #6
  %23 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 9
  store i8* %22, i8** %23, align 8
  %24 = call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.7, i32 0, i32 0), i32 0)
  store i32 %24, i32* %fd, align 4
  %25 = load i32, i32* %fd, align 4
  %26 = icmp slt i32 %25, 0
  br i1 %26, label %27, label %29

; <label>:27                                      ; preds = %0
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.8, i32 0, i32 0))
  br label %29

; <label>:29                                      ; preds = %27, %0
  %30 = load i32, i32* %fd, align 4
  %31 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %32 = call i8* @getLine(i32 %30, i8* %31, i32 1024)
  %33 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 0
  %34 = load i8*, i8** %33, align 16
  %35 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %36 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %37 = call i64 @strlen(i8* %36) #5
  %38 = add i64 %37, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %34, i8* %35, i64 %38, i32 1, i1 false)
  %39 = load i32, i32* %fd, align 4
  %40 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %41 = call i8* @getLine(i32 %39, i8* %40, i32 1024)
  %42 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 1
  %43 = load i8*, i8** %42, align 8
  %44 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %45 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %46 = call i64 @strlen(i8* %45) #5
  %47 = add i64 %46, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %43, i8* %44, i64 %47, i32 1, i1 false)
  %48 = load i32, i32* %fd, align 4
  %49 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %50 = call i8* @getLine(i32 %48, i8* %49, i32 1024)
  %51 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 2
  %52 = load i8*, i8** %51, align 16
  %53 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %54 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %55 = call i64 @strlen(i8* %54) #5
  %56 = add i64 %55, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %52, i8* %53, i64 %56, i32 1, i1 false)
  %57 = load i32, i32* %fd, align 4
  %58 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %59 = call i8* @getLine(i32 %57, i8* %58, i32 1024)
  %60 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 3
  %61 = load i8*, i8** %60, align 8
  %62 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %63 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %64 = call i64 @strlen(i8* %63) #5
  %65 = add i64 %64, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %61, i8* %62, i64 %65, i32 1, i1 false)
  %66 = load i32, i32* %fd, align 4
  %67 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %68 = call i8* @getLine(i32 %66, i8* %67, i32 1024)
  %69 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 4
  %70 = load i8*, i8** %69, align 16
  %71 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %72 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %73 = call i64 @strlen(i8* %72) #5
  %74 = add i64 %73, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %70, i8* %71, i64 %74, i32 1, i1 false)
  %75 = load i32, i32* %fd, align 4
  %76 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %77 = call i8* @getLine(i32 %75, i8* %76, i32 1024)
  %78 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 5
  %79 = load i8*, i8** %78, align 8
  %80 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %81 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %82 = call i64 @strlen(i8* %81) #5
  %83 = add i64 %82, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %79, i8* %80, i64 %83, i32 1, i1 false)
  %84 = load i32, i32* %fd, align 4
  %85 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %86 = call i8* @getLine(i32 %84, i8* %85, i32 1024)
  %87 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 6
  %88 = load i8*, i8** %87, align 16
  %89 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %90 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %91 = call i64 @strlen(i8* %90) #5
  %92 = add i64 %91, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %88, i8* %89, i64 %92, i32 1, i1 false)
  %93 = load i32, i32* %fd, align 4
  %94 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %95 = call i8* @getLine(i32 %93, i8* %94, i32 1024)
  %96 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 7
  %97 = load i8*, i8** %96, align 8
  %98 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %99 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %100 = call i64 @strlen(i8* %99) #5
  %101 = add i64 %100, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %97, i8* %98, i64 %101, i32 1, i1 false)
  %102 = load i32, i32* %fd, align 4
  %103 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %104 = call i8* @getLine(i32 %102, i8* %103, i32 1024)
  %105 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 8
  %106 = load i8*, i8** %105, align 16
  %107 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %108 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %109 = call i64 @strlen(i8* %108) #5
  %110 = add i64 %109, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %106, i8* %107, i64 %110, i32 1, i1 false)
  %111 = load i32, i32* %fd, align 4
  %112 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %113 = call i8* @getLine(i32 %111, i8* %112, i32 1024)
  %114 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i64 0, i64 9
  %115 = load i8*, i8** %114, align 8
  %116 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %117 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %118 = call i64 @strlen(i8* %117) #5
  %119 = add i64 %118, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %115, i8* %116, i64 %119, i32 1, i1 false)
  %120 = getelementptr inbounds [10 x i8*], [10 x i8*]* %buffer, i32 0, i32 0
  %121 = load i32, i32* %fd, align 4
  %122 = getelementptr inbounds [1024 x i8], [1024 x i8]* %line, i32 0, i32 0
  %123 = call i8* @getLine(i32 %121, i8* %122, i32 1024)
  call void @branchPruned(i8** %120, i8* %123)
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
