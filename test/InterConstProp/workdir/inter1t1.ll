; ModuleID = 'workdir/inter1t1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { i32, i32, i8* }

@.str = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"helloworld0\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloworld1\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloworld2\00", align 1
@.str.4 = private unnamed_addr constant [12 x i8] c"helloworld3\00", align 1
@st = global [4 x %struct.stType] [%struct.stType { i32 0, i32 0, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0) }, %struct.stType { i32 1, i32 1, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0) }, %struct.stType { i32 2, i32 2, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0) }, %struct.stType { i32 3, i32 3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.4, i32 0, i32 0) }], align 16

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType* %st, i8* %str0, i8* %str1, i8* %str2, i8* %str3) #0 {
  %1 = alloca %struct.stType*, align 8
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  store %struct.stType* %st, %struct.stType** %1, align 8
  store i8* %str0, i8** %2, align 8
  store i8* %str1, i8** %3, align 8
  store i8* %str2, i8** %4, align 8
  store i8* %str3, i8** %5, align 8
  %6 = load %struct.stType*, %struct.stType** %1, align 8
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %6, i64 0
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %7, i32 0, i32 0
  %9 = load i32, i32* %8, align 8
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %87

; <label>:11                                      ; preds = %0
  %12 = load %struct.stType*, %struct.stType** %1, align 8
  %13 = getelementptr inbounds %struct.stType, %struct.stType* %12, i64 0
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %13, i32 0, i32 1
  %15 = load i32, i32* %14, align 4
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %87

; <label>:17                                      ; preds = %11
  %18 = load %struct.stType*, %struct.stType** %1, align 8
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %18, i64 0
  %20 = getelementptr inbounds %struct.stType, %struct.stType* %19, i32 0, i32 2
  %21 = load i8*, i8** %20, align 8
  %22 = load i8*, i8** %2, align 8
  %23 = call i32 @strcmp(i8* %21, i8* %22) #3
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %87, label %25

; <label>:25                                      ; preds = %17
  %26 = load %struct.stType*, %struct.stType** %1, align 8
  %27 = getelementptr inbounds %struct.stType, %struct.stType* %26, i64 1
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i32 0, i32 0
  %29 = load i32, i32* %28, align 8
  %30 = icmp eq i32 %29, 1
  br i1 %30, label %31, label %87

; <label>:31                                      ; preds = %25
  %32 = load %struct.stType*, %struct.stType** %1, align 8
  %33 = getelementptr inbounds %struct.stType, %struct.stType* %32, i64 1
  %34 = getelementptr inbounds %struct.stType, %struct.stType* %33, i32 0, i32 1
  %35 = load i32, i32* %34, align 4
  %36 = icmp eq i32 %35, 1
  br i1 %36, label %37, label %87

; <label>:37                                      ; preds = %31
  %38 = load %struct.stType*, %struct.stType** %1, align 8
  %39 = getelementptr inbounds %struct.stType, %struct.stType* %38, i64 1
  %40 = getelementptr inbounds %struct.stType, %struct.stType* %39, i32 0, i32 2
  %41 = load i8*, i8** %40, align 8
  %42 = load i8*, i8** %3, align 8
  %43 = call i32 @strcmp(i8* %41, i8* %42) #3
  %44 = icmp ne i32 %43, 0
  br i1 %44, label %87, label %45

; <label>:45                                      ; preds = %37
  %46 = load %struct.stType*, %struct.stType** %1, align 8
  %47 = getelementptr inbounds %struct.stType, %struct.stType* %46, i64 2
  %48 = getelementptr inbounds %struct.stType, %struct.stType* %47, i32 0, i32 0
  %49 = load i32, i32* %48, align 8
  %50 = icmp eq i32 %49, 2
  br i1 %50, label %51, label %87

; <label>:51                                      ; preds = %45
  %52 = load %struct.stType*, %struct.stType** %1, align 8
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %52, i64 2
  %54 = getelementptr inbounds %struct.stType, %struct.stType* %53, i32 0, i32 1
  %55 = load i32, i32* %54, align 4
  %56 = icmp eq i32 %55, 2
  br i1 %56, label %57, label %87

; <label>:57                                      ; preds = %51
  %58 = load %struct.stType*, %struct.stType** %1, align 8
  %59 = getelementptr inbounds %struct.stType, %struct.stType* %58, i64 2
  %60 = getelementptr inbounds %struct.stType, %struct.stType* %59, i32 0, i32 2
  %61 = load i8*, i8** %60, align 8
  %62 = load i8*, i8** %4, align 8
  %63 = call i32 @strcmp(i8* %61, i8* %62) #3
  %64 = icmp ne i32 %63, 0
  br i1 %64, label %87, label %65

; <label>:65                                      ; preds = %57
  %66 = load %struct.stType*, %struct.stType** %1, align 8
  %67 = getelementptr inbounds %struct.stType, %struct.stType* %66, i64 3
  %68 = getelementptr inbounds %struct.stType, %struct.stType* %67, i32 0, i32 0
  %69 = load i32, i32* %68, align 8
  %70 = icmp eq i32 %69, 3
  br i1 %70, label %71, label %87

; <label>:71                                      ; preds = %65
  %72 = load %struct.stType*, %struct.stType** %1, align 8
  %73 = getelementptr inbounds %struct.stType, %struct.stType* %72, i64 3
  %74 = getelementptr inbounds %struct.stType, %struct.stType* %73, i32 0, i32 1
  %75 = load i32, i32* %74, align 4
  %76 = icmp eq i32 %75, 3
  br i1 %76, label %77, label %87

; <label>:77                                      ; preds = %71
  %78 = load %struct.stType*, %struct.stType** %1, align 8
  %79 = getelementptr inbounds %struct.stType, %struct.stType* %78, i64 3
  %80 = getelementptr inbounds %struct.stType, %struct.stType* %79, i32 0, i32 2
  %81 = load i8*, i8** %80, align 8
  %82 = load i8*, i8** %5, align 8
  %83 = call i32 @strcmp(i8* %81, i8* %82) #3
  %84 = icmp ne i32 %83, 0
  br i1 %84, label %87, label %85

; <label>:85                                      ; preds = %77
  %86 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i32 0, i32 0))
  br label %87

; <label>:87                                      ; preds = %85, %77, %71, %65, %57, %51, %45, %37, %31, %25, %17, %11, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @branchPruned(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* @st, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.4, i32 0, i32 0))
  ret i32 0
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
