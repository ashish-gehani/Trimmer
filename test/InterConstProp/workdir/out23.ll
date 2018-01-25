; ModuleID = 'workdir/out23.bc'
source_filename = "inter23.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@obj = common local_unnamed_addr global %struct.stType** null, align 8
@.str = private constant [11 x i8] c"helloWorld\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@str.2 = private unnamed_addr constant [18 x i8] c"*** Branch Taken \00"
@str.3 = private unnamed_addr constant [22 x i8] c"*** Branch not Taken \00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned() local_unnamed_addr #0 {
  %1 = load %struct.stType**, %struct.stType*** @obj, align 8
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 0
  %4 = load %struct.COORD*, %struct.COORD** %3, align 8
  %5 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i64 0, i32 0
  %6 = load i32*, i32** %5, align 8
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 %7, 1
  br i1 %8, label %9, label %57

; <label>:9:                                      ; preds = %0
  %10 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i64 0, i32 1
  %11 = load i32*, i32** %10, align 8
  %12 = load i32, i32* %11, align 4
  %13 = icmp eq i32 %12, 2
  br i1 %13, label %14, label %57

; <label>:14:                                     ; preds = %9
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 1, i64 0
  %16 = tail call i32 @strcmp(i8* %15, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %57

; <label>:18:                                     ; preds = %14
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 1, i64 4
  %20 = load i8, i8* %19, align 4
  %21 = icmp eq i8 %20, 111
  br i1 %21, label %22, label %57

; <label>:22:                                     ; preds = %18
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 1, i64 9
  %24 = load i8, i8* %23, align 1
  %25 = icmp eq i8 %24, 100
  br i1 %25, label %26, label %57

; <label>:26:                                     ; preds = %22
  %27 = getelementptr inbounds %struct.stType*, %struct.stType** %1, i64 2
  %28 = load %struct.stType*, %struct.stType** %27, align 8
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 0
  %30 = load %struct.COORD*, %struct.COORD** %29, align 8
  %31 = getelementptr inbounds %struct.COORD, %struct.COORD* %30, i64 0, i32 0
  %32 = load i32*, i32** %31, align 8
  %33 = load i32, i32* %32, align 4
  %34 = icmp eq i32 %33, 11
  br i1 %34, label %35, label %57

; <label>:35:                                     ; preds = %26
  %36 = getelementptr inbounds %struct.COORD, %struct.COORD* %30, i64 0, i32 1
  %37 = load i32*, i32** %36, align 8
  %38 = load i32, i32* %37, align 4
  %39 = icmp eq i32 %38, 12
  br i1 %39, label %40, label %57

; <label>:40:                                     ; preds = %35
  %41 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 2, i64 1
  %42 = load i32, i32* %41, align 4
  %43 = icmp eq i32 %42, 14
  br i1 %43, label %44, label %57

; <label>:44:                                     ; preds = %40
  %45 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 1, i64 0
  %46 = tail call i32 @strcmp(i8* %45, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %47 = icmp eq i32 %46, 0
  br i1 %47, label %48, label %57

; <label>:48:                                     ; preds = %44
  %49 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 1, i64 4
  %50 = load i8, i8* %49, align 4
  %51 = icmp eq i8 %50, 111
  br i1 %51, label %52, label %57

; <label>:52:                                     ; preds = %48
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 1, i64 9
  %54 = load i8, i8* %53, align 1
  %55 = icmp eq i8 %54, 100
  br i1 %55, label %56, label %57

; <label>:56:                                     ; preds = %52
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0))
  br label %57

; <label>:57:                                     ; preds = %44, %14, %56, %52, %48, %40, %35, %26, %22, %18, %9, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #1

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned() local_unnamed_addr #0 {
  %1 = load %struct.stType**, %struct.stType*** @obj, align 8
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 2, i64 1
  %4 = load i32, i32* %3, align 4
  %5 = icmp eq i32 %4, 4
  br i1 %5, label %6, label %37

