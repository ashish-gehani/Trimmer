; ModuleID = 'workdir/inter20t3.bc'
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
  br i1 %69, label %70, label %145

; <label>:70                                      ; preds = %0
  %71 = icmp sgt i32 %argc, 5
  br i1 %71, label %72, label %87

; <label>:72                                      ; preds = %70
  %73 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %74 = load %struct.stType*, %struct.stType** %73, align 8
  %75 = getelementptr inbounds %struct.stType, %struct.stType* %74, i32 0, i32 0
  %76 = load %struct.COORD*, %struct.COORD** %75, align 8
  %77 = getelementptr inbounds %struct.COORD, %struct.COORD* %76, i32 0, i32 0
  %78 = load i32*, i32** %77, align 8
  %79 = getelementptr inbounds i32, i32* %78, i64 0
  store i32 1, i32* %79, align 4
  %80 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %81 = load %struct.stType*, %struct.stType** %80, align 8
  %82 = getelementptr inbounds %struct.stType, %struct.stType* %81, i32 0, i32 0
  %83 = load %struct.COORD*, %struct.COORD** %82, align 8
  %84 = getelementptr inbounds %struct.COORD, %struct.COORD* %83, i32 0, i32 1
  %85 = load i32*, i32** %84, align 8
  %86 = getelementptr inbounds i32, i32* %85, i64 0
  store i32 2, i32* %86, align 4
  br label %102

; <label>:87                                      ; preds = %70
  %88 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %89 = load %struct.stType*, %struct.stType** %88, align 8
  %90 = getelementptr inbounds %struct.stType, %struct.stType* %89, i32 0, i32 0
  %91 = load %struct.COORD*, %struct.COORD** %90, align 8
  %92 = getelementptr inbounds %struct.COORD, %struct.COORD* %91, i32 0, i32 0
  %93 = load i32*, i32** %92, align 8
  %94 = getelementptr inbounds i32, i32* %93, i64 0
  store i32 1, i32* %94, align 4
  %95 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %96 = load %struct.stType*, %struct.stType** %95, align 8
  %97 = getelementptr inbounds %struct.stType, %struct.stType* %96, i32 0, i32 0
  %98 = load %struct.COORD*, %struct.COORD** %97, align 8
  %99 = getelementptr inbounds %struct.COORD, %struct.COORD* %98, i32 0, i32 1
  %100 = load i32*, i32** %99, align 8
  %101 = getelementptr inbounds i32, i32* %100, i64 0
  store i32 2, i32* %101, align 4
  br label %102

; <label>:102                                     ; preds = %87, %72
  %103 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %104 = load %struct.stType*, %struct.stType** %103, align 8
  %105 = getelementptr inbounds %struct.stType, %struct.stType* %104, i32 0, i32 2
  %106 = getelementptr inbounds [8 x i32], [8 x i32]* %105, i64 0, i64 0
  store i32 3, i32* %106, align 4
  %107 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %108 = load %struct.stType*, %struct.stType** %107, align 8
  %109 = getelementptr inbounds %struct.stType, %struct.stType* %108, i32 0, i32 2
  %110 = getelementptr inbounds [8 x i32], [8 x i32]* %109, i64 0, i64 1
  store i32 4, i32* %110, align 4
  %111 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %112 = load %struct.stType*, %struct.stType** %111, align 8
  %113 = getelementptr inbounds %struct.stType, %struct.stType* %112, i32 0, i32 2
  %114 = getelementptr inbounds [8 x i32], [8 x i32]* %113, i64 0, i64 2
  store i32 5, i32* %114, align 4
  %115 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %116 = load %struct.stType*, %struct.stType** %115, align 8
  %117 = getelementptr inbounds %struct.stType, %struct.stType* %116, i32 0, i32 0
  %118 = load %struct.COORD*, %struct.COORD** %117, align 8
  %119 = getelementptr inbounds %struct.COORD, %struct.COORD* %118, i32 0, i32 0
  %120 = load i32*, i32** %119, align 8
  %121 = getelementptr inbounds i32, i32* %120, i64 0
  store i32 16, i32* %121, align 4
  %122 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %123 = load %struct.stType*, %struct.stType** %122, align 8
  %124 = getelementptr inbounds %struct.stType, %struct.stType* %123, i32 0, i32 0
  %125 = load %struct.COORD*, %struct.COORD** %124, align 8
  %126 = getelementptr inbounds %struct.COORD, %struct.COORD* %125, i32 0, i32 1
  %127 = load i32*, i32** %126, align 8
  %128 = getelementptr inbounds i32, i32* %127, i64 0
  store i32 17, i32* %128, align 4
  %129 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %130 = load %struct.stType*, %struct.stType** %129, align 8
  %131 = getelementptr inbounds %struct.stType, %struct.stType* %130, i32 0, i32 2
  %132 = getelementptr inbounds [8 x i32], [8 x i32]* %131, i64 0, i64 0
  store i32 18, i32* %132, align 4
  %133 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %134 = load %struct.stType*, %struct.stType** %133, align 8
  %135 = getelementptr inbounds %struct.stType, %struct.stType* %134, i32 0, i32 2
  %136 = getelementptr inbounds [8 x i32], [8 x i32]* %135, i64 0, i64 1
  store i32 19, i32* %136, align 4
  %137 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %138 = load %struct.stType*, %struct.stType** %137, align 8
  %139 = getelementptr inbounds %struct.stType, %struct.stType* %138, i32 0, i32 2
  %140 = getelementptr inbounds [8 x i32], [8 x i32]* %139, i64 0, i64 2
  store i32 20, i32* %140, align 4
  %141 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %142 = load %struct.stType*, %struct.stType** %141, align 8
  %143 = getelementptr inbounds %struct.stType, %struct.stType* %142, i32 0, i32 1
  %144 = getelementptr inbounds [100 x i8], [100 x i8]* %143, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %144, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %190

