; ModuleID = 'workdir/inter22t3.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { i32, i32, i8*, {}* }

@.str = private unnamed_addr constant [12 x i8] c"helloworld0\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"helloworld1\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloworld2\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloworld3\00", align 1
@.str.4 = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@st = global <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }> <{ { i32, i32, i8*, void (%struct.stType*)* } { i32 0, i32 0, i8* null, void (%struct.stType*)* @init0 }, { i32, i32, i8*, void (%struct.stType*)* } { i32 0, i32 0, i8* null, void (%struct.stType*)* @init1 }, { i32, i32, i8*, void (%struct.stType*)* } { i32 0, i32 0, i8* null, void (%struct.stType*)* @init2 }, { i32, i32, i8*, void (%struct.stType*)* } { i32 0, i32 0, i8* null, void (%struct.stType*)* @init3 } }>, align 16
@0 = constant [12 x i8] c"helloworld0\00"
@1 = constant [12 x i8] c"helloworld0\00"
@2 = constant [12 x i8] c"helloworld1\00"
@3 = constant [12 x i8] c"helloworld1\00"
@4 = constant [12 x i8] c"helloworld2\00"
@5 = constant [12 x i8] c"helloworld2\00"
@6 = constant [12 x i8] c"helloworld3\00"
@7 = constant [12 x i8] c"helloworld3\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType* %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %1, i32 0, i32 0
  %3 = load i32, i32* %2, align 8
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %66

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %10, label %66

; <label>:10                                      ; preds = %5
  %11 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 2
  %13 = load i8*, i8** %12, align 8
  %14 = call i32 @strcmp(i8* %13, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0)) #5
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %66, label %16

; <label>:16                                      ; preds = %10
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 1
  %18 = getelementptr inbounds %struct.stType, %struct.stType* %17, i32 0, i32 0
  %19 = load i32, i32* %18, align 8
  %20 = icmp eq i32 %19, 1
  br i1 %20, label %21, label %66

; <label>:21                                      ; preds = %16
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 1
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %22, i32 0, i32 1
  %24 = load i32, i32* %23, align 4
  %25 = icmp eq i32 %24, 1
  br i1 %25, label %26, label %66

; <label>:26                                      ; preds = %21
  %27 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 1
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i32 0, i32 2
  %29 = load i8*, i8** %28, align 8
  %30 = call i32 @strcmp(i8* %29, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0)) #5
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %66, label %32

; <label>:32                                      ; preds = %26
  %33 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 2
  %34 = getelementptr inbounds %struct.stType, %struct.stType* %33, i32 0, i32 0
  %35 = load i32, i32* %34, align 8
  %36 = icmp eq i32 %35, 2
  br i1 %36, label %37, label %66

; <label>:37                                      ; preds = %32
  %38 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 2
  %39 = getelementptr inbounds %struct.stType, %struct.stType* %38, i32 0, i32 1
  %40 = load i32, i32* %39, align 4
  %41 = icmp eq i32 %40, 2
  br i1 %41, label %42, label %66

; <label>:42                                      ; preds = %37
  %43 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 2
  %44 = getelementptr inbounds %struct.stType, %struct.stType* %43, i32 0, i32 2
  %45 = load i8*, i8** %44, align 8
  %46 = call i32 @strcmp(i8* %45, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0)) #5
  %47 = icmp ne i32 %46, 0
  br i1 %47, label %66, label %48

; <label>:48                                      ; preds = %42
  %49 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 3
  %50 = getelementptr inbounds %struct.stType, %struct.stType* %49, i32 0, i32 0
  %51 = load i32, i32* %50, align 8
  %52 = icmp eq i32 %51, 3
  br i1 %52, label %53, label %66

; <label>:53                                      ; preds = %48
  %54 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 3
  %55 = getelementptr inbounds %struct.stType, %struct.stType* %54, i32 0, i32 1
  %56 = load i32, i32* %55, align 4
  %57 = icmp eq i32 %56, 3
  br i1 %57, label %58, label %66

; <label>:58                                      ; preds = %53
  %59 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 3
  %60 = getelementptr inbounds %struct.stType, %struct.stType* %59, i32 0, i32 2
  %61 = load i8*, i8** %60, align 8
  %62 = call i32 @strcmp(i8* %61, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0)) #5
  %63 = icmp ne i32 %62, 0
  br i1 %63, label %66, label %64

