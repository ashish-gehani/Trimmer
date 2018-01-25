; ModuleID = 'workdir/inter14t1.bc'
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
  %2 = alloca %struct.stType**, align 8
  store %struct.stType** %0, %struct.stType*** %2, align 8
  %3 = load %struct.stType**, %struct.stType*** %2, align 8
  %4 = getelementptr inbounds %struct.stType*, %struct.stType** %3, i64 0
  %5 = load %struct.stType*, %struct.stType** %4, align 8
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %5, i32 0, i32 0
  %7 = load %struct.COORD*, %struct.COORD** %6, align 8
  %8 = getelementptr inbounds %struct.COORD, %struct.COORD* %7, i32 0, i32 0
  %9 = load i32*, i32** %8, align 8
  %10 = load i32, i32* %9, align 4
  %11 = icmp eq i32 %10, 1
  br i1 %11, label %12, label %124

; <label>:12:                                     ; preds = %1
  %13 = load %struct.stType**, %struct.stType*** %2, align 8
  %14 = getelementptr inbounds %struct.stType*, %struct.stType** %13, i64 0
  %15 = load %struct.stType*, %struct.stType** %14, align 8
  %16 = getelementptr inbounds %struct.stType, %struct.stType* %15, i32 0, i32 0
  %17 = load %struct.COORD*, %struct.COORD** %16, align 8
  %18 = getelementptr inbounds %struct.COORD, %struct.COORD* %17, i32 0, i32 1
  %19 = load i32*, i32** %18, align 8
  %20 = load i32, i32* %19, align 4
  %21 = icmp eq i32 %20, 2
  br i1 %21, label %22, label %124

