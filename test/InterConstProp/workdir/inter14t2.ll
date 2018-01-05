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
  br i1 %8, label %9, label %109

; <label>:9                                       ; preds = %0
  %10 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %11 = load %struct.stType*, %struct.stType** %10, align 8
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 0
  %13 = load %struct.COORD*, %struct.COORD** %12, align 8
  %14 = getelementptr inbounds %struct.COORD, %struct.COORD* %13, i32 0, i32 1
  %15 = load i32*, i32** %14, align 8
  %16 = load i32, i32* %15, align 4
  %17 = icmp eq i32 %16, 2
  br i1 %17, label %18, label %109

; <label>:18                                      ; preds = %9
  %19 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %20 = load %struct.stType*, %struct.stType** %19, align 8
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %20, i32 0, i32 1
  %22 = getelementptr inbounds [100 x i8], [100 x i8]* %21, i32 0, i32 0
  %23 = call i32 @strcmp(i8* %22, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %109, label %25

; <label>:25                                      ; preds = %18
  %26 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %27 = load %struct.stType*, %struct.stType** %26, align 8
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i32 0, i32 1
  %29 = getelementptr inbounds [100 x i8], [100 x i8]* %28, i64 0, i64 4
  %30 = load i8, i8* %29, align 4
  %31 = sext i8 %30 to i32
  %32 = icmp eq i32 %31, 111
  br i1 %32, label %33, label %109

; <label>:33                                      ; preds = %25
  %34 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %35 = load %struct.stType*, %struct.stType** %34, align 8
  %36 = getelementptr inbounds %struct.stType, %struct.stType* %35, i32 0, i32 1
  %37 = getelementptr inbounds [100 x i8], [100 x i8]* %36, i64 0, i64 9
  %38 = load i8, i8* %37, align 1
  %39 = sext i8 %38 to i32
  %40 = icmp eq i32 %39, 100
  br i1 %40, label %41, label %109

; <label>:41                                      ; preds = %33
  %42 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %43 = load %struct.stType*, %struct.stType** %42, align 8
  %44 = getelementptr inbounds %struct.stType, %struct.stType* %43, i32 0, i32 0
  %45 = load %struct.COORD*, %struct.COORD** %44, align 8
  %46 = getelementptr inbounds %struct.COORD, %struct.COORD* %45, i32 0, i32 0
  %47 = load i32*, i32** %46, align 8
  %48 = load i32, i32* %47, align 4
  %49 = icmp eq i32 %48, 11
  br i1 %49, label %50, label %109

; <label>:50                                      ; preds = %41
  %51 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %52 = load %struct.stType*, %struct.stType** %51, align 8
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %52, i32 0, i32 0
  %54 = load %struct.COORD*, %struct.COORD** %53, align 8
  %55 = getelementptr inbounds %struct.COORD, %struct.COORD* %54, i32 0, i32 1
  %56 = load i32*, i32** %55, align 8
  %57 = load i32, i32* %56, align 4
  %58 = icmp eq i32 %57, 12
  br i1 %58, label %59, label %109

; <label>:59                                      ; preds = %50
  %60 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %61 = load %struct.stType*, %struct.stType** %60, align 8
  %62 = getelementptr inbounds %struct.stType, %struct.stType* %61, i32 0, i32 0
  %63 = load %struct.COORD*, %struct.COORD** %62, align 8
  %64 = getelementptr inbounds %struct.COORD, %struct.COORD* %63, i32 0, i32 0
  %65 = load i32*, i32** %64, align 8
  %66 = load i32, i32* %65, align 4
  %67 = icmp eq i32 %66, 16
  br i1 %67, label %68, label %109

; <label>:68                                      ; preds = %59
  %69 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %70 = load %struct.stType*, %struct.stType** %69, align 8
  %71 = getelementptr inbounds %struct.stType, %struct.stType* %70, i32 0, i32 0
  %72 = load %struct.COORD*, %struct.COORD** %71, align 8
  %73 = getelementptr inbounds %struct.COORD, %struct.COORD* %72, i32 0, i32 1
  %74 = load i32*, i32** %73, align 8
  %75 = load i32, i32* %74, align 4
  %76 = icmp eq i32 %75, 17
  br i1 %76, label %77, label %109

; <label>:77                                      ; preds = %68
  %78 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %79 = load %struct.stType*, %struct.stType** %78, align 8
  %80 = getelementptr inbounds %struct.stType, %struct.stType* %79, i32 0, i32 2
  %81 = getelementptr inbounds [8 x i32], [8 x i32]* %80, i64 0, i64 1
  %82 = load i32, i32* %81, align 4
  %83 = icmp eq i32 %82, 14
  br i1 %83, label %84, label %109

; <label>:84                                      ; preds = %77
  %85 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %86 = load %struct.stType*, %struct.stType** %85, align 8
  %87 = getelementptr inbounds %struct.stType, %struct.stType* %86, i32 0, i32 1
  %88 = getelementptr inbounds [100 x i8], [100 x i8]* %87, i32 0, i32 0
  %89 = call i32 @strcmp(i8* %88, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %90 = icmp ne i32 %89, 0
  br i1 %90, label %109, label %91

; <label>:91                                      ; preds = %84
  %92 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %93 = load %struct.stType*, %struct.stType** %92, align 8
  %94 = getelementptr inbounds %struct.stType, %struct.stType* %93, i32 0, i32 1
  %95 = getelementptr inbounds [100 x i8], [100 x i8]* %94, i64 0, i64 4
  %96 = load i8, i8* %95, align 4
  %97 = sext i8 %96 to i32
  %98 = icmp eq i32 %97, 111
  br i1 %98, label %99, label %109

; <label>:99                                      ; preds = %91
  %100 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %101 = load %struct.stType*, %struct.stType** %100, align 8
  %102 = getelementptr inbounds %struct.stType, %struct.stType* %101, i32 0, i32 1
  %103 = getelementptr inbounds [100 x i8], [100 x i8]* %102, i64 0, i64 9
  %104 = load i8, i8* %103, align 1
  %105 = sext i8 %104 to i32
  %106 = icmp eq i32 %105, 100
  br i1 %106, label %107, label %109

; <label>:107                                     ; preds = %99
  %108 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %109

; <label>:109                                     ; preds = %107, %99, %91, %84, %77, %68, %59, %50, %41, %33, %25, %18, %9, %0
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
  br i1 %6, label %37, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %9 = load %struct.stType*, %struct.stType** %8, align 8
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %9, i32 0, i32 2
  %11 = getelementptr inbounds [8 x i32], [8 x i32]* %10, i64 0, i64 1
  %12 = load i32, i32* %11, align 4
  %13 = icmp eq i32 %12, 19
  br i1 %13, label %37, label %14

; <label>:14                                      ; preds = %7
  %15 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %16 = load %struct.stType*, %struct.stType** %15, align 8
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %16, i32 0, i32 1
  %18 = getelementptr inbounds [100 x i8], [100 x i8]* %17, i32 0, i32 0
  %19 = call i32 @strcmp(i8* %18, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %20 = icmp ne i32 %19, 0
  br i1 %20, label %21, label %37

; <label>:21                                      ; preds = %14
  %22 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %23 = load %struct.stType*, %struct.stType** %22, align 8
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %23, i32 0, i32 1
  %25 = getelementptr inbounds [100 x i8], [100 x i8]* %24, i64 0, i64 4
  %26 = load i8, i8* %25, align 4
  %27 = sext i8 %26 to i32
  %28 = icmp eq i32 %27, 111
  br i1 %28, label %37, label %29

; <label>:29                                      ; preds = %21
  %30 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %31 = load %struct.stType*, %struct.stType** %30, align 8
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %31, i32 0, i32 1
  %33 = getelementptr inbounds [100 x i8], [100 x i8]* %32, i64 0, i64 9
  %34 = load i8, i8* %33, align 1
  %35 = sext i8 %34 to i32
  %36 = icmp eq i32 %35, 100
  br i1 %36, label %37, label %39

; <label>:37                                      ; preds = %29, %21, %14, %7, %0
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0))
  br label %39

; <label>:39                                      ; preds = %37, %29
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
  %159 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %160 = load %struct.stType*, %struct.stType** %159, align 8
  %161 = getelementptr inbounds %struct.stType, %struct.stType* %160, i32 0, i32 0
  %162 = load %struct.COORD*, %struct.COORD** %161, align 8
  %163 = getelementptr inbounds %struct.COORD, %struct.COORD* %162, i32 0, i32 0
  %164 = load i32*, i32** %163, align 8
  %165 = getelementptr inbounds i32, i32* %164, i64 0
  store i32 16, i32* %165, align 4
  %166 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %167 = load %struct.stType*, %struct.stType** %166, align 8
  %168 = getelementptr inbounds %struct.stType, %struct.stType* %167, i32 0, i32 0
  %169 = load %struct.COORD*, %struct.COORD** %168, align 8
  %170 = getelementptr inbounds %struct.COORD, %struct.COORD* %169, i32 0, i32 1
  %171 = load i32*, i32** %170, align 8
  %172 = getelementptr inbounds i32, i32* %171, i64 0
  store i32 17, i32* %172, align 4
  %173 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %174 = load %struct.stType*, %struct.stType** %173, align 8
  %175 = getelementptr inbounds %struct.stType, %struct.stType* %174, i32 0, i32 1
  %176 = getelementptr inbounds [100 x i8], [100 x i8]* %175, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %176, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %177 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %178 = load %struct.stType*, %struct.stType** %177, align 8
  %179 = getelementptr inbounds %struct.stType, %struct.stType* %178, i32 0, i32 0
  %180 = load %struct.COORD*, %struct.COORD** %179, align 8
  %181 = getelementptr inbounds %struct.COORD, %struct.COORD* %180, i32 0, i32 0
  %182 = load i32*, i32** %181, align 8
  %183 = getelementptr inbounds i32, i32* %182, i64 0
  store i32 6, i32* %183, align 4
  %184 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %185 = load %struct.stType*, %struct.stType** %184, align 8
  %186 = getelementptr inbounds %struct.stType, %struct.stType* %185, i32 0, i32 0
  %187 = load %struct.COORD*, %struct.COORD** %186, align 8
  %188 = getelementptr inbounds %struct.COORD, %struct.COORD* %187, i32 0, i32 1
  %189 = load i32*, i32** %188, align 8
  %190 = getelementptr inbounds i32, i32* %189, i64 0
  store i32 7, i32* %190, align 4
  %191 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %192 = load %struct.stType*, %struct.stType** %191, align 8
  %193 = getelementptr inbounds %struct.stType, %struct.stType* %192, i32 0, i32 2
  %194 = getelementptr inbounds [8 x i32], [8 x i32]* %193, i64 0, i64 0
  store i32 8, i32* %194, align 4
  %195 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %196 = load %struct.stType*, %struct.stType** %195, align 8
  %197 = getelementptr inbounds %struct.stType, %struct.stType* %196, i32 0, i32 2
  %198 = getelementptr inbounds [8 x i32], [8 x i32]* %197, i64 0, i64 1
  store i32 9, i32* %198, align 4
  %199 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %200 = load %struct.stType*, %struct.stType** %199, align 8
  %201 = getelementptr inbounds %struct.stType, %struct.stType* %200, i32 0, i32 2
  %202 = getelementptr inbounds [8 x i32], [8 x i32]* %201, i64 0, i64 2
  store i32 10, i32* %202, align 4
  %203 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %204 = load %struct.stType*, %struct.stType** %203, align 8
  %205 = getelementptr inbounds %struct.stType, %struct.stType* %204, i32 0, i32 1
  %206 = getelementptr inbounds [100 x i8], [100 x i8]* %205, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %206, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %207 = call noalias i8* @malloc(i64 144) #6
  %208 = bitcast i8* %207 to %struct.stType*
  %209 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  store %struct.stType* %208, %struct.stType** %209, align 8
  %210 = call noalias i8* @malloc(i64 16) #6
  %211 = bitcast i8* %210 to %struct.COORD*
  %212 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %213 = load %struct.stType*, %struct.stType** %212, align 8
  %214 = getelementptr inbounds %struct.stType, %struct.stType* %213, i32 0, i32 0
  store %struct.COORD* %211, %struct.COORD** %214, align 8
  %215 = call noalias i8* @malloc(i64 4) #6
  %216 = bitcast i8* %215 to i32*
  %217 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %218 = load %struct.stType*, %struct.stType** %217, align 8
  %219 = getelementptr inbounds %struct.stType, %struct.stType* %218, i32 0, i32 0
  %220 = load %struct.COORD*, %struct.COORD** %219, align 8
  %221 = getelementptr inbounds %struct.COORD, %struct.COORD* %220, i32 0, i32 0
  store i32* %216, i32** %221, align 8
  %222 = call noalias i8* @malloc(i64 4) #6
  %223 = bitcast i8* %222 to i32*
  %224 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %225 = load %struct.stType*, %struct.stType** %224, align 8
  %226 = getelementptr inbounds %struct.stType, %struct.stType* %225, i32 0, i32 0
  %227 = load %struct.COORD*, %struct.COORD** %226, align 8
  %228 = getelementptr inbounds %struct.COORD, %struct.COORD* %227, i32 0, i32 1
  store i32* %223, i32** %228, align 8
  %229 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %230 = load %struct.stType*, %struct.stType** %229, align 8
  %231 = getelementptr inbounds %struct.stType, %struct.stType* %230, i32 0, i32 0
  %232 = load %struct.COORD*, %struct.COORD** %231, align 8
  %233 = getelementptr inbounds %struct.COORD, %struct.COORD* %232, i32 0, i32 0
  %234 = load i32*, i32** %233, align 8
  %235 = getelementptr inbounds i32, i32* %234, i64 0
  store i32 11, i32* %235, align 4
  %236 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %237 = load %struct.stType*, %struct.stType** %236, align 8
  %238 = getelementptr inbounds %struct.stType, %struct.stType* %237, i32 0, i32 0
  %239 = load %struct.COORD*, %struct.COORD** %238, align 8
  %240 = getelementptr inbounds %struct.COORD, %struct.COORD* %239, i32 0, i32 1
  %241 = load i32*, i32** %240, align 8
  %242 = getelementptr inbounds i32, i32* %241, i64 0
  store i32 12, i32* %242, align 4
  %243 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %244 = load %struct.stType*, %struct.stType** %243, align 8
  %245 = getelementptr inbounds %struct.stType, %struct.stType* %244, i32 0, i32 2
  %246 = getelementptr inbounds [8 x i32], [8 x i32]* %245, i64 0, i64 0
  store i32 13, i32* %246, align 4
  %247 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %248 = load %struct.stType*, %struct.stType** %247, align 8
  %249 = getelementptr inbounds %struct.stType, %struct.stType* %248, i32 0, i32 2
  %250 = getelementptr inbounds [8 x i32], [8 x i32]* %249, i64 0, i64 1
  store i32 14, i32* %250, align 4
  %251 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %252 = load %struct.stType*, %struct.stType** %251, align 8
  %253 = getelementptr inbounds %struct.stType, %struct.stType* %252, i32 0, i32 2
  %254 = getelementptr inbounds [8 x i32], [8 x i32]* %253, i64 0, i64 2
  store i32 15, i32* %254, align 4
  %255 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %256 = load %struct.stType*, %struct.stType** %255, align 8
  %257 = getelementptr inbounds %struct.stType, %struct.stType* %256, i32 0, i32 1
  %258 = getelementptr inbounds [100 x i8], [100 x i8]* %257, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %258, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  call void @branchPruned_clone(%struct.stType** %2)
  call void @branchNotPruned_clone(%struct.stType** %2)
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
  br i1 %8, label %9, label %111

; <label>:9                                       ; preds = %0
  %10 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %11 = load %struct.stType*, %struct.stType** %10, align 8
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 0
  %13 = load %struct.COORD*, %struct.COORD** %12, align 8
  %14 = getelementptr inbounds %struct.COORD, %struct.COORD* %13, i32 0, i32 1
  %15 = load i32*, i32** %14, align 8
  %16 = load i32, i32* %15, align 4
  %17 = icmp eq i32 2, 2
  br i1 %17, label %18, label %111

; <label>:18                                      ; preds = %9
  %19 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %20 = load %struct.stType*, %struct.stType** %19, align 8
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %20, i32 0, i32 1
  %22 = getelementptr inbounds [100 x i8], [100 x i8]* %21, i32 0, i32 0
  %23 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %24 = call i32 @strcmp(i8* %23, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %25 = icmp ne i32 0, 0
  br i1 %25, label %111, label %26

; <label>:26                                      ; preds = %18
  %27 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %28 = load %struct.stType*, %struct.stType** %27, align 8
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i32 0, i32 1
  %30 = getelementptr inbounds [100 x i8], [100 x i8]* %29, i64 0, i64 4
  %31 = load i8, i8* %30, align 4
  %32 = sext i8 111 to i32
  %33 = icmp eq i32 %32, 111
  br i1 %33, label %34, label %111

; <label>:34                                      ; preds = %26
  %35 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %36 = load %struct.stType*, %struct.stType** %35, align 8
  %37 = getelementptr inbounds %struct.stType, %struct.stType* %36, i32 0, i32 1
  %38 = getelementptr inbounds [100 x i8], [100 x i8]* %37, i64 0, i64 9
  %39 = load i8, i8* %38, align 1
  %40 = sext i8 100 to i32
  %41 = icmp eq i32 %40, 100
  br i1 %41, label %42, label %111

; <label>:42                                      ; preds = %34
  %43 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %44 = load %struct.stType*, %struct.stType** %43, align 8
  %45 = getelementptr inbounds %struct.stType, %struct.stType* %44, i32 0, i32 0
  %46 = load %struct.COORD*, %struct.COORD** %45, align 8
  %47 = getelementptr inbounds %struct.COORD, %struct.COORD* %46, i32 0, i32 0
  %48 = load i32*, i32** %47, align 8
  %49 = load i32, i32* %48, align 4
  %50 = icmp eq i32 11, 11
  br i1 %50, label %51, label %111

; <label>:51                                      ; preds = %42
  %52 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %53 = load %struct.stType*, %struct.stType** %52, align 8
  %54 = getelementptr inbounds %struct.stType, %struct.stType* %53, i32 0, i32 0
  %55 = load %struct.COORD*, %struct.COORD** %54, align 8
  %56 = getelementptr inbounds %struct.COORD, %struct.COORD* %55, i32 0, i32 1
  %57 = load i32*, i32** %56, align 8
  %58 = load i32, i32* %57, align 4
  %59 = icmp eq i32 12, 12
  br i1 %59, label %60, label %111

; <label>:60                                      ; preds = %51
  %61 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %62 = load %struct.stType*, %struct.stType** %61, align 8
  %63 = getelementptr inbounds %struct.stType, %struct.stType* %62, i32 0, i32 0
  %64 = load %struct.COORD*, %struct.COORD** %63, align 8
  %65 = getelementptr inbounds %struct.COORD, %struct.COORD* %64, i32 0, i32 0
  %66 = load i32*, i32** %65, align 8
  %67 = load i32, i32* %66, align 4
  %68 = icmp eq i32 16, 16
  br i1 %68, label %69, label %111

; <label>:69                                      ; preds = %60
  %70 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %71 = load %struct.stType*, %struct.stType** %70, align 8
  %72 = getelementptr inbounds %struct.stType, %struct.stType* %71, i32 0, i32 0
  %73 = load %struct.COORD*, %struct.COORD** %72, align 8
  %74 = getelementptr inbounds %struct.COORD, %struct.COORD* %73, i32 0, i32 1
  %75 = load i32*, i32** %74, align 8
  %76 = load i32, i32* %75, align 4
  %77 = icmp eq i32 17, 17
  br i1 %77, label %78, label %111

; <label>:78                                      ; preds = %69
  %79 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %80 = load %struct.stType*, %struct.stType** %79, align 8
  %81 = getelementptr inbounds %struct.stType, %struct.stType* %80, i32 0, i32 2
  %82 = getelementptr inbounds [8 x i32], [8 x i32]* %81, i64 0, i64 1
  %83 = load i32, i32* %82, align 4
  %84 = icmp eq i32 14, 14
  br i1 %84, label %85, label %111

; <label>:85                                      ; preds = %78
  %86 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %87 = load %struct.stType*, %struct.stType** %86, align 8
  %88 = getelementptr inbounds %struct.stType, %struct.stType* %87, i32 0, i32 1
  %89 = getelementptr inbounds [100 x i8], [100 x i8]* %88, i32 0, i32 0
  %90 = getelementptr [11 x i8], [11 x i8]* @1, i64 0, i64 0
  %91 = call i32 @strcmp(i8* %90, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %92 = icmp ne i32 0, 0
  br i1 %92, label %111, label %93

; <label>:93                                      ; preds = %85
  %94 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %95 = load %struct.stType*, %struct.stType** %94, align 8
  %96 = getelementptr inbounds %struct.stType, %struct.stType* %95, i32 0, i32 1
  %97 = getelementptr inbounds [100 x i8], [100 x i8]* %96, i64 0, i64 4
  %98 = load i8, i8* %97, align 4
  %99 = sext i8 111 to i32
  %100 = icmp eq i32 %99, 111
  br i1 %100, label %101, label %111

; <label>:101                                     ; preds = %93
  %102 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %103 = load %struct.stType*, %struct.stType** %102, align 8
  %104 = getelementptr inbounds %struct.stType, %struct.stType* %103, i32 0, i32 1
  %105 = getelementptr inbounds [100 x i8], [100 x i8]* %104, i64 0, i64 9
  %106 = load i8, i8* %105, align 1
  %107 = sext i8 100 to i32
  %108 = icmp eq i32 %107, 100
  br i1 %108, label %109, label %111

; <label>:109                                     ; preds = %101
  %110 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %111

; <label>:111                                     ; preds = %109, %101, %93, %85, %78, %69, %60, %51, %42, %34, %26, %18, %9, %0
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
  br i1 %6, label %37, label %7

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %9 = load %struct.stType*, %struct.stType** %8, align 8
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %9, i32 0, i32 2
  %11 = getelementptr inbounds [8 x i32], [8 x i32]* %10, i64 0, i64 1
  %12 = load i32, i32* %11, align 4
  %13 = icmp eq i32 %12, 19
  br i1 %13, label %37, label %14

; <label>:14                                      ; preds = %7
  %15 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %16 = load %struct.stType*, %struct.stType** %15, align 8
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %16, i32 0, i32 1
  %18 = getelementptr inbounds [100 x i8], [100 x i8]* %17, i32 0, i32 0
  %19 = call i32 @strcmp(i8* %18, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %20 = icmp ne i32 %19, 0
  br i1 %20, label %21, label %37

; <label>:21                                      ; preds = %14
  %22 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %23 = load %struct.stType*, %struct.stType** %22, align 8
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %23, i32 0, i32 1
  %25 = getelementptr inbounds [100 x i8], [100 x i8]* %24, i64 0, i64 4
  %26 = load i8, i8* %25, align 4
  %27 = sext i8 %26 to i32
  %28 = icmp eq i32 %27, 111
  br i1 %28, label %37, label %29

; <label>:29                                      ; preds = %21
  %30 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %31 = load %struct.stType*, %struct.stType** %30, align 8
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %31, i32 0, i32 1
  %33 = getelementptr inbounds [100 x i8], [100 x i8]* %32, i64 0, i64 9
  %34 = load i8, i8* %33, align 1
  %35 = sext i8 %34 to i32
  %36 = icmp eq i32 %35, 100
  br i1 %36, label %37, label %39

; <label>:37                                      ; preds = %29, %21, %14, %7, %0
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0))
  br label %39

; <label>:39                                      ; preds = %37, %29
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
