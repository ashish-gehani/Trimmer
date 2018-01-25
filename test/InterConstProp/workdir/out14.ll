; ModuleID = 'workdir/out14.bc'
source_filename = "inter14.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@.str = private constant [11 x i8] c"helloWorld\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@str.2 = private unnamed_addr constant [18 x i8] c"*** Branch Taken \00"
@str.3 = private unnamed_addr constant [22 x i8] c"*** Branch not Taken \00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType** nocapture readonly) local_unnamed_addr #0 {
  %2 = load %struct.stType*, %struct.stType** %0, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 0
  %4 = load %struct.COORD*, %struct.COORD** %3, align 8
  %5 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i64 0, i32 0
  %6 = load i32*, i32** %5, align 8
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 %7, 1
  br i1 %8, label %9, label %71

; <label>:9:                                      ; preds = %1
  %10 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i64 0, i32 1
  %11 = load i32*, i32** %10, align 8
  %12 = load i32, i32* %11, align 4
  %13 = icmp eq i32 %12, 2
  br i1 %13, label %14, label %71

; <label>:14:                                     ; preds = %9
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 1, i64 0
  %16 = tail call i32 @strcmp(i8* %15, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %71

; <label>:18:                                     ; preds = %14
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 1, i64 4
  %20 = load i8, i8* %19, align 4
  %21 = icmp eq i8 %20, 111
  br i1 %21, label %22, label %71

; <label>:22:                                     ; preds = %18
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 1, i64 9
  %24 = load i8, i8* %23, align 1
  %25 = icmp eq i8 %24, 100
  br i1 %25, label %26, label %71

; <label>:26:                                     ; preds = %22
  %27 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %28 = load %struct.stType*, %struct.stType** %27, align 8
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 0
  %30 = load %struct.COORD*, %struct.COORD** %29, align 8
  %31 = getelementptr inbounds %struct.COORD, %struct.COORD* %30, i64 0, i32 0
  %32 = load i32*, i32** %31, align 8
  %33 = load i32, i32* %32, align 4
  %34 = icmp eq i32 %33, 11
  br i1 %34, label %35, label %71

; <label>:35:                                     ; preds = %26
  %36 = getelementptr inbounds %struct.COORD, %struct.COORD* %30, i64 0, i32 1
  %37 = load i32*, i32** %36, align 8
  %38 = load i32, i32* %37, align 4
  %39 = icmp eq i32 %38, 12
  br i1 %39, label %40, label %71

; <label>:40:                                     ; preds = %35
  %41 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %42 = load %struct.stType*, %struct.stType** %41, align 8
  %43 = getelementptr inbounds %struct.stType, %struct.stType* %42, i64 0, i32 0
  %44 = load %struct.COORD*, %struct.COORD** %43, align 8
  %45 = getelementptr inbounds %struct.COORD, %struct.COORD* %44, i64 0, i32 0
  %46 = load i32*, i32** %45, align 8
  %47 = load i32, i32* %46, align 4
  %48 = icmp eq i32 %47, 16
  br i1 %48, label %49, label %71

; <label>:49:                                     ; preds = %40
  %50 = getelementptr inbounds %struct.COORD, %struct.COORD* %44, i64 0, i32 1
  %51 = load i32*, i32** %50, align 8
  %52 = load i32, i32* %51, align 4
  %53 = icmp eq i32 %52, 17
  br i1 %53, label %54, label %71

; <label>:54:                                     ; preds = %49
  %55 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 2, i64 1
  %56 = load i32, i32* %55, align 4
  %57 = icmp eq i32 %56, 14
  br i1 %57, label %58, label %71

; <label>:58:                                     ; preds = %54
  %59 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 1, i64 0
  %60 = tail call i32 @strcmp(i8* %59, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %61 = icmp eq i32 %60, 0
  br i1 %61, label %62, label %71

; <label>:62:                                     ; preds = %58
  %63 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 1, i64 4
  %64 = load i8, i8* %63, align 4
  %65 = icmp eq i8 %64, 111
  br i1 %65, label %66, label %71

; <label>:66:                                     ; preds = %62
  %67 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 1, i64 9
  %68 = load i8, i8* %67, align 1
  %69 = icmp eq i8 %68, 100
  br i1 %69, label %70, label %71

; <label>:70:                                     ; preds = %66
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0))
  br label %71

