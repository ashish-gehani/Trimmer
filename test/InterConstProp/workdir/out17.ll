; ModuleID = 'workdir/out17.bc'
source_filename = "inter17.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD, [100 x i8], [8 x i32] }
%struct.COORD = type { i32, i32 }

@.str.3 = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.5 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@str = private unnamed_addr constant [12 x i8] c"str matches\00"
@str.1 = private unnamed_addr constant [12 x i8] c"arr matches\00"
@str.2 = private unnamed_addr constant [10 x i8] c"y matches\00"
@str.4 = private unnamed_addr constant [10 x i8] c"x matches\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType* byval nocapture readonly align 8) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0, i32 0
  %3 = load i32, i32* %2, align 8
  %4 = icmp eq i32 %3, 4
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %1
  %puts3 = tail call i32 @puts(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.4, i64 0, i64 0))
  br label %21

; <label>:6:                                      ; preds = %1
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 %8, 8
  br i1 %9, label %10, label %11

; <label>:10:                                     ; preds = %6
  %puts2 = tail call i32 @puts(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.2, i64 0, i64 0))
  br label %21

; <label>:11:                                     ; preds = %6
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 2, i64 1
  %13 = load i32, i32* %12, align 4
  %14 = icmp eq i32 %13, 12
  br i1 %14, label %15, label %16

; <label>:15:                                     ; preds = %11
  %puts1 = tail call i32 @puts(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @str.1, i64 0, i64 0))
  br label %21

; <label>:16:                                     ; preds = %11
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 0, i32 1, i64 0
  %18 = call i32 @strcmp(i8* %17, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.3, i64 0, i64 0)) #4
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %21

; <label>:20:                                     ; preds = %16
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @str, i64 0, i64 0))
  br label %21

; <label>:21:                                     ; preds = %16, %10, %20, %15, %5
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
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i64 0, i64 0), i64 11, i32 1, i1 false)
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
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i64 0, i64 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.stType* byval nocapture readnone align 8) local_unnamed_addr #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.4, i64 0, i64 0))
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
