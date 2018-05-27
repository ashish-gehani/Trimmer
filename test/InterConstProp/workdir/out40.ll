; ModuleID = 'workdir/out40.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { i32, i32, i8* }

@.str.2 = private unnamed_addr constant [12 x i8] c"helloworld0\00", align 1
@st = global %struct.stType { i32 0, i32 0, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0) }, align 8
@0 = internal constant [2 x i8] c"0\00"
@str.1 = private unnamed_addr constant [15 x i8] c"branchPruned 3\00"
@str.2 = private unnamed_addr constant [20 x i8] c"it is equal to zero\00"
@str.3 = private unnamed_addr constant [19 x i8] c"it is equal to one\00"
@str.4 = private unnamed_addr constant [15 x i8] c"branchPruned 5\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(i32 %x) #0 {
  switch i32 %x, label %3 [
    i32 3, label %1
    i32 5, label %2
  ]

; <label>:1                                       ; preds = %0
  %puts1 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([15 x i8], [15 x i8]* @str.1, i64 0, i64 0))
  br label %3

; <label>:2                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([15 x i8], [15 x i8]* @str.4, i64 0, i64 0))
  br label %3

; <label>:3                                       ; preds = %2, %0, %1
  ret void
}

; Function Attrs: nounwind readonly uwtable
define signext i8 @checkSt() #1 {
  %1 = load i64, i64* bitcast (%struct.stType* @st to i64*), align 8
  %2 = lshr i64 %1, 32
  %3 = or i64 %2, %1
  %4 = trunc i64 %3 to i32
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %10

; <label>:6                                       ; preds = %0
  %7 = load i8*, i8** getelementptr inbounds (%struct.stType, %struct.stType* @st, i64 0, i32 2), align 8
  %8 = tail call i32 @strcmp(i8* %7, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0)) #5
  %9 = icmp eq i32 %8, 0
  br label %10

; <label>:10                                      ; preds = %6, %0
  %11 = phi i1 [ false, %0 ], [ %9, %6 ]
  %12 = zext i1 %11 to i8
  ret i8 %12
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #2

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readonly %argv) #0 {
  %1 = getelementptr inbounds i8*, i8** %argv, i64 1
  %2 = load i8*, i8** %1, align 8
  %3 = tail call i32 @strcmp(i8* %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @0, i64 0, i64 0)) #5
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([20 x i8], [20 x i8]* @str.2, i64 0, i64 0))
  br label %7

; <label>:6                                       ; preds = %0
  %puts1 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([19 x i8], [19 x i8]* @str.3, i64 0, i64 0))
  %puts.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([15 x i8], [15 x i8]* @str.4, i64 0, i64 0)) #4
  br label %7

; <label>:7                                       ; preds = %5, %6
  ret i32 0
}

; Function Attrs: norecurse nounwind readnone uwtable
define signext i8 @checkSt_clone() #3 {
  ret i8 1
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(i32 %x) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @str.4, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { norecurse nounwind readnone uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
