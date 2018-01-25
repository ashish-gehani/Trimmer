; ModuleID = 'workdir/inter28t1.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Node = type { i32, i8*, %struct.Node* }

@.str = private unnamed_addr constant [15 x i8] c"condition true\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.Node*) #0 {
  %2 = alloca %struct.Node*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i8, align 1
  %5 = alloca [11 x i8], align 1
  %6 = alloca %struct.Node*, align 8
  %7 = alloca i32, align 4
  store %struct.Node* %0, %struct.Node** %2, align 8
  store i32 1, i32* %3, align 4
  store i8 1, i8* %4, align 1
  %8 = getelementptr inbounds [11 x i8], [11 x i8]* %5, i64 0, i64 10
  store i8 0, i8* %8, align 1
  %9 = getelementptr inbounds [11 x i8], [11 x i8]* %5, i32 0, i32 0
  call void @llvm.memset.p0i8.i64(i8* %9, i8 0, i64 11, i32 1, i1 false)
  %10 = load %struct.Node*, %struct.Node** %2, align 8
  store %struct.Node* %10, %struct.Node** %6, align 8
  br label %11

; <label>:11:                                     ; preds = %47, %1
  %12 = load %struct.Node*, %struct.Node** %6, align 8
  %13 = icmp ne %struct.Node* %12, null
  br i1 %13, label %14, label %53

; <label>:14:                                     ; preds = %11
  %15 = load %struct.Node*, %struct.Node** %6, align 8
  %16 = getelementptr inbounds %struct.Node, %struct.Node* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = load i32, i32* %3, align 4
  %19 = icmp ne i32 %17, %18
  br i1 %19, label %20, label %21

; <label>:20:                                     ; preds = %14
  store i8 0, i8* %4, align 1
  br label %21

; <label>:21:                                     ; preds = %20, %14
  store i32 0, i32* %7, align 4
  br label %22

; <label>:22:                                     ; preds = %35, %21
  %23 = load i32, i32* %7, align 4
  %24 = load i32, i32* %3, align 4
  %25 = icmp slt i32 %23, %24
  br i1 %25, label %26, label %38

; <label>:26:                                     ; preds = %22
  %27 = load i32, i32* %3, align 4
  %28 = add nsw i32 97, %27
  %29 = load i32, i32* %7, align 4
  %30 = add nsw i32 %28, %29
  %31 = trunc i32 %30 to i8
  %32 = load i32, i32* %7, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [11 x i8], [11 x i8]* %5, i64 0, i64 %33
  store i8 %31, i8* %34, align 1
  br label %35

; <label>:35:                                     ; preds = %26
  %36 = load i32, i32* %7, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, i32* %7, align 4
  br label %22

; <label>:38:                                     ; preds = %22
  %39 = load %struct.Node*, %struct.Node** %6, align 8
  %40 = getelementptr inbounds %struct.Node, %struct.Node* %39, i32 0, i32 1
  %41 = load i8*, i8** %40, align 8
  %42 = getelementptr inbounds [11 x i8], [11 x i8]* %5, i32 0, i32 0
  %43 = call i32 @strcmp(i8* %41, i8* %42) #5
  %44 = icmp ne i32 %43, 0
  br i1 %44, label %45, label %46

; <label>:45:                                     ; preds = %38
  store i8 0, i8* %4, align 1
  br label %46

; <label>:46:                                     ; preds = %45, %38
  br label %47

; <label>:47:                                     ; preds = %46
  %48 = load %struct.Node*, %struct.Node** %6, align 8
  %49 = getelementptr inbounds %struct.Node, %struct.Node* %48, i32 0, i32 2
  %50 = load %struct.Node*, %struct.Node** %49, align 8
  store %struct.Node* %50, %struct.Node** %6, align 8
  %51 = load i32, i32* %3, align 4
  %52 = add nsw i32 %51, 1
  store i32 %52, i32* %3, align 4
  br label %11

