; ModuleID = 'workdir/inter6t3.bc'
source_filename = "inter6.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [31 x i8] c"Func2: Both strings are equal\0A\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"value=key\00", align 1
@.str.2 = private unnamed_addr constant [20 x i8] c"unroll count is %d\0A\00", align 1
@0 = constant [10 x i8] c"value=key\00"
@1 = constant [10 x i8] c"value=key\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(i8*, i8*) #0 {
  %3 = call i32 @strcmp(i8* %0, i8* %1) #4
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %2
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str, i32 0, i32 0))
  br label %7

; <label>:7:                                      ; preds = %5, %2
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define void @initialize(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline nounwind uwtable
define void @unroll_loop(i32) #0 {
  %2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.2, i32 0, i32 0), i32 %0)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca [100 x i8], align 16
  %2 = alloca [100 x i8], align 16
  %3 = getelementptr inbounds [100 x i8], [100 x i8]* %1, i32 0, i32 0
  call void @initialize_clone(i8* %3)
  br label %.peel.begin

.peel.begin:                                      ; preds = %0
  br label %4

; <label>:4:                                      ; preds = %.peel.begin
  %5 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.26(i8* %5)
  %6 = add nsw i32 0, 1
  %7 = icmp slt i32 1, 10
  br i1 true, label %.peel.next, label %88

.peel.next:                                       ; preds = %4
  br label %8

; <label>:8:                                      ; preds = %.peel.next
  %9 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.28(i8* %9)
  %10 = add nsw i32 1, 1
  %11 = icmp slt i32 2, 10
  br i1 true, label %.peel.next1, label %88

.peel.next1:                                      ; preds = %8
  br label %12

; <label>:12:                                     ; preds = %.peel.next1
  %13 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.30(i8* %13)
  %14 = add nsw i32 2, 1
  %15 = icmp slt i32 3, 10
  br i1 true, label %.peel.next2, label %88

.peel.next2:                                      ; preds = %12
  br label %16

; <label>:16:                                     ; preds = %.peel.next2
  %17 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.32(i8* %17)
  %18 = add nsw i32 3, 1
  %19 = icmp slt i32 4, 10
  br i1 true, label %.peel.next3, label %88

.peel.next3:                                      ; preds = %16
  br label %20

; <label>:20:                                     ; preds = %.peel.next3
  %21 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.34(i8* %21)
  %22 = add nsw i32 4, 1
  %23 = icmp slt i32 5, 10
  br i1 true, label %.peel.next4, label %88

.peel.next4:                                      ; preds = %20
  br label %24

; <label>:24:                                     ; preds = %.peel.next4
  %25 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.36(i8* %25)
  %26 = add nsw i32 5, 1
  %27 = icmp slt i32 6, 10
  br i1 true, label %.peel.next5, label %88

.peel.next5:                                      ; preds = %24
  br label %28

; <label>:28:                                     ; preds = %.peel.next5
  %29 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.38(i8* %29)
  %30 = add nsw i32 6, 1
  %31 = icmp slt i32 7, 10
  br i1 true, label %.peel.next6, label %88

.peel.next6:                                      ; preds = %28
  br label %32

; <label>:32:                                     ; preds = %.peel.next6
  %33 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.40(i8* %33)
  %34 = add nsw i32 7, 1
  %35 = icmp slt i32 8, 10
  br i1 true, label %.peel.next7, label %88

.peel.next7:                                      ; preds = %32
  br label %36

; <label>:36:                                     ; preds = %.peel.next7
  %37 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.42(i8* %37)
  %38 = add nsw i32 8, 1
  %39 = icmp slt i32 9, 10
  br i1 true, label %.peel.next8, label %88

.peel.next8:                                      ; preds = %36
  br label %40

; <label>:40:                                     ; preds = %.peel.next8
  %41 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.44(i8* %41)
  %42 = add nsw i32 9, 1
  %43 = icmp slt i32 10, 10
  br i1 false, label %.peel.next9, label %88

