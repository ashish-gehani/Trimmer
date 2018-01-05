; ModuleID = 'workdir/inter23t2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@obj = common global %struct.stType** null, align 8
@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"*** Branch Taken \0A\00", align 1
@.str.2 = private unnamed_addr constant [23 x i8] c"*** Branch not Taken \0A\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@0 = constant [11 x i8] c"helloWorld\00"
@1 = constant [11 x i8] c"helloWorld\00"

; Function Attrs: nounwind uwtable
define void @branchPruned() #0 {
  %1 = load %struct.stType**, %struct.stType*** @obj, align 8
  %2 = getelementptr inbounds %struct.stType*, %struct.stType** %1, i64 0
  %3 = load %struct.stType*, %struct.stType** %2, align 8
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 0
  %5 = load %struct.COORD*, %struct.COORD** %4, align 8
  %6 = getelementptr inbounds %struct.COORD, %struct.COORD* %5, i32 0, i32 0
  %7 = load i32*, i32** %6, align 8
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 %8, 1
  br i1 %9, label %10, label %102

; <label>:10                                      ; preds = %0
  %11 = load %struct.stType**, %struct.stType*** @obj, align 8
  %12 = getelementptr inbounds %struct.stType*, %struct.stType** %11, i64 0
  %13 = load %struct.stType*, %struct.stType** %12, align 8
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %13, i32 0, i32 0
  %15 = load %struct.COORD*, %struct.COORD** %14, align 8
  %16 = getelementptr inbounds %struct.COORD, %struct.COORD* %15, i32 0, i32 1
  %17 = load i32*, i32** %16, align 8
  %18 = load i32, i32* %17, align 4
  %19 = icmp eq i32 %18, 2
  br i1 %19, label %20, label %102

