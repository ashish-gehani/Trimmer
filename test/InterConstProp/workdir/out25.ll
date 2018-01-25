; ModuleID = 'workdir/out25.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Node = type { i32, %struct.Node* }

@.str = private unnamed_addr constant [15 x i8] c"condition true\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.Node* readonly) local_unnamed_addr #0 {
  %2 = icmp eq %struct.Node* %0, null
  br i1 %2, label %._crit_edge.thread, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %1
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.05 = phi %struct.Node* [ %7, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.014 = phi i32 [ %8, %.lr.ph ], [ 1, %.lr.ph.preheader ]
  %.023 = phi i8 [ %..023, %.lr.ph ], [ 1, %.lr.ph.preheader ]
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %.05, i64 0, i32 0
  %4 = load i32, i32* %3, align 8
  %5 = icmp ne i32 %4, %.014
  %..023 = select i1 %5, i8 0, i8 %.023
  %6 = getelementptr inbounds %struct.Node, %struct.Node* %.05, i64 0, i32 1
  %7 = load %struct.Node*, %struct.Node** %6, align 8
  %8 = add nuw nsw i32 %.014, 1
  %9 = icmp eq %struct.Node* %7, null
  br i1 %9, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph
  %10 = icmp eq i8 %..023, 0
  br i1 %10, label %12, label %._crit_edge.thread

._crit_edge.thread:                               ; preds = %1, %._crit_edge
  %11 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0))
  br label %12

; <label>:12:                                     ; preds = %._crit_edge, %._crit_edge.thread
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

; Function Attrs: noinline norecurse nounwind uwtable
define void @initialize(%struct.Node* nocapture, i32) local_unnamed_addr #2 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 %1, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
.lr.ph.preheader:
  %0 = tail call noalias i8* @malloc(i64 16) #3
  %1 = bitcast i8* %0 to %struct.Node*
  %2 = tail call noalias i8* @malloc(i64 16) #3
  %3 = getelementptr inbounds i8, i8* %0, i64 8
  %4 = bitcast i8* %3 to %struct.Node**
  %5 = bitcast i8* %3 to i8**
  store i8* %2, i8** %5, align 8
  %6 = tail call noalias i8* @malloc(i64 16) #3
  %7 = getelementptr inbounds i8, i8* %2, i64 8
  %8 = bitcast i8* %7 to i8**
  store i8* %6, i8** %8, align 8
  %9 = tail call noalias i8* @malloc(i64 16) #3
  %10 = getelementptr inbounds i8, i8* %6, i64 8
  %11 = bitcast i8* %10 to i8**
  store i8* %9, i8** %11, align 8
  %12 = tail call noalias i8* @malloc(i64 16) #3
  %13 = getelementptr inbounds i8, i8* %2, i64 8
  %14 = bitcast i8* %13 to %struct.Node**
  %15 = load %struct.Node*, %struct.Node** %14, align 8
  %16 = getelementptr inbounds %struct.Node, %struct.Node* %15, i64 0, i32 1
  %17 = load %struct.Node*, %struct.Node** %16, align 8
  %18 = getelementptr inbounds %struct.Node, %struct.Node* %17, i64 0, i32 1
  %19 = bitcast %struct.Node** %18 to i8**
  store i8* %12, i8** %19, align 8
  %20 = load %struct.Node*, %struct.Node** %14, align 8
  %21 = getelementptr inbounds %struct.Node, %struct.Node* %20, i64 0, i32 1
  %22 = load %struct.Node*, %struct.Node** %21, align 8
  %23 = getelementptr inbounds %struct.Node, %struct.Node* %22, i64 0, i32 1
  %24 = load %struct.Node*, %struct.Node** %23, align 8
  %25 = getelementptr inbounds %struct.Node, %struct.Node* %24, i64 0, i32 1
  store %struct.Node* null, %struct.Node** %25, align 8
  tail call void @initialize_clone.12(%struct.Node* %1, i32 undef)
  %26 = load %struct.Node*, %struct.Node** %4, align 8
  tail call void @initialize_clone.14(%struct.Node* %26, i32 undef)
  %27 = getelementptr inbounds %struct.Node, %struct.Node* %26, i64 0, i32 1
  %28 = load %struct.Node*, %struct.Node** %27, align 8
  tail call void @initialize_clone.16(%struct.Node* %28, i32 undef)
  %29 = getelementptr inbounds %struct.Node, %struct.Node* %28, i64 0, i32 1
  %30 = load %struct.Node*, %struct.Node** %29, align 8
  tail call void @initialize_clone.18(%struct.Node* %30, i32 undef)
  %31 = getelementptr inbounds %struct.Node, %struct.Node* %30, i64 0, i32 1
  %32 = load %struct.Node*, %struct.Node** %31, align 8
  tail call void @initialize_clone.20(%struct.Node* %32, i32 undef)
  tail call void @branchPruned_clone(%struct.Node* %1)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) local_unnamed_addr #1