; <label>:6:                                      ; preds = %0
  %7 = getelementptr inbounds %struct.stType*, %struct.stType** %1, i64 3
  %8 = load %struct.stType*, %struct.stType** %7, align 8
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 0
  %10 = load %struct.COORD*, %struct.COORD** %9, align 8
  %11 = getelementptr inbounds %struct.COORD, %struct.COORD* %10, i64 0, i32 0
  %12 = load i32*, i32** %11, align 8
  %13 = load i32, i32* %12, align 4
  %14 = icmp eq i32 %13, 16
  br i1 %14, label %15, label %37

; <label>:15:                                     ; preds = %6
  %16 = getelementptr inbounds %struct.COORD, %struct.COORD* %10, i64 0, i32 1
  %17 = load i32*, i32** %16, align 8
  %18 = load i32, i32* %17, align 4
  %19 = icmp eq i32 %18, 17
  br i1 %19, label %20, label %37

; <label>:20:                                     ; preds = %15
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 2, i64 1
  %22 = load i32, i32* %21, align 4
  %23 = icmp eq i32 %22, 19
  br i1 %23, label %24, label %37

; <label>:24:                                     ; preds = %20
  %25 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 0
  %26 = tail call i32 @strcmp(i8* %25, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %28, label %37

; <label>:28:                                     ; preds = %24
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 4
  %30 = load i8, i8* %29, align 4
  %31 = icmp eq i8 %30, 111
  br i1 %31, label %32, label %37

; <label>:32:                                     ; preds = %28
  %33 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 9
  %34 = load i8, i8* %33, align 1
  %35 = icmp eq i8 %34, 100
  br i1 %35, label %36, label %37

; <label>:36:                                     ; preds = %32
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @str.3, i64 0, i64 0))
  br label %37

