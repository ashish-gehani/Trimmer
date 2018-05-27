; ModuleID = 'workdir/out14.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@.str = private constant [11 x i8] c"helloWorld\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@str.2 = private unnamed_addr constant [18 x i8] c"*** Branch Taken \00"
@str.3 = private unnamed_addr constant [22 x i8] c"*** Branch not Taken \00"

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType** nocapture readonly %obj) #0 {
  %1 = load %struct.stType*, %struct.stType** %obj, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 0
  %3 = load %struct.COORD*, %struct.COORD** %2, align 8
  %4 = getelementptr inbounds %struct.COORD, %struct.COORD* %3, i64 0, i32 0
  %5 = load i32*, i32** %4, align 8
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 1
  br i1 %7, label %8, label %70

; <label>:8                                       ; preds = %0
  %9 = getelementptr inbounds %struct.COORD, %struct.COORD* %3, i64 0, i32 1
  %10 = load i32*, i32** %9, align 8
  %11 = load i32, i32* %10, align 4
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %70

; <label>:13                                      ; preds = %8
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 1, i64 0
  %15 = tail call i32 @strcmp(i8* %14, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %70

; <label>:17                                      ; preds = %13
  %18 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 1, i64 4
  %19 = load i8, i8* %18, align 4
  %20 = icmp eq i8 %19, 111
  br i1 %20, label %21, label %70

; <label>:21                                      ; preds = %17
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 1, i64 9
  %23 = load i8, i8* %22, align 1
  %24 = icmp eq i8 %23, 100
  br i1 %24, label %25, label %70

; <label>:25                                      ; preds = %21
  %26 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %27 = load %struct.stType*, %struct.stType** %26, align 8
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i64 0, i32 0
  %29 = load %struct.COORD*, %struct.COORD** %28, align 8
  %30 = getelementptr inbounds %struct.COORD, %struct.COORD* %29, i64 0, i32 0
  %31 = load i32*, i32** %30, align 8
  %32 = load i32, i32* %31, align 4
  %33 = icmp eq i32 %32, 11
  br i1 %33, label %34, label %70

; <label>:34                                      ; preds = %25
  %35 = getelementptr inbounds %struct.COORD, %struct.COORD* %29, i64 0, i32 1
  %36 = load i32*, i32** %35, align 8
  %37 = load i32, i32* %36, align 4
  %38 = icmp eq i32 %37, 12
  br i1 %38, label %39, label %70

; <label>:39                                      ; preds = %34
  %40 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %41 = load %struct.stType*, %struct.stType** %40, align 8
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %41, i64 0, i32 0
  %43 = load %struct.COORD*, %struct.COORD** %42, align 8
  %44 = getelementptr inbounds %struct.COORD, %struct.COORD* %43, i64 0, i32 0
  %45 = load i32*, i32** %44, align 8
  %46 = load i32, i32* %45, align 4
  %47 = icmp eq i32 %46, 16
  br i1 %47, label %48, label %70

; <label>:48                                      ; preds = %39
  %49 = getelementptr inbounds %struct.COORD, %struct.COORD* %43, i64 0, i32 1
  %50 = load i32*, i32** %49, align 8
  %51 = load i32, i32* %50, align 4
  %52 = icmp eq i32 %51, 17
  br i1 %52, label %53, label %70

; <label>:53                                      ; preds = %48
  %54 = getelementptr inbounds %struct.stType, %struct.stType* %27, i64 0, i32 2, i64 1
  %55 = load i32, i32* %54, align 4
  %56 = icmp eq i32 %55, 14
  br i1 %56, label %57, label %70

; <label>:57                                      ; preds = %53
  %58 = getelementptr inbounds %struct.stType, %struct.stType* %27, i64 0, i32 1, i64 0
  %59 = tail call i32 @strcmp(i8* %58, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %60 = icmp eq i32 %59, 0
  br i1 %60, label %61, label %70

; <label>:61                                      ; preds = %57
  %62 = getelementptr inbounds %struct.stType, %struct.stType* %27, i64 0, i32 1, i64 4
  %63 = load i8, i8* %62, align 4
  %64 = icmp eq i8 %63, 111
  br i1 %64, label %65, label %70

; <label>:65                                      ; preds = %61
  %66 = getelementptr inbounds %struct.stType, %struct.stType* %27, i64 0, i32 1, i64 9
  %67 = load i8, i8* %66, align 1
  %68 = icmp eq i8 %67, 100
  br i1 %68, label %69, label %70

; <label>:69                                      ; preds = %65
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0))
  br label %70