; <label>:64                                      ; preds = %58
  %65 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.4, i32 0, i32 0))
  br label %66

; <label>:66                                      ; preds = %64, %58, %53, %48, %42, %37, %32, %26, %21, %16, %10, %5, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define void @init0(%struct.stType* %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  store i32 0, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  store i32 0, i32* %2, align 4
  %3 = call noalias i8* @malloc(i64 100) #6
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  store i8* %3, i8** %4, align 8
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %6 = load i8*, i8** %5, align 8
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 100, i32 1, i1 false)
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %8 = load i8*, i8** %7, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #4

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #4

; Function Attrs: nounwind uwtable
define void @init1(%struct.stType* %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  store i32 1, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  store i32 1, i32* %2, align 4
  %3 = call noalias i8* @malloc(i64 100) #6
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  store i8* %3, i8** %4, align 8
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %6 = load i8*, i8** %5, align 8
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 100, i32 1, i1 false)
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %8 = load i8*, i8** %7, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @init2(%struct.stType* %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  store i32 2, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  store i32 2, i32* %2, align 4
  %3 = call noalias i8* @malloc(i64 100) #6
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  store i8* %3, i8** %4, align 8
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %6 = load i8*, i8** %5, align 8
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 100, i32 1, i1 false)
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %8 = load i8*, i8** %7, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @init3(%struct.stType* %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  store i32 3, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  store i32 3, i32* %2, align 4
  %3 = call noalias i8* @malloc(i64 100) #6
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  store i8* %3, i8** %4, align 8
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %6 = load i8*, i8** %5, align 8
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 100, i32 1, i1 false)
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %8 = load i8*, i8** %7, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = load void (%struct.stType*)*, void (%struct.stType*)** bitcast ({}** getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* bitcast (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st to [4 x %struct.stType]*), i64 0, i64 0, i32 3) to void (%struct.stType*)**), align 16
  call void @init0_clone(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* bitcast (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st to [4 x %struct.stType]*), i64 0, i64 0))
  %2 = load void (%struct.stType*)*, void (%struct.stType*)** bitcast ({}** getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* bitcast (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st to [4 x %struct.stType]*), i64 0, i64 1, i32 3) to void (%struct.stType*)**), align 8
  call void @init1_clone(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* bitcast (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st to [4 x %struct.stType]*), i64 0, i64 1))
  %3 = load void (%struct.stType*)*, void (%struct.stType*)** bitcast ({}** getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* bitcast (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st to [4 x %struct.stType]*), i64 0, i64 2, i32 3) to void (%struct.stType*)**), align 16
  call void @init2_clone(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* bitcast (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st to [4 x %struct.stType]*), i64 0, i64 2))
  %4 = load void (%struct.stType*)*, void (%struct.stType*)** bitcast ({}** getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* bitcast (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st to [4 x %struct.stType]*), i64 0, i64 3, i32 3) to void (%struct.stType*)**), align 8
  call void @init3_clone(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* bitcast (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st to [4 x %struct.stType]*), i64 0, i64 3))
  call void @branchPruned_clone(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* bitcast (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st to [4 x %struct.stType]*), i32 0, i32 0))
  ret i32 0
}

; Function Attrs: nounwind uwtable
define void @init0_clone(%struct.stType* %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  store i32 0, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  store i32 0, i32* %2, align 4
  %3 = call noalias i8* @malloc(i64 100) #6
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  store i8* %3, i8** %4, align 8
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %6 = load i8*, i8** %5, align 8
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 100, i32 1, i1 false)
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %8 = load i8*, i8** %7, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @init1_clone(%struct.stType* %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  store i32 1, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  store i32 1, i32* %2, align 4
  %3 = call noalias i8* @malloc(i64 100) #6
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  store i8* %3, i8** %4, align 8
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %6 = load i8*, i8** %5, align 8
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 100, i32 1, i1 false)
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %8 = load i8*, i8** %7, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @init2_clone(%struct.stType* %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  store i32 2, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  store i32 2, i32* %2, align 4
  %3 = call noalias i8* @malloc(i64 100) #6
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  store i8* %3, i8** %4, align 8
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %6 = load i8*, i8** %5, align 8
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 100, i32 1, i1 false)
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %8 = load i8*, i8** %7, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @init3_clone(%struct.stType* %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  store i32 3, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  store i32 3, i32* %2, align 4
  %3 = call noalias i8* @malloc(i64 100) #6
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  store i8* %3, i8** %4, align 8
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %6 = load i8*, i8** %5, align 8
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 100, i32 1, i1 false)
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 2
  %8 = load i8*, i8** %7, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType* %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %1, i32 0, i32 0
  %3 = load i32, i32* %2, align 8
  %4 = icmp eq i32 0, 0
  br i1 true, label %5, label %74

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 0, 0
  br i1 true, label %10, label %74