; <label>:53:                                     ; preds = %11
  %54 = load i8, i8* %4, align 1
  %55 = icmp ne i8 %54, 0
  br i1 %55, label %56, label %58

; <label>:56:                                     ; preds = %53
  %57 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i32 0, i32 0))
  br label %58

; <label>:58:                                     ; preds = %56, %53
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #1

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

declare i32 @printf(i8*, ...) #3

; Function Attrs: noinline nounwind uwtable
define void @initialize(%struct.Node*, i32) #0 {
  %3 = alloca %struct.Node*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store %struct.Node* %0, %struct.Node** %3, align 8
  store i32 %1, i32* %4, align 4
  %6 = load i32, i32* %4, align 4
  %7 = load %struct.Node*, %struct.Node** %3, align 8
  %8 = getelementptr inbounds %struct.Node, %struct.Node* %7, i32 0, i32 0
  store i32 %6, i32* %8, align 8
  %9 = call noalias i8* @malloc(i64 11) #6
  %10 = load %struct.Node*, %struct.Node** %3, align 8
  %11 = getelementptr inbounds %struct.Node, %struct.Node* %10, i32 0, i32 1
  store i8* %9, i8** %11, align 8
  %12 = load %struct.Node*, %struct.Node** %3, align 8
  %13 = getelementptr inbounds %struct.Node, %struct.Node* %12, i32 0, i32 1
  %14 = load i8*, i8** %13, align 8
  call void @llvm.memset.p0i8.i64(i8* %14, i8 0, i64 11, i32 1, i1 false)
  store i32 0, i32* %5, align 4
  br label %15

; <label>:15:                                     ; preds = %31, %2
  %16 = load i32, i32* %5, align 4
  %17 = load i32, i32* %4, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %34

; <label>:19:                                     ; preds = %15
  %20 = load i32, i32* %4, align 4
  %21 = add nsw i32 97, %20
  %22 = load i32, i32* %5, align 4
  %23 = add nsw i32 %21, %22
  %24 = trunc i32 %23 to i8
  %25 = load %struct.Node*, %struct.Node** %3, align 8
  %26 = getelementptr inbounds %struct.Node, %struct.Node* %25, i32 0, i32 1
  %27 = load i8*, i8** %26, align 8
  %28 = load i32, i32* %5, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i8, i8* %27, i64 %29
  store i8 %24, i8* %30, align 1
  br label %31

; <label>:31:                                     ; preds = %19
  %32 = load i32, i32* %5, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, i32* %5, align 4
  br label %15

