; ModuleID = 'workdir/inter14t2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"*** Branch Taken \0A\00", align 1
@.str.2 = private unnamed_addr constant [23 x i8] c"*** Branch not Taken \0A\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@0 = constant [11 x i8] c"helloWorld\00"
@1 = constant [11 x i8] c"helloWorld\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType** %obj) #0 {
  %1 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i32 0, i32 0
  %4 = load %struct.COORD*, %struct.COORD** %3, align 8
  %5 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i32 0, i32 0
  %6 = load i32*, i32** %5, align 8
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 %7, 1
  br i1 %8, label %9, label %91

; <label>:9                                       ; preds = %0
  %10 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %11 = load %struct.stType*, %struct.stType** %10, align 8
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 0
  %13 = load %struct.COORD*, %struct.COORD** %12, align 8
  %14 = getelementptr inbounds %struct.COORD, %struct.COORD* %13, i32 0, i32 1
  %15 = load i32*, i32** %14, align 8
  %16 = load i32, i32* %15, align 4
  %17 = icmp eq i32 %16, 2
  br i1 %17, label %18, label %91

; <label>:18                                      ; preds = %9
  %19 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %20 = load %struct.stType*, %struct.stType** %19, align 8
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %20, i32 0, i32 1
  %22 = getelementptr inbounds [100 x i8], [100 x i8]* %21, i32 0, i32 0
  %23 = call i32 @strcmp(i8* %22, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %91, label %25

; <label>:25                                      ; preds = %18
  %26 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %27 = load %struct.stType*, %struct.stType** %26, align 8
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i32 0, i32 1
  %29 = getelementptr inbounds [100 x i8], [100 x i8]* %28, i64 0, i64 4
  %30 = load i8, i8* %29, align 4
  %31 = sext i8 %30 to i32
  %32 = icmp eq i32 %31, 111
  br i1 %32, label %33, label %91

; <label>:33                                      ; preds = %25
  %34 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %35 = load %struct.stType*, %struct.stType** %34, align 8
  %36 = getelementptr inbounds %struct.stType, %struct.stType* %35, i32 0, i32 1
  %37 = getelementptr inbounds [100 x i8], [100 x i8]* %36, i64 0, i64 9
  %38 = load i8, i8* %37, align 1
  %39 = sext i8 %38 to i32
  %40 = icmp eq i32 %39, 100
  br i1 %40, label %41, label %91

; <label>:41                                      ; preds = %33
  %42 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %43 = load %struct.stType*, %struct.stType** %42, align 8
  %44 = getelementptr inbounds %struct.stType, %struct.stType* %43, i32 0, i32 0
  %45 = load %struct.COORD*, %struct.COORD** %44, align 8
  %46 = getelementptr inbounds %struct.COORD, %struct.COORD* %45, i32 0, i32 0
  %47 = load i32*, i32** %46, align 8
  %48 = load i32, i32* %47, align 4
  %49 = icmp eq i32 %48, 11
  br i1 %49, label %50, label %91

; <label>:50                                      ; preds = %41
  %51 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %52 = load %struct.stType*, %struct.stType** %51, align 8
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %52, i32 0, i32 0
  %54 = load %struct.COORD*, %struct.COORD** %53, align 8
  %55 = getelementptr inbounds %struct.COORD, %struct.COORD* %54, i32 0, i32 1
  %56 = load i32*, i32** %55, align 8
  %57 = load i32, i32* %56, align 4
  %58 = icmp eq i32 %57, 12
  br i1 %58, label %59, label %91

; <label>:59                                      ; preds = %50
  %60 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %61 = load %struct.stType*, %struct.stType** %60, align 8
  %62 = getelementptr inbounds %struct.stType, %struct.stType* %61, i32 0, i32 2
  %63 = getelementptr inbounds [8 x i32], [8 x i32]* %62, i64 0, i64 1
  %64 = load i32, i32* %63, align 4
  %65 = icmp eq i32 %64, 14
  br i1 %65, label %66, label %91

; <label>:66                                      ; preds = %59
  %67 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %68 = load %struct.stType*, %struct.stType** %67, align 8
  %69 = getelementptr inbounds %struct.stType, %struct.stType* %68, i32 0, i32 1
  %70 = getelementptr inbounds [100 x i8], [100 x i8]* %69, i32 0, i32 0
  %71 = call i32 @strcmp(i8* %70, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %72 = icmp ne i32 %71, 0
  br i1 %72, label %91, label %73

; <label>:73                                      ; preds = %66
  %74 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %75 = load %struct.stType*, %struct.stType** %74, align 8
  %76 = getelementptr inbounds %struct.stType, %struct.stType* %75, i32 0, i32 1
  %77 = getelementptr inbounds [100 x i8], [100 x i8]* %76, i64 0, i64 4
  %78 = load i8, i8* %77, align 4
  %79 = sext i8 %78 to i32
  %80 = icmp eq i32 %79, 111
  br i1 %80, label %81, label %91

; <label>:81                                      ; preds = %73
  %82 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %83 = load %struct.stType*, %struct.stType** %82, align 8
  %84 = getelementptr inbounds %struct.stType, %struct.stType* %83, i32 0, i32 1
  %85 = getelementptr inbounds [100 x i8], [100 x i8]* %84, i64 0, i64 9
  %86 = load i8, i8* %85, align 1
  %87 = sext i8 %86 to i32
  %88 = icmp eq i32 %87, 100
  br i1 %88, label %89, label %91

; <label>:89                                      ; preds = %81
  %90 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %91

; <label>:91                                      ; preds = %89, %81, %73, %66, %59, %50, %41, %33, %25, %18, %9, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define void @branchNotPruned(%struct.stType** %obj) #0 {
  %1 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i32 0, i32 2
  %4 = getelementptr inbounds [8 x i32], [8 x i32]* %3, i64 0, i64 1
  %5 = load i32, i32* %4, align 4
  %6 = icmp eq i32 %5, 4
  br i1 %6, label %7, label %57

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %9 = load %struct.stType*, %struct.stType** %8, align 8
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %9, i32 0, i32 0
  %11 = load %struct.COORD*, %struct.COORD** %10, align 8
  %12 = getelementptr inbounds %struct.COORD, %struct.COORD* %11, i32 0, i32 0
  %13 = load i32*, i32** %12, align 8
  %14 = load i32, i32* %13, align 4
  %15 = icmp eq i32 %14, 16
  br i1 %15, label %16, label %57

; <label>:16                                      ; preds = %7
  %17 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %18 = load %struct.stType*, %struct.stType** %17, align 8
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %18, i32 0, i32 0
  %20 = load %struct.COORD*, %struct.COORD** %19, align 8
  %21 = getelementptr inbounds %struct.COORD, %struct.COORD* %20, i32 0, i32 1
  %22 = load i32*, i32** %21, align 8
  %23 = load i32, i32* %22, align 4
  %24 = icmp eq i32 %23, 17
  br i1 %24, label %25, label %57

; <label>:25                                      ; preds = %16
  %26 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %27 = load %struct.stType*, %struct.stType** %26, align 8
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i32 0, i32 2
  %29 = getelementptr inbounds [8 x i32], [8 x i32]* %28, i64 0, i64 1
  %30 = load i32, i32* %29, align 4
  %31 = icmp eq i32 %30, 19
  br i1 %31, label %32, label %57

; <label>:32                                      ; preds = %25
  %33 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %34 = load %struct.stType*, %struct.stType** %33, align 8
  %35 = getelementptr inbounds %struct.stType, %struct.stType* %34, i32 0, i32 1
  %36 = getelementptr inbounds [100 x i8], [100 x i8]* %35, i32 0, i32 0
  %37 = call i32 @strcmp(i8* %36, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %57, label %39

; <label>:39                                      ; preds = %32
  %40 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %41 = load %struct.stType*, %struct.stType** %40, align 8
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %41, i32 0, i32 1
  %43 = getelementptr inbounds [100 x i8], [100 x i8]* %42, i64 0, i64 4
  %44 = load i8, i8* %43, align 4
  %45 = sext i8 %44 to i32
  %46 = icmp eq i32 %45, 111
  br i1 %46, label %47, label %57

; <label>:47                                      ; preds = %39
  %48 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %49 = load %struct.stType*, %struct.stType** %48, align 8
  %50 = getelementptr inbounds %struct.stType, %struct.stType* %49, i32 0, i32 1
  %51 = getelementptr inbounds [100 x i8], [100 x i8]* %50, i64 0, i64 9
  %52 = load i8, i8* %51, align 1
  %53 = sext i8 %52 to i32
  %54 = icmp eq i32 %53, 100
  br i1 %54, label %55, label %57

; <label>:55                                      ; preds = %47
  %56 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0))
  br label %57

; <label>:57                                      ; preds = %55, %47, %39, %32, %25, %16, %7, %0
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = call noalias i8* @malloc(i64 160) #6
  %2 = bitcast i8* %1 to %struct.stType**
  %3 = call noalias i8* @malloc(i64 144) #6
  %4 = bitcast i8* %3 to %struct.stType*
  %5 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  store %struct.stType* %4, %struct.stType** %5, align 8
  %6 = call noalias i8* @malloc(i64 16) #6
  %7 = bitcast i8* %6 to %struct.COORD*
  %8 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %9 = load %struct.stType*, %struct.stType** %8, align 8
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %9, i32 0, i32 0
  store %struct.COORD* %7, %struct.COORD** %10, align 8
  %11 = call noalias i8* @malloc(i64 4) #6
  %12 = bitcast i8* %11 to i32*
  %13 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %14 = load %struct.stType*, %struct.stType** %13, align 8
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %14, i32 0, i32 0
  %16 = load %struct.COORD*, %struct.COORD** %15, align 8
  %17 = getelementptr inbounds %struct.COORD, %struct.COORD* %16, i32 0, i32 0
  store i32* %12, i32** %17, align 8
  %18 = call noalias i8* @malloc(i64 4) #6
  %19 = bitcast i8* %18 to i32*
  %20 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %21 = load %struct.stType*, %struct.stType** %20, align 8
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %21, i32 0, i32 0
  %23 = load %struct.COORD*, %struct.COORD** %22, align 8
  %24 = getelementptr inbounds %struct.COORD, %struct.COORD* %23, i32 0, i32 1
  store i32* %19, i32** %24, align 8
  %25 = call noalias i8* @malloc(i64 144) #6
  %26 = bitcast i8* %25 to %struct.stType*
  %27 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  store %struct.stType* %26, %struct.stType** %27, align 8
  %28 = call noalias i8* @malloc(i64 16) #6
  %29 = bitcast i8* %28 to %struct.COORD*
  %30 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %31 = load %struct.stType*, %struct.stType** %30, align 8
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %31, i32 0, i32 0
  store %struct.COORD* %29, %struct.COORD** %32, align 8
  %33 = call noalias i8* @malloc(i64 4) #6
  %34 = bitcast i8* %33 to i32*
  %35 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %36 = load %struct.stType*, %struct.stType** %35, align 8
  %37 = getelementptr inbounds %struct.stType, %struct.stType* %36, i32 0, i32 0
  %38 = load %struct.COORD*, %struct.COORD** %37, align 8
  %39 = getelementptr inbounds %struct.COORD, %struct.COORD* %38, i32 0, i32 0
  store i32* %34, i32** %39, align 8
  %40 = call noalias i8* @malloc(i64 4) #6
  %41 = bitcast i8* %40 to i32*
  %42 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %43 = load %struct.stType*, %struct.stType** %42, align 8
  %44 = getelementptr inbounds %struct.stType, %struct.stType* %43, i32 0, i32 0
  %45 = load %struct.COORD*, %struct.COORD** %44, align 8
  %46 = getelementptr inbounds %struct.COORD, %struct.COORD* %45, i32 0, i32 1
  store i32* %41, i32** %46, align 8
  %47 = call noalias i8* @malloc(i64 144) #6
  %48 = bitcast i8* %47 to %struct.stType*
  %49 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  store %struct.stType* %48, %struct.stType** %49, align 8
  %50 = call noalias i8* @malloc(i64 16) #6
  %51 = bitcast i8* %50 to %struct.COORD*
  %52 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %53 = load %struct.stType*, %struct.stType** %52, align 8
  %54 = getelementptr inbounds %struct.stType, %struct.stType* %53, i32 0, i32 0
  store %struct.COORD* %51, %struct.COORD** %54, align 8
  %55 = call noalias i8* @malloc(i64 4) #6
  %56 = bitcast i8* %55 to i32*
  %57 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %58 = load %struct.stType*, %struct.stType** %57, align 8
  %59 = getelementptr inbounds %struct.stType, %struct.stType* %58, i32 0, i32 0
  %60 = load %struct.COORD*, %struct.COORD** %59, align 8
  %61 = getelementptr inbounds %struct.COORD, %struct.COORD* %60, i32 0, i32 0
  store i32* %56, i32** %61, align 8
  %62 = call noalias i8* @malloc(i64 4) #6
  %63 = bitcast i8* %62 to i32*
  %64 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %65 = load %struct.stType*, %struct.stType** %64, align 8
  %66 = getelementptr inbounds %struct.stType, %struct.stType* %65, i32 0, i32 0
  %67 = load %struct.COORD*, %struct.COORD** %66, align 8
  %68 = getelementptr inbounds %struct.COORD, %struct.COORD* %67, i32 0, i32 1
  store i32* %63, i32** %68, align 8
  %69 = icmp sgt i32 %argc, 2
  %70 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %71 = load %struct.stType*, %struct.stType** %70, align 8
  %72 = getelementptr inbounds %struct.stType, %struct.stType* %71, i32 0, i32 0
  %73 = load %struct.COORD*, %struct.COORD** %72, align 8
  %74 = getelementptr inbounds %struct.COORD, %struct.COORD* %73, i32 0, i32 0
  %75 = load i32*, i32** %74, align 8
  %76 = getelementptr inbounds i32, i32* %75, i64 0
  store i32 1, i32* %76, align 4
  %77 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %78 = load %struct.stType*, %struct.stType** %77, align 8
  %79 = getelementptr inbounds %struct.stType, %struct.stType* %78, i32 0, i32 0
  %80 = load %struct.COORD*, %struct.COORD** %79, align 8
  %81 = getelementptr inbounds %struct.COORD, %struct.COORD* %80, i32 0, i32 1
  %82 = load i32*, i32** %81, align 8
  %83 = getelementptr inbounds i32, i32* %82, i64 0
  store i32 2, i32* %83, align 4
  br i1 %69, label %84, label %127

; <label>:84                                      ; preds = %0
  %85 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %86 = load %struct.stType*, %struct.stType** %85, align 8
  %87 = getelementptr inbounds %struct.stType, %struct.stType* %86, i32 0, i32 2
  %88 = getelementptr inbounds [8 x i32], [8 x i32]* %87, i64 0, i64 0
  store i32 3, i32* %88, align 4
  %89 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %90 = load %struct.stType*, %struct.stType** %89, align 8
  %91 = getelementptr inbounds %struct.stType, %struct.stType* %90, i32 0, i32 2
  %92 = getelementptr inbounds [8 x i32], [8 x i32]* %91, i64 0, i64 1
  store i32 4, i32* %92, align 4
  %93 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %94 = load %struct.stType*, %struct.stType** %93, align 8
  %95 = getelementptr inbounds %struct.stType, %struct.stType* %94, i32 0, i32 2
  %96 = getelementptr inbounds [8 x i32], [8 x i32]* %95, i64 0, i64 2
  store i32 5, i32* %96, align 4
  %97 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %98 = load %struct.stType*, %struct.stType** %97, align 8
  %99 = getelementptr inbounds %struct.stType, %struct.stType* %98, i32 0, i32 0
  %100 = load %struct.COORD*, %struct.COORD** %99, align 8
  %101 = getelementptr inbounds %struct.COORD, %struct.COORD* %100, i32 0, i32 0
  %102 = load i32*, i32** %101, align 8
  %103 = getelementptr inbounds i32, i32* %102, i64 0
  store i32 16, i32* %103, align 4
  %104 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %105 = load %struct.stType*, %struct.stType** %104, align 8
  %106 = getelementptr inbounds %struct.stType, %struct.stType* %105, i32 0, i32 0
  %107 = load %struct.COORD*, %struct.COORD** %106, align 8
  %108 = getelementptr inbounds %struct.COORD, %struct.COORD* %107, i32 0, i32 1
  %109 = load i32*, i32** %108, align 8
  %110 = getelementptr inbounds i32, i32* %109, i64 0
  store i32 17, i32* %110, align 4
  %111 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %112 = load %struct.stType*, %struct.stType** %111, align 8
  %113 = getelementptr inbounds %struct.stType, %struct.stType* %112, i32 0, i32 2
  %114 = getelementptr inbounds [8 x i32], [8 x i32]* %113, i64 0, i64 0
  store i32 18, i32* %114, align 4
  %115 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %116 = load %struct.stType*, %struct.stType** %115, align 8
  %117 = getelementptr inbounds %struct.stType, %struct.stType* %116, i32 0, i32 2
  %118 = getelementptr inbounds [8 x i32], [8 x i32]* %117, i64 0, i64 1
  store i32 19, i32* %118, align 4
  %119 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %120 = load %struct.stType*, %struct.stType** %119, align 8
  %121 = getelementptr inbounds %struct.stType, %struct.stType* %120, i32 0, i32 2
  %122 = getelementptr inbounds [8 x i32], [8 x i32]* %121, i64 0, i64 2
  store i32 20, i32* %122, align 4
  %123 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %124 = load %struct.stType*, %struct.stType** %123, align 8
  %125 = getelementptr inbounds %struct.stType, %struct.stType* %124, i32 0, i32 1
  %126 = getelementptr inbounds [100 x i8], [100 x i8]* %125, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %126, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %158

; <label>:127                                     ; preds = %0
  %128 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %129 = load %struct.stType*, %struct.stType** %128, align 8
  %130 = getelementptr inbounds %struct.stType, %struct.stType* %129, i32 0, i32 0
  %131 = load %struct.COORD*, %struct.COORD** %130, align 8
  %132 = getelementptr inbounds %struct.COORD, %struct.COORD* %131, i32 0, i32 0
  %133 = load i32*, i32** %132, align 8
  %134 = getelementptr inbounds i32, i32* %133, i64 0
  store i32 6, i32* %134, align 4
  %135 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %136 = load %struct.stType*, %struct.stType** %135, align 8
  %137 = getelementptr inbounds %struct.stType, %struct.stType* %136, i32 0, i32 0
  %138 = load %struct.COORD*, %struct.COORD** %137, align 8
  %139 = getelementptr inbounds %struct.COORD, %struct.COORD* %138, i32 0, i32 1
  %140 = load i32*, i32** %139, align 8
  %141 = getelementptr inbounds i32, i32* %140, i64 0
  store i32 7, i32* %141, align 4
  %142 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %143 = load %struct.stType*, %struct.stType** %142, align 8
  %144 = getelementptr inbounds %struct.stType, %struct.stType* %143, i32 0, i32 2
  %145 = getelementptr inbounds [8 x i32], [8 x i32]* %144, i64 0, i64 0
  store i32 8, i32* %145, align 4
  %146 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %147 = load %struct.stType*, %struct.stType** %146, align 8
  %148 = getelementptr inbounds %struct.stType, %struct.stType* %147, i32 0, i32 2
  %149 = getelementptr inbounds [8 x i32], [8 x i32]* %148, i64 0, i64 1
  store i32 9, i32* %149, align 4
  %150 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %151 = load %struct.stType*, %struct.stType** %150, align 8
  %152 = getelementptr inbounds %struct.stType, %struct.stType* %151, i32 0, i32 2
  %153 = getelementptr inbounds [8 x i32], [8 x i32]* %152, i64 0, i64 2
  store i32 10, i32* %153, align 4
  %154 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %155 = load %struct.stType*, %struct.stType** %154, align 8
  %156 = getelementptr inbounds %struct.stType, %struct.stType* %155, i32 0, i32 1
  %157 = getelementptr inbounds [100 x i8], [100 x i8]* %156, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %157, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %158

; <label>:158                                     ; preds = %127, %84
  %159 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %160 = load %struct.stType*, %struct.stType** %159, align 8
  %161 = getelementptr inbounds %struct.stType, %struct.stType* %160, i32 0, i32 1
  %162 = getelementptr inbounds [100 x i8], [100 x i8]* %161, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %162, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %163 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %164 = load %struct.stType*, %struct.stType** %163, align 8
  %165 = getelementptr inbounds %struct.stType, %struct.stType* %164, i32 0, i32 0
  %166 = load %struct.COORD*, %struct.COORD** %165, align 8
  %167 = getelementptr inbounds %struct.COORD, %struct.COORD* %166, i32 0, i32 0
  %168 = load i32*, i32** %167, align 8
  %169 = getelementptr inbounds i32, i32* %168, i64 0
  store i32 6, i32* %169, align 4
  %170 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %171 = load %struct.stType*, %struct.stType** %170, align 8
  %172 = getelementptr inbounds %struct.stType, %struct.stType* %171, i32 0, i32 0
  %173 = load %struct.COORD*, %struct.COORD** %172, align 8
  %174 = getelementptr inbounds %struct.COORD, %struct.COORD* %173, i32 0, i32 1
  %175 = load i32*, i32** %174, align 8
  %176 = getelementptr inbounds i32, i32* %175, i64 0
  store i32 7, i32* %176, align 4
  %177 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %178 = load %struct.stType*, %struct.stType** %177, align 8
  %179 = getelementptr inbounds %struct.stType, %struct.stType* %178, i32 0, i32 2
  %180 = getelementptr inbounds [8 x i32], [8 x i32]* %179, i64 0, i64 0
  store i32 8, i32* %180, align 4
  %181 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %182 = load %struct.stType*, %struct.stType** %181, align 8
  %183 = getelementptr inbounds %struct.stType, %struct.stType* %182, i32 0, i32 2
  %184 = getelementptr inbounds [8 x i32], [8 x i32]* %183, i64 0, i64 1
  store i32 9, i32* %184, align 4
  %185 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %186 = load %struct.stType*, %struct.stType** %185, align 8
  %187 = getelementptr inbounds %struct.stType, %struct.stType* %186, i32 0, i32 2
  %188 = getelementptr inbounds [8 x i32], [8 x i32]* %187, i64 0, i64 2
  store i32 10, i32* %188, align 4
  %189 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %190 = load %struct.stType*, %struct.stType** %189, align 8
  %191 = getelementptr inbounds %struct.stType, %struct.stType* %190, i32 0, i32 1
  %192 = getelementptr inbounds [100 x i8], [100 x i8]* %191, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %192, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %193 = call noalias i8* @malloc(i64 144) #6
  %194 = bitcast i8* %193 to %struct.stType*
  %195 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  store %struct.stType* %194, %struct.stType** %195, align 8
  %196 = call noalias i8* @malloc(i64 16) #6
  %197 = bitcast i8* %196 to %struct.COORD*
  %198 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %199 = load %struct.stType*, %struct.stType** %198, align 8
  %200 = getelementptr inbounds %struct.stType, %struct.stType* %199, i32 0, i32 0
  store %struct.COORD* %197, %struct.COORD** %200, align 8
  %201 = call noalias i8* @malloc(i64 4) #6
  %202 = bitcast i8* %201 to i32*
  %203 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %204 = load %struct.stType*, %struct.stType** %203, align 8
  %205 = getelementptr inbounds %struct.stType, %struct.stType* %204, i32 0, i32 0
  %206 = load %struct.COORD*, %struct.COORD** %205, align 8
  %207 = getelementptr inbounds %struct.COORD, %struct.COORD* %206, i32 0, i32 0
  store i32* %202, i32** %207, align 8
  %208 = call noalias i8* @malloc(i64 4) #6
  %209 = bitcast i8* %208 to i32*
  %210 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %211 = load %struct.stType*, %struct.stType** %210, align 8
  %212 = getelementptr inbounds %struct.stType, %struct.stType* %211, i32 0, i32 0
  %213 = load %struct.COORD*, %struct.COORD** %212, align 8
  %214 = getelementptr inbounds %struct.COORD, %struct.COORD* %213, i32 0, i32 1
  store i32* %209, i32** %214, align 8
  %215 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %216 = load %struct.stType*, %struct.stType** %215, align 8
  %217 = getelementptr inbounds %struct.stType, %struct.stType* %216, i32 0, i32 0
  %218 = load %struct.COORD*, %struct.COORD** %217, align 8
  %219 = getelementptr inbounds %struct.COORD, %struct.COORD* %218, i32 0, i32 0
  %220 = load i32*, i32** %219, align 8
  %221 = getelementptr inbounds i32, i32* %220, i64 0
  store i32 11, i32* %221, align 4
  %222 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %223 = load %struct.stType*, %struct.stType** %222, align 8
  %224 = getelementptr inbounds %struct.stType, %struct.stType* %223, i32 0, i32 0
  %225 = load %struct.COORD*, %struct.COORD** %224, align 8
  %226 = getelementptr inbounds %struct.COORD, %struct.COORD* %225, i32 0, i32 1
  %227 = load i32*, i32** %226, align 8
  %228 = getelementptr inbounds i32, i32* %227, i64 0
  store i32 12, i32* %228, align 4
  %229 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %230 = load %struct.stType*, %struct.stType** %229, align 8
  %231 = getelementptr inbounds %struct.stType, %struct.stType* %230, i32 0, i32 2
  %232 = getelementptr inbounds [8 x i32], [8 x i32]* %231, i64 0, i64 0
  store i32 13, i32* %232, align 4
  %233 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %234 = load %struct.stType*, %struct.stType** %233, align 8
  %235 = getelementptr inbounds %struct.stType, %struct.stType* %234, i32 0, i32 2
  %236 = getelementptr inbounds [8 x i32], [8 x i32]* %235, i64 0, i64 1
  store i32 14, i32* %236, align 4
  %237 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %238 = load %struct.stType*, %struct.stType** %237, align 8
  %239 = getelementptr inbounds %struct.stType, %struct.stType* %238, i32 0, i32 2
  %240 = getelementptr inbounds [8 x i32], [8 x i32]* %239, i64 0, i64 2
  store i32 15, i32* %240, align 4
  %241 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %242 = load %struct.stType*, %struct.stType** %241, align 8
  %243 = getelementptr inbounds %struct.stType, %struct.stType* %242, i32 0, i32 1
  %244 = getelementptr inbounds [100 x i8], [100 x i8]* %243, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %244, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  call void @branchPruned_clone(%struct.stType** %2)
  call void @branchNotPruned(%struct.stType** %2)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #4

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType** %obj) #0 {
  %1 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i32 0, i32 0
  %4 = load %struct.COORD*, %struct.COORD** %3, align 8
  %5 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i32 0, i32 0
  %6 = load i32*, i32** %5, align 8
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 1, 1
  br i1 %8, label %9, label %93

