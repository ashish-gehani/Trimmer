; ModuleID = 'workdir/out23.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@obj = common global %struct.stType** null, align 8
@.str = private constant [11 x i8] c"helloWorld\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@str.2 = private unnamed_addr constant [18 x i8] c"*** Branch Taken \00"
@str.3 = private unnamed_addr constant [22 x i8] c"*** Branch not Taken \00"

; Function Attrs: nounwind uwtable
define void @branchPruned() #0 {
  %1 = load %struct.stType**, %struct.stType*** @obj, align 8
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 0
  %4 = load %struct.COORD*, %struct.COORD** %3, align 8
  %5 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i64 0, i32 0
  %6 = load i32*, i32** %5, align 8
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 %7, 1
  br i1 %8, label %9, label %57

; <label>:9                                       ; preds = %0
  %10 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i64 0, i32 1
  %11 = load i32*, i32** %10, align 8
  %12 = load i32, i32* %11, align 4
  %13 = icmp eq i32 %12, 2
  br i1 %13, label %14, label %57

; <label>:14                                      ; preds = %9
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 1, i64 0
  %16 = tail call i32 @strcmp(i8* %15, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %57

; <label>:18                                      ; preds = %14
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 1, i64 4
  %20 = load i8, i8* %19, align 4
  %21 = icmp eq i8 %20, 111
  br i1 %21, label %22, label %57

; <label>:22                                      ; preds = %18
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 1, i64 9
  %24 = load i8, i8* %23, align 1
  %25 = icmp eq i8 %24, 100
  br i1 %25, label %26, label %57

; <label>:26                                      ; preds = %22
  %27 = getelementptr inbounds %struct.stType*, %struct.stType** %1, i64 2
  %28 = load %struct.stType*, %struct.stType** %27, align 8
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 0
  %30 = load %struct.COORD*, %struct.COORD** %29, align 8
  %31 = getelementptr inbounds %struct.COORD, %struct.COORD* %30, i64 0, i32 0
  %32 = load i32*, i32** %31, align 8
  %33 = load i32, i32* %32, align 4
  %34 = icmp eq i32 %33, 11
  br i1 %34, label %35, label %57

; <label>:35                                      ; preds = %26
  %36 = getelementptr inbounds %struct.COORD, %struct.COORD* %30, i64 0, i32 1
  %37 = load i32*, i32** %36, align 8
  %38 = load i32, i32* %37, align 4
  %39 = icmp eq i32 %38, 12
  br i1 %39, label %40, label %57

; <label>:40                                      ; preds = %35
  %41 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 2, i64 1
  %42 = load i32, i32* %41, align 4
  %43 = icmp eq i32 %42, 14
  br i1 %43, label %44, label %57

; <label>:44                                      ; preds = %40
  %45 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 1, i64 0
  %46 = tail call i32 @strcmp(i8* %45, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %47 = icmp eq i32 %46, 0
  br i1 %47, label %48, label %57

; <label>:48                                      ; preds = %44
  %49 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 1, i64 4
  %50 = load i8, i8* %49, align 4
  %51 = icmp eq i8 %50, 111
  br i1 %51, label %52, label %57

; <label>:52                                      ; preds = %48
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 0, i32 1, i64 9
  %54 = load i8, i8* %53, align 1
  %55 = icmp eq i8 %54, 100
  br i1 %55, label %56, label %57

; <label>:56                                      ; preds = %52
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0))
  br label %57

; <label>:57                                      ; preds = %44, %14, %56, %52, %48, %40, %35, %26, %22, %18, %9, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define void @branchNotPruned() #0 {
  %1 = load %struct.stType**, %struct.stType*** @obj, align 8
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 2, i64 1
  %4 = load i32, i32* %3, align 4
  %5 = icmp eq i32 %4, 4
  br i1 %5, label %6, label %37