; <label>:37:                                     ; preds = %24, %36, %32, %28, %20, %15, %6, %0
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8** nocapture readnone) local_unnamed_addr #0 {
  %3 = tail call noalias i8* @malloc(i64 160) #4
  store i8* %3, i8** bitcast (%struct.stType*** @obj to i8**), align 8
  %4 = tail call noalias i8* @malloc(i64 144) #4
  %5 = bitcast i8* %3 to i8**
  store i8* %4, i8** %5, align 8
  %6 = tail call noalias i8* @malloc(i64 16) #4
  %7 = bitcast i8* %4 to i8**
  store i8* %6, i8** %7, align 8
  %8 = tail call noalias i8* @malloc(i64 4) #4
  %.cast2 = bitcast i8* %6 to i8**
  store i8* %8, i8** %.cast2, align 8
  %9 = tail call noalias i8* @malloc(i64 4) #4
  %10 = load %struct.stType**, %struct.stType*** @obj, align 8
  %11 = load %struct.stType*, %struct.stType** %10, align 8
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i64 0, i32 0
  %13 = load %struct.COORD*, %struct.COORD** %12, align 8
  %14 = getelementptr inbounds %struct.COORD, %struct.COORD* %13, i64 0, i32 1
  %15 = bitcast i32** %14 to i8**
  store i8* %9, i8** %15, align 8
  %16 = tail call noalias i8* @malloc(i64 144) #4
  %17 = getelementptr inbounds %struct.stType*, %struct.stType** %10, i64 3
  %18 = bitcast %struct.stType** %17 to i8**
  store i8* %16, i8** %18, align 8
  %19 = tail call noalias i8* @malloc(i64 16) #4
  %20 = bitcast %struct.stType** %17 to i8***
  %21 = load i8**, i8*** %20, align 8
  store i8* %19, i8** %21, align 8
  %22 = tail call noalias i8* @malloc(i64 4) #4
  %23 = load %struct.stType**, %struct.stType*** @obj, align 8
  %24 = getelementptr inbounds %struct.stType*, %struct.stType** %23, i64 3
  %25 = bitcast %struct.stType** %24 to i8****
  %26 = load i8***, i8**** %25, align 8
  %27 = load i8**, i8*** %26, align 8
  store i8* %22, i8** %27, align 8
  %28 = tail call noalias i8* @malloc(i64 4) #4
  %29 = load %struct.stType**, %struct.stType*** @obj, align 8
  %30 = getelementptr inbounds %struct.stType*, %struct.stType** %29, i64 3
  %31 = load %struct.stType*, %struct.stType** %30, align 8
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %31, i64 0, i32 0
  %33 = load %struct.COORD*, %struct.COORD** %32, align 8
  %34 = getelementptr inbounds %struct.COORD, %struct.COORD* %33, i64 0, i32 1
  %35 = bitcast i32** %34 to i8**
  store i8* %28, i8** %35, align 8
  %36 = tail call noalias i8* @malloc(i64 144) #4
  %37 = getelementptr inbounds %struct.stType*, %struct.stType** %29, i64 1
  %38 = bitcast %struct.stType** %37 to i8**
  store i8* %36, i8** %38, align 8
  %39 = tail call noalias i8* @malloc(i64 16) #4
  %40 = bitcast %struct.stType** %37 to i8***
  %41 = load i8**, i8*** %40, align 8
  store i8* %39, i8** %41, align 8
  %42 = tail call noalias i8* @malloc(i64 4) #4
  %43 = load %struct.stType**, %struct.stType*** @obj, align 8
  %44 = getelementptr inbounds %struct.stType*, %struct.stType** %43, i64 1
  %45 = bitcast %struct.stType** %44 to i8****
  %46 = load i8***, i8**** %45, align 8
  %47 = load i8**, i8*** %46, align 8
  store i8* %42, i8** %47, align 8
  %48 = tail call noalias i8* @malloc(i64 4) #4
  %49 = load %struct.stType**, %struct.stType*** @obj, align 8
  %50 = getelementptr inbounds %struct.stType*, %struct.stType** %49, i64 1
  %51 = load %struct.stType*, %struct.stType** %50, align 8
  %52 = getelementptr inbounds %struct.stType, %struct.stType* %51, i64 0, i32 0
  %53 = load %struct.COORD*, %struct.COORD** %52, align 8
  %54 = getelementptr inbounds %struct.COORD, %struct.COORD* %53, i64 0, i32 1
  %55 = bitcast i32** %54 to i8**
  store i8* %48, i8** %55, align 8
  %56 = icmp sgt i32 %0, 2
  %57 = load %struct.stType*, %struct.stType** %49, align 8
  %58 = getelementptr inbounds %struct.stType, %struct.stType* %57, i64 0, i32 0
  %59 = load %struct.COORD*, %struct.COORD** %58, align 8
  %60 = getelementptr inbounds %struct.COORD, %struct.COORD* %59, i64 0, i32 0
  %61 = load i32*, i32** %60, align 8
  store i32 1, i32* %61, align 4
  %62 = load %struct.stType**, %struct.stType*** @obj, align 8
  %63 = load %struct.stType*, %struct.stType** %62, align 8
  %64 = getelementptr inbounds %struct.stType, %struct.stType* %63, i64 0, i32 0
  %65 = load %struct.COORD*, %struct.COORD** %64, align 8
  %66 = getelementptr inbounds %struct.COORD, %struct.COORD* %65, i64 0, i32 1
  %67 = load i32*, i32** %66, align 8
  store i32 2, i32* %67, align 4
  %68 = load %struct.stType**, %struct.stType*** @obj, align 8
  br i1 %56, label %69, label %99

