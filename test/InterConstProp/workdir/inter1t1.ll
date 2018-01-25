; ModuleID = 'workdir/inter1t1.bc'
source_filename = "inter1.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { i32, i32, i8* }

@.str = private unnamed_addr constant [12 x i8] c"helloworld0\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"helloworld1\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloworld2\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloworld3\00", align 1
@.str.4 = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@st = global [4 x %struct.stType] [%struct.stType { i32 0, i32 0, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0) }, %struct.stType { i32 1, i32 1, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0) }, %struct.stType { i32 2, i32 2, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0) }, %struct.stType { i32 3, i32 3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0) }], align 16

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType*) #0 {
  %2 = alloca %struct.stType*, align 8
  store %struct.stType* %0, %struct.stType** %2, align 8
  %3 = load %struct.stType*, %struct.stType** %2, align 8
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %3, i64 0
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %4, i32 0, i32 0
  %6 = load i32, i32* %5, align 8
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %80

; <label>:8:                                      ; preds = %1
  %9 = load %struct.stType*, %struct.stType** %2, align 8
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %9, i64 0
  %11 = getelementptr inbounds %struct.stType, %struct.stType* %10, i32 0, i32 1
  %12 = load i32, i32* %11, align 4
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %80

; <label>:14:                                     ; preds = %8
  %15 = load %struct.stType*, %struct.stType** %2, align 8
  %16 = getelementptr inbounds %struct.stType, %struct.stType* %15, i64 0
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %16, i32 0, i32 2
  %18 = load i8*, i8** %17, align 8
  %19 = call i32 @strcmp(i8* %18, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0)) #3
  %20 = icmp ne i32 %19, 0
  br i1 %20, label %80, label %21

; <label>:21:                                     ; preds = %14
  %22 = load %struct.stType*, %struct.stType** %2, align 8
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %22, i64 1
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %23, i32 0, i32 0
  %25 = load i32, i32* %24, align 8
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %80

; <label>:27:                                     ; preds = %21
  %28 = load %struct.stType*, %struct.stType** %2, align 8
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i64 1
  %30 = getelementptr inbounds %struct.stType, %struct.stType* %29, i32 0, i32 1
  %31 = load i32, i32* %30, align 4
  %32 = icmp eq i32 %31, 1
  br i1 %32, label %33, label %80

; <label>:33:                                     ; preds = %27
  %34 = load %struct.stType*, %struct.stType** %2, align 8
  %35 = getelementptr inbounds %struct.stType, %struct.stType* %34, i64 1
  %36 = getelementptr inbounds %struct.stType, %struct.stType* %35, i32 0, i32 2
  %37 = load i8*, i8** %36, align 8
  %38 = call i32 @strcmp(i8* %37, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0)) #3
  %39 = icmp ne i32 %38, 0
  br i1 %39, label %80, label %40

; <label>:40:                                     ; preds = %33
  %41 = load %struct.stType*, %struct.stType** %2, align 8
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %41, i64 2
  %43 = getelementptr inbounds %struct.stType, %struct.stType* %42, i32 0, i32 0
  %44 = load i32, i32* %43, align 8
  %45 = icmp eq i32 %44, 2
  br i1 %45, label %46, label %80

; <label>:46:                                     ; preds = %40
  %47 = load %struct.stType*, %struct.stType** %2, align 8
  %48 = getelementptr inbounds %struct.stType, %struct.stType* %47, i64 2
  %49 = getelementptr inbounds %struct.stType, %struct.stType* %48, i32 0, i32 1
  %50 = load i32, i32* %49, align 4
  %51 = icmp eq i32 %50, 2
  br i1 %51, label %52, label %80

; <label>:52:                                     ; preds = %46
  %53 = load %struct.stType*, %struct.stType** %2, align 8
  %54 = getelementptr inbounds %struct.stType, %struct.stType* %53, i64 2
  %55 = getelementptr inbounds %struct.stType, %struct.stType* %54, i32 0, i32 2
  %56 = load i8*, i8** %55, align 8
  %57 = call i32 @strcmp(i8* %56, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0)) #3
  %58 = icmp ne i32 %57, 0
  br i1 %58, label %80, label %59

; <label>:59:                                     ; preds = %52
  %60 = load %struct.stType*, %struct.stType** %2, align 8
  %61 = getelementptr inbounds %struct.stType, %struct.stType* %60, i64 3
  %62 = getelementptr inbounds %struct.stType, %struct.stType* %61, i32 0, i32 0
  %63 = load i32, i32* %62, align 8
  %64 = icmp eq i32 %63, 3
  br i1 %64, label %65, label %80

; <label>:65:                                     ; preds = %59
  %66 = load %struct.stType*, %struct.stType** %2, align 8
  %67 = getelementptr inbounds %struct.stType, %struct.stType* %66, i64 3
  %68 = getelementptr inbounds %struct.stType, %struct.stType* %67, i32 0, i32 1
  %69 = load i32, i32* %68, align 4
  %70 = icmp eq i32 %69, 3
  br i1 %70, label %71, label %80

; <label>:71:                                     ; preds = %65
  %72 = load %struct.stType*, %struct.stType** %2, align 8
  %73 = getelementptr inbounds %struct.stType, %struct.stType* %72, i64 3
  %74 = getelementptr inbounds %struct.stType, %struct.stType* %73, i32 0, i32 2
  %75 = load i8*, i8** %74, align 8
  %76 = call i32 @strcmp(i8* %75, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0)) #3
  %77 = icmp ne i32 %76, 0
  br i1 %77, label %80, label %78

; <label>:78:                                     ; preds = %71
  %79 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.4, i32 0, i32 0))
  br label %80

; <label>:80:                                     ; preds = %78, %71, %65, %59, %52, %46, %40, %33, %27, %21, %14, %8, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @branchPruned(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* @st, i32 0, i32 0))
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
