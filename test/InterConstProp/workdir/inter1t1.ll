; ModuleID = 'workdir/inter1t1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { i32, i32, i8* }

@.str = private unnamed_addr constant [12 x i8] c"helloworld0\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"helloworld1\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloworld2\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloworld3\00", align 1
@.str.4 = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@st = global [4 x %struct.stType] [%struct.stType { i32 0, i32 0, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0) }, %struct.stType { i32 1, i32 1, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0) }, %struct.stType { i32 2, i32 2, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0) }, %struct.stType { i32 3, i32 3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0) }], align 16

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType* %st) #0 {
  %1 = alloca %struct.stType*, align 8
  store %struct.stType* %st, %struct.stType** %1, align 8
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 0
  %5 = load i32, i32* %4, align 8
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %79

; <label>:7                                       ; preds = %0
  %8 = load %struct.stType*, %struct.stType** %1, align 8
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %8, i64 0
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %9, i32 0, i32 1
  %11 = load i32, i32* %10, align 4
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %79

; <label>:13                                      ; preds = %7
  %14 = load %struct.stType*, %struct.stType** %1, align 8
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %14, i64 0
  %16 = getelementptr inbounds %struct.stType, %struct.stType* %15, i32 0, i32 2
  %17 = load i8*, i8** %16, align 8
  %18 = call i32 @strcmp(i8* %17, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0)) #3
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %79, label %20

; <label>:20                                      ; preds = %13
  %21 = load %struct.stType*, %struct.stType** %1, align 8
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %21, i64 1
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %22, i32 0, i32 0
  %24 = load i32, i32* %23, align 8
  %25 = icmp eq i32 %24, 1
  br i1 %25, label %26, label %79

; <label>:26                                      ; preds = %20
  %27 = load %struct.stType*, %struct.stType** %1, align 8
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i64 1
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i32 0, i32 1
  %30 = load i32, i32* %29, align 4
  %31 = icmp eq i32 %30, 1
  br i1 %31, label %32, label %79

; <label>:32                                      ; preds = %26
  %33 = load %struct.stType*, %struct.stType** %1, align 8
  %34 = getelementptr inbounds %struct.stType, %struct.stType* %33, i64 1
  %35 = getelementptr inbounds %struct.stType, %struct.stType* %34, i32 0, i32 2
  %36 = load i8*, i8** %35, align 8
  %37 = call i32 @strcmp(i8* %36, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0)) #3
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %79, label %39

; <label>:39                                      ; preds = %32
  %40 = load %struct.stType*, %struct.stType** %1, align 8
  %41 = getelementptr inbounds %struct.stType, %struct.stType* %40, i64 2
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %41, i32 0, i32 0
  %43 = load i32, i32* %42, align 8
  %44 = icmp eq i32 %43, 2
  br i1 %44, label %45, label %79

; <label>:45                                      ; preds = %39
  %46 = load %struct.stType*, %struct.stType** %1, align 8
  %47 = getelementptr inbounds %struct.stType, %struct.stType* %46, i64 2
  %48 = getelementptr inbounds %struct.stType, %struct.stType* %47, i32 0, i32 1
  %49 = load i32, i32* %48, align 4
  %50 = icmp eq i32 %49, 2
  br i1 %50, label %51, label %79

; <label>:51                                      ; preds = %45
  %52 = load %struct.stType*, %struct.stType** %1, align 8
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %52, i64 2
  %54 = getelementptr inbounds %struct.stType, %struct.stType* %53, i32 0, i32 2
  %55 = load i8*, i8** %54, align 8
  %56 = call i32 @strcmp(i8* %55, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0)) #3
  %57 = icmp ne i32 %56, 0
  br i1 %57, label %79, label %58

; <label>:58                                      ; preds = %51
  %59 = load %struct.stType*, %struct.stType** %1, align 8
  %60 = getelementptr inbounds %struct.stType, %struct.stType* %59, i64 3
  %61 = getelementptr inbounds %struct.stType, %struct.stType* %60, i32 0, i32 0
  %62 = load i32, i32* %61, align 8
  %63 = icmp eq i32 %62, 3
  br i1 %63, label %64, label %79

; <label>:64                                      ; preds = %58
  %65 = load %struct.stType*, %struct.stType** %1, align 8
  %66 = getelementptr inbounds %struct.stType, %struct.stType* %65, i64 3
  %67 = getelementptr inbounds %struct.stType, %struct.stType* %66, i32 0, i32 1
  %68 = load i32, i32* %67, align 4
  %69 = icmp eq i32 %68, 3
  br i1 %69, label %70, label %79

; <label>:70                                      ; preds = %64
  %71 = load %struct.stType*, %struct.stType** %1, align 8
  %72 = getelementptr inbounds %struct.stType, %struct.stType* %71, i64 3
  %73 = getelementptr inbounds %struct.stType, %struct.stType* %72, i32 0, i32 2
  %74 = load i8*, i8** %73, align 8
  %75 = call i32 @strcmp(i8* %74, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0)) #3
  %76 = icmp ne i32 %75, 0
  br i1 %76, label %79, label %77

; <label>:77                                      ; preds = %70
  %78 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.4, i32 0, i32 0))
  br label %79

; <label>:79                                      ; preds = %77, %70, %64, %58, %51, %45, %39, %32, %26, %20, %13, %7, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @branchPruned(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* @st, i32 0, i32 0))
  ret i32 0
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
