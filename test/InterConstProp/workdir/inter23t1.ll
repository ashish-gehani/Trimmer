; ModuleID = 'workdir/inter23t1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@obj = common global %struct.stType** null, align 8
@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"*** Branch Taken \0A\00", align 1
@.str.2 = private unnamed_addr constant [23 x i8] c"*** Branch not Taken \0A\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1

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
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  store i32 0, i32* %1, align 4
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = call noalias i8* @malloc(i64 160) #6
  %5 = bitcast i8* %4 to %struct.stType**
  store %struct.stType** %5, %struct.stType*** @obj, align 8
  %6 = call noalias i8* @malloc(i64 144) #6
  %7 = bitcast i8* %6 to %struct.stType*
  %8 = load %struct.stType**, %struct.stType*** @obj, align 8
  %9 = getelementptr inbounds %struct.stType*, %struct.stType** %8, i64 0
  store %struct.stType* %7, %struct.stType** %9, align 8
  %10 = call noalias i8* @malloc(i64 16) #6
  %11 = bitcast i8* %10 to %struct.COORD*
  %12 = load %struct.stType**, %struct.stType*** @obj, align 8
  %13 = getelementptr inbounds %struct.stType*, %struct.stType** %12, i64 0
  %14 = load %struct.stType*, %struct.stType** %13, align 8
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %14, i32 0, i32 0
  store %struct.COORD* %11, %struct.COORD** %15, align 8
  %16 = call noalias i8* @malloc(i64 4) #6
  %17 = bitcast i8* %16 to i32*
  %18 = load %struct.stType**, %struct.stType*** @obj, align 8
  %19 = getelementptr inbounds %struct.stType*, %struct.stType** %18, i64 0
  %20 = load %struct.stType*, %struct.stType** %19, align 8
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %20, i32 0, i32 0
  %22 = load %struct.COORD*, %struct.COORD** %21, align 8
  %23 = getelementptr inbounds %struct.COORD, %struct.COORD* %22, i32 0, i32 0
  store i32* %17, i32** %23, align 8
  %24 = call noalias i8* @malloc(i64 4) #6
  %25 = bitcast i8* %24 to i32*
  %26 = load %struct.stType**, %struct.stType*** @obj, align 8
  %27 = getelementptr inbounds %struct.stType*, %struct.stType** %26, i64 0
  %28 = load %struct.stType*, %struct.stType** %27, align 8
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i32 0, i32 0
  %30 = load %struct.COORD*, %struct.COORD** %29, align 8
  %31 = getelementptr inbounds %struct.COORD, %struct.COORD* %30, i32 0, i32 1
  store i32* %25, i32** %31, align 8
  %32 = call noalias i8* @malloc(i64 144) #6
  %33 = bitcast i8* %32 to %struct.stType*
  %34 = load %struct.stType**, %struct.stType*** @obj, align 8
  %35 = getelementptr inbounds %struct.stType*, %struct.stType** %34, i64 3
  store %struct.stType* %33, %struct.stType** %35, align 8
  %36 = call noalias i8* @malloc(i64 16) #6
  %37 = bitcast i8* %36 to %struct.COORD*
  %38 = load %struct.stType**, %struct.stType*** @obj, align 8
  %39 = getelementptr inbounds %struct.stType*, %struct.stType** %38, i64 3
  %40 = load %struct.stType*, %struct.stType** %39, align 8
  %41 = getelementptr inbounds %struct.stType, %struct.stType* %40, i32 0, i32 0
  store %struct.COORD* %37, %struct.COORD** %41, align 8
  %42 = call noalias i8* @malloc(i64 4) #6
  %43 = bitcast i8* %42 to i32*
  %44 = load %struct.stType**, %struct.stType*** @obj, align 8
  %45 = getelementptr inbounds %struct.stType*, %struct.stType** %44, i64 3
  %46 = load %struct.stType*, %struct.stType** %45, align 8
  %47 = getelementptr inbounds %struct.stType, %struct.stType* %46, i32 0, i32 0
  %48 = load %struct.COORD*, %struct.COORD** %47, align 8
  %49 = getelementptr inbounds %struct.COORD, %struct.COORD* %48, i32 0, i32 0
  store i32* %43, i32** %49, align 8
  %50 = call noalias i8* @malloc(i64 4) #6
  %51 = bitcast i8* %50 to i32*
  %52 = load %struct.stType**, %struct.stType*** @obj, align 8
  %53 = getelementptr inbounds %struct.stType*, %struct.stType** %52, i64 3
  %54 = load %struct.stType*, %struct.stType** %53, align 8
  %55 = getelementptr inbounds %struct.stType, %struct.stType* %54, i32 0, i32 0
  %56 = load %struct.COORD*, %struct.COORD** %55, align 8
  %57 = getelementptr inbounds %struct.COORD, %struct.COORD* %56, i32 0, i32 1
  store i32* %51, i32** %57, align 8
  %58 = call noalias i8* @malloc(i64 144) #6
  %59 = bitcast i8* %58 to %struct.stType*
  %60 = load %struct.stType**, %struct.stType*** @obj, align 8
  %61 = getelementptr inbounds %struct.stType*, %struct.stType** %60, i64 1
  store %struct.stType* %59, %struct.stType** %61, align 8
  %62 = call noalias i8* @malloc(i64 16) #6
  %63 = bitcast i8* %62 to %struct.COORD*
  %64 = load %struct.stType**, %struct.stType*** @obj, align 8
  %65 = getelementptr inbounds %struct.stType*, %struct.stType** %64, i64 1
  %66 = load %struct.stType*, %struct.stType** %65, align 8
  %67 = getelementptr inbounds %struct.stType, %struct.stType* %66, i32 0, i32 0
  store %struct.COORD* %63, %struct.COORD** %67, align 8
  %68 = call noalias i8* @malloc(i64 4) #6
  %69 = bitcast i8* %68 to i32*
  %70 = load %struct.stType**, %struct.stType*** @obj, align 8
  %71 = getelementptr inbounds %struct.stType*, %struct.stType** %70, i64 1
  %72 = load %struct.stType*, %struct.stType** %71, align 8
  %73 = getelementptr inbounds %struct.stType, %struct.stType* %72, i32 0, i32 0
  %74 = load %struct.COORD*, %struct.COORD** %73, align 8
  %75 = getelementptr inbounds %struct.COORD, %struct.COORD* %74, i32 0, i32 0
  store i32* %69, i32** %75, align 8
  %76 = call noalias i8* @malloc(i64 4) #6
  %77 = bitcast i8* %76 to i32*
  %78 = load %struct.stType**, %struct.stType*** @obj, align 8
  %79 = getelementptr inbounds %struct.stType*, %struct.stType** %78, i64 1
  %80 = load %struct.stType*, %struct.stType** %79, align 8
  %81 = getelementptr inbounds %struct.stType, %struct.stType* %80, i32 0, i32 0
  %82 = load %struct.COORD*, %struct.COORD** %81, align 8
  %83 = getelementptr inbounds %struct.COORD, %struct.COORD* %82, i32 0, i32 1
  store i32* %77, i32** %83, align 8
  %84 = load i32, i32* %2, align 4
  %85 = icmp sgt i32 %84, 2
  br i1 %85, label %86, label %175

