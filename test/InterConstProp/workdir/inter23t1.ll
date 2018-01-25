; ModuleID = 'workdir/inter23t1.bc'
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
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  %6 = call noalias i8* @malloc(i64 160) #6
  %7 = bitcast i8* %6 to %struct.stType**
  store %struct.stType** %7, %struct.stType*** @obj, align 8
  %8 = call noalias i8* @malloc(i64 144) #6
  %9 = bitcast i8* %8 to %struct.stType*
  %10 = load %struct.stType**, %struct.stType*** @obj, align 8
  %11 = getelementptr inbounds %struct.stType*, %struct.stType** %10, i64 0
  store %struct.stType* %9, %struct.stType** %11, align 8
  %12 = call noalias i8* @malloc(i64 16) #6
  %13 = bitcast i8* %12 to %struct.COORD*
  %14 = load %struct.stType**, %struct.stType*** @obj, align 8
  %15 = getelementptr inbounds %struct.stType*, %struct.stType** %14, i64 0
  %16 = load %struct.stType*, %struct.stType** %15, align 8
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %16, i32 0, i32 0
  store %struct.COORD* %13, %struct.COORD** %17, align 8
  %18 = call noalias i8* @malloc(i64 4) #6
  %19 = bitcast i8* %18 to i32*
  %20 = load %struct.stType**, %struct.stType*** @obj, align 8
  %21 = getelementptr inbounds %struct.stType*, %struct.stType** %20, i64 0
  %22 = load %struct.stType*, %struct.stType** %21, align 8
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %22, i32 0, i32 0
  %24 = load %struct.COORD*, %struct.COORD** %23, align 8
  %25 = getelementptr inbounds %struct.COORD, %struct.COORD* %24, i32 0, i32 0
  store i32* %19, i32** %25, align 8
  %26 = call noalias i8* @malloc(i64 4) #6
  %27 = bitcast i8* %26 to i32*
  %28 = load %struct.stType**, %struct.stType*** @obj, align 8
  %29 = getelementptr inbounds %struct.stType*, %struct.stType** %28, i64 0
  %30 = load %struct.stType*, %struct.stType** %29, align 8
  %31 = getelementptr inbounds %struct.stType, %struct.stType* %30, i32 0, i32 0
  %32 = load %struct.COORD*, %struct.COORD** %31, align 8
  %33 = getelementptr inbounds %struct.COORD, %struct.COORD* %32, i32 0, i32 1
  store i32* %27, i32** %33, align 8
  %34 = call noalias i8* @malloc(i64 144) #6
  %35 = bitcast i8* %34 to %struct.stType*
  %36 = load %struct.stType**, %struct.stType*** @obj, align 8
  %37 = getelementptr inbounds %struct.stType*, %struct.stType** %36, i64 3
  store %struct.stType* %35, %struct.stType** %37, align 8
  %38 = call noalias i8* @malloc(i64 16) #6
  %39 = bitcast i8* %38 to %struct.COORD*
  %40 = load %struct.stType**, %struct.stType*** @obj, align 8
  %41 = getelementptr inbounds %struct.stType*, %struct.stType** %40, i64 3
  %42 = load %struct.stType*, %struct.stType** %41, align 8
  %43 = getelementptr inbounds %struct.stType, %struct.stType* %42, i32 0, i32 0
  store %struct.COORD* %39, %struct.COORD** %43, align 8
  %44 = call noalias i8* @malloc(i64 4) #6
  %45 = bitcast i8* %44 to i32*
  %46 = load %struct.stType**, %struct.stType*** @obj, align 8
  %47 = getelementptr inbounds %struct.stType*, %struct.stType** %46, i64 3
  %48 = load %struct.stType*, %struct.stType** %47, align 8
  %49 = getelementptr inbounds %struct.stType, %struct.stType* %48, i32 0, i32 0
  %50 = load %struct.COORD*, %struct.COORD** %49, align 8
  %51 = getelementptr inbounds %struct.COORD, %struct.COORD* %50, i32 0, i32 0
  store i32* %45, i32** %51, align 8
  %52 = call noalias i8* @malloc(i64 4) #6
  %53 = bitcast i8* %52 to i32*
  %54 = load %struct.stType**, %struct.stType*** @obj, align 8
  %55 = getelementptr inbounds %struct.stType*, %struct.stType** %54, i64 3
  %56 = load %struct.stType*, %struct.stType** %55, align 8
  %57 = getelementptr inbounds %struct.stType, %struct.stType* %56, i32 0, i32 0
  %58 = load %struct.COORD*, %struct.COORD** %57, align 8
  %59 = getelementptr inbounds %struct.COORD, %struct.COORD* %58, i32 0, i32 1
  store i32* %53, i32** %59, align 8
  %60 = call noalias i8* @malloc(i64 144) #6
  %61 = bitcast i8* %60 to %struct.stType*
  %62 = load %struct.stType**, %struct.stType*** @obj, align 8
  %63 = getelementptr inbounds %struct.stType*, %struct.stType** %62, i64 1
  store %struct.stType* %61, %struct.stType** %63, align 8
  %64 = call noalias i8* @malloc(i64 16) #6
  %65 = bitcast i8* %64 to %struct.COORD*
  %66 = load %struct.stType**, %struct.stType*** @obj, align 8
  %67 = getelementptr inbounds %struct.stType*, %struct.stType** %66, i64 1
  %68 = load %struct.stType*, %struct.stType** %67, align 8
  %69 = getelementptr inbounds %struct.stType, %struct.stType* %68, i32 0, i32 0
  store %struct.COORD* %65, %struct.COORD** %69, align 8
  %70 = call noalias i8* @malloc(i64 4) #6
  %71 = bitcast i8* %70 to i32*
  %72 = load %struct.stType**, %struct.stType*** @obj, align 8
  %73 = getelementptr inbounds %struct.stType*, %struct.stType** %72, i64 1
  %74 = load %struct.stType*, %struct.stType** %73, align 8
  %75 = getelementptr inbounds %struct.stType, %struct.stType* %74, i32 0, i32 0
  %76 = load %struct.COORD*, %struct.COORD** %75, align 8
  %77 = getelementptr inbounds %struct.COORD, %struct.COORD* %76, i32 0, i32 0
  store i32* %71, i32** %77, align 8
  %78 = call noalias i8* @malloc(i64 4) #6
  %79 = bitcast i8* %78 to i32*
  %80 = load %struct.stType**, %struct.stType*** @obj, align 8
  %81 = getelementptr inbounds %struct.stType*, %struct.stType** %80, i64 1
  %82 = load %struct.stType*, %struct.stType** %81, align 8
  %83 = getelementptr inbounds %struct.stType, %struct.stType* %82, i32 0, i32 0
  %84 = load %struct.COORD*, %struct.COORD** %83, align 8
  %85 = getelementptr inbounds %struct.COORD, %struct.COORD* %84, i32 0, i32 1
  store i32* %79, i32** %85, align 8
  %86 = load i32, i32* %4, align 4
  %87 = icmp sgt i32 %86, 2
  br i1 %87, label %88, label %177

