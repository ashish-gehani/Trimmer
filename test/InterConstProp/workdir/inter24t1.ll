; ModuleID = 'workdir/inter24t1.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { i32, i32, i8* }

@st = global [4 x %struct.stType] [%struct.stType { i32 0, i32 0, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0) }, %struct.stType { i32 1, i32 1, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0) }, %struct.stType { i32 2, i32 2, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.4, i32 0, i32 0) }, %struct.stType { i32 3, i32 3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i32 0, i32 0) }], align 16
@.str.2 = private unnamed_addr constant [12 x i8] c"helloworld0\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloworld1\00", align 1
@.str.4 = private unnamed_addr constant [12 x i8] c"helloworld2\00", align 1
@.str.5 = private unnamed_addr constant [12 x i8] c"helloworld3\00", align 1
@.str = private unnamed_addr constant [11 x i8] c"helloworld\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType*) #0 {
  %2 = alloca %struct.stType*, align 8
  %3 = alloca i8, align 1
  %4 = alloca [11 x i8], align 1
  %5 = alloca i32, align 4
  store %struct.stType* %0, %struct.stType** %2, align 8
  store i8 1, i8* %3, align 1
  %6 = getelementptr inbounds [11 x i8], [11 x i8]* %4, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0), i64 10, i32 1, i1 false)
  store i32 0, i32* %5, align 4
  br label %7

; <label>:7:                                      ; preds = %44, %1
  %8 = load i32, i32* %5, align 4
  %9 = icmp ult i32 %8, 4
  br i1 %9, label %10, label %47

; <label>:10:                                     ; preds = %7
  %11 = load i32, i32* %5, align 4
  %12 = add i32 %11, 48
  %13 = trunc i32 %12 to i8
  %14 = getelementptr inbounds [11 x i8], [11 x i8]* %4, i64 0, i64 10
  store i8 %13, i8* %14, align 1
  %15 = load %struct.stType*, %struct.stType** %2, align 8
  %16 = load i32, i32* %5, align 4
  %17 = zext i32 %16 to i64
  %18 = getelementptr inbounds %struct.stType, %struct.stType* %15, i64 %17
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = load i32, i32* %5, align 4
  %22 = icmp ne i32 %20, %21
  br i1 %22, label %42, label %23

; <label>:23:                                     ; preds = %10
  %24 = load %struct.stType*, %struct.stType** %2, align 8
  %25 = load i32, i32* %5, align 4
  %26 = zext i32 %25 to i64
  %27 = getelementptr inbounds %struct.stType, %struct.stType* %24, i64 %26
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i32 0, i32 1
  %29 = load i32, i32* %28, align 4
  %30 = load i32, i32* %5, align 4
  %31 = icmp ne i32 %29, %30
  br i1 %31, label %42, label %32

; <label>:32:                                     ; preds = %23
  %33 = getelementptr inbounds [11 x i8], [11 x i8]* %4, i32 0, i32 0
  %34 = load %struct.stType*, %struct.stType** %2, align 8
  %35 = load i32, i32* %5, align 4
  %36 = zext i32 %35 to i64
  %37 = getelementptr inbounds %struct.stType, %struct.stType* %34, i64 %36
  %38 = getelementptr inbounds %struct.stType, %struct.stType* %37, i32 0, i32 2
  %39 = load i8*, i8** %38, align 8
  %40 = call i32 @strcmp(i8* %33, i8* %39) #4
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %42, label %43

; <label>:42:                                     ; preds = %32, %23, %10
  store i8 0, i8* %3, align 1
  br label %43

; <label>:43:                                     ; preds = %42, %32
  br label %44

; <label>:44:                                     ; preds = %43
  %45 = load i32, i32* %5, align 4
  %46 = add i32 %45, 1
  store i32 %46, i32* %5, align 4
  br label %7

; <label>:47:                                     ; preds = %7
  %48 = load i8, i8* %3, align 1
  %49 = icmp ne i8 %48, 0
  br i1 %49, label %50, label %52

; <label>:50:                                     ; preds = %47
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i32 0, i32 0))
  br label %52

; <label>:52:                                     ; preds = %50, %47
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

declare i32 @printf(i8*, ...) #3

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @branchPruned(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* @st, i32 0, i32 0))
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