; <label>:34:                                     ; preds = %15
  %35 = load %struct.Node*, %struct.Node** %3, align 8
  %36 = getelementptr inbounds %struct.Node, %struct.Node* %35, i32 0, i32 1
  %37 = load i8*, i8** %36, align 8
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0), i8* %37)
  ret void
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #4

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Node*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %struct.Node*, align 8
  store i32 0, i32* %1, align 4
  %5 = call noalias i8* @malloc(i64 24) #6
  %6 = bitcast i8* %5 to %struct.Node*
  store %struct.Node* %6, %struct.Node** %2, align 8
  %7 = call noalias i8* @malloc(i64 24) #6
  %8 = bitcast i8* %7 to %struct.Node*
  %9 = load %struct.Node*, %struct.Node** %2, align 8
  %10 = getelementptr inbounds %struct.Node, %struct.Node* %9, i32 0, i32 2
  store %struct.Node* %8, %struct.Node** %10, align 8
  %11 = call noalias i8* @malloc(i64 24) #6
  %12 = bitcast i8* %11 to %struct.Node*
  %13 = load %struct.Node*, %struct.Node** %2, align 8
  %14 = getelementptr inbounds %struct.Node, %struct.Node* %13, i32 0, i32 2
  %15 = load %struct.Node*, %struct.Node** %14, align 8
  %16 = getelementptr inbounds %struct.Node, %struct.Node* %15, i32 0, i32 2
  store %struct.Node* %12, %struct.Node** %16, align 8
  %17 = call noalias i8* @malloc(i64 24) #6
  %18 = bitcast i8* %17 to %struct.Node*
  %19 = load %struct.Node*, %struct.Node** %2, align 8
  %20 = getelementptr inbounds %struct.Node, %struct.Node* %19, i32 0, i32 2
  %21 = load %struct.Node*, %struct.Node** %20, align 8
  %22 = getelementptr inbounds %struct.Node, %struct.Node* %21, i32 0, i32 2
  %23 = load %struct.Node*, %struct.Node** %22, align 8
  %24 = getelementptr inbounds %struct.Node, %struct.Node* %23, i32 0, i32 2
  store %struct.Node* %18, %struct.Node** %24, align 8
  %25 = call noalias i8* @malloc(i64 24) #6
  %26 = bitcast i8* %25 to %struct.Node*
  %27 = load %struct.Node*, %struct.Node** %2, align 8
  %28 = getelementptr inbounds %struct.Node, %struct.Node* %27, i32 0, i32 2
  %29 = load %struct.Node*, %struct.Node** %28, align 8
  %30 = getelementptr inbounds %struct.Node, %struct.Node* %29, i32 0, i32 2
  %31 = load %struct.Node*, %struct.Node** %30, align 8
  %32 = getelementptr inbounds %struct.Node, %struct.Node* %31, i32 0, i32 2
  %33 = load %struct.Node*, %struct.Node** %32, align 8
  %34 = getelementptr inbounds %struct.Node, %struct.Node* %33, i32 0, i32 2
  store %struct.Node* %26, %struct.Node** %34, align 8
  %35 = load %struct.Node*, %struct.Node** %2, align 8
  %36 = getelementptr inbounds %struct.Node, %struct.Node* %35, i32 0, i32 2
  %37 = load %struct.Node*, %struct.Node** %36, align 8
  %38 = getelementptr inbounds %struct.Node, %struct.Node* %37, i32 0, i32 2
  %39 = load %struct.Node*, %struct.Node** %38, align 8
  %40 = getelementptr inbounds %struct.Node, %struct.Node* %39, i32 0, i32 2
  %41 = load %struct.Node*, %struct.Node** %40, align 8
  %42 = getelementptr inbounds %struct.Node, %struct.Node* %41, i32 0, i32 2
  %43 = load %struct.Node*, %struct.Node** %42, align 8
  %44 = getelementptr inbounds %struct.Node, %struct.Node* %43, i32 0, i32 2
  store %struct.Node* null, %struct.Node** %44, align 8
  store i32 1, i32* %3, align 4
  %45 = load %struct.Node*, %struct.Node** %2, align 8
  store %struct.Node* %45, %struct.Node** %4, align 8
  br label %46

; <label>:46:                                     ; preds = %52, %0
  %47 = load %struct.Node*, %struct.Node** %4, align 8
  %48 = icmp ne %struct.Node* %47, null
  br i1 %48, label %49, label %58

; <label>:49:                                     ; preds = %46
  %50 = load %struct.Node*, %struct.Node** %4, align 8
  %51 = load i32, i32* %3, align 4
  call void @initialize(%struct.Node* %50, i32 %51)
  br label %52

; <label>:52:                                     ; preds = %49
  %53 = load %struct.Node*, %struct.Node** %4, align 8
  %54 = getelementptr inbounds %struct.Node, %struct.Node* %53, i32 0, i32 2
  %55 = load %struct.Node*, %struct.Node** %54, align 8
  store %struct.Node* %55, %struct.Node** %4, align 8
  %56 = load i32, i32* %3, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, i32* %3, align 4
  br label %46

; <label>:58:                                     ; preds = %46
  %59 = load %struct.Node*, %struct.Node** %2, align 8
  call void @branchPruned(%struct.Node* %59)
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