; <label>:88:                                     ; preds = %2
  %89 = load i32, i32* %4, align 4
  %90 = icmp sgt i32 %89, 5
  br i1 %90, label %91, label %108

; <label>:91:                                     ; preds = %88
  %92 = load %struct.stType**, %struct.stType*** @obj, align 8
  %93 = getelementptr inbounds %struct.stType*, %struct.stType** %92, i64 0
  %94 = load %struct.stType*, %struct.stType** %93, align 8
  %95 = getelementptr inbounds %struct.stType, %struct.stType* %94, i32 0, i32 0
  %96 = load %struct.COORD*, %struct.COORD** %95, align 8
  %97 = getelementptr inbounds %struct.COORD, %struct.COORD* %96, i32 0, i32 0
  %98 = load i32*, i32** %97, align 8
  %99 = getelementptr inbounds i32, i32* %98, i64 0
  store i32 1, i32* %99, align 4
  %100 = load %struct.stType**, %struct.stType*** @obj, align 8
  %101 = getelementptr inbounds %struct.stType*, %struct.stType** %100, i64 0
  %102 = load %struct.stType*, %struct.stType** %101, align 8
  %103 = getelementptr inbounds %struct.stType, %struct.stType* %102, i32 0, i32 0
  %104 = load %struct.COORD*, %struct.COORD** %103, align 8
  %105 = getelementptr inbounds %struct.COORD, %struct.COORD* %104, i32 0, i32 1
  %106 = load i32*, i32** %105, align 8
  %107 = getelementptr inbounds i32, i32* %106, i64 0
  store i32 2, i32* %107, align 4
  br label %125

