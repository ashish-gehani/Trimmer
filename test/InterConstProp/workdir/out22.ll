; ModuleID = 'workdir/out22.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { i32, i32, i8*, {}* }

@.str = private unnamed_addr constant [12 x i8] c"helloworld0\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"helloworld1\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloworld2\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloworld3\00", align 1
@st = global <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }> <{ { i32, i32, i8*, void (%struct.stType*)* } { i32 0, i32 0, i8* null, void (%struct.stType*)* @init0 }, { i32, i32, i8*, void (%struct.stType*)* } { i32 0, i32 0, i8* null, void (%struct.stType*)* @init1 }, { i32, i32, i8*, void (%struct.stType*)* } { i32 0, i32 0, i8* null, void (%struct.stType*)* @init2 }, { i32, i32, i8*, void (%struct.stType*)* } { i32 0, i32 0, i8* null, void (%struct.stType*)* @init3 } }>, align 16
@str.1 = private unnamed_addr constant [13 x i8] c"branchPruned\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType* nocapture readonly %st) #0 {
  %1 = bitcast %struct.stType* %st to i64*
  %2 = load i64, i64* %1, align 8
  %3 = trunc i64 %2 to i32
  %4 = icmp eq i32 %3, 0
  %5 = icmp ult i64 %2, 4294967296
  %or.cond = and i1 %4, %5
  br i1 %or.cond, label %6, label %42

; <label>:6                                       ; preds = %0
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 2
  %8 = load i8*, i8** %7, align 8
  %9 = tail call i32 @strcmp(i8* %8, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0)) #5
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %42

; <label>:11                                      ; preds = %6
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 1, i32 0
  %13 = bitcast i32* %12 to i64*
  %14 = load i64, i64* %13, align 8
  %15 = icmp eq i64 %14, 4294967297
  br i1 %15, label %16, label %42

; <label>:16                                      ; preds = %11
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 1, i32 2
  %18 = load i8*, i8** %17, align 8
  %19 = tail call i32 @strcmp(i8* %18, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0)) #5
  %20 = icmp eq i32 %19, 0
  br i1 %20, label %21, label %42

; <label>:21                                      ; preds = %16
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 2, i32 0
  %23 = bitcast i32* %22 to i64*
  %24 = load i64, i64* %23, align 8
  %25 = icmp eq i64 %24, 8589934594
  br i1 %25, label %26, label %42

; <label>:26                                      ; preds = %21
  %27 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 2, i32 2
  %28 = load i8*, i8** %27, align 8
  %29 = tail call i32 @strcmp(i8* %28, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0)) #5
  %30 = icmp eq i32 %29, 0
  br i1 %30, label %31, label %42

; <label>:31                                      ; preds = %26
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 3, i32 0
  %33 = bitcast i32* %32 to i64*
  %34 = load i64, i64* %33, align 8
  %35 = icmp eq i64 %34, 12884901891
  br i1 %35, label %36, label %42

; <label>:36                                      ; preds = %31
  %37 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 3, i32 2
  %38 = load i8*, i8** %37, align 8
  %39 = tail call i32 @strcmp(i8* %38, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0)) #5
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %41, label %42

; <label>:41                                      ; preds = %36
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @str.1, i64 0, i64 0))
  br label %42

; <label>:42                                      ; preds = %36, %26, %16, %6, %41, %31, %21, %11, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define void @init0(%struct.stType* nocapture %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0
  store i32 0, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 1
  store i32 0, i32* %2, align 4
  %3 = tail call noalias i8* @malloc(i64 100) #4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 2
  store i8* %3, i8** %4, align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind uwtable
define void @init1(%struct.stType* nocapture %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0
  store i32 1, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 1
  store i32 1, i32* %2, align 4
  %3 = tail call noalias i8* @malloc(i64 100) #4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 2
  store i8* %3, i8** %4, align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @init2(%struct.stType* nocapture %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0
  store i32 2, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 1
  store i32 2, i32* %2, align 4
  %3 = tail call noalias i8* @malloc(i64 100) #4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 2
  store i8* %3, i8** %4, align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @init3(%struct.stType* nocapture %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0
  store i32 3, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 1
  store i32 3, i32* %2, align 4
  %3 = tail call noalias i8* @malloc(i64 100) #4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 2
  store i8* %3, i8** %4, align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  store i32 0, i32* getelementptr inbounds (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>, <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st, i64 0, i32 0, i32 0), align 16
  store i32 0, i32* getelementptr inbounds (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>, <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st, i64 0, i32 0, i32 1), align 4
  %1 = tail call noalias i8* @malloc(i64 100) #4
  store i8* %1, i8** getelementptr inbounds (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>, <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st, i64 0, i32 0, i32 2), align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0), i64 100, i32 1, i1 false) #4
  store i32 1, i32* getelementptr inbounds (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>, <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st, i64 0, i32 1, i32 0), align 8
  store i32 1, i32* getelementptr inbounds (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>, <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st, i64 0, i32 1, i32 1), align 4
  %2 = tail call noalias i8* @malloc(i64 100) #4
  store i8* %2, i8** getelementptr inbounds (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>, <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st, i64 0, i32 1, i32 2), align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false) #4
  store i32 2, i32* getelementptr inbounds (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>, <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st, i64 0, i32 2, i32 0), align 16
  store i32 2, i32* getelementptr inbounds (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>, <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st, i64 0, i32 2, i32 1), align 4
  %3 = tail call noalias i8* @malloc(i64 100) #4
  store i8* %3, i8** getelementptr inbounds (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>, <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st, i64 0, i32 2, i32 2), align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0), i64 100, i32 1, i1 false) #4
  store i32 3, i32* getelementptr inbounds (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>, <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st, i64 0, i32 3, i32 0), align 8
  store i32 3, i32* getelementptr inbounds (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>, <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st, i64 0, i32 3, i32 1), align 4
  %4 = tail call noalias i8* @malloc(i64 100) #4
  store i8* %4, i8** getelementptr inbounds (<{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>, <{ { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* }, { i32, i32, i8*, void (%struct.stType*)* } }>* @st, i64 0, i32 3, i32 2), align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %4, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 100, i32 1, i1 false) #4
  %puts.i = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.1, i64 0, i64 0)) #4
  ret i32 0
}

; Function Attrs: nounwind uwtable
define void @init0_clone(%struct.stType* nocapture %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0
  store i32 0, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 1
  store i32 0, i32* %2, align 4
  %3 = tail call noalias i8* @malloc(i64 100) #4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 2
  store i8* %3, i8** %4, align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @init1_clone(%struct.stType* nocapture %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0
  store i32 1, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 1
  store i32 1, i32* %2, align 4
  %3 = tail call noalias i8* @malloc(i64 100) #4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 2
  store i8* %3, i8** %4, align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @init2_clone(%struct.stType* nocapture %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0
  store i32 2, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 1
  store i32 2, i32* %2, align 4
  %3 = tail call noalias i8* @malloc(i64 100) #4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 2
  store i8* %3, i8** %4, align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @init3_clone(%struct.stType* nocapture %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 0
  store i32 3, i32* %1, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 1
  store i32 3, i32* %2, align 4
  %3 = tail call noalias i8* @malloc(i64 100) #4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %st, i64 0, i32 2
  store i8* %3, i8** %4, align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType* nocapture readnone %st) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.1, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
