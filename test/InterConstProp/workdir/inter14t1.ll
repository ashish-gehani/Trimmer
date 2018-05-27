; ModuleID = 'workdir/inter14t1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"*** Branch Taken \0A\00", align 1
@.str.2 = private unnamed_addr constant [23 x i8] c"*** Branch not Taken \0A\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType** %obj) #0 {
  %1 = alloca %struct.stType**, align 8
  store %struct.stType** %obj, %struct.stType*** %1, align 8
  %2 = load %struct.stType**, %struct.stType*** %1, align 8
  %3 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %4 = load %struct.stType*, %struct.stType** %3, align 8
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %4, i32 0, i32 0
  %6 = load %struct.COORD*, %struct.COORD** %5, align 8
  %7 = getelementptr inbounds %struct.COORD, %struct.COORD* %6, i32 0, i32 0
  %8 = load i32*, i32** %7, align 8
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %123

; <label>:11                                      ; preds = %0
  %12 = load %struct.stType**, %struct.stType*** %1, align 8
  %13 = getelementptr inbounds %struct.stType*, %struct.stType** %12, i64 0
  %14 = load %struct.stType*, %struct.stType** %13, align 8
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %14, i32 0, i32 0
  %16 = load %struct.COORD*, %struct.COORD** %15, align 8
  %17 = getelementptr inbounds %struct.COORD, %struct.COORD* %16, i32 0, i32 1
  %18 = load i32*, i32** %17, align 8
  %19 = load i32, i32* %18, align 4
  %20 = icmp eq i32 %19, 2
  br i1 %20, label %21, label %123