; <label>:86                                      ; preds = %0
  %87 = load i32, i32* %2, align 4
  %88 = icmp sgt i32 %87, 5
  br i1 %88, label %89, label %106

; <label>:89                                      ; preds = %86
  %90 = load %struct.stType**, %struct.stType*** @obj, align 8
  %91 = getelementptr inbounds %struct.stType*, %struct.stType** %90, i64 0
  %92 = load %struct.stType*, %struct.stType** %91, align 8
  %93 = getelementptr inbounds %struct.stType, %struct.stType* %92, i32 0, i32 0
  %94 = load %struct.COORD*, %struct.COORD** %93, align 8
  %95 = getelementptr inbounds %struct.COORD, %struct.COORD* %94, i32 0, i32 0
  %96 = load i32*, i32** %95, align 8
  %97 = getelementptr inbounds i32, i32* %96, i64 0
  store i32 1, i32* %97, align 4
  %98 = load %struct.stType**, %struct.stType*** @obj, align 8
  %99 = getelementptr inbounds %struct.stType*, %struct.stType** %98, i64 0
  %100 = load %struct.stType*, %struct.stType** %99, align 8
  %101 = getelementptr inbounds %struct.stType, %struct.stType* %100, i32 0, i32 0
  %102 = load %struct.COORD*, %struct.COORD** %101, align 8
  %103 = getelementptr inbounds %struct.COORD, %struct.COORD* %102, i32 0, i32 1
  %104 = load i32*, i32** %103, align 8
  %105 = getelementptr inbounds i32, i32* %104, i64 0
  store i32 2, i32* %105, align 4
  br label %123