.peel.next9:                                      ; preds = %40
  br label %44

; <label>:44:                                     ; preds = %.peel.next9
  %45 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %45)
  %46 = add nsw i32 10, 1
  %47 = icmp slt i32 %46, 10
  br i1 %47, label %.peel.next10, label %88

.peel.next10:                                     ; preds = %44
  br label %48

; <label>:48:                                     ; preds = %.peel.next10
  %49 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %49)
  %50 = add nsw i32 %46, 1
  %51 = icmp slt i32 %50, 10
  br i1 %51, label %.peel.next11, label %88

.peel.next11:                                     ; preds = %48
  br label %52

; <label>:52:                                     ; preds = %.peel.next11
  %53 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %53)
  %54 = add nsw i32 %50, 1
  %55 = icmp slt i32 %54, 10
  br i1 %55, label %.peel.next12, label %88

.peel.next12:                                     ; preds = %52
  br label %56

; <label>:56:                                     ; preds = %.peel.next12
  %57 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %57)
  %58 = add nsw i32 %54, 1
  %59 = icmp slt i32 %58, 10
  br i1 %59, label %.peel.next13, label %88

.peel.next13:                                     ; preds = %56
  br label %60

; <label>:60:                                     ; preds = %.peel.next13
  %61 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %61)
  %62 = add nsw i32 %58, 1
  %63 = icmp slt i32 %62, 10
  br i1 %63, label %.peel.next14, label %88

.peel.next14:                                     ; preds = %60
  br label %64

; <label>:64:                                     ; preds = %.peel.next14
  %65 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %65)
  %66 = add nsw i32 %62, 1
  %67 = icmp slt i32 %66, 10
  br i1 %67, label %.peel.next15, label %88

.peel.next15:                                     ; preds = %64
  br label %68

; <label>:68:                                     ; preds = %.peel.next15
  %69 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %69)
  %70 = add nsw i32 %66, 1
  %71 = icmp slt i32 %70, 10
  br i1 %71, label %.peel.next16, label %88

.peel.next16:                                     ; preds = %68
  br label %72

; <label>:72:                                     ; preds = %.peel.next16
  %73 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %73)
  %74 = add nsw i32 %70, 1
  %75 = icmp slt i32 %74, 10
  br i1 %75, label %.peel.next17, label %88

.peel.next17:                                     ; preds = %72
  br label %76

; <label>:76:                                     ; preds = %.peel.next17
  %77 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %77)
  %78 = add nsw i32 %74, 1
  %79 = icmp slt i32 %78, 10
  br i1 %79, label %.peel.next18, label %88

.peel.next18:                                     ; preds = %76
  br label %80

; <label>:80:                                     ; preds = %.peel.next18
  %81 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %81)
  %82 = add nsw i32 %78, 1
  %83 = icmp slt i32 %82, 10
  br i1 %83, label %.peel.next19, label %88

.peel.next19:                                     ; preds = %80
  br label %.peel.next20

.peel.next20:                                     ; preds = %.peel.next19
  br label %.peel.newph

.peel.newph:                                      ; preds = %.peel.next20
  br label %84

; <label>:84:                                     ; preds = %.peel.newph, %84
  %.01 = phi i32 [ %82, %.peel.newph ], [ %86, %84 ]
  %85 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %85)
  %86 = add nsw i32 %.01, 1
  %87 = icmp slt i32 %86, 10
  br i1 %87, label %84, label %.loopexit

.loopexit:                                        ; preds = %84
  br label %88

; <label>:88:                                     ; preds = %.loopexit, %80, %76, %72, %68, %64, %60, %56, %52, %48, %44, %40, %36, %32, %28, %24, %20, %16, %12, %8, %4
  %89 = getelementptr inbounds [100 x i8], [100 x i8]* %1, i32 0, i32 0
  %90 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @branchPruned_clone(i8* %89, i8* %90)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main_clone() #0 {
  %1 = alloca [100 x i8], align 16
  %2 = alloca [100 x i8], align 16
  %3 = getelementptr inbounds [100 x i8], [100 x i8]* %1, i32 0, i32 0
  call void @initialize_clone.4(i8* %3)
  br label %.peel.begin