; <label>:6                                       ; preds = %0
  %7 = getelementptr inbounds %struct.stType*, %struct.stType** %1, i64 3
  %8 = load %struct.stType*, %struct.stType** %7, align 8
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 0
  %10 = load %struct.COORD*, %struct.COORD** %9, align 8
  %11 = getelementptr inbounds %struct.COORD, %struct.COORD* %10, i64 0, i32 0
  %12 = load i32*, i32** %11, align 8
  %13 = load i32, i32* %12, align 4
  %14 = icmp eq i32 %13, 16
  br i1 %14, label %15, label %37

; <label>:15                                      ; preds = %6
  %16 = getelementptr inbounds %struct.COORD, %struct.COORD* %10, i64 0, i32 1
  %17 = load i32*, i32** %16, align 8
  %18 = load i32, i32* %17, align 4
  %19 = icmp eq i32 %18, 17
  br i1 %19, label %20, label %37

; <label>:20                                      ; preds = %15
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 2, i64 1
  %22 = load i32, i32* %21, align 4
  %23 = icmp eq i32 %22, 19
  br i1 %23, label %24, label %37

; <label>:24                                      ; preds = %20
  %25 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 0
  %26 = tail call i32 @strcmp(i8* %25, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %28, label %37

; <label>:28                                      ; preds = %24
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 4
  %30 = load i8, i8* %29, align 4
  %31 = icmp eq i8 %30, 111
  br i1 %31, label %32, label %37

; <label>:32                                      ; preds = %28
  %33 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 9
  %34 = load i8, i8* %33, align 1
  %35 = icmp eq i8 %34, 100
  br i1 %35, label %36, label %37

; <label>:36                                      ; preds = %32
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @str.3, i64 0, i64 0))
  br label %37

; <label>:37                                      ; preds = %24, %36, %32, %28, %20, %15, %6, %0
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = tail call noalias i8* @malloc(i64 160) #4
  store i8* %1, i8** bitcast (%struct.stType*** @obj to i8**), align 8
  %2 = tail call noalias i8* @malloc(i64 144) #4
  %3 = bitcast i8* %1 to i8**
  store i8* %2, i8** %3, align 8
  %4 = tail call noalias i8* @malloc(i64 16) #4
  %5 = bitcast i8* %2 to i8**
  store i8* %4, i8** %5, align 8
  %6 = tail call noalias i8* @malloc(i64 4) #4
  %7 = bitcast i8* %4 to i8**
  store i8* %6, i8** %7, align 8
  %8 = tail call noalias i8* @malloc(i64 4) #4
  %9 = getelementptr inbounds i8, i8* %4, i64 8
  %10 = bitcast i8* %9 to i8**
  store i8* %8, i8** %10, align 8
  %11 = tail call noalias i8* @malloc(i64 144) #4
  %12 = getelementptr inbounds i8, i8* %1, i64 24
  %13 = bitcast i8* %12 to i8**
  store i8* %11, i8** %13, align 8
  %14 = tail call noalias i8* @malloc(i64 16) #4
  %15 = bitcast i8* %11 to i8**
  store i8* %14, i8** %15, align 8
  %16 = tail call noalias i8* @malloc(i64 4) #4
  %17 = bitcast i8* %14 to i8**
  store i8* %16, i8** %17, align 8
  %18 = tail call noalias i8* @malloc(i64 4) #4
  %19 = getelementptr inbounds i8, i8* %14, i64 8
  %20 = bitcast i8* %19 to i8**
  store i8* %18, i8** %20, align 8
  %21 = tail call noalias i8* @malloc(i64 144) #4
  %22 = getelementptr inbounds i8, i8* %1, i64 8
  %23 = bitcast i8* %22 to i8**
  store i8* %21, i8** %23, align 8
  %24 = tail call noalias i8* @malloc(i64 16) #4
  %25 = bitcast i8* %21 to i8**
  store i8* %24, i8** %25, align 8
  %26 = tail call noalias i8* @malloc(i64 4) #4
  %27 = bitcast i8* %24 to i8**
  store i8* %26, i8** %27, align 8
  %28 = tail call noalias i8* @malloc(i64 4) #4
  %29 = getelementptr inbounds i8, i8* %24, i64 8
  %30 = bitcast i8* %29 to i8**
  store i8* %28, i8** %30, align 8
  %31 = icmp sgt i32 %argc, 2
  %32 = bitcast i8* %6 to i32*
  store i32 1, i32* %32, align 4
  %33 = bitcast i8* %8 to i32*
  store i32 2, i32* %33, align 4
  br i1 %31, label %34, label %73