; <label>:106                                     ; preds = %86
  %107 = load %struct.stType**, %struct.stType*** @obj, align 8
  %108 = getelementptr inbounds %struct.stType*, %struct.stType** %107, i64 0
  %109 = load %struct.stType*, %struct.stType** %108, align 8
  %110 = getelementptr inbounds %struct.stType, %struct.stType* %109, i32 0, i32 0
  %111 = load %struct.COORD*, %struct.COORD** %110, align 8
  %112 = getelementptr inbounds %struct.COORD, %struct.COORD* %111, i32 0, i32 0
  %113 = load i32*, i32** %112, align 8
  %114 = getelementptr inbounds i32, i32* %113, i64 0
  store i32 1, i32* %114, align 4
  %115 = load %struct.stType**, %struct.stType*** @obj, align 8
  %116 = getelementptr inbounds %struct.stType*, %struct.stType** %115, i64 0
  %117 = load %struct.stType*, %struct.stType** %116, align 8
  %118 = getelementptr inbounds %struct.stType, %struct.stType* %117, i32 0, i32 0
  %119 = load %struct.COORD*, %struct.COORD** %118, align 8
  %120 = getelementptr inbounds %struct.COORD, %struct.COORD* %119, i32 0, i32 1
  %121 = load i32*, i32** %120, align 8
  %122 = getelementptr inbounds i32, i32* %121, i64 0
  store i32 2, i32* %122, align 4
  br label %123

; <label>:123                                     ; preds = %106, %89
  %124 = load %struct.stType**, %struct.stType*** @obj, align 8
  %125 = getelementptr inbounds %struct.stType*, %struct.stType** %124, i64 0
  %126 = load %struct.stType*, %struct.stType** %125, align 8
  %127 = getelementptr inbounds %struct.stType, %struct.stType* %126, i32 0, i32 2
  %128 = getelementptr inbounds [8 x i32], [8 x i32]* %127, i64 0, i64 0
  store i32 3, i32* %128, align 4
  %129 = load %struct.stType**, %struct.stType*** @obj, align 8
  %130 = getelementptr inbounds %struct.stType*, %struct.stType** %129, i64 0
  %131 = load %struct.stType*, %struct.stType** %130, align 8
  %132 = getelementptr inbounds %struct.stType, %struct.stType* %131, i32 0, i32 2
  %133 = getelementptr inbounds [8 x i32], [8 x i32]* %132, i64 0, i64 1
  store i32 4, i32* %133, align 4
  %134 = load %struct.stType**, %struct.stType*** @obj, align 8
  %135 = getelementptr inbounds %struct.stType*, %struct.stType** %134, i64 0
  %136 = load %struct.stType*, %struct.stType** %135, align 8
  %137 = getelementptr inbounds %struct.stType, %struct.stType* %136, i32 0, i32 2
  %138 = getelementptr inbounds [8 x i32], [8 x i32]* %137, i64 0, i64 2
  store i32 5, i32* %138, align 4
  %139 = load %struct.stType**, %struct.stType*** @obj, align 8
  %140 = getelementptr inbounds %struct.stType*, %struct.stType** %139, i64 3
  %141 = load %struct.stType*, %struct.stType** %140, align 8
  %142 = getelementptr inbounds %struct.stType, %struct.stType* %141, i32 0, i32 0
  %143 = load %struct.COORD*, %struct.COORD** %142, align 8
  %144 = getelementptr inbounds %struct.COORD, %struct.COORD* %143, i32 0, i32 0
  %145 = load i32*, i32** %144, align 8
  %146 = getelementptr inbounds i32, i32* %145, i64 0
  store i32 16, i32* %146, align 4
  %147 = load %struct.stType**, %struct.stType*** @obj, align 8
  %148 = getelementptr inbounds %struct.stType*, %struct.stType** %147, i64 3
  %149 = load %struct.stType*, %struct.stType** %148, align 8
  %150 = getelementptr inbounds %struct.stType, %struct.stType* %149, i32 0, i32 0
  %151 = load %struct.COORD*, %struct.COORD** %150, align 8
  %152 = getelementptr inbounds %struct.COORD, %struct.COORD* %151, i32 0, i32 1
  %153 = load i32*, i32** %152, align 8
  %154 = getelementptr inbounds i32, i32* %153, i64 0
  store i32 17, i32* %154, align 4
  %155 = load %struct.stType**, %struct.stType*** @obj, align 8
  %156 = getelementptr inbounds %struct.stType*, %struct.stType** %155, i64 3
  %157 = load %struct.stType*, %struct.stType** %156, align 8
  %158 = getelementptr inbounds %struct.stType, %struct.stType* %157, i32 0, i32 2
  %159 = getelementptr inbounds [8 x i32], [8 x i32]* %158, i64 0, i64 0
  store i32 18, i32* %159, align 4
  %160 = load %struct.stType**, %struct.stType*** @obj, align 8
  %161 = getelementptr inbounds %struct.stType*, %struct.stType** %160, i64 3
  %162 = load %struct.stType*, %struct.stType** %161, align 8
  %163 = getelementptr inbounds %struct.stType, %struct.stType* %162, i32 0, i32 2
  %164 = getelementptr inbounds [8 x i32], [8 x i32]* %163, i64 0, i64 1
  store i32 19, i32* %164, align 4
  %165 = load %struct.stType**, %struct.stType*** @obj, align 8
  %166 = getelementptr inbounds %struct.stType*, %struct.stType** %165, i64 3
  %167 = load %struct.stType*, %struct.stType** %166, align 8
  %168 = getelementptr inbounds %struct.stType, %struct.stType* %167, i32 0, i32 2
  %169 = getelementptr inbounds [8 x i32], [8 x i32]* %168, i64 0, i64 2
  store i32 20, i32* %169, align 4
  %170 = load %struct.stType**, %struct.stType*** @obj, align 8
  %171 = getelementptr inbounds %struct.stType*, %struct.stType** %170, i64 3
  %172 = load %struct.stType*, %struct.stType** %171, align 8
  %173 = getelementptr inbounds %struct.stType, %struct.stType* %172, i32 0, i32 1
  %174 = getelementptr inbounds [100 x i8], [100 x i8]* %173, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %174, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %228