.peel.begin:                                      ; preds = %0
  br label %4

; <label>:4:                                      ; preds = %.peel.begin
  %5 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.6(i8* %5)
  %6 = add nsw i32 0, 1
  %7 = icmp slt i32 1, 10
  br i1 true, label %.peel.next, label %88

.peel.next:                                       ; preds = %4
  br label %8

; <label>:8:                                      ; preds = %.peel.next
  %9 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.8(i8* %9)
  %10 = add nsw i32 1, 1
  %11 = icmp slt i32 2, 10
  br i1 true, label %.peel.next1, label %88

.peel.next1:                                      ; preds = %8
  br label %12

; <label>:12:                                     ; preds = %.peel.next1
  %13 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.10(i8* %13)
  %14 = add nsw i32 2, 1
  %15 = icmp slt i32 3, 10
  br i1 true, label %.peel.next2, label %88

.peel.next2:                                      ; preds = %12
  br label %16

; <label>:16:                                     ; preds = %.peel.next2
  %17 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.12(i8* %17)
  %18 = add nsw i32 3, 1
  %19 = icmp slt i32 4, 10
  br i1 true, label %.peel.next3, label %88

.peel.next3:                                      ; preds = %16
  br label %20

; <label>:20:                                     ; preds = %.peel.next3
  %21 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.14(i8* %21)
  %22 = add nsw i32 4, 1
  %23 = icmp slt i32 5, 10
  br i1 true, label %.peel.next4, label %88

.peel.next4:                                      ; preds = %20
  br label %24

; <label>:24:                                     ; preds = %.peel.next4
  %25 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.16(i8* %25)
  %26 = add nsw i32 5, 1
  %27 = icmp slt i32 6, 10
  br i1 true, label %.peel.next5, label %88

.peel.next5:                                      ; preds = %24
  br label %28

; <label>:28:                                     ; preds = %.peel.next5
  %29 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.18(i8* %29)
  %30 = add nsw i32 6, 1
  %31 = icmp slt i32 7, 10
  br i1 true, label %.peel.next6, label %88

.peel.next6:                                      ; preds = %28
  br label %32

; <label>:32:                                     ; preds = %.peel.next6
  %33 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.20(i8* %33)
  %34 = add nsw i32 7, 1
  %35 = icmp slt i32 8, 10
  br i1 true, label %.peel.next7, label %88

.peel.next7:                                      ; preds = %32
  br label %36

; <label>:36:                                     ; preds = %.peel.next7
  %37 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.22(i8* %37)
  %38 = add nsw i32 8, 1
  %39 = icmp slt i32 9, 10
  br i1 true, label %.peel.next8, label %88

.peel.next8:                                      ; preds = %36
  br label %40

; <label>:40:                                     ; preds = %.peel.next8
  %41 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize_clone.24(i8* %41)
  %42 = add nsw i32 9, 1
  %43 = icmp slt i32 10, 10
  br i1 false, label %.peel.next9, label %88

.peel.next9:                                      ; preds = %40
  br label %44

; <label>:44:                                     ; preds = %.peel.next9
  %45 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %45)
  %46 = add nsw i32 10, 1
  %47 = icmp slt i32 %46, 10
  br i1 %47, label %.peel.next10, label %88

.peel.next10:                                     ; preds = %44
  br label %48

; <label>:48:                                     ; preds = %.peel.next10
  %49 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %49)
  %50 = add nsw i32 %46, 1
  %51 = icmp slt i32 %50, 10
  br i1 %51, label %.peel.next11, label %88

.peel.next11:                                     ; preds = %48
  br label %52

