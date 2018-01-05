; ModuleID = 'workdir/out17.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD, [100 x i8], [8 x i32] }
%struct.COORD = type { i32, i32 }

@.str.3 = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.5 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 8
@str = private unnamed_addr constant [12 x i8] c"str matches\00"
@str.1 = private unnamed_addr constant [12 x i8] c"arr matches\00"
@str.2 = private unnamed_addr constant [10 x i8] c"y matches\00"
@str.5 = private unnamed_addr constant [10 x i8] c"x matches\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType* byval nocapture readonly align 8 %obj) #0 {
  %1 = bitcast %struct.stType* %obj to i64*
  %2 = load i64, i64* %1, align 8
  %3 = trunc i64 %2 to i32
  %4 = icmp eq i32 %3, 4
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  %puts3 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([10 x i8], [10 x i8]* @str.5, i64 0, i64 0))
  br label %19

; <label>:6                                       ; preds = %0
  %.mask = and i64 %2, -4294967296
  %7 = icmp eq i64 %.mask, 34359738368
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %6
  %puts2 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([10 x i8], [10 x i8]* @str.2, i64 0, i64 0))
  br label %19

; <label>:9                                       ; preds = %6
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 2, i64 1
  %11 = load i32, i32* %10, align 4
  %12 = icmp eq i32 %11, 12
  br i1 %12, label %13, label %14

; <label>:13                                      ; preds = %9
  %puts1 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @str.1, i64 0, i64 0))
  br label %19

; <label>:14                                      ; preds = %9
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i64 0, i32 1, i64 0
  %16 = call i32 @strcmp(i8* %15, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.3, i64 0, i64 0)) #5
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %19

; <label>:18                                      ; preds = %14
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @str, i64 0, i64 0))
  br label %19

; <label>:19                                      ; preds = %14, %8, %18, %13, %5
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: norecurse nounwind uwtable
define void @initialize(%struct.stType* nocapture %obj) #2 {
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
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i64 0, i64 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %puts.i = tail call i32 @puts(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.5, i64 0, i64 0)) #4
  ret i32 0
}

; Function Attrs: norecurse nounwind uwtable
define void @initialize_clone(%struct.stType* nocapture %obj) #2 {
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
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i64 0, i64 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType* byval nocapture readnone align 8 %obj) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.5, i64 0, i64 0))
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define void @initialize_clone_clone(%struct.stType* nocapture %obj) #2 {
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
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i64 0, i64 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone_clone(%struct.stType* byval nocapture readnone align 8 %obj) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.5, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