; <label>:34                                      ; preds = %0
  %35 = getelementptr inbounds i8, i8* %2, i64 108
  %36 = bitcast i8* %35 to i32*
  store i32 3, i32* %36, align 4
  %37 = load %struct.stType**, %struct.stType*** @obj, align 8
  %38 = load %struct.stType*, %struct.stType** %37, align 8
  %39 = getelementptr inbounds %struct.stType, %struct.stType* %38, i64 0, i32 2, i64 1
  store i32 4, i32* %39, align 4
  %40 = load %struct.stType**, %struct.stType*** @obj, align 8
  %41 = load %struct.stType*, %struct.stType** %40, align 8
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %41, i64 0, i32 2, i64 2
  store i32 5, i32* %42, align 4
  %43 = load %struct.stType**, %struct.stType*** @obj, align 8
  %44 = getelementptr inbounds %struct.stType*, %struct.stType** %43, i64 3
  %45 = load %struct.stType*, %struct.stType** %44, align 8
  %46 = getelementptr inbounds %struct.stType, %struct.stType* %45, i64 0, i32 0
  %47 = load %struct.COORD*, %struct.COORD** %46, align 8
  %48 = getelementptr inbounds %struct.COORD, %struct.COORD* %47, i64 0, i32 0
  %49 = load i32*, i32** %48, align 8
  store i32 16, i32* %49, align 4
  %50 = load %struct.stType**, %struct.stType*** @obj, align 8
  %51 = getelementptr inbounds %struct.stType*, %struct.stType** %50, i64 3
  %52 = load %struct.stType*, %struct.stType** %51, align 8
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %52, i64 0, i32 0
  %54 = load %struct.COORD*, %struct.COORD** %53, align 8
  %55 = getelementptr inbounds %struct.COORD, %struct.COORD* %54, i64 0, i32 1
  %56 = load i32*, i32** %55, align 8
  store i32 17, i32* %56, align 4
  %57 = load %struct.stType**, %struct.stType*** @obj, align 8
  %58 = getelementptr inbounds %struct.stType*, %struct.stType** %57, i64 3
  %59 = load %struct.stType*, %struct.stType** %58, align 8
  %60 = getelementptr inbounds %struct.stType, %struct.stType* %59, i64 0, i32 2, i64 0
  store i32 18, i32* %60, align 4
  %61 = load %struct.stType**, %struct.stType*** @obj, align 8
  %62 = getelementptr inbounds %struct.stType*, %struct.stType** %61, i64 3
  %63 = load %struct.stType*, %struct.stType** %62, align 8
  %64 = getelementptr inbounds %struct.stType, %struct.stType* %63, i64 0, i32 2, i64 1
  store i32 19, i32* %64, align 4
  %65 = load %struct.stType**, %struct.stType*** @obj, align 8
  %66 = getelementptr inbounds %struct.stType*, %struct.stType** %65, i64 3
  %67 = load %struct.stType*, %struct.stType** %66, align 8
  %68 = getelementptr inbounds %struct.stType, %struct.stType* %67, i64 0, i32 2, i64 2
  store i32 20, i32* %68, align 4
  %69 = load %struct.stType**, %struct.stType*** @obj, align 8
  %70 = getelementptr inbounds %struct.stType*, %struct.stType** %69, i64 3
  %71 = load %struct.stType*, %struct.stType** %70, align 8
  %72 = getelementptr inbounds %struct.stType, %struct.stType* %71, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %72, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  br label %101

