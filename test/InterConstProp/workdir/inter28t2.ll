; ModuleID = 'workdir/inter28t2.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Node = type { i32, i8*, %struct.Node* }

@.str = private unnamed_addr constant [15 x i8] c"condition true\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.Node*) #0 {
  %2 = alloca [11 x i8], align 1
  %3 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 10
  store i8 0, i8* %3, align 1
  %4 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i32 0, i32 0
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 11, i32 1, i1 false)
  %5 = icmp ne %struct.Node* %0, null
  br i1 %5, label %.lr.ph9, label %._crit_edge10

.lr.ph9:                                          ; preds = %1, %._crit_edge
  %.017 = phi i32 [ %24, %._crit_edge ], [ 1, %1 ]
  %.026 = phi i8 [ %...026, %._crit_edge ], [ 1, %1 ]
  %.035 = phi %struct.Node* [ %23, %._crit_edge ], [ %0, %1 ]
  %6 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i32 0, i32 0
  %7 = load i32, i32* %6, align 8
  %8 = icmp ne i32 %7, %.017
  %..026 = select i1 %8, i8 0, i8 %.026
  %9 = icmp slt i32 0, %.017
  br i1 %9, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.lr.ph9, %.lr.ph
  %.04 = phi i32 [ %15, %.lr.ph ], [ 0, %.lr.ph9 ]
  %10 = add nsw i32 97, %.017
  %11 = add nsw i32 %10, %.04
  %12 = trunc i32 %11 to i8
  %13 = sext i32 %.04 to i64
  %14 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 %13
  store i8 %12, i8* %14, align 1
  %15 = add nsw i32 %.04, 1
  %16 = icmp slt i32 %15, %.017
  br i1 %16, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %.lr.ph9
  %17 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i32 0, i32 1
  %18 = load i8*, i8** %17, align 8
  %19 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i32 0, i32 0
  %20 = call i32 @strcmp(i8* %18, i8* %19) #5
  %21 = icmp ne i32 %20, 0
  %...026 = select i1 %21, i8 0, i8 %..026
  %22 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i32 0, i32 2
  %23 = load %struct.Node*, %struct.Node** %22, align 8
  %24 = add nsw i32 %.017, 1
  %25 = icmp ne %struct.Node* %23, null
  br i1 %25, label %.lr.ph9, label %._crit_edge10

._crit_edge10:                                    ; preds = %._crit_edge, %1
  %.02.lcssa = phi i8 [ 1, %1 ], [ %...026, %._crit_edge ]
  %26 = icmp ne i8 %.02.lcssa, 0
  br i1 %26, label %27, label %29

; <label>:27:                                     ; preds = %._crit_edge10
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i32 0, i32 0))
  br label %29

; <label>:29:                                     ; preds = %27, %._crit_edge10
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #1

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

declare i32 @printf(i8*, ...) #3

; Function Attrs: noinline nounwind uwtable
define void @initialize(%struct.Node*, i32) #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  store i32 %1, i32* %3, align 8
  %4 = call noalias i8* @malloc(i64 11) #6
  %5 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 1
  store i8* %4, i8** %5, align 8
  %6 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 1
  %7 = load i8*, i8** %6, align 8
  call void @llvm.memset.p0i8.i64(i8* %7, i8 0, i64 11, i32 1, i1 false)
  %8 = icmp slt i32 0, %1
  br i1 %8, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.01 = phi i32 [ %16, %.lr.ph ], [ 0, %2 ]
  %9 = add nsw i32 97, %1
  %10 = add nsw i32 %9, %.01
  %11 = trunc i32 %10 to i8
  %12 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 1
  %13 = load i8*, i8** %12, align 8
  %14 = sext i32 %.01 to i64
  %15 = getelementptr inbounds i8, i8* %13, i64 %14
  store i8 %11, i8* %15, align 1
  %16 = add nsw i32 %.01, 1
  %17 = icmp slt i32 %16, %1
  br i1 %17, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %2
  %18 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 1
  %19 = load i8*, i8** %18, align 8
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0), i8* %19)
  ret void
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #4

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = call noalias i8* @malloc(i64 24) #6
  %2 = bitcast i8* %1 to %struct.Node*
  %3 = call noalias i8* @malloc(i64 24) #6
  %4 = bitcast i8* %3 to %struct.Node*
  %5 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 2
  store %struct.Node* %4, %struct.Node** %5, align 8
  %6 = call noalias i8* @malloc(i64 24) #6
  %7 = bitcast i8* %6 to %struct.Node*
  %8 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 2
  %9 = load %struct.Node*, %struct.Node** %8, align 8
  %10 = getelementptr inbounds %struct.Node, %struct.Node* %9, i32 0, i32 2
  store %struct.Node* %7, %struct.Node** %10, align 8
  %11 = call noalias i8* @malloc(i64 24) #6
  %12 = bitcast i8* %11 to %struct.Node*
  %13 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 2
  %14 = load %struct.Node*, %struct.Node** %13, align 8
  %15 = getelementptr inbounds %struct.Node, %struct.Node* %14, i32 0, i32 2
  %16 = load %struct.Node*, %struct.Node** %15, align 8
  %17 = getelementptr inbounds %struct.Node, %struct.Node* %16, i32 0, i32 2
  store %struct.Node* %12, %struct.Node** %17, align 8
  %18 = call noalias i8* @malloc(i64 24) #6
  %19 = bitcast i8* %18 to %struct.Node*
  %20 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 2
  %21 = load %struct.Node*, %struct.Node** %20, align 8
  %22 = getelementptr inbounds %struct.Node, %struct.Node* %21, i32 0, i32 2
  %23 = load %struct.Node*, %struct.Node** %22, align 8
  %24 = getelementptr inbounds %struct.Node, %struct.Node* %23, i32 0, i32 2
  %25 = load %struct.Node*, %struct.Node** %24, align 8
  %26 = getelementptr inbounds %struct.Node, %struct.Node* %25, i32 0, i32 2
  store %struct.Node* %19, %struct.Node** %26, align 8
  %27 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 2
  %28 = load %struct.Node*, %struct.Node** %27, align 8
  %29 = getelementptr inbounds %struct.Node, %struct.Node* %28, i32 0, i32 2
  %30 = load %struct.Node*, %struct.Node** %29, align 8
  %31 = getelementptr inbounds %struct.Node, %struct.Node* %30, i32 0, i32 2
  %32 = load %struct.Node*, %struct.Node** %31, align 8
  %33 = getelementptr inbounds %struct.Node, %struct.Node* %32, i32 0, i32 2
  %34 = load %struct.Node*, %struct.Node** %33, align 8
  %35 = getelementptr inbounds %struct.Node, %struct.Node* %34, i32 0, i32 2
  store %struct.Node* null, %struct.Node** %35, align 8
  %36 = icmp ne %struct.Node* %2, null
  br i1 %36, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0, %.lr.ph
  %.03 = phi %struct.Node* [ %38, %.lr.ph ], [ %2, %0 ]
  %.012 = phi i32 [ %39, %.lr.ph ], [ 1, %0 ]
  call void @initialize(%struct.Node* %.03, i32 %.012)
  %37 = getelementptr inbounds %struct.Node, %struct.Node* %.03, i32 0, i32 2
  %38 = load %struct.Node*, %struct.Node** %37, align 8
  %39 = add nsw i32 %.012, 1
  %40 = icmp ne %struct.Node* %38, null
  br i1 %40, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %0
  call void @branchPruned(%struct.Node* %2)
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
