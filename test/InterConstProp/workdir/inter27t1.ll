; ModuleID = 'workdir/inter27t1.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Node = type { i32, i8*, %struct.Node* }

@.str = private unnamed_addr constant [15 x i8] c"condition true\00", align 1

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
  %9 = load %struct.Node*, %struct.Node** %2, align 8
  store %struct.Node* %9, %struct.Node** %6, align 8
  br label %10

; <label>:10:                                     ; preds = %45, %1
  %11 = load %struct.Node*, %struct.Node** %6, align 8
  %12 = icmp ne %struct.Node* %11, null
  br i1 %12, label %13, label %51

; <label>:13:                                     ; preds = %10
  %14 = load %struct.Node*, %struct.Node** %6, align 8
  %15 = getelementptr inbounds %struct.Node, %struct.Node* %14, i32 0, i32 0
  %16 = load i32, i32* %15, align 8
  %17 = load i32, i32* %3, align 4
  %18 = icmp ne i32 %16, %17
  br i1 %18, label %19, label %20

; <label>:19:                                     ; preds = %13
  store i8 0, i8* %4, align 1
  br label %20

; <label>:20:                                     ; preds = %19, %13
  store i32 0, i32* %7, align 4
  br label %21

; <label>:21:                                     ; preds = %33, %20
  %22 = load i32, i32* %7, align 4
  %23 = icmp slt i32 %22, 10
  br i1 %23, label %24, label %36

; <label>:24:                                     ; preds = %21
  %25 = load i32, i32* %3, align 4
  %26 = add nsw i32 97, %25
  %27 = load i32, i32* %7, align 4
  %28 = add nsw i32 %26, %27
  %29 = trunc i32 %28 to i8
  %30 = load i32, i32* %7, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [11 x i8], [11 x i8]* %5, i64 0, i64 %31
  store i8 %29, i8* %32, align 1
  br label %33

; <label>:33:                                     ; preds = %24
  %34 = load i32, i32* %7, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, i32* %7, align 4
  br label %21

; <label>:36:                                     ; preds = %21
  %37 = load %struct.Node*, %struct.Node** %6, align 8
  %38 = getelementptr inbounds %struct.Node, %struct.Node* %37, i32 0, i32 1
  %39 = load i8*, i8** %38, align 8
  %40 = getelementptr inbounds [11 x i8], [11 x i8]* %5, i32 0, i32 0
  %41 = call i32 @strcmp(i8* %39, i8* %40) #4
  %42 = icmp ne i32 %41, 0
  br i1 %42, label %43, label %44

; <label>:43:                                     ; preds = %36
  store i8 0, i8* %4, align 1
  br label %44

; <label>:44:                                     ; preds = %43, %36
  br label %45

; <label>:45:                                     ; preds = %44
  %46 = load %struct.Node*, %struct.Node** %6, align 8
  %47 = getelementptr inbounds %struct.Node, %struct.Node* %46, i32 0, i32 2
  %48 = load %struct.Node*, %struct.Node** %47, align 8
  store %struct.Node* %48, %struct.Node** %6, align 8
  %49 = load i32, i32* %3, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, i32* %3, align 4
  br label %10

; <label>:51:                                     ; preds = %10
  %52 = load i8, i8* %4, align 1
  %53 = icmp ne i8 %52, 0
  br i1 %53, label %54, label %56

; <label>:54:                                     ; preds = %51
  %55 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i32 0, i32 0))
  br label %56

; <label>:56:                                     ; preds = %54, %51
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

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
  %9 = call noalias i8* @malloc(i64 11) #5
  %10 = load %struct.Node*, %struct.Node** %3, align 8
  %11 = getelementptr inbounds %struct.Node, %struct.Node* %10, i32 0, i32 1
  store i8* %9, i8** %11, align 8
  store i32 0, i32* %5, align 4
  br label %12

; <label>:12:                                     ; preds = %27, %2
  %13 = load i32, i32* %5, align 4
  %14 = icmp slt i32 %13, 10
  br i1 %14, label %15, label %30

; <label>:15:                                     ; preds = %12
  %16 = load i32, i32* %4, align 4
  %17 = add nsw i32 97, %16
  %18 = load i32, i32* %5, align 4
  %19 = add nsw i32 %17, %18
  %20 = trunc i32 %19 to i8
  %21 = load %struct.Node*, %struct.Node** %3, align 8
  %22 = getelementptr inbounds %struct.Node, %struct.Node* %21, i32 0, i32 1
  %23 = load i8*, i8** %22, align 8
  %24 = load i32, i32* %5, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i8, i8* %23, i64 %25
  store i8 %20, i8* %26, align 1
  br label %27

; <label>:27:                                     ; preds = %15
  %28 = load i32, i32* %5, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, i32* %5, align 4
  br label %12

; <label>:30:                                     ; preds = %12
  %31 = load %struct.Node*, %struct.Node** %3, align 8
  %32 = getelementptr inbounds %struct.Node, %struct.Node* %31, i32 0, i32 1
  %33 = load i8*, i8** %32, align 8
  %34 = getelementptr inbounds i8, i8* %33, i64 10
  store i8 0, i8* %34, align 1
  ret void
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Node*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %struct.Node*, align 8
  store i32 0, i32* %1, align 4
  %5 = call noalias i8* @malloc(i64 24) #5
  %6 = bitcast i8* %5 to %struct.Node*
  store %struct.Node* %6, %struct.Node** %2, align 8
  %7 = call noalias i8* @malloc(i64 24) #5
  %8 = bitcast i8* %7 to %struct.Node*
  %9 = load %struct.Node*, %struct.Node** %2, align 8
  %10 = getelementptr inbounds %struct.Node, %struct.Node* %9, i32 0, i32 2
  store %struct.Node* %8, %struct.Node** %10, align 8
  %11 = call noalias i8* @malloc(i64 24) #5
  %12 = bitcast i8* %11 to %struct.Node*
  %13 = load %struct.Node*, %struct.Node** %2, align 8
  %14 = getelementptr inbounds %struct.Node, %struct.Node* %13, i32 0, i32 2
  %15 = load %struct.Node*, %struct.Node** %14, align 8
  %16 = getelementptr inbounds %struct.Node, %struct.Node* %15, i32 0, i32 2
  store %struct.Node* %12, %struct.Node** %16, align 8
  %17 = call noalias i8* @malloc(i64 24) #5
  %18 = bitcast i8* %17 to %struct.Node*
  %19 = load %struct.Node*, %struct.Node** %2, align 8
  %20 = getelementptr inbounds %struct.Node, %struct.Node* %19, i32 0, i32 2
  %21 = load %struct.Node*, %struct.Node** %20, align 8
  %22 = getelementptr inbounds %struct.Node, %struct.Node* %21, i32 0, i32 2
  %23 = load %struct.Node*, %struct.Node** %22, align 8
  %24 = getelementptr inbounds %struct.Node, %struct.Node* %23, i32 0, i32 2
  store %struct.Node* %18, %struct.Node** %24, align 8
  %25 = call noalias i8* @malloc(i64 24) #5
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
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }
attributes #5 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
