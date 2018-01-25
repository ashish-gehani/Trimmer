; ModuleID = 'workdir/inter14t2.bc'
source_filename = "inter14.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"*** Branch Taken \0A\00", align 1
@.str.2 = private unnamed_addr constant [23 x i8] c"*** Branch not Taken \0A\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType**) #0 {
  %2 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %3 = load %struct.stType*, %struct.stType** %2, align 8
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 0
  %5 = load %struct.COORD*, %struct.COORD** %4, align 8
  %6 = getelementptr inbounds %struct.COORD, %struct.COORD* %5, i32 0, i32 0
  %7 = load i32*, i32** %6, align 8
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 %8, 1
  br i1 %9, label %10, label %110

; <label>:10:                                     ; preds = %1
  %11 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %12 = load %struct.stType*, %struct.stType** %11, align 8
  %13 = getelementptr inbounds %struct.stType, %struct.stType* %12, i32 0, i32 0
  %14 = load %struct.COORD*, %struct.COORD** %13, align 8
  %15 = getelementptr inbounds %struct.COORD, %struct.COORD* %14, i32 0, i32 1
  %16 = load i32*, i32** %15, align 8
  %17 = load i32, i32* %16, align 4
  %18 = icmp eq i32 %17, 2
  br i1 %18, label %19, label %110

