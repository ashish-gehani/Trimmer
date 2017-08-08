; ModuleID = 'workdir/out14.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@str.4 = private unnamed_addr constant [18 x i8] c"*** Branch Taken \00"
@str.5 = private unnamed_addr constant [22 x i8] c"*** Branch not Taken \00"

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType** nocapture readonly %obj) #0 {
  %1 = load %struct.stType*, %struct.stType** %obj, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 0
  %3 = load %struct.COORD*, %struct.COORD** %2, align 8
  %4 = getelementptr inbounds %struct.COORD, %struct.COORD* %3, i64 0, i32 0
  %5 = load i32*, i32** %4, align 8
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 1
  br i1 %7, label %8, label %56

; <label>:8                                       ; preds = %0
  %9 = getelementptr inbounds %struct.COORD, %struct.COORD* %3, i64 0, i32 1
  %10 = load i32*, i32** %9, align 8
  %11 = load i32, i32* %10, align 4
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %56

; <label>:13                                      ; preds = %8
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 1, i64 0
  %15 = tail call i32 @strcmp(i8* %14, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %56

; <label>:17                                      ; preds = %13
  %18 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 1, i64 4
  %19 = load i8, i8* %18, align 4
  %20 = icmp eq i8 %19, 111
  br i1 %20, label %21, label %56

; <label>:21                                      ; preds = %17
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 1, i64 9
  %23 = load i8, i8* %22, align 1
  %24 = icmp eq i8 %23, 100
  br i1 %24, label %25, label %56

; <label>:25                                      ; preds = %21
  %26 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %27 = load %struct.stType*, %struct.stType** %26, align 8
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i64 0, i32 0
  %29 = load %struct.COORD*, %struct.COORD** %28, align 8
  %30 = getelementptr inbounds %struct.COORD, %struct.COORD* %29, i64 0, i32 0
  %31 = load i32*, i32** %30, align 8
  %32 = load i32, i32* %31, align 4
  %33 = icmp eq i32 %32, 11
  br i1 %33, label %34, label %56

; <label>:34                                      ; preds = %25
  %35 = getelementptr inbounds %struct.COORD, %struct.COORD* %29, i64 0, i32 1
  %36 = load i32*, i32** %35, align 8
  %37 = load i32, i32* %36, align 4
  %38 = icmp eq i32 %37, 12
  br i1 %38, label %39, label %56

; <label>:39                                      ; preds = %34
  %40 = getelementptr inbounds %struct.stType, %struct.stType* %27, i64 0, i32 2, i64 1
  %41 = load i32, i32* %40, align 4
  %42 = icmp eq i32 %41, 14
  br i1 %42, label %43, label %56

; <label>:43                                      ; preds = %39
  %44 = getelementptr inbounds %struct.stType, %struct.stType* %27, i64 0, i32 1, i64 0
  %45 = tail call i32 @strcmp(i8* %44, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %46 = icmp eq i32 %45, 0
  br i1 %46, label %47, label %56

; <label>:47                                      ; preds = %43
  %48 = getelementptr inbounds %struct.stType, %struct.stType* %27, i64 0, i32 1, i64 4
  %49 = load i8, i8* %48, align 4
  %50 = icmp eq i8 %49, 111
  br i1 %50, label %51, label %56

; <label>:51                                      ; preds = %47
  %52 = getelementptr inbounds %struct.stType, %struct.stType* %27, i64 0, i32 1, i64 9
  %53 = load i8, i8* %52, align 1
  %54 = icmp eq i8 %53, 100
  br i1 %54, label %55, label %56

; <label>:55                                      ; preds = %51
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.4, i64 0, i64 0))
  br label %56

