; ModuleID = 'workdir/inter23t3.bc'
source_filename = "inter23.c"
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
@2 = constant [11 x i8] c"helloWorld\00"
@3 = constant [11 x i8] c"helloWorld\00"
@4 = constant [11 x i8] c"helloWorld\00"

; Function Attrs: noinline nounwind uwtable
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

; <label>:10:                                     ; preds = %0
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

; <label>:20:                                     ; preds = %10
  %21 = load %struct.stType**, %struct.stType*** @obj, align 8
  %22 = getelementptr inbounds %struct.stType*, %struct.stType** %21, i64 0
  %23 = load %struct.stType*, %struct.stType** %22, align 8
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %23, i32 0, i32 1
  %25 = getelementptr inbounds [100 x i8], [100 x i8]* %24, i32 0, i32 0
  %26 = call i32 @strcmp(i8* %25, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %102, label %28

; <label>:28:                                     ; preds = %20
  %29 = load %struct.stType**, %struct.stType*** @obj, align 8
  %30 = getelementptr inbounds %struct.stType*, %struct.stType** %29, i64 0
  %31 = load %struct.stType*, %struct.stType** %30, align 8
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %31, i32 0, i32 1
  %33 = getelementptr inbounds [100 x i8], [100 x i8]* %32, i64 0, i64 4
  %34 = load i8, i8* %33, align 4
  %35 = sext i8 %34 to i32
  %36 = icmp eq i32 %35, 111
  br i1 %36, label %37, label %102

; <label>:37:                                     ; preds = %28
  %38 = load %struct.stType**, %struct.stType*** @obj, align 8
  %39 = getelementptr inbounds %struct.stType*, %struct.stType** %38, i64 0
  %40 = load %struct.stType*, %struct.stType** %39, align 8
  %41 = getelementptr inbounds %struct.stType, %struct.stType* %40, i32 0, i32 1
  %42 = getelementptr inbounds [100 x i8], [100 x i8]* %41, i64 0, i64 9
  %43 = load i8, i8* %42, align 1
  %44 = sext i8 %43 to i32
  %45 = icmp eq i32 %44, 100
  br i1 %45, label %46, label %102

; <label>:46:                                     ; preds = %37
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

; <label>:56:                                     ; preds = %46
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

; <label>:66:                                     ; preds = %56
  %67 = load %struct.stType**, %struct.stType*** @obj, align 8
  %68 = getelementptr inbounds %struct.stType*, %struct.stType** %67, i64 2
  %69 = load %struct.stType*, %struct.stType** %68, align 8
  %70 = getelementptr inbounds %struct.stType, %struct.stType* %69, i32 0, i32 2
  %71 = getelementptr inbounds [8 x i32], [8 x i32]* %70, i64 0, i64 1
  %72 = load i32, i32* %71, align 4
  %73 = icmp eq i32 %72, 14
  br i1 %73, label %74, label %102

; <label>:74:                                     ; preds = %66
  %75 = load %struct.stType**, %struct.stType*** @obj, align 8
  %76 = getelementptr inbounds %struct.stType*, %struct.stType** %75, i64 2
  %77 = load %struct.stType*, %struct.stType** %76, align 8
  %78 = getelementptr inbounds %struct.stType, %struct.stType* %77, i32 0, i32 1
  %79 = getelementptr inbounds [100 x i8], [100 x i8]* %78, i32 0, i32 0
  %80 = call i32 @strcmp(i8* %79, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %81 = icmp ne i32 %80, 0
  br i1 %81, label %102, label %82

; <label>:82:                                     ; preds = %74
  %83 = load %struct.stType**, %struct.stType*** @obj, align 8
  %84 = getelementptr inbounds %struct.stType*, %struct.stType** %83, i64 2
  %85 = load %struct.stType*, %struct.stType** %84, align 8
  %86 = getelementptr inbounds %struct.stType, %struct.stType* %85, i32 0, i32 1
  %87 = getelementptr inbounds [100 x i8], [100 x i8]* %86, i64 0, i64 4
  %88 = load i8, i8* %87, align 4
  %89 = sext i8 %88 to i32
  %90 = icmp eq i32 %89, 111
  br i1 %90, label %91, label %102

; <label>:91:                                     ; preds = %82
  %92 = load %struct.stType**, %struct.stType*** @obj, align 8
  %93 = getelementptr inbounds %struct.stType*, %struct.stType** %92, i64 2
  %94 = load %struct.stType*, %struct.stType** %93, align 8
  %95 = getelementptr inbounds %struct.stType, %struct.stType* %94, i32 0, i32 1
  %96 = getelementptr inbounds [100 x i8], [100 x i8]* %95, i64 0, i64 9
  %97 = load i8, i8* %96, align 1
  %98 = sext i8 %97 to i32
  %99 = icmp eq i32 %98, 100
  br i1 %99, label %100, label %102

; <label>:100:                                    ; preds = %91
  %101 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %102

; <label>:102:                                    ; preds = %100, %91, %82, %74, %66, %56, %46, %37, %28, %20, %10, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned() #0 {
  %1 = load %struct.stType**, %struct.stType*** @obj, align 8
  %2 = getelementptr inbounds %struct.stType*, %struct.stType** %1, i64 0
  %3 = load %struct.stType*, %struct.stType** %2, align 8
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 2
  %5 = getelementptr inbounds [8 x i32], [8 x i32]* %4, i64 0, i64 1
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 4
  br i1 %7, label %8, label %64

; <label>:8:                                      ; preds = %0
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

; <label>:18:                                     ; preds = %8
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

; <label>:28:                                     ; preds = %18
  %29 = load %struct.stType**, %struct.stType*** @obj, align 8
  %30 = getelementptr inbounds %struct.stType*, %struct.stType** %29, i64 3
  %31 = load %struct.stType*, %struct.stType** %30, align 8
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %31, i32 0, i32 2
  %33 = getelementptr inbounds [8 x i32], [8 x i32]* %32, i64 0, i64 1
  %34 = load i32, i32* %33, align 4
  %35 = icmp eq i32 %34, 19
  br i1 %35, label %36, label %64

; <label>:36:                                     ; preds = %28
  %37 = load %struct.stType**, %struct.stType*** @obj, align 8
  %38 = getelementptr inbounds %struct.stType*, %struct.stType** %37, i64 3
  %39 = load %struct.stType*, %struct.stType** %38, align 8
  %40 = getelementptr inbounds %struct.stType, %struct.stType* %39, i32 0, i32 1
  %41 = getelementptr inbounds [100 x i8], [100 x i8]* %40, i32 0, i32 0
  %42 = call i32 @strcmp(i8* %41, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %43 = icmp ne i32 %42, 0
  br i1 %43, label %64, label %44

; <label>:44:                                     ; preds = %36
  %45 = load %struct.stType**, %struct.stType*** @obj, align 8
  %46 = getelementptr inbounds %struct.stType*, %struct.stType** %45, i64 3
  %47 = load %struct.stType*, %struct.stType** %46, align 8
  %48 = getelementptr inbounds %struct.stType, %struct.stType* %47, i32 0, i32 1
  %49 = getelementptr inbounds [100 x i8], [100 x i8]* %48, i64 0, i64 4
  %50 = load i8, i8* %49, align 4
  %51 = sext i8 %50 to i32
  %52 = icmp eq i32 %51, 111
  br i1 %52, label %53, label %64

; <label>:53:                                     ; preds = %44
  %54 = load %struct.stType**, %struct.stType*** @obj, align 8
  %55 = getelementptr inbounds %struct.stType*, %struct.stType** %54, i64 3
  %56 = load %struct.stType*, %struct.stType** %55, align 8
  %57 = getelementptr inbounds %struct.stType, %struct.stType* %56, i32 0, i32 1
  %58 = getelementptr inbounds [100 x i8], [100 x i8]* %57, i64 0, i64 9
  %59 = load i8, i8* %58, align 1
  %60 = sext i8 %59 to i32
  %61 = icmp eq i32 %60, 100
  br i1 %61, label %62, label %64

; <label>:62:                                     ; preds = %53
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0))
  br label %64

; <label>:64:                                     ; preds = %62, %53, %44, %36, %28, %18, %8, %0
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 {
  %3 = call noalias i8* @malloc(i64 160) #6
  %4 = bitcast i8* %3 to %struct.stType**
  store %struct.stType** %4, %struct.stType*** @obj, align 8
  %5 = call noalias i8* @malloc(i64 144) #6
  %6 = bitcast i8* %5 to %struct.stType*
  %7 = load %struct.stType**, %struct.stType*** @obj, align 8
  %8 = getelementptr inbounds %struct.stType*, %struct.stType** %7, i64 0
  store %struct.stType* %6, %struct.stType** %8, align 8
  %9 = call noalias i8* @malloc(i64 16) #6
  %10 = bitcast i8* %9 to %struct.COORD*
  %11 = load %struct.stType**, %struct.stType*** @obj, align 8
  %12 = getelementptr inbounds %struct.stType*, %struct.stType** %11, i64 0
  %13 = load %struct.stType*, %struct.stType** %12, align 8
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %13, i32 0, i32 0
  store %struct.COORD* %10, %struct.COORD** %14, align 8
  %15 = call noalias i8* @malloc(i64 4) #6
  %16 = bitcast i8* %15 to i32*
  %17 = load %struct.stType**, %struct.stType*** @obj, align 8
  %18 = getelementptr inbounds %struct.stType*, %struct.stType** %17, i64 0
  %19 = load %struct.stType*, %struct.stType** %18, align 8
  %20 = getelementptr inbounds %struct.stType, %struct.stType* %19, i32 0, i32 0
  %21 = load %struct.COORD*, %struct.COORD** %20, align 8
  %22 = getelementptr inbounds %struct.COORD, %struct.COORD* %21, i32 0, i32 0
  store i32* %16, i32** %22, align 8
  %23 = call noalias i8* @malloc(i64 4) #6
  %24 = bitcast i8* %23 to i32*
  %25 = load %struct.stType**, %struct.stType*** @obj, align 8
  %26 = getelementptr inbounds %struct.stType*, %struct.stType** %25, i64 0
  %27 = load %struct.stType*, %struct.stType** %26, align 8
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i32 0, i32 0
  %29 = load %struct.COORD*, %struct.COORD** %28, align 8
  %30 = getelementptr inbounds %struct.COORD, %struct.COORD* %29, i32 0, i32 1
  store i32* %24, i32** %30, align 8
  %31 = call noalias i8* @malloc(i64 144) #6
  %32 = bitcast i8* %31 to %struct.stType*
  %33 = load %struct.stType**, %struct.stType*** @obj, align 8
  %34 = getelementptr inbounds %struct.stType*, %struct.stType** %33, i64 3
  store %struct.stType* %32, %struct.stType** %34, align 8
  %35 = call noalias i8* @malloc(i64 16) #6
  %36 = bitcast i8* %35 to %struct.COORD*
  %37 = load %struct.stType**, %struct.stType*** @obj, align 8
  %38 = getelementptr inbounds %struct.stType*, %struct.stType** %37, i64 3
  %39 = load %struct.stType*, %struct.stType** %38, align 8
  %40 = getelementptr inbounds %struct.stType, %struct.stType* %39, i32 0, i32 0
  store %struct.COORD* %36, %struct.COORD** %40, align 8
  %41 = call noalias i8* @malloc(i64 4) #6
  %42 = bitcast i8* %41 to i32*
  %43 = load %struct.stType**, %struct.stType*** @obj, align 8
  %44 = getelementptr inbounds %struct.stType*, %struct.stType** %43, i64 3
  %45 = load %struct.stType*, %struct.stType** %44, align 8
  %46 = getelementptr inbounds %struct.stType, %struct.stType* %45, i32 0, i32 0
  %47 = load %struct.COORD*, %struct.COORD** %46, align 8
  %48 = getelementptr inbounds %struct.COORD, %struct.COORD* %47, i32 0, i32 0
  store i32* %42, i32** %48, align 8
  %49 = call noalias i8* @malloc(i64 4) #6
  %50 = bitcast i8* %49 to i32*
  %51 = load %struct.stType**, %struct.stType*** @obj, align 8
  %52 = getelementptr inbounds %struct.stType*, %struct.stType** %51, i64 3
  %53 = load %struct.stType*, %struct.stType** %52, align 8
  %54 = getelementptr inbounds %struct.stType, %struct.stType* %53, i32 0, i32 0
  %55 = load %struct.COORD*, %struct.COORD** %54, align 8
  %56 = getelementptr inbounds %struct.COORD, %struct.COORD* %55, i32 0, i32 1
  store i32* %50, i32** %56, align 8
  %57 = call noalias i8* @malloc(i64 144) #6
  %58 = bitcast i8* %57 to %struct.stType*
  %59 = load %struct.stType**, %struct.stType*** @obj, align 8
  %60 = getelementptr inbounds %struct.stType*, %struct.stType** %59, i64 1
  store %struct.stType* %58, %struct.stType** %60, align 8
  %61 = call noalias i8* @malloc(i64 16) #6
  %62 = bitcast i8* %61 to %struct.COORD*
  %63 = load %struct.stType**, %struct.stType*** @obj, align 8
  %64 = getelementptr inbounds %struct.stType*, %struct.stType** %63, i64 1
  %65 = load %struct.stType*, %struct.stType** %64, align 8
  %66 = getelementptr inbounds %struct.stType, %struct.stType* %65, i32 0, i32 0
  store %struct.COORD* %62, %struct.COORD** %66, align 8
  %67 = call noalias i8* @malloc(i64 4) #6
  %68 = bitcast i8* %67 to i32*
  %69 = load %struct.stType**, %struct.stType*** @obj, align 8
  %70 = getelementptr inbounds %struct.stType*, %struct.stType** %69, i64 1
  %71 = load %struct.stType*, %struct.stType** %70, align 8
  %72 = getelementptr inbounds %struct.stType, %struct.stType* %71, i32 0, i32 0
  %73 = load %struct.COORD*, %struct.COORD** %72, align 8
  %74 = getelementptr inbounds %struct.COORD, %struct.COORD* %73, i32 0, i32 0
  store i32* %68, i32** %74, align 8
  %75 = call noalias i8* @malloc(i64 4) #6
  %76 = bitcast i8* %75 to i32*
  %77 = load %struct.stType**, %struct.stType*** @obj, align 8
  %78 = getelementptr inbounds %struct.stType*, %struct.stType** %77, i64 1
  %79 = load %struct.stType*, %struct.stType** %78, align 8
  %80 = getelementptr inbounds %struct.stType, %struct.stType* %79, i32 0, i32 0
  %81 = load %struct.COORD*, %struct.COORD** %80, align 8
  %82 = getelementptr inbounds %struct.COORD, %struct.COORD* %81, i32 0, i32 1
  store i32* %76, i32** %82, align 8
  %83 = icmp sgt i32 %0, 2
  %84 = load %struct.stType**, %struct.stType*** @obj, align 8
  %85 = getelementptr inbounds %struct.stType*, %struct.stType** %84, i64 0
  %86 = load %struct.stType*, %struct.stType** %85, align 8
  %87 = getelementptr inbounds %struct.stType, %struct.stType* %86, i32 0, i32 0
  %88 = load %struct.COORD*, %struct.COORD** %87, align 8
  %89 = getelementptr inbounds %struct.COORD, %struct.COORD* %88, i32 0, i32 0
  %90 = load i32*, i32** %89, align 8
  %91 = getelementptr inbounds i32, i32* %90, i64 0
  store i32 1, i32* %91, align 4
  %92 = load %struct.stType**, %struct.stType*** @obj, align 8
  %93 = getelementptr inbounds %struct.stType*, %struct.stType** %92, i64 0
  %94 = load %struct.stType*, %struct.stType** %93, align 8
  %95 = getelementptr inbounds %struct.stType, %struct.stType* %94, i32 0, i32 0
  %96 = load %struct.COORD*, %struct.COORD** %95, align 8
  %97 = getelementptr inbounds %struct.COORD, %struct.COORD* %96, i32 0, i32 1
  %98 = load i32*, i32** %97, align 8
  %99 = getelementptr inbounds i32, i32* %98, i64 0
  store i32 2, i32* %99, align 4
  %100 = load %struct.stType**, %struct.stType*** @obj, align 8
  br i1 %83, label %101, label %152

; <label>:101:                                    ; preds = %2
  %102 = getelementptr inbounds %struct.stType*, %struct.stType** %100, i64 0
  %103 = load %struct.stType*, %struct.stType** %102, align 8
  %104 = getelementptr inbounds %struct.stType, %struct.stType* %103, i32 0, i32 2
  %105 = getelementptr inbounds [8 x i32], [8 x i32]* %104, i64 0, i64 0
  store i32 3, i32* %105, align 4
  %106 = load %struct.stType**, %struct.stType*** @obj, align 8
  %107 = getelementptr inbounds %struct.stType*, %struct.stType** %106, i64 0
  %108 = load %struct.stType*, %struct.stType** %107, align 8
  %109 = getelementptr inbounds %struct.stType, %struct.stType* %108, i32 0, i32 2
  %110 = getelementptr inbounds [8 x i32], [8 x i32]* %109, i64 0, i64 1
  store i32 4, i32* %110, align 4
  %111 = load %struct.stType**, %struct.stType*** @obj, align 8
  %112 = getelementptr inbounds %struct.stType*, %struct.stType** %111, i64 0
  %113 = load %struct.stType*, %struct.stType** %112, align 8
  %114 = getelementptr inbounds %struct.stType, %struct.stType* %113, i32 0, i32 2
  %115 = getelementptr inbounds [8 x i32], [8 x i32]* %114, i64 0, i64 2
  store i32 5, i32* %115, align 4
  %116 = load %struct.stType**, %struct.stType*** @obj, align 8
  %117 = getelementptr inbounds %struct.stType*, %struct.stType** %116, i64 3
  %118 = load %struct.stType*, %struct.stType** %117, align 8
  %119 = getelementptr inbounds %struct.stType, %struct.stType* %118, i32 0, i32 0
  %120 = load %struct.COORD*, %struct.COORD** %119, align 8
  %121 = getelementptr inbounds %struct.COORD, %struct.COORD* %120, i32 0, i32 0
  %122 = load i32*, i32** %121, align 8
  %123 = getelementptr inbounds i32, i32* %122, i64 0
  store i32 16, i32* %123, align 4
  %124 = load %struct.stType**, %struct.stType*** @obj, align 8
  %125 = getelementptr inbounds %struct.stType*, %struct.stType** %124, i64 3
  %126 = load %struct.stType*, %struct.stType** %125, align 8
  %127 = getelementptr inbounds %struct.stType, %struct.stType* %126, i32 0, i32 0
  %128 = load %struct.COORD*, %struct.COORD** %127, align 8
  %129 = getelementptr inbounds %struct.COORD, %struct.COORD* %128, i32 0, i32 1
  %130 = load i32*, i32** %129, align 8
  %131 = getelementptr inbounds i32, i32* %130, i64 0
  store i32 17, i32* %131, align 4
  %132 = load %struct.stType**, %struct.stType*** @obj, align 8
  %133 = getelementptr inbounds %struct.stType*, %struct.stType** %132, i64 3
  %134 = load %struct.stType*, %struct.stType** %133, align 8
  %135 = getelementptr inbounds %struct.stType, %struct.stType* %134, i32 0, i32 2
  %136 = getelementptr inbounds [8 x i32], [8 x i32]* %135, i64 0, i64 0
  store i32 18, i32* %136, align 4
  %137 = load %struct.stType**, %struct.stType*** @obj, align 8
  %138 = getelementptr inbounds %struct.stType*, %struct.stType** %137, i64 3
  %139 = load %struct.stType*, %struct.stType** %138, align 8
  %140 = getelementptr inbounds %struct.stType, %struct.stType* %139, i32 0, i32 2
  %141 = getelementptr inbounds [8 x i32], [8 x i32]* %140, i64 0, i64 1
  store i32 19, i32* %141, align 4
  %142 = load %struct.stType**, %struct.stType*** @obj, align 8
  %143 = getelementptr inbounds %struct.stType*, %struct.stType** %142, i64 3
  %144 = load %struct.stType*, %struct.stType** %143, align 8
  %145 = getelementptr inbounds %struct.stType, %struct.stType* %144, i32 0, i32 2
  %146 = getelementptr inbounds [8 x i32], [8 x i32]* %145, i64 0, i64 2
  store i32 20, i32* %146, align 4
  %147 = load %struct.stType**, %struct.stType*** @obj, align 8
  %148 = getelementptr inbounds %struct.stType*, %struct.stType** %147, i64 3
  %149 = load %struct.stType*, %struct.stType** %148, align 8
  %150 = getelementptr inbounds %struct.stType, %struct.stType* %149, i32 0, i32 1
  %151 = getelementptr inbounds [100 x i8], [100 x i8]* %150, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %151, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %188

; <label>:152:                                    ; preds = %2
  %153 = getelementptr inbounds %struct.stType*, %struct.stType** %100, i64 1
  %154 = load %struct.stType*, %struct.stType** %153, align 8
  %155 = getelementptr inbounds %struct.stType, %struct.stType* %154, i32 0, i32 0
  %156 = load %struct.COORD*, %struct.COORD** %155, align 8
  %157 = getelementptr inbounds %struct.COORD, %struct.COORD* %156, i32 0, i32 0
  %158 = load i32*, i32** %157, align 8
  %159 = getelementptr inbounds i32, i32* %158, i64 0
  store i32 6, i32* %159, align 4
  %160 = load %struct.stType**, %struct.stType*** @obj, align 8
  %161 = getelementptr inbounds %struct.stType*, %struct.stType** %160, i64 1
  %162 = load %struct.stType*, %struct.stType** %161, align 8
  %163 = getelementptr inbounds %struct.stType, %struct.stType* %162, i32 0, i32 0
  %164 = load %struct.COORD*, %struct.COORD** %163, align 8
  %165 = getelementptr inbounds %struct.COORD, %struct.COORD* %164, i32 0, i32 1
  %166 = load i32*, i32** %165, align 8
  %167 = getelementptr inbounds i32, i32* %166, i64 0
  store i32 7, i32* %167, align 4
  %168 = load %struct.stType**, %struct.stType*** @obj, align 8
  %169 = getelementptr inbounds %struct.stType*, %struct.stType** %168, i64 1
  %170 = load %struct.stType*, %struct.stType** %169, align 8
  %171 = getelementptr inbounds %struct.stType, %struct.stType* %170, i32 0, i32 2
  %172 = getelementptr inbounds [8 x i32], [8 x i32]* %171, i64 0, i64 0
  store i32 8, i32* %172, align 4
  %173 = load %struct.stType**, %struct.stType*** @obj, align 8
  %174 = getelementptr inbounds %struct.stType*, %struct.stType** %173, i64 1
  %175 = load %struct.stType*, %struct.stType** %174, align 8
  %176 = getelementptr inbounds %struct.stType, %struct.stType* %175, i32 0, i32 2
  %177 = getelementptr inbounds [8 x i32], [8 x i32]* %176, i64 0, i64 1
  store i32 9, i32* %177, align 4
  %178 = load %struct.stType**, %struct.stType*** @obj, align 8
  %179 = getelementptr inbounds %struct.stType*, %struct.stType** %178, i64 1
  %180 = load %struct.stType*, %struct.stType** %179, align 8
  %181 = getelementptr inbounds %struct.stType, %struct.stType* %180, i32 0, i32 2
  %182 = getelementptr inbounds [8 x i32], [8 x i32]* %181, i64 0, i64 2
  store i32 10, i32* %182, align 4
  %183 = load %struct.stType**, %struct.stType*** @obj, align 8
  %184 = getelementptr inbounds %struct.stType*, %struct.stType** %183, i64 1
  %185 = load %struct.stType*, %struct.stType** %184, align 8
  %186 = getelementptr inbounds %struct.stType, %struct.stType* %185, i32 0, i32 1
  %187 = getelementptr inbounds [100 x i8], [100 x i8]* %186, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %187, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %188

; <label>:188:                                    ; preds = %152, %101
  %189 = load %struct.stType**, %struct.stType*** @obj, align 8
  %190 = getelementptr inbounds %struct.stType*, %struct.stType** %189, i64 0
  %191 = load %struct.stType*, %struct.stType** %190, align 8
  %192 = getelementptr inbounds %struct.stType, %struct.stType* %191, i32 0, i32 1
  %193 = getelementptr inbounds [100 x i8], [100 x i8]* %192, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %193, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %194 = load %struct.stType**, %struct.stType*** @obj, align 8
  %195 = getelementptr inbounds %struct.stType*, %struct.stType** %194, i64 1
  %196 = load %struct.stType*, %struct.stType** %195, align 8
  %197 = getelementptr inbounds %struct.stType, %struct.stType* %196, i32 0, i32 0
  %198 = load %struct.COORD*, %struct.COORD** %197, align 8
  %199 = getelementptr inbounds %struct.COORD, %struct.COORD* %198, i32 0, i32 0
  %200 = load i32*, i32** %199, align 8
  %201 = getelementptr inbounds i32, i32* %200, i64 0
  store i32 6, i32* %201, align 4
  %202 = load %struct.stType**, %struct.stType*** @obj, align 8
  %203 = getelementptr inbounds %struct.stType*, %struct.stType** %202, i64 1
  %204 = load %struct.stType*, %struct.stType** %203, align 8
  %205 = getelementptr inbounds %struct.stType, %struct.stType* %204, i32 0, i32 0
  %206 = load %struct.COORD*, %struct.COORD** %205, align 8
  %207 = getelementptr inbounds %struct.COORD, %struct.COORD* %206, i32 0, i32 1
  %208 = load i32*, i32** %207, align 8
  %209 = getelementptr inbounds i32, i32* %208, i64 0
  store i32 7, i32* %209, align 4
  %210 = load %struct.stType**, %struct.stType*** @obj, align 8
  %211 = getelementptr inbounds %struct.stType*, %struct.stType** %210, i64 1
  %212 = load %struct.stType*, %struct.stType** %211, align 8
  %213 = getelementptr inbounds %struct.stType, %struct.stType* %212, i32 0, i32 2
  %214 = getelementptr inbounds [8 x i32], [8 x i32]* %213, i64 0, i64 0
  store i32 8, i32* %214, align 4
  %215 = load %struct.stType**, %struct.stType*** @obj, align 8
  %216 = getelementptr inbounds %struct.stType*, %struct.stType** %215, i64 1
  %217 = load %struct.stType*, %struct.stType** %216, align 8
  %218 = getelementptr inbounds %struct.stType, %struct.stType* %217, i32 0, i32 2
  %219 = getelementptr inbounds [8 x i32], [8 x i32]* %218, i64 0, i64 1
  store i32 9, i32* %219, align 4
  %220 = load %struct.stType**, %struct.stType*** @obj, align 8
  %221 = getelementptr inbounds %struct.stType*, %struct.stType** %220, i64 1
  %222 = load %struct.stType*, %struct.stType** %221, align 8
  %223 = getelementptr inbounds %struct.stType, %struct.stType* %222, i32 0, i32 2
  %224 = getelementptr inbounds [8 x i32], [8 x i32]* %223, i64 0, i64 2
  store i32 10, i32* %224, align 4
  %225 = load %struct.stType**, %struct.stType*** @obj, align 8
  %226 = getelementptr inbounds %struct.stType*, %struct.stType** %225, i64 1
  %227 = load %struct.stType*, %struct.stType** %226, align 8
  %228 = getelementptr inbounds %struct.stType, %struct.stType* %227, i32 0, i32 1
  %229 = getelementptr inbounds [100 x i8], [100 x i8]* %228, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %229, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %230 = call noalias i8* @malloc(i64 144) #6
  %231 = bitcast i8* %230 to %struct.stType*
  %232 = load %struct.stType**, %struct.stType*** @obj, align 8
  %233 = getelementptr inbounds %struct.stType*, %struct.stType** %232, i64 2
  store %struct.stType* %231, %struct.stType** %233, align 8
  %234 = call noalias i8* @malloc(i64 16) #6
  %235 = bitcast i8* %234 to %struct.COORD*
  %236 = load %struct.stType**, %struct.stType*** @obj, align 8
  %237 = getelementptr inbounds %struct.stType*, %struct.stType** %236, i64 2
  %238 = load %struct.stType*, %struct.stType** %237, align 8
  %239 = getelementptr inbounds %struct.stType, %struct.stType* %238, i32 0, i32 0
  store %struct.COORD* %235, %struct.COORD** %239, align 8
  %240 = call noalias i8* @malloc(i64 4) #6
  %241 = bitcast i8* %240 to i32*
  %242 = load %struct.stType**, %struct.stType*** @obj, align 8
  %243 = getelementptr inbounds %struct.stType*, %struct.stType** %242, i64 2
  %244 = load %struct.stType*, %struct.stType** %243, align 8
  %245 = getelementptr inbounds %struct.stType, %struct.stType* %244, i32 0, i32 0
  %246 = load %struct.COORD*, %struct.COORD** %245, align 8
  %247 = getelementptr inbounds %struct.COORD, %struct.COORD* %246, i32 0, i32 0
  store i32* %241, i32** %247, align 8
  %248 = call noalias i8* @malloc(i64 4) #6
  %249 = bitcast i8* %248 to i32*
  %250 = load %struct.stType**, %struct.stType*** @obj, align 8
  %251 = getelementptr inbounds %struct.stType*, %struct.stType** %250, i64 2
  %252 = load %struct.stType*, %struct.stType** %251, align 8
  %253 = getelementptr inbounds %struct.stType, %struct.stType* %252, i32 0, i32 0
  %254 = load %struct.COORD*, %struct.COORD** %253, align 8
  %255 = getelementptr inbounds %struct.COORD, %struct.COORD* %254, i32 0, i32 1
  store i32* %249, i32** %255, align 8
  %256 = load %struct.stType**, %struct.stType*** @obj, align 8
  %257 = getelementptr inbounds %struct.stType*, %struct.stType** %256, i64 2
  %258 = load %struct.stType*, %struct.stType** %257, align 8
  %259 = getelementptr inbounds %struct.stType, %struct.stType* %258, i32 0, i32 0
  %260 = load %struct.COORD*, %struct.COORD** %259, align 8
  %261 = getelementptr inbounds %struct.COORD, %struct.COORD* %260, i32 0, i32 0
  %262 = load i32*, i32** %261, align 8
  %263 = getelementptr inbounds i32, i32* %262, i64 0
  store i32 11, i32* %263, align 4
  %264 = load %struct.stType**, %struct.stType*** @obj, align 8
  %265 = getelementptr inbounds %struct.stType*, %struct.stType** %264, i64 2
  %266 = load %struct.stType*, %struct.stType** %265, align 8
  %267 = getelementptr inbounds %struct.stType, %struct.stType* %266, i32 0, i32 0
  %268 = load %struct.COORD*, %struct.COORD** %267, align 8
  %269 = getelementptr inbounds %struct.COORD, %struct.COORD* %268, i32 0, i32 1
  %270 = load i32*, i32** %269, align 8
  %271 = getelementptr inbounds i32, i32* %270, i64 0
  store i32 12, i32* %271, align 4
  %272 = load %struct.stType**, %struct.stType*** @obj, align 8
  %273 = getelementptr inbounds %struct.stType*, %struct.stType** %272, i64 2
  %274 = load %struct.stType*, %struct.stType** %273, align 8
  %275 = getelementptr inbounds %struct.stType, %struct.stType* %274, i32 0, i32 2
  %276 = getelementptr inbounds [8 x i32], [8 x i32]* %275, i64 0, i64 0
  store i32 13, i32* %276, align 4
  %277 = load %struct.stType**, %struct.stType*** @obj, align 8
  %278 = getelementptr inbounds %struct.stType*, %struct.stType** %277, i64 2
  %279 = load %struct.stType*, %struct.stType** %278, align 8
  %280 = getelementptr inbounds %struct.stType, %struct.stType* %279, i32 0, i32 2
  %281 = getelementptr inbounds [8 x i32], [8 x i32]* %280, i64 0, i64 1
  store i32 14, i32* %281, align 4
  %282 = load %struct.stType**, %struct.stType*** @obj, align 8
  %283 = getelementptr inbounds %struct.stType*, %struct.stType** %282, i64 2
  %284 = load %struct.stType*, %struct.stType** %283, align 8
  %285 = getelementptr inbounds %struct.stType, %struct.stType* %284, i32 0, i32 2
  %286 = getelementptr inbounds [8 x i32], [8 x i32]* %285, i64 0, i64 2
  store i32 15, i32* %286, align 4
  %287 = load %struct.stType**, %struct.stType*** @obj, align 8
  %288 = getelementptr inbounds %struct.stType*, %struct.stType** %287, i64 2
  %289 = load %struct.stType*, %struct.stType** %288, align 8
  %290 = getelementptr inbounds %struct.stType, %struct.stType* %289, i32 0, i32 1
  %291 = getelementptr inbounds [100 x i8], [100 x i8]* %290, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %291, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  call void @branchPruned_clone()
  call void @branchNotPruned_clone()
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #4

; Function Attrs: noinline nounwind uwtable
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
  br i1 true, label %10, label %106

; <label>:10:                                     ; preds = %0
  %11 = load %struct.stType**, %struct.stType*** @obj, align 8
  %12 = getelementptr inbounds %struct.stType*, %struct.stType** %11, i64 0
  %13 = load %struct.stType*, %struct.stType** %12, align 8
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %13, i32 0, i32 0
  %15 = load %struct.COORD*, %struct.COORD** %14, align 8
  %16 = getelementptr inbounds %struct.COORD, %struct.COORD* %15, i32 0, i32 1
  %17 = load i32*, i32** %16, align 8
  %18 = load i32, i32* %17, align 4
  %19 = icmp eq i32 2, 2
  br i1 true, label %20, label %106

; <label>:20:                                     ; preds = %10
  %21 = load %struct.stType**, %struct.stType*** @obj, align 8
  %22 = getelementptr inbounds %struct.stType*, %struct.stType** %21, i64 0
  %23 = load %struct.stType*, %struct.stType** %22, align 8
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %23, i32 0, i32 1
  %25 = getelementptr inbounds [100 x i8], [100 x i8]* %24, i32 0, i32 0
  %26 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %27 = getelementptr [11 x i8], [11 x i8]* @1, i64 0, i64 0
  %28 = call i32 @strcmp(i8* %26, i8* %27) #5
  %29 = icmp ne i32 0, 0
  br i1 false, label %106, label %30

; <label>:30:                                     ; preds = %20
  %31 = load %struct.stType**, %struct.stType*** @obj, align 8
  %32 = getelementptr inbounds %struct.stType*, %struct.stType** %31, i64 0
  %33 = load %struct.stType*, %struct.stType** %32, align 8
  %34 = getelementptr inbounds %struct.stType, %struct.stType* %33, i32 0, i32 1
  %35 = getelementptr inbounds [100 x i8], [100 x i8]* %34, i64 0, i64 4
  %36 = load i8, i8* %35, align 4
  %37 = sext i8 111 to i32
  %38 = icmp eq i32 111, 111
  br i1 true, label %39, label %106

; <label>:39:                                     ; preds = %30
  %40 = load %struct.stType**, %struct.stType*** @obj, align 8
  %41 = getelementptr inbounds %struct.stType*, %struct.stType** %40, i64 0
  %42 = load %struct.stType*, %struct.stType** %41, align 8
  %43 = getelementptr inbounds %struct.stType, %struct.stType* %42, i32 0, i32 1
  %44 = getelementptr inbounds [100 x i8], [100 x i8]* %43, i64 0, i64 9
  %45 = load i8, i8* %44, align 1
  %46 = sext i8 100 to i32
  %47 = icmp eq i32 100, 100
  br i1 true, label %48, label %106

; <label>:48:                                     ; preds = %39
  %49 = load %struct.stType**, %struct.stType*** @obj, align 8
  %50 = getelementptr inbounds %struct.stType*, %struct.stType** %49, i64 2
  %51 = load %struct.stType*, %struct.stType** %50, align 8
  %52 = getelementptr inbounds %struct.stType, %struct.stType* %51, i32 0, i32 0
  %53 = load %struct.COORD*, %struct.COORD** %52, align 8
  %54 = getelementptr inbounds %struct.COORD, %struct.COORD* %53, i32 0, i32 0
  %55 = load i32*, i32** %54, align 8
  %56 = load i32, i32* %55, align 4
  %57 = icmp eq i32 11, 11
  br i1 true, label %58, label %106

; <label>:58:                                     ; preds = %48
  %59 = load %struct.stType**, %struct.stType*** @obj, align 8
  %60 = getelementptr inbounds %struct.stType*, %struct.stType** %59, i64 2
  %61 = load %struct.stType*, %struct.stType** %60, align 8
  %62 = getelementptr inbounds %struct.stType, %struct.stType* %61, i32 0, i32 0
  %63 = load %struct.COORD*, %struct.COORD** %62, align 8
  %64 = getelementptr inbounds %struct.COORD, %struct.COORD* %63, i32 0, i32 1
  %65 = load i32*, i32** %64, align 8
  %66 = load i32, i32* %65, align 4
  %67 = icmp eq i32 12, 12
  br i1 true, label %68, label %106

; <label>:68:                                     ; preds = %58
  %69 = load %struct.stType**, %struct.stType*** @obj, align 8
  %70 = getelementptr inbounds %struct.stType*, %struct.stType** %69, i64 2
  %71 = load %struct.stType*, %struct.stType** %70, align 8
  %72 = getelementptr inbounds %struct.stType, %struct.stType* %71, i32 0, i32 2
  %73 = getelementptr inbounds [8 x i32], [8 x i32]* %72, i64 0, i64 1
  %74 = load i32, i32* %73, align 4
  %75 = icmp eq i32 14, 14
  br i1 true, label %76, label %106

; <label>:76:                                     ; preds = %68
  %77 = load %struct.stType**, %struct.stType*** @obj, align 8
  %78 = getelementptr inbounds %struct.stType*, %struct.stType** %77, i64 2
  %79 = load %struct.stType*, %struct.stType** %78, align 8
  %80 = getelementptr inbounds %struct.stType, %struct.stType* %79, i32 0, i32 1
  %81 = getelementptr inbounds [100 x i8], [100 x i8]* %80, i32 0, i32 0
  %82 = getelementptr [11 x i8], [11 x i8]* @2, i64 0, i64 0
  %83 = getelementptr [11 x i8], [11 x i8]* @3, i64 0, i64 0
  %84 = call i32 @strcmp(i8* %82, i8* %83) #5
  %85 = icmp ne i32 0, 0
  br i1 false, label %106, label %86

; <label>:86:                                     ; preds = %76
  %87 = load %struct.stType**, %struct.stType*** @obj, align 8
  %88 = getelementptr inbounds %struct.stType*, %struct.stType** %87, i64 2
  %89 = load %struct.stType*, %struct.stType** %88, align 8
  %90 = getelementptr inbounds %struct.stType, %struct.stType* %89, i32 0, i32 1
  %91 = getelementptr inbounds [100 x i8], [100 x i8]* %90, i64 0, i64 4
  %92 = load i8, i8* %91, align 4
  %93 = sext i8 111 to i32
  %94 = icmp eq i32 111, 111
  br i1 true, label %95, label %106

; <label>:95:                                     ; preds = %86
  %96 = load %struct.stType**, %struct.stType*** @obj, align 8
  %97 = getelementptr inbounds %struct.stType*, %struct.stType** %96, i64 2
  %98 = load %struct.stType*, %struct.stType** %97, align 8
  %99 = getelementptr inbounds %struct.stType, %struct.stType* %98, i32 0, i32 1
  %100 = getelementptr inbounds [100 x i8], [100 x i8]* %99, i64 0, i64 9
  %101 = load i8, i8* %100, align 1
  %102 = sext i8 100 to i32
  %103 = icmp eq i32 100, 100
  br i1 true, label %104, label %106

; <label>:104:                                    ; preds = %95
  %105 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %106

; <label>:106:                                    ; preds = %104, %95, %86, %76, %68, %58, %48, %39, %30, %20, %10, %0
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned_clone() #0 {
  %1 = load %struct.stType**, %struct.stType*** @obj, align 8
  %2 = getelementptr inbounds %struct.stType*, %struct.stType** %1, i64 0
  %3 = load %struct.stType*, %struct.stType** %2, align 8
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 2
  %5 = getelementptr inbounds [8 x i32], [8 x i32]* %4, i64 0, i64 1
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 4
  br i1 %7, label %8, label %65

; <label>:8:                                      ; preds = %0
  %9 = load %struct.stType**, %struct.stType*** @obj, align 8
  %10 = getelementptr inbounds %struct.stType*, %struct.stType** %9, i64 3
  %11 = load %struct.stType*, %struct.stType** %10, align 8
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 0
  %13 = load %struct.COORD*, %struct.COORD** %12, align 8
  %14 = getelementptr inbounds %struct.COORD, %struct.COORD* %13, i32 0, i32 0
  %15 = load i32*, i32** %14, align 8
  %16 = load i32, i32* %15, align 4
  %17 = icmp eq i32 %16, 16
  br i1 %17, label %18, label %65

; <label>:18:                                     ; preds = %8
  %19 = load %struct.stType**, %struct.stType*** @obj, align 8
  %20 = getelementptr inbounds %struct.stType*, %struct.stType** %19, i64 3
  %21 = load %struct.stType*, %struct.stType** %20, align 8
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %21, i32 0, i32 0
  %23 = load %struct.COORD*, %struct.COORD** %22, align 8
  %24 = getelementptr inbounds %struct.COORD, %struct.COORD* %23, i32 0, i32 1
  %25 = load i32*, i32** %24, align 8
  %26 = load i32, i32* %25, align 4
  %27 = icmp eq i32 %26, 17
  br i1 %27, label %28, label %65

; <label>:28:                                     ; preds = %18
  %29 = load %struct.stType**, %struct.stType*** @obj, align 8
  %30 = getelementptr inbounds %struct.stType*, %struct.stType** %29, i64 3
  %31 = load %struct.stType*, %struct.stType** %30, align 8
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %31, i32 0, i32 2
  %33 = getelementptr inbounds [8 x i32], [8 x i32]* %32, i64 0, i64 1
  %34 = load i32, i32* %33, align 4
  %35 = icmp eq i32 %34, 19
  br i1 %35, label %36, label %65

; <label>:36:                                     ; preds = %28
  %37 = load %struct.stType**, %struct.stType*** @obj, align 8
  %38 = getelementptr inbounds %struct.stType*, %struct.stType** %37, i64 3
  %39 = load %struct.stType*, %struct.stType** %38, align 8
  %40 = getelementptr inbounds %struct.stType, %struct.stType* %39, i32 0, i32 1
  %41 = getelementptr inbounds [100 x i8], [100 x i8]* %40, i32 0, i32 0
  %42 = getelementptr [11 x i8], [11 x i8]* @4, i64 0, i64 0
  %43 = call i32 @strcmp(i8* %41, i8* %42) #5
  %44 = icmp ne i32 %43, 0
  br i1 %44, label %65, label %45

; <label>:45:                                     ; preds = %36
  %46 = load %struct.stType**, %struct.stType*** @obj, align 8
  %47 = getelementptr inbounds %struct.stType*, %struct.stType** %46, i64 3
  %48 = load %struct.stType*, %struct.stType** %47, align 8
  %49 = getelementptr inbounds %struct.stType, %struct.stType* %48, i32 0, i32 1
  %50 = getelementptr inbounds [100 x i8], [100 x i8]* %49, i64 0, i64 4
  %51 = load i8, i8* %50, align 4
  %52 = sext i8 %51 to i32
  %53 = icmp eq i32 %52, 111
  br i1 %53, label %54, label %65

; <label>:54:                                     ; preds = %45
  %55 = load %struct.stType**, %struct.stType*** @obj, align 8
  %56 = getelementptr inbounds %struct.stType*, %struct.stType** %55, i64 3
  %57 = load %struct.stType*, %struct.stType** %56, align 8
  %58 = getelementptr inbounds %struct.stType, %struct.stType* %57, i32 0, i32 1
  %59 = getelementptr inbounds [100 x i8], [100 x i8]* %58, i64 0, i64 9
  %60 = load i8, i8* %59, align 1
  %61 = sext i8 %60 to i32
  %62 = icmp eq i32 %61, 100
  br i1 %62, label %63, label %65

; <label>:63:                                     ; preds = %54
  %64 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0))
  br label %65

; <label>:65:                                     ; preds = %63, %54, %45, %36, %28, %18, %8, %0
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