; <label>:19:                                     ; preds = %10
  %20 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %21 = load %struct.stType*, %struct.stType** %20, align 8
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %21, i32 0, i32 1
  %23 = getelementptr inbounds [100 x i8], [100 x i8]* %22, i32 0, i32 0
  %24 = call i32 @strcmp(i8* %23, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %110, label %26

; <label>:26:                                     ; preds = %19
  %27 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %28 = load %struct.stType*, %struct.stType** %27, align 8
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i32 0, i32 1
  %30 = getelementptr inbounds [100 x i8], [100 x i8]* %29, i64 0, i64 4
  %31 = load i8, i8* %30, align 4
  %32 = sext i8 %31 to i32
  %33 = icmp eq i32 %32, 111
  br i1 %33, label %34, label %110

; <label>:34:                                     ; preds = %26
  %35 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %36 = load %struct.stType*, %struct.stType** %35, align 8
  %37 = getelementptr inbounds %struct.stType, %struct.stType* %36, i32 0, i32 1
  %38 = getelementptr inbounds [100 x i8], [100 x i8]* %37, i64 0, i64 9
  %39 = load i8, i8* %38, align 1
  %40 = sext i8 %39 to i32
  %41 = icmp eq i32 %40, 100
  br i1 %41, label %42, label %110

; <label>:42:                                     ; preds = %34
  %43 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %44 = load %struct.stType*, %struct.stType** %43, align 8
  %45 = getelementptr inbounds %struct.stType, %struct.stType* %44, i32 0, i32 0
  %46 = load %struct.COORD*, %struct.COORD** %45, align 8
  %47 = getelementptr inbounds %struct.COORD, %struct.COORD* %46, i32 0, i32 0
  %48 = load i32*, i32** %47, align 8
  %49 = load i32, i32* %48, align 4
  %50 = icmp eq i32 %49, 11
  br i1 %50, label %51, label %110

; <label>:51:                                     ; preds = %42
  %52 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %53 = load %struct.stType*, %struct.stType** %52, align 8
  %54 = getelementptr inbounds %struct.stType, %struct.stType* %53, i32 0, i32 0
  %55 = load %struct.COORD*, %struct.COORD** %54, align 8
  %56 = getelementptr inbounds %struct.COORD, %struct.COORD* %55, i32 0, i32 1
  %57 = load i32*, i32** %56, align 8
  %58 = load i32, i32* %57, align 4
  %59 = icmp eq i32 %58, 12
  br i1 %59, label %60, label %110

; <label>:60:                                     ; preds = %51
  %61 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %62 = load %struct.stType*, %struct.stType** %61, align 8
  %63 = getelementptr inbounds %struct.stType, %struct.stType* %62, i32 0, i32 0
  %64 = load %struct.COORD*, %struct.COORD** %63, align 8
  %65 = getelementptr inbounds %struct.COORD, %struct.COORD* %64, i32 0, i32 0
  %66 = load i32*, i32** %65, align 8
  %67 = load i32, i32* %66, align 4
  %68 = icmp eq i32 %67, 16
  br i1 %68, label %69, label %110

; <label>:69:                                     ; preds = %60
  %70 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %71 = load %struct.stType*, %struct.stType** %70, align 8
  %72 = getelementptr inbounds %struct.stType, %struct.stType* %71, i32 0, i32 0
  %73 = load %struct.COORD*, %struct.COORD** %72, align 8
  %74 = getelementptr inbounds %struct.COORD, %struct.COORD* %73, i32 0, i32 1
  %75 = load i32*, i32** %74, align 8
  %76 = load i32, i32* %75, align 4
  %77 = icmp eq i32 %76, 17
  br i1 %77, label %78, label %110

; <label>:78:                                     ; preds = %69
  %79 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %80 = load %struct.stType*, %struct.stType** %79, align 8
  %81 = getelementptr inbounds %struct.stType, %struct.stType* %80, i32 0, i32 2
  %82 = getelementptr inbounds [8 x i32], [8 x i32]* %81, i64 0, i64 1
  %83 = load i32, i32* %82, align 4
  %84 = icmp eq i32 %83, 14
  br i1 %84, label %85, label %110

; <label>:85:                                     ; preds = %78
  %86 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %87 = load %struct.stType*, %struct.stType** %86, align 8
  %88 = getelementptr inbounds %struct.stType, %struct.stType* %87, i32 0, i32 1
  %89 = getelementptr inbounds [100 x i8], [100 x i8]* %88, i32 0, i32 0
  %90 = call i32 @strcmp(i8* %89, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %91 = icmp ne i32 %90, 0
  br i1 %91, label %110, label %92

; <label>:92:                                     ; preds = %85
  %93 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %94 = load %struct.stType*, %struct.stType** %93, align 8
  %95 = getelementptr inbounds %struct.stType, %struct.stType* %94, i32 0, i32 1
  %96 = getelementptr inbounds [100 x i8], [100 x i8]* %95, i64 0, i64 4
  %97 = load i8, i8* %96, align 4
  %98 = sext i8 %97 to i32
  %99 = icmp eq i32 %98, 111
  br i1 %99, label %100, label %110

; <label>:100:                                    ; preds = %92
  %101 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %102 = load %struct.stType*, %struct.stType** %101, align 8
  %103 = getelementptr inbounds %struct.stType, %struct.stType* %102, i32 0, i32 1
  %104 = getelementptr inbounds [100 x i8], [100 x i8]* %103, i64 0, i64 9
  %105 = load i8, i8* %104, align 1
  %106 = sext i8 %105 to i32
  %107 = icmp eq i32 %106, 100
  br i1 %107, label %108, label %110

; <label>:108:                                    ; preds = %100
  %109 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %110

; <label>:110:                                    ; preds = %108, %100, %92, %85, %78, %69, %60, %51, %42, %34, %26, %19, %10, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned(%struct.stType**) #0 {
  %2 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %3 = load %struct.stType*, %struct.stType** %2, align 8
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 2
  %5 = getelementptr inbounds [8 x i32], [8 x i32]* %4, i64 0, i64 1
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 4
  br i1 %7, label %38, label %8

; <label>:8:                                      ; preds = %1
  %9 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %10 = load %struct.stType*, %struct.stType** %9, align 8
  %11 = getelementptr inbounds %struct.stType, %struct.stType* %10, i32 0, i32 2
  %12 = getelementptr inbounds [8 x i32], [8 x i32]* %11, i64 0, i64 1
  %13 = load i32, i32* %12, align 4
  %14 = icmp eq i32 %13, 19
  br i1 %14, label %38, label %15

; <label>:15:                                     ; preds = %8
  %16 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %17 = load %struct.stType*, %struct.stType** %16, align 8
  %18 = getelementptr inbounds %struct.stType, %struct.stType* %17, i32 0, i32 1
  %19 = getelementptr inbounds [100 x i8], [100 x i8]* %18, i32 0, i32 0
  %20 = call i32 @strcmp(i8* %19, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %22, label %38

; <label>:22:                                     ; preds = %15
  %23 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %24 = load %struct.stType*, %struct.stType** %23, align 8
  %25 = getelementptr inbounds %struct.stType, %struct.stType* %24, i32 0, i32 1
  %26 = getelementptr inbounds [100 x i8], [100 x i8]* %25, i64 0, i64 4
  %27 = load i8, i8* %26, align 4
  %28 = sext i8 %27 to i32
  %29 = icmp eq i32 %28, 111
  br i1 %29, label %38, label %30

; <label>:30:                                     ; preds = %22
  %31 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %32 = load %struct.stType*, %struct.stType** %31, align 8
  %33 = getelementptr inbounds %struct.stType, %struct.stType* %32, i32 0, i32 1
  %34 = getelementptr inbounds [100 x i8], [100 x i8]* %33, i64 0, i64 9
  %35 = load i8, i8* %34, align 1
  %36 = sext i8 %35 to i32
  %37 = icmp eq i32 %36, 100
  br i1 %37, label %38, label %40

; <label>:38:                                     ; preds = %30, %22, %15, %8, %1
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0))
  br label %40

; <label>:40:                                     ; preds = %38, %30
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 {
  %3 = call noalias i8* @malloc(i64 160) #6
  %4 = bitcast i8* %3 to %struct.stType**
  %5 = call noalias i8* @malloc(i64 144) #6
  %6 = bitcast i8* %5 to %struct.stType*
  %7 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 0
  store %struct.stType* %6, %struct.stType** %7, align 8
  %8 = call noalias i8* @malloc(i64 16) #6
  %9 = bitcast i8* %8 to %struct.COORD*
  %10 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 0
  %11 = load %struct.stType*, %struct.stType** %10, align 8
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 0
  store %struct.COORD* %9, %struct.COORD** %12, align 8
  %13 = call noalias i8* @malloc(i64 4) #6
  %14 = bitcast i8* %13 to i32*
  %15 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 0
  %16 = load %struct.stType*, %struct.stType** %15, align 8
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %16, i32 0, i32 0
  %18 = load %struct.COORD*, %struct.COORD** %17, align 8
  %19 = getelementptr inbounds %struct.COORD, %struct.COORD* %18, i32 0, i32 0
  store i32* %14, i32** %19, align 8
  %20 = call noalias i8* @malloc(i64 4) #6
  %21 = bitcast i8* %20 to i32*
  %22 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 0
  %23 = load %struct.stType*, %struct.stType** %22, align 8
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %23, i32 0, i32 0
  %25 = load %struct.COORD*, %struct.COORD** %24, align 8
  %26 = getelementptr inbounds %struct.COORD, %struct.COORD* %25, i32 0, i32 1
  store i32* %21, i32** %26, align 8
  %27 = call noalias i8* @malloc(i64 144) #6
  %28 = bitcast i8* %27 to %struct.stType*
  %29 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 3
  store %struct.stType* %28, %struct.stType** %29, align 8
  %30 = call noalias i8* @malloc(i64 16) #6
  %31 = bitcast i8* %30 to %struct.COORD*
  %32 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 3
  %33 = load %struct.stType*, %struct.stType** %32, align 8
  %34 = getelementptr inbounds %struct.stType, %struct.stType* %33, i32 0, i32 0
  store %struct.COORD* %31, %struct.COORD** %34, align 8
  %35 = call noalias i8* @malloc(i64 4) #6
  %36 = bitcast i8* %35 to i32*
  %37 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 3
  %38 = load %struct.stType*, %struct.stType** %37, align 8
  %39 = getelementptr inbounds %struct.stType, %struct.stType* %38, i32 0, i32 0
  %40 = load %struct.COORD*, %struct.COORD** %39, align 8
  %41 = getelementptr inbounds %struct.COORD, %struct.COORD* %40, i32 0, i32 0
  store i32* %36, i32** %41, align 8
  %42 = call noalias i8* @malloc(i64 4) #6
  %43 = bitcast i8* %42 to i32*
  %44 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 3
  %45 = load %struct.stType*, %struct.stType** %44, align 8
  %46 = getelementptr inbounds %struct.stType, %struct.stType* %45, i32 0, i32 0
  %47 = load %struct.COORD*, %struct.COORD** %46, align 8
  %48 = getelementptr inbounds %struct.COORD, %struct.COORD* %47, i32 0, i32 1
  store i32* %43, i32** %48, align 8
  %49 = call noalias i8* @malloc(i64 144) #6
  %50 = bitcast i8* %49 to %struct.stType*
  %51 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  store %struct.stType* %50, %struct.stType** %51, align 8
  %52 = call noalias i8* @malloc(i64 16) #6
  %53 = bitcast i8* %52 to %struct.COORD*
  %54 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %55 = load %struct.stType*, %struct.stType** %54, align 8
  %56 = getelementptr inbounds %struct.stType, %struct.stType* %55, i32 0, i32 0
  store %struct.COORD* %53, %struct.COORD** %56, align 8
  %57 = call noalias i8* @malloc(i64 4) #6
  %58 = bitcast i8* %57 to i32*
  %59 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %60 = load %struct.stType*, %struct.stType** %59, align 8
  %61 = getelementptr inbounds %struct.stType, %struct.stType* %60, i32 0, i32 0
  %62 = load %struct.COORD*, %struct.COORD** %61, align 8
  %63 = getelementptr inbounds %struct.COORD, %struct.COORD* %62, i32 0, i32 0
  store i32* %58, i32** %63, align 8
  %64 = call noalias i8* @malloc(i64 4) #6
  %65 = bitcast i8* %64 to i32*
  %66 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %67 = load %struct.stType*, %struct.stType** %66, align 8
  %68 = getelementptr inbounds %struct.stType, %struct.stType* %67, i32 0, i32 0
  %69 = load %struct.COORD*, %struct.COORD** %68, align 8
  %70 = getelementptr inbounds %struct.COORD, %struct.COORD* %69, i32 0, i32 1
  store i32* %65, i32** %70, align 8
  %71 = icmp sgt i32 %0, 2
  %72 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 0
  %73 = load %struct.stType*, %struct.stType** %72, align 8
  %74 = getelementptr inbounds %struct.stType, %struct.stType* %73, i32 0, i32 0
  %75 = load %struct.COORD*, %struct.COORD** %74, align 8
  %76 = getelementptr inbounds %struct.COORD, %struct.COORD* %75, i32 0, i32 0
  %77 = load i32*, i32** %76, align 8
  %78 = getelementptr inbounds i32, i32* %77, i64 0
  store i32 1, i32* %78, align 4
  %79 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 0
  %80 = load %struct.stType*, %struct.stType** %79, align 8
  %81 = getelementptr inbounds %struct.stType, %struct.stType* %80, i32 0, i32 0
  %82 = load %struct.COORD*, %struct.COORD** %81, align 8
  %83 = getelementptr inbounds %struct.COORD, %struct.COORD* %82, i32 0, i32 1
  %84 = load i32*, i32** %83, align 8
  %85 = getelementptr inbounds i32, i32* %84, i64 0
  store i32 2, i32* %85, align 4
  br i1 %71, label %86, label %129

; <label>:86:                                     ; preds = %2
  %87 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 0
  %88 = load %struct.stType*, %struct.stType** %87, align 8
  %89 = getelementptr inbounds %struct.stType, %struct.stType* %88, i32 0, i32 2
  %90 = getelementptr inbounds [8 x i32], [8 x i32]* %89, i64 0, i64 0
  store i32 3, i32* %90, align 4
  %91 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 0
  %92 = load %struct.stType*, %struct.stType** %91, align 8
  %93 = getelementptr inbounds %struct.stType, %struct.stType* %92, i32 0, i32 2
  %94 = getelementptr inbounds [8 x i32], [8 x i32]* %93, i64 0, i64 1
  store i32 4, i32* %94, align 4
  %95 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 0
  %96 = load %struct.stType*, %struct.stType** %95, align 8
  %97 = getelementptr inbounds %struct.stType, %struct.stType* %96, i32 0, i32 2
  %98 = getelementptr inbounds [8 x i32], [8 x i32]* %97, i64 0, i64 2
  store i32 5, i32* %98, align 4
  %99 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 3
  %100 = load %struct.stType*, %struct.stType** %99, align 8
  %101 = getelementptr inbounds %struct.stType, %struct.stType* %100, i32 0, i32 0
  %102 = load %struct.COORD*, %struct.COORD** %101, align 8
  %103 = getelementptr inbounds %struct.COORD, %struct.COORD* %102, i32 0, i32 0
  %104 = load i32*, i32** %103, align 8
  %105 = getelementptr inbounds i32, i32* %104, i64 0
  store i32 16, i32* %105, align 4
  %106 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 3
  %107 = load %struct.stType*, %struct.stType** %106, align 8
  %108 = getelementptr inbounds %struct.stType, %struct.stType* %107, i32 0, i32 0
  %109 = load %struct.COORD*, %struct.COORD** %108, align 8
  %110 = getelementptr inbounds %struct.COORD, %struct.COORD* %109, i32 0, i32 1
  %111 = load i32*, i32** %110, align 8
  %112 = getelementptr inbounds i32, i32* %111, i64 0
  store i32 17, i32* %112, align 4
  %113 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 3
  %114 = load %struct.stType*, %struct.stType** %113, align 8
  %115 = getelementptr inbounds %struct.stType, %struct.stType* %114, i32 0, i32 2
  %116 = getelementptr inbounds [8 x i32], [8 x i32]* %115, i64 0, i64 0
  store i32 18, i32* %116, align 4
  %117 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 3
  %118 = load %struct.stType*, %struct.stType** %117, align 8
  %119 = getelementptr inbounds %struct.stType, %struct.stType* %118, i32 0, i32 2
  %120 = getelementptr inbounds [8 x i32], [8 x i32]* %119, i64 0, i64 1
  store i32 19, i32* %120, align 4
  %121 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 3
  %122 = load %struct.stType*, %struct.stType** %121, align 8
  %123 = getelementptr inbounds %struct.stType, %struct.stType* %122, i32 0, i32 2
  %124 = getelementptr inbounds [8 x i32], [8 x i32]* %123, i64 0, i64 2
  store i32 20, i32* %124, align 4
  %125 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 3
  %126 = load %struct.stType*, %struct.stType** %125, align 8
  %127 = getelementptr inbounds %struct.stType, %struct.stType* %126, i32 0, i32 1
  %128 = getelementptr inbounds [100 x i8], [100 x i8]* %127, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %128, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %160

; <label>:129:                                    ; preds = %2
  %130 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %131 = load %struct.stType*, %struct.stType** %130, align 8
  %132 = getelementptr inbounds %struct.stType, %struct.stType* %131, i32 0, i32 0
  %133 = load %struct.COORD*, %struct.COORD** %132, align 8
  %134 = getelementptr inbounds %struct.COORD, %struct.COORD* %133, i32 0, i32 0
  %135 = load i32*, i32** %134, align 8
  %136 = getelementptr inbounds i32, i32* %135, i64 0
  store i32 6, i32* %136, align 4
  %137 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %138 = load %struct.stType*, %struct.stType** %137, align 8
  %139 = getelementptr inbounds %struct.stType, %struct.stType* %138, i32 0, i32 0
  %140 = load %struct.COORD*, %struct.COORD** %139, align 8
  %141 = getelementptr inbounds %struct.COORD, %struct.COORD* %140, i32 0, i32 1
  %142 = load i32*, i32** %141, align 8
  %143 = getelementptr inbounds i32, i32* %142, i64 0
  store i32 7, i32* %143, align 4
  %144 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %145 = load %struct.stType*, %struct.stType** %144, align 8
  %146 = getelementptr inbounds %struct.stType, %struct.stType* %145, i32 0, i32 2
  %147 = getelementptr inbounds [8 x i32], [8 x i32]* %146, i64 0, i64 0
  store i32 8, i32* %147, align 4
  %148 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %149 = load %struct.stType*, %struct.stType** %148, align 8
  %150 = getelementptr inbounds %struct.stType, %struct.stType* %149, i32 0, i32 2
  %151 = getelementptr inbounds [8 x i32], [8 x i32]* %150, i64 0, i64 1
  store i32 9, i32* %151, align 4
  %152 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %153 = load %struct.stType*, %struct.stType** %152, align 8
  %154 = getelementptr inbounds %struct.stType, %struct.stType* %153, i32 0, i32 2
  %155 = getelementptr inbounds [8 x i32], [8 x i32]* %154, i64 0, i64 2
  store i32 10, i32* %155, align 4
  %156 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %157 = load %struct.stType*, %struct.stType** %156, align 8
  %158 = getelementptr inbounds %struct.stType, %struct.stType* %157, i32 0, i32 1
  %159 = getelementptr inbounds [100 x i8], [100 x i8]* %158, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %159, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %160

; <label>:160:                                    ; preds = %129, %86
  %161 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 3
  %162 = load %struct.stType*, %struct.stType** %161, align 8
  %163 = getelementptr inbounds %struct.stType, %struct.stType* %162, i32 0, i32 0
  %164 = load %struct.COORD*, %struct.COORD** %163, align 8
  %165 = getelementptr inbounds %struct.COORD, %struct.COORD* %164, i32 0, i32 0
  %166 = load i32*, i32** %165, align 8
  %167 = getelementptr inbounds i32, i32* %166, i64 0
  store i32 16, i32* %167, align 4
  %168 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 3
  %169 = load %struct.stType*, %struct.stType** %168, align 8
  %170 = getelementptr inbounds %struct.stType, %struct.stType* %169, i32 0, i32 0
  %171 = load %struct.COORD*, %struct.COORD** %170, align 8
  %172 = getelementptr inbounds %struct.COORD, %struct.COORD* %171, i32 0, i32 1
  %173 = load i32*, i32** %172, align 8
  %174 = getelementptr inbounds i32, i32* %173, i64 0
  store i32 17, i32* %174, align 4
  %175 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 0
  %176 = load %struct.stType*, %struct.stType** %175, align 8
  %177 = getelementptr inbounds %struct.stType, %struct.stType* %176, i32 0, i32 1
  %178 = getelementptr inbounds [100 x i8], [100 x i8]* %177, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %178, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %179 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %180 = load %struct.stType*, %struct.stType** %179, align 8
  %181 = getelementptr inbounds %struct.stType, %struct.stType* %180, i32 0, i32 0
  %182 = load %struct.COORD*, %struct.COORD** %181, align 8
  %183 = getelementptr inbounds %struct.COORD, %struct.COORD* %182, i32 0, i32 0
  %184 = load i32*, i32** %183, align 8
  %185 = getelementptr inbounds i32, i32* %184, i64 0
  store i32 6, i32* %185, align 4
  %186 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %187 = load %struct.stType*, %struct.stType** %186, align 8
  %188 = getelementptr inbounds %struct.stType, %struct.stType* %187, i32 0, i32 0
  %189 = load %struct.COORD*, %struct.COORD** %188, align 8
  %190 = getelementptr inbounds %struct.COORD, %struct.COORD* %189, i32 0, i32 1
  %191 = load i32*, i32** %190, align 8
  %192 = getelementptr inbounds i32, i32* %191, i64 0
  store i32 7, i32* %192, align 4
  %193 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %194 = load %struct.stType*, %struct.stType** %193, align 8
  %195 = getelementptr inbounds %struct.stType, %struct.stType* %194, i32 0, i32 2
  %196 = getelementptr inbounds [8 x i32], [8 x i32]* %195, i64 0, i64 0
  store i32 8, i32* %196, align 4
  %197 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %198 = load %struct.stType*, %struct.stType** %197, align 8
  %199 = getelementptr inbounds %struct.stType, %struct.stType* %198, i32 0, i32 2
  %200 = getelementptr inbounds [8 x i32], [8 x i32]* %199, i64 0, i64 1
  store i32 9, i32* %200, align 4
  %201 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %202 = load %struct.stType*, %struct.stType** %201, align 8
  %203 = getelementptr inbounds %struct.stType, %struct.stType* %202, i32 0, i32 2
  %204 = getelementptr inbounds [8 x i32], [8 x i32]* %203, i64 0, i64 2
  store i32 10, i32* %204, align 4
  %205 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 1
  %206 = load %struct.stType*, %struct.stType** %205, align 8
  %207 = getelementptr inbounds %struct.stType, %struct.stType* %206, i32 0, i32 1
  %208 = getelementptr inbounds [100 x i8], [100 x i8]* %207, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %208, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %209 = call noalias i8* @malloc(i64 144) #6
  %210 = bitcast i8* %209 to %struct.stType*
  %211 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 2
  store %struct.stType* %210, %struct.stType** %211, align 8
  %212 = call noalias i8* @malloc(i64 16) #6
  %213 = bitcast i8* %212 to %struct.COORD*
  %214 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 2
  %215 = load %struct.stType*, %struct.stType** %214, align 8
  %216 = getelementptr inbounds %struct.stType, %struct.stType* %215, i32 0, i32 0
  store %struct.COORD* %213, %struct.COORD** %216, align 8
  %217 = call noalias i8* @malloc(i64 4) #6
  %218 = bitcast i8* %217 to i32*
  %219 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 2
  %220 = load %struct.stType*, %struct.stType** %219, align 8
  %221 = getelementptr inbounds %struct.stType, %struct.stType* %220, i32 0, i32 0
  %222 = load %struct.COORD*, %struct.COORD** %221, align 8
  %223 = getelementptr inbounds %struct.COORD, %struct.COORD* %222, i32 0, i32 0
  store i32* %218, i32** %223, align 8
  %224 = call noalias i8* @malloc(i64 4) #6
  %225 = bitcast i8* %224 to i32*
  %226 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 2
  %227 = load %struct.stType*, %struct.stType** %226, align 8
  %228 = getelementptr inbounds %struct.stType, %struct.stType* %227, i32 0, i32 0
  %229 = load %struct.COORD*, %struct.COORD** %228, align 8
  %230 = getelementptr inbounds %struct.COORD, %struct.COORD* %229, i32 0, i32 1
  store i32* %225, i32** %230, align 8
  %231 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 2
  %232 = load %struct.stType*, %struct.stType** %231, align 8
  %233 = getelementptr inbounds %struct.stType, %struct.stType* %232, i32 0, i32 0
  %234 = load %struct.COORD*, %struct.COORD** %233, align 8
  %235 = getelementptr inbounds %struct.COORD, %struct.COORD* %234, i32 0, i32 0
  %236 = load i32*, i32** %235, align 8
  %237 = getelementptr inbounds i32, i32* %236, i64 0
  store i32 11, i32* %237, align 4
  %238 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 2
  %239 = load %struct.stType*, %struct.stType** %238, align 8
  %240 = getelementptr inbounds %struct.stType, %struct.stType* %239, i32 0, i32 0
  %241 = load %struct.COORD*, %struct.COORD** %240, align 8
  %242 = getelementptr inbounds %struct.COORD, %struct.COORD* %241, i32 0, i32 1
  %243 = load i32*, i32** %242, align 8
  %244 = getelementptr inbounds i32, i32* %243, i64 0
  store i32 12, i32* %244, align 4
  %245 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 2
  %246 = load %struct.stType*, %struct.stType** %245, align 8
  %247 = getelementptr inbounds %struct.stType, %struct.stType* %246, i32 0, i32 2
  %248 = getelementptr inbounds [8 x i32], [8 x i32]* %247, i64 0, i64 0
  store i32 13, i32* %248, align 4
  %249 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 2
  %250 = load %struct.stType*, %struct.stType** %249, align 8
  %251 = getelementptr inbounds %struct.stType, %struct.stType* %250, i32 0, i32 2
  %252 = getelementptr inbounds [8 x i32], [8 x i32]* %251, i64 0, i64 1
  store i32 14, i32* %252, align 4
  %253 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 2
  %254 = load %struct.stType*, %struct.stType** %253, align 8
  %255 = getelementptr inbounds %struct.stType, %struct.stType* %254, i32 0, i32 2
  %256 = getelementptr inbounds [8 x i32], [8 x i32]* %255, i64 0, i64 2
  store i32 15, i32* %256, align 4
  %257 = getelementptr inbounds %struct.stType*, %struct.stType** %4, i64 2
  %258 = load %struct.stType*, %struct.stType** %257, align 8
  %259 = getelementptr inbounds %struct.stType, %struct.stType* %258, i32 0, i32 1
  %260 = getelementptr inbounds [100 x i8], [100 x i8]* %259, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %260, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  call void @branchPruned(%struct.stType** %4)
  call void @branchNotPruned(%struct.stType** %4)
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