; <label>:73                                      ; preds = %0
  %74 = bitcast i8* %21 to %struct.COORD**
  %75 = load %struct.COORD*, %struct.COORD** %74, align 8
  %76 = getelementptr inbounds %struct.COORD, %struct.COORD* %75, i64 0, i32 0
  %77 = load i32*, i32** %76, align 8
  store i32 6, i32* %77, align 4
  %78 = load %struct.stType**, %struct.stType*** @obj, align 8
  %79 = getelementptr inbounds %struct.stType*, %struct.stType** %78, i64 1
  %80 = load %struct.stType*, %struct.stType** %79, align 8
  %81 = getelementptr inbounds %struct.stType, %struct.stType* %80, i64 0, i32 0
  %82 = load %struct.COORD*, %struct.COORD** %81, align 8
  %83 = getelementptr inbounds %struct.COORD, %struct.COORD* %82, i64 0, i32 1
  %84 = load i32*, i32** %83, align 8
  store i32 7, i32* %84, align 4
  %85 = load %struct.stType**, %struct.stType*** @obj, align 8
  %86 = getelementptr inbounds %struct.stType*, %struct.stType** %85, i64 1
  %87 = load %struct.stType*, %struct.stType** %86, align 8
  %88 = getelementptr inbounds %struct.stType, %struct.stType* %87, i64 0, i32 2, i64 0
  store i32 8, i32* %88, align 4
  %89 = load %struct.stType**, %struct.stType*** @obj, align 8
  %90 = getelementptr inbounds %struct.stType*, %struct.stType** %89, i64 1
  %91 = load %struct.stType*, %struct.stType** %90, align 8
  %92 = getelementptr inbounds %struct.stType, %struct.stType* %91, i64 0, i32 2, i64 1
  store i32 9, i32* %92, align 4
  %93 = load %struct.stType**, %struct.stType*** @obj, align 8
  %94 = getelementptr inbounds %struct.stType*, %struct.stType** %93, i64 1
  %95 = load %struct.stType*, %struct.stType** %94, align 8
  %96 = getelementptr inbounds %struct.stType, %struct.stType* %95, i64 0, i32 2, i64 2
  store i32 10, i32* %96, align 4
  %97 = load %struct.stType**, %struct.stType*** @obj, align 8
  %98 = getelementptr inbounds %struct.stType*, %struct.stType** %97, i64 1
  %99 = load %struct.stType*, %struct.stType** %98, align 8
  %100 = getelementptr inbounds %struct.stType, %struct.stType* %99, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %100, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  br label %101