; <label>:69:                                     ; preds = %2
  %70 = load %struct.stType*, %struct.stType** %68, align 8
  %71 = getelementptr inbounds %struct.stType, %struct.stType* %70, i64 0, i32 2, i64 0
  store i32 3, i32* %71, align 4
  %72 = load %struct.stType*, %struct.stType** %68, align 8
  %73 = getelementptr inbounds %struct.stType, %struct.stType* %72, i64 0, i32 2, i64 1
  store i32 4, i32* %73, align 4
  %74 = load %struct.stType*, %struct.stType** %68, align 8
  %75 = getelementptr inbounds %struct.stType, %struct.stType* %74, i64 0, i32 2, i64 2
  store i32 5, i32* %75, align 4
  %76 = getelementptr inbounds %struct.stType*, %struct.stType** %68, i64 3
  %77 = load %struct.stType*, %struct.stType** %76, align 8
  %78 = getelementptr inbounds %struct.stType, %struct.stType* %77, i64 0, i32 0
  %79 = load %struct.COORD*, %struct.COORD** %78, align 8
  %80 = getelementptr inbounds %struct.COORD, %struct.COORD* %79, i64 0, i32 0
  %81 = load i32*, i32** %80, align 8
  store i32 16, i32* %81, align 4
  %82 = load %struct.stType**, %struct.stType*** @obj, align 8
  %83 = getelementptr inbounds %struct.stType*, %struct.stType** %82, i64 3
  %84 = load %struct.stType*, %struct.stType** %83, align 8
  %85 = getelementptr inbounds %struct.stType, %struct.stType* %84, i64 0, i32 0
  %86 = load %struct.COORD*, %struct.COORD** %85, align 8
  %87 = getelementptr inbounds %struct.COORD, %struct.COORD* %86, i64 0, i32 1
  %88 = load i32*, i32** %87, align 8
  store i32 17, i32* %88, align 4
  %89 = load %struct.stType**, %struct.stType*** @obj, align 8
  %90 = getelementptr inbounds %struct.stType*, %struct.stType** %89, i64 3
  %91 = load %struct.stType*, %struct.stType** %90, align 8
  %92 = getelementptr inbounds %struct.stType, %struct.stType* %91, i64 0, i32 2, i64 0
  store i32 18, i32* %92, align 4
  %93 = load %struct.stType*, %struct.stType** %90, align 8
  %94 = getelementptr inbounds %struct.stType, %struct.stType* %93, i64 0, i32 2, i64 1
  store i32 19, i32* %94, align 4
  %95 = load %struct.stType*, %struct.stType** %90, align 8
  %96 = getelementptr inbounds %struct.stType, %struct.stType* %95, i64 0, i32 2, i64 2
  store i32 20, i32* %96, align 4
  %97 = load %struct.stType*, %struct.stType** %90, align 8
  %98 = getelementptr inbounds %struct.stType, %struct.stType* %97, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %98, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  br label %123

; <label>:99:                                     ; preds = %2
  %100 = getelementptr inbounds %struct.stType*, %struct.stType** %68, i64 1
  %101 = load %struct.stType*, %struct.stType** %100, align 8
  %102 = getelementptr inbounds %struct.stType, %struct.stType* %101, i64 0, i32 0
  %103 = load %struct.COORD*, %struct.COORD** %102, align 8
  %104 = getelementptr inbounds %struct.COORD, %struct.COORD* %103, i64 0, i32 0
  %105 = load i32*, i32** %104, align 8
  store i32 6, i32* %105, align 4
  %106 = load %struct.stType**, %struct.stType*** @obj, align 8
  %107 = getelementptr inbounds %struct.stType*, %struct.stType** %106, i64 1
  %108 = load %struct.stType*, %struct.stType** %107, align 8
  %109 = getelementptr inbounds %struct.stType, %struct.stType* %108, i64 0, i32 0
  %110 = load %struct.COORD*, %struct.COORD** %109, align 8
  %111 = getelementptr inbounds %struct.COORD, %struct.COORD* %110, i64 0, i32 1
  %112 = load i32*, i32** %111, align 8
  store i32 7, i32* %112, align 4
  %113 = load %struct.stType**, %struct.stType*** @obj, align 8
  %114 = getelementptr inbounds %struct.stType*, %struct.stType** %113, i64 1
  %115 = load %struct.stType*, %struct.stType** %114, align 8
  %116 = getelementptr inbounds %struct.stType, %struct.stType* %115, i64 0, i32 2, i64 0
  store i32 8, i32* %116, align 4
  %117 = load %struct.stType*, %struct.stType** %114, align 8
  %118 = getelementptr inbounds %struct.stType, %struct.stType* %117, i64 0, i32 2, i64 1
  store i32 9, i32* %118, align 4
  %119 = load %struct.stType*, %struct.stType** %114, align 8
  %120 = getelementptr inbounds %struct.stType, %struct.stType* %119, i64 0, i32 2, i64 2
  store i32 10, i32* %120, align 4
  %121 = load %struct.stType*, %struct.stType** %114, align 8
  %122 = getelementptr inbounds %struct.stType, %struct.stType* %121, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %122, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  br label %123