; <label>:21                                      ; preds = %11
  %22 = load %struct.stType**, %struct.stType*** %1, align 8
  %23 = getelementptr inbounds %struct.stType*, %struct.stType** %22, i64 0
  %24 = load %struct.stType*, %struct.stType** %23, align 8
  %25 = getelementptr inbounds %struct.stType, %struct.stType* %24, i32 0, i32 1
  %26 = getelementptr inbounds [100 x i8], [100 x i8]* %25, i32 0, i32 0
  %27 = call i32 @strcmp(i8* %26, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %123, label %29

; <label>:29                                      ; preds = %21
  %30 = load %struct.stType**, %struct.stType*** %1, align 8
  %31 = getelementptr inbounds %struct.stType*, %struct.stType** %30, i64 0
  %32 = load %struct.stType*, %struct.stType** %31, align 8
  %33 = getelementptr inbounds %struct.stType, %struct.stType* %32, i32 0, i32 1
  %34 = getelementptr inbounds [100 x i8], [100 x i8]* %33, i64 0, i64 4
  %35 = load i8, i8* %34, align 4
  %36 = sext i8 %35 to i32
  %37 = icmp eq i32 %36, 111
  br i1 %37, label %38, label %123

; <label>:38                                      ; preds = %29
  %39 = load %struct.stType**, %struct.stType*** %1, align 8
  %40 = getelementptr inbounds %struct.stType*, %struct.stType** %39, i64 0
  %41 = load %struct.stType*, %struct.stType** %40, align 8
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %41, i32 0, i32 1
  %43 = getelementptr inbounds [100 x i8], [100 x i8]* %42, i64 0, i64 9
  %44 = load i8, i8* %43, align 1
  %45 = sext i8 %44 to i32
  %46 = icmp eq i32 %45, 100
  br i1 %46, label %47, label %123

; <label>:47                                      ; preds = %38
  %48 = load %struct.stType**, %struct.stType*** %1, align 8
  %49 = getelementptr inbounds %struct.stType*, %struct.stType** %48, i64 2
  %50 = load %struct.stType*, %struct.stType** %49, align 8
  %51 = getelementptr inbounds %struct.stType, %struct.stType* %50, i32 0, i32 0
  %52 = load %struct.COORD*, %struct.COORD** %51, align 8
  %53 = getelementptr inbounds %struct.COORD, %struct.COORD* %52, i32 0, i32 0
  %54 = load i32*, i32** %53, align 8
  %55 = load i32, i32* %54, align 4
  %56 = icmp eq i32 %55, 11
  br i1 %56, label %57, label %123

; <label>:57                                      ; preds = %47
  %58 = load %struct.stType**, %struct.stType*** %1, align 8
  %59 = getelementptr inbounds %struct.stType*, %struct.stType** %58, i64 2
  %60 = load %struct.stType*, %struct.stType** %59, align 8
  %61 = getelementptr inbounds %struct.stType, %struct.stType* %60, i32 0, i32 0
  %62 = load %struct.COORD*, %struct.COORD** %61, align 8
  %63 = getelementptr inbounds %struct.COORD, %struct.COORD* %62, i32 0, i32 1
  %64 = load i32*, i32** %63, align 8
  %65 = load i32, i32* %64, align 4
  %66 = icmp eq i32 %65, 12
  br i1 %66, label %67, label %123

; <label>:67                                      ; preds = %57
  %68 = load %struct.stType**, %struct.stType*** %1, align 8
  %69 = getelementptr inbounds %struct.stType*, %struct.stType** %68, i64 3
  %70 = load %struct.stType*, %struct.stType** %69, align 8
  %71 = getelementptr inbounds %struct.stType, %struct.stType* %70, i32 0, i32 0
  %72 = load %struct.COORD*, %struct.COORD** %71, align 8
  %73 = getelementptr inbounds %struct.COORD, %struct.COORD* %72, i32 0, i32 0
  %74 = load i32*, i32** %73, align 8
  %75 = load i32, i32* %74, align 4
  %76 = icmp eq i32 %75, 16
  br i1 %76, label %77, label %123

; <label>:77                                      ; preds = %67
  %78 = load %struct.stType**, %struct.stType*** %1, align 8
  %79 = getelementptr inbounds %struct.stType*, %struct.stType** %78, i64 3
  %80 = load %struct.stType*, %struct.stType** %79, align 8
  %81 = getelementptr inbounds %struct.stType, %struct.stType* %80, i32 0, i32 0
  %82 = load %struct.COORD*, %struct.COORD** %81, align 8
  %83 = getelementptr inbounds %struct.COORD, %struct.COORD* %82, i32 0, i32 1
  %84 = load i32*, i32** %83, align 8
  %85 = load i32, i32* %84, align 4
  %86 = icmp eq i32 %85, 17
  br i1 %86, label %87, label %123

; <label>:87                                      ; preds = %77
  %88 = load %struct.stType**, %struct.stType*** %1, align 8
  %89 = getelementptr inbounds %struct.stType*, %struct.stType** %88, i64 2
  %90 = load %struct.stType*, %struct.stType** %89, align 8
  %91 = getelementptr inbounds %struct.stType, %struct.stType* %90, i32 0, i32 2
  %92 = getelementptr inbounds [8 x i32], [8 x i32]* %91, i64 0, i64 1
  %93 = load i32, i32* %92, align 4
  %94 = icmp eq i32 %93, 14
  br i1 %94, label %95, label %123

; <label>:95                                      ; preds = %87
  %96 = load %struct.stType**, %struct.stType*** %1, align 8
  %97 = getelementptr inbounds %struct.stType*, %struct.stType** %96, i64 2
  %98 = load %struct.stType*, %struct.stType** %97, align 8
  %99 = getelementptr inbounds %struct.stType, %struct.stType* %98, i32 0, i32 1
  %100 = getelementptr inbounds [100 x i8], [100 x i8]* %99, i32 0, i32 0
  %101 = call i32 @strcmp(i8* %100, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %102 = icmp ne i32 %101, 0
  br i1 %102, label %123, label %103

; <label>:103                                     ; preds = %95
  %104 = load %struct.stType**, %struct.stType*** %1, align 8
  %105 = getelementptr inbounds %struct.stType*, %struct.stType** %104, i64 2
  %106 = load %struct.stType*, %struct.stType** %105, align 8
  %107 = getelementptr inbounds %struct.stType, %struct.stType* %106, i32 0, i32 1
  %108 = getelementptr inbounds [100 x i8], [100 x i8]* %107, i64 0, i64 4
  %109 = load i8, i8* %108, align 4
  %110 = sext i8 %109 to i32
  %111 = icmp eq i32 %110, 111
  br i1 %111, label %112, label %123

; <label>:112                                     ; preds = %103
  %113 = load %struct.stType**, %struct.stType*** %1, align 8
  %114 = getelementptr inbounds %struct.stType*, %struct.stType** %113, i64 2
  %115 = load %struct.stType*, %struct.stType** %114, align 8
  %116 = getelementptr inbounds %struct.stType, %struct.stType* %115, i32 0, i32 1
  %117 = getelementptr inbounds [100 x i8], [100 x i8]* %116, i64 0, i64 9
  %118 = load i8, i8* %117, align 1
  %119 = sext i8 %118 to i32
  %120 = icmp eq i32 %119, 100
  br i1 %120, label %121, label %123

; <label>:121                                     ; preds = %112
  %122 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %123

; <label>:123                                     ; preds = %121, %112, %103, %95, %87, %77, %67, %57, %47, %38, %29, %21, %11, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define void @branchNotPruned(%struct.stType** %obj) #0 {
  %1 = alloca %struct.stType**, align 8
  store %struct.stType** %obj, %struct.stType*** %1, align 8
  %2 = load %struct.stType**, %struct.stType*** %1, align 8
  %3 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %4 = load %struct.stType*, %struct.stType** %3, align 8
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %4, i32 0, i32 2
  %6 = getelementptr inbounds [8 x i32], [8 x i32]* %5, i64 0, i64 1
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 %7, 4
  br i1 %8, label %43, label %9

; <label>:9                                       ; preds = %0
  %10 = load %struct.stType**, %struct.stType*** %1, align 8
  %11 = getelementptr inbounds %struct.stType*, %struct.stType** %10, i64 3
  %12 = load %struct.stType*, %struct.stType** %11, align 8
  %13 = getelementptr inbounds %struct.stType, %struct.stType* %12, i32 0, i32 2
  %14 = getelementptr inbounds [8 x i32], [8 x i32]* %13, i64 0, i64 1
  %15 = load i32, i32* %14, align 4
  %16 = icmp eq i32 %15, 19
  br i1 %16, label %43, label %17

; <label>:17                                      ; preds = %9
  %18 = load %struct.stType**, %struct.stType*** %1, align 8
  %19 = getelementptr inbounds %struct.stType*, %struct.stType** %18, i64 3
  %20 = load %struct.stType*, %struct.stType** %19, align 8
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %20, i32 0, i32 1
  %22 = getelementptr inbounds [100 x i8], [100 x i8]* %21, i32 0, i32 0
  %23 = call i32 @strcmp(i8* %22, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %25, label %43

; <label>:25                                      ; preds = %17
  %26 = load %struct.stType**, %struct.stType*** %1, align 8
  %27 = getelementptr inbounds %struct.stType*, %struct.stType** %26, i64 3
  %28 = load %struct.stType*, %struct.stType** %27, align 8
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i32 0, i32 1
  %30 = getelementptr inbounds [100 x i8], [100 x i8]* %29, i64 0, i64 4
  %31 = load i8, i8* %30, align 4
  %32 = sext i8 %31 to i32
  %33 = icmp eq i32 %32, 111
  br i1 %33, label %43, label %34

; <label>:34                                      ; preds = %25
  %35 = load %struct.stType**, %struct.stType*** %1, align 8
  %36 = getelementptr inbounds %struct.stType*, %struct.stType** %35, i64 3
  %37 = load %struct.stType*, %struct.stType** %36, align 8
  %38 = getelementptr inbounds %struct.stType, %struct.stType* %37, i32 0, i32 1
  %39 = getelementptr inbounds [100 x i8], [100 x i8]* %38, i64 0, i64 9
  %40 = load i8, i8* %39, align 1
  %41 = sext i8 %40 to i32
  %42 = icmp eq i32 %41, 100
  br i1 %42, label %43, label %45

; <label>:43                                      ; preds = %34, %25, %17, %9, %0
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0))
  br label %45

; <label>:45                                      ; preds = %43, %34
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %obj = alloca %struct.stType**, align 8
  store i32 0, i32* %1, align 4
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = call noalias i8* @malloc(i64 160) #6
  %5 = bitcast i8* %4 to %struct.stType**
  store %struct.stType** %5, %struct.stType*** %obj, align 8
  %6 = call noalias i8* @malloc(i64 144) #6
  %7 = bitcast i8* %6 to %struct.stType*
  %8 = load %struct.stType**, %struct.stType*** %obj, align 8
  %9 = getelementptr inbounds %struct.stType*, %struct.stType** %8, i64 0
  store %struct.stType* %7, %struct.stType** %9, align 8
  %10 = call noalias i8* @malloc(i64 16) #6
  %11 = bitcast i8* %10 to %struct.COORD*
  %12 = load %struct.stType**, %struct.stType*** %obj, align 8
  %13 = getelementptr inbounds %struct.stType*, %struct.stType** %12, i64 0
  %14 = load %struct.stType*, %struct.stType** %13, align 8
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %14, i32 0, i32 0
  store %struct.COORD* %11, %struct.COORD** %15, align 8
  %16 = call noalias i8* @malloc(i64 4) #6
  %17 = bitcast i8* %16 to i32*
  %18 = load %struct.stType**, %struct.stType*** %obj, align 8
  %19 = getelementptr inbounds %struct.stType*, %struct.stType** %18, i64 0
  %20 = load %struct.stType*, %struct.stType** %19, align 8
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %20, i32 0, i32 0
  %22 = load %struct.COORD*, %struct.COORD** %21, align 8
  %23 = getelementptr inbounds %struct.COORD, %struct.COORD* %22, i32 0, i32 0
  store i32* %17, i32** %23, align 8
  %24 = call noalias i8* @malloc(i64 4) #6
  %25 = bitcast i8* %24 to i32*
  %26 = load %struct.stType**, %struct.stType*** %obj, align 8
  %27 = getelementptr inbounds %struct.stType*, %struct.stType** %26, i64 0
  %28 = load %struct.stType*, %struct.stType** %27, align 8
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i32 0, i32 0
  %30 = load %struct.COORD*, %struct.COORD** %29, align 8
  %31 = getelementptr inbounds %struct.COORD, %struct.COORD* %30, i32 0, i32 1
  store i32* %25, i32** %31, align 8
  %32 = call noalias i8* @malloc(i64 144) #6
  %33 = bitcast i8* %32 to %struct.stType*
  %34 = load %struct.stType**, %struct.stType*** %obj, align 8
  %35 = getelementptr inbounds %struct.stType*, %struct.stType** %34, i64 3
  store %struct.stType* %33, %struct.stType** %35, align 8
  %36 = call noalias i8* @malloc(i64 16) #6
  %37 = bitcast i8* %36 to %struct.COORD*
  %38 = load %struct.stType**, %struct.stType*** %obj, align 8
  %39 = getelementptr inbounds %struct.stType*, %struct.stType** %38, i64 3
  %40 = load %struct.stType*, %struct.stType** %39, align 8
  %41 = getelementptr inbounds %struct.stType, %struct.stType* %40, i32 0, i32 0
  store %struct.COORD* %37, %struct.COORD** %41, align 8
  %42 = call noalias i8* @malloc(i64 4) #6
  %43 = bitcast i8* %42 to i32*
  %44 = load %struct.stType**, %struct.stType*** %obj, align 8
  %45 = getelementptr inbounds %struct.stType*, %struct.stType** %44, i64 3
  %46 = load %struct.stType*, %struct.stType** %45, align 8
  %47 = getelementptr inbounds %struct.stType, %struct.stType* %46, i32 0, i32 0
  %48 = load %struct.COORD*, %struct.COORD** %47, align 8
  %49 = getelementptr inbounds %struct.COORD, %struct.COORD* %48, i32 0, i32 0
  store i32* %43, i32** %49, align 8
  %50 = call noalias i8* @malloc(i64 4) #6
  %51 = bitcast i8* %50 to i32*
  %52 = load %struct.stType**, %struct.stType*** %obj, align 8
  %53 = getelementptr inbounds %struct.stType*, %struct.stType** %52, i64 3
  %54 = load %struct.stType*, %struct.stType** %53, align 8
  %55 = getelementptr inbounds %struct.stType, %struct.stType* %54, i32 0, i32 0
  %56 = load %struct.COORD*, %struct.COORD** %55, align 8
  %57 = getelementptr inbounds %struct.COORD, %struct.COORD* %56, i32 0, i32 1
  store i32* %51, i32** %57, align 8
  %58 = call noalias i8* @malloc(i64 144) #6
  %59 = bitcast i8* %58 to %struct.stType*
  %60 = load %struct.stType**, %struct.stType*** %obj, align 8
  %61 = getelementptr inbounds %struct.stType*, %struct.stType** %60, i64 1
  store %struct.stType* %59, %struct.stType** %61, align 8
  %62 = call noalias i8* @malloc(i64 16) #6
  %63 = bitcast i8* %62 to %struct.COORD*
  %64 = load %struct.stType**, %struct.stType*** %obj, align 8
  %65 = getelementptr inbounds %struct.stType*, %struct.stType** %64, i64 1
  %66 = load %struct.stType*, %struct.stType** %65, align 8
  %67 = getelementptr inbounds %struct.stType, %struct.stType* %66, i32 0, i32 0
  store %struct.COORD* %63, %struct.COORD** %67, align 8
  %68 = call noalias i8* @malloc(i64 4) #6
  %69 = bitcast i8* %68 to i32*
  %70 = load %struct.stType**, %struct.stType*** %obj, align 8
  %71 = getelementptr inbounds %struct.stType*, %struct.stType** %70, i64 1
  %72 = load %struct.stType*, %struct.stType** %71, align 8
  %73 = getelementptr inbounds %struct.stType, %struct.stType* %72, i32 0, i32 0
  %74 = load %struct.COORD*, %struct.COORD** %73, align 8
  %75 = getelementptr inbounds %struct.COORD, %struct.COORD* %74, i32 0, i32 0
  store i32* %69, i32** %75, align 8
  %76 = call noalias i8* @malloc(i64 4) #6
  %77 = bitcast i8* %76 to i32*
  %78 = load %struct.stType**, %struct.stType*** %obj, align 8
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
  %90 = load %struct.stType**, %struct.stType*** %obj, align 8
  %91 = getelementptr inbounds %struct.stType*, %struct.stType** %90, i64 0
  %92 = load %struct.stType*, %struct.stType** %91, align 8
  %93 = getelementptr inbounds %struct.stType, %struct.stType* %92, i32 0, i32 0
  %94 = load %struct.COORD*, %struct.COORD** %93, align 8
  %95 = getelementptr inbounds %struct.COORD, %struct.COORD* %94, i32 0, i32 0
  %96 = load i32*, i32** %95, align 8
  %97 = getelementptr inbounds i32, i32* %96, i64 0
  store i32 1, i32* %97, align 4
  %98 = load %struct.stType**, %struct.stType*** %obj, align 8
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
  %107 = load %struct.stType**, %struct.stType*** %obj, align 8
  %108 = getelementptr inbounds %struct.stType*, %struct.stType** %107, i64 0
  %109 = load %struct.stType*, %struct.stType** %108, align 8
  %110 = getelementptr inbounds %struct.stType, %struct.stType* %109, i32 0, i32 0
  %111 = load %struct.COORD*, %struct.COORD** %110, align 8
  %112 = getelementptr inbounds %struct.COORD, %struct.COORD* %111, i32 0, i32 0
  %113 = load i32*, i32** %112, align 8
  %114 = getelementptr inbounds i32, i32* %113, i64 0
  store i32 1, i32* %114, align 4
  %115 = load %struct.stType**, %struct.stType*** %obj, align 8
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
  %124 = load %struct.stType**, %struct.stType*** %obj, align 8
  %125 = getelementptr inbounds %struct.stType*, %struct.stType** %124, i64 0
  %126 = load %struct.stType*, %struct.stType** %125, align 8
  %127 = getelementptr inbounds %struct.stType, %struct.stType* %126, i32 0, i32 2
  %128 = getelementptr inbounds [8 x i32], [8 x i32]* %127, i64 0, i64 0
  store i32 3, i32* %128, align 4
  %129 = load %struct.stType**, %struct.stType*** %obj, align 8
  %130 = getelementptr inbounds %struct.stType*, %struct.stType** %129, i64 0
  %131 = load %struct.stType*, %struct.stType** %130, align 8
  %132 = getelementptr inbounds %struct.stType, %struct.stType* %131, i32 0, i32 2
  %133 = getelementptr inbounds [8 x i32], [8 x i32]* %132, i64 0, i64 1
  store i32 4, i32* %133, align 4
  %134 = load %struct.stType**, %struct.stType*** %obj, align 8
  %135 = getelementptr inbounds %struct.stType*, %struct.stType** %134, i64 0
  %136 = load %struct.stType*, %struct.stType** %135, align 8
  %137 = getelementptr inbounds %struct.stType, %struct.stType* %136, i32 0, i32 2
  %138 = getelementptr inbounds [8 x i32], [8 x i32]* %137, i64 0, i64 2
  store i32 5, i32* %138, align 4
  %139 = load %struct.stType**, %struct.stType*** %obj, align 8
  %140 = getelementptr inbounds %struct.stType*, %struct.stType** %139, i64 3
  %141 = load %struct.stType*, %struct.stType** %140, align 8
  %142 = getelementptr inbounds %struct.stType, %struct.stType* %141, i32 0, i32 0
  %143 = load %struct.COORD*, %struct.COORD** %142, align 8
  %144 = getelementptr inbounds %struct.COORD, %struct.COORD* %143, i32 0, i32 0
  %145 = load i32*, i32** %144, align 8
  %146 = getelementptr inbounds i32, i32* %145, i64 0
  store i32 16, i32* %146, align 4
  %147 = load %struct.stType**, %struct.stType*** %obj, align 8
  %148 = getelementptr inbounds %struct.stType*, %struct.stType** %147, i64 3
  %149 = load %struct.stType*, %struct.stType** %148, align 8
  %150 = getelementptr inbounds %struct.stType, %struct.stType* %149, i32 0, i32 0
  %151 = load %struct.COORD*, %struct.COORD** %150, align 8
  %152 = getelementptr inbounds %struct.COORD, %struct.COORD* %151, i32 0, i32 1
  %153 = load i32*, i32** %152, align 8
  %154 = getelementptr inbounds i32, i32* %153, i64 0
  store i32 17, i32* %154, align 4
  %155 = load %struct.stType**, %struct.stType*** %obj, align 8
  %156 = getelementptr inbounds %struct.stType*, %struct.stType** %155, i64 3
  %157 = load %struct.stType*, %struct.stType** %156, align 8
  %158 = getelementptr inbounds %struct.stType, %struct.stType* %157, i32 0, i32 2
  %159 = getelementptr inbounds [8 x i32], [8 x i32]* %158, i64 0, i64 0
  store i32 18, i32* %159, align 4
  %160 = load %struct.stType**, %struct.stType*** %obj, align 8
  %161 = getelementptr inbounds %struct.stType*, %struct.stType** %160, i64 3
  %162 = load %struct.stType*, %struct.stType** %161, align 8
  %163 = getelementptr inbounds %struct.stType, %struct.stType* %162, i32 0, i32 2
  %164 = getelementptr inbounds [8 x i32], [8 x i32]* %163, i64 0, i64 1
  store i32 19, i32* %164, align 4
  %165 = load %struct.stType**, %struct.stType*** %obj, align 8
  %166 = getelementptr inbounds %struct.stType*, %struct.stType** %165, i64 3
  %167 = load %struct.stType*, %struct.stType** %166, align 8
  %168 = getelementptr inbounds %struct.stType, %struct.stType* %167, i32 0, i32 2
  %169 = getelementptr inbounds [8 x i32], [8 x i32]* %168, i64 0, i64 2
  store i32 20, i32* %169, align 4
  %170 = load %struct.stType**, %struct.stType*** %obj, align 8
  %171 = getelementptr inbounds %struct.stType*, %struct.stType** %170, i64 3
  %172 = load %struct.stType*, %struct.stType** %171, align 8
  %173 = getelementptr inbounds %struct.stType, %struct.stType* %172, i32 0, i32 1
  %174 = getelementptr inbounds [100 x i8], [100 x i8]* %173, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %174, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %228

; <label>:175                                     ; preds = %0
  %176 = load %struct.stType**, %struct.stType*** %obj, align 8
  %177 = getelementptr inbounds %struct.stType*, %struct.stType** %176, i64 0
  %178 = load %struct.stType*, %struct.stType** %177, align 8
  %179 = getelementptr inbounds %struct.stType, %struct.stType* %178, i32 0, i32 0
  %180 = load %struct.COORD*, %struct.COORD** %179, align 8
  %181 = getelementptr inbounds %struct.COORD, %struct.COORD* %180, i32 0, i32 0
  %182 = load i32*, i32** %181, align 8
  %183 = getelementptr inbounds i32, i32* %182, i64 0
  store i32 1, i32* %183, align 4
  %184 = load %struct.stType**, %struct.stType*** %obj, align 8
  %185 = getelementptr inbounds %struct.stType*, %struct.stType** %184, i64 0
  %186 = load %struct.stType*, %struct.stType** %185, align 8
  %187 = getelementptr inbounds %struct.stType, %struct.stType* %186, i32 0, i32 0
  %188 = load %struct.COORD*, %struct.COORD** %187, align 8
  %189 = getelementptr inbounds %struct.COORD, %struct.COORD* %188, i32 0, i32 1
  %190 = load i32*, i32** %189, align 8
  %191 = getelementptr inbounds i32, i32* %190, i64 0
  store i32 2, i32* %191, align 4
  %192 = load %struct.stType**, %struct.stType*** %obj, align 8
  %193 = getelementptr inbounds %struct.stType*, %struct.stType** %192, i64 1
  %194 = load %struct.stType*, %struct.stType** %193, align 8
  %195 = getelementptr inbounds %struct.stType, %struct.stType* %194, i32 0, i32 0
  %196 = load %struct.COORD*, %struct.COORD** %195, align 8
  %197 = getelementptr inbounds %struct.COORD, %struct.COORD* %196, i32 0, i32 0
  %198 = load i32*, i32** %197, align 8
  %199 = getelementptr inbounds i32, i32* %198, i64 0
  store i32 6, i32* %199, align 4
  %200 = load %struct.stType**, %struct.stType*** %obj, align 8
  %201 = getelementptr inbounds %struct.stType*, %struct.stType** %200, i64 1
  %202 = load %struct.stType*, %struct.stType** %201, align 8
  %203 = getelementptr inbounds %struct.stType, %struct.stType* %202, i32 0, i32 0
  %204 = load %struct.COORD*, %struct.COORD** %203, align 8
  %205 = getelementptr inbounds %struct.COORD, %struct.COORD* %204, i32 0, i32 1
  %206 = load i32*, i32** %205, align 8
  %207 = getelementptr inbounds i32, i32* %206, i64 0
  store i32 7, i32* %207, align 4
  %208 = load %struct.stType**, %struct.stType*** %obj, align 8
  %209 = getelementptr inbounds %struct.stType*, %struct.stType** %208, i64 1
  %210 = load %struct.stType*, %struct.stType** %209, align 8
  %211 = getelementptr inbounds %struct.stType, %struct.stType* %210, i32 0, i32 2
  %212 = getelementptr inbounds [8 x i32], [8 x i32]* %211, i64 0, i64 0
  store i32 8, i32* %212, align 4
  %213 = load %struct.stType**, %struct.stType*** %obj, align 8
  %214 = getelementptr inbounds %struct.stType*, %struct.stType** %213, i64 1
  %215 = load %struct.stType*, %struct.stType** %214, align 8
  %216 = getelementptr inbounds %struct.stType, %struct.stType* %215, i32 0, i32 2
  %217 = getelementptr inbounds [8 x i32], [8 x i32]* %216, i64 0, i64 1
  store i32 9, i32* %217, align 4
  %218 = load %struct.stType**, %struct.stType*** %obj, align 8
  %219 = getelementptr inbounds %struct.stType*, %struct.stType** %218, i64 1
  %220 = load %struct.stType*, %struct.stType** %219, align 8
  %221 = getelementptr inbounds %struct.stType, %struct.stType* %220, i32 0, i32 2
  %222 = getelementptr inbounds [8 x i32], [8 x i32]* %221, i64 0, i64 2
  store i32 10, i32* %222, align 4
  %223 = load %struct.stType**, %struct.stType*** %obj, align 8
  %224 = getelementptr inbounds %struct.stType*, %struct.stType** %223, i64 1
  %225 = load %struct.stType*, %struct.stType** %224, align 8
  %226 = getelementptr inbounds %struct.stType, %struct.stType* %225, i32 0, i32 1
  %227 = getelementptr inbounds [100 x i8], [100 x i8]* %226, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %227, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %228

; <label>:228                                     ; preds = %175, %123
  %229 = load %struct.stType**, %struct.stType*** %obj, align 8
  %230 = getelementptr inbounds %struct.stType*, %struct.stType** %229, i64 3
  %231 = load %struct.stType*, %struct.stType** %230, align 8
  %232 = getelementptr inbounds %struct.stType, %struct.stType* %231, i32 0, i32 0
  %233 = load %struct.COORD*, %struct.COORD** %232, align 8
  %234 = getelementptr inbounds %struct.COORD, %struct.COORD* %233, i32 0, i32 0
  %235 = load i32*, i32** %234, align 8
  %236 = getelementptr inbounds i32, i32* %235, i64 0
  store i32 16, i32* %236, align 4
  %237 = load %struct.stType**, %struct.stType*** %obj, align 8
  %238 = getelementptr inbounds %struct.stType*, %struct.stType** %237, i64 3
  %239 = load %struct.stType*, %struct.stType** %238, align 8
  %240 = getelementptr inbounds %struct.stType, %struct.stType* %239, i32 0, i32 0
  %241 = load %struct.COORD*, %struct.COORD** %240, align 8
  %242 = getelementptr inbounds %struct.COORD, %struct.COORD* %241, i32 0, i32 1
  %243 = load i32*, i32** %242, align 8
  %244 = getelementptr inbounds i32, i32* %243, i64 0
  store i32 17, i32* %244, align 4
  %245 = load %struct.stType**, %struct.stType*** %obj, align 8
  %246 = getelementptr inbounds %struct.stType*, %struct.stType** %245, i64 0
  %247 = load %struct.stType*, %struct.stType** %246, align 8
  %248 = getelementptr inbounds %struct.stType, %struct.stType* %247, i32 0, i32 1
  %249 = getelementptr inbounds [100 x i8], [100 x i8]* %248, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %249, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %250 = load %struct.stType**, %struct.stType*** %obj, align 8
  %251 = getelementptr inbounds %struct.stType*, %struct.stType** %250, i64 1
  %252 = load %struct.stType*, %struct.stType** %251, align 8
  %253 = getelementptr inbounds %struct.stType, %struct.stType* %252, i32 0, i32 0
  %254 = load %struct.COORD*, %struct.COORD** %253, align 8
  %255 = getelementptr inbounds %struct.COORD, %struct.COORD* %254, i32 0, i32 0
  %256 = load i32*, i32** %255, align 8
  %257 = getelementptr inbounds i32, i32* %256, i64 0
  store i32 6, i32* %257, align 4
  %258 = load %struct.stType**, %struct.stType*** %obj, align 8
  %259 = getelementptr inbounds %struct.stType*, %struct.stType** %258, i64 1
  %260 = load %struct.stType*, %struct.stType** %259, align 8
  %261 = getelementptr inbounds %struct.stType, %struct.stType* %260, i32 0, i32 0
  %262 = load %struct.COORD*, %struct.COORD** %261, align 8
  %263 = getelementptr inbounds %struct.COORD, %struct.COORD* %262, i32 0, i32 1
  %264 = load i32*, i32** %263, align 8
  %265 = getelementptr inbounds i32, i32* %264, i64 0
  store i32 7, i32* %265, align 4
  %266 = load %struct.stType**, %struct.stType*** %obj, align 8
  %267 = getelementptr inbounds %struct.stType*, %struct.stType** %266, i64 1
  %268 = load %struct.stType*, %struct.stType** %267, align 8
  %269 = getelementptr inbounds %struct.stType, %struct.stType* %268, i32 0, i32 2
  %270 = getelementptr inbounds [8 x i32], [8 x i32]* %269, i64 0, i64 0
  store i32 8, i32* %270, align 4
  %271 = load %struct.stType**, %struct.stType*** %obj, align 8
  %272 = getelementptr inbounds %struct.stType*, %struct.stType** %271, i64 1
  %273 = load %struct.stType*, %struct.stType** %272, align 8
  %274 = getelementptr inbounds %struct.stType, %struct.stType* %273, i32 0, i32 2
  %275 = getelementptr inbounds [8 x i32], [8 x i32]* %274, i64 0, i64 1
  store i32 9, i32* %275, align 4
  %276 = load %struct.stType**, %struct.stType*** %obj, align 8
  %277 = getelementptr inbounds %struct.stType*, %struct.stType** %276, i64 1
  %278 = load %struct.stType*, %struct.stType** %277, align 8
  %279 = getelementptr inbounds %struct.stType, %struct.stType* %278, i32 0, i32 2
  %280 = getelementptr inbounds [8 x i32], [8 x i32]* %279, i64 0, i64 2
  store i32 10, i32* %280, align 4
  %281 = load %struct.stType**, %struct.stType*** %obj, align 8
  %282 = getelementptr inbounds %struct.stType*, %struct.stType** %281, i64 1
  %283 = load %struct.stType*, %struct.stType** %282, align 8
  %284 = getelementptr inbounds %struct.stType, %struct.stType* %283, i32 0, i32 1
  %285 = getelementptr inbounds [100 x i8], [100 x i8]* %284, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %286 = call noalias i8* @malloc(i64 144) #6
  %287 = bitcast i8* %286 to %struct.stType*
  %288 = load %struct.stType**, %struct.stType*** %obj, align 8
  %289 = getelementptr inbounds %struct.stType*, %struct.stType** %288, i64 2
  store %struct.stType* %287, %struct.stType** %289, align 8
  %290 = call noalias i8* @malloc(i64 16) #6
  %291 = bitcast i8* %290 to %struct.COORD*
  %292 = load %struct.stType**, %struct.stType*** %obj, align 8
  %293 = getelementptr inbounds %struct.stType*, %struct.stType** %292, i64 2
  %294 = load %struct.stType*, %struct.stType** %293, align 8
  %295 = getelementptr inbounds %struct.stType, %struct.stType* %294, i32 0, i32 0
  store %struct.COORD* %291, %struct.COORD** %295, align 8
  %296 = call noalias i8* @malloc(i64 4) #6
  %297 = bitcast i8* %296 to i32*
  %298 = load %struct.stType**, %struct.stType*** %obj, align 8
  %299 = getelementptr inbounds %struct.stType*, %struct.stType** %298, i64 2
  %300 = load %struct.stType*, %struct.stType** %299, align 8
  %301 = getelementptr inbounds %struct.stType, %struct.stType* %300, i32 0, i32 0
  %302 = load %struct.COORD*, %struct.COORD** %301, align 8
  %303 = getelementptr inbounds %struct.COORD, %struct.COORD* %302, i32 0, i32 0
  store i32* %297, i32** %303, align 8
  %304 = call noalias i8* @malloc(i64 4) #6
  %305 = bitcast i8* %304 to i32*
  %306 = load %struct.stType**, %struct.stType*** %obj, align 8
  %307 = getelementptr inbounds %struct.stType*, %struct.stType** %306, i64 2
  %308 = load %struct.stType*, %struct.stType** %307, align 8
  %309 = getelementptr inbounds %struct.stType, %struct.stType* %308, i32 0, i32 0
  %310 = load %struct.COORD*, %struct.COORD** %309, align 8
  %311 = getelementptr inbounds %struct.COORD, %struct.COORD* %310, i32 0, i32 1
  store i32* %305, i32** %311, align 8
  %312 = load %struct.stType**, %struct.stType*** %obj, align 8
  %313 = getelementptr inbounds %struct.stType*, %struct.stType** %312, i64 2
  %314 = load %struct.stType*, %struct.stType** %313, align 8
  %315 = getelementptr inbounds %struct.stType, %struct.stType* %314, i32 0, i32 0
  %316 = load %struct.COORD*, %struct.COORD** %315, align 8
  %317 = getelementptr inbounds %struct.COORD, %struct.COORD* %316, i32 0, i32 0
  %318 = load i32*, i32** %317, align 8
  %319 = getelementptr inbounds i32, i32* %318, i64 0
  store i32 11, i32* %319, align 4
  %320 = load %struct.stType**, %struct.stType*** %obj, align 8
  %321 = getelementptr inbounds %struct.stType*, %struct.stType** %320, i64 2
  %322 = load %struct.stType*, %struct.stType** %321, align 8
  %323 = getelementptr inbounds %struct.stType, %struct.stType* %322, i32 0, i32 0
  %324 = load %struct.COORD*, %struct.COORD** %323, align 8
  %325 = getelementptr inbounds %struct.COORD, %struct.COORD* %324, i32 0, i32 1
  %326 = load i32*, i32** %325, align 8
  %327 = getelementptr inbounds i32, i32* %326, i64 0
  store i32 12, i32* %327, align 4
  %328 = load %struct.stType**, %struct.stType*** %obj, align 8
  %329 = getelementptr inbounds %struct.stType*, %struct.stType** %328, i64 2
  %330 = load %struct.stType*, %struct.stType** %329, align 8
  %331 = getelementptr inbounds %struct.stType, %struct.stType* %330, i32 0, i32 2
  %332 = getelementptr inbounds [8 x i32], [8 x i32]* %331, i64 0, i64 0
  store i32 13, i32* %332, align 4
  %333 = load %struct.stType**, %struct.stType*** %obj, align 8
  %334 = getelementptr inbounds %struct.stType*, %struct.stType** %333, i64 2
  %335 = load %struct.stType*, %struct.stType** %334, align 8
  %336 = getelementptr inbounds %struct.stType, %struct.stType* %335, i32 0, i32 2
  %337 = getelementptr inbounds [8 x i32], [8 x i32]* %336, i64 0, i64 1
  store i32 14, i32* %337, align 4
  %338 = load %struct.stType**, %struct.stType*** %obj, align 8
  %339 = getelementptr inbounds %struct.stType*, %struct.stType** %338, i64 2
  %340 = load %struct.stType*, %struct.stType** %339, align 8
  %341 = getelementptr inbounds %struct.stType, %struct.stType* %340, i32 0, i32 2
  %342 = getelementptr inbounds [8 x i32], [8 x i32]* %341, i64 0, i64 2
  store i32 15, i32* %342, align 4
  %343 = load %struct.stType**, %struct.stType*** %obj, align 8
  %344 = getelementptr inbounds %struct.stType*, %struct.stType** %343, i64 2
  %345 = load %struct.stType*, %struct.stType** %344, align 8
  %346 = getelementptr inbounds %struct.stType, %struct.stType* %345, i32 0, i32 1
  %347 = getelementptr inbounds [100 x i8], [100 x i8]* %346, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %347, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %348 = load %struct.stType**, %struct.stType*** %obj, align 8
  call void @branchPruned(%struct.stType** %348)
  %349 = load %struct.stType**, %struct.stType*** %obj, align 8
  call void @branchNotPruned(%struct.stType** %349)
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