; <label>:145                                     ; preds = %0
  %146 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %147 = load %struct.stType*, %struct.stType** %146, align 8
  %148 = getelementptr inbounds %struct.stType, %struct.stType* %147, i32 0, i32 0
  %149 = load %struct.COORD*, %struct.COORD** %148, align 8
  %150 = getelementptr inbounds %struct.COORD, %struct.COORD* %149, i32 0, i32 0
  %151 = load i32*, i32** %150, align 8
  %152 = getelementptr inbounds i32, i32* %151, i64 0
  store i32 1, i32* %152, align 4
  %153 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %154 = load %struct.stType*, %struct.stType** %153, align 8
  %155 = getelementptr inbounds %struct.stType, %struct.stType* %154, i32 0, i32 0
  %156 = load %struct.COORD*, %struct.COORD** %155, align 8
  %157 = getelementptr inbounds %struct.COORD, %struct.COORD* %156, i32 0, i32 1
  %158 = load i32*, i32** %157, align 8
  %159 = getelementptr inbounds i32, i32* %158, i64 0
  store i32 2, i32* %159, align 4
  %160 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %161 = load %struct.stType*, %struct.stType** %160, align 8
  %162 = getelementptr inbounds %struct.stType, %struct.stType* %161, i32 0, i32 0
  %163 = load %struct.COORD*, %struct.COORD** %162, align 8
  %164 = getelementptr inbounds %struct.COORD, %struct.COORD* %163, i32 0, i32 0
  %165 = load i32*, i32** %164, align 8
  %166 = getelementptr inbounds i32, i32* %165, i64 0
  store i32 6, i32* %166, align 4
  %167 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %168 = load %struct.stType*, %struct.stType** %167, align 8
  %169 = getelementptr inbounds %struct.stType, %struct.stType* %168, i32 0, i32 0
  %170 = load %struct.COORD*, %struct.COORD** %169, align 8
  %171 = getelementptr inbounds %struct.COORD, %struct.COORD* %170, i32 0, i32 1
  %172 = load i32*, i32** %171, align 8
  %173 = getelementptr inbounds i32, i32* %172, i64 0
  store i32 7, i32* %173, align 4
  %174 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %175 = load %struct.stType*, %struct.stType** %174, align 8
  %176 = getelementptr inbounds %struct.stType, %struct.stType* %175, i32 0, i32 2
  %177 = getelementptr inbounds [8 x i32], [8 x i32]* %176, i64 0, i64 0
  store i32 8, i32* %177, align 4
  %178 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %179 = load %struct.stType*, %struct.stType** %178, align 8
  %180 = getelementptr inbounds %struct.stType, %struct.stType* %179, i32 0, i32 2
  %181 = getelementptr inbounds [8 x i32], [8 x i32]* %180, i64 0, i64 1
  store i32 9, i32* %181, align 4
  %182 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %183 = load %struct.stType*, %struct.stType** %182, align 8
  %184 = getelementptr inbounds %struct.stType, %struct.stType* %183, i32 0, i32 2
  %185 = getelementptr inbounds [8 x i32], [8 x i32]* %184, i64 0, i64 2
  store i32 10, i32* %185, align 4
  %186 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %187 = load %struct.stType*, %struct.stType** %186, align 8
  %188 = getelementptr inbounds %struct.stType, %struct.stType* %187, i32 0, i32 1
  %189 = getelementptr inbounds [100 x i8], [100 x i8]* %188, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %189, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %190

