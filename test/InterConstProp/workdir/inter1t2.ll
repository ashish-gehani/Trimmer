; ModuleID = 'workdir/inter1t2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { i32, i32, i8* }

@.str = private unnamed_addr constant [12 x i8] c"helloworld0\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"helloworld1\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloworld2\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloworld3\00", align 1
@.str.4 = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@st = global [4 x %struct.stType] [%struct.stType { i32 0, i32 0, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0) }, %struct.stType { i32 1, i32 1, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0) }, %struct.stType { i32 2, i32 2, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0) }, %struct.stType { i32 3, i32 3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0) }], align 16
@0 = constant [12 x i8] c"helloworld0\00"
@1 = constant [12 x i8] c"helloworld1\00"
@2 = constant [12 x i8] c"helloworld2\00"
@3 = constant [12 x i8] c"helloworld3\00"

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
  %14 = call i32 @strcmp(i8* %13, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0)) #3
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
  %30 = call i32 @strcmp(i8* %29, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0)) #3
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
  %46 = call i32 @strcmp(i8* %45, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0)) #3
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
  %62 = call i32 @strcmp(i8* %61, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0)) #3
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
define i32 @main() #0 {
  call void @branchPruned_clone(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* @st, i32 0, i32 0))
  ret i32 0
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType* %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %1, i32 0, i32 0
  %3 = load i32, i32* %2, align 8
  %4 = icmp eq i32 0, 0
  br i1 %4, label %5, label %70

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 0, 0
  br i1 %9, label %10, label %70

; <label>:10                                      ; preds = %5
  %11 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 2
  %13 = load i8*, i8** %12, align 8
  %14 = getelementptr [12 x i8], [12 x i8]* @0, i64 0, i64 0
  %15 = call i32 @strcmp(i8* %14, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0)) #3
  %16 = icmp ne i32 0, 0
  br i1 %16, label %70, label %17

; <label>:17                                      ; preds = %10
  %18 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 1
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = icmp eq i32 1, 1
  br i1 %21, label %22, label %70

; <label>:22                                      ; preds = %17
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 1
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %23, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = icmp eq i32 1, 1
  br i1 %26, label %27, label %70

; <label>:27                                      ; preds = %22
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 1
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i32 0, i32 2
  %30 = load i8*, i8** %29, align 8
  %31 = getelementptr [12 x i8], [12 x i8]* @1, i64 0, i64 0
  %32 = call i32 @strcmp(i8* %31, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0)) #3
  %33 = icmp ne i32 0, 0
  br i1 %33, label %70, label %34

; <label>:34                                      ; preds = %27
  %35 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 2
  %36 = getelementptr inbounds %struct.stType, %struct.stType* %35, i32 0, i32 0
  %37 = load i32, i32* %36, align 8
  %38 = icmp eq i32 2, 2
  br i1 %38, label %39, label %70

; <label>:39                                      ; preds = %34
  %40 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 2
  %41 = getelementptr inbounds %struct.stType, %struct.stType* %40, i32 0, i32 1
  %42 = load i32, i32* %41, align 4
  %43 = icmp eq i32 2, 2
  br i1 %43, label %44, label %70

; <label>:44                                      ; preds = %39
  %45 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 2
  %46 = getelementptr inbounds %struct.stType, %struct.stType* %45, i32 0, i32 2
  %47 = load i8*, i8** %46, align 8
  %48 = getelementptr [12 x i8], [12 x i8]* @2, i64 0, i64 0
  %49 = call i32 @strcmp(i8* %48, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0)) #3
  %50 = icmp ne i32 0, 0
  br i1 %50, label %70, label %51

; <label>:51                                      ; preds = %44
  %52 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 3
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %52, i32 0, i32 0
  %54 = load i32, i32* %53, align 8
  %55 = icmp eq i32 3, 3
  br i1 %55, label %56, label %70

; <label>:56                                      ; preds = %51
  %57 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 3
  %58 = getelementptr inbounds %struct.stType, %struct.stType* %57, i32 0, i32 1
  %59 = load i32, i32* %58, align 4
  %60 = icmp eq i32 3, 3
  br i1 %60, label %61, label %70

; <label>:61                                      ; preds = %56
  %62 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 3
  %63 = getelementptr inbounds %struct.stType, %struct.stType* %62, i32 0, i32 2
  %64 = load i8*, i8** %63, align 8
  %65 = getelementptr [12 x i8], [12 x i8]* @3, i64 0, i64 0
  %66 = call i32 @strcmp(i8* %65, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0)) #3
  %67 = icmp ne i32 0, 0
  br i1 %67, label %70, label %68

; <label>:68                                      ; preds = %61
  %69 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.4, i32 0, i32 0))
  br label %70

; <label>:70                                      ; preds = %68, %61, %56, %51, %44, %39, %34, %27, %22, %17, %10, %5, %0
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