; <label>:108:                                    ; preds = %88
  %109 = load %struct.stType**, %struct.stType*** @obj, align 8
  %110 = getelementptr inbounds %struct.stType*, %struct.stType** %109, i64 0
  %111 = load %struct.stType*, %struct.stType** %110, align 8
  %112 = getelementptr inbounds %struct.stType, %struct.stType* %111, i32 0, i32 0
  %113 = load %struct.COORD*, %struct.COORD** %112, align 8
  %114 = getelementptr inbounds %struct.COORD, %struct.COORD* %113, i32 0, i32 0
  %115 = load i32*, i32** %114, align 8
  %116 = getelementptr inbounds i32, i32* %115, i64 0
  store i32 1, i32* %116, align 4
  %117 = load %struct.stType**, %struct.stType*** @obj, align 8
  %118 = getelementptr inbounds %struct.stType*, %struct.stType** %117, i64 0
  %119 = load %struct.stType*, %struct.stType** %118, align 8
  %120 = getelementptr inbounds %struct.stType, %struct.stType* %119, i32 0, i32 0
  %121 = load %struct.COORD*, %struct.COORD** %120, align 8
  %122 = getelementptr inbounds %struct.COORD, %struct.COORD* %121, i32 0, i32 1
  %123 = load i32*, i32** %122, align 8
  %124 = getelementptr inbounds i32, i32* %123, i64 0
  store i32 2, i32* %124, align 4
  br label %125

; <label>:125:                                    ; preds = %108, %91
  %126 = load %struct.stType**, %struct.stType*** @obj, align 8
  %127 = getelementptr inbounds %struct.stType*, %struct.stType** %126, i64 0
  %128 = load %struct.stType*, %struct.stType** %127, align 8
  %129 = getelementptr inbounds %struct.stType, %struct.stType* %128, i32 0, i32 2
  %130 = getelementptr inbounds [8 x i32], [8 x i32]* %129, i64 0, i64 0
  store i32 3, i32* %130, align 4
  %131 = load %struct.stType**, %struct.stType*** @obj, align 8
  %132 = getelementptr inbounds %struct.stType*, %struct.stType** %131, i64 0
  %133 = load %struct.stType*, %struct.stType** %132, align 8
  %134 = getelementptr inbounds %struct.stType, %struct.stType* %133, i32 0, i32 2
  %135 = getelementptr inbounds [8 x i32], [8 x i32]* %134, i64 0, i64 1
  store i32 4, i32* %135, align 4
  %136 = load %struct.stType**, %struct.stType*** @obj, align 8
  %137 = getelementptr inbounds %struct.stType*, %struct.stType** %136, i64 0
  %138 = load %struct.stType*, %struct.stType** %137, align 8
  %139 = getelementptr inbounds %struct.stType, %struct.stType* %138, i32 0, i32 2
  %140 = getelementptr inbounds [8 x i32], [8 x i32]* %139, i64 0, i64 2
  store i32 5, i32* %140, align 4
  %141 = load %struct.stType**, %struct.stType*** @obj, align 8
  %142 = getelementptr inbounds %struct.stType*, %struct.stType** %141, i64 3
  %143 = load %struct.stType*, %struct.stType** %142, align 8
  %144 = getelementptr inbounds %struct.stType, %struct.stType* %143, i32 0, i32 0
  %145 = load %struct.COORD*, %struct.COORD** %144, align 8
  %146 = getelementptr inbounds %struct.COORD, %struct.COORD* %145, i32 0, i32 0
  %147 = load i32*, i32** %146, align 8
  %148 = getelementptr inbounds i32, i32* %147, i64 0
  store i32 16, i32* %148, align 4
  %149 = load %struct.stType**, %struct.stType*** @obj, align 8
  %150 = getelementptr inbounds %struct.stType*, %struct.stType** %149, i64 3
  %151 = load %struct.stType*, %struct.stType** %150, align 8
  %152 = getelementptr inbounds %struct.stType, %struct.stType* %151, i32 0, i32 0
  %153 = load %struct.COORD*, %struct.COORD** %152, align 8
  %154 = getelementptr inbounds %struct.COORD, %struct.COORD* %153, i32 0, i32 1
  %155 = load i32*, i32** %154, align 8
  %156 = getelementptr inbounds i32, i32* %155, i64 0
  store i32 17, i32* %156, align 4
  %157 = load %struct.stType**, %struct.stType*** @obj, align 8
  %158 = getelementptr inbounds %struct.stType*, %struct.stType** %157, i64 3
  %159 = load %struct.stType*, %struct.stType** %158, align 8
  %160 = getelementptr inbounds %struct.stType, %struct.stType* %159, i32 0, i32 2
  %161 = getelementptr inbounds [8 x i32], [8 x i32]* %160, i64 0, i64 0
  store i32 18, i32* %161, align 4
  %162 = load %struct.stType**, %struct.stType*** @obj, align 8
  %163 = getelementptr inbounds %struct.stType*, %struct.stType** %162, i64 3
  %164 = load %struct.stType*, %struct.stType** %163, align 8
  %165 = getelementptr inbounds %struct.stType, %struct.stType* %164, i32 0, i32 2
  %166 = getelementptr inbounds [8 x i32], [8 x i32]* %165, i64 0, i64 1
  store i32 19, i32* %166, align 4
  %167 = load %struct.stType**, %struct.stType*** @obj, align 8
  %168 = getelementptr inbounds %struct.stType*, %struct.stType** %167, i64 3
  %169 = load %struct.stType*, %struct.stType** %168, align 8
  %170 = getelementptr inbounds %struct.stType, %struct.stType* %169, i32 0, i32 2
  %171 = getelementptr inbounds [8 x i32], [8 x i32]* %170, i64 0, i64 2
  store i32 20, i32* %171, align 4
  %172 = load %struct.stType**, %struct.stType*** @obj, align 8
  %173 = getelementptr inbounds %struct.stType*, %struct.stType** %172, i64 3
  %174 = load %struct.stType*, %struct.stType** %173, align 8
  %175 = getelementptr inbounds %struct.stType, %struct.stType* %174, i32 0, i32 1
  %176 = getelementptr inbounds [100 x i8], [100 x i8]* %175, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %176, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %230