; <label>:190                                     ; preds = %145, %102
  %191 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %192 = load %struct.stType*, %struct.stType** %191, align 8
  %193 = getelementptr inbounds %struct.stType, %struct.stType* %192, i32 0, i32 1
  %194 = getelementptr inbounds [100 x i8], [100 x i8]* %193, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %194, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %195 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %196 = load %struct.stType*, %struct.stType** %195, align 8
  %197 = getelementptr inbounds %struct.stType, %struct.stType* %196, i32 0, i32 0
  %198 = load %struct.COORD*, %struct.COORD** %197, align 8
  %199 = getelementptr inbounds %struct.COORD, %struct.COORD* %198, i32 0, i32 0
  %200 = load i32*, i32** %199, align 8
  %201 = getelementptr inbounds i32, i32* %200, i64 0
  store i32 6, i32* %201, align 4
  %202 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %203 = load %struct.stType*, %struct.stType** %202, align 8
  %204 = getelementptr inbounds %struct.stType, %struct.stType* %203, i32 0, i32 0
  %205 = load %struct.COORD*, %struct.COORD** %204, align 8
  %206 = getelementptr inbounds %struct.COORD, %struct.COORD* %205, i32 0, i32 1
  %207 = load i32*, i32** %206, align 8
  %208 = getelementptr inbounds i32, i32* %207, i64 0
  store i32 7, i32* %208, align 4
  %209 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %210 = load %struct.stType*, %struct.stType** %209, align 8
  %211 = getelementptr inbounds %struct.stType, %struct.stType* %210, i32 0, i32 2
  %212 = getelementptr inbounds [8 x i32], [8 x i32]* %211, i64 0, i64 0
  store i32 8, i32* %212, align 4
  %213 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %214 = load %struct.stType*, %struct.stType** %213, align 8
  %215 = getelementptr inbounds %struct.stType, %struct.stType* %214, i32 0, i32 2
  %216 = getelementptr inbounds [8 x i32], [8 x i32]* %215, i64 0, i64 1
  store i32 9, i32* %216, align 4
  %217 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %218 = load %struct.stType*, %struct.stType** %217, align 8
  %219 = getelementptr inbounds %struct.stType, %struct.stType* %218, i32 0, i32 2
  %220 = getelementptr inbounds [8 x i32], [8 x i32]* %219, i64 0, i64 2
  store i32 10, i32* %220, align 4
  %221 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %222 = load %struct.stType*, %struct.stType** %221, align 8
  %223 = getelementptr inbounds %struct.stType, %struct.stType* %222, i32 0, i32 1
  %224 = getelementptr inbounds [100 x i8], [100 x i8]* %223, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %224, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %225 = call noalias i8* @malloc(i64 144) #6
  %226 = bitcast i8* %225 to %struct.stType*
  %227 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  store %struct.stType* %226, %struct.stType** %227, align 8
  %228 = call noalias i8* @malloc(i64 16) #6
  %229 = bitcast i8* %228 to %struct.COORD*
  %230 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %231 = load %struct.stType*, %struct.stType** %230, align 8
  %232 = getelementptr inbounds %struct.stType, %struct.stType* %231, i32 0, i32 0
  store %struct.COORD* %229, %struct.COORD** %232, align 8
  %233 = call noalias i8* @malloc(i64 4) #6
  %234 = bitcast i8* %233 to i32*
  %235 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %236 = load %struct.stType*, %struct.stType** %235, align 8
  %237 = getelementptr inbounds %struct.stType, %struct.stType* %236, i32 0, i32 0
  %238 = load %struct.COORD*, %struct.COORD** %237, align 8
  %239 = getelementptr inbounds %struct.COORD, %struct.COORD* %238, i32 0, i32 0
  store i32* %234, i32** %239, align 8
  %240 = call noalias i8* @malloc(i64 4) #6
  %241 = bitcast i8* %240 to i32*
  %242 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %243 = load %struct.stType*, %struct.stType** %242, align 8
  %244 = getelementptr inbounds %struct.stType, %struct.stType* %243, i32 0, i32 0
  %245 = load %struct.COORD*, %struct.COORD** %244, align 8
  %246 = getelementptr inbounds %struct.COORD, %struct.COORD* %245, i32 0, i32 1
  store i32* %241, i32** %246, align 8
  %247 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %248 = load %struct.stType*, %struct.stType** %247, align 8
  %249 = getelementptr inbounds %struct.stType, %struct.stType* %248, i32 0, i32 0
  %250 = load %struct.COORD*, %struct.COORD** %249, align 8
  %251 = getelementptr inbounds %struct.COORD, %struct.COORD* %250, i32 0, i32 0
  %252 = load i32*, i32** %251, align 8
  %253 = getelementptr inbounds i32, i32* %252, i64 0
  store i32 11, i32* %253, align 4
  %254 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %255 = load %struct.stType*, %struct.stType** %254, align 8
  %256 = getelementptr inbounds %struct.stType, %struct.stType* %255, i32 0, i32 0
  %257 = load %struct.COORD*, %struct.COORD** %256, align 8
  %258 = getelementptr inbounds %struct.COORD, %struct.COORD* %257, i32 0, i32 1
  %259 = load i32*, i32** %258, align 8
  %260 = getelementptr inbounds i32, i32* %259, i64 0
  store i32 12, i32* %260, align 4
  %261 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %262 = load %struct.stType*, %struct.stType** %261, align 8
  %263 = getelementptr inbounds %struct.stType, %struct.stType* %262, i32 0, i32 2
  %264 = getelementptr inbounds [8 x i32], [8 x i32]* %263, i64 0, i64 0
  store i32 13, i32* %264, align 4
  %265 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %266 = load %struct.stType*, %struct.stType** %265, align 8
  %267 = getelementptr inbounds %struct.stType, %struct.stType* %266, i32 0, i32 2
  %268 = getelementptr inbounds [8 x i32], [8 x i32]* %267, i64 0, i64 1
  store i32 14, i32* %268, align 4
  %269 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %270 = load %struct.stType*, %struct.stType** %269, align 8
  %271 = getelementptr inbounds %struct.stType, %struct.stType* %270, i32 0, i32 2
  %272 = getelementptr inbounds [8 x i32], [8 x i32]* %271, i64 0, i64 2
  store i32 15, i32* %272, align 4
  %273 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %274 = load %struct.stType*, %struct.stType** %273, align 8
  %275 = getelementptr inbounds %struct.stType, %struct.stType* %274, i32 0, i32 1
  %276 = getelementptr inbounds [100 x i8], [100 x i8]* %275, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %276, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
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
  br i1 true, label %8, label %76