; <label>:71:                                     ; preds = %58, %14, %70, %66, %62, %54, %49, %40, %35, %26, %22, %18, %9, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #1

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned(%struct.stType** nocapture readonly) local_unnamed_addr #0 {
  %2 = load %struct.stType*, %struct.stType** %0, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 2, i64 1
  %4 = load i32, i32* %3, align 4
  %5 = icmp eq i32 %4, 4
  br i1 %5, label %24, label %6

; <label>:6:                                      ; preds = %1
  %7 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %8 = load %struct.stType*, %struct.stType** %7, align 8
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 2, i64 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp eq i32 %10, 19
  br i1 %11, label %24, label %12

; <label>:12:                                     ; preds = %6
  %13 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 0
  %14 = tail call i32 @strcmp(i8* %13, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %24, label %16

; <label>:16:                                     ; preds = %12
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 4
  %18 = load i8, i8* %17, align 4
  %19 = icmp eq i8 %18, 111
  br i1 %19, label %24, label %20

; <label>:20:                                     ; preds = %16
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 9
  %22 = load i8, i8* %21, align 1
  %23 = icmp eq i8 %22, 100
  br i1 %23, label %24, label %25

; <label>:24:                                     ; preds = %12, %20, %16, %6, %1
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @str.3, i64 0, i64 0))
  br label %25

; <label>:25:                                     ; preds = %24, %20
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8** nocapture readnone) local_unnamed_addr #0 {
  %3 = tail call noalias i8* @malloc(i64 160) #4
  %4 = bitcast i8* %3 to %struct.stType**
  %5 = tail call noalias i8* @malloc(i64 144) #4
  %6 = bitcast i8* %3 to i8**
  store i8* %5, i8** %6, align 8
  %7 = tail call noalias i8* @malloc(i64 16) #4
  %8 = bitcast i8* %5 to i8**
  store i8* %7, i8** %8, align 8
  %9 = tail call noalias i8* @malloc(i64 4) #4
  %10 = bitcast i8* %7 to i8**
  store i8* %9, i8** %10, align 8
  %11 = tail call noalias i8* @malloc(i64 4) #4
  %12 = bitcast i8* %5 to %struct.COORD**
  %13 = getelementptr inbounds i8, i8* %7, i64 8
  %14 = bitcast i8* %13 to i8**
  store i8* %11, i8** %14, align 8
  %15 = tail call noalias i8* @malloc(i64 144) #4
  %16 = getelementptr inbounds i8, i8* %3, i64 24
  %17 = bitcast i8* %16 to %struct.stType**
  %18 = bitcast i8* %16 to i8**
  store i8* %15, i8** %18, align 8
  %19 = tail call noalias i8* @malloc(i64 16) #4
  %20 = bitcast i8* %15 to i8**
  store i8* %19, i8** %20, align 8
  %21 = tail call noalias i8* @malloc(i64 4) #4
  %22 = bitcast i8* %19 to i8**
  store i8* %21, i8** %22, align 8
  %23 = tail call noalias i8* @malloc(i64 4) #4
  %24 = getelementptr inbounds i8, i8* %19, i64 8
  %25 = bitcast i8* %24 to i8**
  store i8* %23, i8** %25, align 8
  %26 = tail call noalias i8* @malloc(i64 144) #4
  %27 = getelementptr inbounds i8, i8* %3, i64 8
  %28 = bitcast i8* %27 to %struct.stType**
  %29 = bitcast i8* %27 to i8**
  store i8* %26, i8** %29, align 8
  %30 = tail call noalias i8* @malloc(i64 16) #4
  %31 = bitcast i8* %26 to i8**
  store i8* %30, i8** %31, align 8
  %32 = tail call noalias i8* @malloc(i64 4) #4
  %33 = bitcast i8* %30 to i8**
  store i8* %32, i8** %33, align 8
  %34 = tail call noalias i8* @malloc(i64 4) #4
  %35 = bitcast i8* %26 to %struct.COORD**
  %36 = getelementptr inbounds i8, i8* %30, i64 8
  %37 = bitcast i8* %36 to i8**
  store i8* %34, i8** %37, align 8
  %38 = icmp sgt i32 %0, 2
  %39 = load %struct.COORD*, %struct.COORD** %12, align 8
  %40 = getelementptr inbounds %struct.COORD, %struct.COORD* %39, i64 0, i32 0
  %41 = load i32*, i32** %40, align 8
  store i32 1, i32* %41, align 4
  %42 = load %struct.COORD*, %struct.COORD** %12, align 8
  %43 = getelementptr inbounds %struct.COORD, %struct.COORD* %42, i64 0, i32 1
  %44 = load i32*, i32** %43, align 8
  store i32 2, i32* %44, align 4
  br i1 %38, label %45, label %64