; <label>:70                                      ; preds = %57, %13, %69, %65, %61, %53, %48, %39, %34, %25, %21, %17, %8, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define void @branchNotPruned(%struct.stType** nocapture readonly %obj) #0 {
  %1 = load %struct.stType*, %struct.stType** %obj, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 2, i64 1
  %3 = load i32, i32* %2, align 4
  %4 = icmp eq i32 %3, 4
  br i1 %4, label %23, label %5

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %7 = load %struct.stType*, %struct.stType** %6, align 8
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 2, i64 1
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 19
  br i1 %10, label %23, label %11

; <label>:11                                      ; preds = %5
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 0
  %13 = tail call i32 @strcmp(i8* %12, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %23, label %15

; <label>:15                                      ; preds = %11
  %16 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 4
  %17 = load i8, i8* %16, align 4
  %18 = icmp eq i8 %17, 111
  br i1 %18, label %23, label %19

; <label>:19                                      ; preds = %15
  %20 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 9
  %21 = load i8, i8* %20, align 1
  %22 = icmp eq i8 %21, 100
  br i1 %22, label %23, label %24

; <label>:23                                      ; preds = %11, %19, %15, %5, %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @str.3, i64 0, i64 0))
  br label %24

; <label>:24                                      ; preds = %23, %19
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = tail call noalias i8* @malloc(i64 160) #4
  %2 = bitcast i8* %1 to %struct.stType**
  %3 = tail call noalias i8* @malloc(i64 144) #4
  %4 = bitcast i8* %1 to i8**
  store i8* %3, i8** %4, align 8
  %5 = tail call noalias i8* @malloc(i64 16) #4
  %.cast = bitcast i8* %3 to i8**
  store i8* %5, i8** %.cast, align 8
  %6 = tail call noalias i8* @malloc(i64 4) #4
  %7 = bitcast i8* %5 to i8**
  store i8* %6, i8** %7, align 8
  %8 = tail call noalias i8* @malloc(i64 4) #4
  %9 = getelementptr inbounds i8, i8* %5, i64 8
  %10 = bitcast i8* %9 to i8**
  store i8* %8, i8** %10, align 8
  %11 = tail call noalias i8* @malloc(i64 144) #4
  %12 = getelementptr inbounds i8, i8* %1, i64 24
  %13 = bitcast i8* %12 to %struct.stType**
  %14 = bitcast i8* %12 to i8**
  store i8* %11, i8** %14, align 8
  %15 = tail call noalias i8* @malloc(i64 16) #4
  %.cast3 = bitcast i8* %11 to i8**
  store i8* %15, i8** %.cast3, align 8
  %16 = tail call noalias i8* @malloc(i64 4) #4
  %17 = bitcast i8* %15 to i8**
  store i8* %16, i8** %17, align 8
  %18 = tail call noalias i8* @malloc(i64 4) #4
  %19 = getelementptr inbounds i8, i8* %15, i64 8
  %20 = bitcast i8* %19 to i8**
  store i8* %18, i8** %20, align 8
  %21 = tail call noalias i8* @malloc(i64 144) #4
  %22 = getelementptr inbounds i8, i8* %1, i64 8
  %23 = bitcast i8* %22 to %struct.stType**
  %24 = bitcast i8* %22 to i8**
  store i8* %21, i8** %24, align 8
  %25 = tail call noalias i8* @malloc(i64 16) #4
  %.cast5 = bitcast i8* %21 to i8**
  store i8* %25, i8** %.cast5, align 8
  %26 = tail call noalias i8* @malloc(i64 4) #4
  %27 = bitcast i8* %25 to i8**
  store i8* %26, i8** %27, align 8
  %28 = tail call noalias i8* @malloc(i64 4) #4
  %29 = getelementptr inbounds i8, i8* %25, i64 8
  %30 = bitcast i8* %29 to i8**
  store i8* %28, i8** %30, align 8
  %31 = icmp sgt i32 %argc, 2
  %32 = bitcast i8* %6 to i32*
  store i32 1, i32* %32, align 4
  %33 = bitcast i8* %8 to i32*
  store i32 2, i32* %33, align 4
  br i1 %31, label %34, label %53

