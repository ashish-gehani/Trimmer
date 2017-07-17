; ModuleID = 'workdir/out8.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.HighType = type { %struct.LowTypeString, %struct.LowTypeInt }
%struct.LowTypeString = type { [1000 x i8], [1000 x i8] }
%struct.LowTypeInt = type { [1000 x i32], [1000 x i32] }

@.str = private unnamed_addr constant [16 x i8] c"*** branchTaken\00", align 1

; Function Attrs: norecurse nounwind uwtable
define void @initialize(%struct.HighType* nocapture %obj) #0 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 569
  store i32 127, i32* %1, align 4
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 335
  store i32 78, i32* %2, align 4
  %3 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 534
  store i32 48, i32* %3, align 4
  %4 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 645
  store i8 56, i8* %4, align 1
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 902
  store i8 117, i8* %5, align 2
  %6 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 966
  store i32 3, i32* %6, align 4
  %7 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 316
  store i32 51, i32* %7, align 4
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 987
  store i32 119, i32* %8, align 4
  %9 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 253
  store i8 126, i8* %9, align 1
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 879
  store i8 48, i8* %10, align 1
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.HighType* byval nocapture readonly align 8 %obj) #1 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 569
  %2 = load i32, i32* %1, align 4
  %3 = icmp eq i32 %2, 127
  br i1 %3, label %4, label %42

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 335
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 78
  br i1 %7, label %8, label %42

; <label>:8                                       ; preds = %4
  %9 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 534
  %10 = load i32, i32* %9, align 8
  %11 = icmp eq i32 %10, 48
  br i1 %11, label %12, label %42

; <label>:12                                      ; preds = %8
  %13 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 645
  %14 = load i8, i8* %13, align 1
  %15 = icmp eq i8 %14, 56
  br i1 %15, label %16, label %42

; <label>:16                                      ; preds = %12
  %17 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 902
  %18 = load i8, i8* %17, align 2
  %19 = icmp eq i8 %18, 117
  br i1 %19, label %20, label %42

; <label>:20                                      ; preds = %16
  %21 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 966
  %22 = load i32, i32* %21, align 8
  %23 = icmp eq i32 %22, 3
  br i1 %23, label %24, label %42

; <label>:24                                      ; preds = %20
  %25 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 316
  %26 = load i32, i32* %25, align 8
  %27 = icmp eq i32 %26, 51
  br i1 %27, label %28, label %42

; <label>:28                                      ; preds = %24
  %29 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 987
  %30 = load i32, i32* %29, align 4
  %31 = icmp eq i32 %30, 119
  br i1 %31, label %32, label %42

; <label>:32                                      ; preds = %28
  %33 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 253
  %34 = load i8, i8* %33, align 1
  %35 = icmp eq i8 %34, 126
  br i1 %35, label %36, label %42

; <label>:36                                      ; preds = %32
  %37 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 879
  %38 = load i8, i8* %37, align 1
  %39 = icmp eq i8 %38, 48
  br i1 %39, label %40, label %42

; <label>:40                                      ; preds = %36
  %41 = tail call i32 (i8*, ...) @printf(i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i64 0, i64 0)) #4
  br label %42

; <label>:42                                      ; preds = %40, %36, %32, %28, %24, %20, %16, %12, %8, %4, %0
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind uwtable
define i32 @main() #1 {
branchPruned.exit:
  %0 = tail call i32 (i8*, ...) @printf(i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i64 0, i64 0)) #4
  ret i32 0
}

; Function Attrs: norecurse nounwind uwtable
define void @initialize_clone(%struct.HighType* nocapture %obj) #0 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 569
  store i32 127, i32* %1, align 4
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 335
  store i32 78, i32* %2, align 4
  %3 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 534
  store i32 48, i32* %3, align 4
  %4 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 645
  store i8 56, i8* %4, align 1
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 902
  store i8 117, i8* %5, align 2
  %6 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 966
  store i32 3, i32* %6, align 4
  %7 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 316
  store i32 51, i32* %7, align 4
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 987
  store i32 119, i32* %8, align 4
  %9 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 253
  store i8 126, i8* %9, align 1
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 879
  store i8 48, i8* %10, align 1
  ret void
}

; Function Attrs: norecurse nounwind readnone uwtable
define void @branchPruned_clone(%struct.HighType* byval nocapture align 8 %obj) #3 {
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define void @initialize_clone.1(%struct.HighType* nocapture %obj) #0 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 569
  store i32 127, i32* %1, align 4
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 335
  store i32 78, i32* %2, align 4
  %3 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 534
  store i32 48, i32* %3, align 4
  %4 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 645
  store i8 56, i8* %4, align 1
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 902
  store i8 117, i8* %5, align 2
  %6 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 966
  store i32 3, i32* %6, align 4
  %7 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 316
  store i32 51, i32* %7, align 4
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 987
  store i32 119, i32* %8, align 4
  %9 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 253
  store i8 126, i8* %9, align 1
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 879
  store i8 48, i8* %10, align 1
  ret void
}

; Function Attrs: norecurse nounwind readnone uwtable
define void @branchPruned_clone.2(%struct.HighType* byval nocapture align 8 %obj) #3 {
  ret void
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { norecurse nounwind readnone uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