; <label>:101                                     ; preds = %73, %34
  %102 = load %struct.stType**, %struct.stType*** @obj, align 8
  %103 = load %struct.stType*, %struct.stType** %102, align 8
  %104 = getelementptr inbounds %struct.stType, %struct.stType* %103, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %104, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %105 = load %struct.stType**, %struct.stType*** @obj, align 8
  %106 = getelementptr inbounds %struct.stType*, %struct.stType** %105, i64 1
  %107 = load %struct.stType*, %struct.stType** %106, align 8
  %108 = getelementptr inbounds %struct.stType, %struct.stType* %107, i64 0, i32 0
  %109 = load %struct.COORD*, %struct.COORD** %108, align 8
  %110 = getelementptr inbounds %struct.COORD, %struct.COORD* %109, i64 0, i32 0
  %111 = load i32*, i32** %110, align 8
  store i32 6, i32* %111, align 4
  %112 = load %struct.stType**, %struct.stType*** @obj, align 8
  %113 = getelementptr inbounds %struct.stType*, %struct.stType** %112, i64 1
  %114 = load %struct.stType*, %struct.stType** %113, align 8
  %115 = getelementptr inbounds %struct.stType, %struct.stType* %114, i64 0, i32 0
  %116 = load %struct.COORD*, %struct.COORD** %115, align 8
  %117 = getelementptr inbounds %struct.COORD, %struct.COORD* %116, i64 0, i32 1
  %118 = load i32*, i32** %117, align 8
  store i32 7, i32* %118, align 4
  %119 = load %struct.stType**, %struct.stType*** @obj, align 8
  %120 = getelementptr inbounds %struct.stType*, %struct.stType** %119, i64 1
  %121 = load %struct.stType*, %struct.stType** %120, align 8
  %122 = getelementptr inbounds %struct.stType, %struct.stType* %121, i64 0, i32 2, i64 0
  store i32 8, i32* %122, align 4
  %123 = load %struct.stType**, %struct.stType*** @obj, align 8
  %124 = getelementptr inbounds %struct.stType*, %struct.stType** %123, i64 1
  %125 = load %struct.stType*, %struct.stType** %124, align 8
  %126 = getelementptr inbounds %struct.stType, %struct.stType* %125, i64 0, i32 2, i64 1
  store i32 9, i32* %126, align 4
  %127 = load %struct.stType**, %struct.stType*** @obj, align 8
  %128 = getelementptr inbounds %struct.stType*, %struct.stType** %127, i64 1
  %129 = load %struct.stType*, %struct.stType** %128, align 8
  %130 = getelementptr inbounds %struct.stType, %struct.stType* %129, i64 0, i32 2, i64 2
  store i32 10, i32* %130, align 4
  %131 = load %struct.stType**, %struct.stType*** @obj, align 8
  %132 = getelementptr inbounds %struct.stType*, %struct.stType** %131, i64 1
  %133 = load %struct.stType*, %struct.stType** %132, align 8
  %134 = getelementptr inbounds %struct.stType, %struct.stType* %133, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %134, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %135 = tail call noalias i8* @malloc(i64 144) #4
  %136 = load %struct.stType**, %struct.stType*** @obj, align 8
  %137 = getelementptr inbounds %struct.stType*, %struct.stType** %136, i64 2
  %138 = bitcast %struct.stType** %137 to i8**
  store i8* %135, i8** %138, align 8
  %139 = tail call noalias i8* @malloc(i64 16) #4
  %140 = load %struct.stType**, %struct.stType*** @obj, align 8
  %141 = getelementptr inbounds %struct.stType*, %struct.stType** %140, i64 2
  %142 = bitcast %struct.stType** %141 to i8***
  %143 = load i8**, i8*** %142, align 8
  store i8* %139, i8** %143, align 8
  %144 = tail call noalias i8* @malloc(i64 4) #4
  %145 = load %struct.stType**, %struct.stType*** @obj, align 8
  %146 = getelementptr inbounds %struct.stType*, %struct.stType** %145, i64 2
  %147 = bitcast %struct.stType** %146 to i8****
  %148 = load i8***, i8**** %147, align 8
  %149 = load i8**, i8*** %148, align 8
  store i8* %144, i8** %149, align 8
  %150 = tail call noalias i8* @malloc(i64 4) #4
  %151 = load %struct.stType**, %struct.stType*** @obj, align 8
  %152 = getelementptr inbounds %struct.stType*, %struct.stType** %151, i64 2
  %153 = load %struct.stType*, %struct.stType** %152, align 8
  %154 = getelementptr inbounds %struct.stType, %struct.stType* %153, i64 0, i32 0
  %155 = load %struct.COORD*, %struct.COORD** %154, align 8
  %156 = getelementptr inbounds %struct.COORD, %struct.COORD* %155, i64 0, i32 1
  %157 = bitcast i32** %156 to i8**
  store i8* %150, i8** %157, align 8
  %158 = load %struct.stType**, %struct.stType*** @obj, align 8
  %159 = getelementptr inbounds %struct.stType*, %struct.stType** %158, i64 2
  %160 = load %struct.stType*, %struct.stType** %159, align 8
  %161 = getelementptr inbounds %struct.stType, %struct.stType* %160, i64 0, i32 0
  %162 = load %struct.COORD*, %struct.COORD** %161, align 8
  %163 = getelementptr inbounds %struct.COORD, %struct.COORD* %162, i64 0, i32 0
  %164 = load i32*, i32** %163, align 8
  store i32 11, i32* %164, align 4
  %165 = load %struct.stType**, %struct.stType*** @obj, align 8
  %166 = getelementptr inbounds %struct.stType*, %struct.stType** %165, i64 2
  %167 = load %struct.stType*, %struct.stType** %166, align 8
  %168 = getelementptr inbounds %struct.stType, %struct.stType* %167, i64 0, i32 0
  %169 = load %struct.COORD*, %struct.COORD** %168, align 8
  %170 = getelementptr inbounds %struct.COORD, %struct.COORD* %169, i64 0, i32 1
  %171 = load i32*, i32** %170, align 8
  store i32 12, i32* %171, align 4
  %172 = load %struct.stType**, %struct.stType*** @obj, align 8
  %173 = getelementptr inbounds %struct.stType*, %struct.stType** %172, i64 2
  %174 = load %struct.stType*, %struct.stType** %173, align 8
  %175 = getelementptr inbounds %struct.stType, %struct.stType* %174, i64 0, i32 2, i64 0
  store i32 13, i32* %175, align 4
  %176 = load %struct.stType**, %struct.stType*** @obj, align 8
  %177 = getelementptr inbounds %struct.stType*, %struct.stType** %176, i64 2
  %178 = load %struct.stType*, %struct.stType** %177, align 8
  %179 = getelementptr inbounds %struct.stType, %struct.stType* %178, i64 0, i32 2, i64 1
  store i32 14, i32* %179, align 4
  %180 = load %struct.stType**, %struct.stType*** @obj, align 8
  %181 = getelementptr inbounds %struct.stType*, %struct.stType** %180, i64 2
  %182 = load %struct.stType*, %struct.stType** %181, align 8
  %183 = getelementptr inbounds %struct.stType, %struct.stType* %182, i64 0, i32 2, i64 2
  store i32 15, i32* %183, align 4
  %184 = load %struct.stType**, %struct.stType*** @obj, align 8
  %185 = getelementptr inbounds %struct.stType*, %struct.stType** %184, i64 2
  %186 = load %struct.stType*, %struct.stType** %185, align 8
  %187 = getelementptr inbounds %struct.stType, %struct.stType* %186, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %187, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  %puts.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0)) #4
  %188 = load %struct.stType**, %struct.stType*** @obj, align 8
  %189 = load %struct.stType*, %struct.stType** %188, align 8
  %190 = getelementptr inbounds %struct.stType, %struct.stType* %189, i64 0, i32 2, i64 1
  %191 = load i32, i32* %190, align 4
  %192 = icmp eq i32 %191, 4
  br i1 %192, label %193, label %branchNotPruned_clone.exit