; <label>:34                                      ; preds = %0
  %35 = getelementptr inbounds i8, i8* %3, i64 108
  %36 = bitcast i8* %35 to i32*
  store i32 3, i32* %36, align 4
  %37 = getelementptr inbounds i8, i8* %3, i64 112
  %38 = bitcast i8* %37 to i32*
  store i32 4, i32* %38, align 4
  %39 = getelementptr inbounds i8, i8* %3, i64 116
  %40 = bitcast i8* %39 to i32*
  store i32 5, i32* %40, align 4
  %41 = load %struct.stType*, %struct.stType** %13, align 8
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %41, i64 0, i32 0
  %43 = load %struct.COORD*, %struct.COORD** %42, align 8
  %44 = getelementptr inbounds %struct.COORD, %struct.COORD* %43, i64 0, i32 0
  %45 = load i32*, i32** %44, align 8
  store i32 16, i32* %45, align 4
  %46 = load %struct.COORD*, %struct.COORD** %42, align 8
  %47 = getelementptr inbounds %struct.COORD, %struct.COORD* %46, i64 0, i32 1
  %48 = load i32*, i32** %47, align 8
  store i32 17, i32* %48, align 4
  %49 = getelementptr inbounds %struct.stType, %struct.stType* %41, i64 0, i32 2, i64 0
  store i32 18, i32* %49, align 4
  %50 = getelementptr inbounds %struct.stType, %struct.stType* %41, i64 0, i32 2, i64 1
  store i32 19, i32* %50, align 4
  %51 = getelementptr inbounds %struct.stType, %struct.stType* %41, i64 0, i32 2, i64 2
  store i32 20, i32* %51, align 4
  %52 = getelementptr inbounds %struct.stType, %struct.stType* %41, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %52, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %.pre9 = load %struct.stType*, %struct.stType** %23, align 8
  br label %69

; <label>:53                                      ; preds = %0
  %54 = bitcast i8* %21 to %struct.COORD**
  %55 = load %struct.COORD*, %struct.COORD** %54, align 8
  %56 = getelementptr inbounds %struct.COORD, %struct.COORD* %55, i64 0, i32 0
  %57 = load i32*, i32** %56, align 8
  store i32 6, i32* %57, align 4
  %58 = load %struct.COORD*, %struct.COORD** %54, align 8
  %59 = getelementptr inbounds %struct.COORD, %struct.COORD* %58, i64 0, i32 1
  %60 = load i32*, i32** %59, align 8
  store i32 7, i32* %60, align 4
  %61 = getelementptr inbounds i8, i8* %21, i64 108
  %62 = bitcast i8* %61 to i32*
  store i32 8, i32* %62, align 4
  %63 = getelementptr inbounds i8, i8* %21, i64 112
  %64 = bitcast i8* %63 to i32*
  store i32 9, i32* %64, align 4
  %65 = getelementptr inbounds i8, i8* %21, i64 116
  %66 = bitcast i8* %65 to i32*
  store i32 10, i32* %66, align 4
  %67 = load %struct.stType*, %struct.stType** %23, align 8
  %68 = getelementptr inbounds %struct.stType, %struct.stType* %67, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %68, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %.pre = load %struct.stType*, %struct.stType** %13, align 8
  br label %69

; <label>:69                                      ; preds = %53, %34
  %70 = phi %struct.stType* [ %67, %53 ], [ %.pre9, %34 ]
  %71 = phi %struct.stType* [ %.pre, %53 ], [ %41, %34 ]
  %72 = getelementptr inbounds %struct.stType, %struct.stType* %71, i64 0, i32 0
  %73 = load %struct.COORD*, %struct.COORD** %72, align 8
  %74 = getelementptr inbounds %struct.COORD, %struct.COORD* %73, i64 0, i32 0
  %75 = load i32*, i32** %74, align 8
  store i32 16, i32* %75, align 4
  %76 = load %struct.COORD*, %struct.COORD** %72, align 8
  %77 = getelementptr inbounds %struct.COORD, %struct.COORD* %76, i64 0, i32 1
  %78 = load i32*, i32** %77, align 8
  store i32 17, i32* %78, align 4
  %79 = load %struct.stType*, %struct.stType** %2, align 8
  %80 = getelementptr inbounds %struct.stType, %struct.stType* %79, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %80, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %81 = getelementptr inbounds %struct.stType, %struct.stType* %70, i64 0, i32 0
  %82 = load %struct.COORD*, %struct.COORD** %81, align 8
  %83 = getelementptr inbounds %struct.COORD, %struct.COORD* %82, i64 0, i32 0
  %84 = load i32*, i32** %83, align 8
  store i32 6, i32* %84, align 4
  %85 = load %struct.COORD*, %struct.COORD** %81, align 8
  %86 = getelementptr inbounds %struct.COORD, %struct.COORD* %85, i64 0, i32 1
  %87 = load i32*, i32** %86, align 8
  store i32 7, i32* %87, align 4
  %88 = getelementptr inbounds %struct.stType, %struct.stType* %70, i64 0, i32 2, i64 0
  store i32 8, i32* %88, align 4
  %89 = getelementptr inbounds %struct.stType, %struct.stType* %70, i64 0, i32 2, i64 1
  store i32 9, i32* %89, align 4
  %90 = getelementptr inbounds %struct.stType, %struct.stType* %70, i64 0, i32 2, i64 2
  store i32 10, i32* %90, align 4
  %91 = getelementptr inbounds %struct.stType, %struct.stType* %70, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %91, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %92 = tail call noalias i8* @malloc(i64 144) #4
  %93 = getelementptr inbounds i8, i8* %1, i64 16
  %94 = bitcast i8* %93 to i8**
  store i8* %92, i8** %94, align 8
  %95 = tail call noalias i8* @malloc(i64 16) #4
  %.cast7 = bitcast i8* %92 to i8**
  store i8* %95, i8** %.cast7, align 8
  %96 = tail call noalias i8* @malloc(i64 4) #4
  %97 = bitcast i8* %95 to i8**
  store i8* %96, i8** %97, align 8
  %98 = tail call noalias i8* @malloc(i64 4) #4
  %99 = getelementptr inbounds i8, i8* %95, i64 8
  %100 = bitcast i8* %99 to i8**
  store i8* %98, i8** %100, align 8
  %101 = bitcast i8* %96 to i32*
  store i32 11, i32* %101, align 4
  %102 = bitcast i8* %98 to i32*
  store i32 12, i32* %102, align 4
  %103 = getelementptr inbounds i8, i8* %92, i64 108
  %104 = bitcast i8* %103 to i32*
  store i32 13, i32* %104, align 4
  %105 = getelementptr inbounds i8, i8* %92, i64 112
  %106 = bitcast i8* %105 to i32*
  store i32 14, i32* %106, align 4
  %107 = getelementptr inbounds i8, i8* %92, i64 116
  %108 = bitcast i8* %107 to i32*
  store i32 15, i32* %108, align 4
  %109 = getelementptr inbounds i8, i8* %92, i64 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %109, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %puts.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0)) #4
  %110 = getelementptr inbounds %struct.stType, %struct.stType* %79, i64 0, i32 2, i64 1
  %111 = load i32, i32* %110, align 4
  %112 = icmp eq i32 %111, 4
  br i1 %112, label %129, label %113