; <label>:20                                      ; preds = %10
  %21 = load %struct.stType**, %struct.stType*** @obj, align 8
  %22 = getelementptr inbounds %struct.stType*, %struct.stType** %21, i64 0
  %23 = load %struct.stType*, %struct.stType** %22, align 8
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %23, i32 0, i32 1
  %25 = getelementptr inbounds [100 x i8], [100 x i8]* %24, i32 0, i32 0
  %26 = call i32 @strcmp(i8* %25, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %102, label %28

; <label>:28                                      ; preds = %20
  %29 = load %struct.stType**, %struct.stType*** @obj, align 8
  %30 = getelementptr inbounds %struct.stType*, %struct.stType** %29, i64 0
  %31 = load %struct.stType*, %struct.stType** %30, align 8
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %31, i32 0, i32 1
  %33 = getelementptr inbounds [100 x i8], [100 x i8]* %32, i64 0, i64 4
  %34 = load i8, i8* %33, align 4
  %35 = sext i8 %34 to i32
  %36 = icmp eq i32 %35, 111
  br i1 %36, label %37, label %102

; <label>:37                                      ; preds = %28
  %38 = load %struct.stType**, %struct.stType*** @obj, align 8
  %39 = getelementptr inbounds %struct.stType*, %struct.stType** %38, i64 0
  %40 = load %struct.stType*, %struct.stType** %39, align 8
  %41 = getelementptr inbounds %struct.stType, %struct.stType* %40, i32 0, i32 1
  %42 = getelementptr inbounds [100 x i8], [100 x i8]* %41, i64 0, i64 9
  %43 = load i8, i8* %42, align 1
  %44 = sext i8 %43 to i32
  %45 = icmp eq i32 %44, 100
  br i1 %45, label %46, label %102

; <label>:46                                      ; preds = %37
  %47 = load %struct.stType**, %struct.stType*** @obj, align 8
  %48 = getelementptr inbounds %struct.stType*, %struct.stType** %47, i64 2
  %49 = load %struct.stType*, %struct.stType** %48, align 8
  %50 = getelementptr inbounds %struct.stType, %struct.stType* %49, i32 0, i32 0
  %51 = load %struct.COORD*, %struct.COORD** %50, align 8
  %52 = getelementptr inbounds %struct.COORD, %struct.COORD* %51, i32 0, i32 0
  %53 = load i32*, i32** %52, align 8
  %54 = load i32, i32* %53, align 4
  %55 = icmp eq i32 %54, 11
  br i1 %55, label %56, label %102

; <label>:56                                      ; preds = %46
  %57 = load %struct.stType**, %struct.stType*** @obj, align 8
  %58 = getelementptr inbounds %struct.stType*, %struct.stType** %57, i64 2
  %59 = load %struct.stType*, %struct.stType** %58, align 8
  %60 = getelementptr inbounds %struct.stType, %struct.stType* %59, i32 0, i32 0
  %61 = load %struct.COORD*, %struct.COORD** %60, align 8
  %62 = getelementptr inbounds %struct.COORD, %struct.COORD* %61, i32 0, i32 1
  %63 = load i32*, i32** %62, align 8
  %64 = load i32, i32* %63, align 4
  %65 = icmp eq i32 %64, 12
  br i1 %65, label %66, label %102

; <label>:66                                      ; preds = %56
  %67 = load %struct.stType**, %struct.stType*** @obj, align 8
  %68 = getelementptr inbounds %struct.stType*, %struct.stType** %67, i64 2
  %69 = load %struct.stType*, %struct.stType** %68, align 8
  %70 = getelementptr inbounds %struct.stType, %struct.stType* %69, i32 0, i32 2
  %71 = getelementptr inbounds [8 x i32], [8 x i32]* %70, i64 0, i64 1
  %72 = load i32, i32* %71, align 4
  %73 = icmp eq i32 %72, 14
  br i1 %73, label %74, label %102

; <label>:74                                      ; preds = %66
  %75 = load %struct.stType**, %struct.stType*** @obj, align 8
  %76 = getelementptr inbounds %struct.stType*, %struct.stType** %75, i64 2
  %77 = load %struct.stType*, %struct.stType** %76, align 8
  %78 = getelementptr inbounds %struct.stType, %struct.stType* %77, i32 0, i32 1
  %79 = getelementptr inbounds [100 x i8], [100 x i8]* %78, i32 0, i32 0
  %80 = call i32 @strcmp(i8* %79, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %81 = icmp ne i32 %80, 0
  br i1 %81, label %102, label %82

; <label>:82                                      ; preds = %74
  %83 = load %struct.stType**, %struct.stType*** @obj, align 8
  %84 = getelementptr inbounds %struct.stType*, %struct.stType** %83, i64 2
  %85 = load %struct.stType*, %struct.stType** %84, align 8
  %86 = getelementptr inbounds %struct.stType, %struct.stType* %85, i32 0, i32 1
  %87 = getelementptr inbounds [100 x i8], [100 x i8]* %86, i64 0, i64 4
  %88 = load i8, i8* %87, align 4
  %89 = sext i8 %88 to i32
  %90 = icmp eq i32 %89, 111
  br i1 %90, label %91, label %102

; <label>:91                                      ; preds = %82
  %92 = load %struct.stType**, %struct.stType*** @obj, align 8
  %93 = getelementptr inbounds %struct.stType*, %struct.stType** %92, i64 2
  %94 = load %struct.stType*, %struct.stType** %93, align 8
  %95 = getelementptr inbounds %struct.stType, %struct.stType* %94, i32 0, i32 1
  %96 = getelementptr inbounds [100 x i8], [100 x i8]* %95, i64 0, i64 9
  %97 = load i8, i8* %96, align 1
  %98 = sext i8 %97 to i32
  %99 = icmp eq i32 %98, 100
  br i1 %99, label %100, label %102

; <label>:100                                     ; preds = %91
  %101 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %102

; <label>:102                                     ; preds = %100, %91, %82, %74, %66, %56, %46, %37, %28, %20, %10, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define void @branchNotPruned() #0 {
  %1 = load %struct.stType**, %struct.stType*** @obj, align 8
  %2 = getelementptr inbounds %struct.stType*, %struct.stType** %1, i64 0
  %3 = load %struct.stType*, %struct.stType** %2, align 8
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 2
  %5 = getelementptr inbounds [8 x i32], [8 x i32]* %4, i64 0, i64 1
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 4
  br i1 %7, label %8, label %64

; <label>:8                                       ; preds = %0
  %9 = load %struct.stType**, %struct.stType*** @obj, align 8
  %10 = getelementptr inbounds %struct.stType*, %struct.stType** %9, i64 3
  %11 = load %struct.stType*, %struct.stType** %10, align 8
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 0
  %13 = load %struct.COORD*, %struct.COORD** %12, align 8
  %14 = getelementptr inbounds %struct.COORD, %struct.COORD* %13, i32 0, i32 0
  %15 = load i32*, i32** %14, align 8
  %16 = load i32, i32* %15, align 4
  %17 = icmp eq i32 %16, 16
  br i1 %17, label %18, label %64

; <label>:18                                      ; preds = %8
  %19 = load %struct.stType**, %struct.stType*** @obj, align 8
  %20 = getelementptr inbounds %struct.stType*, %struct.stType** %19, i64 3
  %21 = load %struct.stType*, %struct.stType** %20, align 8
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %21, i32 0, i32 0
  %23 = load %struct.COORD*, %struct.COORD** %22, align 8
  %24 = getelementptr inbounds %struct.COORD, %struct.COORD* %23, i32 0, i32 1
  %25 = load i32*, i32** %24, align 8
  %26 = load i32, i32* %25, align 4
  %27 = icmp eq i32 %26, 17
  br i1 %27, label %28, label %64

; <label>:28                                      ; preds = %18
  %29 = load %struct.stType**, %struct.stType*** @obj, align 8
  %30 = getelementptr inbounds %struct.stType*, %struct.stType** %29, i64 3
  %31 = load %struct.stType*, %struct.stType** %30, align 8
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %31, i32 0, i32 2
  %33 = getelementptr inbounds [8 x i32], [8 x i32]* %32, i64 0, i64 1
  %34 = load i32, i32* %33, align 4
  %35 = icmp eq i32 %34, 19
  br i1 %35, label %36, label %64

; <label>:36                                      ; preds = %28
  %37 = load %struct.stType**, %struct.stType*** @obj, align 8
  %38 = getelementptr inbounds %struct.stType*, %struct.stType** %37, i64 3
  %39 = load %struct.stType*, %struct.stType** %38, align 8
  %40 = getelementptr inbounds %struct.stType, %struct.stType* %39, i32 0, i32 1
  %41 = getelementptr inbounds [100 x i8], [100 x i8]* %40, i32 0, i32 0
  %42 = call i32 @strcmp(i8* %41, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %43 = icmp ne i32 %42, 0
  br i1 %43, label %64, label %44

; <label>:44                                      ; preds = %36
  %45 = load %struct.stType**, %struct.stType*** @obj, align 8
  %46 = getelementptr inbounds %struct.stType*, %struct.stType** %45, i64 3
  %47 = load %struct.stType*, %struct.stType** %46, align 8
  %48 = getelementptr inbounds %struct.stType, %struct.stType* %47, i32 0, i32 1
  %49 = getelementptr inbounds [100 x i8], [100 x i8]* %48, i64 0, i64 4
  %50 = load i8, i8* %49, align 4
  %51 = sext i8 %50 to i32
  %52 = icmp eq i32 %51, 111
  br i1 %52, label %53, label %64

; <label>:53                                      ; preds = %44
  %54 = load %struct.stType**, %struct.stType*** @obj, align 8
  %55 = getelementptr inbounds %struct.stType*, %struct.stType** %54, i64 3
  %56 = load %struct.stType*, %struct.stType** %55, align 8
  %57 = getelementptr inbounds %struct.stType, %struct.stType* %56, i32 0, i32 1
  %58 = getelementptr inbounds [100 x i8], [100 x i8]* %57, i64 0, i64 9
  %59 = load i8, i8* %58, align 1
  %60 = sext i8 %59 to i32
  %61 = icmp eq i32 %60, 100
  br i1 %61, label %62, label %64

; <label>:62                                      ; preds = %53
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0))
  br label %64

; <label>:64                                      ; preds = %62, %53, %44, %36, %28, %18, %8, %0
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = call noalias i8* @malloc(i64 160) #6
  %2 = bitcast i8* %1 to %struct.stType**
  store %struct.stType** %2, %struct.stType*** @obj, align 8
  %3 = call noalias i8* @malloc(i64 144) #6
  %4 = bitcast i8* %3 to %struct.stType*
  %5 = load %struct.stType**, %struct.stType*** @obj, align 8
  %6 = getelementptr inbounds %struct.stType*, %struct.stType** %5, i64 0
  store %struct.stType* %4, %struct.stType** %6, align 8
  %7 = call noalias i8* @malloc(i64 16) #6
  %8 = bitcast i8* %7 to %struct.COORD*
  %9 = load %struct.stType**, %struct.stType*** @obj, align 8
  %10 = getelementptr inbounds %struct.stType*, %struct.stType** %9, i64 0
  %11 = load %struct.stType*, %struct.stType** %10, align 8
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 0
  store %struct.COORD* %8, %struct.COORD** %12, align 8
  %13 = call noalias i8* @malloc(i64 4) #6
  %14 = bitcast i8* %13 to i32*
  %15 = load %struct.stType**, %struct.stType*** @obj, align 8
  %16 = getelementptr inbounds %struct.stType*, %struct.stType** %15, i64 0
  %17 = load %struct.stType*, %struct.stType** %16, align 8
  %18 = getelementptr inbounds %struct.stType, %struct.stType* %17, i32 0, i32 0
  %19 = load %struct.COORD*, %struct.COORD** %18, align 8
  %20 = getelementptr inbounds %struct.COORD, %struct.COORD* %19, i32 0, i32 0
  store i32* %14, i32** %20, align 8
  %21 = call noalias i8* @malloc(i64 4) #6
  %22 = bitcast i8* %21 to i32*
  %23 = load %struct.stType**, %struct.stType*** @obj, align 8
  %24 = getelementptr inbounds %struct.stType*, %struct.stType** %23, i64 0
  %25 = load %struct.stType*, %struct.stType** %24, align 8
  %26 = getelementptr inbounds %struct.stType, %struct.stType* %25, i32 0, i32 0
  %27 = load %struct.COORD*, %struct.COORD** %26, align 8
  %28 = getelementptr inbounds %struct.COORD, %struct.COORD* %27, i32 0, i32 1
  store i32* %22, i32** %28, align 8
  %29 = call noalias i8* @malloc(i64 144) #6
  %30 = bitcast i8* %29 to %struct.stType*
  %31 = load %struct.stType**, %struct.stType*** @obj, align 8
  %32 = getelementptr inbounds %struct.stType*, %struct.stType** %31, i64 3
  store %struct.stType* %30, %struct.stType** %32, align 8
  %33 = call noalias i8* @malloc(i64 16) #6
  %34 = bitcast i8* %33 to %struct.COORD*
  %35 = load %struct.stType**, %struct.stType*** @obj, align 8
  %36 = getelementptr inbounds %struct.stType*, %struct.stType** %35, i64 3
  %37 = load %struct.stType*, %struct.stType** %36, align 8
  %38 = getelementptr inbounds %struct.stType, %struct.stType* %37, i32 0, i32 0
  store %struct.COORD* %34, %struct.COORD** %38, align 8
  %39 = call noalias i8* @malloc(i64 4) #6
  %40 = bitcast i8* %39 to i32*
  %41 = load %struct.stType**, %struct.stType*** @obj, align 8
  %42 = getelementptr inbounds %struct.stType*, %struct.stType** %41, i64 3
  %43 = load %struct.stType*, %struct.stType** %42, align 8
  %44 = getelementptr inbounds %struct.stType, %struct.stType* %43, i32 0, i32 0
  %45 = load %struct.COORD*, %struct.COORD** %44, align 8
  %46 = getelementptr inbounds %struct.COORD, %struct.COORD* %45, i32 0, i32 0
  store i32* %40, i32** %46, align 8
  %47 = call noalias i8* @malloc(i64 4) #6
  %48 = bitcast i8* %47 to i32*
  %49 = load %struct.stType**, %struct.stType*** @obj, align 8
  %50 = getelementptr inbounds %struct.stType*, %struct.stType** %49, i64 3
  %51 = load %struct.stType*, %struct.stType** %50, align 8
  %52 = getelementptr inbounds %struct.stType, %struct.stType* %51, i32 0, i32 0
  %53 = load %struct.COORD*, %struct.COORD** %52, align 8
  %54 = getelementptr inbounds %struct.COORD, %struct.COORD* %53, i32 0, i32 1
  store i32* %48, i32** %54, align 8
  %55 = call noalias i8* @malloc(i64 144) #6
  %56 = bitcast i8* %55 to %struct.stType*
  %57 = load %struct.stType**, %struct.stType*** @obj, align 8
  %58 = getelementptr inbounds %struct.stType*, %struct.stType** %57, i64 1
  store %struct.stType* %56, %struct.stType** %58, align 8
  %59 = call noalias i8* @malloc(i64 16) #6
  %60 = bitcast i8* %59 to %struct.COORD*
  %61 = load %struct.stType**, %struct.stType*** @obj, align 8
  %62 = getelementptr inbounds %struct.stType*, %struct.stType** %61, i64 1
  %63 = load %struct.stType*, %struct.stType** %62, align 8
  %64 = getelementptr inbounds %struct.stType, %struct.stType* %63, i32 0, i32 0
  store %struct.COORD* %60, %struct.COORD** %64, align 8
  %65 = call noalias i8* @malloc(i64 4) #6
  %66 = bitcast i8* %65 to i32*
  %67 = load %struct.stType**, %struct.stType*** @obj, align 8
  %68 = getelementptr inbounds %struct.stType*, %struct.stType** %67, i64 1
  %69 = load %struct.stType*, %struct.stType** %68, align 8
  %70 = getelementptr inbounds %struct.stType, %struct.stType* %69, i32 0, i32 0
  %71 = load %struct.COORD*, %struct.COORD** %70, align 8
  %72 = getelementptr inbounds %struct.COORD, %struct.COORD* %71, i32 0, i32 0
  store i32* %66, i32** %72, align 8
  %73 = call noalias i8* @malloc(i64 4) #6
  %74 = bitcast i8* %73 to i32*
  %75 = load %struct.stType**, %struct.stType*** @obj, align 8
  %76 = getelementptr inbounds %struct.stType*, %struct.stType** %75, i64 1
  %77 = load %struct.stType*, %struct.stType** %76, align 8
  %78 = getelementptr inbounds %struct.stType, %struct.stType* %77, i32 0, i32 0
  %79 = load %struct.COORD*, %struct.COORD** %78, align 8
  %80 = getelementptr inbounds %struct.COORD, %struct.COORD* %79, i32 0, i32 1
  store i32* %74, i32** %80, align 8
  %81 = icmp sgt i32 %argc, 2
  %82 = load %struct.stType**, %struct.stType*** @obj, align 8
  %83 = getelementptr inbounds %struct.stType*, %struct.stType** %82, i64 0
  %84 = load %struct.stType*, %struct.stType** %83, align 8
  %85 = getelementptr inbounds %struct.stType, %struct.stType* %84, i32 0, i32 0
  %86 = load %struct.COORD*, %struct.COORD** %85, align 8
  %87 = getelementptr inbounds %struct.COORD, %struct.COORD* %86, i32 0, i32 0
  %88 = load i32*, i32** %87, align 8
  %89 = getelementptr inbounds i32, i32* %88, i64 0
  store i32 1, i32* %89, align 4
  %90 = load %struct.stType**, %struct.stType*** @obj, align 8
  %91 = getelementptr inbounds %struct.stType*, %struct.stType** %90, i64 0
  %92 = load %struct.stType*, %struct.stType** %91, align 8
  %93 = getelementptr inbounds %struct.stType, %struct.stType* %92, i32 0, i32 0
  %94 = load %struct.COORD*, %struct.COORD** %93, align 8
  %95 = getelementptr inbounds %struct.COORD, %struct.COORD* %94, i32 0, i32 1
  %96 = load i32*, i32** %95, align 8
  %97 = getelementptr inbounds i32, i32* %96, i64 0
  store i32 2, i32* %97, align 4
  %98 = load %struct.stType**, %struct.stType*** @obj, align 8
  br i1 %81, label %99, label %150

; <label>:99                                      ; preds = %0
  %100 = getelementptr inbounds %struct.stType*, %struct.stType** %98, i64 0
  %101 = load %struct.stType*, %struct.stType** %100, align 8
  %102 = getelementptr inbounds %struct.stType, %struct.stType* %101, i32 0, i32 2
  %103 = getelementptr inbounds [8 x i32], [8 x i32]* %102, i64 0, i64 0
  store i32 3, i32* %103, align 4
  %104 = load %struct.stType**, %struct.stType*** @obj, align 8
  %105 = getelementptr inbounds %struct.stType*, %struct.stType** %104, i64 0
  %106 = load %struct.stType*, %struct.stType** %105, align 8
  %107 = getelementptr inbounds %struct.stType, %struct.stType* %106, i32 0, i32 2
  %108 = getelementptr inbounds [8 x i32], [8 x i32]* %107, i64 0, i64 1
  store i32 4, i32* %108, align 4
  %109 = load %struct.stType**, %struct.stType*** @obj, align 8
  %110 = getelementptr inbounds %struct.stType*, %struct.stType** %109, i64 0
  %111 = load %struct.stType*, %struct.stType** %110, align 8
  %112 = getelementptr inbounds %struct.stType, %struct.stType* %111, i32 0, i32 2
  %113 = getelementptr inbounds [8 x i32], [8 x i32]* %112, i64 0, i64 2
  store i32 5, i32* %113, align 4
  %114 = load %struct.stType**, %struct.stType*** @obj, align 8
  %115 = getelementptr inbounds %struct.stType*, %struct.stType** %114, i64 3
  %116 = load %struct.stType*, %struct.stType** %115, align 8
  %117 = getelementptr inbounds %struct.stType, %struct.stType* %116, i32 0, i32 0
  %118 = load %struct.COORD*, %struct.COORD** %117, align 8
  %119 = getelementptr inbounds %struct.COORD, %struct.COORD* %118, i32 0, i32 0
  %120 = load i32*, i32** %119, align 8
  %121 = getelementptr inbounds i32, i32* %120, i64 0
  store i32 16, i32* %121, align 4
  %122 = load %struct.stType**, %struct.stType*** @obj, align 8
  %123 = getelementptr inbounds %struct.stType*, %struct.stType** %122, i64 3
  %124 = load %struct.stType*, %struct.stType** %123, align 8
  %125 = getelementptr inbounds %struct.stType, %struct.stType* %124, i32 0, i32 0
  %126 = load %struct.COORD*, %struct.COORD** %125, align 8
  %127 = getelementptr inbounds %struct.COORD, %struct.COORD* %126, i32 0, i32 1
  %128 = load i32*, i32** %127, align 8
  %129 = getelementptr inbounds i32, i32* %128, i64 0
  store i32 17, i32* %129, align 4
  %130 = load %struct.stType**, %struct.stType*** @obj, align 8
  %131 = getelementptr inbounds %struct.stType*, %struct.stType** %130, i64 3
  %132 = load %struct.stType*, %struct.stType** %131, align 8
  %133 = getelementptr inbounds %struct.stType, %struct.stType* %132, i32 0, i32 2
  %134 = getelementptr inbounds [8 x i32], [8 x i32]* %133, i64 0, i64 0
  store i32 18, i32* %134, align 4
  %135 = load %struct.stType**, %struct.stType*** @obj, align 8
  %136 = getelementptr inbounds %struct.stType*, %struct.stType** %135, i64 3
  %137 = load %struct.stType*, %struct.stType** %136, align 8
  %138 = getelementptr inbounds %struct.stType, %struct.stType* %137, i32 0, i32 2
  %139 = getelementptr inbounds [8 x i32], [8 x i32]* %138, i64 0, i64 1
  store i32 19, i32* %139, align 4
  %140 = load %struct.stType**, %struct.stType*** @obj, align 8
  %141 = getelementptr inbounds %struct.stType*, %struct.stType** %140, i64 3
  %142 = load %struct.stType*, %struct.stType** %141, align 8
  %143 = getelementptr inbounds %struct.stType, %struct.stType* %142, i32 0, i32 2
  %144 = getelementptr inbounds [8 x i32], [8 x i32]* %143, i64 0, i64 2
  store i32 20, i32* %144, align 4
  %145 = load %struct.stType**, %struct.stType*** @obj, align 8
  %146 = getelementptr inbounds %struct.stType*, %struct.stType** %145, i64 3
  %147 = load %struct.stType*, %struct.stType** %146, align 8
  %148 = getelementptr inbounds %struct.stType, %struct.stType* %147, i32 0, i32 1
  %149 = getelementptr inbounds [100 x i8], [100 x i8]* %148, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %149, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %186

; <label>:150                                     ; preds = %0
  %151 = getelementptr inbounds %struct.stType*, %struct.stType** %98, i64 1
  %152 = load %struct.stType*, %struct.stType** %151, align 8
  %153 = getelementptr inbounds %struct.stType, %struct.stType* %152, i32 0, i32 0
  %154 = load %struct.COORD*, %struct.COORD** %153, align 8
  %155 = getelementptr inbounds %struct.COORD, %struct.COORD* %154, i32 0, i32 0
  %156 = load i32*, i32** %155, align 8
  %157 = getelementptr inbounds i32, i32* %156, i64 0
  store i32 6, i32* %157, align 4
  %158 = load %struct.stType**, %struct.stType*** @obj, align 8
  %159 = getelementptr inbounds %struct.stType*, %struct.stType** %158, i64 1
  %160 = load %struct.stType*, %struct.stType** %159, align 8
  %161 = getelementptr inbounds %struct.stType, %struct.stType* %160, i32 0, i32 0
  %162 = load %struct.COORD*, %struct.COORD** %161, align 8
  %163 = getelementptr inbounds %struct.COORD, %struct.COORD* %162, i32 0, i32 1
  %164 = load i32*, i32** %163, align 8
  %165 = getelementptr inbounds i32, i32* %164, i64 0
  store i32 7, i32* %165, align 4
  %166 = load %struct.stType**, %struct.stType*** @obj, align 8
  %167 = getelementptr inbounds %struct.stType*, %struct.stType** %166, i64 1
  %168 = load %struct.stType*, %struct.stType** %167, align 8
  %169 = getelementptr inbounds %struct.stType, %struct.stType* %168, i32 0, i32 2
  %170 = getelementptr inbounds [8 x i32], [8 x i32]* %169, i64 0, i64 0
  store i32 8, i32* %170, align 4
  %171 = load %struct.stType**, %struct.stType*** @obj, align 8
  %172 = getelementptr inbounds %struct.stType*, %struct.stType** %171, i64 1
  %173 = load %struct.stType*, %struct.stType** %172, align 8
  %174 = getelementptr inbounds %struct.stType, %struct.stType* %173, i32 0, i32 2
  %175 = getelementptr inbounds [8 x i32], [8 x i32]* %174, i64 0, i64 1
  store i32 9, i32* %175, align 4
  %176 = load %struct.stType**, %struct.stType*** @obj, align 8
  %177 = getelementptr inbounds %struct.stType*, %struct.stType** %176, i64 1
  %178 = load %struct.stType*, %struct.stType** %177, align 8
  %179 = getelementptr inbounds %struct.stType, %struct.stType* %178, i32 0, i32 2
  %180 = getelementptr inbounds [8 x i32], [8 x i32]* %179, i64 0, i64 2
  store i32 10, i32* %180, align 4
  %181 = load %struct.stType**, %struct.stType*** @obj, align 8
  %182 = getelementptr inbounds %struct.stType*, %struct.stType** %181, i64 1
  %183 = load %struct.stType*, %struct.stType** %182, align 8
  %184 = getelementptr inbounds %struct.stType, %struct.stType* %183, i32 0, i32 1
  %185 = getelementptr inbounds [100 x i8], [100 x i8]* %184, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %185, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %186

; <label>:186                                     ; preds = %150, %99
  %187 = load %struct.stType**, %struct.stType*** @obj, align 8
  %188 = getelementptr inbounds %struct.stType*, %struct.stType** %187, i64 0
  %189 = load %struct.stType*, %struct.stType** %188, align 8
  %190 = getelementptr inbounds %struct.stType, %struct.stType* %189, i32 0, i32 1
  %191 = getelementptr inbounds [100 x i8], [100 x i8]* %190, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %191, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %192 = load %struct.stType**, %struct.stType*** @obj, align 8
  %193 = getelementptr inbounds %struct.stType*, %struct.stType** %192, i64 1
  %194 = load %struct.stType*, %struct.stType** %193, align 8
  %195 = getelementptr inbounds %struct.stType, %struct.stType* %194, i32 0, i32 0
  %196 = load %struct.COORD*, %struct.COORD** %195, align 8
  %197 = getelementptr inbounds %struct.COORD, %struct.COORD* %196, i32 0, i32 0
  %198 = load i32*, i32** %197, align 8
  %199 = getelementptr inbounds i32, i32* %198, i64 0
  store i32 6, i32* %199, align 4
  %200 = load %struct.stType**, %struct.stType*** @obj, align 8
  %201 = getelementptr inbounds %struct.stType*, %struct.stType** %200, i64 1
  %202 = load %struct.stType*, %struct.stType** %201, align 8
  %203 = getelementptr inbounds %struct.stType, %struct.stType* %202, i32 0, i32 0
  %204 = load %struct.COORD*, %struct.COORD** %203, align 8
  %205 = getelementptr inbounds %struct.COORD, %struct.COORD* %204, i32 0, i32 1
  %206 = load i32*, i32** %205, align 8
  %207 = getelementptr inbounds i32, i32* %206, i64 0
  store i32 7, i32* %207, align 4
  %208 = load %struct.stType**, %struct.stType*** @obj, align 8
  %209 = getelementptr inbounds %struct.stType*, %struct.stType** %208, i64 1
  %210 = load %struct.stType*, %struct.stType** %209, align 8
  %211 = getelementptr inbounds %struct.stType, %struct.stType* %210, i32 0, i32 2
  %212 = getelementptr inbounds [8 x i32], [8 x i32]* %211, i64 0, i64 0
  store i32 8, i32* %212, align 4
  %213 = load %struct.stType**, %struct.stType*** @obj, align 8
  %214 = getelementptr inbounds %struct.stType*, %struct.stType** %213, i64 1
  %215 = load %struct.stType*, %struct.stType** %214, align 8
  %216 = getelementptr inbounds %struct.stType, %struct.stType* %215, i32 0, i32 2
  %217 = getelementptr inbounds [8 x i32], [8 x i32]* %216, i64 0, i64 1
  store i32 9, i32* %217, align 4
  %218 = load %struct.stType**, %struct.stType*** @obj, align 8
  %219 = getelementptr inbounds %struct.stType*, %struct.stType** %218, i64 1
  %220 = load %struct.stType*, %struct.stType** %219, align 8
  %221 = getelementptr inbounds %struct.stType, %struct.stType* %220, i32 0, i32 2
  %222 = getelementptr inbounds [8 x i32], [8 x i32]* %221, i64 0, i64 2
  store i32 10, i32* %222, align 4
  %223 = load %struct.stType**, %struct.stType*** @obj, align 8
  %224 = getelementptr inbounds %struct.stType*, %struct.stType** %223, i64 1
  %225 = load %struct.stType*, %struct.stType** %224, align 8
  %226 = getelementptr inbounds %struct.stType, %struct.stType* %225, i32 0, i32 1
  %227 = getelementptr inbounds [100 x i8], [100 x i8]* %226, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %227, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %228 = call noalias i8* @malloc(i64 144) #6
  %229 = bitcast i8* %228 to %struct.stType*
  %230 = load %struct.stType**, %struct.stType*** @obj, align 8
  %231 = getelementptr inbounds %struct.stType*, %struct.stType** %230, i64 2
  store %struct.stType* %229, %struct.stType** %231, align 8
  %232 = call noalias i8* @malloc(i64 16) #6
  %233 = bitcast i8* %232 to %struct.COORD*
  %234 = load %struct.stType**, %struct.stType*** @obj, align 8
  %235 = getelementptr inbounds %struct.stType*, %struct.stType** %234, i64 2
  %236 = load %struct.stType*, %struct.stType** %235, align 8
  %237 = getelementptr inbounds %struct.stType, %struct.stType* %236, i32 0, i32 0
  store %struct.COORD* %233, %struct.COORD** %237, align 8
  %238 = call noalias i8* @malloc(i64 4) #6
  %239 = bitcast i8* %238 to i32*
  %240 = load %struct.stType**, %struct.stType*** @obj, align 8
  %241 = getelementptr inbounds %struct.stType*, %struct.stType** %240, i64 2
  %242 = load %struct.stType*, %struct.stType** %241, align 8
  %243 = getelementptr inbounds %struct.stType, %struct.stType* %242, i32 0, i32 0
  %244 = load %struct.COORD*, %struct.COORD** %243, align 8
  %245 = getelementptr inbounds %struct.COORD, %struct.COORD* %244, i32 0, i32 0
  store i32* %239, i32** %245, align 8
  %246 = call noalias i8* @malloc(i64 4) #6
  %247 = bitcast i8* %246 to i32*
  %248 = load %struct.stType**, %struct.stType*** @obj, align 8
  %249 = getelementptr inbounds %struct.stType*, %struct.stType** %248, i64 2
  %250 = load %struct.stType*, %struct.stType** %249, align 8
  %251 = getelementptr inbounds %struct.stType, %struct.stType* %250, i32 0, i32 0
  %252 = load %struct.COORD*, %struct.COORD** %251, align 8
  %253 = getelementptr inbounds %struct.COORD, %struct.COORD* %252, i32 0, i32 1
  store i32* %247, i32** %253, align 8
  %254 = load %struct.stType**, %struct.stType*** @obj, align 8
  %255 = getelementptr inbounds %struct.stType*, %struct.stType** %254, i64 2
  %256 = load %struct.stType*, %struct.stType** %255, align 8
  %257 = getelementptr inbounds %struct.stType, %struct.stType* %256, i32 0, i32 0
  %258 = load %struct.COORD*, %struct.COORD** %257, align 8
  %259 = getelementptr inbounds %struct.COORD, %struct.COORD* %258, i32 0, i32 0
  %260 = load i32*, i32** %259, align 8
  %261 = getelementptr inbounds i32, i32* %260, i64 0
  store i32 11, i32* %261, align 4
  %262 = load %struct.stType**, %struct.stType*** @obj, align 8
  %263 = getelementptr inbounds %struct.stType*, %struct.stType** %262, i64 2
  %264 = load %struct.stType*, %struct.stType** %263, align 8
  %265 = getelementptr inbounds %struct.stType, %struct.stType* %264, i32 0, i32 0
  %266 = load %struct.COORD*, %struct.COORD** %265, align 8
  %267 = getelementptr inbounds %struct.COORD, %struct.COORD* %266, i32 0, i32 1
  %268 = load i32*, i32** %267, align 8
  %269 = getelementptr inbounds i32, i32* %268, i64 0
  store i32 12, i32* %269, align 4
  %270 = load %struct.stType**, %struct.stType*** @obj, align 8
  %271 = getelementptr inbounds %struct.stType*, %struct.stType** %270, i64 2
  %272 = load %struct.stType*, %struct.stType** %271, align 8
  %273 = getelementptr inbounds %struct.stType, %struct.stType* %272, i32 0, i32 2
  %274 = getelementptr inbounds [8 x i32], [8 x i32]* %273, i64 0, i64 0
  store i32 13, i32* %274, align 4
  %275 = load %struct.stType**, %struct.stType*** @obj, align 8
  %276 = getelementptr inbounds %struct.stType*, %struct.stType** %275, i64 2
  %277 = load %struct.stType*, %struct.stType** %276, align 8
  %278 = getelementptr inbounds %struct.stType, %struct.stType* %277, i32 0, i32 2
  %279 = getelementptr inbounds [8 x i32], [8 x i32]* %278, i64 0, i64 1
  store i32 14, i32* %279, align 4
  %280 = load %struct.stType**, %struct.stType*** @obj, align 8
  %281 = getelementptr inbounds %struct.stType*, %struct.stType** %280, i64 2
  %282 = load %struct.stType*, %struct.stType** %281, align 8
  %283 = getelementptr inbounds %struct.stType, %struct.stType* %282, i32 0, i32 2
  %284 = getelementptr inbounds [8 x i32], [8 x i32]* %283, i64 0, i64 2
  store i32 15, i32* %284, align 4
  %285 = load %struct.stType**, %struct.stType*** @obj, align 8
  %286 = getelementptr inbounds %struct.stType*, %struct.stType** %285, i64 2
  %287 = load %struct.stType*, %struct.stType** %286, align 8
  %288 = getelementptr inbounds %struct.stType, %struct.stType* %287, i32 0, i32 1
  %289 = getelementptr inbounds [100 x i8], [100 x i8]* %288, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %289, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  call void @branchPruned_clone()
  call void @branchNotPruned_clone()
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #4

; Function Attrs: nounwind uwtable
define void @branchPruned_clone() #0 {
  %1 = load %struct.stType**, %struct.stType*** @obj, align 8
  %2 = getelementptr inbounds %struct.stType*, %struct.stType** %1, i64 0
  %3 = load %struct.stType*, %struct.stType** %2, align 8
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 0
  %5 = load %struct.COORD*, %struct.COORD** %4, align 8
  %6 = getelementptr inbounds %struct.COORD, %struct.COORD* %5, i32 0, i32 0
  %7 = load i32*, i32** %6, align 8
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 1, 1
  br i1 %9, label %10, label %104

; <label>:10                                      ; preds = %0
  %11 = load %struct.stType**, %struct.stType*** @obj, align 8
  %12 = getelementptr inbounds %struct.stType*, %struct.stType** %11, i64 0
  %13 = load %struct.stType*, %struct.stType** %12, align 8
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %13, i32 0, i32 0
  %15 = load %struct.COORD*, %struct.COORD** %14, align 8
  %16 = getelementptr inbounds %struct.COORD, %struct.COORD* %15, i32 0, i32 1
  %17 = load i32*, i32** %16, align 8
  %18 = load i32, i32* %17, align 4
  %19 = icmp eq i32 2, 2
  br i1 %19, label %20, label %104

; <label>:20                                      ; preds = %10
  %21 = load %struct.stType**, %struct.stType*** @obj, align 8
  %22 = getelementptr inbounds %struct.stType*, %struct.stType** %21, i64 0
  %23 = load %struct.stType*, %struct.stType** %22, align 8
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %23, i32 0, i32 1
  %25 = getelementptr inbounds [100 x i8], [100 x i8]* %24, i32 0, i32 0
  %26 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %27 = call i32 @strcmp(i8* %26, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %28 = icmp ne i32 0, 0
  br i1 %28, label %104, label %29

; <label>:29                                      ; preds = %20
  %30 = load %struct.stType**, %struct.stType*** @obj, align 8
  %31 = getelementptr inbounds %struct.stType*, %struct.stType** %30, i64 0
  %32 = load %struct.stType*, %struct.stType** %31, align 8
  %33 = getelementptr inbounds %struct.stType, %struct.stType* %32, i32 0, i32 1
  %34 = getelementptr inbounds [100 x i8], [100 x i8]* %33, i64 0, i64 4
  %35 = load i8, i8* %34, align 4
  %36 = sext i8 111 to i32
  %37 = icmp eq i32 %36, 111
  br i1 %37, label %38, label %104

; <label>:38                                      ; preds = %29
  %39 = load %struct.stType**, %struct.stType*** @obj, align 8
  %40 = getelementptr inbounds %struct.stType*, %struct.stType** %39, i64 0
  %41 = load %struct.stType*, %struct.stType** %40, align 8
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %41, i32 0, i32 1
  %43 = getelementptr inbounds [100 x i8], [100 x i8]* %42, i64 0, i64 9
  %44 = load i8, i8* %43, align 1
  %45 = sext i8 100 to i32
  %46 = icmp eq i32 %45, 100
  br i1 %46, label %47, label %104

; <label>:47                                      ; preds = %38
  %48 = load %struct.stType**, %struct.stType*** @obj, align 8
  %49 = getelementptr inbounds %struct.stType*, %struct.stType** %48, i64 2
  %50 = load %struct.stType*, %struct.stType** %49, align 8
  %51 = getelementptr inbounds %struct.stType, %struct.stType* %50, i32 0, i32 0
  %52 = load %struct.COORD*, %struct.COORD** %51, align 8
  %53 = getelementptr inbounds %struct.COORD, %struct.COORD* %52, i32 0, i32 0
  %54 = load i32*, i32** %53, align 8
  %55 = load i32, i32* %54, align 4
  %56 = icmp eq i32 11, 11
  br i1 %56, label %57, label %104

; <label>:57                                      ; preds = %47
  %58 = load %struct.stType**, %struct.stType*** @obj, align 8
  %59 = getelementptr inbounds %struct.stType*, %struct.stType** %58, i64 2
  %60 = load %struct.stType*, %struct.stType** %59, align 8
  %61 = getelementptr inbounds %struct.stType, %struct.stType* %60, i32 0, i32 0
  %62 = load %struct.COORD*, %struct.COORD** %61, align 8
  %63 = getelementptr inbounds %struct.COORD, %struct.COORD* %62, i32 0, i32 1
  %64 = load i32*, i32** %63, align 8
  %65 = load i32, i32* %64, align 4
  %66 = icmp eq i32 12, 12
  br i1 %66, label %67, label %104

; <label>:67                                      ; preds = %57
  %68 = load %struct.stType**, %struct.stType*** @obj, align 8
  %69 = getelementptr inbounds %struct.stType*, %struct.stType** %68, i64 2
  %70 = load %struct.stType*, %struct.stType** %69, align 8
  %71 = getelementptr inbounds %struct.stType, %struct.stType* %70, i32 0, i32 2
  %72 = getelementptr inbounds [8 x i32], [8 x i32]* %71, i64 0, i64 1
  %73 = load i32, i32* %72, align 4
  %74 = icmp eq i32 14, 14
  br i1 %74, label %75, label %104

; <label>:75                                      ; preds = %67
  %76 = load %struct.stType**, %struct.stType*** @obj, align 8
  %77 = getelementptr inbounds %struct.stType*, %struct.stType** %76, i64 2
  %78 = load %struct.stType*, %struct.stType** %77, align 8
  %79 = getelementptr inbounds %struct.stType, %struct.stType* %78, i32 0, i32 1
  %80 = getelementptr inbounds [100 x i8], [100 x i8]* %79, i32 0, i32 0
  %81 = getelementptr [11 x i8], [11 x i8]* @1, i64 0, i64 0
  %82 = call i32 @strcmp(i8* %81, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %83 = icmp ne i32 0, 0
  br i1 %83, label %104, label %84

; <label>:84                                      ; preds = %75
  %85 = load %struct.stType**, %struct.stType*** @obj, align 8
  %86 = getelementptr inbounds %struct.stType*, %struct.stType** %85, i64 2
  %87 = load %struct.stType*, %struct.stType** %86, align 8
  %88 = getelementptr inbounds %struct.stType, %struct.stType* %87, i32 0, i32 1
  %89 = getelementptr inbounds [100 x i8], [100 x i8]* %88, i64 0, i64 4
  %90 = load i8, i8* %89, align 4
  %91 = sext i8 111 to i32
  %92 = icmp eq i32 %91, 111
  br i1 %92, label %93, label %104

; <label>:93                                      ; preds = %84
  %94 = load %struct.stType**, %struct.stType*** @obj, align 8
  %95 = getelementptr inbounds %struct.stType*, %struct.stType** %94, i64 2
  %96 = load %struct.stType*, %struct.stType** %95, align 8
  %97 = getelementptr inbounds %struct.stType, %struct.stType* %96, i32 0, i32 1
  %98 = getelementptr inbounds [100 x i8], [100 x i8]* %97, i64 0, i64 9
  %99 = load i8, i8* %98, align 1
  %100 = sext i8 100 to i32
  %101 = icmp eq i32 %100, 100
  br i1 %101, label %102, label %104

; <label>:102                                     ; preds = %93
  %103 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %104

; <label>:104                                     ; preds = %102, %93, %84, %75, %67, %57, %47, %38, %29, %20, %10, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone() #0 {
  %1 = load %struct.stType**, %struct.stType*** @obj, align 8
  %2 = getelementptr inbounds %struct.stType*, %struct.stType** %1, i64 0
  %3 = load %struct.stType*, %struct.stType** %2, align 8
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 2
  %5 = getelementptr inbounds [8 x i32], [8 x i32]* %4, i64 0, i64 1
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 4
  br i1 %7, label %8, label %64

; <label>:8                                       ; preds = %0
  %9 = load %struct.stType**, %struct.stType*** @obj, align 8
  %10 = getelementptr inbounds %struct.stType*, %struct.stType** %9, i64 3
  %11 = load %struct.stType*, %struct.stType** %10, align 8
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 0
  %13 = load %struct.COORD*, %struct.COORD** %12, align 8
  %14 = getelementptr inbounds %struct.COORD, %struct.COORD* %13, i32 0, i32 0
  %15 = load i32*, i32** %14, align 8
  %16 = load i32, i32* %15, align 4
  %17 = icmp eq i32 %16, 16
  br i1 %17, label %18, label %64

; <label>:18                                      ; preds = %8
  %19 = load %struct.stType**, %struct.stType*** @obj, align 8
  %20 = getelementptr inbounds %struct.stType*, %struct.stType** %19, i64 3
  %21 = load %struct.stType*, %struct.stType** %20, align 8
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %21, i32 0, i32 0
  %23 = load %struct.COORD*, %struct.COORD** %22, align 8
  %24 = getelementptr inbounds %struct.COORD, %struct.COORD* %23, i32 0, i32 1
  %25 = load i32*, i32** %24, align 8
  %26 = load i32, i32* %25, align 4
  %27 = icmp eq i32 %26, 17
  br i1 %27, label %28, label %64

; <label>:28                                      ; preds = %18
  %29 = load %struct.stType**, %struct.stType*** @obj, align 8
  %30 = getelementptr inbounds %struct.stType*, %struct.stType** %29, i64 3
  %31 = load %struct.stType*, %struct.stType** %30, align 8
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %31, i32 0, i32 2
  %33 = getelementptr inbounds [8 x i32], [8 x i32]* %32, i64 0, i64 1
  %34 = load i32, i32* %33, align 4
  %35 = icmp eq i32 %34, 19
  br i1 %35, label %36, label %64

; <label>:36                                      ; preds = %28
  %37 = load %struct.stType**, %struct.stType*** @obj, align 8
  %38 = getelementptr inbounds %struct.stType*, %struct.stType** %37, i64 3
  %39 = load %struct.stType*, %struct.stType** %38, align 8
  %40 = getelementptr inbounds %struct.stType, %struct.stType* %39, i32 0, i32 1
  %41 = getelementptr inbounds [100 x i8], [100 x i8]* %40, i32 0, i32 0
  %42 = call i32 @strcmp(i8* %41, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %43 = icmp ne i32 %42, 0
  br i1 %43, label %64, label %44

; <label>:44                                      ; preds = %36
  %45 = load %struct.stType**, %struct.stType*** @obj, align 8
  %46 = getelementptr inbounds %struct.stType*, %struct.stType** %45, i64 3
  %47 = load %struct.stType*, %struct.stType** %46, align 8
  %48 = getelementptr inbounds %struct.stType, %struct.stType* %47, i32 0, i32 1
  %49 = getelementptr inbounds [100 x i8], [100 x i8]* %48, i64 0, i64 4
  %50 = load i8, i8* %49, align 4
  %51 = sext i8 %50 to i32
  %52 = icmp eq i32 %51, 111
  br i1 %52, label %53, label %64

; <label>:53                                      ; preds = %44
  %54 = load %struct.stType**, %struct.stType*** @obj, align 8
  %55 = getelementptr inbounds %struct.stType*, %struct.stType** %54, i64 3
  %56 = load %struct.stType*, %struct.stType** %55, align 8
  %57 = getelementptr inbounds %struct.stType, %struct.stType* %56, i32 0, i32 1
  %58 = getelementptr inbounds [100 x i8], [100 x i8]* %57, i64 0, i64 9
  %59 = load i8, i8* %58, align 1
  %60 = sext i8 %59 to i32
  %61 = icmp eq i32 %60, 100
  br i1 %61, label %62, label %64

; <label>:62                                      ; preds = %53
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0))
  br label %64

; <label>:64                                      ; preds = %62, %53, %44, %36, %28, %18, %8, %0
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