; <label>:193                                     ; preds = %101
  %194 = getelementptr inbounds %struct.stType*, %struct.stType** %188, i64 3
  %195 = load %struct.stType*, %struct.stType** %194, align 8
  %196 = getelementptr inbounds %struct.stType, %struct.stType* %195, i64 0, i32 0
  %197 = load %struct.COORD*, %struct.COORD** %196, align 8
  %198 = getelementptr inbounds %struct.COORD, %struct.COORD* %197, i64 0, i32 0
  %199 = load i32*, i32** %198, align 8
  %200 = load i32, i32* %199, align 4
  %201 = icmp eq i32 %200, 16
  br i1 %201, label %202, label %branchNotPruned_clone.exit

; <label>:202                                     ; preds = %193
  %203 = getelementptr inbounds %struct.COORD, %struct.COORD* %197, i64 0, i32 1
  %204 = load i32*, i32** %203, align 8
  %205 = load i32, i32* %204, align 4
  %206 = icmp eq i32 %205, 17
  br i1 %206, label %207, label %branchNotPruned_clone.exit

; <label>:207                                     ; preds = %202
  %208 = getelementptr inbounds %struct.stType, %struct.stType* %195, i64 0, i32 2, i64 1
  %209 = load i32, i32* %208, align 4
  %210 = icmp eq i32 %209, 19
  br i1 %210, label %211, label %branchNotPruned_clone.exit