; <label>:22:                                     ; preds = %12
  %23 = load %struct.stType**, %struct.stType*** %2, align 8
  %24 = getelementptr inbounds %struct.stType*, %struct.stType** %23, i64 0
  %25 = load %struct.stType*, %struct.stType** %24, align 8
  %26 = getelementptr inbounds %struct.stType, %struct.stType* %25, i32 0, i32 1
  %27 = getelementptr inbounds [100 x i8], [100 x i8]* %26, i32 0, i32 0
  %28 = call i32 @strcmp(i8* %27, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %124, label %30

; <label>:30:                                     ; preds = %22
  %31 = load %struct.stType**, %struct.stType*** %2, align 8
  %32 = getelementptr inbounds %struct.stType*, %struct.stType** %31, i64 0
  %33 = load %struct.stType*, %struct.stType** %32, align 8
  %34 = getelementptr inbounds %struct.stType, %struct.stType* %33, i32 0, i32 1
  %35 = getelementptr inbounds [100 x i8], [100 x i8]* %34, i64 0, i64 4
  %36 = load i8, i8* %35, align 4
  %37 = sext i8 %36 to i32
  %38 = icmp eq i32 %37, 111
  br i1 %38, label %39, label %124

; <label>:39:                                     ; preds = %30
  %40 = load %struct.stType**, %struct.stType*** %2, align 8
  %41 = getelementptr inbounds %struct.stType*, %struct.stType** %40, i64 0
  %42 = load %struct.stType*, %struct.stType** %41, align 8
  %43 = getelementptr inbounds %struct.stType, %struct.stType* %42, i32 0, i32 1
  %44 = getelementptr inbounds [100 x i8], [100 x i8]* %43, i64 0, i64 9
  %45 = load i8, i8* %44, align 1
  %46 = sext i8 %45 to i32
  %47 = icmp eq i32 %46, 100
  br i1 %47, label %48, label %124

; <label>:48:                                     ; preds = %39
  %49 = load %struct.stType**, %struct.stType*** %2, align 8
  %50 = getelementptr inbounds %struct.stType*, %struct.stType** %49, i64 2
  %51 = load %struct.stType*, %struct.stType** %50, align 8
  %52 = getelementptr inbounds %struct.stType, %struct.stType* %51, i32 0, i32 0
  %53 = load %struct.COORD*, %struct.COORD** %52, align 8
  %54 = getelementptr inbounds %struct.COORD, %struct.COORD* %53, i32 0, i32 0
  %55 = load i32*, i32** %54, align 8
  %56 = load i32, i32* %55, align 4
  %57 = icmp eq i32 %56, 11
  br i1 %57, label %58, label %124

; <label>:58:                                     ; preds = %48
  %59 = load %struct.stType**, %struct.stType*** %2, align 8
  %60 = getelementptr inbounds %struct.stType*, %struct.stType** %59, i64 2
  %61 = load %struct.stType*, %struct.stType** %60, align 8
  %62 = getelementptr inbounds %struct.stType, %struct.stType* %61, i32 0, i32 0
  %63 = load %struct.COORD*, %struct.COORD** %62, align 8
  %64 = getelementptr inbounds %struct.COORD, %struct.COORD* %63, i32 0, i32 1
  %65 = load i32*, i32** %64, align 8
  %66 = load i32, i32* %65, align 4
  %67 = icmp eq i32 %66, 12
  br i1 %67, label %68, label %124

; <label>:68:                                     ; preds = %58
  %69 = load %struct.stType**, %struct.stType*** %2, align 8
  %70 = getelementptr inbounds %struct.stType*, %struct.stType** %69, i64 3
  %71 = load %struct.stType*, %struct.stType** %70, align 8
  %72 = getelementptr inbounds %struct.stType, %struct.stType* %71, i32 0, i32 0
  %73 = load %struct.COORD*, %struct.COORD** %72, align 8
  %74 = getelementptr inbounds %struct.COORD, %struct.COORD* %73, i32 0, i32 0
  %75 = load i32*, i32** %74, align 8
  %76 = load i32, i32* %75, align 4
  %77 = icmp eq i32 %76, 16
  br i1 %77, label %78, label %124

; <label>:78:                                     ; preds = %68
  %79 = load %struct.stType**, %struct.stType*** %2, align 8
  %80 = getelementptr inbounds %struct.stType*, %struct.stType** %79, i64 3
  %81 = load %struct.stType*, %struct.stType** %80, align 8
  %82 = getelementptr inbounds %struct.stType, %struct.stType* %81, i32 0, i32 0
  %83 = load %struct.COORD*, %struct.COORD** %82, align 8
  %84 = getelementptr inbounds %struct.COORD, %struct.COORD* %83, i32 0, i32 1
  %85 = load i32*, i32** %84, align 8
  %86 = load i32, i32* %85, align 4
  %87 = icmp eq i32 %86, 17
  br i1 %87, label %88, label %124

; <label>:88:                                     ; preds = %78
  %89 = load %struct.stType**, %struct.stType*** %2, align 8
  %90 = getelementptr inbounds %struct.stType*, %struct.stType** %89, i64 2
  %91 = load %struct.stType*, %struct.stType** %90, align 8
  %92 = getelementptr inbounds %struct.stType, %struct.stType* %91, i32 0, i32 2
  %93 = getelementptr inbounds [8 x i32], [8 x i32]* %92, i64 0, i64 1
  %94 = load i32, i32* %93, align 4
  %95 = icmp eq i32 %94, 14
  br i1 %95, label %96, label %124

; <label>:96:                                     ; preds = %88
  %97 = load %struct.stType**, %struct.stType*** %2, align 8
  %98 = getelementptr inbounds %struct.stType*, %struct.stType** %97, i64 2
  %99 = load %struct.stType*, %struct.stType** %98, align 8
  %100 = getelementptr inbounds %struct.stType, %struct.stType* %99, i32 0, i32 1
  %101 = getelementptr inbounds [100 x i8], [100 x i8]* %100, i32 0, i32 0
  %102 = call i32 @strcmp(i8* %101, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %103 = icmp ne i32 %102, 0
  br i1 %103, label %124, label %104

; <label>:104:                                    ; preds = %96
  %105 = load %struct.stType**, %struct.stType*** %2, align 8
  %106 = getelementptr inbounds %struct.stType*, %struct.stType** %105, i64 2
  %107 = load %struct.stType*, %struct.stType** %106, align 8
  %108 = getelementptr inbounds %struct.stType, %struct.stType* %107, i32 0, i32 1
  %109 = getelementptr inbounds [100 x i8], [100 x i8]* %108, i64 0, i64 4
  %110 = load i8, i8* %109, align 4
  %111 = sext i8 %110 to i32
  %112 = icmp eq i32 %111, 111
  br i1 %112, label %113, label %124

; <label>:113:                                    ; preds = %104
  %114 = load %struct.stType**, %struct.stType*** %2, align 8
  %115 = getelementptr inbounds %struct.stType*, %struct.stType** %114, i64 2
  %116 = load %struct.stType*, %struct.stType** %115, align 8
  %117 = getelementptr inbounds %struct.stType, %struct.stType* %116, i32 0, i32 1
  %118 = getelementptr inbounds [100 x i8], [100 x i8]* %117, i64 0, i64 9
  %119 = load i8, i8* %118, align 1
  %120 = sext i8 %119 to i32
  %121 = icmp eq i32 %120, 100
  br i1 %121, label %122, label %124

; <label>:122:                                    ; preds = %113
  %123 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %124

; <label>:124:                                    ; preds = %122, %113, %104, %96, %88, %78, %68, %58, %48, %39, %30, %22, %12, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned(%struct.stType**) #0 {
  %2 = alloca %struct.stType**, align 8
  store %struct.stType** %0, %struct.stType*** %2, align 8
  %3 = load %struct.stType**, %struct.stType*** %2, align 8
  %4 = getelementptr inbounds %struct.stType*, %struct.stType** %3, i64 0
  %5 = load %struct.stType*, %struct.stType** %4, align 8
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %5, i32 0, i32 2
  %7 = getelementptr inbounds [8 x i32], [8 x i32]* %6, i64 0, i64 1
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 %8, 4
  br i1 %9, label %44, label %10

; <label>:10:                                     ; preds = %1
  %11 = load %struct.stType**, %struct.stType*** %2, align 8
  %12 = getelementptr inbounds %struct.stType*, %struct.stType** %11, i64 3
  %13 = load %struct.stType*, %struct.stType** %12, align 8
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %13, i32 0, i32 2
  %15 = getelementptr inbounds [8 x i32], [8 x i32]* %14, i64 0, i64 1
  %16 = load i32, i32* %15, align 4
  %17 = icmp eq i32 %16, 19
  br i1 %17, label %44, label %18

; <label>:18:                                     ; preds = %10
  %19 = load %struct.stType**, %struct.stType*** %2, align 8
  %20 = getelementptr inbounds %struct.stType*, %struct.stType** %19, i64 3
  %21 = load %struct.stType*, %struct.stType** %20, align 8
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %21, i32 0, i32 1
  %23 = getelementptr inbounds [100 x i8], [100 x i8]* %22, i32 0, i32 0
  %24 = call i32 @strcmp(i8* %23, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %26, label %44

; <label>:26:                                     ; preds = %18
  %27 = load %struct.stType**, %struct.stType*** %2, align 8
  %28 = getelementptr inbounds %struct.stType*, %struct.stType** %27, i64 3
  %29 = load %struct.stType*, %struct.stType** %28, align 8
  %30 = getelementptr inbounds %struct.stType, %struct.stType* %29, i32 0, i32 1
  %31 = getelementptr inbounds [100 x i8], [100 x i8]* %30, i64 0, i64 4
  %32 = load i8, i8* %31, align 4
  %33 = sext i8 %32 to i32
  %34 = icmp eq i32 %33, 111
  br i1 %34, label %44, label %35

; <label>:35:                                     ; preds = %26
  %36 = load %struct.stType**, %struct.stType*** %2, align 8
  %37 = getelementptr inbounds %struct.stType*, %struct.stType** %36, i64 3
  %38 = load %struct.stType*, %struct.stType** %37, align 8
  %39 = getelementptr inbounds %struct.stType, %struct.stType* %38, i32 0, i32 1
  %40 = getelementptr inbounds [100 x i8], [100 x i8]* %39, i64 0, i64 9
  %41 = load i8, i8* %40, align 1
  %42 = sext i8 %41 to i32
  %43 = icmp eq i32 %42, 100
  br i1 %43, label %44, label %46

; <label>:44:                                     ; preds = %35, %26, %18, %10, %1
  %45 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0))
  br label %46

; <label>:46:                                     ; preds = %44, %35
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca %struct.stType**, align 8
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  %7 = call noalias i8* @malloc(i64 160) #6
  %8 = bitcast i8* %7 to %struct.stType**
  store %struct.stType** %8, %struct.stType*** %6, align 8
  %9 = call noalias i8* @malloc(i64 144) #6
  %10 = bitcast i8* %9 to %struct.stType*
  %11 = load %struct.stType**, %struct.stType*** %6, align 8
  %12 = getelementptr inbounds %struct.stType*, %struct.stType** %11, i64 0
  store %struct.stType* %10, %struct.stType** %12, align 8
  %13 = call noalias i8* @malloc(i64 16) #6
  %14 = bitcast i8* %13 to %struct.COORD*
  %15 = load %struct.stType**, %struct.stType*** %6, align 8
  %16 = getelementptr inbounds %struct.stType*, %struct.stType** %15, i64 0
  %17 = load %struct.stType*, %struct.stType** %16, align 8
  %18 = getelementptr inbounds %struct.stType, %struct.stType* %17, i32 0, i32 0
  store %struct.COORD* %14, %struct.COORD** %18, align 8
  %19 = call noalias i8* @malloc(i64 4) #6
  %20 = bitcast i8* %19 to i32*
  %21 = load %struct.stType**, %struct.stType*** %6, align 8
  %22 = getelementptr inbounds %struct.stType*, %struct.stType** %21, i64 0
  %23 = load %struct.stType*, %struct.stType** %22, align 8
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %23, i32 0, i32 0
  %25 = load %struct.COORD*, %struct.COORD** %24, align 8
  %26 = getelementptr inbounds %struct.COORD, %struct.COORD* %25, i32 0, i32 0
  store i32* %20, i32** %26, align 8
  %27 = call noalias i8* @malloc(i64 4) #6
  %28 = bitcast i8* %27 to i32*
  %29 = load %struct.stType**, %struct.stType*** %6, align 8
  %30 = getelementptr inbounds %struct.stType*, %struct.stType** %29, i64 0
  %31 = load %struct.stType*, %struct.stType** %30, align 8
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %31, i32 0, i32 0
  %33 = load %struct.COORD*, %struct.COORD** %32, align 8
  %34 = getelementptr inbounds %struct.COORD, %struct.COORD* %33, i32 0, i32 1
  store i32* %28, i32** %34, align 8
  %35 = call noalias i8* @malloc(i64 144) #6
  %36 = bitcast i8* %35 to %struct.stType*
  %37 = load %struct.stType**, %struct.stType*** %6, align 8
  %38 = getelementptr inbounds %struct.stType*, %struct.stType** %37, i64 3
  store %struct.stType* %36, %struct.stType** %38, align 8
  %39 = call noalias i8* @malloc(i64 16) #6
  %40 = bitcast i8* %39 to %struct.COORD*
  %41 = load %struct.stType**, %struct.stType*** %6, align 8
  %42 = getelementptr inbounds %struct.stType*, %struct.stType** %41, i64 3
  %43 = load %struct.stType*, %struct.stType** %42, align 8
  %44 = getelementptr inbounds %struct.stType, %struct.stType* %43, i32 0, i32 0
  store %struct.COORD* %40, %struct.COORD** %44, align 8
  %45 = call noalias i8* @malloc(i64 4) #6
  %46 = bitcast i8* %45 to i32*
  %47 = load %struct.stType**, %struct.stType*** %6, align 8
  %48 = getelementptr inbounds %struct.stType*, %struct.stType** %47, i64 3
  %49 = load %struct.stType*, %struct.stType** %48, align 8
  %50 = getelementptr inbounds %struct.stType, %struct.stType* %49, i32 0, i32 0
  %51 = load %struct.COORD*, %struct.COORD** %50, align 8
  %52 = getelementptr inbounds %struct.COORD, %struct.COORD* %51, i32 0, i32 0
  store i32* %46, i32** %52, align 8
  %53 = call noalias i8* @malloc(i64 4) #6
  %54 = bitcast i8* %53 to i32*
  %55 = load %struct.stType**, %struct.stType*** %6, align 8
  %56 = getelementptr inbounds %struct.stType*, %struct.stType** %55, i64 3
  %57 = load %struct.stType*, %struct.stType** %56, align 8
  %58 = getelementptr inbounds %struct.stType, %struct.stType* %57, i32 0, i32 0
  %59 = load %struct.COORD*, %struct.COORD** %58, align 8
  %60 = getelementptr inbounds %struct.COORD, %struct.COORD* %59, i32 0, i32 1
  store i32* %54, i32** %60, align 8
  %61 = call noalias i8* @malloc(i64 144) #6
  %62 = bitcast i8* %61 to %struct.stType*
  %63 = load %struct.stType**, %struct.stType*** %6, align 8
  %64 = getelementptr inbounds %struct.stType*, %struct.stType** %63, i64 1
  store %struct.stType* %62, %struct.stType** %64, align 8
  %65 = call noalias i8* @malloc(i64 16) #6
  %66 = bitcast i8* %65 to %struct.COORD*
  %67 = load %struct.stType**, %struct.stType*** %6, align 8
  %68 = getelementptr inbounds %struct.stType*, %struct.stType** %67, i64 1
  %69 = load %struct.stType*, %struct.stType** %68, align 8
  %70 = getelementptr inbounds %struct.stType, %struct.stType* %69, i32 0, i32 0
  store %struct.COORD* %66, %struct.COORD** %70, align 8
  %71 = call noalias i8* @malloc(i64 4) #6
  %72 = bitcast i8* %71 to i32*
  %73 = load %struct.stType**, %struct.stType*** %6, align 8
  %74 = getelementptr inbounds %struct.stType*, %struct.stType** %73, i64 1
  %75 = load %struct.stType*, %struct.stType** %74, align 8
  %76 = getelementptr inbounds %struct.stType, %struct.stType* %75, i32 0, i32 0
  %77 = load %struct.COORD*, %struct.COORD** %76, align 8
  %78 = getelementptr inbounds %struct.COORD, %struct.COORD* %77, i32 0, i32 0
  store i32* %72, i32** %78, align 8
  %79 = call noalias i8* @malloc(i64 4) #6
  %80 = bitcast i8* %79 to i32*
  %81 = load %struct.stType**, %struct.stType*** %6, align 8
  %82 = getelementptr inbounds %struct.stType*, %struct.stType** %81, i64 1
  %83 = load %struct.stType*, %struct.stType** %82, align 8
  %84 = getelementptr inbounds %struct.stType, %struct.stType* %83, i32 0, i32 0
  %85 = load %struct.COORD*, %struct.COORD** %84, align 8
  %86 = getelementptr inbounds %struct.COORD, %struct.COORD* %85, i32 0, i32 1
  store i32* %80, i32** %86, align 8
  %87 = load i32, i32* %4, align 4
  %88 = icmp sgt i32 %87, 2
  br i1 %88, label %89, label %178

; <label>:89:                                     ; preds = %2
  %90 = load i32, i32* %4, align 4
  %91 = icmp sgt i32 %90, 5
  br i1 %91, label %92, label %109

; <label>:92:                                     ; preds = %89
  %93 = load %struct.stType**, %struct.stType*** %6, align 8
  %94 = getelementptr inbounds %struct.stType*, %struct.stType** %93, i64 0
  %95 = load %struct.stType*, %struct.stType** %94, align 8
  %96 = getelementptr inbounds %struct.stType, %struct.stType* %95, i32 0, i32 0
  %97 = load %struct.COORD*, %struct.COORD** %96, align 8
  %98 = getelementptr inbounds %struct.COORD, %struct.COORD* %97, i32 0, i32 0
  %99 = load i32*, i32** %98, align 8
  %100 = getelementptr inbounds i32, i32* %99, i64 0
  store i32 1, i32* %100, align 4
  %101 = load %struct.stType**, %struct.stType*** %6, align 8
  %102 = getelementptr inbounds %struct.stType*, %struct.stType** %101, i64 0
  %103 = load %struct.stType*, %struct.stType** %102, align 8
  %104 = getelementptr inbounds %struct.stType, %struct.stType* %103, i32 0, i32 0
  %105 = load %struct.COORD*, %struct.COORD** %104, align 8
  %106 = getelementptr inbounds %struct.COORD, %struct.COORD* %105, i32 0, i32 1
  %107 = load i32*, i32** %106, align 8
  %108 = getelementptr inbounds i32, i32* %107, i64 0
  store i32 2, i32* %108, align 4
  br label %126

; <label>:109:                                    ; preds = %89
  %110 = load %struct.stType**, %struct.stType*** %6, align 8
  %111 = getelementptr inbounds %struct.stType*, %struct.stType** %110, i64 0
  %112 = load %struct.stType*, %struct.stType** %111, align 8
  %113 = getelementptr inbounds %struct.stType, %struct.stType* %112, i32 0, i32 0
  %114 = load %struct.COORD*, %struct.COORD** %113, align 8
  %115 = getelementptr inbounds %struct.COORD, %struct.COORD* %114, i32 0, i32 0
  %116 = load i32*, i32** %115, align 8
  %117 = getelementptr inbounds i32, i32* %116, i64 0
  store i32 1, i32* %117, align 4
  %118 = load %struct.stType**, %struct.stType*** %6, align 8
  %119 = getelementptr inbounds %struct.stType*, %struct.stType** %118, i64 0
  %120 = load %struct.stType*, %struct.stType** %119, align 8
  %121 = getelementptr inbounds %struct.stType, %struct.stType* %120, i32 0, i32 0
  %122 = load %struct.COORD*, %struct.COORD** %121, align 8
  %123 = getelementptr inbounds %struct.COORD, %struct.COORD* %122, i32 0, i32 1
  %124 = load i32*, i32** %123, align 8
  %125 = getelementptr inbounds i32, i32* %124, i64 0
  store i32 2, i32* %125, align 4
  br label %126

; <label>:126:                                    ; preds = %109, %92
  %127 = load %struct.stType**, %struct.stType*** %6, align 8
  %128 = getelementptr inbounds %struct.stType*, %struct.stType** %127, i64 0
  %129 = load %struct.stType*, %struct.stType** %128, align 8
  %130 = getelementptr inbounds %struct.stType, %struct.stType* %129, i32 0, i32 2
  %131 = getelementptr inbounds [8 x i32], [8 x i32]* %130, i64 0, i64 0
  store i32 3, i32* %131, align 4
  %132 = load %struct.stType**, %struct.stType*** %6, align 8
  %133 = getelementptr inbounds %struct.stType*, %struct.stType** %132, i64 0
  %134 = load %struct.stType*, %struct.stType** %133, align 8
  %135 = getelementptr inbounds %struct.stType, %struct.stType* %134, i32 0, i32 2
  %136 = getelementptr inbounds [8 x i32], [8 x i32]* %135, i64 0, i64 1
  store i32 4, i32* %136, align 4
  %137 = load %struct.stType**, %struct.stType*** %6, align 8
  %138 = getelementptr inbounds %struct.stType*, %struct.stType** %137, i64 0
  %139 = load %struct.stType*, %struct.stType** %138, align 8
  %140 = getelementptr inbounds %struct.stType, %struct.stType* %139, i32 0, i32 2
  %141 = getelementptr inbounds [8 x i32], [8 x i32]* %140, i64 0, i64 2
  store i32 5, i32* %141, align 4
  %142 = load %struct.stType**, %struct.stType*** %6, align 8
  %143 = getelementptr inbounds %struct.stType*, %struct.stType** %142, i64 3
  %144 = load %struct.stType*, %struct.stType** %143, align 8
  %145 = getelementptr inbounds %struct.stType, %struct.stType* %144, i32 0, i32 0
  %146 = load %struct.COORD*, %struct.COORD** %145, align 8
  %147 = getelementptr inbounds %struct.COORD, %struct.COORD* %146, i32 0, i32 0
  %148 = load i32*, i32** %147, align 8
  %149 = getelementptr inbounds i32, i32* %148, i64 0
  store i32 16, i32* %149, align 4
  %150 = load %struct.stType**, %struct.stType*** %6, align 8
  %151 = getelementptr inbounds %struct.stType*, %struct.stType** %150, i64 3
  %152 = load %struct.stType*, %struct.stType** %151, align 8
  %153 = getelementptr inbounds %struct.stType, %struct.stType* %152, i32 0, i32 0
  %154 = load %struct.COORD*, %struct.COORD** %153, align 8
  %155 = getelementptr inbounds %struct.COORD, %struct.COORD* %154, i32 0, i32 1
  %156 = load i32*, i32** %155, align 8
  %157 = getelementptr inbounds i32, i32* %156, i64 0
  store i32 17, i32* %157, align 4
  %158 = load %struct.stType**, %struct.stType*** %6, align 8
  %159 = getelementptr inbounds %struct.stType*, %struct.stType** %158, i64 3
  %160 = load %struct.stType*, %struct.stType** %159, align 8
  %161 = getelementptr inbounds %struct.stType, %struct.stType* %160, i32 0, i32 2
  %162 = getelementptr inbounds [8 x i32], [8 x i32]* %161, i64 0, i64 0
  store i32 18, i32* %162, align 4
  %163 = load %struct.stType**, %struct.stType*** %6, align 8
  %164 = getelementptr inbounds %struct.stType*, %struct.stType** %163, i64 3
  %165 = load %struct.stType*, %struct.stType** %164, align 8
  %166 = getelementptr inbounds %struct.stType, %struct.stType* %165, i32 0, i32 2
  %167 = getelementptr inbounds [8 x i32], [8 x i32]* %166, i64 0, i64 1
  store i32 19, i32* %167, align 4
  %168 = load %struct.stType**, %struct.stType*** %6, align 8
  %169 = getelementptr inbounds %struct.stType*, %struct.stType** %168, i64 3
  %170 = load %struct.stType*, %struct.stType** %169, align 8
  %171 = getelementptr inbounds %struct.stType, %struct.stType* %170, i32 0, i32 2
  %172 = getelementptr inbounds [8 x i32], [8 x i32]* %171, i64 0, i64 2
  store i32 20, i32* %172, align 4
  %173 = load %struct.stType**, %struct.stType*** %6, align 8
  %174 = getelementptr inbounds %struct.stType*, %struct.stType** %173, i64 3
  %175 = load %struct.stType*, %struct.stType** %174, align 8
  %176 = getelementptr inbounds %struct.stType, %struct.stType* %175, i32 0, i32 1
  %177 = getelementptr inbounds [100 x i8], [100 x i8]* %176, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %177, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %231

; <label>:178:                                    ; preds = %2
  %179 = load %struct.stType**, %struct.stType*** %6, align 8
  %180 = getelementptr inbounds %struct.stType*, %struct.stType** %179, i64 0
  %181 = load %struct.stType*, %struct.stType** %180, align 8
  %182 = getelementptr inbounds %struct.stType, %struct.stType* %181, i32 0, i32 0
  %183 = load %struct.COORD*, %struct.COORD** %182, align 8
  %184 = getelementptr inbounds %struct.COORD, %struct.COORD* %183, i32 0, i32 0
  %185 = load i32*, i32** %184, align 8
  %186 = getelementptr inbounds i32, i32* %185, i64 0
  store i32 1, i32* %186, align 4
  %187 = load %struct.stType**, %struct.stType*** %6, align 8
  %188 = getelementptr inbounds %struct.stType*, %struct.stType** %187, i64 0
  %189 = load %struct.stType*, %struct.stType** %188, align 8
  %190 = getelementptr inbounds %struct.stType, %struct.stType* %189, i32 0, i32 0
  %191 = load %struct.COORD*, %struct.COORD** %190, align 8
  %192 = getelementptr inbounds %struct.COORD, %struct.COORD* %191, i32 0, i32 1
  %193 = load i32*, i32** %192, align 8
  %194 = getelementptr inbounds i32, i32* %193, i64 0
  store i32 2, i32* %194, align 4
  %195 = load %struct.stType**, %struct.stType*** %6, align 8
  %196 = getelementptr inbounds %struct.stType*, %struct.stType** %195, i64 1
  %197 = load %struct.stType*, %struct.stType** %196, align 8
  %198 = getelementptr inbounds %struct.stType, %struct.stType* %197, i32 0, i32 0
  %199 = load %struct.COORD*, %struct.COORD** %198, align 8
  %200 = getelementptr inbounds %struct.COORD, %struct.COORD* %199, i32 0, i32 0
  %201 = load i32*, i32** %200, align 8
  %202 = getelementptr inbounds i32, i32* %201, i64 0
  store i32 6, i32* %202, align 4
  %203 = load %struct.stType**, %struct.stType*** %6, align 8
  %204 = getelementptr inbounds %struct.stType*, %struct.stType** %203, i64 1
  %205 = load %struct.stType*, %struct.stType** %204, align 8
  %206 = getelementptr inbounds %struct.stType, %struct.stType* %205, i32 0, i32 0
  %207 = load %struct.COORD*, %struct.COORD** %206, align 8
  %208 = getelementptr inbounds %struct.COORD, %struct.COORD* %207, i32 0, i32 1
  %209 = load i32*, i32** %208, align 8
  %210 = getelementptr inbounds i32, i32* %209, i64 0
  store i32 7, i32* %210, align 4
  %211 = load %struct.stType**, %struct.stType*** %6, align 8
  %212 = getelementptr inbounds %struct.stType*, %struct.stType** %211, i64 1
  %213 = load %struct.stType*, %struct.stType** %212, align 8
  %214 = getelementptr inbounds %struct.stType, %struct.stType* %213, i32 0, i32 2
  %215 = getelementptr inbounds [8 x i32], [8 x i32]* %214, i64 0, i64 0
  store i32 8, i32* %215, align 4
  %216 = load %struct.stType**, %struct.stType*** %6, align 8
  %217 = getelementptr inbounds %struct.stType*, %struct.stType** %216, i64 1
  %218 = load %struct.stType*, %struct.stType** %217, align 8
  %219 = getelementptr inbounds %struct.stType, %struct.stType* %218, i32 0, i32 2
  %220 = getelementptr inbounds [8 x i32], [8 x i32]* %219, i64 0, i64 1
  store i32 9, i32* %220, align 4
  %221 = load %struct.stType**, %struct.stType*** %6, align 8
  %222 = getelementptr inbounds %struct.stType*, %struct.stType** %221, i64 1
  %223 = load %struct.stType*, %struct.stType** %222, align 8
  %224 = getelementptr inbounds %struct.stType, %struct.stType* %223, i32 0, i32 2
  %225 = getelementptr inbounds [8 x i32], [8 x i32]* %224, i64 0, i64 2
  store i32 10, i32* %225, align 4
  %226 = load %struct.stType**, %struct.stType*** %6, align 8
  %227 = getelementptr inbounds %struct.stType*, %struct.stType** %226, i64 1
  %228 = load %struct.stType*, %struct.stType** %227, align 8
  %229 = getelementptr inbounds %struct.stType, %struct.stType* %228, i32 0, i32 1
  %230 = getelementptr inbounds [100 x i8], [100 x i8]* %229, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %230, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %231

; <label>:231:                                    ; preds = %178, %126
  %232 = load %struct.stType**, %struct.stType*** %6, align 8
  %233 = getelementptr inbounds %struct.stType*, %struct.stType** %232, i64 3
  %234 = load %struct.stType*, %struct.stType** %233, align 8
  %235 = getelementptr inbounds %struct.stType, %struct.stType* %234, i32 0, i32 0
  %236 = load %struct.COORD*, %struct.COORD** %235, align 8
  %237 = getelementptr inbounds %struct.COORD, %struct.COORD* %236, i32 0, i32 0
  %238 = load i32*, i32** %237, align 8
  %239 = getelementptr inbounds i32, i32* %238, i64 0
  store i32 16, i32* %239, align 4
  %240 = load %struct.stType**, %struct.stType*** %6, align 8
  %241 = getelementptr inbounds %struct.stType*, %struct.stType** %240, i64 3
  %242 = load %struct.stType*, %struct.stType** %241, align 8
  %243 = getelementptr inbounds %struct.stType, %struct.stType* %242, i32 0, i32 0
  %244 = load %struct.COORD*, %struct.COORD** %243, align 8
  %245 = getelementptr inbounds %struct.COORD, %struct.COORD* %244, i32 0, i32 1
  %246 = load i32*, i32** %245, align 8
  %247 = getelementptr inbounds i32, i32* %246, i64 0
  store i32 17, i32* %247, align 4
  %248 = load %struct.stType**, %struct.stType*** %6, align 8
  %249 = getelementptr inbounds %struct.stType*, %struct.stType** %248, i64 0
  %250 = load %struct.stType*, %struct.stType** %249, align 8
  %251 = getelementptr inbounds %struct.stType, %struct.stType* %250, i32 0, i32 1
  %252 = getelementptr inbounds [100 x i8], [100 x i8]* %251, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %252, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %253 = load %struct.stType**, %struct.stType*** %6, align 8
  %254 = getelementptr inbounds %struct.stType*, %struct.stType** %253, i64 1
  %255 = load %struct.stType*, %struct.stType** %254, align 8
  %256 = getelementptr inbounds %struct.stType, %struct.stType* %255, i32 0, i32 0
  %257 = load %struct.COORD*, %struct.COORD** %256, align 8
  %258 = getelementptr inbounds %struct.COORD, %struct.COORD* %257, i32 0, i32 0
  %259 = load i32*, i32** %258, align 8
  %260 = getelementptr inbounds i32, i32* %259, i64 0
  store i32 6, i32* %260, align 4
  %261 = load %struct.stType**, %struct.stType*** %6, align 8
  %262 = getelementptr inbounds %struct.stType*, %struct.stType** %261, i64 1
  %263 = load %struct.stType*, %struct.stType** %262, align 8
  %264 = getelementptr inbounds %struct.stType, %struct.stType* %263, i32 0, i32 0
  %265 = load %struct.COORD*, %struct.COORD** %264, align 8
  %266 = getelementptr inbounds %struct.COORD, %struct.COORD* %265, i32 0, i32 1
  %267 = load i32*, i32** %266, align 8
  %268 = getelementptr inbounds i32, i32* %267, i64 0
  store i32 7, i32* %268, align 4
  %269 = load %struct.stType**, %struct.stType*** %6, align 8
  %270 = getelementptr inbounds %struct.stType*, %struct.stType** %269, i64 1
  %271 = load %struct.stType*, %struct.stType** %270, align 8
  %272 = getelementptr inbounds %struct.stType, %struct.stType* %271, i32 0, i32 2
  %273 = getelementptr inbounds [8 x i32], [8 x i32]* %272, i64 0, i64 0
  store i32 8, i32* %273, align 4
  %274 = load %struct.stType**, %struct.stType*** %6, align 8
  %275 = getelementptr inbounds %struct.stType*, %struct.stType** %274, i64 1
  %276 = load %struct.stType*, %struct.stType** %275, align 8
  %277 = getelementptr inbounds %struct.stType, %struct.stType* %276, i32 0, i32 2
  %278 = getelementptr inbounds [8 x i32], [8 x i32]* %277, i64 0, i64 1
  store i32 9, i32* %278, align 4
  %279 = load %struct.stType**, %struct.stType*** %6, align 8
  %280 = getelementptr inbounds %struct.stType*, %struct.stType** %279, i64 1
  %281 = load %struct.stType*, %struct.stType** %280, align 8
  %282 = getelementptr inbounds %struct.stType, %struct.stType* %281, i32 0, i32 2
  %283 = getelementptr inbounds [8 x i32], [8 x i32]* %282, i64 0, i64 2
  store i32 10, i32* %283, align 4
  %284 = load %struct.stType**, %struct.stType*** %6, align 8
  %285 = getelementptr inbounds %struct.stType*, %struct.stType** %284, i64 1
  %286 = load %struct.stType*, %struct.stType** %285, align 8
  %287 = getelementptr inbounds %struct.stType, %struct.stType* %286, i32 0, i32 1
  %288 = getelementptr inbounds [100 x i8], [100 x i8]* %287, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %288, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %289 = call noalias i8* @malloc(i64 144) #6
  %290 = bitcast i8* %289 to %struct.stType*
  %291 = load %struct.stType**, %struct.stType*** %6, align 8
  %292 = getelementptr inbounds %struct.stType*, %struct.stType** %291, i64 2
  store %struct.stType* %290, %struct.stType** %292, align 8
  %293 = call noalias i8* @malloc(i64 16) #6
  %294 = bitcast i8* %293 to %struct.COORD*
  %295 = load %struct.stType**, %struct.stType*** %6, align 8
  %296 = getelementptr inbounds %struct.stType*, %struct.stType** %295, i64 2
  %297 = load %struct.stType*, %struct.stType** %296, align 8
  %298 = getelementptr inbounds %struct.stType, %struct.stType* %297, i32 0, i32 0
  store %struct.COORD* %294, %struct.COORD** %298, align 8
  %299 = call noalias i8* @malloc(i64 4) #6
  %300 = bitcast i8* %299 to i32*
  %301 = load %struct.stType**, %struct.stType*** %6, align 8
  %302 = getelementptr inbounds %struct.stType*, %struct.stType** %301, i64 2
  %303 = load %struct.stType*, %struct.stType** %302, align 8
  %304 = getelementptr inbounds %struct.stType, %struct.stType* %303, i32 0, i32 0
  %305 = load %struct.COORD*, %struct.COORD** %304, align 8
  %306 = getelementptr inbounds %struct.COORD, %struct.COORD* %305, i32 0, i32 0
  store i32* %300, i32** %306, align 8
  %307 = call noalias i8* @malloc(i64 4) #6
  %308 = bitcast i8* %307 to i32*
  %309 = load %struct.stType**, %struct.stType*** %6, align 8
  %310 = getelementptr inbounds %struct.stType*, %struct.stType** %309, i64 2
  %311 = load %struct.stType*, %struct.stType** %310, align 8
  %312 = getelementptr inbounds %struct.stType, %struct.stType* %311, i32 0, i32 0
  %313 = load %struct.COORD*, %struct.COORD** %312, align 8
  %314 = getelementptr inbounds %struct.COORD, %struct.COORD* %313, i32 0, i32 1
  store i32* %308, i32** %314, align 8
  %315 = load %struct.stType**, %struct.stType*** %6, align 8
  %316 = getelementptr inbounds %struct.stType*, %struct.stType** %315, i64 2
  %317 = load %struct.stType*, %struct.stType** %316, align 8
  %318 = getelementptr inbounds %struct.stType, %struct.stType* %317, i32 0, i32 0
  %319 = load %struct.COORD*, %struct.COORD** %318, align 8
  %320 = getelementptr inbounds %struct.COORD, %struct.COORD* %319, i32 0, i32 0
  %321 = load i32*, i32** %320, align 8
  %322 = getelementptr inbounds i32, i32* %321, i64 0
  store i32 11, i32* %322, align 4
  %323 = load %struct.stType**, %struct.stType*** %6, align 8
  %324 = getelementptr inbounds %struct.stType*, %struct.stType** %323, i64 2
  %325 = load %struct.stType*, %struct.stType** %324, align 8
  %326 = getelementptr inbounds %struct.stType, %struct.stType* %325, i32 0, i32 0
  %327 = load %struct.COORD*, %struct.COORD** %326, align 8
  %328 = getelementptr inbounds %struct.COORD, %struct.COORD* %327, i32 0, i32 1
  %329 = load i32*, i32** %328, align 8
  %330 = getelementptr inbounds i32, i32* %329, i64 0
  store i32 12, i32* %330, align 4
  %331 = load %struct.stType**, %struct.stType*** %6, align 8
  %332 = getelementptr inbounds %struct.stType*, %struct.stType** %331, i64 2
  %333 = load %struct.stType*, %struct.stType** %332, align 8
  %334 = getelementptr inbounds %struct.stType, %struct.stType* %333, i32 0, i32 2
  %335 = getelementptr inbounds [8 x i32], [8 x i32]* %334, i64 0, i64 0
  store i32 13, i32* %335, align 4
  %336 = load %struct.stType**, %struct.stType*** %6, align 8
  %337 = getelementptr inbounds %struct.stType*, %struct.stType** %336, i64 2
  %338 = load %struct.stType*, %struct.stType** %337, align 8
  %339 = getelementptr inbounds %struct.stType, %struct.stType* %338, i32 0, i32 2
  %340 = getelementptr inbounds [8 x i32], [8 x i32]* %339, i64 0, i64 1
  store i32 14, i32* %340, align 4
  %341 = load %struct.stType**, %struct.stType*** %6, align 8
  %342 = getelementptr inbounds %struct.stType*, %struct.stType** %341, i64 2
  %343 = load %struct.stType*, %struct.stType** %342, align 8
  %344 = getelementptr inbounds %struct.stType, %struct.stType* %343, i32 0, i32 2
  %345 = getelementptr inbounds [8 x i32], [8 x i32]* %344, i64 0, i64 2
  store i32 15, i32* %345, align 4
  %346 = load %struct.stType**, %struct.stType*** %6, align 8
  %347 = getelementptr inbounds %struct.stType*, %struct.stType** %346, i64 2
  %348 = load %struct.stType*, %struct.stType** %347, align 8
  %349 = getelementptr inbounds %struct.stType, %struct.stType* %348, i32 0, i32 1
  %350 = getelementptr inbounds [100 x i8], [100 x i8]* %349, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %350, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %351 = load %struct.stType**, %struct.stType*** %6, align 8
  call void @branchPruned(%struct.stType** %351)
  %352 = load %struct.stType**, %struct.stType*** %6, align 8
  call void @branchNotPruned(%struct.stType** %352)
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