; <label>:175                                     ; preds = %0
  %176 = load %struct.stType**, %struct.stType*** @obj, align 8
  %177 = getelementptr inbounds %struct.stType*, %struct.stType** %176, i64 0
  %178 = load %struct.stType*, %struct.stType** %177, align 8
  %179 = getelementptr inbounds %struct.stType, %struct.stType* %178, i32 0, i32 0
  %180 = load %struct.COORD*, %struct.COORD** %179, align 8
  %181 = getelementptr inbounds %struct.COORD, %struct.COORD* %180, i32 0, i32 0
  %182 = load i32*, i32** %181, align 8
  %183 = getelementptr inbounds i32, i32* %182, i64 0
  store i32 1, i32* %183, align 4
  %184 = load %struct.stType**, %struct.stType*** @obj, align 8
  %185 = getelementptr inbounds %struct.stType*, %struct.stType** %184, i64 0
  %186 = load %struct.stType*, %struct.stType** %185, align 8
  %187 = getelementptr inbounds %struct.stType, %struct.stType* %186, i32 0, i32 0
  %188 = load %struct.COORD*, %struct.COORD** %187, align 8
  %189 = getelementptr inbounds %struct.COORD, %struct.COORD* %188, i32 0, i32 1
  %190 = load i32*, i32** %189, align 8
  %191 = getelementptr inbounds i32, i32* %190, i64 0
  store i32 2, i32* %191, align 4
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
  br label %228