; <label>:56                                      ; preds = %43, %13, %55, %51, %47, %39, %34, %25, %21, %17, %8, %0
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
  br i1 %4, label %5, label %36

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %7 = load %struct.stType*, %struct.stType** %6, align 8
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 0
  %9 = load %struct.COORD*, %struct.COORD** %8, align 8
  %10 = getelementptr inbounds %struct.COORD, %struct.COORD* %9, i64 0, i32 0
  %11 = load i32*, i32** %10, align 8
  %12 = load i32, i32* %11, align 4
  %13 = icmp eq i32 %12, 16
  br i1 %13, label %14, label %36

; <label>:14                                      ; preds = %5
  %15 = getelementptr inbounds %struct.COORD, %struct.COORD* %9, i64 0, i32 1
  %16 = load i32*, i32** %15, align 8
  %17 = load i32, i32* %16, align 4
  %18 = icmp eq i32 %17, 17
  br i1 %18, label %19, label %36

; <label>:19                                      ; preds = %14
  %20 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 2, i64 1
  %21 = load i32, i32* %20, align 4
  %22 = icmp eq i32 %21, 19
  br i1 %22, label %23, label %36

; <label>:23                                      ; preds = %19
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 0
  %25 = tail call i32 @strcmp(i8* %24, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %27, label %36

; <label>:27                                      ; preds = %23
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 4
  %29 = load i8, i8* %28, align 4
  %30 = icmp eq i8 %29, 111
  br i1 %30, label %31, label %36

; <label>:31                                      ; preds = %27
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 9
  %33 = load i8, i8* %32, align 1
  %34 = icmp eq i8 %33, 100
  br i1 %34, label %35, label %36

; <label>:35                                      ; preds = %31
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @str.5, i64 0, i64 0))
  br label %36

; <label>:36                                      ; preds = %23, %35, %31, %27, %19, %14, %5, %0
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
  %.pre = load %struct.stType*, %struct.stType** %23, align 8
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
  br label %69

; <label>:69                                      ; preds = %53, %34
  %70 = phi %struct.stType* [ %67, %53 ], [ %.pre, %34 ]
  %71 = load %struct.stType*, %struct.stType** %2, align 8
  %72 = getelementptr inbounds %struct.stType, %struct.stType* %71, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %72, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %73 = getelementptr inbounds %struct.stType, %struct.stType* %70, i64 0, i32 0
  %74 = load %struct.COORD*, %struct.COORD** %73, align 8
  %75 = getelementptr inbounds %struct.COORD, %struct.COORD* %74, i64 0, i32 0
  %76 = load i32*, i32** %75, align 8
  store i32 6, i32* %76, align 4
  %77 = load %struct.COORD*, %struct.COORD** %73, align 8
  %78 = getelementptr inbounds %struct.COORD, %struct.COORD* %77, i64 0, i32 1
  %79 = load i32*, i32** %78, align 8
  store i32 7, i32* %79, align 4
  %80 = getelementptr inbounds %struct.stType, %struct.stType* %70, i64 0, i32 2, i64 0
  store i32 8, i32* %80, align 4
  %81 = getelementptr inbounds %struct.stType, %struct.stType* %70, i64 0, i32 2, i64 1
  store i32 9, i32* %81, align 4
  %82 = getelementptr inbounds %struct.stType, %struct.stType* %70, i64 0, i32 2, i64 2
  store i32 10, i32* %82, align 4
  %83 = getelementptr inbounds %struct.stType, %struct.stType* %70, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %83, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %84 = tail call noalias i8* @malloc(i64 144) #4
  %85 = getelementptr inbounds i8, i8* %1, i64 16
  %86 = bitcast i8* %85 to i8**
  store i8* %84, i8** %86, align 8
  %87 = tail call noalias i8* @malloc(i64 16) #4
  %.cast7 = bitcast i8* %84 to i8**
  store i8* %87, i8** %.cast7, align 8
  %88 = tail call noalias i8* @malloc(i64 4) #4
  %89 = bitcast i8* %87 to i8**
  store i8* %88, i8** %89, align 8
  %90 = tail call noalias i8* @malloc(i64 4) #4
  %91 = getelementptr inbounds i8, i8* %87, i64 8
  %92 = bitcast i8* %91 to i8**
  store i8* %90, i8** %92, align 8
  %93 = bitcast i8* %88 to i32*
  store i32 11, i32* %93, align 4
  %94 = bitcast i8* %90 to i32*
  store i32 12, i32* %94, align 4
  %95 = getelementptr inbounds i8, i8* %84, i64 108
  %96 = bitcast i8* %95 to i32*
  store i32 13, i32* %96, align 4
  %97 = getelementptr inbounds i8, i8* %84, i64 112
  %98 = bitcast i8* %97 to i32*
  store i32 14, i32* %98, align 4
  %99 = getelementptr inbounds i8, i8* %84, i64 116
  %100 = bitcast i8* %99 to i32*
  store i32 15, i32* %100, align 4
  %101 = getelementptr inbounds i8, i8* %84, i64 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %101, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %puts.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.4, i64 0, i64 0)) #4
  %102 = getelementptr inbounds %struct.stType, %struct.stType* %71, i64 0, i32 2, i64 1
  %103 = load i32, i32* %102, align 4
  %104 = icmp eq i32 %103, 4
  br i1 %104, label %105, label %branchNotPruned.exit