; <label>:9                                       ; preds = %0
  %10 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %11 = load %struct.stType*, %struct.stType** %10, align 8
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 0
  %13 = load %struct.COORD*, %struct.COORD** %12, align 8
  %14 = getelementptr inbounds %struct.COORD, %struct.COORD* %13, i32 0, i32 1
  %15 = load i32*, i32** %14, align 8
  %16 = load i32, i32* %15, align 4
  %17 = icmp eq i32 2, 2
  br i1 %17, label %18, label %93

; <label>:18                                      ; preds = %9
  %19 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %20 = load %struct.stType*, %struct.stType** %19, align 8
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %20, i32 0, i32 1
  %22 = getelementptr inbounds [100 x i8], [100 x i8]* %21, i32 0, i32 0
  %23 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %24 = call i32 @strcmp(i8* %23, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %25 = icmp ne i32 0, 0
  br i1 %25, label %93, label %26

; <label>:26                                      ; preds = %18
  %27 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %28 = load %struct.stType*, %struct.stType** %27, align 8
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i32 0, i32 1
  %30 = getelementptr inbounds [100 x i8], [100 x i8]* %29, i64 0, i64 4
  %31 = load i8, i8* %30, align 4
  %32 = sext i8 111 to i32
  %33 = icmp eq i32 %32, 111
  br i1 %33, label %34, label %93

; <label>:34                                      ; preds = %26
  %35 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %36 = load %struct.stType*, %struct.stType** %35, align 8
  %37 = getelementptr inbounds %struct.stType, %struct.stType* %36, i32 0, i32 1
  %38 = getelementptr inbounds [100 x i8], [100 x i8]* %37, i64 0, i64 9
  %39 = load i8, i8* %38, align 1
  %40 = sext i8 100 to i32
  %41 = icmp eq i32 %40, 100
  br i1 %41, label %42, label %93

; <label>:42                                      ; preds = %34
  %43 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %44 = load %struct.stType*, %struct.stType** %43, align 8
  %45 = getelementptr inbounds %struct.stType, %struct.stType* %44, i32 0, i32 0
  %46 = load %struct.COORD*, %struct.COORD** %45, align 8
  %47 = getelementptr inbounds %struct.COORD, %struct.COORD* %46, i32 0, i32 0
  %48 = load i32*, i32** %47, align 8
  %49 = load i32, i32* %48, align 4
  %50 = icmp eq i32 11, 11
  br i1 %50, label %51, label %93

; <label>:51                                      ; preds = %42
  %52 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %53 = load %struct.stType*, %struct.stType** %52, align 8
  %54 = getelementptr inbounds %struct.stType, %struct.stType* %53, i32 0, i32 0
  %55 = load %struct.COORD*, %struct.COORD** %54, align 8
  %56 = getelementptr inbounds %struct.COORD, %struct.COORD* %55, i32 0, i32 1
  %57 = load i32*, i32** %56, align 8
  %58 = load i32, i32* %57, align 4
  %59 = icmp eq i32 12, 12
  br i1 %59, label %60, label %93

; <label>:60                                      ; preds = %51
  %61 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %62 = load %struct.stType*, %struct.stType** %61, align 8
  %63 = getelementptr inbounds %struct.stType, %struct.stType* %62, i32 0, i32 2
  %64 = getelementptr inbounds [8 x i32], [8 x i32]* %63, i64 0, i64 1
  %65 = load i32, i32* %64, align 4
  %66 = icmp eq i32 14, 14
  br i1 %66, label %67, label %93

; <label>:67                                      ; preds = %60
  %68 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %69 = load %struct.stType*, %struct.stType** %68, align 8
  %70 = getelementptr inbounds %struct.stType, %struct.stType* %69, i32 0, i32 1
  %71 = getelementptr inbounds [100 x i8], [100 x i8]* %70, i32 0, i32 0
  %72 = getelementptr [11 x i8], [11 x i8]* @1, i64 0, i64 0
  %73 = call i32 @strcmp(i8* %72, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %74 = icmp ne i32 0, 0
  br i1 %74, label %93, label %75

; <label>:75                                      ; preds = %67
  %76 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %77 = load %struct.stType*, %struct.stType** %76, align 8
  %78 = getelementptr inbounds %struct.stType, %struct.stType* %77, i32 0, i32 1
  %79 = getelementptr inbounds [100 x i8], [100 x i8]* %78, i64 0, i64 4
  %80 = load i8, i8* %79, align 4
  %81 = sext i8 111 to i32
  %82 = icmp eq i32 %81, 111
  br i1 %82, label %83, label %93

; <label>:83                                      ; preds = %75
  %84 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %85 = load %struct.stType*, %struct.stType** %84, align 8
  %86 = getelementptr inbounds %struct.stType, %struct.stType* %85, i32 0, i32 1
  %87 = getelementptr inbounds [100 x i8], [100 x i8]* %86, i64 0, i64 9
  %88 = load i8, i8* %87, align 1
  %89 = sext i8 100 to i32
  %90 = icmp eq i32 %89, 100
  br i1 %90, label %91, label %93

; <label>:91                                      ; preds = %83
  %92 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %93

; <label>:93                                      ; preds = %91, %83, %75, %67, %60, %51, %42, %34, %26, %18, %9, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(%struct.stType** %obj) #0 {
  %1 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i32 0, i32 2
  %4 = getelementptr inbounds [8 x i32], [8 x i32]* %3, i64 0, i64 1
  %5 = load i32, i32* %4, align 4
  %6 = icmp eq i32 %5, 4
  br i1 %6, label %7, label %57

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %9 = load %struct.stType*, %struct.stType** %8, align 8
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %9, i32 0, i32 0
  %11 = load %struct.COORD*, %struct.COORD** %10, align 8
  %12 = getelementptr inbounds %struct.COORD, %struct.COORD* %11, i32 0, i32 0
  %13 = load i32*, i32** %12, align 8
  %14 = load i32, i32* %13, align 4
  %15 = icmp eq i32 %14, 16
  br i1 %15, label %16, label %57

; <label>:16                                      ; preds = %7
  %17 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %18 = load %struct.stType*, %struct.stType** %17, align 8
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %18, i32 0, i32 0
  %20 = load %struct.COORD*, %struct.COORD** %19, align 8
  %21 = getelementptr inbounds %struct.COORD, %struct.COORD* %20, i32 0, i32 1
  %22 = load i32*, i32** %21, align 8
  %23 = load i32, i32* %22, align 4
  %24 = icmp eq i32 %23, 17
  br i1 %24, label %25, label %57

; <label>:25                                      ; preds = %16
  %26 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %27 = load %struct.stType*, %struct.stType** %26, align 8
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i32 0, i32 2
  %29 = getelementptr inbounds [8 x i32], [8 x i32]* %28, i64 0, i64 1
  %30 = load i32, i32* %29, align 4
  %31 = icmp eq i32 %30, 19
  br i1 %31, label %32, label %57

; <label>:32                                      ; preds = %25
  %33 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %34 = load %struct.stType*, %struct.stType** %33, align 8
  %35 = getelementptr inbounds %struct.stType, %struct.stType* %34, i32 0, i32 1
  %36 = getelementptr inbounds [100 x i8], [100 x i8]* %35, i32 0, i32 0
  %37 = call i32 @strcmp(i8* %36, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %57, label %39

; <label>:39                                      ; preds = %32
  %40 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %41 = load %struct.stType*, %struct.stType** %40, align 8
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %41, i32 0, i32 1
  %43 = getelementptr inbounds [100 x i8], [100 x i8]* %42, i64 0, i64 4
  %44 = load i8, i8* %43, align 4
  %45 = sext i8 %44 to i32
  %46 = icmp eq i32 %45, 111
  br i1 %46, label %47, label %57

; <label>:47                                      ; preds = %39
  %48 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %49 = load %struct.stType*, %struct.stType** %48, align 8
  %50 = getelementptr inbounds %struct.stType, %struct.stType* %49, i32 0, i32 1
  %51 = getelementptr inbounds [100 x i8], [100 x i8]* %50, i64 0, i64 9
  %52 = load i8, i8* %51, align 1
  %53 = sext i8 %52 to i32
  %54 = icmp eq i32 %53, 100
  br i1 %54, label %55, label %57

; <label>:55                                      ; preds = %47
  %56 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0))
  br label %57

; <label>:57                                      ; preds = %55, %47, %39, %32, %25, %16, %7, %0
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
