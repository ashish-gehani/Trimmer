; ModuleID = 'workdir/inter7t3.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD, [100 x i8], [8 x i32] }
%struct.COORD = type { i32, i32 }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"*** Branch Taken \0A\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"found\0A\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@0 = constant [11 x i8] c"helloWorld\00"
@str = private unnamed_addr constant [18 x i8] c"*** Branch Taken \00"
@str.1 = private unnamed_addr constant [6 x i8] c"found\00"
@str.2 = private unnamed_addr constant [6 x i8] c"found\00"
@str.3 = private unnamed_addr constant [18 x i8] c"*** Branch Taken \00"

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType* byval align 8 %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 0, i32 0
  %2 = load i32, i32* %1, align 8
  %3 = icmp eq i32 %2, 4
  br i1 %3, label %4, label %25

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 0, i32 1
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 8
  br i1 %7, label %8, label %25

; <label>:8                                       ; preds = %4
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp eq i32 %10, 12
  br i1 %11, label %12, label %25

; <label>:12                                      ; preds = %8
  %13 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 1, i64 0
  %14 = call i32 @strcmp(i8* %13, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %16, label %25

; <label>:16                                      ; preds = %12
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 1, i64 4
  %18 = load i8, i8* %17, align 4
  %19 = icmp eq i8 %18, 111
  br i1 %19, label %20, label %25

; <label>:20                                      ; preds = %16
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 1, i64 9
  %22 = load i8, i8* %21, align 1
  %23 = icmp eq i8 %22, 100
  br i1 %23, label %24, label %25

; <label>:24                                      ; preds = %20
  %puts = call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str, i64 0, i64 0))
  br label %25

; <label>:25                                      ; preds = %12, %24, %20, %16, %8, %4, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define void @branchNotPruned(%struct.stType* byval align 8 %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 6
  %2 = load i32, i32* %1, align 4
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %8, label %4

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 1, i64 15
  %6 = load i8, i8* %5, align 1
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %4, %0
  %puts = call i32 @puts(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @str.1, i64 0, i64 0))
  br label %9

; <label>:9                                       ; preds = %8, %4
  ret void
}

; Function Attrs: nounwind uwtable
define void @initialize(%struct.stType* %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 0, i32 0
  store i32 4, i32* %1, align 4
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 0, i32 1
  store i32 8, i32* %2, align 4
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 0
  store i32 12, i32* %3, align 4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 1
  store i32 12, i32* %4, align 4
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 2
  store i32 12, i32* %5, align 4
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 1, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %obj = alloca %struct.stType, align 8
  call void @initialize(%struct.stType* nonnull %obj)
  call void @branchNotPruned(%struct.stType* byval nonnull align 8 %obj)
  call void @branchPruned_clone(%struct.stType* nonnull %obj)
  ret i32 0
}

; Function Attrs: nounwind uwtable
define void @initialize_clone(%struct.stType* %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 0, i32 0
  store i32 4, i32* %1, align 4
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 0, i32 1
  store i32 8, i32* %2, align 4
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 0
  store i32 12, i32* %3, align 4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 1
  store i32 12, i32* %4, align 4
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 2
  store i32 12, i32* %5, align 4
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 1, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(%struct.stType* byval align 8 %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 6
  %2 = load i32, i32* %1, align 4
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %8, label %4

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 1, i64 15
  %6 = load i8, i8* %5, align 1
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %4, %0
  %puts = call i32 @puts(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @str.2, i64 0, i64 0))
  br label %9

; <label>:9                                       ; preds = %8, %4
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType* byval align 8 %obj) #0 {
  br i1 true, label %1, label %7

; <label>:1                                       ; preds = %0
  br i1 true, label %2, label %7

; <label>:2                                       ; preds = %1
  br i1 true, label %3, label %7

; <label>:3                                       ; preds = %2
  br i1 false, label %7, label %4

; <label>:4                                       ; preds = %3
  br i1 true, label %5, label %7

; <label>:5                                       ; preds = %4
  br i1 true, label %6, label %7

; <label>:6                                       ; preds = %5
  %puts = call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.3, i64 0, i64 0))
  br label %7

; <label>:7                                       ; preds = %6, %5, %4, %3, %2, %1, %0
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #4

; Function Attrs: nounwind uwtable
define void @initialize_clone.4(%struct.stType* %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 0, i32 0
  store i32 4, i32* %1, align 4
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 0, i32 1
  store i32 8, i32* %2, align 4
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 0
  store i32 12, i32* %3, align 4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 1
  store i32 12, i32* %4, align 4
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 2
  store i32 12, i32* %5, align 4
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 1, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone.5(%struct.stType* byval align 8 %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 6
  %2 = load i32, i32* %1, align 4
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %8, label %4

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 1, i64 15
  %6 = load i8, i8* %5, align 1
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %4, %0
  %puts = call i32 @puts(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @str.1, i64 0, i64 0))
  br label %9

; <label>:9                                       ; preds = %8, %4
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone_clone(%struct.stType* byval align 8 %obj) #0 {
  br i1 true, label %1, label %7

; <label>:1                                       ; preds = %0
  br i1 true, label %2, label %7

; <label>:2                                       ; preds = %1
  br i1 true, label %3, label %7

; <label>:3                                       ; preds = %2
  br i1 false, label %7, label %4

; <label>:4                                       ; preds = %3
  br i1 true, label %5, label %7

; <label>:5                                       ; preds = %4
  br i1 true, label %6, label %7

; <label>:6                                       ; preds = %5
  %puts = call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.3, i64 0, i64 0))
  br label %7

; <label>:7                                       ; preds = %6, %5, %4, %3, %2, %1, %0
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