; <label>:211                                     ; preds = %207
  %212 = getelementptr inbounds %struct.stType, %struct.stType* %195, i64 0, i32 1, i64 0
  %213 = tail call i32 @strcmp(i8* %212, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %214 = icmp eq i32 %213, 0
  br i1 %214, label %215, label %branchNotPruned_clone.exit

; <label>:215                                     ; preds = %211
  %216 = getelementptr inbounds %struct.stType, %struct.stType* %195, i64 0, i32 1, i64 4
  %217 = load i8, i8* %216, align 4
  %218 = icmp eq i8 %217, 111
  br i1 %218, label %219, label %branchNotPruned_clone.exit

; <label>:219                                     ; preds = %215
  %220 = getelementptr inbounds %struct.stType, %struct.stType* %195, i64 0, i32 1, i64 9
  %221 = load i8, i8* %220, align 1
  %222 = icmp eq i8 %221, 100
  br i1 %222, label %223, label %branchNotPruned_clone.exit

; <label>:223                                     ; preds = %219
  %puts.i1 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @str.3, i64 0, i64 0)) #4
  br label %branchNotPruned_clone.exit

branchNotPruned_clone.exit:                       ; preds = %101, %193, %202, %207, %211, %215, %219, %223
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind uwtable
define void @branchPruned_clone() #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone() #0 {
  %1 = load %struct.stType**, %struct.stType*** @obj, align 8
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 2, i64 1
  %4 = load i32, i32* %3, align 4
  %5 = icmp eq i32 %4, 4
  br i1 %5, label %6, label %37

; <label>:6                                       ; preds = %0
  %7 = getelementptr inbounds %struct.stType*, %struct.stType** %1, i64 3
  %8 = load %struct.stType*, %struct.stType** %7, align 8
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 0
  %10 = load %struct.COORD*, %struct.COORD** %9, align 8
  %11 = getelementptr inbounds %struct.COORD, %struct.COORD* %10, i64 0, i32 0
  %12 = load i32*, i32** %11, align 8
  %13 = load i32, i32* %12, align 4
  %14 = icmp eq i32 %13, 16
  br i1 %14, label %15, label %37

; <label>:15                                      ; preds = %6
  %16 = getelementptr inbounds %struct.COORD, %struct.COORD* %10, i64 0, i32 1
  %17 = load i32*, i32** %16, align 8
  %18 = load i32, i32* %17, align 4
  %19 = icmp eq i32 %18, 17
  br i1 %19, label %20, label %37

; <label>:20                                      ; preds = %15
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 2, i64 1
  %22 = load i32, i32* %21, align 4
  %23 = icmp eq i32 %22, 19
  br i1 %23, label %24, label %37

; <label>:24                                      ; preds = %20
  %25 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 0
  %26 = tail call i32 @strcmp(i8* %25, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %28, label %37

; <label>:28                                      ; preds = %24
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 4
  %30 = load i8, i8* %29, align 4
  %31 = icmp eq i8 %30, 111
  br i1 %31, label %32, label %37

; <label>:32                                      ; preds = %28
  %33 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0, i32 1, i64 9
  %34 = load i8, i8* %33, align 1
  %35 = icmp eq i8 %34, 100
  br i1 %35, label %36, label %37

; <label>:36                                      ; preds = %32
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @str.3, i64 0, i64 0))
  br label %37

; <label>:37                                      ; preds = %24, %36, %32, %28, %20, %15, %6, %0
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
