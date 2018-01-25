; ModuleID = 'workdir/out7.bc'
source_filename = "inter7.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD, [100 x i8], [8 x i32] }
%struct.COORD = type { i32, i32 }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@str.1 = private unnamed_addr constant [18 x i8] c"*** Branch Taken \00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType* byval nocapture readonly align 8) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0, i32 0
  %3 = load i32, i32* %2, align 8
  %4 = icmp eq i32 %3, 4
  br i1 %4, label %5, label %26

; <label>:5:                                      ; preds = %1
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0, i32 1
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 %7, 8
  br i1 %8, label %9, label %26

; <label>:9:                                      ; preds = %5
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 2, i64 1
  %11 = load i32, i32* %10, align 4
  %12 = icmp eq i32 %11, 12
  br i1 %12, label %13, label %26

; <label>:13:                                     ; preds = %9
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 1, i64 0
  %15 = call i32 @strcmp(i8* %14, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #4
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %26

; <label>:17:                                     ; preds = %13
  %18 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 1, i64 4
  %19 = load i8, i8* %18, align 4
  %20 = icmp eq i8 %19, 111
  br i1 %20, label %21, label %26

; <label>:21:                                     ; preds = %17
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 1, i64 9
  %23 = load i8, i8* %22, align 1
  %24 = icmp eq i8 %23, 100
  br i1 %24, label %25, label %26

; <label>:25:                                     ; preds = %21
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.1, i64 0, i64 0))
  br label %26

; <label>:26:                                     ; preds = %13, %25, %21, %17, %9, %5, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #1

; Function Attrs: noinline nounwind uwtable
define void @initialize(%struct.stType* nocapture) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0, i32 0
  store i32 4, i32* %2, align 4
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0, i32 1
  store i32 8, i32* %3, align 4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 2, i64 0
  store i32 12, i32* %4, align 4
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 2, i64 1
  store i32 12, i32* %5, align 4
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 2, i64 2
  store i32 12, i32* %6, align 4
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: noinline nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.stType, align 8
  call void @initialize_clone(%struct.stType* nonnull %1)
  call void @branchPruned_clone(%struct.stType* nonnull %1)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone(%struct.stType* nocapture) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0, i32 0
  store i32 4, i32* %2, align 4
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0, i32 1
  store i32 8, i32* %3, align 4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 2, i64 0
  store i32 12, i32* %4, align 4
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 2, i64 1
  store i32 12, i32* %5, align 4
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 2, i64 2
  store i32 12, i32* %6, align 4
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.stType* byval nocapture readnone align 8) local_unnamed_addr #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.1, i64 0, i64 0))
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
