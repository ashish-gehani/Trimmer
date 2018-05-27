; ModuleID = 'workdir/out8.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.HighType = type { %struct.LowTypeString, %struct.LowTypeInt }
%struct.LowTypeString = type { [1000 x i8], [1000 x i8] }
%struct.LowTypeInt = type { [1000 x i32], [1000 x i32] }

@.str = private unnamed_addr constant [4 x i8] c"ygx\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"afwik\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"xawjt\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"meaj\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"oqmop\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"*** branchTaken\00", align 1

; Function Attrs: norecurse nounwind uwtable
define void @initialize(%struct.HighType* nocapture %obj) #0 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 569
  store i32 122, i32* %1, align 4
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 335
  store i32 112, i32* %2, align 4
  %3 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 534
  store i32 106, i32* %3, align 4
  %4 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 645
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %4, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i64 3, i32 1, i1 false)
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 131
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i64 5, i32 1, i1 false)
  %6 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 987
  store i32 121, i32* %6, align 4
  %7 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 253
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i64 5, i32 1, i1 false)
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 649
  store i32 116, i32* %8, align 4
  %9 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 276
  %10 = bitcast i8* %9 to i32*
  store i32 1784767853, i32* %10, align 1
  %11 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 225
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %11, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), i64 5, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.HighType* byval readonly align 8 %obj) #2 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 225
  %2 = load i8, i8* %1, align 1
  %3 = icmp eq i8 %2, 111
  br i1 %3, label %4, label %88

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 226
  %6 = bitcast i8* %5 to i16*
  %7 = load i16, i16* %6, align 2
  %8 = icmp eq i16 %7, 28017
  br i1 %8, label %9, label %88

; <label>:9                                       ; preds = %4
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 228
  %11 = bitcast i8* %10 to i16*
  %12 = load i16, i16* %11, align 4
  %13 = icmp eq i16 %12, 28783
  br i1 %13, label %14, label %88

; <label>:14                                      ; preds = %9
  %15 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 131
  %16 = load i8, i8* %15, align 1
  %17 = icmp eq i8 %16, 97
  br i1 %17, label %18, label %88

; <label>:18                                      ; preds = %14
  %19 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 132
  %20 = bitcast i8* %19 to i32*
  %21 = load i32, i32* %20, align 4
  %22 = icmp eq i32 %21, 1802073958
  br i1 %22, label %23, label %88

; <label>:23                                      ; preds = %18
  %24 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 253
  %25 = load i8, i8* %24, align 1
  %26 = icmp eq i8 %25, 120
  br i1 %26, label %27, label %88

; <label>:27                                      ; preds = %23
  %28 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 254
  %29 = bitcast i8* %28 to i16*
  %30 = load i16, i16* %29, align 2
  %31 = icmp eq i16 %30, 30561
  br i1 %31, label %32, label %88

; <label>:32                                      ; preds = %27
  %33 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 256
  %34 = bitcast i8* %33 to i16*
  %35 = load i16, i16* %34, align 8
  %36 = icmp eq i16 %35, 29802
  br i1 %36, label %37, label %88

; <label>:37                                      ; preds = %32
  %38 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 276
  %39 = bitcast i8* %38 to i32*
  %40 = load i32, i32* %39, align 4
  %41 = icmp eq i32 %40, 1784767853
  br i1 %41, label %42, label %88

; <label>:42                                      ; preds = %37
  %43 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 645
  %44 = load i8, i8* %43, align 1
  %45 = icmp eq i8 %44, 121
  br i1 %45, label %46, label %88

; <label>:46                                      ; preds = %42
  %47 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 646
  %48 = bitcast i8* %47 to i16*
  %49 = load i16, i16* %48, align 2
  %50 = icmp eq i16 %49, 30823
  br i1 %50, label %51, label %88

; <label>:51                                      ; preds = %46
  %52 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 335
  %53 = load i32, i32* %52, align 4
  %54 = icmp eq i32 %53, 112
  br i1 %54, label %55, label %88

; <label>:55                                      ; preds = %51
  %56 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 534
  %57 = load i32, i32* %56, align 8
  %58 = icmp eq i32 %57, 106
  br i1 %58, label %59, label %88

; <label>:59                                      ; preds = %55
  %60 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 569
  %61 = load i32, i32* %60, align 4
  %62 = icmp eq i32 %61, 122
  br i1 %62, label %63, label %88

; <label>:63                                      ; preds = %59
  %64 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 649
  %65 = load i32, i32* %64, align 4
  %66 = icmp eq i32 %65, 116
  br i1 %66, label %67, label %88

; <label>:67                                      ; preds = %63
  %68 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 987
  %69 = load i32, i32* %68, align 4
  %70 = icmp eq i32 %69, 121
  br i1 %70, label %71, label %88

; <label>:71                                      ; preds = %67
  %72 = call i32 @strcmp(i8* nonnull %1, i8* nonnull getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0)) #5
  %73 = icmp eq i32 %72, 0
  br i1 %73, label %74, label %88

; <label>:74                                      ; preds = %71
  %75 = call i32 @strcmp(i8* nonnull %43, i8* nonnull getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0)) #5
  %76 = icmp eq i32 %75, 0
  br i1 %76, label %77, label %88

; <label>:77                                      ; preds = %74
  %78 = call i32 @strcmp(i8* nonnull %15, i8* nonnull getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0)) #5
  %79 = icmp eq i32 %78, 0
  br i1 %79, label %80, label %88

; <label>:80                                      ; preds = %77
  %81 = call i32 @strcmp(i8* nonnull %24, i8* nonnull getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)) #5
  %82 = icmp eq i32 %81, 0
  br i1 %82, label %83, label %88

; <label>:83                                      ; preds = %80
  %84 = call i32 @strcmp(i8* nonnull %38, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i64 0, i64 0)) #5
  %85 = icmp eq i32 %84, 0
  br i1 %85, label %86, label %88

; <label>:86                                      ; preds = %83
  %87 = tail call i32 (i8*, ...) @printf(i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0))
  br label %88

; <label>:88                                      ; preds = %83, %80, %77, %74, %71, %86, %67, %63, %59, %55, %51, %46, %42, %37, %32, %27, %23, %18, %14, %9, %4, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #3

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #4

; Function Attrs: nounwind uwtable
define i32 @main() #2 {
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0)) #6
  ret i32 0
}

; Function Attrs: norecurse nounwind uwtable
define void @initialize_clone(%struct.HighType* nocapture %obj) #0 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 569
  store i32 122, i32* %1, align 4
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 335
  store i32 112, i32* %2, align 4
  %3 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 534
  store i32 106, i32* %3, align 4
  %4 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 645
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %4, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i64 3, i32 1, i1 false)
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 131
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i64 5, i32 1, i1 false)
  %6 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 987
  store i32 121, i32* %6, align 4
  %7 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 253
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i64 5, i32 1, i1 false)
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 649
  store i32 116, i32* %8, align 4
  %9 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 276
  %10 = bitcast i8* %9 to i32*
  store i32 1784767853, i32* %10, align 1
  %11 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 225
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %11, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), i64 5, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.HighType* byval nocapture readnone align 8 %obj) #2 {
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0))
  ret void
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