; <label>:52:                                     ; preds = %.peel.next11
  %53 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %53)
  %54 = add nsw i32 %50, 1
  %55 = icmp slt i32 %54, 10
  br i1 %55, label %.peel.next12, label %88

.peel.next12:                                     ; preds = %52
  br label %56

; <label>:56:                                     ; preds = %.peel.next12
  %57 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %57)
  %58 = add nsw i32 %54, 1
  %59 = icmp slt i32 %58, 10
  br i1 %59, label %.peel.next13, label %88

.peel.next13:                                     ; preds = %56
  br label %60

; <label>:60:                                     ; preds = %.peel.next13
  %61 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %61)
  %62 = add nsw i32 %58, 1
  %63 = icmp slt i32 %62, 10
  br i1 %63, label %.peel.next14, label %88

.peel.next14:                                     ; preds = %60
  br label %64

; <label>:64:                                     ; preds = %.peel.next14
  %65 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %65)
  %66 = add nsw i32 %62, 1
  %67 = icmp slt i32 %66, 10
  br i1 %67, label %.peel.next15, label %88

.peel.next15:                                     ; preds = %64
  br label %68

; <label>:68:                                     ; preds = %.peel.next15
  %69 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %69)
  %70 = add nsw i32 %66, 1
  %71 = icmp slt i32 %70, 10
  br i1 %71, label %.peel.next16, label %88

.peel.next16:                                     ; preds = %68
  br label %72

; <label>:72:                                     ; preds = %.peel.next16
  %73 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %73)
  %74 = add nsw i32 %70, 1
  %75 = icmp slt i32 %74, 10
  br i1 %75, label %.peel.next17, label %88

.peel.next17:                                     ; preds = %72
  br label %76

; <label>:76:                                     ; preds = %.peel.next17
  %77 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %77)
  %78 = add nsw i32 %74, 1
  %79 = icmp slt i32 %78, 10
  br i1 %79, label %.peel.next18, label %88

.peel.next18:                                     ; preds = %76
  br label %80

; <label>:80:                                     ; preds = %.peel.next18
  %81 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %81)
  %82 = add nsw i32 %78, 1
  %83 = icmp slt i32 %82, 10
  br i1 %83, label %.peel.next19, label %88

.peel.next19:                                     ; preds = %80
  br label %.peel.next20

.peel.next20:                                     ; preds = %.peel.next19
  br label %.peel.newph

.peel.newph:                                      ; preds = %.peel.next20
  br label %84

; <label>:84:                                     ; preds = %84, %.peel.newph
  %.01 = phi i32 [ %82, %.peel.newph ], [ %86, %84 ]
  %85 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @initialize(i8* %85)
  %86 = add nsw i32 %.01, 1
  %87 = icmp slt i32 %86, 10
  br i1 %87, label %84, label %.loopexit

.loopexit:                                        ; preds = %84
  br label %88

; <label>:88:                                     ; preds = %.loopexit, %80, %76, %72, %68, %64, %60, %56, %52, %48, %44, %40, %36, %32, %28, %24, %20, %16, %12, %8, %4
  %89 = getelementptr inbounds [100 x i8], [100 x i8]* %1, i32 0, i32 0
  %90 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  call void @branchPruned(i8* %89, i8* %90)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.4(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.6(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.8(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.10(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.12(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.14(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.16(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.18(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.20(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.22(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.24(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.26(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.28(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.30(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.32(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.34(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.36(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.38(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.40(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.42(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.44(i8*) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(i8*, i8*) #0 {
  %3 = getelementptr [10 x i8], [10 x i8]* @0, i64 0, i64 0
  %4 = getelementptr [10 x i8], [10 x i8]* @1, i64 0, i64 0
  %5 = call i32 @strcmp(i8* %3, i8* %4) #4
  %6 = icmp eq i32 0, 0
  br i1 true, label %7, label %9

; <label>:7:                                      ; preds = %2
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str, i32 0, i32 0))
  br label %9

; <label>:9:                                      ; preds = %7, %2
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