; <label>:105                                     ; preds = %69
  %106 = load %struct.stType*, %struct.stType** %13, align 8
  %107 = getelementptr inbounds %struct.stType, %struct.stType* %106, i64 0, i32 0
  %108 = load %struct.COORD*, %struct.COORD** %107, align 8
  %109 = getelementptr inbounds %struct.COORD, %struct.COORD* %108, i64 0, i32 0
  %110 = load i32*, i32** %109, align 8
  %111 = load i32, i32* %110, align 4
  %112 = icmp eq i32 %111, 16
  br i1 %112, label %113, label %branchNotPruned.exit

; <label>:113                                     ; preds = %105
  %114 = getelementptr inbounds %struct.COORD, %struct.COORD* %108, i64 0, i32 1
  %115 = load i32*, i32** %114, align 8
  %116 = load i32, i32* %115, align 4
  %117 = icmp eq i32 %116, 17
  br i1 %117, label %118, label %branchNotPruned.exit

; <label>:118                                     ; preds = %113
  %119 = getelementptr inbounds %struct.stType, %struct.stType* %106, i64 0, i32 2, i64 1
  %120 = load i32, i32* %119, align 4
  %121 = icmp eq i32 %120, 19
  br i1 %121, label %122, label %branchNotPruned.exit

; <label>:122                                     ; preds = %118
  %123 = getelementptr inbounds %struct.stType, %struct.stType* %106, i64 0, i32 1, i64 0
  %124 = tail call i32 @strcmp(i8* %123, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %125 = icmp eq i32 %124, 0
  br i1 %125, label %126, label %branchNotPruned.exit

; <label>:126                                     ; preds = %122
  %127 = getelementptr inbounds %struct.stType, %struct.stType* %106, i64 0, i32 1, i64 4
  %128 = load i8, i8* %127, align 4
  %129 = icmp eq i8 %128, 111
  br i1 %129, label %130, label %branchNotPruned.exit

; <label>:130                                     ; preds = %126
  %131 = getelementptr inbounds %struct.stType, %struct.stType* %106, i64 0, i32 1, i64 9
  %132 = load i8, i8* %131, align 1
  %133 = icmp eq i8 %132, 100
  br i1 %133, label %134, label %branchNotPruned.exit

; <label>:134                                     ; preds = %130
  %puts.i1 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @str.5, i64 0, i64 0)) #4
  br label %branchNotPruned.exit