; <label>:8                                       ; preds = %0
  %9 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %10 = load %struct.stType*, %struct.stType** %9, align 8
  %11 = getelementptr inbounds %struct.stType, %struct.stType* %10, i32 0, i32 0
  %12 = load %struct.COORD*, %struct.COORD** %11, align 8
  %13 = getelementptr inbounds %struct.COORD, %struct.COORD* %12, i32 0, i32 1
  %14 = load i32*, i32** %13, align 8
  %15 = load i32, i32* %14, align 4
  br i1 true, label %16, label %76

; <label>:16                                      ; preds = %8
  %17 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %18 = load %struct.stType*, %struct.stType** %17, align 8
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %18, i32 0, i32 1
  %20 = getelementptr inbounds [100 x i8], [100 x i8]* %19, i32 0, i32 0
  %21 = call i32 @strcmp(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @0, i64 0, i64 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  br i1 false, label %76, label %22

; <label>:22                                      ; preds = %16
  %23 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %24 = load %struct.stType*, %struct.stType** %23, align 8
  %25 = getelementptr inbounds %struct.stType, %struct.stType* %24, i32 0, i32 1
  %26 = getelementptr inbounds [100 x i8], [100 x i8]* %25, i64 0, i64 4
  %27 = load i8, i8* %26, align 4
  br i1 true, label %28, label %76

; <label>:28                                      ; preds = %22
  %29 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %30 = load %struct.stType*, %struct.stType** %29, align 8
  %31 = getelementptr inbounds %struct.stType, %struct.stType* %30, i32 0, i32 1
  %32 = getelementptr inbounds [100 x i8], [100 x i8]* %31, i64 0, i64 9
  %33 = load i8, i8* %32, align 1
  br i1 true, label %34, label %76

; <label>:34                                      ; preds = %28
  %35 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %36 = load %struct.stType*, %struct.stType** %35, align 8
  %37 = getelementptr inbounds %struct.stType, %struct.stType* %36, i32 0, i32 0
  %38 = load %struct.COORD*, %struct.COORD** %37, align 8
  %39 = getelementptr inbounds %struct.COORD, %struct.COORD* %38, i32 0, i32 0
  %40 = load i32*, i32** %39, align 8
  %41 = load i32, i32* %40, align 4
  br i1 true, label %42, label %76

; <label>:42                                      ; preds = %34
  %43 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %44 = load %struct.stType*, %struct.stType** %43, align 8
  %45 = getelementptr inbounds %struct.stType, %struct.stType* %44, i32 0, i32 0
  %46 = load %struct.COORD*, %struct.COORD** %45, align 8
  %47 = getelementptr inbounds %struct.COORD, %struct.COORD* %46, i32 0, i32 1
  %48 = load i32*, i32** %47, align 8
  %49 = load i32, i32* %48, align 4
  br i1 true, label %50, label %76

; <label>:50                                      ; preds = %42
  %51 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %52 = load %struct.stType*, %struct.stType** %51, align 8
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %52, i32 0, i32 2
  %54 = getelementptr inbounds [8 x i32], [8 x i32]* %53, i64 0, i64 1
  %55 = load i32, i32* %54, align 4
  br i1 true, label %56, label %76

; <label>:56                                      ; preds = %50
  %57 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %58 = load %struct.stType*, %struct.stType** %57, align 8
  %59 = getelementptr inbounds %struct.stType, %struct.stType* %58, i32 0, i32 1
  %60 = getelementptr inbounds [100 x i8], [100 x i8]* %59, i32 0, i32 0
  %61 = call i32 @strcmp(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @1, i64 0, i64 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  br i1 false, label %76, label %62

; <label>:62                                      ; preds = %56
  %63 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %64 = load %struct.stType*, %struct.stType** %63, align 8
  %65 = getelementptr inbounds %struct.stType, %struct.stType* %64, i32 0, i32 1
  %66 = getelementptr inbounds [100 x i8], [100 x i8]* %65, i64 0, i64 4
  %67 = load i8, i8* %66, align 4
  br i1 true, label %68, label %76

; <label>:68                                      ; preds = %62
  %69 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %70 = load %struct.stType*, %struct.stType** %69, align 8
  %71 = getelementptr inbounds %struct.stType, %struct.stType* %70, i32 0, i32 1
  %72 = getelementptr inbounds [100 x i8], [100 x i8]* %71, i64 0, i64 9
  %73 = load i8, i8* %72, align 1
  br i1 true, label %74, label %76

; <label>:74                                      ; preds = %68
  %75 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %76

; <label>:76                                      ; preds = %74, %68, %62, %56, %50, %42, %34, %28, %22, %16, %8, %0
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

; Function Attrs: nounwind uwtable
define void @branchPruned_clone_clone(%struct.stType** %obj) #0 {
  %1 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i32 0, i32 0
  %4 = load %struct.COORD*, %struct.COORD** %3, align 8
  %5 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i32 0, i32 0
  %6 = load i32*, i32** %5, align 8
  %7 = load i32, i32* %6, align 4
  br i1 true, label %8, label %76

; <label>:8                                       ; preds = %0
  %9 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %10 = load %struct.stType*, %struct.stType** %9, align 8
  %11 = getelementptr inbounds %struct.stType, %struct.stType* %10, i32 0, i32 0
  %12 = load %struct.COORD*, %struct.COORD** %11, align 8
  %13 = getelementptr inbounds %struct.COORD, %struct.COORD* %12, i32 0, i32 1
  %14 = load i32*, i32** %13, align 8
  %15 = load i32, i32* %14, align 4
  br i1 true, label %16, label %76

; <label>:16                                      ; preds = %8
  %17 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %18 = load %struct.stType*, %struct.stType** %17, align 8
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %18, i32 0, i32 1
  %20 = getelementptr inbounds [100 x i8], [100 x i8]* %19, i32 0, i32 0
  %21 = call i32 @strcmp(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @0, i64 0, i64 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  br i1 false, label %76, label %22

; <label>:22                                      ; preds = %16
  %23 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %24 = load %struct.stType*, %struct.stType** %23, align 8
  %25 = getelementptr inbounds %struct.stType, %struct.stType* %24, i32 0, i32 1
  %26 = getelementptr inbounds [100 x i8], [100 x i8]* %25, i64 0, i64 4
  %27 = load i8, i8* %26, align 4
  br i1 true, label %28, label %76

; <label>:28                                      ; preds = %22
  %29 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %30 = load %struct.stType*, %struct.stType** %29, align 8
  %31 = getelementptr inbounds %struct.stType, %struct.stType* %30, i32 0, i32 1
  %32 = getelementptr inbounds [100 x i8], [100 x i8]* %31, i64 0, i64 9
  %33 = load i8, i8* %32, align 1
  br i1 true, label %34, label %76

; <label>:34                                      ; preds = %28
  %35 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %36 = load %struct.stType*, %struct.stType** %35, align 8
  %37 = getelementptr inbounds %struct.stType, %struct.stType* %36, i32 0, i32 0
  %38 = load %struct.COORD*, %struct.COORD** %37, align 8
  %39 = getelementptr inbounds %struct.COORD, %struct.COORD* %38, i32 0, i32 0
  %40 = load i32*, i32** %39, align 8
  %41 = load i32, i32* %40, align 4
  br i1 true, label %42, label %76

; <label>:42                                      ; preds = %34
  %43 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %44 = load %struct.stType*, %struct.stType** %43, align 8
  %45 = getelementptr inbounds %struct.stType, %struct.stType* %44, i32 0, i32 0
  %46 = load %struct.COORD*, %struct.COORD** %45, align 8
  %47 = getelementptr inbounds %struct.COORD, %struct.COORD* %46, i32 0, i32 1
  %48 = load i32*, i32** %47, align 8
  %49 = load i32, i32* %48, align 4
  br i1 true, label %50, label %76

; <label>:50                                      ; preds = %42
  %51 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %52 = load %struct.stType*, %struct.stType** %51, align 8
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %52, i32 0, i32 2
  %54 = getelementptr inbounds [8 x i32], [8 x i32]* %53, i64 0, i64 1
  %55 = load i32, i32* %54, align 4
  br i1 true, label %56, label %76

; <label>:56                                      ; preds = %50
  %57 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %58 = load %struct.stType*, %struct.stType** %57, align 8
  %59 = getelementptr inbounds %struct.stType, %struct.stType* %58, i32 0, i32 1
  %60 = getelementptr inbounds [100 x i8], [100 x i8]* %59, i32 0, i32 0
  %61 = call i32 @strcmp(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @1, i64 0, i64 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  br i1 false, label %76, label %62

; <label>:62                                      ; preds = %56
  %63 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %64 = load %struct.stType*, %struct.stType** %63, align 8
  %65 = getelementptr inbounds %struct.stType, %struct.stType* %64, i32 0, i32 1
  %66 = getelementptr inbounds [100 x i8], [100 x i8]* %65, i64 0, i64 4
  %67 = load i8, i8* %66, align 4
  br i1 true, label %68, label %76

; <label>:68                                      ; preds = %62
  %69 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %70 = load %struct.stType*, %struct.stType** %69, align 8
  %71 = getelementptr inbounds %struct.stType, %struct.stType* %70, i32 0, i32 1
  %72 = getelementptr inbounds [100 x i8], [100 x i8]* %71, i64 0, i64 9
  %73 = load i8, i8* %72, align 1
  br i1 true, label %74, label %76

; <label>:74                                      ; preds = %68
  %75 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %76

; <label>:76                                      ; preds = %74, %68, %62, %56, %50, %42, %34, %28, %22, %16, %8, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone.1(%struct.stType** %obj) #0 {
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