; <label>:45:                                     ; preds = %2
  %46 = getelementptr inbounds i8, i8* %5, i64 108
  %47 = bitcast i8* %46 to i32*
  store i32 3, i32* %47, align 4
  %48 = getelementptr inbounds i8, i8* %5, i64 112
  %49 = bitcast i8* %48 to i32*
  store i32 4, i32* %49, align 4
  %50 = getelementptr inbounds i8, i8* %5, i64 116
  %51 = bitcast i8* %50 to i32*
  store i32 5, i32* %51, align 4
  %52 = load %struct.stType*, %struct.stType** %17, align 8
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %52, i64 0, i32 0
  %54 = load %struct.COORD*, %struct.COORD** %53, align 8
  %55 = getelementptr inbounds %struct.COORD, %struct.COORD* %54, i64 0, i32 0
  %56 = load i32*, i32** %55, align 8
  store i32 16, i32* %56, align 4
  %57 = load %struct.COORD*, %struct.COORD** %53, align 8
  %58 = getelementptr inbounds %struct.COORD, %struct.COORD* %57, i64 0, i32 1
  %59 = load i32*, i32** %58, align 8
  store i32 17, i32* %59, align 4
  %60 = getelementptr inbounds %struct.stType, %struct.stType* %52, i64 0, i32 2, i64 0
  store i32 18, i32* %60, align 4
  %61 = getelementptr inbounds %struct.stType, %struct.stType* %52, i64 0, i32 2, i64 1
  store i32 19, i32* %61, align 4
  %62 = getelementptr inbounds %struct.stType, %struct.stType* %52, i64 0, i32 2, i64 2
  store i32 20, i32* %62, align 4
  %63 = getelementptr inbounds %struct.stType, %struct.stType* %52, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %63, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %.pre1 = load %struct.stType*, %struct.stType** %28, align 8
  br label %79

; <label>:64:                                     ; preds = %2
  %65 = load %struct.COORD*, %struct.COORD** %35, align 8
  %66 = getelementptr inbounds %struct.COORD, %struct.COORD* %65, i64 0, i32 0
  %67 = load i32*, i32** %66, align 8
  store i32 6, i32* %67, align 4
  %68 = load %struct.COORD*, %struct.COORD** %35, align 8
  %69 = getelementptr inbounds %struct.COORD, %struct.COORD* %68, i64 0, i32 1
  %70 = load i32*, i32** %69, align 8
  store i32 7, i32* %70, align 4
  %71 = getelementptr inbounds i8, i8* %26, i64 108
  %72 = bitcast i8* %71 to i32*
  store i32 8, i32* %72, align 4
  %73 = getelementptr inbounds i8, i8* %26, i64 112
  %74 = bitcast i8* %73 to i32*
  store i32 9, i32* %74, align 4
  %75 = getelementptr inbounds i8, i8* %26, i64 116
  %76 = bitcast i8* %75 to i32*
  store i32 10, i32* %76, align 4
  %77 = load %struct.stType*, %struct.stType** %28, align 8
  %78 = getelementptr inbounds %struct.stType, %struct.stType* %77, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %78, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %.pre = load %struct.stType*, %struct.stType** %17, align 8
  br label %79