; Function Attrs: noinline nounwind uwtable
define i32 @main_clone() local_unnamed_addr #0 {
.lr.ph.preheader:
  %0 = tail call noalias i8* @malloc(i64 16) #3
  %1 = bitcast i8* %0 to %struct.Node*
  %2 = tail call noalias i8* @malloc(i64 16) #3
  %3 = getelementptr inbounds i8, i8* %0, i64 8
  %4 = bitcast i8* %3 to %struct.Node**
  %5 = bitcast i8* %3 to i8**
  store i8* %2, i8** %5, align 8
  %6 = tail call noalias i8* @malloc(i64 16) #3
  %7 = getelementptr inbounds i8, i8* %2, i64 8
  %8 = bitcast i8* %7 to i8**
  store i8* %6, i8** %8, align 8
  %9 = tail call noalias i8* @malloc(i64 16) #3
  %10 = getelementptr inbounds i8, i8* %6, i64 8
  %11 = bitcast i8* %10 to i8**
  store i8* %9, i8** %11, align 8
  %12 = tail call noalias i8* @malloc(i64 16) #3
  %13 = getelementptr inbounds i8, i8* %2, i64 8
  %14 = bitcast i8* %13 to %struct.Node**
  %15 = load %struct.Node*, %struct.Node** %14, align 8
  %16 = getelementptr inbounds %struct.Node, %struct.Node* %15, i64 0, i32 1
  %17 = load %struct.Node*, %struct.Node** %16, align 8
  %18 = getelementptr inbounds %struct.Node, %struct.Node* %17, i64 0, i32 1
  %19 = bitcast %struct.Node** %18 to i8**
  store i8* %12, i8** %19, align 8
  %20 = load %struct.Node*, %struct.Node** %4, align 8
  %21 = getelementptr inbounds %struct.Node, %struct.Node* %20, i64 0, i32 1
  %22 = load %struct.Node*, %struct.Node** %21, align 8
  %23 = getelementptr inbounds %struct.Node, %struct.Node* %22, i64 0, i32 1
  %24 = load %struct.Node*, %struct.Node** %23, align 8
  %25 = getelementptr inbounds %struct.Node, %struct.Node* %24, i64 0, i32 1
  %26 = load %struct.Node*, %struct.Node** %25, align 8
  %27 = getelementptr inbounds %struct.Node, %struct.Node* %26, i64 0, i32 1
  store %struct.Node* null, %struct.Node** %27, align 8
  tail call void @initialize_clone(%struct.Node* %1, i32 undef)
  %28 = load %struct.Node*, %struct.Node** %4, align 8
  tail call void @initialize_clone.4(%struct.Node* %28, i32 undef)
  %29 = getelementptr inbounds %struct.Node, %struct.Node* %28, i64 0, i32 1
  %30 = load %struct.Node*, %struct.Node** %29, align 8
  tail call void @initialize_clone.6(%struct.Node* %30, i32 undef)
  %31 = getelementptr inbounds %struct.Node, %struct.Node* %30, i64 0, i32 1
  %32 = load %struct.Node*, %struct.Node** %31, align 8
  tail call void @initialize_clone.8(%struct.Node* %32, i32 undef)
  %33 = getelementptr inbounds %struct.Node, %struct.Node* %32, i64 0, i32 1
  %34 = load %struct.Node*, %struct.Node** %33, align 8
  tail call void @initialize_clone.10(%struct.Node* %34, i32 undef)
  tail call void @branchPruned(%struct.Node* %1)
  ret i32 0
}

; Function Attrs: noinline norecurse nounwind uwtable
define void @initialize_clone(%struct.Node* nocapture, i32) local_unnamed_addr #2 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 1, i32* %3, align 8
  ret void
}

; Function Attrs: noinline norecurse nounwind uwtable
define void @initialize_clone.4(%struct.Node* nocapture, i32) local_unnamed_addr #2 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 2, i32* %3, align 8
  ret void
}

; Function Attrs: noinline norecurse nounwind uwtable
define void @initialize_clone.6(%struct.Node* nocapture, i32) local_unnamed_addr #2 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 3, i32* %3, align 8
  ret void
}

; Function Attrs: noinline norecurse nounwind uwtable
define void @initialize_clone.8(%struct.Node* nocapture, i32) local_unnamed_addr #2 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 4, i32* %3, align 8
  ret void
}

; Function Attrs: noinline norecurse nounwind uwtable
define void @initialize_clone.10(%struct.Node* nocapture, i32) local_unnamed_addr #2 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 5, i32* %3, align 8
  ret void
}

; Function Attrs: noinline norecurse nounwind uwtable
define void @initialize_clone.12(%struct.Node* nocapture, i32) local_unnamed_addr #2 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 1, i32* %3, align 8
  ret void
}

; Function Attrs: noinline norecurse nounwind uwtable
define void @initialize_clone.14(%struct.Node* nocapture, i32) local_unnamed_addr #2 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 2, i32* %3, align 8
  ret void
}

; Function Attrs: noinline norecurse nounwind uwtable
define void @initialize_clone.16(%struct.Node* nocapture, i32) local_unnamed_addr #2 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 3, i32* %3, align 8
  ret void
}

; Function Attrs: noinline norecurse nounwind uwtable
define void @initialize_clone.18(%struct.Node* nocapture, i32) local_unnamed_addr #2 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 4, i32* %3, align 8
  ret void
}

; Function Attrs: noinline norecurse nounwind uwtable
define void @initialize_clone.20(%struct.Node* nocapture, i32) local_unnamed_addr #2 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 5, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.Node* nocapture readnone) local_unnamed_addr #0 {
.lr.ph.preheader:
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone_clone(%struct.Node* nocapture readnone) local_unnamed_addr #0 {
.lr.ph.preheader:
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0))
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
