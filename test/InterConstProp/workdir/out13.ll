; ModuleID = 'workdir/out13.bc'
source_filename = "inter13.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { [100 x i8], [8 x i32] }

@.str.1 = private constant [11 x i8] c"helloWorld\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"hellogorld\00\00", align 1
@.str.4 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@str.2 = private unnamed_addr constant [17 x i8] c"*** Branch Taken\00"
@str.3 = private unnamed_addr constant [21 x i8] c"*** Branch Not Taken\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType* byval nocapture readonly align 8) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 1, i64 0
  %3 = load i32, i32* %2, align 4
  %4 = icmp eq i32 %3, 27
  br i1 %4, label %5, label %10

; <label>:5:                                      ; preds = %1
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 1, i64 7
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 %7, 55
  br i1 %8, label %9, label %10

; <label>:9:                                      ; preds = %5
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @str.2, i64 0, i64 0))
  br label %10

; <label>:10:                                     ; preds = %9, %5, %1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned(%struct.stType* byval nocapture readonly align 8) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0, i64 0
  %3 = call i32 @strcmp(i8* nonnull %2, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0)) #4
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %14

; <label>:5:                                      ; preds = %1
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0, i64 4
  %7 = load i8, i8* %6, align 4
  %8 = icmp eq i8 %7, 111
  br i1 %8, label %9, label %14

; <label>:9:                                      ; preds = %5
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0, i64 9
  %11 = load i8, i8* %10, align 1
  %12 = icmp eq i8 %11, 100
  br i1 %12, label %13, label %14

; <label>:13:                                     ; preds = %9
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @str.3, i64 0, i64 0))
  br label %14

; <label>:14:                                     ; preds = %1, %13, %9, %5
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #1

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8** nocapture readnone) local_unnamed_addr #0 {
  %3 = alloca %struct.stType, align 8
  %4 = icmp eq i32 %0, 1
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %3, i64 0, i32 0, i64 0
  br i1 %4, label %6, label %7

; <label>:6:                                      ; preds = %2
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %5, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  br label %8

; <label>:7:                                      ; preds = %2
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %5, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.4, i64 0, i64 0), i64 11, i32 1, i1 false)
  br label %8

; <label>:8:                                      ; preds = %7, %6
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %3, i64 0, i32 1, i64 0
  store i32 27, i32* %9, align 4
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %3, i64 0, i32 1, i64 7
  store i32 55, i32* %10, align 4
  call void @branchPruned_clone(%struct.stType* nonnull %3)
  call void @branchNotPruned_clone(%struct.stType* nonnull %3)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.stType* byval nocapture readnone align 8) local_unnamed_addr #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @str.2, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned_clone(%struct.stType* byval nocapture readonly align 8) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0, i64 0
  %3 = call i32 @strcmp(i8* nonnull %2, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0)) #4
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %1
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @str.3, i64 0, i64 0))
  br label %6

; <label>:6:                                      ; preds = %1, %5
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #3

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