; <label>:79:                                     ; preds = %64, %45
  %80 = phi %struct.stType* [ %77, %64 ], [ %.pre1, %45 ]
  %81 = phi %struct.stType* [ %.pre, %64 ], [ %52, %45 ]
  %82 = getelementptr inbounds %struct.stType, %struct.stType* %81, i64 0, i32 0
  %83 = load %struct.COORD*, %struct.COORD** %82, align 8
  %84 = getelementptr inbounds %struct.COORD, %struct.COORD* %83, i64 0, i32 0
  %85 = load i32*, i32** %84, align 8
  store i32 16, i32* %85, align 4
  %86 = load %struct.COORD*, %struct.COORD** %82, align 8
  %87 = getelementptr inbounds %struct.COORD, %struct.COORD* %86, i64 0, i32 1
  %88 = load i32*, i32** %87, align 8
  store i32 17, i32* %88, align 4
  %89 = load %struct.stType*, %struct.stType** %4, align 8
  %90 = getelementptr inbounds %struct.stType, %struct.stType* %89, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %90, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %91 = getelementptr inbounds %struct.stType, %struct.stType* %80, i64 0, i32 0
  %92 = load %struct.COORD*, %struct.COORD** %91, align 8
  %93 = getelementptr inbounds %struct.COORD, %struct.COORD* %92, i64 0, i32 0
  %94 = load i32*, i32** %93, align 8
  store i32 6, i32* %94, align 4
  %95 = load %struct.COORD*, %struct.COORD** %91, align 8
  %96 = getelementptr inbounds %struct.COORD, %struct.COORD* %95, i64 0, i32 1
  %97 = load i32*, i32** %96, align 8
  store i32 7, i32* %97, align 4
  %98 = getelementptr inbounds %struct.stType, %struct.stType* %80, i64 0, i32 2, i64 0
  store i32 8, i32* %98, align 4
  %99 = getelementptr inbounds %struct.stType, %struct.stType* %80, i64 0, i32 2, i64 1
  store i32 9, i32* %99, align 4
  %100 = getelementptr inbounds %struct.stType, %struct.stType* %80, i64 0, i32 2, i64 2
  store i32 10, i32* %100, align 4
  %101 = getelementptr inbounds %struct.stType, %struct.stType* %80, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %101, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %102 = tail call noalias i8* @malloc(i64 144) #4
  %103 = getelementptr inbounds i8, i8* %3, i64 16
  %104 = bitcast i8* %103 to %struct.stType**
  %105 = bitcast i8* %103 to i8**
  store i8* %102, i8** %105, align 8
  %106 = tail call noalias i8* @malloc(i64 16) #4
  %107 = bitcast i8* %102 to i8**
  store i8* %106, i8** %107, align 8
  %108 = tail call noalias i8* @malloc(i64 4) #4
  %109 = bitcast i8* %106 to i8**
  store i8* %108, i8** %109, align 8
  %110 = tail call noalias i8* @malloc(i64 4) #4
  %111 = bitcast i8* %102 to %struct.COORD**
  %112 = getelementptr inbounds i8, i8* %106, i64 8
  %113 = bitcast i8* %112 to i8**
  store i8* %110, i8** %113, align 8
  %114 = load %struct.COORD*, %struct.COORD** %111, align 8
  %115 = getelementptr inbounds %struct.COORD, %struct.COORD* %114, i64 0, i32 0
  %116 = load i32*, i32** %115, align 8
  store i32 11, i32* %116, align 4
  %117 = load %struct.COORD*, %struct.COORD** %111, align 8
  %118 = getelementptr inbounds %struct.COORD, %struct.COORD* %117, i64 0, i32 1
  %119 = load i32*, i32** %118, align 8
  store i32 12, i32* %119, align 4
  %120 = getelementptr inbounds i8, i8* %102, i64 108
  %121 = bitcast i8* %120 to i32*
  store i32 13, i32* %121, align 4
  %122 = load %struct.stType*, %struct.stType** %104, align 8
  %123 = getelementptr inbounds %struct.stType, %struct.stType* %122, i64 0, i32 2, i64 1
  store i32 14, i32* %123, align 4
  %124 = getelementptr inbounds %struct.stType, %struct.stType* %122, i64 0, i32 2, i64 2
  store i32 15, i32* %124, align 4
  %125 = getelementptr inbounds %struct.stType, %struct.stType* %122, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %125, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  tail call void @branchPruned_clone(%struct.stType** nonnull %4)
  tail call void @branchNotPruned_clone(%struct.stType** nonnull %4)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.stType** nocapture readnone) local_unnamed_addr #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned_clone(%struct.stType** nocapture readonly) local_unnamed_addr #0 {
  %2 = load %struct.stType*, %struct.stType** %0, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 2, i64 1
  %4 = load i32, i32* %3, align 4
  %5 = icmp eq i32 %4, 4
  br i1 %5, label %24, label %6

; <label>:6:                                      ; preds = %1
  %7 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %8 = load %struct.stType*, %struct.stType** %7, align 8
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 2, i64 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp eq i32 %10, 19
  br i1 %11, label %24, label %12

; <label>:12:                                     ; preds = %6
  %13 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 0
  %14 = tail call i32 @strcmp(i8* %13, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %24, label %16

; <label>:16:                                     ; preds = %12
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 4
  %18 = load i8, i8* %17, align 4
  %19 = icmp eq i8 %18, 111
  br i1 %19, label %24, label %20

; <label>:20:                                     ; preds = %16
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 9
  %22 = load i8, i8* %21, align 1
  %23 = icmp eq i8 %22, 100
  br i1 %23, label %24, label %25

; <label>:24:                                     ; preds = %12, %20, %16, %6, %1
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @str.3, i64 0, i64 0))
  br label %25

; <label>:25:                                     ; preds = %24, %20
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #4

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