; <label>:10                                      ; preds = %5
  %11 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 2
  %13 = load i8*, i8** %12, align 8
  %14 = getelementptr [12 x i8], [12 x i8]* @0, i64 0, i64 0
  %15 = getelementptr [12 x i8], [12 x i8]* @1, i64 0, i64 0
  %16 = call i32 @strcmp(i8* %14, i8* %15) #5
  %17 = icmp ne i32 0, 0
  br i1 false, label %74, label %18

; <label>:18                                      ; preds = %10
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 1
  %20 = getelementptr inbounds %struct.stType, %struct.stType* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = icmp eq i32 1, 1
  br i1 true, label %23, label %74

; <label>:23                                      ; preds = %18
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 1
  %25 = getelementptr inbounds %struct.stType, %struct.stType* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 4
  %27 = icmp eq i32 1, 1
  br i1 true, label %28, label %74

; <label>:28                                      ; preds = %23
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 1
  %30 = getelementptr inbounds %struct.stType, %struct.stType* %29, i32 0, i32 2
  %31 = load i8*, i8** %30, align 8
  %32 = getelementptr [12 x i8], [12 x i8]* @2, i64 0, i64 0
  %33 = getelementptr [12 x i8], [12 x i8]* @3, i64 0, i64 0
  %34 = call i32 @strcmp(i8* %32, i8* %33) #5
  %35 = icmp ne i32 0, 0
  br i1 false, label %74, label %36

; <label>:36                                      ; preds = %28
  %37 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 2
  %38 = getelementptr inbounds %struct.stType, %struct.stType* %37, i32 0, i32 0
  %39 = load i32, i32* %38, align 8
  %40 = icmp eq i32 2, 2
  br i1 true, label %41, label %74

; <label>:41                                      ; preds = %36
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 2
  %43 = getelementptr inbounds %struct.stType, %struct.stType* %42, i32 0, i32 1
  %44 = load i32, i32* %43, align 4
  %45 = icmp eq i32 2, 2
  br i1 true, label %46, label %74

; <label>:46                                      ; preds = %41
  %47 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 2
  %48 = getelementptr inbounds %struct.stType, %struct.stType* %47, i32 0, i32 2
  %49 = load i8*, i8** %48, align 8
  %50 = getelementptr [12 x i8], [12 x i8]* @4, i64 0, i64 0
  %51 = getelementptr [12 x i8], [12 x i8]* @5, i64 0, i64 0
  %52 = call i32 @strcmp(i8* %50, i8* %51) #5
  %53 = icmp ne i32 0, 0
  br i1 false, label %74, label %54

; <label>:54                                      ; preds = %46
  %55 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 3
  %56 = getelementptr inbounds %struct.stType, %struct.stType* %55, i32 0, i32 0
  %57 = load i32, i32* %56, align 8
  %58 = icmp eq i32 3, 3
  br i1 true, label %59, label %74

; <label>:59                                      ; preds = %54
  %60 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 3
  %61 = getelementptr inbounds %struct.stType, %struct.stType* %60, i32 0, i32 1
  %62 = load i32, i32* %61, align 4
  %63 = icmp eq i32 3, 3
  br i1 true, label %64, label %74

; <label>:64                                      ; preds = %59
  %65 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 3
  %66 = getelementptr inbounds %struct.stType, %struct.stType* %65, i32 0, i32 2
  %67 = load i8*, i8** %66, align 8
  %68 = getelementptr [12 x i8], [12 x i8]* @6, i64 0, i64 0
  %69 = getelementptr [12 x i8], [12 x i8]* @7, i64 0, i64 0
  %70 = call i32 @strcmp(i8* %68, i8* %69) #5
  %71 = icmp ne i32 0, 0
  br i1 false, label %74, label %72

; <label>:72                                      ; preds = %64
  %73 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.4, i32 0, i32 0))
  br label %74

; <label>:74                                      ; preds = %72, %64, %59, %54, %46, %41, %36, %28, %23, %18, %10, %5, %0
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
