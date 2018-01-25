; ModuleID = 'workdir/inter2t3.bc'
source_filename = "inter2.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"ielloWorld\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"ialloWorld\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"branchNotPruned\0A\00", align 1
@buffer = common global [100 x i8] zeroinitializer, align 16
@.str.4 = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@0 = constant [11 x i8] c"ielloWorld\00"
@1 = constant [11 x i8] c"ialloWorld\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(i8*) #0 {
  %2 = getelementptr inbounds i8, i8* %0, i64 0
  %3 = load i8, i8* %2, align 1
  %4 = sext i8 %3 to i32
  %5 = icmp eq i32 %4, 105
  br i1 %5, label %6, label %8

; <label>:6:                                      ; preds = %1
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i32 0, i32 0))
  br label %8

; <label>:8:                                      ; preds = %6, %1
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned(i8*) #0 {
  %2 = getelementptr inbounds i8, i8* %0, i64 1
  %3 = load i8, i8* %2, align 1
  %4 = sext i8 %3 to i32
  %5 = icmp eq i32 %4, 97
  br i1 %5, label %17, label %6

; <label>:6:                                      ; preds = %1
  %7 = getelementptr inbounds i8, i8* %0, i64 1
  %8 = load i8, i8* %7, align 1
  %9 = sext i8 %8 to i32
  %10 = icmp eq i32 %9, 101
  br i1 %10, label %17, label %11

; <label>:11:                                     ; preds = %6
  %12 = call i32 @strcmp(i8* %0, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0)) #4
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %17, label %14

; <label>:14:                                     ; preds = %11
  %15 = call i32 @strcmp(i8* %0, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i32 0, i32 0)) #4
  %16 = icmp ne i32 %15, 0
  br i1 %16, label %17, label %19

; <label>:17:                                     ; preds = %14, %11, %6, %1
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i32 0, i32 0))
  br label %19

; <label>:19:                                     ; preds = %17, %14
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

; Function Attrs: noinline nounwind uwtable
define void @modify(i8*, i32, i32) #0 {
  %4 = icmp eq i32 %1, 3
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = getelementptr inbounds i8, i8* %0, i64 0
  store i8 105, i8* %6, align 1
  br label %7

; <label>:7:                                      ; preds = %5, %3
  %8 = icmp eq i32 %2, 5
  br i1 %8, label %9, label %11

; <label>:9:                                      ; preds = %7
  %10 = getelementptr inbounds i8, i8* %0, i64 1
  store i8 97, i8* %10, align 1
  br label %11

; <label>:11:                                     ; preds = %9, %7
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i32 0, i32 0), i64 100, i32 1, i1 false)
  call void @modify_clone(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i32 0, i32 0), i32 3, i32 %0)
  call void @branchPruned_clone(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i32 0, i32 0))
  call void @branchNotPruned_clone(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i32 0, i32 0))
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline nounwind uwtable
define void @modify_clone(i8*, i32, i32) #0 {
  %4 = icmp eq i32 3, 3
  br i1 true, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = getelementptr inbounds i8, i8* %0, i64 0
  store i8 105, i8* %6, align 1
  br label %7

; <label>:7:                                      ; preds = %5, %3
  %8 = icmp eq i32 %2, 5
  br i1 %8, label %9, label %11

; <label>:9:                                      ; preds = %7
  %10 = getelementptr inbounds i8, i8* %0, i64 1
  store i8 97, i8* %10, align 1
  br label %11

; <label>:11:                                     ; preds = %9, %7
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(i8*) #0 {
  %2 = getelementptr inbounds i8, i8* %0, i64 0
  %3 = load i8, i8* %2, align 1
  %4 = sext i8 105 to i32
  %5 = icmp eq i32 105, 105
  br i1 true, label %6, label %8

; <label>:6:                                      ; preds = %1
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i32 0, i32 0))
  br label %8

; <label>:8:                                      ; preds = %6, %1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned_clone(i8*) #0 {
  %2 = getelementptr inbounds i8, i8* %0, i64 1
  %3 = load i8, i8* %2, align 1
  %4 = sext i8 %3 to i32
  %5 = icmp eq i32 %4, 97
  br i1 %5, label %19, label %6

; <label>:6:                                      ; preds = %1
  %7 = getelementptr inbounds i8, i8* %0, i64 1
  %8 = load i8, i8* %7, align 1
  %9 = sext i8 %8 to i32
  %10 = icmp eq i32 %9, 101
  br i1 %10, label %19, label %11

; <label>:11:                                     ; preds = %6
  %12 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %13 = call i32 @strcmp(i8* %0, i8* %12) #4
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %19, label %15

; <label>:15:                                     ; preds = %11
  %16 = getelementptr [11 x i8], [11 x i8]* @1, i64 0, i64 0
  %17 = call i32 @strcmp(i8* %0, i8* %16) #4
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %21

; <label>:19:                                     ; preds = %15, %11, %6, %1
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i32 0, i32 0))
  br label %21

; <label>:21:                                     ; preds = %19, %15
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