; <label>:177:                                    ; preds = %2
  %178 = load %struct.stType**, %struct.stType*** @obj, align 8
  %179 = getelementptr inbounds %struct.stType*, %struct.stType** %178, i64 0
  %180 = load %struct.stType*, %struct.stType** %179, align 8
  %181 = getelementptr inbounds %struct.stType, %struct.stType* %180, i32 0, i32 0
  %182 = load %struct.COORD*, %struct.COORD** %181, align 8
  %183 = getelementptr inbounds %struct.COORD, %struct.COORD* %182, i32 0, i32 0
  %184 = load i32*, i32** %183, align 8
  %185 = getelementptr inbounds i32, i32* %184, i64 0
  store i32 1, i32* %185, align 4
  %186 = load %struct.stType**, %struct.stType*** @obj, align 8
  %187 = getelementptr inbounds %struct.stType*, %struct.stType** %186, i64 0
  %188 = load %struct.stType*, %struct.stType** %187, align 8
  %189 = getelementptr inbounds %struct.stType, %struct.stType* %188, i32 0, i32 0
  %190 = load %struct.COORD*, %struct.COORD** %189, align 8
  %191 = getelementptr inbounds %struct.COORD, %struct.COORD* %190, i32 0, i32 1
  %192 = load i32*, i32** %191, align 8
  %193 = getelementptr inbounds i32, i32* %192, i64 0
  store i32 2, i32* %193, align 4
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
  br label %230

