; ModuleID = 'workdir/out13.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { [100 x i8], [8 x i32] }

@.str.1 = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"hellogorld\00\00", align 1
@.str.4 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@str.4 = private unnamed_addr constant [17 x i8] c"*** Branch Taken\00"
@str.5 = private unnamed_addr constant [21 x i8] c"*** Branch Not Taken\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType* byval nocapture readonly align 8 %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 1, i64 0
  %2 = load i32, i32* %1, align 4
  %3 = icmp eq i32 %2, 27
  br i1 %3, label %4, label %9

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 1, i64 7
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 55
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %4
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([17 x i8], [17 x i8]* @str.4, i64 0, i64 0))
  br label %9

; <label>:9                                       ; preds = %8, %4, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned(%struct.stType* byval nocapture readonly align 8 %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0, i64 0
  %2 = call i32 @strcmp(i8* %1, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0)) #4
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %13

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0, i64 4
  %6 = load i8, i8* %5, align 4
  %7 = icmp eq i8 %6, 111
  br i1 %7, label %8, label %13

; <label>:8                                       ; preds = %4
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0, i64 9
  %10 = load i8, i8* %9, align 1
  %11 = icmp eq i8 %10, 100
  br i1 %11, label %12, label %13

; <label>:12                                      ; preds = %8
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([21 x i8], [21 x i8]* @str.5, i64 0, i64 0))
  br label %13

; <label>:13                                      ; preds = %0, %12, %8, %4
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %st2 = alloca %struct.stType, align 8
  %st.sroa.0 = alloca [100 x i8], align 8
  %st.sroa.6 = alloca [6 x i32], align 8
  %1 = icmp eq i32 %argc, 1
  %2 = getelementptr inbounds [100 x i8], [100 x i8]* %st.sroa.0, i64 0, i64 0
  br i1 %1, label %3, label %4

; <label>:3                                       ; preds = %0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 11, i32 1, i1 false)
  br label %branchPruned.exit

; <label>:4                                       ; preds = %0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.4, i64 0, i64 0), i64 11, i32 1, i1 false)
  br label %branchPruned.exit

branchPruned.exit:                                ; preds = %3, %4
  %5 = bitcast [6 x i32]* %st.sroa.6 to i8*
  %puts.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([17 x i8], [17 x i8]* @str.4, i64 0, i64 0)) #3
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %st2, i64 0, i32 0, i64 0
  call void @llvm.lifetime.start(i64 132, i8* %6)
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* nonnull %2, i64 100, i32 8, i1 false)
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %st2, i64 0, i32 1, i64 0
  store i32 27, i32* %7, align 4
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %st2, i64 0, i32 1, i64 1
  %9 = bitcast i32* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %9, i8* %5, i64 24, i32 4, i1 false)
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %st2, i64 0, i32 1, i64 7
  store i32 55, i32* %10, align 4
  %11 = call i32 @strcmp(i8* %6, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0)) #4
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %branchNotPruned.exit

; <label>:13                                      ; preds = %branchPruned.exit
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %st2, i64 0, i32 0, i64 4
  %15 = load i8, i8* %14, align 4
  %16 = icmp eq i8 %15, 111
  br i1 %16, label %17, label %branchNotPruned.exit

; <label>:17                                      ; preds = %13
  %18 = getelementptr inbounds %struct.stType, %struct.stType* %st2, i64 0, i32 0, i64 9
  %19 = load i8, i8* %18, align 1
  %20 = icmp eq i8 %19, 100
  br i1 %20, label %21, label %branchNotPruned.exit

; <label>:21                                      ; preds = %17
  %puts.i3 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([21 x i8], [21 x i8]* @str.5, i64 0, i64 0)) #3
  br label %branchNotPruned.exit

branchNotPruned.exit:                             ; preds = %branchPruned.exit, %13, %17, %21
  call void @llvm.lifetime.end(i64 132, i8* %6)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType* byval nocapture readnone align 8 %st) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @str.4, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(%struct.stType* byval nocapture readonly align 8 %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0, i64 0
  %2 = call i32 @strcmp(i8* %1, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0)) #4
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %13

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0, i64 4
  %6 = load i8, i8* %5, align 4
  %7 = icmp eq i8 %6, 111
  br i1 %7, label %8, label %13

; <label>:8                                       ; preds = %4
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0, i64 9
  %10 = load i8, i8* %9, align 1
  %11 = icmp eq i8 %10, 100
  br i1 %11, label %12, label %13

; <label>:12                                      ; preds = %8
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([21 x i8], [21 x i8]* @str.5, i64 0, i64 0))
  br label %13

; <label>:13                                      ; preds = %0, %12, %8, %4
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone.1(%struct.stType* byval nocapture readnone align 8 %st) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @str.4, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone.2(%struct.stType* byval nocapture readonly align 8 %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0, i64 0
  %2 = call i32 @strcmp(i8* %1, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0)) #4
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %13

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0, i64 4
  %6 = load i8, i8* %5, align 4
  %7 = icmp eq i8 %6, 111
  br i1 %7, label %8, label %13

; <label>:8                                       ; preds = %4
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0, i64 9
  %10 = load i8, i8* %9, align 1
  %11 = icmp eq i8 %10, 100
  br i1 %11, label %12, label %13

; <label>:12                                      ; preds = %8
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([21 x i8], [21 x i8]* @str.5, i64 0, i64 0))
  br label %13

; <label>:13                                      ; preds = %0, %12, %8, %4
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
