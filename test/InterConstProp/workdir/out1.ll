; ModuleID = 'workdir/out1.bc'
source_filename = "inter1.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { i32, i32, i8* }

@.str = private unnamed_addr constant [12 x i8] c"helloworld0\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"helloworld1\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloworld2\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloworld3\00", align 1
@st = global [4 x %struct.stType] [%struct.stType { i32 0, i32 0, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0) }, %struct.stType { i32 1, i32 1, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0) }, %struct.stType { i32 2, i32 2, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0) }, %struct.stType { i32 3, i32 3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0) }], align 16
@str.1 = private unnamed_addr constant [13 x i8] c"branchPruned\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType* nocapture readonly) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0
  %3 = load i32, i32* %2, align 8
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %54

; <label>:5:                                      ; preds = %1
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 1
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %54

; <label>:9:                                      ; preds = %5
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 2
  %11 = load i8*, i8** %10, align 8
  %12 = tail call i32 @strcmp(i8* %11, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0)) #3
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %54

; <label>:14:                                     ; preds = %9
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 1, i32 0
  %16 = load i32, i32* %15, align 8
  %17 = icmp eq i32 %16, 1
  br i1 %17, label %18, label %54

; <label>:18:                                     ; preds = %14
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 1, i32 1
  %20 = load i32, i32* %19, align 4
  %21 = icmp eq i32 %20, 1
  br i1 %21, label %22, label %54

; <label>:22:                                     ; preds = %18
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 1, i32 2
  %24 = load i8*, i8** %23, align 8
  %25 = tail call i32 @strcmp(i8* %24, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0)) #3
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %27, label %54

; <label>:27:                                     ; preds = %22
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 2, i32 0
  %29 = load i32, i32* %28, align 8
  %30 = icmp eq i32 %29, 2
  br i1 %30, label %31, label %54

; <label>:31:                                     ; preds = %27
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 2, i32 1
  %33 = load i32, i32* %32, align 4
  %34 = icmp eq i32 %33, 2
  br i1 %34, label %35, label %54

; <label>:35:                                     ; preds = %31
  %36 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 2, i32 2
  %37 = load i8*, i8** %36, align 8
  %38 = tail call i32 @strcmp(i8* %37, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0)) #3
  %39 = icmp eq i32 %38, 0
  br i1 %39, label %40, label %54

; <label>:40:                                     ; preds = %35
  %41 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 3, i32 0
  %42 = load i32, i32* %41, align 8
  %43 = icmp eq i32 %42, 3
  br i1 %43, label %44, label %54

; <label>:44:                                     ; preds = %40
  %45 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 3, i32 1
  %46 = load i32, i32* %45, align 4
  %47 = icmp eq i32 %46, 3
  br i1 %47, label %48, label %54

; <label>:48:                                     ; preds = %44
  %49 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 3, i32 2
  %50 = load i8*, i8** %49, align 8
  %51 = tail call i32 @strcmp(i8* %50, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0)) #3
  %52 = icmp eq i32 %51, 0
  br i1 %52, label %53, label %54

; <label>:53:                                     ; preds = %48
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.1, i64 0, i64 0))
  br label %54

; <label>:54:                                     ; preds = %48, %35, %22, %9, %53, %44, %40, %31, %27, %18, %14, %5, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #1

; Function Attrs: noinline nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
  tail call void @branchPruned_clone(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* @st, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.stType* nocapture readnone) local_unnamed_addr #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.1, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
