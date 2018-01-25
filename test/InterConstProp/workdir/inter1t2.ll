; ModuleID = 'workdir/inter1t2.bc'
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
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i32 0, i32 0
  %4 = load i32, i32* %3, align 8
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %67

; <label>:6:                                      ; preds = %1
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %7, i32 0, i32 1
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %67

; <label>:11:                                     ; preds = %6
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0
  %13 = getelementptr inbounds %struct.stType, %struct.stType* %12, i32 0, i32 2
  %14 = load i8*, i8** %13, align 8
  %15 = call i32 @strcmp(i8* %14, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0)) #3
  %16 = icmp ne i32 %15, 0
  br i1 %16, label %67, label %17

; <label>:17:                                     ; preds = %11
  %18 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 1
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = icmp eq i32 %20, 1
  br i1 %21, label %22, label %67

; <label>:22:                                     ; preds = %17
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 1
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %23, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %67

; <label>:27:                                     ; preds = %22
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 1
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i32 0, i32 2
  %30 = load i8*, i8** %29, align 8
  %31 = call i32 @strcmp(i8* %30, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0)) #3
  %32 = icmp ne i32 %31, 0
  br i1 %32, label %67, label %33

; <label>:33:                                     ; preds = %27
  %34 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 2
  %35 = getelementptr inbounds %struct.stType, %struct.stType* %34, i32 0, i32 0
  %36 = load i32, i32* %35, align 8
  %37 = icmp eq i32 %36, 2
  br i1 %37, label %38, label %67

; <label>:38:                                     ; preds = %33
  %39 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 2
  %40 = getelementptr inbounds %struct.stType, %struct.stType* %39, i32 0, i32 1
  %41 = load i32, i32* %40, align 4
  %42 = icmp eq i32 %41, 2
  br i1 %42, label %43, label %67

; <label>:43:                                     ; preds = %38
  %44 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 2
  %45 = getelementptr inbounds %struct.stType, %struct.stType* %44, i32 0, i32 2
  %46 = load i8*, i8** %45, align 8
  %47 = call i32 @strcmp(i8* %46, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0)) #3
  %48 = icmp ne i32 %47, 0
  br i1 %48, label %67, label %49

; <label>:49:                                     ; preds = %43
  %50 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 3
  %51 = getelementptr inbounds %struct.stType, %struct.stType* %50, i32 0, i32 0
  %52 = load i32, i32* %51, align 8
  %53 = icmp eq i32 %52, 3
  br i1 %53, label %54, label %67

; <label>:54:                                     ; preds = %49
  %55 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 3
  %56 = getelementptr inbounds %struct.stType, %struct.stType* %55, i32 0, i32 1
  %57 = load i32, i32* %56, align 4
  %58 = icmp eq i32 %57, 3
  br i1 %58, label %59, label %67

; <label>:59:                                     ; preds = %54
  %60 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 3
  %61 = getelementptr inbounds %struct.stType, %struct.stType* %60, i32 0, i32 2
  %62 = load i8*, i8** %61, align 8
  %63 = call i32 @strcmp(i8* %62, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0)) #3
  %64 = icmp ne i32 %63, 0
  br i1 %64, label %67, label %65

; <label>:65:                                     ; preds = %59
  %66 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.4, i32 0, i32 0))
  br label %67

; <label>:67:                                     ; preds = %65, %59, %54, %49, %43, %38, %33, %27, %22, %17, %11, %6, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  call void @branchPruned(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* @st, i32 0, i32 0))
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