; <label>:230:                                    ; preds = %177, %125
  %231 = load %struct.stType**, %struct.stType*** @obj, align 8
  %232 = getelementptr inbounds %struct.stType*, %struct.stType** %231, i64 0
  %233 = load %struct.stType*, %struct.stType** %232, align 8
  %234 = getelementptr inbounds %struct.stType, %struct.stType* %233, i32 0, i32 1
  %235 = getelementptr inbounds [100 x i8], [100 x i8]* %234, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %235, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %236 = load %struct.stType**, %struct.stType*** @obj, align 8
  %237 = getelementptr inbounds %struct.stType*, %struct.stType** %236, i64 1
  %238 = load %struct.stType*, %struct.stType** %237, align 8
  %239 = getelementptr inbounds %struct.stType, %struct.stType* %238, i32 0, i32 0
  %240 = load %struct.COORD*, %struct.COORD** %239, align 8
  %241 = getelementptr inbounds %struct.COORD, %struct.COORD* %240, i32 0, i32 0
  %242 = load i32*, i32** %241, align 8
  %243 = getelementptr inbounds i32, i32* %242, i64 0
  store i32 6, i32* %243, align 4
  %244 = load %struct.stType**, %struct.stType*** @obj, align 8
  %245 = getelementptr inbounds %struct.stType*, %struct.stType** %244, i64 1
  %246 = load %struct.stType*, %struct.stType** %245, align 8
  %247 = getelementptr inbounds %struct.stType, %struct.stType* %246, i32 0, i32 0
  %248 = load %struct.COORD*, %struct.COORD** %247, align 8
  %249 = getelementptr inbounds %struct.COORD, %struct.COORD* %248, i32 0, i32 1
  %250 = load i32*, i32** %249, align 8
  %251 = getelementptr inbounds i32, i32* %250, i64 0
  store i32 7, i32* %251, align 4
  %252 = load %struct.stType**, %struct.stType*** @obj, align 8
  %253 = getelementptr inbounds %struct.stType*, %struct.stType** %252, i64 1
  %254 = load %struct.stType*, %struct.stType** %253, align 8
  %255 = getelementptr inbounds %struct.stType, %struct.stType* %254, i32 0, i32 2
  %256 = getelementptr inbounds [8 x i32], [8 x i32]* %255, i64 0, i64 0
  store i32 8, i32* %256, align 4
  %257 = load %struct.stType**, %struct.stType*** @obj, align 8
  %258 = getelementptr inbounds %struct.stType*, %struct.stType** %257, i64 1
  %259 = load %struct.stType*, %struct.stType** %258, align 8
  %260 = getelementptr inbounds %struct.stType, %struct.stType* %259, i32 0, i32 2
  %261 = getelementptr inbounds [8 x i32], [8 x i32]* %260, i64 0, i64 1
  store i32 9, i32* %261, align 4
  %262 = load %struct.stType**, %struct.stType*** @obj, align 8
  %263 = getelementptr inbounds %struct.stType*, %struct.stType** %262, i64 1
  %264 = load %struct.stType*, %struct.stType** %263, align 8
  %265 = getelementptr inbounds %struct.stType, %struct.stType* %264, i32 0, i32 2
  %266 = getelementptr inbounds [8 x i32], [8 x i32]* %265, i64 0, i64 2
  store i32 10, i32* %266, align 4
  %267 = load %struct.stType**, %struct.stType*** @obj, align 8
  %268 = getelementptr inbounds %struct.stType*, %struct.stType** %267, i64 1
  %269 = load %struct.stType*, %struct.stType** %268, align 8
  %270 = getelementptr inbounds %struct.stType, %struct.stType* %269, i32 0, i32 1
  %271 = getelementptr inbounds [100 x i8], [100 x i8]* %270, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %271, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %272 = call noalias i8* @malloc(i64 144) #6
  %273 = bitcast i8* %272 to %struct.stType*
  %274 = load %struct.stType**, %struct.stType*** @obj, align 8
  %275 = getelementptr inbounds %struct.stType*, %struct.stType** %274, i64 2
  store %struct.stType* %273, %struct.stType** %275, align 8
  %276 = call noalias i8* @malloc(i64 16) #6
  %277 = bitcast i8* %276 to %struct.COORD*
  %278 = load %struct.stType**, %struct.stType*** @obj, align 8
  %279 = getelementptr inbounds %struct.stType*, %struct.stType** %278, i64 2
  %280 = load %struct.stType*, %struct.stType** %279, align 8
  %281 = getelementptr inbounds %struct.stType, %struct.stType* %280, i32 0, i32 0
  store %struct.COORD* %277, %struct.COORD** %281, align 8
  %282 = call noalias i8* @malloc(i64 4) #6
  %283 = bitcast i8* %282 to i32*
  %284 = load %struct.stType**, %struct.stType*** @obj, align 8
  %285 = getelementptr inbounds %struct.stType*, %struct.stType** %284, i64 2
  %286 = load %struct.stType*, %struct.stType** %285, align 8
  %287 = getelementptr inbounds %struct.stType, %struct.stType* %286, i32 0, i32 0
  %288 = load %struct.COORD*, %struct.COORD** %287, align 8
  %289 = getelementptr inbounds %struct.COORD, %struct.COORD* %288, i32 0, i32 0
  store i32* %283, i32** %289, align 8
  %290 = call noalias i8* @malloc(i64 4) #6
  %291 = bitcast i8* %290 to i32*
  %292 = load %struct.stType**, %struct.stType*** @obj, align 8
  %293 = getelementptr inbounds %struct.stType*, %struct.stType** %292, i64 2
  %294 = load %struct.stType*, %struct.stType** %293, align 8
  %295 = getelementptr inbounds %struct.stType, %struct.stType* %294, i32 0, i32 0
  %296 = load %struct.COORD*, %struct.COORD** %295, align 8
  %297 = getelementptr inbounds %struct.COORD, %struct.COORD* %296, i32 0, i32 1
  store i32* %291, i32** %297, align 8
  %298 = load %struct.stType**, %struct.stType*** @obj, align 8
  %299 = getelementptr inbounds %struct.stType*, %struct.stType** %298, i64 2
  %300 = load %struct.stType*, %struct.stType** %299, align 8
  %301 = getelementptr inbounds %struct.stType, %struct.stType* %300, i32 0, i32 0
  %302 = load %struct.COORD*, %struct.COORD** %301, align 8
  %303 = getelementptr inbounds %struct.COORD, %struct.COORD* %302, i32 0, i32 0
  %304 = load i32*, i32** %303, align 8
  %305 = getelementptr inbounds i32, i32* %304, i64 0
  store i32 11, i32* %305, align 4
  %306 = load %struct.stType**, %struct.stType*** @obj, align 8
  %307 = getelementptr inbounds %struct.stType*, %struct.stType** %306, i64 2
  %308 = load %struct.stType*, %struct.stType** %307, align 8
  %309 = getelementptr inbounds %struct.stType, %struct.stType* %308, i32 0, i32 0
  %310 = load %struct.COORD*, %struct.COORD** %309, align 8
  %311 = getelementptr inbounds %struct.COORD, %struct.COORD* %310, i32 0, i32 1
  %312 = load i32*, i32** %311, align 8
  %313 = getelementptr inbounds i32, i32* %312, i64 0
  store i32 12, i32* %313, align 4
  %314 = load %struct.stType**, %struct.stType*** @obj, align 8
  %315 = getelementptr inbounds %struct.stType*, %struct.stType** %314, i64 2
  %316 = load %struct.stType*, %struct.stType** %315, align 8
  %317 = getelementptr inbounds %struct.stType, %struct.stType* %316, i32 0, i32 2
  %318 = getelementptr inbounds [8 x i32], [8 x i32]* %317, i64 0, i64 0
  store i32 13, i32* %318, align 4
  %319 = load %struct.stType**, %struct.stType*** @obj, align 8
  %320 = getelementptr inbounds %struct.stType*, %struct.stType** %319, i64 2
  %321 = load %struct.stType*, %struct.stType** %320, align 8
  %322 = getelementptr inbounds %struct.stType, %struct.stType* %321, i32 0, i32 2
  %323 = getelementptr inbounds [8 x i32], [8 x i32]* %322, i64 0, i64 1
  store i32 14, i32* %323, align 4
  %324 = load %struct.stType**, %struct.stType*** @obj, align 8
  %325 = getelementptr inbounds %struct.stType*, %struct.stType** %324, i64 2
  %326 = load %struct.stType*, %struct.stType** %325, align 8
  %327 = getelementptr inbounds %struct.stType, %struct.stType* %326, i32 0, i32 2
  %328 = getelementptr inbounds [8 x i32], [8 x i32]* %327, i64 0, i64 2
  store i32 15, i32* %328, align 4
  %329 = load %struct.stType**, %struct.stType*** @obj, align 8
  %330 = getelementptr inbounds %struct.stType*, %struct.stType** %329, i64 2
  %331 = load %struct.stType*, %struct.stType** %330, align 8
  %332 = getelementptr inbounds %struct.stType, %struct.stType* %331, i32 0, i32 1
  %333 = getelementptr inbounds [100 x i8], [100 x i8]* %332, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %333, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  call void @branchPruned()
  call void @branchNotPruned()
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #4

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
