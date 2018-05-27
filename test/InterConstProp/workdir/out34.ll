; ModuleID = 'workdir/out34.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.2 = private unnamed_addr constant [19 x i8] c"inter31_fileio.txt\00", align 1
@str.1 = private unnamed_addr constant [15 x i8] c"file not found\00"
@str.2 = private unnamed_addr constant [13 x i8] c"branchPruned\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(i32 %size, i8* nocapture readonly %buffer) #0 {
  %1 = icmp eq i32 %size, 10
  br i1 %1, label %2, label %6

; <label>:2                                       ; preds = %0
  %3 = tail call i32 @strcmp(i8* %buffer, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #4
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %2
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @str.2, i64 0, i64 0))
  br label %6

; <label>:6                                       ; preds = %2, %5, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %buffer = alloca [100 x i8], align 16
  %1 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i64 0, i64 0
  call void @externalFunc(i8* %1) #3
  %2 = call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.2, i64 0, i64 0), i32 0) #3
  %3 = icmp slt i32 %2, 0
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  %puts = call i32 @puts(i8* nonnull getelementptr inbounds ([15 x i8], [15 x i8]* @str.1, i64 0, i64 0))
  br label %5

; <label>:5                                       ; preds = %4, %0
  %6 = call i64 @read(i32 %2, i8* %1, i64 100) #3
  %7 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i64 0, i64 10
  store i8 0, i8* %7, align 2
  %puts.i = call i32 @puts(i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @str.2, i64 0, i64 0)) #3
  ret i32 0
}

declare void @externalFunc(i8*) #2

declare i32 @open(i8* nocapture readonly, i32, ...) #2

declare i64 @read(i32, i8* nocapture, i64) #2

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(i32 %size, i8* nocapture readnone %buffer) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.2, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #3

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
