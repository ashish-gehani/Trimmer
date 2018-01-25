; ModuleID = 'workdir/inter24t2.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { i32, i32, i8* }

@st = global [4 x %struct.stType] [%struct.stType { i32 0, i32 0, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0) }, %struct.stType { i32 1, i32 1, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0) }, %struct.stType { i32 2, i32 2, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.4, i32 0, i32 0) }, %struct.stType { i32 3, i32 3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i32 0, i32 0) }], align 16
@.str.2 = private unnamed_addr constant [12 x i8] c"helloworld0\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"helloworld1\00", align 1
@.str.4 = private unnamed_addr constant [12 x i8] c"helloworld2\00", align 1
@.str.5 = private unnamed_addr constant [12 x i8] c"helloworld3\00", align 1
@.str = private unnamed_addr constant [11 x i8] c"helloworld\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType*) #0 {
  %2 = alloca [11 x i8], align 1
  %3 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0), i64 10, i32 1, i1 false)
  br label %4

; <label>:4:                                      ; preds = %1, %28
  %.03 = phi i32 [ 0, %1 ], [ %29, %28 ]
  %.012 = phi i8 [ 1, %1 ], [ %.1, %28 ]
  %5 = add i32 %.03, 48
  %6 = trunc i32 %5 to i8
  %7 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 10
  store i8 %6, i8* %7, align 1
  %8 = zext i32 %.03 to i64
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 %8
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %9, i32 0, i32 0
  %11 = load i32, i32* %10, align 8
  %12 = icmp ne i32 %11, %.03
  br i1 %12, label %27, label %13

; <label>:13:                                     ; preds = %4
  %14 = zext i32 %.03 to i64
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 %14
  %16 = getelementptr inbounds %struct.stType, %struct.stType* %15, i32 0, i32 1
  %17 = load i32, i32* %16, align 4
  %18 = icmp ne i32 %17, %.03
  br i1 %18, label %27, label %19

; <label>:19:                                     ; preds = %13
  %20 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i32 0, i32 0
  %21 = zext i32 %.03 to i64
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %0, i64 %21
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %22, i32 0, i32 2
  %24 = load i8*, i8** %23, align 8
  %25 = call i32 @strcmp(i8* %20, i8* %24) #4
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %27, label %28

; <label>:27:                                     ; preds = %19, %13, %4
  br label %28

; <label>:28:                                     ; preds = %19, %27
  %.1 = phi i8 [ 0, %27 ], [ %.012, %19 ]
  %29 = add i32 %.03, 1
  %30 = icmp ult i32 %29, 4
  br i1 %30, label %4, label %31

; <label>:31:                                     ; preds = %28
  %.01.lcssa = phi i8 [ %.1, %28 ]
  %32 = icmp ne i8 %.01.lcssa, 0
  br i1 %32, label %33, label %35

; <label>:33:                                     ; preds = %31
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i32 0, i32 0))
  br label %35

; <label>:35:                                     ; preds = %33, %31
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

declare i32 @printf(i8*, ...) #3

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  call void @branchPruned(%struct.stType* getelementptr inbounds ([4 x %struct.stType], [4 x %struct.stType]* @st, i32 0, i32 0))
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