; <label>:228                                     ; preds = %175, %123
  %229 = load %struct.stType**, %struct.stType*** @obj, align 8
  %230 = getelementptr inbounds %struct.stType*, %struct.stType** %229, i64 0
  %231 = load %struct.stType*, %struct.stType** %230, align 8
  %232 = getelementptr inbounds %struct.stType, %struct.stType* %231, i32 0, i32 1
  %233 = getelementptr inbounds [100 x i8], [100 x i8]* %232, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %233, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %234 = load %struct.stType**, %struct.stType*** @obj, align 8
  %235 = getelementptr inbounds %struct.stType*, %struct.stType** %234, i64 1
  %236 = load %struct.stType*, %struct.stType** %235, align 8
  %237 = getelementptr inbounds %struct.stType, %struct.stType* %236, i32 0, i32 0
  %238 = load %struct.COORD*, %struct.COORD** %237, align 8
  %239 = getelementptr inbounds %struct.COORD, %struct.COORD* %238, i32 0, i32 0
  %240 = load i32*, i32** %239, align 8
  %241 = getelementptr inbounds i32, i32* %240, i64 0
  store i32 6, i32* %241, align 4
  %242 = load %struct.stType**, %struct.stType*** @obj, align 8
  %243 = getelementptr inbounds %struct.stType*, %struct.stType** %242, i64 1
  %244 = load %struct.stType*, %struct.stType** %243, align 8
  %245 = getelementptr inbounds %struct.stType, %struct.stType* %244, i32 0, i32 0
  %246 = load %struct.COORD*, %struct.COORD** %245, align 8
  %247 = getelementptr inbounds %struct.COORD, %struct.COORD* %246, i32 0, i32 1
  %248 = load i32*, i32** %247, align 8
  %249 = getelementptr inbounds i32, i32* %248, i64 0
  store i32 7, i32* %249, align 4
  %250 = load %struct.stType**, %struct.stType*** @obj, align 8
  %251 = getelementptr inbounds %struct.stType*, %struct.stType** %250, i64 1
  %252 = load %struct.stType*, %struct.stType** %251, align 8
  %253 = getelementptr inbounds %struct.stType, %struct.stType* %252, i32 0, i32 2
  %254 = getelementptr inbounds [8 x i32], [8 x i32]* %253, i64 0, i64 0
  store i32 8, i32* %254, align 4
  %255 = load %struct.stType**, %struct.stType*** @obj, align 8
  %256 = getelementptr inbounds %struct.stType*, %struct.stType** %255, i64 1
  %257 = load %struct.stType*, %struct.stType** %256, align 8
  %258 = getelementptr inbounds %struct.stType, %struct.stType* %257, i32 0, i32 2
  %259 = getelementptr inbounds [8 x i32], [8 x i32]* %258, i64 0, i64 1
  store i32 9, i32* %259, align 4
  %260 = load %struct.stType**, %struct.stType*** @obj, align 8
  %261 = getelementptr inbounds %struct.stType*, %struct.stType** %260, i64 1
  %262 = load %struct.stType*, %struct.stType** %261, align 8
  %263 = getelementptr inbounds %struct.stType, %struct.stType* %262, i32 0, i32 2
  %264 = getelementptr inbounds [8 x i32], [8 x i32]* %263, i64 0, i64 2
  store i32 10, i32* %264, align 4
  %265 = load %struct.stType**, %struct.stType*** @obj, align 8
  %266 = getelementptr inbounds %struct.stType*, %struct.stType** %265, i64 1
  %267 = load %struct.stType*, %struct.stType** %266, align 8
  %268 = getelementptr inbounds %struct.stType, %struct.stType* %267, i32 0, i32 1
  %269 = getelementptr inbounds [100 x i8], [100 x i8]* %268, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %269, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %270 = call noalias i8* @malloc(i64 144) #6
  %271 = bitcast i8* %270 to %struct.stType*
  %272 = load %struct.stType**, %struct.stType*** @obj, align 8
  %273 = getelementptr inbounds %struct.stType*, %struct.stType** %272, i64 2
  store %struct.stType* %271, %struct.stType** %273, align 8
  %274 = call noalias i8* @malloc(i64 16) #6
  %275 = bitcast i8* %274 to %struct.COORD*
  %276 = load %struct.stType**, %struct.stType*** @obj, align 8
  %277 = getelementptr inbounds %struct.stType*, %struct.stType** %276, i64 2
  %278 = load %struct.stType*, %struct.stType** %277, align 8
  %279 = getelementptr inbounds %struct.stType, %struct.stType* %278, i32 0, i32 0
  store %struct.COORD* %275, %struct.COORD** %279, align 8
  %280 = call noalias i8* @malloc(i64 4) #6
  %281 = bitcast i8* %280 to i32*
  %282 = load %struct.stType**, %struct.stType*** @obj, align 8
  %283 = getelementptr inbounds %struct.stType*, %struct.stType** %282, i64 2
  %284 = load %struct.stType*, %struct.stType** %283, align 8
  %285 = getelementptr inbounds %struct.stType, %struct.stType* %284, i32 0, i32 0
  %286 = load %struct.COORD*, %struct.COORD** %285, align 8
  %287 = getelementptr inbounds %struct.COORD, %struct.COORD* %286, i32 0, i32 0
  store i32* %281, i32** %287, align 8
  %288 = call noalias i8* @malloc(i64 4) #6
  %289 = bitcast i8* %288 to i32*
  %290 = load %struct.stType**, %struct.stType*** @obj, align 8
  %291 = getelementptr inbounds %struct.stType*, %struct.stType** %290, i64 2
  %292 = load %struct.stType*, %struct.stType** %291, align 8
  %293 = getelementptr inbounds %struct.stType, %struct.stType* %292, i32 0, i32 0
  %294 = load %struct.COORD*, %struct.COORD** %293, align 8
  %295 = getelementptr inbounds %struct.COORD, %struct.COORD* %294, i32 0, i32 1
  store i32* %289, i32** %295, align 8
  %296 = load %struct.stType**, %struct.stType*** @obj, align 8
  %297 = getelementptr inbounds %struct.stType*, %struct.stType** %296, i64 2
  %298 = load %struct.stType*, %struct.stType** %297, align 8
  %299 = getelementptr inbounds %struct.stType, %struct.stType* %298, i32 0, i32 0
  %300 = load %struct.COORD*, %struct.COORD** %299, align 8
  %301 = getelementptr inbounds %struct.COORD, %struct.COORD* %300, i32 0, i32 0
  %302 = load i32*, i32** %301, align 8
  %303 = getelementptr inbounds i32, i32* %302, i64 0
  store i32 11, i32* %303, align 4
  %304 = load %struct.stType**, %struct.stType*** @obj, align 8
  %305 = getelementptr inbounds %struct.stType*, %struct.stType** %304, i64 2
  %306 = load %struct.stType*, %struct.stType** %305, align 8
  %307 = getelementptr inbounds %struct.stType, %struct.stType* %306, i32 0, i32 0
  %308 = load %struct.COORD*, %struct.COORD** %307, align 8
  %309 = getelementptr inbounds %struct.COORD, %struct.COORD* %308, i32 0, i32 1
  %310 = load i32*, i32** %309, align 8
  %311 = getelementptr inbounds i32, i32* %310, i64 0
  store i32 12, i32* %311, align 4
  %312 = load %struct.stType**, %struct.stType*** @obj, align 8
  %313 = getelementptr inbounds %struct.stType*, %struct.stType** %312, i64 2
  %314 = load %struct.stType*, %struct.stType** %313, align 8
  %315 = getelementptr inbounds %struct.stType, %struct.stType* %314, i32 0, i32 2
  %316 = getelementptr inbounds [8 x i32], [8 x i32]* %315, i64 0, i64 0
  store i32 13, i32* %316, align 4
  %317 = load %struct.stType**, %struct.stType*** @obj, align 8
  %318 = getelementptr inbounds %struct.stType*, %struct.stType** %317, i64 2
  %319 = load %struct.stType*, %struct.stType** %318, align 8
  %320 = getelementptr inbounds %struct.stType, %struct.stType* %319, i32 0, i32 2
  %321 = getelementptr inbounds [8 x i32], [8 x i32]* %320, i64 0, i64 1
  store i32 14, i32* %321, align 4
  %322 = load %struct.stType**, %struct.stType*** @obj, align 8
  %323 = getelementptr inbounds %struct.stType*, %struct.stType** %322, i64 2
  %324 = load %struct.stType*, %struct.stType** %323, align 8
  %325 = getelementptr inbounds %struct.stType, %struct.stType* %324, i32 0, i32 2
  %326 = getelementptr inbounds [8 x i32], [8 x i32]* %325, i64 0, i64 2
  store i32 15, i32* %326, align 4
  %327 = load %struct.stType**, %struct.stType*** @obj, align 8
  %328 = getelementptr inbounds %struct.stType*, %struct.stType** %327, i64 2
  %329 = load %struct.stType*, %struct.stType** %328, align 8
  %330 = getelementptr inbounds %struct.stType, %struct.stType* %329, i32 0, i32 1
  %331 = getelementptr inbounds [100 x i8], [100 x i8]* %330, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %331, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  call void @branchPruned()
  call void @branchNotPruned()
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

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