; <label>:123:                                    ; preds = %99, %69
  %124 = phi %struct.stType** [ %113, %99 ], [ %89, %69 ]
  %125 = load %struct.stType*, %struct.stType** %124, align 8
  %126 = getelementptr inbounds %struct.stType, %struct.stType* %125, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %126, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %127 = getelementptr inbounds %struct.stType*, %struct.stType** %124, i64 1
  %128 = load %struct.stType*, %struct.stType** %127, align 8
  %129 = getelementptr inbounds %struct.stType, %struct.stType* %128, i64 0, i32 0
  %130 = load %struct.COORD*, %struct.COORD** %129, align 8
  %131 = getelementptr inbounds %struct.COORD, %struct.COORD* %130, i64 0, i32 0
  %132 = load i32*, i32** %131, align 8
  store i32 6, i32* %132, align 4
  %133 = load %struct.stType**, %struct.stType*** @obj, align 8
  %134 = getelementptr inbounds %struct.stType*, %struct.stType** %133, i64 1
  %135 = load %struct.stType*, %struct.stType** %134, align 8
  %136 = getelementptr inbounds %struct.stType, %struct.stType* %135, i64 0, i32 0
  %137 = load %struct.COORD*, %struct.COORD** %136, align 8
  %138 = getelementptr inbounds %struct.COORD, %struct.COORD* %137, i64 0, i32 1
  %139 = load i32*, i32** %138, align 8
  store i32 7, i32* %139, align 4
  %140 = load %struct.stType**, %struct.stType*** @obj, align 8
  %141 = getelementptr inbounds %struct.stType*, %struct.stType** %140, i64 1
  %142 = load %struct.stType*, %struct.stType** %141, align 8
  %143 = getelementptr inbounds %struct.stType, %struct.stType* %142, i64 0, i32 2, i64 0
  store i32 8, i32* %143, align 4
  %144 = load %struct.stType*, %struct.stType** %141, align 8
  %145 = getelementptr inbounds %struct.stType, %struct.stType* %144, i64 0, i32 2, i64 1
  store i32 9, i32* %145, align 4
  %146 = load %struct.stType*, %struct.stType** %141, align 8
  %147 = getelementptr inbounds %struct.stType, %struct.stType* %146, i64 0, i32 2, i64 2
  store i32 10, i32* %147, align 4
  %148 = load %struct.stType*, %struct.stType** %141, align 8
  %149 = getelementptr inbounds %struct.stType, %struct.stType* %148, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %149, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %150 = tail call noalias i8* @malloc(i64 144) #4
  %151 = getelementptr inbounds %struct.stType*, %struct.stType** %140, i64 2
  %152 = bitcast %struct.stType** %151 to i8**
  store i8* %150, i8** %152, align 8
  %153 = tail call noalias i8* @malloc(i64 16) #4
  %154 = bitcast %struct.stType** %151 to i8***
  %155 = load i8**, i8*** %154, align 8
  store i8* %153, i8** %155, align 8
  %156 = tail call noalias i8* @malloc(i64 4) #4
  %157 = load %struct.stType**, %struct.stType*** @obj, align 8
  %158 = getelementptr inbounds %struct.stType*, %struct.stType** %157, i64 2
  %159 = bitcast %struct.stType** %158 to i8****
  %160 = load i8***, i8**** %159, align 8
  %161 = load i8**, i8*** %160, align 8
  store i8* %156, i8** %161, align 8
  %162 = tail call noalias i8* @malloc(i64 4) #4
  %163 = load %struct.stType**, %struct.stType*** @obj, align 8
  %164 = getelementptr inbounds %struct.stType*, %struct.stType** %163, i64 2
  %165 = load %struct.stType*, %struct.stType** %164, align 8
  %166 = getelementptr inbounds %struct.stType, %struct.stType* %165, i64 0, i32 0
  %167 = load %struct.COORD*, %struct.COORD** %166, align 8
  %168 = getelementptr inbounds %struct.COORD, %struct.COORD* %167, i64 0, i32 1
  %169 = bitcast i32** %168 to i8**
  store i8* %162, i8** %169, align 8
  %170 = load %struct.stType*, %struct.stType** %164, align 8
  %171 = getelementptr inbounds %struct.stType, %struct.stType* %170, i64 0, i32 0
  %172 = load %struct.COORD*, %struct.COORD** %171, align 8
  %173 = getelementptr inbounds %struct.COORD, %struct.COORD* %172, i64 0, i32 0
  %174 = load i32*, i32** %173, align 8
  store i32 11, i32* %174, align 4
  %175 = load %struct.stType**, %struct.stType*** @obj, align 8
  %176 = getelementptr inbounds %struct.stType*, %struct.stType** %175, i64 2
  %177 = load %struct.stType*, %struct.stType** %176, align 8
  %178 = getelementptr inbounds %struct.stType, %struct.stType* %177, i64 0, i32 0
  %179 = load %struct.COORD*, %struct.COORD** %178, align 8
  %180 = getelementptr inbounds %struct.COORD, %struct.COORD* %179, i64 0, i32 1
  %181 = load i32*, i32** %180, align 8
  store i32 12, i32* %181, align 4
  %182 = load %struct.stType**, %struct.stType*** @obj, align 8
  %183 = getelementptr inbounds %struct.stType*, %struct.stType** %182, i64 2
  %184 = load %struct.stType*, %struct.stType** %183, align 8
  %185 = getelementptr inbounds %struct.stType, %struct.stType* %184, i64 0, i32 2, i64 0
  store i32 13, i32* %185, align 4
  %186 = load %struct.stType*, %struct.stType** %183, align 8
  %187 = getelementptr inbounds %struct.stType, %struct.stType* %186, i64 0, i32 2, i64 1
  store i32 14, i32* %187, align 4
  %188 = load %struct.stType*, %struct.stType** %183, align 8
  %189 = getelementptr inbounds %struct.stType, %struct.stType* %188, i64 0, i32 2, i64 2
  store i32 15, i32* %189, align 4
  %190 = load %struct.stType*, %struct.stType** %183, align 8
  %191 = getelementptr inbounds %struct.stType, %struct.stType* %190, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %191, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  tail call void @branchPruned_clone()
  tail call void @branchNotPruned_clone()
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone() local_unnamed_addr #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned_clone() local_unnamed_addr #0 {
  %1 = load %struct.stType**, %struct.stType*** @obj, align 8
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 2, i64 1
  %4 = load i32, i32* %3, align 4
  %5 = icmp eq i32 %4, 4
  br i1 %5, label %6, label %37