branchNotPruned.exit:                             ; preds = %69, %105, %113, %118, %122, %126, %130, %134
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType** nocapture readnone %obj) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.4, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(%struct.stType** nocapture readonly %obj) #0 {
  %1 = load %struct.stType*, %struct.stType** %obj, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 2, i64 1
  %3 = load i32, i32* %2, align 4
  %4 = icmp eq i32 %3, 4
  br i1 %4, label %5, label %36

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %7 = load %struct.stType*, %struct.stType** %6, align 8
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 0
  %9 = load %struct.COORD*, %struct.COORD** %8, align 8
  %10 = getelementptr inbounds %struct.COORD, %struct.COORD* %9, i64 0, i32 0
  %11 = load i32*, i32** %10, align 8
  %12 = load i32, i32* %11, align 4
  %13 = icmp eq i32 %12, 16
  br i1 %13, label %14, label %36

; <label>:14                                      ; preds = %5
  %15 = getelementptr inbounds %struct.COORD, %struct.COORD* %9, i64 0, i32 1
  %16 = load i32*, i32** %15, align 8
  %17 = load i32, i32* %16, align 4
  %18 = icmp eq i32 %17, 17
  br i1 %18, label %19, label %36

; <label>:19                                      ; preds = %14
  %20 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 2, i64 1
  %21 = load i32, i32* %20, align 4
  %22 = icmp eq i32 %21, 19
  br i1 %22, label %23, label %36

; <label>:23                                      ; preds = %19
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 0
  %25 = tail call i32 @strcmp(i8* %24, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %27, label %36

; <label>:27                                      ; preds = %23
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 4
  %29 = load i8, i8* %28, align 4
  %30 = icmp eq i8 %29, 111
  br i1 %30, label %31, label %36

; <label>:31                                      ; preds = %27
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 9
  %33 = load i8, i8* %32, align 1
  %34 = icmp eq i8 %33, 100
  br i1 %34, label %35, label %36

; <label>:35                                      ; preds = %31
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @str.5, i64 0, i64 0))
  br label %36

; <label>:36                                      ; preds = %23, %35, %31, %27, %19, %14, %5, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone_clone(%struct.stType** nocapture readnone %obj) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.4, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone.1(%struct.stType** nocapture readonly %obj) #0 {
  %1 = load %struct.stType*, %struct.stType** %obj, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 2, i64 1
  %3 = load i32, i32* %2, align 4
  %4 = icmp eq i32 %3, 4
  br i1 %4, label %5, label %36

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %7 = load %struct.stType*, %struct.stType** %6, align 8
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 0
  %9 = load %struct.COORD*, %struct.COORD** %8, align 8
  %10 = getelementptr inbounds %struct.COORD, %struct.COORD* %9, i64 0, i32 0
  %11 = load i32*, i32** %10, align 8
  %12 = load i32, i32* %11, align 4
  %13 = icmp eq i32 %12, 16
  br i1 %13, label %14, label %36

; <label>:14                                      ; preds = %5
  %15 = getelementptr inbounds %struct.COORD, %struct.COORD* %9, i64 0, i32 1
  %16 = load i32*, i32** %15, align 8
  %17 = load i32, i32* %16, align 4
  %18 = icmp eq i32 %17, 17
  br i1 %18, label %19, label %36

; <label>:19                                      ; preds = %14
  %20 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 2, i64 1
  %21 = load i32, i32* %20, align 4
  %22 = icmp eq i32 %21, 19
  br i1 %22, label %23, label %36

; <label>:23                                      ; preds = %19
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 0
  %25 = tail call i32 @strcmp(i8* %24, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %27, label %36

; <label>:27                                      ; preds = %23
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 4
  %29 = load i8, i8* %28, align 4
  %30 = icmp eq i8 %29, 111
  br i1 %30, label %31, label %36

; <label>:31                                      ; preds = %27
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %7, i64 0, i32 1, i64 9
  %33 = load i8, i8* %32, align 1
  %34 = icmp eq i8 %33, 100
  br i1 %34, label %35, label %36

; <label>:35                                      ; preds = %31
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @str.5, i64 0, i64 0))
  br label %36

; <label>:36                                      ; preds = %23, %35, %31, %27, %19, %14, %5, %0
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
