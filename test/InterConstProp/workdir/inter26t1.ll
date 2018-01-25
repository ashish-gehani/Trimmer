; ModuleID = 'workdir/inter26t1.bc'
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
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Node*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %struct.Node*, align 8
  %5 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %6 = call noalias i8* @malloc(i64 24) #5
  %7 = bitcast i8* %6 to %struct.Node*
  store %struct.Node* %7, %struct.Node** %2, align 8
  %8 = call noalias i8* @malloc(i64 24) #5
  %9 = bitcast i8* %8 to %struct.Node*
  %10 = load %struct.Node*, %struct.Node** %2, align 8
  %11 = getelementptr inbounds %struct.Node, %struct.Node* %10, i32 0, i32 2
  store %struct.Node* %9, %struct.Node** %11, align 8
  %12 = call noalias i8* @malloc(i64 24) #5
  %13 = bitcast i8* %12 to %struct.Node*
  %14 = load %struct.Node*, %struct.Node** %2, align 8
  %15 = getelementptr inbounds %struct.Node, %struct.Node* %14, i32 0, i32 2
  %16 = load %struct.Node*, %struct.Node** %15, align 8
  %17 = getelementptr inbounds %struct.Node, %struct.Node* %16, i32 0, i32 2
  store %struct.Node* %13, %struct.Node** %17, align 8
  %18 = call noalias i8* @malloc(i64 24) #5
  %19 = bitcast i8* %18 to %struct.Node*
  %20 = load %struct.Node*, %struct.Node** %2, align 8
  %21 = getelementptr inbounds %struct.Node, %struct.Node* %20, i32 0, i32 2
  %22 = load %struct.Node*, %struct.Node** %21, align 8
  %23 = getelementptr inbounds %struct.Node, %struct.Node* %22, i32 0, i32 2
  %24 = load %struct.Node*, %struct.Node** %23, align 8
  %25 = getelementptr inbounds %struct.Node, %struct.Node* %24, i32 0, i32 2
  store %struct.Node* %19, %struct.Node** %25, align 8
  %26 = call noalias i8* @malloc(i64 24) #5
  %27 = bitcast i8* %26 to %struct.Node*
  %28 = load %struct.Node*, %struct.Node** %2, align 8
  %29 = getelementptr inbounds %struct.Node, %struct.Node* %28, i32 0, i32 2
  %30 = load %struct.Node*, %struct.Node** %29, align 8
  %31 = getelementptr inbounds %struct.Node, %struct.Node* %30, i32 0, i32 2
  %32 = load %struct.Node*, %struct.Node** %31, align 8
  %33 = getelementptr inbounds %struct.Node, %struct.Node* %32, i32 0, i32 2
  %34 = load %struct.Node*, %struct.Node** %33, align 8
  %35 = getelementptr inbounds %struct.Node, %struct.Node* %34, i32 0, i32 2
  store %struct.Node* %27, %struct.Node** %35, align 8
  %36 = load %struct.Node*, %struct.Node** %2, align 8
  %37 = getelementptr inbounds %struct.Node, %struct.Node* %36, i32 0, i32 2
  %38 = load %struct.Node*, %struct.Node** %37, align 8
  %39 = getelementptr inbounds %struct.Node, %struct.Node* %38, i32 0, i32 2
  %40 = load %struct.Node*, %struct.Node** %39, align 8
  %41 = getelementptr inbounds %struct.Node, %struct.Node* %40, i32 0, i32 2
  %42 = load %struct.Node*, %struct.Node** %41, align 8
  %43 = getelementptr inbounds %struct.Node, %struct.Node* %42, i32 0, i32 2
  %44 = load %struct.Node*, %struct.Node** %43, align 8
  %45 = getelementptr inbounds %struct.Node, %struct.Node* %44, i32 0, i32 2
  store %struct.Node* null, %struct.Node** %45, align 8
  store i32 1, i32* %3, align 4
  %46 = load %struct.Node*, %struct.Node** %2, align 8
  store %struct.Node* %46, %struct.Node** %4, align 8
  br label %47

; <label>:47:                                     ; preds = %80, %0
  %48 = load %struct.Node*, %struct.Node** %4, align 8
  %49 = icmp ne %struct.Node* %48, null
  br i1 %49, label %50, label %86

; <label>:50:                                     ; preds = %47
  %51 = load i32, i32* %3, align 4
  %52 = load %struct.Node*, %struct.Node** %4, align 8
  %53 = getelementptr inbounds %struct.Node, %struct.Node* %52, i32 0, i32 0
  store i32 %51, i32* %53, align 8
  %54 = call noalias i8* @malloc(i64 11) #5
  %55 = load %struct.Node*, %struct.Node** %4, align 8
  %56 = getelementptr inbounds %struct.Node, %struct.Node* %55, i32 0, i32 1
  store i8* %54, i8** %56, align 8
  store i32 0, i32* %5, align 4
  br label %57

; <label>:57:                                     ; preds = %72, %50
  %58 = load i32, i32* %5, align 4
  %59 = icmp slt i32 %58, 10
  br i1 %59, label %60, label %75

; <label>:60:                                     ; preds = %57
  %61 = load i32, i32* %3, align 4
  %62 = add nsw i32 97, %61
  %63 = load i32, i32* %5, align 4
  %64 = add nsw i32 %62, %63
  %65 = trunc i32 %64 to i8
  %66 = load %struct.Node*, %struct.Node** %4, align 8
  %67 = getelementptr inbounds %struct.Node, %struct.Node* %66, i32 0, i32 1
  %68 = load i8*, i8** %67, align 8
  %69 = load i32, i32* %5, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds i8, i8* %68, i64 %70
  store i8 %65, i8* %71, align 1
  br label %72

; <label>:72:                                     ; preds = %60
  %73 = load i32, i32* %5, align 4
  %74 = add nsw i32 %73, 1
  store i32 %74, i32* %5, align 4
  br label %57

; <label>:75:                                     ; preds = %57
  %76 = load %struct.Node*, %struct.Node** %4, align 8
  %77 = getelementptr inbounds %struct.Node, %struct.Node* %76, i32 0, i32 1
  %78 = load i8*, i8** %77, align 8
  %79 = getelementptr inbounds i8, i8* %78, i64 10
  store i8 0, i8* %79, align 1
  br label %80

; <label>:80:                                     ; preds = %75
  %81 = load %struct.Node*, %struct.Node** %4, align 8
  %82 = getelementptr inbounds %struct.Node, %struct.Node* %81, i32 0, i32 2
  %83 = load %struct.Node*, %struct.Node** %82, align 8
  store %struct.Node* %83, %struct.Node** %4, align 8
  %84 = load i32, i32* %3, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, i32* %3, align 4
  br label %47

; <label>:86:                                     ; preds = %47
  %87 = load %struct.Node*, %struct.Node** %2, align 8
  call void @branchPruned(%struct.Node* %87)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }
attributes #5 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