; <label>:6:                                      ; preds = %0
  %7 = getelementptr inbounds %struct.stType*, %struct.stType** %1, i64 3
  %8 = load %struct.stType*, %struct.stType** %7, align 8
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 0
  %10 = load %struct.COORD*, %struct.COORD** %9, align 8
  %11 = getelementptr inbounds %struct.COORD, %struct.COORD* %10, i64 0, i32 0
  %12 = load i32*, i32** %11, align 8
  %13 = load i32, i32* %12, align 4
  %14 = icmp eq i32 %13, 16
  br i1 %14, label %15, label %37

; <label>:15:                                     ; preds = %6
  %16 = getelementptr inbounds %struct.COORD, %struct.COORD* %10, i64 0, i32 1
  %17 = load i32*, i32** %16, align 8
  %18 = load i32, i32* %17, align 4
  %19 = icmp eq i32 %18, 17
  br i1 %19, label %20, label %37

; <label>:20:                                     ; preds = %15
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 2, i64 1
  %22 = load i32, i32* %21, align 4
  %23 = icmp eq i32 %22, 19
  br i1 %23, label %24, label %37

; <label>:24:                                     ; preds = %20
  %25 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 0
  %26 = tail call i32 @strcmp(i8* %25, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %28, label %37

; <label>:28:                                     ; preds = %24
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 4
  %30 = load i8, i8* %29, align 4
  %31 = icmp eq i8 %30, 111
  br i1 %31, label %32, label %37

; <label>:32:                                     ; preds = %28
  %33 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 9
  %34 = load i8, i8* %33, align 1
  %35 = icmp eq i8 %34, 100
  br i1 %35, label %36, label %37

; <label>:36:                                     ; preds = %32
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @str.3, i64 0, i64 0))
  br label %37

; <label>:37:                                     ; preds = %24, %36, %32, %28, %20, %15, %6, %0
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