; <label>:113                                     ; preds = %69
  %114 = getelementptr inbounds %struct.stType, %struct.stType* %71, i64 0, i32 2, i64 1
  %115 = load i32, i32* %114, align 4
  %116 = icmp eq i32 %115, 19
  br i1 %116, label %129, label %117

; <label>:117                                     ; preds = %113
  %118 = getelementptr inbounds %struct.stType, %struct.stType* %71, i64 0, i32 1, i64 0
  %119 = tail call i32 @strcmp(i8* %118, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %120 = icmp eq i32 %119, 0
  br i1 %120, label %129, label %121

; <label>:121                                     ; preds = %117
  %122 = getelementptr inbounds %struct.stType, %struct.stType* %71, i64 0, i32 1, i64 4
  %123 = load i8, i8* %122, align 4
  %124 = icmp eq i8 %123, 111
  br i1 %124, label %129, label %125

; <label>:125                                     ; preds = %121
  %126 = getelementptr inbounds %struct.stType, %struct.stType* %71, i64 0, i32 1, i64 9
  %127 = load i8, i8* %126, align 1
  %128 = icmp eq i8 %127, 100
  br i1 %128, label %129, label %branchNotPruned_clone.exit

; <label>:129                                     ; preds = %125, %121, %117, %113, %69
  %puts.i1 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @str.3, i64 0, i64 0)) #4
  br label %branchNotPruned_clone.exit

branchNotPruned_clone.exit:                       ; preds = %125, %129
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType** nocapture readnone %obj) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(%struct.stType** nocapture readonly %obj) #0 {
  %1 = load %struct.stType*, %struct.stType** %obj, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 2, i64 1
  %3 = load i32, i32* %2, align 4
  %4 = icmp eq i32 %3, 4
  br i1 %4, label %23, label %5

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %7 = load %struct.stType*, %struct.stType** %6, align 8
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 2, i64 1
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 19
  br i1 %10, label %23, label %11

; <label>:11                                      ; preds = %5
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 0
  %13 = tail call i32 @strcmp(i8* %12, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %23, label %15

; <label>:15                                      ; preds = %11
  %16 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 4
  %17 = load i8, i8* %16, align 4
  %18 = icmp eq i8 %17, 111
  br i1 %18, label %23, label %19

; <label>:19                                      ; preds = %15
  %20 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 9
  %21 = load i8, i8* %20, align 1
  %22 = icmp eq i8 %21, 100
  br i1 %22, label %23, label %24

; <label>:23                                      ; preds = %11, %19, %15, %5, %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @str.3, i64 0, i64 0))
  br label %24

; <label>:24                                      ; preds = %23, %19
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
