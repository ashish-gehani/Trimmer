; ModuleID = 'workdir/out24.bc'
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
@str.2 = private unnamed_addr constant [13 x i8] c"branchPruned\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType* nocapture readonly) local_unnamed_addr #0 {
  %2 = alloca [11 x i8], align 1
  %3 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %3, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i64 10, i32 1, i1 false)
  %4 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 10
  store i8 48, i8* %4, align 1
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0
  %6 = load i32, i32* %5, align 8
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %17

; <label>:8:                                      ; preds = %1
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %17

; <label>:12:                                     ; preds = %8
  %13 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 2
  %14 = load i8*, i8** %13, align 8
  %15 = call i32 @strcmp(i8* nonnull %3, i8* %14) #4
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %18, label %17

; <label>:17:                                     ; preds = %12, %8, %1
  br label %18

; <label>:18:                                     ; preds = %12, %17
  %.1 = phi i8 [ 0, %17 ], [ 1, %12 ]
  store i8 49, i8* %4, align 1
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 1, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = icmp eq i32 %20, 1
  br i1 %21, label %23, label %32

; <label>:22:                                     ; preds = %55
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.2, i64 0, i64 0))
  br label %.thread

.thread:                                          ; preds = %55, %51, %47, %22
  ret void

; <label>:23:                                     ; preds = %18
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 1, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %32

; <label>:27:                                     ; preds = %23
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 1, i32 2
  %29 = load i8*, i8** %28, align 8
  %30 = call i32 @strcmp(i8* nonnull %3, i8* %29) #4
  %31 = icmp eq i32 %30, 0
  br i1 %31, label %33, label %32

; <label>:32:                                     ; preds = %27, %23, %18
  br label %33

; <label>:33:                                     ; preds = %32, %27
  %.1.1 = phi i8 [ 0, %32 ], [ %.1, %27 ]
  store i8 50, i8* %4, align 1
  %34 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 2, i32 0
  %35 = load i32, i32* %34, align 8
  %36 = icmp eq i32 %35, 2
  br i1 %36, label %37, label %46

; <label>:37:                                     ; preds = %33
  %38 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 2, i32 1
  %39 = load i32, i32* %38, align 4
  %40 = icmp eq i32 %39, 2
  br i1 %40, label %41, label %46

; <label>:41:                                     ; preds = %37
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 2, i32 2
  %43 = load i8*, i8** %42, align 8
  %44 = call i32 @strcmp(i8* nonnull %3, i8* %43) #4
  %45 = icmp eq i32 %44, 0
  br i1 %45, label %47, label %46

; <label>:46:                                     ; preds = %41, %37, %33
  br label %47

; <label>:47:                                     ; preds = %46, %41
  %.1.2 = phi i8 [ 0, %46 ], [ %.1.1, %41 ]
  store i8 51, i8* %4, align 1
  %48 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 3, i32 0
  %49 = load i32, i32* %48, align 8
  %50 = icmp eq i32 %49, 3
  br i1 %50, label %51, label %.thread

; <label>:51:                                     ; preds = %47
  %52 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 3, i32 1
  %53 = load i32, i32* %52, align 4
  %54 = icmp eq i32 %53, 3
  br i1 %54, label %55, label %.thread

; <label>:55:                                     ; preds = %51
  %56 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 3, i32 2
  %57 = load i8*, i8** %56, align 8
  %58 = call i32 @strcmp(i8* nonnull %3, i8* %57) #4
  %59 = icmp ne i32 %58, 0
  %60 = icmp eq i8 %.1.2, 0
  %or.cond = or i1 %59, %60
  br i1 %or.cond, label %.thread, label %22
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #2

; Function Attrs: noinline nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
  tail call void @branchPruned_clone(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* @st, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.stType* nocapture readnone) local_unnamed_addr #0 {
.peel.begin:
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.2, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone_clone(%struct.stType* nocapture readnone) local_unnamed_addr #0 {
.peel.begin:
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.2, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #3

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
