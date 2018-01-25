; ModuleID = 'workdir/out27.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Node = type { i32, i8*, %struct.Node* }

@.str = private unnamed_addr constant [15 x i8] c"condition true\00", align 1
@0 = internal constant [11 x i8] c"bcdefghijk\00"
@1 = internal constant [11 x i8] c"cdefghijkl\00"
@2 = internal constant [11 x i8] c"defghijklm\00"
@3 = internal constant [11 x i8] c"efghijklmn\00"
@4 = internal constant [11 x i8] c"fghijklmno\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.Node* readonly) local_unnamed_addr #0 {
  %2 = alloca [11 x i8], align 1
  %3 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 10
  store i8 0, i8* %3, align 1
  %4 = icmp eq %struct.Node* %0, null
  br i1 %4, label %._crit_edge.thread, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %1
  %5 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 0
  %6 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 1
  %7 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 2
  %8 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 3
  %9 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 4
  %10 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 5
  %11 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 6
  %12 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 7
  %13 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 8
  %14 = getelementptr inbounds [11 x i8], [11 x i8]* %2, i64 0, i64 9
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %indvars.iv = phi i64 [ 1, %.lr.ph.preheader ], [ %indvars.iv.next, %.lr.ph ]
  %.026 = phi i8 [ 1, %.lr.ph.preheader ], [ %...026, %.lr.ph ]
  %.035 = phi %struct.Node* [ %0, %.lr.ph.preheader ], [ %45, %.lr.ph ]
  %15 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 0
  %16 = load i32, i32* %15, align 8
  %17 = add nuw nsw i64 %indvars.iv, 97
  %18 = trunc i64 %17 to i8
  store i8 %18, i8* %5, align 1
  %19 = add nsw i64 %indvars.iv, 98
  %20 = trunc i64 %19 to i8
  store i8 %20, i8* %6, align 1
  %21 = add nsw i64 %indvars.iv, 99
  %22 = trunc i64 %21 to i8
  store i8 %22, i8* %7, align 1
  %23 = add nsw i64 %indvars.iv, 100
  %24 = trunc i64 %23 to i8
  store i8 %24, i8* %8, align 1
  %25 = add nsw i64 %indvars.iv, 101
  %26 = trunc i64 %25 to i8
  store i8 %26, i8* %9, align 1
  %27 = add nsw i64 %indvars.iv, 102
  %28 = trunc i64 %27 to i8
  store i8 %28, i8* %10, align 1
  %29 = add nsw i64 %indvars.iv, 103
  %30 = trunc i64 %29 to i8
  store i8 %30, i8* %11, align 1
  %31 = add nsw i64 %indvars.iv, 104
  %32 = trunc i64 %31 to i8
  store i8 %32, i8* %12, align 1
  %33 = add nsw i64 %indvars.iv, 105
  %34 = trunc i64 %33 to i8
  store i8 %34, i8* %13, align 1
  %35 = add nsw i64 %indvars.iv, 106
  %36 = trunc i64 %35 to i8
  store i8 %36, i8* %14, align 1
  %37 = zext i32 %16 to i64
  %38 = icmp ne i64 %37, %indvars.iv
  %39 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 1
  %40 = load i8*, i8** %39, align 8
  %41 = call i32 @strcmp(i8* %40, i8* nonnull %5) #3
  %42 = icmp ne i32 %41, 0
  %43 = or i1 %38, %42
  %...026 = select i1 %43, i8 0, i8 %.026
  %44 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 2
  %45 = load %struct.Node*, %struct.Node** %44, align 8
  %indvars.iv.next = add nuw i64 %indvars.iv, 1
  %46 = icmp eq %struct.Node* %45, null
  br i1 %46, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph
  %47 = icmp eq i8 %...026, 0
  br i1 %47, label %49, label %._crit_edge.thread

._crit_edge.thread:                               ; preds = %1, %._crit_edge
  %48 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0))
  br label %49

; <label>:49:                                     ; preds = %._crit_edge, %._crit_edge.thread
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: noinline nounwind uwtable
define void @initialize(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 %1, i32* %3, align 8
  %4 = tail call noalias i8* @malloc(i64 11) #4
  %5 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %4, i8** %5, align 8
  %6 = add nsw i32 %1, 97
  %7 = trunc i32 %6 to i8
  store i8 %7, i8* %4, align 1
  %8 = add i32 %1, 98
  %9 = trunc i32 %8 to i8
  %10 = getelementptr inbounds i8, i8* %4, i64 1
  store i8 %9, i8* %10, align 1
  %11 = add i32 %1, 99
  %12 = trunc i32 %11 to i8
  %13 = getelementptr inbounds i8, i8* %4, i64 2
  store i8 %12, i8* %13, align 1
  %14 = add i32 %1, 100
  %15 = trunc i32 %14 to i8
  %16 = getelementptr inbounds i8, i8* %4, i64 3
  store i8 %15, i8* %16, align 1
  %17 = add i32 %1, 101
  %18 = trunc i32 %17 to i8
  %19 = getelementptr inbounds i8, i8* %4, i64 4
  store i8 %18, i8* %19, align 1
  %20 = add i32 %1, 102
  %21 = trunc i32 %20 to i8
  %22 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 %21, i8* %22, align 1
  %23 = add i32 %1, 103
  %24 = trunc i32 %23 to i8
  %25 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 %24, i8* %25, align 1
  %26 = add i32 %1, 104
  %27 = trunc i32 %26 to i8
  %28 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 %27, i8* %28, align 1
  %29 = add i32 %1, 105
  %30 = trunc i32 %29 to i8
  %31 = getelementptr inbounds i8, i8* %4, i64 8
  store i8 %30, i8* %31, align 1
  %32 = add i32 %1, 106
  %33 = trunc i32 %32 to i8
  %34 = getelementptr inbounds i8, i8* %4, i64 9
  store i8 %33, i8* %34, align 1
  %35 = getelementptr inbounds i8, i8* %4, i64 10
  store i8 0, i8* %35, align 1
  ret void
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) local_unnamed_addr #2

; Function Attrs: noinline nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
.lr.ph.preheader:
  %0 = tail call noalias i8* @malloc(i64 24) #4
  %1 = bitcast i8* %0 to %struct.Node*
  %2 = tail call noalias i8* @malloc(i64 24) #4
  %3 = getelementptr inbounds i8, i8* %0, i64 16
  %4 = bitcast i8* %3 to %struct.Node**
  %5 = bitcast i8* %3 to i8**
  store i8* %2, i8** %5, align 8
  %6 = tail call noalias i8* @malloc(i64 24) #4
  %7 = getelementptr inbounds i8, i8* %2, i64 16
  %8 = bitcast i8* %7 to i8**
  store i8* %6, i8** %8, align 8
  %9 = tail call noalias i8* @malloc(i64 24) #4
  %10 = getelementptr inbounds i8, i8* %6, i64 16
  %11 = bitcast i8* %10 to i8**
  store i8* %9, i8** %11, align 8
  %12 = tail call noalias i8* @malloc(i64 24) #4
  %13 = getelementptr inbounds i8, i8* %2, i64 16
  %14 = bitcast i8* %13 to %struct.Node**
  %15 = load %struct.Node*, %struct.Node** %14, align 8
  %16 = getelementptr inbounds %struct.Node, %struct.Node* %15, i64 0, i32 2
  %17 = load %struct.Node*, %struct.Node** %16, align 8
  %18 = getelementptr inbounds %struct.Node, %struct.Node* %17, i64 0, i32 2
  %19 = bitcast %struct.Node** %18 to i8**
  store i8* %12, i8** %19, align 8
  %20 = load %struct.Node*, %struct.Node** %14, align 8
  %21 = getelementptr inbounds %struct.Node, %struct.Node* %20, i64 0, i32 2
  %22 = load %struct.Node*, %struct.Node** %21, align 8
  %23 = getelementptr inbounds %struct.Node, %struct.Node* %22, i64 0, i32 2
  %24 = load %struct.Node*, %struct.Node** %23, align 8
  %25 = getelementptr inbounds %struct.Node, %struct.Node* %24, i64 0, i32 2
  store %struct.Node* null, %struct.Node** %25, align 8
  tail call void @initialize_clone.12(%struct.Node* %1, i32 undef)
  %26 = load %struct.Node*, %struct.Node** %4, align 8
  tail call void @initialize_clone.15(%struct.Node* %26, i32 undef)
  %27 = getelementptr inbounds %struct.Node, %struct.Node* %26, i64 0, i32 2
  %28 = load %struct.Node*, %struct.Node** %27, align 8
  tail call void @initialize_clone.18(%struct.Node* %28, i32 undef)
  %29 = getelementptr inbounds %struct.Node, %struct.Node* %28, i64 0, i32 2
  %30 = load %struct.Node*, %struct.Node** %29, align 8
  tail call void @initialize_clone.21(%struct.Node* %30, i32 undef)
  %31 = getelementptr inbounds %struct.Node, %struct.Node* %30, i64 0, i32 2
  %32 = load %struct.Node*, %struct.Node** %31, align 8
  tail call void @initialize_clone.24(%struct.Node* %32, i32 undef)
  tail call void @branchPruned_clone(%struct.Node* %1)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define i32 @main_clone() local_unnamed_addr #0 {
.lr.ph.preheader:
  %0 = tail call noalias i8* @malloc(i64 24) #4
  %1 = bitcast i8* %0 to %struct.Node*
  %2 = tail call noalias i8* @malloc(i64 24) #4
  %3 = getelementptr inbounds i8, i8* %0, i64 16
  %4 = bitcast i8* %3 to %struct.Node**
  %5 = bitcast i8* %3 to i8**
  store i8* %2, i8** %5, align 8
  %6 = tail call noalias i8* @malloc(i64 24) #4
  %7 = getelementptr inbounds i8, i8* %2, i64 16
  %8 = bitcast i8* %7 to i8**
  store i8* %6, i8** %8, align 8
  %9 = tail call noalias i8* @malloc(i64 24) #4
  %10 = getelementptr inbounds i8, i8* %6, i64 16
  %11 = bitcast i8* %10 to i8**
  store i8* %9, i8** %11, align 8
  %12 = tail call noalias i8* @malloc(i64 24) #4
  %13 = getelementptr inbounds i8, i8* %2, i64 16
  %14 = bitcast i8* %13 to %struct.Node**
  %15 = load %struct.Node*, %struct.Node** %14, align 8
  %16 = getelementptr inbounds %struct.Node, %struct.Node* %15, i64 0, i32 2
  %17 = load %struct.Node*, %struct.Node** %16, align 8
  %18 = getelementptr inbounds %struct.Node, %struct.Node* %17, i64 0, i32 2
  %19 = bitcast %struct.Node** %18 to i8**
  store i8* %12, i8** %19, align 8
  %20 = load %struct.Node*, %struct.Node** %4, align 8
  %21 = getelementptr inbounds %struct.Node, %struct.Node* %20, i64 0, i32 2
  %22 = load %struct.Node*, %struct.Node** %21, align 8
  %23 = getelementptr inbounds %struct.Node, %struct.Node* %22, i64 0, i32 2
  %24 = load %struct.Node*, %struct.Node** %23, align 8
  %25 = getelementptr inbounds %struct.Node, %struct.Node* %24, i64 0, i32 2
  %26 = load %struct.Node*, %struct.Node** %25, align 8
  %27 = getelementptr inbounds %struct.Node, %struct.Node* %26, i64 0, i32 2
  store %struct.Node* null, %struct.Node** %27, align 8
  tail call void @initialize_clone(%struct.Node* %1, i32 undef)
  %28 = load %struct.Node*, %struct.Node** %4, align 8
  tail call void @initialize_clone.4(%struct.Node* %28, i32 undef)
  %29 = getelementptr inbounds %struct.Node, %struct.Node* %28, i64 0, i32 2
  %30 = load %struct.Node*, %struct.Node** %29, align 8
  tail call void @initialize_clone.6(%struct.Node* %30, i32 undef)
  %31 = getelementptr inbounds %struct.Node, %struct.Node* %30, i64 0, i32 2
  %32 = load %struct.Node*, %struct.Node** %31, align 8
  tail call void @initialize_clone.8(%struct.Node* %32, i32 undef)
  %33 = getelementptr inbounds %struct.Node, %struct.Node* %32, i64 0, i32 2
  %34 = load %struct.Node*, %struct.Node** %33, align 8
  tail call void @initialize_clone.10(%struct.Node* %34, i32 undef)
  tail call void @branchPruned(%struct.Node* %1)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 1, i32* %3, align 8
  %4 = tail call noalias i8* @malloc(i64 11) #4
  %5 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %4, i8** %5, align 8
  store i8 98, i8* %4, align 1
  %6 = getelementptr inbounds i8, i8* %4, i64 1
  store i8 99, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %4, i64 2
  store i8 100, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 3
  store i8 101, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %4, i64 4
  store i8 102, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 103, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 104, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 105, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %4, i64 8
  store i8 106, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %4, i64 9
  store i8 107, i8* %14, align 1
  %15 = getelementptr inbounds i8, i8* %4, i64 10
  store i8 0, i8* %15, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.4(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 2, i32* %3, align 8
  %4 = tail call noalias i8* @malloc(i64 11) #4
  %5 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %4, i8** %5, align 8
  store i8 99, i8* %4, align 1
  %6 = getelementptr inbounds i8, i8* %4, i64 1
  store i8 100, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %4, i64 2
  store i8 101, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 3
  store i8 102, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %4, i64 4
  store i8 103, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 104, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 105, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 106, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %4, i64 8
  store i8 107, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %4, i64 9
  store i8 108, i8* %14, align 1
  %15 = getelementptr inbounds i8, i8* %4, i64 10
  store i8 0, i8* %15, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.6(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 3, i32* %3, align 8
  %4 = tail call noalias i8* @malloc(i64 11) #4
  %5 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %4, i8** %5, align 8
  store i8 100, i8* %4, align 1
  %6 = getelementptr inbounds i8, i8* %4, i64 1
  store i8 101, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %4, i64 2
  store i8 102, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 3
  store i8 103, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %4, i64 4
  store i8 104, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 105, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 106, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 107, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %4, i64 8
  store i8 108, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %4, i64 9
  store i8 109, i8* %14, align 1
  %15 = getelementptr inbounds i8, i8* %4, i64 10
  store i8 0, i8* %15, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.8(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 4, i32* %3, align 8
  %4 = tail call noalias i8* @malloc(i64 11) #4
  %5 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %4, i8** %5, align 8
  store i8 101, i8* %4, align 1
  %6 = getelementptr inbounds i8, i8* %4, i64 1
  store i8 102, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %4, i64 2
  store i8 103, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 3
  store i8 104, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %4, i64 4
  store i8 105, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 106, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 107, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 108, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %4, i64 8
  store i8 109, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %4, i64 9
  store i8 110, i8* %14, align 1
  %15 = getelementptr inbounds i8, i8* %4, i64 10
  store i8 0, i8* %15, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.10(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 5, i32* %3, align 8
  %4 = tail call noalias i8* @malloc(i64 11) #4
  %5 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %4, i8** %5, align 8
  store i8 102, i8* %4, align 1
  %6 = getelementptr inbounds i8, i8* %4, i64 1
  store i8 103, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %4, i64 2
  store i8 104, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 3
  store i8 105, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %4, i64 4
  store i8 106, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 107, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 108, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 109, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %4, i64 8
  store i8 110, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %4, i64 9
  store i8 111, i8* %14, align 1
  %15 = getelementptr inbounds i8, i8* %4, i64 10
  store i8 0, i8* %15, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.12(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
.peel.begin:
  %2 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 1, i32* %2, align 8
  %3 = tail call noalias i8* @malloc(i64 11) #4
  %4 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %3, i8** %4, align 8
  store i8 98, i8* %3, align 1
  %5 = getelementptr inbounds i8, i8* %3, i64 1
  store i8 99, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %3, i64 2
  store i8 100, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %3, i64 3
  store i8 101, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %3, i64 4
  store i8 102, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %3, i64 5
  store i8 103, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 6
  store i8 104, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %3, i64 7
  store i8 105, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %3, i64 8
  store i8 106, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %3, i64 9
  store i8 107, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 10
  store i8 0, i8* %14, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.12_clone(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
.peel.begin:
  %2 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 1, i32* %2, align 8
  %3 = tail call noalias i8* @malloc(i64 11) #4
  %4 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %3, i8** %4, align 8
  store i8 98, i8* %3, align 1
  %5 = getelementptr inbounds i8, i8* %3, i64 1
  store i8 99, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %3, i64 2
  store i8 100, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %3, i64 3
  store i8 101, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %3, i64 4
  store i8 102, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %3, i64 5
  store i8 103, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 6
  store i8 104, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %3, i64 7
  store i8 105, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %3, i64 8
  store i8 106, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %3, i64 9
  store i8 107, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 10
  store i8 0, i8* %14, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.15(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
.peel.begin:
  %2 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 2, i32* %2, align 8
  %3 = tail call noalias i8* @malloc(i64 11) #4
  %4 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %3, i8** %4, align 8
  store i8 99, i8* %3, align 1
  %5 = getelementptr inbounds i8, i8* %3, i64 1
  store i8 100, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %3, i64 2
  store i8 101, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %3, i64 3
  store i8 102, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %3, i64 4
  store i8 103, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %3, i64 5
  store i8 104, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 6
  store i8 105, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %3, i64 7
  store i8 106, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %3, i64 8
  store i8 107, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %3, i64 9
  store i8 108, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 10
  store i8 0, i8* %14, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.15_clone(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
.peel.begin:
  %2 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 2, i32* %2, align 8
  %3 = tail call noalias i8* @malloc(i64 11) #4
  %4 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %3, i8** %4, align 8
  store i8 99, i8* %3, align 1
  %5 = getelementptr inbounds i8, i8* %3, i64 1
  store i8 100, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %3, i64 2
  store i8 101, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %3, i64 3
  store i8 102, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %3, i64 4
  store i8 103, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %3, i64 5
  store i8 104, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 6
  store i8 105, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %3, i64 7
  store i8 106, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %3, i64 8
  store i8 107, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %3, i64 9
  store i8 108, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 10
  store i8 0, i8* %14, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.18(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
.peel.begin:
  %2 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 3, i32* %2, align 8
  %3 = tail call noalias i8* @malloc(i64 11) #4
  %4 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %3, i8** %4, align 8
  store i8 100, i8* %3, align 1
  %5 = getelementptr inbounds i8, i8* %3, i64 1
  store i8 101, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %3, i64 2
  store i8 102, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %3, i64 3
  store i8 103, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %3, i64 4
  store i8 104, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %3, i64 5
  store i8 105, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 6
  store i8 106, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %3, i64 7
  store i8 107, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %3, i64 8
  store i8 108, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %3, i64 9
  store i8 109, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 10
  store i8 0, i8* %14, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.18_clone(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
.peel.begin:
  %2 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 3, i32* %2, align 8
  %3 = tail call noalias i8* @malloc(i64 11) #4
  %4 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %3, i8** %4, align 8
  store i8 100, i8* %3, align 1
  %5 = getelementptr inbounds i8, i8* %3, i64 1
  store i8 101, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %3, i64 2
  store i8 102, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %3, i64 3
  store i8 103, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %3, i64 4
  store i8 104, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %3, i64 5
  store i8 105, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 6
  store i8 106, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %3, i64 7
  store i8 107, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %3, i64 8
  store i8 108, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %3, i64 9
  store i8 109, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 10
  store i8 0, i8* %14, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.21(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
.peel.begin:
  %2 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 4, i32* %2, align 8
  %3 = tail call noalias i8* @malloc(i64 11) #4
  %4 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %3, i8** %4, align 8
  store i8 101, i8* %3, align 1
  %5 = getelementptr inbounds i8, i8* %3, i64 1
  store i8 102, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %3, i64 2
  store i8 103, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %3, i64 3
  store i8 104, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %3, i64 4
  store i8 105, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %3, i64 5
  store i8 106, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 6
  store i8 107, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %3, i64 7
  store i8 108, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %3, i64 8
  store i8 109, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %3, i64 9
  store i8 110, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 10
  store i8 0, i8* %14, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.21_clone(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
.peel.begin:
  %2 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 4, i32* %2, align 8
  %3 = tail call noalias i8* @malloc(i64 11) #4
  %4 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %3, i8** %4, align 8
  store i8 101, i8* %3, align 1
  %5 = getelementptr inbounds i8, i8* %3, i64 1
  store i8 102, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %3, i64 2
  store i8 103, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %3, i64 3
  store i8 104, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %3, i64 4
  store i8 105, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %3, i64 5
  store i8 106, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 6
  store i8 107, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %3, i64 7
  store i8 108, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %3, i64 8
  store i8 109, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %3, i64 9
  store i8 110, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 10
  store i8 0, i8* %14, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.24(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
.peel.begin:
  %2 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 5, i32* %2, align 8
  %3 = tail call noalias i8* @malloc(i64 11) #4
  %4 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %3, i8** %4, align 8
  store i8 102, i8* %3, align 1
  %5 = getelementptr inbounds i8, i8* %3, i64 1
  store i8 103, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %3, i64 2
  store i8 104, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %3, i64 3
  store i8 105, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %3, i64 4
  store i8 106, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %3, i64 5
  store i8 107, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 6
  store i8 108, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %3, i64 7
  store i8 109, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %3, i64 8
  store i8 110, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %3, i64 9
  store i8 111, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 10
  store i8 0, i8* %14, align 1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.24_clone(%struct.Node* nocapture, i32) local_unnamed_addr #0 {
.peel.begin:
  %2 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  store i32 5, i32* %2, align 8
  %3 = tail call noalias i8* @malloc(i64 11) #4
  %4 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  store i8* %3, i8** %4, align 8
  store i8 102, i8* %3, align 1
  %5 = getelementptr inbounds i8, i8* %3, i64 1
  store i8 103, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %3, i64 2
  store i8 104, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %3, i64 3
  store i8 105, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %3, i64 4
  store i8 106, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %3, i64 5
  store i8 107, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 6
  store i8 108, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %3, i64 7
  store i8 109, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %3, i64 8
  store i8 110, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %3, i64 9
  store i8 111, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 10
  store i8 0, i8* %14, align 1
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
  %1 = alloca [11 x i8], align 1
  %2 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 10
  store i8 0, i8* %2, align 1
  %3 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 0
  store i8 98, i8* %3, align 1
  %4 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 1
  store i8 99, i8* %4, align 1
  %5 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 2
  store i8 100, i8* %5, align 1
  %6 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 3
  store i8 101, i8* %6, align 1
  %7 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 4
  store i8 102, i8* %7, align 1
  %8 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 5
  store i8 103, i8* %8, align 1
  %9 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 6
  store i8 104, i8* %9, align 1
  %10 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 7
  store i8 105, i8* %10, align 1
  %11 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 8
  store i8 106, i8* %11, align 1
  %12 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 9
  store i8 107, i8* %12, align 1
  %13 = call i32 @strcmp(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @0, i64 0, i64 0), i8* nonnull %3) #3
  store i8 99, i8* %3, align 1
  store i8 100, i8* %4, align 1
  store i8 101, i8* %5, align 1
  store i8 102, i8* %6, align 1
  store i8 103, i8* %7, align 1
  store i8 104, i8* %8, align 1
  store i8 105, i8* %9, align 1
  store i8 106, i8* %10, align 1
  store i8 107, i8* %11, align 1
  store i8 108, i8* %12, align 1
  %14 = call i32 @strcmp(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @1, i64 0, i64 0), i8* nonnull %3) #3
  store i8 100, i8* %3, align 1
  store i8 101, i8* %4, align 1
  store i8 102, i8* %5, align 1
  store i8 103, i8* %6, align 1
  store i8 104, i8* %7, align 1
  store i8 105, i8* %8, align 1
  store i8 106, i8* %9, align 1
  store i8 107, i8* %10, align 1
  store i8 108, i8* %11, align 1
  store i8 109, i8* %12, align 1
  %15 = or i32 %14, %13
  %16 = call i32 @strcmp(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @2, i64 0, i64 0), i8* nonnull %3) #3
  store i8 101, i8* %3, align 1
  store i8 102, i8* %4, align 1
  store i8 103, i8* %5, align 1
  store i8 104, i8* %6, align 1
  store i8 105, i8* %7, align 1
  store i8 106, i8* %8, align 1
  store i8 107, i8* %9, align 1
  store i8 108, i8* %10, align 1
  store i8 109, i8* %11, align 1
  store i8 110, i8* %12, align 1
  %17 = or i32 %15, %16
  %18 = call i32 @strcmp(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @3, i64 0, i64 0), i8* nonnull %3) #3
  store i8 102, i8* %3, align 1
  store i8 103, i8* %4, align 1
  store i8 104, i8* %5, align 1
  store i8 105, i8* %6, align 1
  store i8 106, i8* %7, align 1
  store i8 107, i8* %8, align 1
  store i8 108, i8* %9, align 1
  store i8 109, i8* %10, align 1
  store i8 110, i8* %11, align 1
  store i8 111, i8* %12, align 1
  %19 = or i32 %17, %18
  %20 = call i32 @strcmp(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @4, i64 0, i64 0), i8* nonnull %3) #3
  %21 = or i32 %19, %20
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %23, label %25

; <label>:23:                                     ; preds = %.lr.ph.preheader
  %24 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0))
  br label %25

; <label>:25:                                     ; preds = %23, %.lr.ph.preheader
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone_clone.29(%struct.Node* nocapture readonly) local_unnamed_addr #0 {
.lr.ph.preheader:
  %1 = alloca [11 x i8], align 1
  %2 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 10
  store i8 0, i8* %2, align 1
  %3 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 0
  store i8 98, i8* %3, align 1
  %4 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 1
  store i8 99, i8* %4, align 1
  %5 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 2
  store i8 100, i8* %5, align 1
  %6 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 3
  store i8 101, i8* %6, align 1
  %7 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 4
  store i8 102, i8* %7, align 1
  %8 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 5
  store i8 103, i8* %8, align 1
  %9 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 6
  store i8 104, i8* %9, align 1
  %10 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 7
  store i8 105, i8* %10, align 1
  %11 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 8
  store i8 106, i8* %11, align 1
  %12 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 9
  store i8 107, i8* %12, align 1
  %13 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 1
  %14 = load i8*, i8** %13, align 8
  %15 = call i32 @strcmp(i8* %14, i8* nonnull %3) #3
  %not. = icmp eq i32 %15, 0
  %...026.peel = zext i1 %not. to i8
  %16 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 2
  %17 = load %struct.Node*, %struct.Node** %16, align 8
  %18 = icmp eq %struct.Node* %17, null
  br i1 %18, label %._crit_edge, label %.lr.ph.peel2

.lr.ph.peel2:                                     ; preds = %.lr.ph.preheader
  %19 = getelementptr inbounds %struct.Node, %struct.Node* %17, i64 0, i32 0
  %20 = load i32, i32* %19, align 8
  store i8 99, i8* %3, align 1
  store i8 100, i8* %4, align 1
  store i8 101, i8* %5, align 1
  store i8 102, i8* %6, align 1
  store i8 103, i8* %7, align 1
  store i8 104, i8* %8, align 1
  store i8 105, i8* %9, align 1
  store i8 106, i8* %10, align 1
  store i8 107, i8* %11, align 1
  store i8 108, i8* %12, align 1
  %not.1 = icmp eq i32 %20, 2
  %21 = getelementptr inbounds %struct.Node, %struct.Node* %17, i64 0, i32 1
  %22 = load i8*, i8** %21, align 8
  %23 = call i32 @strcmp(i8* %22, i8* nonnull %3) #3
  %24 = or i32 %23, %15
  %25 = icmp eq i32 %24, 0
  %26 = and i1 %not.1, %25
  %...026.peel5 = zext i1 %26 to i8
  %27 = getelementptr inbounds %struct.Node, %struct.Node* %17, i64 0, i32 2
  %28 = load %struct.Node*, %struct.Node** %27, align 8
  %29 = icmp eq %struct.Node* %28, null
  br i1 %29, label %._crit_edge, label %.lr.ph.peel7

.lr.ph.peel7:                                     ; preds = %.lr.ph.peel2
  %30 = getelementptr inbounds %struct.Node, %struct.Node* %28, i64 0, i32 0
  %31 = load i32, i32* %30, align 8
  %not.4 = icmp eq i32 %31, 3
  store i8 100, i8* %3, align 1
  store i8 101, i8* %4, align 1
  store i8 102, i8* %5, align 1
  store i8 103, i8* %6, align 1
  store i8 104, i8* %7, align 1
  store i8 105, i8* %8, align 1
  store i8 106, i8* %9, align 1
  store i8 107, i8* %10, align 1
  store i8 108, i8* %11, align 1
  store i8 109, i8* %12, align 1
  %narrow = and i1 %26, %not.4
  %32 = getelementptr inbounds %struct.Node, %struct.Node* %28, i64 0, i32 1
  %33 = load i8*, i8** %32, align 8
  %34 = call i32 @strcmp(i8* %33, i8* nonnull %3) #3
  %not.6 = icmp eq i32 %34, 0
  %narrow5 = and i1 %narrow, %not.6
  %...026.peel10 = zext i1 %narrow5 to i8
  %35 = getelementptr inbounds %struct.Node, %struct.Node* %28, i64 0, i32 2
  %36 = load %struct.Node*, %struct.Node** %35, align 8
  %37 = icmp eq %struct.Node* %36, null
  br i1 %37, label %._crit_edge, label %.lr.ph.peel12

.lr.ph.peel12:                                    ; preds = %.lr.ph.peel7
  %38 = getelementptr inbounds %struct.Node, %struct.Node* %36, i64 0, i32 0
  %39 = load i32, i32* %38, align 8
  %not.8 = icmp eq i32 %39, 4
  store i8 101, i8* %3, align 1
  store i8 102, i8* %4, align 1
  store i8 103, i8* %5, align 1
  store i8 104, i8* %6, align 1
  store i8 105, i8* %7, align 1
  store i8 106, i8* %8, align 1
  store i8 107, i8* %9, align 1
  store i8 108, i8* %10, align 1
  store i8 109, i8* %11, align 1
  store i8 110, i8* %12, align 1
  %narrow7 = and i1 %narrow5, %not.8
  %40 = getelementptr inbounds %struct.Node, %struct.Node* %36, i64 0, i32 1
  %41 = load i8*, i8** %40, align 8
  %42 = call i32 @strcmp(i8* %41, i8* nonnull %3) #3
  %not.10 = icmp eq i32 %42, 0
  %narrow9 = and i1 %narrow7, %not.10
  %...026.peel15 = zext i1 %narrow9 to i8
  %43 = getelementptr inbounds %struct.Node, %struct.Node* %36, i64 0, i32 2
  %44 = load %struct.Node*, %struct.Node** %43, align 8
  %45 = icmp eq %struct.Node* %44, null
  br i1 %45, label %._crit_edge, label %.lr.ph.peel17

.lr.ph.peel17:                                    ; preds = %.lr.ph.peel12
  %46 = getelementptr inbounds %struct.Node, %struct.Node* %44, i64 0, i32 0
  %47 = load i32, i32* %46, align 8
  %not.12 = icmp eq i32 %47, 5
  store i8 102, i8* %3, align 1
  store i8 103, i8* %4, align 1
  store i8 104, i8* %5, align 1
  store i8 105, i8* %6, align 1
  store i8 106, i8* %7, align 1
  store i8 107, i8* %8, align 1
  store i8 108, i8* %9, align 1
  store i8 109, i8* %10, align 1
  store i8 110, i8* %11, align 1
  store i8 111, i8* %12, align 1
  %narrow11 = and i1 %narrow9, %not.12
  %48 = getelementptr inbounds %struct.Node, %struct.Node* %44, i64 0, i32 1
  %49 = load i8*, i8** %48, align 8
  %50 = call i32 @strcmp(i8* %49, i8* nonnull %3) #3
  %not.14 = icmp eq i32 %50, 0
  %narrow13 = and i1 %narrow11, %not.14
  %...026.peel20 = zext i1 %narrow13 to i8
  %51 = getelementptr inbounds %struct.Node, %struct.Node* %44, i64 0, i32 2
  %52 = load %struct.Node*, %struct.Node** %51, align 8
  %53 = icmp eq %struct.Node* %52, null
  br i1 %53, label %._crit_edge, label %.lr.ph.peel22

.lr.ph.peel22:                                    ; preds = %.lr.ph.peel17
  %54 = getelementptr inbounds %struct.Node, %struct.Node* %52, i64 0, i32 0
  %55 = load i32, i32* %54, align 8
  %not.16 = icmp eq i32 %55, 6
  store i8 103, i8* %3, align 1
  store i8 104, i8* %4, align 1
  store i8 105, i8* %5, align 1
  store i8 106, i8* %6, align 1
  store i8 107, i8* %7, align 1
  store i8 108, i8* %8, align 1
  store i8 109, i8* %9, align 1
  store i8 110, i8* %10, align 1
  store i8 111, i8* %11, align 1
  store i8 112, i8* %12, align 1
  %narrow15 = and i1 %narrow13, %not.16
  %56 = getelementptr inbounds %struct.Node, %struct.Node* %52, i64 0, i32 1
  %57 = load i8*, i8** %56, align 8
  %58 = call i32 @strcmp(i8* %57, i8* nonnull %3) #3
  %not.18 = icmp eq i32 %58, 0
  %narrow17 = and i1 %narrow15, %not.18
  %...026.peel25 = zext i1 %narrow17 to i8
  %59 = getelementptr inbounds %struct.Node, %struct.Node* %52, i64 0, i32 2
  %60 = load %struct.Node*, %struct.Node** %59, align 8
  %61 = icmp eq %struct.Node* %60, null
  br i1 %61, label %._crit_edge, label %.lr.ph.peel27

.lr.ph.peel27:                                    ; preds = %.lr.ph.peel22
  %62 = getelementptr inbounds %struct.Node, %struct.Node* %60, i64 0, i32 0
  %63 = load i32, i32* %62, align 8
  %not.20 = icmp eq i32 %63, 7
  store i8 104, i8* %3, align 1
  store i8 105, i8* %4, align 1
  store i8 106, i8* %5, align 1
  store i8 107, i8* %6, align 1
  store i8 108, i8* %7, align 1
  store i8 109, i8* %8, align 1
  store i8 110, i8* %9, align 1
  store i8 111, i8* %10, align 1
  store i8 112, i8* %11, align 1
  store i8 113, i8* %12, align 1
  %narrow19 = and i1 %narrow17, %not.20
  %64 = getelementptr inbounds %struct.Node, %struct.Node* %60, i64 0, i32 1
  %65 = load i8*, i8** %64, align 8
  %66 = call i32 @strcmp(i8* %65, i8* nonnull %3) #3
  %not.22 = icmp eq i32 %66, 0
  %narrow21 = and i1 %narrow19, %not.22
  %...026.peel30 = zext i1 %narrow21 to i8
  %67 = getelementptr inbounds %struct.Node, %struct.Node* %60, i64 0, i32 2
  %68 = load %struct.Node*, %struct.Node** %67, align 8
  %69 = icmp eq %struct.Node* %68, null
  br i1 %69, label %._crit_edge, label %.lr.ph.peel32

.lr.ph.peel32:                                    ; preds = %.lr.ph.peel27
  %70 = getelementptr inbounds %struct.Node, %struct.Node* %68, i64 0, i32 0
  %71 = load i32, i32* %70, align 8
  %not.24 = icmp eq i32 %71, 8
  store i8 105, i8* %3, align 1
  store i8 106, i8* %4, align 1
  store i8 107, i8* %5, align 1
  store i8 108, i8* %6, align 1
  store i8 109, i8* %7, align 1
  store i8 110, i8* %8, align 1
  store i8 111, i8* %9, align 1
  store i8 112, i8* %10, align 1
  store i8 113, i8* %11, align 1
  store i8 114, i8* %12, align 1
  %narrow23 = and i1 %narrow21, %not.24
  %72 = getelementptr inbounds %struct.Node, %struct.Node* %68, i64 0, i32 1
  %73 = load i8*, i8** %72, align 8
  %74 = call i32 @strcmp(i8* %73, i8* nonnull %3) #3
  %not.26 = icmp eq i32 %74, 0
  %narrow25 = and i1 %narrow23, %not.26
  %...026.peel35 = zext i1 %narrow25 to i8
  %75 = getelementptr inbounds %struct.Node, %struct.Node* %68, i64 0, i32 2
  %76 = load %struct.Node*, %struct.Node** %75, align 8
  %77 = icmp eq %struct.Node* %76, null
  br i1 %77, label %._crit_edge, label %.lr.ph.peel37

.lr.ph.peel37:                                    ; preds = %.lr.ph.peel32
  %78 = getelementptr inbounds %struct.Node, %struct.Node* %76, i64 0, i32 0
  %79 = load i32, i32* %78, align 8
  %not.28 = icmp eq i32 %79, 9
  store i8 106, i8* %3, align 1
  store i8 107, i8* %4, align 1
  store i8 108, i8* %5, align 1
  store i8 109, i8* %6, align 1
  store i8 110, i8* %7, align 1
  store i8 111, i8* %8, align 1
  store i8 112, i8* %9, align 1
  store i8 113, i8* %10, align 1
  store i8 114, i8* %11, align 1
  store i8 115, i8* %12, align 1
  %narrow27 = and i1 %narrow25, %not.28
  %80 = getelementptr inbounds %struct.Node, %struct.Node* %76, i64 0, i32 1
  %81 = load i8*, i8** %80, align 8
  %82 = call i32 @strcmp(i8* %81, i8* nonnull %3) #3
  %not.30 = icmp eq i32 %82, 0
  %narrow29 = and i1 %narrow27, %not.30
  %...026.peel40 = zext i1 %narrow29 to i8
  %83 = getelementptr inbounds %struct.Node, %struct.Node* %76, i64 0, i32 2
  %84 = load %struct.Node*, %struct.Node** %83, align 8
  %85 = icmp eq %struct.Node* %84, null
  br i1 %85, label %._crit_edge, label %.lr.ph.peel42

.lr.ph.peel42:                                    ; preds = %.lr.ph.peel37
  %86 = getelementptr inbounds %struct.Node, %struct.Node* %84, i64 0, i32 0
  %87 = load i32, i32* %86, align 8
  %not.32 = icmp eq i32 %87, 10
  store i8 107, i8* %3, align 1
  store i8 108, i8* %4, align 1
  store i8 109, i8* %5, align 1
  store i8 110, i8* %6, align 1
  store i8 111, i8* %7, align 1
  store i8 112, i8* %8, align 1
  store i8 113, i8* %9, align 1
  store i8 114, i8* %10, align 1
  store i8 115, i8* %11, align 1
  store i8 116, i8* %12, align 1
  %narrow31 = and i1 %narrow29, %not.32
  %88 = getelementptr inbounds %struct.Node, %struct.Node* %84, i64 0, i32 1
  %89 = load i8*, i8** %88, align 8
  %90 = call i32 @strcmp(i8* %89, i8* nonnull %3) #3
  %not.34 = icmp eq i32 %90, 0
  %narrow33 = and i1 %narrow31, %not.34
  %...026.peel45 = zext i1 %narrow33 to i8
  %91 = getelementptr inbounds %struct.Node, %struct.Node* %84, i64 0, i32 2
  %92 = load %struct.Node*, %struct.Node** %91, align 8
  %93 = icmp eq %struct.Node* %92, null
  br i1 %93, label %._crit_edge, label %.lr.ph.peel47

.lr.ph.peel47:                                    ; preds = %.lr.ph.peel42
  %94 = getelementptr inbounds %struct.Node, %struct.Node* %92, i64 0, i32 0
  %95 = load i32, i32* %94, align 8
  %not.36 = icmp eq i32 %95, 11
  store i8 108, i8* %3, align 1
  store i8 109, i8* %4, align 1
  store i8 110, i8* %5, align 1
  store i8 111, i8* %6, align 1
  store i8 112, i8* %7, align 1
  store i8 113, i8* %8, align 1
  store i8 114, i8* %9, align 1
  store i8 115, i8* %10, align 1
  store i8 116, i8* %11, align 1
  store i8 117, i8* %12, align 1
  %narrow35 = and i1 %narrow33, %not.36
  %96 = getelementptr inbounds %struct.Node, %struct.Node* %92, i64 0, i32 1
  %97 = load i8*, i8** %96, align 8
  %98 = call i32 @strcmp(i8* %97, i8* nonnull %3) #3
  %not.38 = icmp eq i32 %98, 0
  %narrow37 = and i1 %narrow35, %not.38
  %...026.peel50 = zext i1 %narrow37 to i8
  %99 = getelementptr inbounds %struct.Node, %struct.Node* %92, i64 0, i32 2
  %100 = load %struct.Node*, %struct.Node** %99, align 8
  %101 = icmp eq %struct.Node* %100, null
  br i1 %101, label %._crit_edge, label %.lr.ph.peel52

.lr.ph.peel52:                                    ; preds = %.lr.ph.peel47
  %102 = getelementptr inbounds %struct.Node, %struct.Node* %100, i64 0, i32 0
  %103 = load i32, i32* %102, align 8
  %not.40 = icmp eq i32 %103, 12
  store i8 109, i8* %3, align 1
  store i8 110, i8* %4, align 1
  store i8 111, i8* %5, align 1
  store i8 112, i8* %6, align 1
  store i8 113, i8* %7, align 1
  store i8 114, i8* %8, align 1
  store i8 115, i8* %9, align 1
  store i8 116, i8* %10, align 1
  store i8 117, i8* %11, align 1
  store i8 118, i8* %12, align 1
  %narrow39 = and i1 %narrow37, %not.40
  %104 = getelementptr inbounds %struct.Node, %struct.Node* %100, i64 0, i32 1
  %105 = load i8*, i8** %104, align 8
  %106 = call i32 @strcmp(i8* %105, i8* nonnull %3) #3
  %not.42 = icmp eq i32 %106, 0
  %narrow41 = and i1 %narrow39, %not.42
  %...026.peel55 = zext i1 %narrow41 to i8
  %107 = getelementptr inbounds %struct.Node, %struct.Node* %100, i64 0, i32 2
  %108 = load %struct.Node*, %struct.Node** %107, align 8
  %109 = icmp eq %struct.Node* %108, null
  br i1 %109, label %._crit_edge, label %.lr.ph.peel57

.lr.ph.peel57:                                    ; preds = %.lr.ph.peel52
  %110 = getelementptr inbounds %struct.Node, %struct.Node* %108, i64 0, i32 0
  %111 = load i32, i32* %110, align 8
  %not.44 = icmp eq i32 %111, 13
  store i8 110, i8* %3, align 1
  store i8 111, i8* %4, align 1
  store i8 112, i8* %5, align 1
  store i8 113, i8* %6, align 1
  store i8 114, i8* %7, align 1
  store i8 115, i8* %8, align 1
  store i8 116, i8* %9, align 1
  store i8 117, i8* %10, align 1
  store i8 118, i8* %11, align 1
  store i8 119, i8* %12, align 1
  %narrow43 = and i1 %narrow41, %not.44
  %112 = getelementptr inbounds %struct.Node, %struct.Node* %108, i64 0, i32 1
  %113 = load i8*, i8** %112, align 8
  %114 = call i32 @strcmp(i8* %113, i8* nonnull %3) #3
  %not.46 = icmp eq i32 %114, 0
  %narrow45 = and i1 %narrow43, %not.46
  %...026.peel60 = zext i1 %narrow45 to i8
  %115 = getelementptr inbounds %struct.Node, %struct.Node* %108, i64 0, i32 2
  %116 = load %struct.Node*, %struct.Node** %115, align 8
  %117 = icmp eq %struct.Node* %116, null
  br i1 %117, label %._crit_edge, label %.lr.ph.peel62

.lr.ph.peel62:                                    ; preds = %.lr.ph.peel57
  %118 = getelementptr inbounds %struct.Node, %struct.Node* %116, i64 0, i32 0
  %119 = load i32, i32* %118, align 8
  %not.48 = icmp eq i32 %119, 14
  store i8 111, i8* %3, align 1
  store i8 112, i8* %4, align 1
  store i8 113, i8* %5, align 1
  store i8 114, i8* %6, align 1
  store i8 115, i8* %7, align 1
  store i8 116, i8* %8, align 1
  store i8 117, i8* %9, align 1
  store i8 118, i8* %10, align 1
  store i8 119, i8* %11, align 1
  store i8 120, i8* %12, align 1
  %narrow47 = and i1 %narrow45, %not.48
  %120 = getelementptr inbounds %struct.Node, %struct.Node* %116, i64 0, i32 1
  %121 = load i8*, i8** %120, align 8
  %122 = call i32 @strcmp(i8* %121, i8* nonnull %3) #3
  %not.50 = icmp eq i32 %122, 0
  %narrow49 = and i1 %narrow47, %not.50
  %...026.peel65 = zext i1 %narrow49 to i8
  %123 = getelementptr inbounds %struct.Node, %struct.Node* %116, i64 0, i32 2
  %124 = load %struct.Node*, %struct.Node** %123, align 8
  %125 = icmp eq %struct.Node* %124, null
  br i1 %125, label %._crit_edge, label %.lr.ph.peel67

.lr.ph.peel67:                                    ; preds = %.lr.ph.peel62
  %126 = getelementptr inbounds %struct.Node, %struct.Node* %124, i64 0, i32 0
  %127 = load i32, i32* %126, align 8
  %not.52 = icmp eq i32 %127, 15
  store i8 112, i8* %3, align 1
  store i8 113, i8* %4, align 1
  store i8 114, i8* %5, align 1
  store i8 115, i8* %6, align 1
  store i8 116, i8* %7, align 1
  store i8 117, i8* %8, align 1
  store i8 118, i8* %9, align 1
  store i8 119, i8* %10, align 1
  store i8 120, i8* %11, align 1
  store i8 121, i8* %12, align 1
  %narrow51 = and i1 %narrow49, %not.52
  %128 = getelementptr inbounds %struct.Node, %struct.Node* %124, i64 0, i32 1
  %129 = load i8*, i8** %128, align 8
  %130 = call i32 @strcmp(i8* %129, i8* nonnull %3) #3
  %not.54 = icmp eq i32 %130, 0
  %narrow53 = and i1 %narrow51, %not.54
  %...026.peel70 = zext i1 %narrow53 to i8
  %131 = getelementptr inbounds %struct.Node, %struct.Node* %124, i64 0, i32 2
  %132 = load %struct.Node*, %struct.Node** %131, align 8
  %133 = icmp eq %struct.Node* %132, null
  br i1 %133, label %._crit_edge, label %.lr.ph.peel72

.lr.ph.peel72:                                    ; preds = %.lr.ph.peel67
  %134 = getelementptr inbounds %struct.Node, %struct.Node* %132, i64 0, i32 0
  %135 = load i32, i32* %134, align 8
  %not.56 = icmp eq i32 %135, 16
  store i8 113, i8* %3, align 1
  store i8 114, i8* %4, align 1
  store i8 115, i8* %5, align 1
  store i8 116, i8* %6, align 1
  store i8 117, i8* %7, align 1
  store i8 118, i8* %8, align 1
  store i8 119, i8* %9, align 1
  store i8 120, i8* %10, align 1
  store i8 121, i8* %11, align 1
  store i8 122, i8* %12, align 1
  %narrow55 = and i1 %narrow53, %not.56
  %136 = getelementptr inbounds %struct.Node, %struct.Node* %132, i64 0, i32 1
  %137 = load i8*, i8** %136, align 8
  %138 = call i32 @strcmp(i8* %137, i8* nonnull %3) #3
  %not.58 = icmp eq i32 %138, 0
  %narrow57 = and i1 %narrow55, %not.58
  %...026.peel75 = zext i1 %narrow57 to i8
  %139 = getelementptr inbounds %struct.Node, %struct.Node* %132, i64 0, i32 2
  %140 = load %struct.Node*, %struct.Node** %139, align 8
  %141 = icmp eq %struct.Node* %140, null
  br i1 %141, label %._crit_edge, label %.lr.ph.peel77

.lr.ph.peel77:                                    ; preds = %.lr.ph.peel72
  %142 = getelementptr inbounds %struct.Node, %struct.Node* %140, i64 0, i32 0
  %143 = load i32, i32* %142, align 8
  %not.60 = icmp eq i32 %143, 17
  store i8 114, i8* %3, align 1
  store i8 115, i8* %4, align 1
  store i8 116, i8* %5, align 1
  store i8 117, i8* %6, align 1
  store i8 118, i8* %7, align 1
  store i8 119, i8* %8, align 1
  store i8 120, i8* %9, align 1
  store i8 121, i8* %10, align 1
  store i8 122, i8* %11, align 1
  store i8 123, i8* %12, align 1
  %narrow59 = and i1 %narrow57, %not.60
  %144 = getelementptr inbounds %struct.Node, %struct.Node* %140, i64 0, i32 1
  %145 = load i8*, i8** %144, align 8
  %146 = call i32 @strcmp(i8* %145, i8* nonnull %3) #3
  %not.62 = icmp eq i32 %146, 0
  %narrow61 = and i1 %narrow59, %not.62
  %...026.peel80 = zext i1 %narrow61 to i8
  %147 = getelementptr inbounds %struct.Node, %struct.Node* %140, i64 0, i32 2
  %148 = load %struct.Node*, %struct.Node** %147, align 8
  %149 = icmp eq %struct.Node* %148, null
  br i1 %149, label %._crit_edge, label %.lr.ph.peel82

.lr.ph.peel82:                                    ; preds = %.lr.ph.peel77
  %150 = getelementptr inbounds %struct.Node, %struct.Node* %148, i64 0, i32 0
  %151 = load i32, i32* %150, align 8
  %not.64 = icmp eq i32 %151, 18
  store i8 115, i8* %3, align 1
  store i8 116, i8* %4, align 1
  store i8 117, i8* %5, align 1
  store i8 118, i8* %6, align 1
  store i8 119, i8* %7, align 1
  store i8 120, i8* %8, align 1
  store i8 121, i8* %9, align 1
  store i8 122, i8* %10, align 1
  store i8 123, i8* %11, align 1
  store i8 124, i8* %12, align 1
  %narrow63 = and i1 %narrow61, %not.64
  %152 = getelementptr inbounds %struct.Node, %struct.Node* %148, i64 0, i32 1
  %153 = load i8*, i8** %152, align 8
  %154 = call i32 @strcmp(i8* %153, i8* nonnull %3) #3
  %not.66 = icmp eq i32 %154, 0
  %narrow65 = and i1 %narrow63, %not.66
  %...026.peel85 = zext i1 %narrow65 to i8
  %155 = getelementptr inbounds %struct.Node, %struct.Node* %148, i64 0, i32 2
  %156 = load %struct.Node*, %struct.Node** %155, align 8
  %157 = icmp eq %struct.Node* %156, null
  br i1 %157, label %._crit_edge, label %.lr.ph.peel87

.lr.ph.peel87:                                    ; preds = %.lr.ph.peel82
  %158 = getelementptr inbounds %struct.Node, %struct.Node* %156, i64 0, i32 0
  %159 = load i32, i32* %158, align 8
  %not.68 = icmp eq i32 %159, 19
  store i8 116, i8* %3, align 1
  store i8 117, i8* %4, align 1
  store i8 118, i8* %5, align 1
  store i8 119, i8* %6, align 1
  store i8 120, i8* %7, align 1
  store i8 121, i8* %8, align 1
  store i8 122, i8* %9, align 1
  store i8 123, i8* %10, align 1
  store i8 124, i8* %11, align 1
  store i8 125, i8* %12, align 1
  %narrow67 = and i1 %narrow65, %not.68
  %160 = getelementptr inbounds %struct.Node, %struct.Node* %156, i64 0, i32 1
  %161 = load i8*, i8** %160, align 8
  %162 = call i32 @strcmp(i8* %161, i8* nonnull %3) #3
  %not.70 = icmp eq i32 %162, 0
  %narrow69 = and i1 %narrow67, %not.70
  %...026.peel90 = zext i1 %narrow69 to i8
  %163 = getelementptr inbounds %struct.Node, %struct.Node* %156, i64 0, i32 2
  %164 = load %struct.Node*, %struct.Node** %163, align 8
  %165 = icmp eq %struct.Node* %164, null
  br i1 %165, label %._crit_edge, label %.lr.ph.peel92

.lr.ph.peel92:                                    ; preds = %.lr.ph.peel87
  %166 = getelementptr inbounds %struct.Node, %struct.Node* %164, i64 0, i32 0
  %167 = load i32, i32* %166, align 8
  %not.72 = icmp eq i32 %167, 20
  store i8 117, i8* %3, align 1
  store i8 118, i8* %4, align 1
  store i8 119, i8* %5, align 1
  store i8 120, i8* %6, align 1
  store i8 121, i8* %7, align 1
  store i8 122, i8* %8, align 1
  store i8 123, i8* %9, align 1
  store i8 124, i8* %10, align 1
  store i8 125, i8* %11, align 1
  store i8 126, i8* %12, align 1
  %narrow71 = and i1 %narrow69, %not.72
  %168 = getelementptr inbounds %struct.Node, %struct.Node* %164, i64 0, i32 1
  %169 = load i8*, i8** %168, align 8
  %170 = call i32 @strcmp(i8* %169, i8* nonnull %3) #3
  %not.74 = icmp eq i32 %170, 0
  %narrow73 = and i1 %narrow71, %not.74
  %...026.peel95 = zext i1 %narrow73 to i8
  %171 = getelementptr inbounds %struct.Node, %struct.Node* %164, i64 0, i32 2
  %172 = load %struct.Node*, %struct.Node** %171, align 8
  %173 = icmp eq %struct.Node* %172, null
  br i1 %173, label %._crit_edge, label %.lr.ph.preheader121

.lr.ph.preheader121:                              ; preds = %.lr.ph.peel92
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader121, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 21, %.lr.ph.preheader121 ]
  %.026 = phi i8 [ %...026, %.lr.ph ], [ %...026.peel95, %.lr.ph.preheader121 ]
  %.035 = phi %struct.Node* [ %204, %.lr.ph ], [ %172, %.lr.ph.preheader121 ]
  %174 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 0
  %175 = load i32, i32* %174, align 8
  %176 = add nuw nsw i64 %indvars.iv, 97
  %177 = trunc i64 %176 to i8
  store i8 %177, i8* %3, align 1
  %178 = add nsw i64 %indvars.iv, 98
  %179 = trunc i64 %178 to i8
  store i8 %179, i8* %4, align 1
  %180 = add nsw i64 %indvars.iv, 99
  %181 = trunc i64 %180 to i8
  store i8 %181, i8* %5, align 1
  %182 = add nsw i64 %indvars.iv, 100
  %183 = trunc i64 %182 to i8
  store i8 %183, i8* %6, align 1
  %184 = add nsw i64 %indvars.iv, 101
  %185 = trunc i64 %184 to i8
  store i8 %185, i8* %7, align 1
  %186 = add nsw i64 %indvars.iv, 102
  %187 = trunc i64 %186 to i8
  store i8 %187, i8* %8, align 1
  %188 = add nsw i64 %indvars.iv, 103
  %189 = trunc i64 %188 to i8
  store i8 %189, i8* %9, align 1
  %190 = add nsw i64 %indvars.iv, 104
  %191 = trunc i64 %190 to i8
  store i8 %191, i8* %10, align 1
  %192 = add nsw i64 %indvars.iv, 105
  %193 = trunc i64 %192 to i8
  store i8 %193, i8* %11, align 1
  %194 = add nsw i64 %indvars.iv, 106
  %195 = trunc i64 %194 to i8
  store i8 %195, i8* %12, align 1
  %196 = zext i32 %175 to i64
  %197 = icmp ne i64 %196, %indvars.iv
  %198 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 1
  %199 = load i8*, i8** %198, align 8
  %200 = call i32 @strcmp(i8* %199, i8* nonnull %3) #3
  %201 = icmp ne i32 %200, 0
  %202 = or i1 %197, %201
  %...026 = select i1 %202, i8 0, i8 %.026
  %203 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 2
  %204 = load %struct.Node*, %struct.Node** %203, align 8
  %indvars.iv.next = add nuw i64 %indvars.iv, 1
  %205 = icmp eq %struct.Node* %204, null
  br i1 %205, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %.lr.ph.peel92, %.lr.ph.peel87, %.lr.ph.peel82, %.lr.ph.peel77, %.lr.ph.peel72, %.lr.ph.peel67, %.lr.ph.peel62, %.lr.ph.peel57, %.lr.ph.peel52, %.lr.ph.peel47, %.lr.ph.peel42, %.lr.ph.peel37, %.lr.ph.peel32, %.lr.ph.peel27, %.lr.ph.peel22, %.lr.ph.peel17, %.lr.ph.peel12, %.lr.ph.peel7, %.lr.ph.peel2, %.lr.ph.preheader
  %...026.lcssa = phi i8 [ %...026.peel, %.lr.ph.preheader ], [ %...026.peel5, %.lr.ph.peel2 ], [ %...026.peel10, %.lr.ph.peel7 ], [ %...026.peel15, %.lr.ph.peel12 ], [ %...026.peel20, %.lr.ph.peel17 ], [ %...026.peel25, %.lr.ph.peel22 ], [ %...026.peel30, %.lr.ph.peel27 ], [ %...026.peel35, %.lr.ph.peel32 ], [ %...026.peel40, %.lr.ph.peel37 ], [ %...026.peel45, %.lr.ph.peel42 ], [ %...026.peel50, %.lr.ph.peel47 ], [ %...026.peel55, %.lr.ph.peel52 ], [ %...026.peel60, %.lr.ph.peel57 ], [ %...026.peel65, %.lr.ph.peel62 ], [ %...026.peel70, %.lr.ph.peel67 ], [ %...026.peel75, %.lr.ph.peel72 ], [ %...026.peel80, %.lr.ph.peel77 ], [ %...026.peel85, %.lr.ph.peel82 ], [ %...026.peel90, %.lr.ph.peel87 ], [ %...026.peel95, %.lr.ph.peel92 ], [ %...026, %._crit_edge.loopexit ]
  %206 = icmp eq i8 %...026.lcssa, 0
  br i1 %206, label %209, label %207

; <label>:207:                                    ; preds = %._crit_edge
  %208 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0))
  br label %209

; <label>:209:                                    ; preds = %._crit_edge, %207
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone_clone.31(%struct.Node* nocapture readonly) local_unnamed_addr #0 {
.lr.ph.preheader:
  %1 = alloca [11 x i8], align 1
  %2 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 10
  store i8 0, i8* %2, align 1
  %3 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 0
  %4 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 1
  %5 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 2
  %6 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 3
  %7 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 4
  %8 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 5
  %9 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 6
  %10 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 7
  %11 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 8
  %12 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 9
  %13 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 2
  %14 = load %struct.Node*, %struct.Node** %13, align 8
  store i8 99, i8* %3, align 1
  store i8 100, i8* %4, align 1
  store i8 101, i8* %5, align 1
  store i8 102, i8* %6, align 1
  store i8 103, i8* %7, align 1
  store i8 104, i8* %8, align 1
  store i8 105, i8* %9, align 1
  store i8 106, i8* %10, align 1
  store i8 107, i8* %11, align 1
  store i8 108, i8* %12, align 1
  %15 = getelementptr inbounds %struct.Node, %struct.Node* %14, i64 0, i32 1
  %16 = load i8*, i8** %15, align 8
  %17 = call i32 @strcmp(i8* %16, i8* nonnull %3) #3
  %not. = icmp eq i32 %17, 0
  %...026.peel5 = zext i1 %not. to i8
  %18 = getelementptr inbounds %struct.Node, %struct.Node* %14, i64 0, i32 2
  %19 = load %struct.Node*, %struct.Node** %18, align 8
  %20 = icmp eq %struct.Node* %19, null
  br i1 %20, label %._crit_edge, label %.lr.ph.peel7

.lr.ph.peel7:                                     ; preds = %.lr.ph.preheader
  %21 = getelementptr inbounds %struct.Node, %struct.Node* %19, i64 0, i32 0
  %22 = load i32, i32* %21, align 8
  store i8 100, i8* %3, align 1
  store i8 101, i8* %4, align 1
  store i8 102, i8* %5, align 1
  store i8 103, i8* %6, align 1
  store i8 104, i8* %7, align 1
  store i8 105, i8* %8, align 1
  store i8 106, i8* %9, align 1
  store i8 107, i8* %10, align 1
  store i8 108, i8* %11, align 1
  store i8 109, i8* %12, align 1
  %not.1 = icmp eq i32 %22, 3
  %23 = getelementptr inbounds %struct.Node, %struct.Node* %19, i64 0, i32 1
  %24 = load i8*, i8** %23, align 8
  %25 = call i32 @strcmp(i8* %24, i8* nonnull %3) #3
  %26 = or i32 %25, %17
  %27 = icmp eq i32 %26, 0
  %28 = and i1 %not.1, %27
  %...026.peel10 = zext i1 %28 to i8
  %29 = getelementptr inbounds %struct.Node, %struct.Node* %19, i64 0, i32 2
  %30 = load %struct.Node*, %struct.Node** %29, align 8
  %31 = icmp eq %struct.Node* %30, null
  br i1 %31, label %._crit_edge, label %.lr.ph.peel12

.lr.ph.peel12:                                    ; preds = %.lr.ph.peel7
  %32 = getelementptr inbounds %struct.Node, %struct.Node* %30, i64 0, i32 0
  %33 = load i32, i32* %32, align 8
  %not.4 = icmp eq i32 %33, 4
  store i8 101, i8* %3, align 1
  store i8 102, i8* %4, align 1
  store i8 103, i8* %5, align 1
  store i8 104, i8* %6, align 1
  store i8 105, i8* %7, align 1
  store i8 106, i8* %8, align 1
  store i8 107, i8* %9, align 1
  store i8 108, i8* %10, align 1
  store i8 109, i8* %11, align 1
  store i8 110, i8* %12, align 1
  %narrow = and i1 %28, %not.4
  %34 = getelementptr inbounds %struct.Node, %struct.Node* %30, i64 0, i32 1
  %35 = load i8*, i8** %34, align 8
  %36 = call i32 @strcmp(i8* %35, i8* nonnull %3) #3
  %not.6 = icmp eq i32 %36, 0
  %narrow5 = and i1 %narrow, %not.6
  %...026.peel15 = zext i1 %narrow5 to i8
  %37 = getelementptr inbounds %struct.Node, %struct.Node* %30, i64 0, i32 2
  %38 = load %struct.Node*, %struct.Node** %37, align 8
  %39 = icmp eq %struct.Node* %38, null
  br i1 %39, label %._crit_edge, label %.lr.ph.peel17

.lr.ph.peel17:                                    ; preds = %.lr.ph.peel12
  %40 = getelementptr inbounds %struct.Node, %struct.Node* %38, i64 0, i32 0
  %41 = load i32, i32* %40, align 8
  %not.8 = icmp eq i32 %41, 5
  store i8 102, i8* %3, align 1
  store i8 103, i8* %4, align 1
  store i8 104, i8* %5, align 1
  store i8 105, i8* %6, align 1
  store i8 106, i8* %7, align 1
  store i8 107, i8* %8, align 1
  store i8 108, i8* %9, align 1
  store i8 109, i8* %10, align 1
  store i8 110, i8* %11, align 1
  store i8 111, i8* %12, align 1
  %narrow7 = and i1 %narrow5, %not.8
  %42 = getelementptr inbounds %struct.Node, %struct.Node* %38, i64 0, i32 1
  %43 = load i8*, i8** %42, align 8
  %44 = call i32 @strcmp(i8* %43, i8* nonnull %3) #3
  %not.10 = icmp eq i32 %44, 0
  %narrow9 = and i1 %narrow7, %not.10
  %...026.peel20 = zext i1 %narrow9 to i8
  %45 = getelementptr inbounds %struct.Node, %struct.Node* %38, i64 0, i32 2
  %46 = load %struct.Node*, %struct.Node** %45, align 8
  %47 = icmp eq %struct.Node* %46, null
  br i1 %47, label %._crit_edge, label %.lr.ph.peel22

.lr.ph.peel22:                                    ; preds = %.lr.ph.peel17
  %48 = getelementptr inbounds %struct.Node, %struct.Node* %46, i64 0, i32 0
  %49 = load i32, i32* %48, align 8
  %not.12 = icmp eq i32 %49, 6
  store i8 103, i8* %3, align 1
  store i8 104, i8* %4, align 1
  store i8 105, i8* %5, align 1
  store i8 106, i8* %6, align 1
  store i8 107, i8* %7, align 1
  store i8 108, i8* %8, align 1
  store i8 109, i8* %9, align 1
  store i8 110, i8* %10, align 1
  store i8 111, i8* %11, align 1
  store i8 112, i8* %12, align 1
  %narrow11 = and i1 %narrow9, %not.12
  %50 = getelementptr inbounds %struct.Node, %struct.Node* %46, i64 0, i32 1
  %51 = load i8*, i8** %50, align 8
  %52 = call i32 @strcmp(i8* %51, i8* nonnull %3) #3
  %not.14 = icmp eq i32 %52, 0
  %narrow13 = and i1 %narrow11, %not.14
  %...026.peel25 = zext i1 %narrow13 to i8
  %53 = getelementptr inbounds %struct.Node, %struct.Node* %46, i64 0, i32 2
  %54 = load %struct.Node*, %struct.Node** %53, align 8
  %55 = icmp eq %struct.Node* %54, null
  br i1 %55, label %._crit_edge, label %.lr.ph.peel27

.lr.ph.peel27:                                    ; preds = %.lr.ph.peel22
  %56 = getelementptr inbounds %struct.Node, %struct.Node* %54, i64 0, i32 0
  %57 = load i32, i32* %56, align 8
  %not.16 = icmp eq i32 %57, 7
  store i8 104, i8* %3, align 1
  store i8 105, i8* %4, align 1
  store i8 106, i8* %5, align 1
  store i8 107, i8* %6, align 1
  store i8 108, i8* %7, align 1
  store i8 109, i8* %8, align 1
  store i8 110, i8* %9, align 1
  store i8 111, i8* %10, align 1
  store i8 112, i8* %11, align 1
  store i8 113, i8* %12, align 1
  %narrow15 = and i1 %narrow13, %not.16
  %58 = getelementptr inbounds %struct.Node, %struct.Node* %54, i64 0, i32 1
  %59 = load i8*, i8** %58, align 8
  %60 = call i32 @strcmp(i8* %59, i8* nonnull %3) #3
  %not.18 = icmp eq i32 %60, 0
  %narrow17 = and i1 %narrow15, %not.18
  %...026.peel30 = zext i1 %narrow17 to i8
  %61 = getelementptr inbounds %struct.Node, %struct.Node* %54, i64 0, i32 2
  %62 = load %struct.Node*, %struct.Node** %61, align 8
  %63 = icmp eq %struct.Node* %62, null
  br i1 %63, label %._crit_edge, label %.lr.ph.peel32

.lr.ph.peel32:                                    ; preds = %.lr.ph.peel27
  %64 = getelementptr inbounds %struct.Node, %struct.Node* %62, i64 0, i32 0
  %65 = load i32, i32* %64, align 8
  %not.20 = icmp eq i32 %65, 8
  store i8 105, i8* %3, align 1
  store i8 106, i8* %4, align 1
  store i8 107, i8* %5, align 1
  store i8 108, i8* %6, align 1
  store i8 109, i8* %7, align 1
  store i8 110, i8* %8, align 1
  store i8 111, i8* %9, align 1
  store i8 112, i8* %10, align 1
  store i8 113, i8* %11, align 1
  store i8 114, i8* %12, align 1
  %narrow19 = and i1 %narrow17, %not.20
  %66 = getelementptr inbounds %struct.Node, %struct.Node* %62, i64 0, i32 1
  %67 = load i8*, i8** %66, align 8
  %68 = call i32 @strcmp(i8* %67, i8* nonnull %3) #3
  %not.22 = icmp eq i32 %68, 0
  %narrow21 = and i1 %narrow19, %not.22
  %...026.peel35 = zext i1 %narrow21 to i8
  %69 = getelementptr inbounds %struct.Node, %struct.Node* %62, i64 0, i32 2
  %70 = load %struct.Node*, %struct.Node** %69, align 8
  %71 = icmp eq %struct.Node* %70, null
  br i1 %71, label %._crit_edge, label %.lr.ph.peel37

.lr.ph.peel37:                                    ; preds = %.lr.ph.peel32
  %72 = getelementptr inbounds %struct.Node, %struct.Node* %70, i64 0, i32 0
  %73 = load i32, i32* %72, align 8
  %not.24 = icmp eq i32 %73, 9
  store i8 106, i8* %3, align 1
  store i8 107, i8* %4, align 1
  store i8 108, i8* %5, align 1
  store i8 109, i8* %6, align 1
  store i8 110, i8* %7, align 1
  store i8 111, i8* %8, align 1
  store i8 112, i8* %9, align 1
  store i8 113, i8* %10, align 1
  store i8 114, i8* %11, align 1
  store i8 115, i8* %12, align 1
  %narrow23 = and i1 %narrow21, %not.24
  %74 = getelementptr inbounds %struct.Node, %struct.Node* %70, i64 0, i32 1
  %75 = load i8*, i8** %74, align 8
  %76 = call i32 @strcmp(i8* %75, i8* nonnull %3) #3
  %not.26 = icmp eq i32 %76, 0
  %narrow25 = and i1 %narrow23, %not.26
  %...026.peel40 = zext i1 %narrow25 to i8
  %77 = getelementptr inbounds %struct.Node, %struct.Node* %70, i64 0, i32 2
  %78 = load %struct.Node*, %struct.Node** %77, align 8
  %79 = icmp eq %struct.Node* %78, null
  br i1 %79, label %._crit_edge, label %.lr.ph.peel42

.lr.ph.peel42:                                    ; preds = %.lr.ph.peel37
  %80 = getelementptr inbounds %struct.Node, %struct.Node* %78, i64 0, i32 0
  %81 = load i32, i32* %80, align 8
  %not.28 = icmp eq i32 %81, 10
  store i8 107, i8* %3, align 1
  store i8 108, i8* %4, align 1
  store i8 109, i8* %5, align 1
  store i8 110, i8* %6, align 1
  store i8 111, i8* %7, align 1
  store i8 112, i8* %8, align 1
  store i8 113, i8* %9, align 1
  store i8 114, i8* %10, align 1
  store i8 115, i8* %11, align 1
  store i8 116, i8* %12, align 1
  %narrow27 = and i1 %narrow25, %not.28
  %82 = getelementptr inbounds %struct.Node, %struct.Node* %78, i64 0, i32 1
  %83 = load i8*, i8** %82, align 8
  %84 = call i32 @strcmp(i8* %83, i8* nonnull %3) #3
  %not.30 = icmp eq i32 %84, 0
  %narrow29 = and i1 %narrow27, %not.30
  %...026.peel45 = zext i1 %narrow29 to i8
  %85 = getelementptr inbounds %struct.Node, %struct.Node* %78, i64 0, i32 2
  %86 = load %struct.Node*, %struct.Node** %85, align 8
  %87 = icmp eq %struct.Node* %86, null
  br i1 %87, label %._crit_edge, label %.lr.ph.peel47

.lr.ph.peel47:                                    ; preds = %.lr.ph.peel42
  %88 = getelementptr inbounds %struct.Node, %struct.Node* %86, i64 0, i32 0
  %89 = load i32, i32* %88, align 8
  %not.32 = icmp eq i32 %89, 11
  store i8 108, i8* %3, align 1
  store i8 109, i8* %4, align 1
  store i8 110, i8* %5, align 1
  store i8 111, i8* %6, align 1
  store i8 112, i8* %7, align 1
  store i8 113, i8* %8, align 1
  store i8 114, i8* %9, align 1
  store i8 115, i8* %10, align 1
  store i8 116, i8* %11, align 1
  store i8 117, i8* %12, align 1
  %narrow31 = and i1 %narrow29, %not.32
  %90 = getelementptr inbounds %struct.Node, %struct.Node* %86, i64 0, i32 1
  %91 = load i8*, i8** %90, align 8
  %92 = call i32 @strcmp(i8* %91, i8* nonnull %3) #3
  %not.34 = icmp eq i32 %92, 0
  %narrow33 = and i1 %narrow31, %not.34
  %...026.peel50 = zext i1 %narrow33 to i8
  %93 = getelementptr inbounds %struct.Node, %struct.Node* %86, i64 0, i32 2
  %94 = load %struct.Node*, %struct.Node** %93, align 8
  %95 = icmp eq %struct.Node* %94, null
  br i1 %95, label %._crit_edge, label %.lr.ph.peel52

.lr.ph.peel52:                                    ; preds = %.lr.ph.peel47
  %96 = getelementptr inbounds %struct.Node, %struct.Node* %94, i64 0, i32 0
  %97 = load i32, i32* %96, align 8
  %not.36 = icmp eq i32 %97, 12
  store i8 109, i8* %3, align 1
  store i8 110, i8* %4, align 1
  store i8 111, i8* %5, align 1
  store i8 112, i8* %6, align 1
  store i8 113, i8* %7, align 1
  store i8 114, i8* %8, align 1
  store i8 115, i8* %9, align 1
  store i8 116, i8* %10, align 1
  store i8 117, i8* %11, align 1
  store i8 118, i8* %12, align 1
  %narrow35 = and i1 %narrow33, %not.36
  %98 = getelementptr inbounds %struct.Node, %struct.Node* %94, i64 0, i32 1
  %99 = load i8*, i8** %98, align 8
  %100 = call i32 @strcmp(i8* %99, i8* nonnull %3) #3
  %not.38 = icmp eq i32 %100, 0
  %narrow37 = and i1 %narrow35, %not.38
  %...026.peel55 = zext i1 %narrow37 to i8
  %101 = getelementptr inbounds %struct.Node, %struct.Node* %94, i64 0, i32 2
  %102 = load %struct.Node*, %struct.Node** %101, align 8
  %103 = icmp eq %struct.Node* %102, null
  br i1 %103, label %._crit_edge, label %.lr.ph.peel57

.lr.ph.peel57:                                    ; preds = %.lr.ph.peel52
  %104 = getelementptr inbounds %struct.Node, %struct.Node* %102, i64 0, i32 0
  %105 = load i32, i32* %104, align 8
  %not.40 = icmp eq i32 %105, 13
  store i8 110, i8* %3, align 1
  store i8 111, i8* %4, align 1
  store i8 112, i8* %5, align 1
  store i8 113, i8* %6, align 1
  store i8 114, i8* %7, align 1
  store i8 115, i8* %8, align 1
  store i8 116, i8* %9, align 1
  store i8 117, i8* %10, align 1
  store i8 118, i8* %11, align 1
  store i8 119, i8* %12, align 1
  %narrow39 = and i1 %narrow37, %not.40
  %106 = getelementptr inbounds %struct.Node, %struct.Node* %102, i64 0, i32 1
  %107 = load i8*, i8** %106, align 8
  %108 = call i32 @strcmp(i8* %107, i8* nonnull %3) #3
  %not.42 = icmp eq i32 %108, 0
  %narrow41 = and i1 %narrow39, %not.42
  %...026.peel60 = zext i1 %narrow41 to i8
  %109 = getelementptr inbounds %struct.Node, %struct.Node* %102, i64 0, i32 2
  %110 = load %struct.Node*, %struct.Node** %109, align 8
  %111 = icmp eq %struct.Node* %110, null
  br i1 %111, label %._crit_edge, label %.lr.ph.peel62

.lr.ph.peel62:                                    ; preds = %.lr.ph.peel57
  %112 = getelementptr inbounds %struct.Node, %struct.Node* %110, i64 0, i32 0
  %113 = load i32, i32* %112, align 8
  %not.44 = icmp eq i32 %113, 14
  store i8 111, i8* %3, align 1
  store i8 112, i8* %4, align 1
  store i8 113, i8* %5, align 1
  store i8 114, i8* %6, align 1
  store i8 115, i8* %7, align 1
  store i8 116, i8* %8, align 1
  store i8 117, i8* %9, align 1
  store i8 118, i8* %10, align 1
  store i8 119, i8* %11, align 1
  store i8 120, i8* %12, align 1
  %narrow43 = and i1 %narrow41, %not.44
  %114 = getelementptr inbounds %struct.Node, %struct.Node* %110, i64 0, i32 1
  %115 = load i8*, i8** %114, align 8
  %116 = call i32 @strcmp(i8* %115, i8* nonnull %3) #3
  %not.46 = icmp eq i32 %116, 0
  %narrow45 = and i1 %narrow43, %not.46
  %...026.peel65 = zext i1 %narrow45 to i8
  %117 = getelementptr inbounds %struct.Node, %struct.Node* %110, i64 0, i32 2
  %118 = load %struct.Node*, %struct.Node** %117, align 8
  %119 = icmp eq %struct.Node* %118, null
  br i1 %119, label %._crit_edge, label %.lr.ph.peel67

.lr.ph.peel67:                                    ; preds = %.lr.ph.peel62
  %120 = getelementptr inbounds %struct.Node, %struct.Node* %118, i64 0, i32 0
  %121 = load i32, i32* %120, align 8
  %not.48 = icmp eq i32 %121, 15
  store i8 112, i8* %3, align 1
  store i8 113, i8* %4, align 1
  store i8 114, i8* %5, align 1
  store i8 115, i8* %6, align 1
  store i8 116, i8* %7, align 1
  store i8 117, i8* %8, align 1
  store i8 118, i8* %9, align 1
  store i8 119, i8* %10, align 1
  store i8 120, i8* %11, align 1
  store i8 121, i8* %12, align 1
  %narrow47 = and i1 %narrow45, %not.48
  %122 = getelementptr inbounds %struct.Node, %struct.Node* %118, i64 0, i32 1
  %123 = load i8*, i8** %122, align 8
  %124 = call i32 @strcmp(i8* %123, i8* nonnull %3) #3
  %not.50 = icmp eq i32 %124, 0
  %narrow49 = and i1 %narrow47, %not.50
  %...026.peel70 = zext i1 %narrow49 to i8
  %125 = getelementptr inbounds %struct.Node, %struct.Node* %118, i64 0, i32 2
  %126 = load %struct.Node*, %struct.Node** %125, align 8
  %127 = icmp eq %struct.Node* %126, null
  br i1 %127, label %._crit_edge, label %.lr.ph.peel72

.lr.ph.peel72:                                    ; preds = %.lr.ph.peel67
  %128 = getelementptr inbounds %struct.Node, %struct.Node* %126, i64 0, i32 0
  %129 = load i32, i32* %128, align 8
  %not.52 = icmp eq i32 %129, 16
  store i8 113, i8* %3, align 1
  store i8 114, i8* %4, align 1
  store i8 115, i8* %5, align 1
  store i8 116, i8* %6, align 1
  store i8 117, i8* %7, align 1
  store i8 118, i8* %8, align 1
  store i8 119, i8* %9, align 1
  store i8 120, i8* %10, align 1
  store i8 121, i8* %11, align 1
  store i8 122, i8* %12, align 1
  %narrow51 = and i1 %narrow49, %not.52
  %130 = getelementptr inbounds %struct.Node, %struct.Node* %126, i64 0, i32 1
  %131 = load i8*, i8** %130, align 8
  %132 = call i32 @strcmp(i8* %131, i8* nonnull %3) #3
  %not.54 = icmp eq i32 %132, 0
  %narrow53 = and i1 %narrow51, %not.54
  %...026.peel75 = zext i1 %narrow53 to i8
  %133 = getelementptr inbounds %struct.Node, %struct.Node* %126, i64 0, i32 2
  %134 = load %struct.Node*, %struct.Node** %133, align 8
  %135 = icmp eq %struct.Node* %134, null
  br i1 %135, label %._crit_edge, label %.lr.ph.peel77

.lr.ph.peel77:                                    ; preds = %.lr.ph.peel72
  %136 = getelementptr inbounds %struct.Node, %struct.Node* %134, i64 0, i32 0
  %137 = load i32, i32* %136, align 8
  %not.56 = icmp eq i32 %137, 17
  store i8 114, i8* %3, align 1
  store i8 115, i8* %4, align 1
  store i8 116, i8* %5, align 1
  store i8 117, i8* %6, align 1
  store i8 118, i8* %7, align 1
  store i8 119, i8* %8, align 1
  store i8 120, i8* %9, align 1
  store i8 121, i8* %10, align 1
  store i8 122, i8* %11, align 1
  store i8 123, i8* %12, align 1
  %narrow55 = and i1 %narrow53, %not.56
  %138 = getelementptr inbounds %struct.Node, %struct.Node* %134, i64 0, i32 1
  %139 = load i8*, i8** %138, align 8
  %140 = call i32 @strcmp(i8* %139, i8* nonnull %3) #3
  %not.58 = icmp eq i32 %140, 0
  %narrow57 = and i1 %narrow55, %not.58
  %...026.peel80 = zext i1 %narrow57 to i8
  %141 = getelementptr inbounds %struct.Node, %struct.Node* %134, i64 0, i32 2
  %142 = load %struct.Node*, %struct.Node** %141, align 8
  %143 = icmp eq %struct.Node* %142, null
  br i1 %143, label %._crit_edge, label %.lr.ph.peel82

.lr.ph.peel82:                                    ; preds = %.lr.ph.peel77
  %144 = getelementptr inbounds %struct.Node, %struct.Node* %142, i64 0, i32 0
  %145 = load i32, i32* %144, align 8
  %not.60 = icmp eq i32 %145, 18
  store i8 115, i8* %3, align 1
  store i8 116, i8* %4, align 1
  store i8 117, i8* %5, align 1
  store i8 118, i8* %6, align 1
  store i8 119, i8* %7, align 1
  store i8 120, i8* %8, align 1
  store i8 121, i8* %9, align 1
  store i8 122, i8* %10, align 1
  store i8 123, i8* %11, align 1
  store i8 124, i8* %12, align 1
  %narrow59 = and i1 %narrow57, %not.60
  %146 = getelementptr inbounds %struct.Node, %struct.Node* %142, i64 0, i32 1
  %147 = load i8*, i8** %146, align 8
  %148 = call i32 @strcmp(i8* %147, i8* nonnull %3) #3
  %not.62 = icmp eq i32 %148, 0
  %narrow61 = and i1 %narrow59, %not.62
  %...026.peel85 = zext i1 %narrow61 to i8
  %149 = getelementptr inbounds %struct.Node, %struct.Node* %142, i64 0, i32 2
  %150 = load %struct.Node*, %struct.Node** %149, align 8
  %151 = icmp eq %struct.Node* %150, null
  br i1 %151, label %._crit_edge, label %.lr.ph.peel87

.lr.ph.peel87:                                    ; preds = %.lr.ph.peel82
  %152 = getelementptr inbounds %struct.Node, %struct.Node* %150, i64 0, i32 0
  %153 = load i32, i32* %152, align 8
  %not.64 = icmp eq i32 %153, 19
  store i8 116, i8* %3, align 1
  store i8 117, i8* %4, align 1
  store i8 118, i8* %5, align 1
  store i8 119, i8* %6, align 1
  store i8 120, i8* %7, align 1
  store i8 121, i8* %8, align 1
  store i8 122, i8* %9, align 1
  store i8 123, i8* %10, align 1
  store i8 124, i8* %11, align 1
  store i8 125, i8* %12, align 1
  %narrow63 = and i1 %narrow61, %not.64
  %154 = getelementptr inbounds %struct.Node, %struct.Node* %150, i64 0, i32 1
  %155 = load i8*, i8** %154, align 8
  %156 = call i32 @strcmp(i8* %155, i8* nonnull %3) #3
  %not.66 = icmp eq i32 %156, 0
  %narrow65 = and i1 %narrow63, %not.66
  %...026.peel90 = zext i1 %narrow65 to i8
  %157 = getelementptr inbounds %struct.Node, %struct.Node* %150, i64 0, i32 2
  %158 = load %struct.Node*, %struct.Node** %157, align 8
  %159 = icmp eq %struct.Node* %158, null
  br i1 %159, label %._crit_edge, label %.lr.ph.peel92

.lr.ph.peel92:                                    ; preds = %.lr.ph.peel87
  %160 = getelementptr inbounds %struct.Node, %struct.Node* %158, i64 0, i32 0
  %161 = load i32, i32* %160, align 8
  %not.68 = icmp eq i32 %161, 20
  store i8 117, i8* %3, align 1
  store i8 118, i8* %4, align 1
  store i8 119, i8* %5, align 1
  store i8 120, i8* %6, align 1
  store i8 121, i8* %7, align 1
  store i8 122, i8* %8, align 1
  store i8 123, i8* %9, align 1
  store i8 124, i8* %10, align 1
  store i8 125, i8* %11, align 1
  store i8 126, i8* %12, align 1
  %narrow67 = and i1 %narrow65, %not.68
  %162 = getelementptr inbounds %struct.Node, %struct.Node* %158, i64 0, i32 1
  %163 = load i8*, i8** %162, align 8
  %164 = call i32 @strcmp(i8* %163, i8* nonnull %3) #3
  %not.70 = icmp eq i32 %164, 0
  %narrow69 = and i1 %narrow67, %not.70
  %...026.peel95 = zext i1 %narrow69 to i8
  %165 = getelementptr inbounds %struct.Node, %struct.Node* %158, i64 0, i32 2
  %166 = load %struct.Node*, %struct.Node** %165, align 8
  %167 = icmp eq %struct.Node* %166, null
  br i1 %167, label %._crit_edge, label %.lr.ph.preheader115

.lr.ph.preheader115:                              ; preds = %.lr.ph.peel92
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader115, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 21, %.lr.ph.preheader115 ]
  %.026 = phi i8 [ %...026, %.lr.ph ], [ %...026.peel95, %.lr.ph.preheader115 ]
  %.035 = phi %struct.Node* [ %198, %.lr.ph ], [ %166, %.lr.ph.preheader115 ]
  %168 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 0
  %169 = load i32, i32* %168, align 8
  %170 = add nuw nsw i64 %indvars.iv, 97
  %171 = trunc i64 %170 to i8
  store i8 %171, i8* %3, align 1
  %172 = add nsw i64 %indvars.iv, 98
  %173 = trunc i64 %172 to i8
  store i8 %173, i8* %4, align 1
  %174 = add nsw i64 %indvars.iv, 99
  %175 = trunc i64 %174 to i8
  store i8 %175, i8* %5, align 1
  %176 = add nsw i64 %indvars.iv, 100
  %177 = trunc i64 %176 to i8
  store i8 %177, i8* %6, align 1
  %178 = add nsw i64 %indvars.iv, 101
  %179 = trunc i64 %178 to i8
  store i8 %179, i8* %7, align 1
  %180 = add nsw i64 %indvars.iv, 102
  %181 = trunc i64 %180 to i8
  store i8 %181, i8* %8, align 1
  %182 = add nsw i64 %indvars.iv, 103
  %183 = trunc i64 %182 to i8
  store i8 %183, i8* %9, align 1
  %184 = add nsw i64 %indvars.iv, 104
  %185 = trunc i64 %184 to i8
  store i8 %185, i8* %10, align 1
  %186 = add nsw i64 %indvars.iv, 105
  %187 = trunc i64 %186 to i8
  store i8 %187, i8* %11, align 1
  %188 = add nsw i64 %indvars.iv, 106
  %189 = trunc i64 %188 to i8
  store i8 %189, i8* %12, align 1
  %190 = zext i32 %169 to i64
  %191 = icmp ne i64 %190, %indvars.iv
  %192 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 1
  %193 = load i8*, i8** %192, align 8
  %194 = call i32 @strcmp(i8* %193, i8* nonnull %3) #3
  %195 = icmp ne i32 %194, 0
  %196 = or i1 %191, %195
  %...026 = select i1 %196, i8 0, i8 %.026
  %197 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 2
  %198 = load %struct.Node*, %struct.Node** %197, align 8
  %indvars.iv.next = add nuw i64 %indvars.iv, 1
  %199 = icmp eq %struct.Node* %198, null
  br i1 %199, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %.lr.ph.peel92, %.lr.ph.peel87, %.lr.ph.peel82, %.lr.ph.peel77, %.lr.ph.peel72, %.lr.ph.peel67, %.lr.ph.peel62, %.lr.ph.peel57, %.lr.ph.peel52, %.lr.ph.peel47, %.lr.ph.peel42, %.lr.ph.peel37, %.lr.ph.peel32, %.lr.ph.peel27, %.lr.ph.peel22, %.lr.ph.peel17, %.lr.ph.peel12, %.lr.ph.peel7, %.lr.ph.preheader
  %...026.lcssa = phi i8 [ %...026.peel5, %.lr.ph.preheader ], [ %...026.peel10, %.lr.ph.peel7 ], [ %...026.peel15, %.lr.ph.peel12 ], [ %...026.peel20, %.lr.ph.peel17 ], [ %...026.peel25, %.lr.ph.peel22 ], [ %...026.peel30, %.lr.ph.peel27 ], [ %...026.peel35, %.lr.ph.peel32 ], [ %...026.peel40, %.lr.ph.peel37 ], [ %...026.peel45, %.lr.ph.peel42 ], [ %...026.peel50, %.lr.ph.peel47 ], [ %...026.peel55, %.lr.ph.peel52 ], [ %...026.peel60, %.lr.ph.peel57 ], [ %...026.peel65, %.lr.ph.peel62 ], [ %...026.peel70, %.lr.ph.peel67 ], [ %...026.peel75, %.lr.ph.peel72 ], [ %...026.peel80, %.lr.ph.peel77 ], [ %...026.peel85, %.lr.ph.peel82 ], [ %...026.peel90, %.lr.ph.peel87 ], [ %...026.peel95, %.lr.ph.peel92 ], [ %...026, %._crit_edge.loopexit ]
  %200 = icmp eq i8 %...026.lcssa, 0
  br i1 %200, label %203, label %201

; <label>:201:                                    ; preds = %._crit_edge
  %202 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0))
  br label %203

; <label>:203:                                    ; preds = %._crit_edge, %201
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone_clone.33(%struct.Node* nocapture readonly) local_unnamed_addr #0 {
.lr.ph.preheader:
  %1 = alloca [11 x i8], align 1
  %2 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 10
  store i8 0, i8* %2, align 1
  %3 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 0
  %4 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 1
  %5 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 2
  %6 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 3
  %7 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 4
  %8 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 5
  %9 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 6
  %10 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 7
  %11 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 8
  %12 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 9
  %13 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 2
  %14 = load %struct.Node*, %struct.Node** %13, align 8
  %15 = getelementptr inbounds %struct.Node, %struct.Node* %14, i64 0, i32 2
  %16 = load %struct.Node*, %struct.Node** %15, align 8
  store i8 100, i8* %3, align 1
  store i8 101, i8* %4, align 1
  store i8 102, i8* %5, align 1
  store i8 103, i8* %6, align 1
  store i8 104, i8* %7, align 1
  store i8 105, i8* %8, align 1
  store i8 106, i8* %9, align 1
  store i8 107, i8* %10, align 1
  store i8 108, i8* %11, align 1
  store i8 109, i8* %12, align 1
  %17 = getelementptr inbounds %struct.Node, %struct.Node* %16, i64 0, i32 1
  %18 = load i8*, i8** %17, align 8
  %19 = call i32 @strcmp(i8* %18, i8* nonnull %3) #3
  %not. = icmp eq i32 %19, 0
  %...026.peel10 = zext i1 %not. to i8
  %20 = getelementptr inbounds %struct.Node, %struct.Node* %16, i64 0, i32 2
  %21 = load %struct.Node*, %struct.Node** %20, align 8
  %22 = icmp eq %struct.Node* %21, null
  br i1 %22, label %._crit_edge, label %.lr.ph.peel12

.lr.ph.peel12:                                    ; preds = %.lr.ph.preheader
  %23 = getelementptr inbounds %struct.Node, %struct.Node* %21, i64 0, i32 0
  %24 = load i32, i32* %23, align 8
  store i8 101, i8* %3, align 1
  store i8 102, i8* %4, align 1
  store i8 103, i8* %5, align 1
  store i8 104, i8* %6, align 1
  store i8 105, i8* %7, align 1
  store i8 106, i8* %8, align 1
  store i8 107, i8* %9, align 1
  store i8 108, i8* %10, align 1
  store i8 109, i8* %11, align 1
  store i8 110, i8* %12, align 1
  %not.1 = icmp eq i32 %24, 4
  %25 = getelementptr inbounds %struct.Node, %struct.Node* %21, i64 0, i32 1
  %26 = load i8*, i8** %25, align 8
  %27 = call i32 @strcmp(i8* %26, i8* nonnull %3) #3
  %28 = or i32 %27, %19
  %29 = icmp eq i32 %28, 0
  %30 = and i1 %not.1, %29
  %...026.peel15 = zext i1 %30 to i8
  %31 = getelementptr inbounds %struct.Node, %struct.Node* %21, i64 0, i32 2
  %32 = load %struct.Node*, %struct.Node** %31, align 8
  %33 = icmp eq %struct.Node* %32, null
  br i1 %33, label %._crit_edge, label %.lr.ph.peel17

.lr.ph.peel17:                                    ; preds = %.lr.ph.peel12
  %34 = getelementptr inbounds %struct.Node, %struct.Node* %32, i64 0, i32 0
  %35 = load i32, i32* %34, align 8
  %not.4 = icmp eq i32 %35, 5
  store i8 102, i8* %3, align 1
  store i8 103, i8* %4, align 1
  store i8 104, i8* %5, align 1
  store i8 105, i8* %6, align 1
  store i8 106, i8* %7, align 1
  store i8 107, i8* %8, align 1
  store i8 108, i8* %9, align 1
  store i8 109, i8* %10, align 1
  store i8 110, i8* %11, align 1
  store i8 111, i8* %12, align 1
  %narrow = and i1 %30, %not.4
  %36 = getelementptr inbounds %struct.Node, %struct.Node* %32, i64 0, i32 1
  %37 = load i8*, i8** %36, align 8
  %38 = call i32 @strcmp(i8* %37, i8* nonnull %3) #3
  %not.6 = icmp eq i32 %38, 0
  %narrow5 = and i1 %narrow, %not.6
  %...026.peel20 = zext i1 %narrow5 to i8
  %39 = getelementptr inbounds %struct.Node, %struct.Node* %32, i64 0, i32 2
  %40 = load %struct.Node*, %struct.Node** %39, align 8
  %41 = icmp eq %struct.Node* %40, null
  br i1 %41, label %._crit_edge, label %.lr.ph.peel22

.lr.ph.peel22:                                    ; preds = %.lr.ph.peel17
  %42 = getelementptr inbounds %struct.Node, %struct.Node* %40, i64 0, i32 0
  %43 = load i32, i32* %42, align 8
  %not.8 = icmp eq i32 %43, 6
  store i8 103, i8* %3, align 1
  store i8 104, i8* %4, align 1
  store i8 105, i8* %5, align 1
  store i8 106, i8* %6, align 1
  store i8 107, i8* %7, align 1
  store i8 108, i8* %8, align 1
  store i8 109, i8* %9, align 1
  store i8 110, i8* %10, align 1
  store i8 111, i8* %11, align 1
  store i8 112, i8* %12, align 1
  %narrow7 = and i1 %narrow5, %not.8
  %44 = getelementptr inbounds %struct.Node, %struct.Node* %40, i64 0, i32 1
  %45 = load i8*, i8** %44, align 8
  %46 = call i32 @strcmp(i8* %45, i8* nonnull %3) #3
  %not.10 = icmp eq i32 %46, 0
  %narrow9 = and i1 %narrow7, %not.10
  %...026.peel25 = zext i1 %narrow9 to i8
  %47 = getelementptr inbounds %struct.Node, %struct.Node* %40, i64 0, i32 2
  %48 = load %struct.Node*, %struct.Node** %47, align 8
  %49 = icmp eq %struct.Node* %48, null
  br i1 %49, label %._crit_edge, label %.lr.ph.peel27

.lr.ph.peel27:                                    ; preds = %.lr.ph.peel22
  %50 = getelementptr inbounds %struct.Node, %struct.Node* %48, i64 0, i32 0
  %51 = load i32, i32* %50, align 8
  %not.12 = icmp eq i32 %51, 7
  store i8 104, i8* %3, align 1
  store i8 105, i8* %4, align 1
  store i8 106, i8* %5, align 1
  store i8 107, i8* %6, align 1
  store i8 108, i8* %7, align 1
  store i8 109, i8* %8, align 1
  store i8 110, i8* %9, align 1
  store i8 111, i8* %10, align 1
  store i8 112, i8* %11, align 1
  store i8 113, i8* %12, align 1
  %narrow11 = and i1 %narrow9, %not.12
  %52 = getelementptr inbounds %struct.Node, %struct.Node* %48, i64 0, i32 1
  %53 = load i8*, i8** %52, align 8
  %54 = call i32 @strcmp(i8* %53, i8* nonnull %3) #3
  %not.14 = icmp eq i32 %54, 0
  %narrow13 = and i1 %narrow11, %not.14
  %...026.peel30 = zext i1 %narrow13 to i8
  %55 = getelementptr inbounds %struct.Node, %struct.Node* %48, i64 0, i32 2
  %56 = load %struct.Node*, %struct.Node** %55, align 8
  %57 = icmp eq %struct.Node* %56, null
  br i1 %57, label %._crit_edge, label %.lr.ph.peel32

.lr.ph.peel32:                                    ; preds = %.lr.ph.peel27
  %58 = getelementptr inbounds %struct.Node, %struct.Node* %56, i64 0, i32 0
  %59 = load i32, i32* %58, align 8
  %not.16 = icmp eq i32 %59, 8
  store i8 105, i8* %3, align 1
  store i8 106, i8* %4, align 1
  store i8 107, i8* %5, align 1
  store i8 108, i8* %6, align 1
  store i8 109, i8* %7, align 1
  store i8 110, i8* %8, align 1
  store i8 111, i8* %9, align 1
  store i8 112, i8* %10, align 1
  store i8 113, i8* %11, align 1
  store i8 114, i8* %12, align 1
  %narrow15 = and i1 %narrow13, %not.16
  %60 = getelementptr inbounds %struct.Node, %struct.Node* %56, i64 0, i32 1
  %61 = load i8*, i8** %60, align 8
  %62 = call i32 @strcmp(i8* %61, i8* nonnull %3) #3
  %not.18 = icmp eq i32 %62, 0
  %narrow17 = and i1 %narrow15, %not.18
  %...026.peel35 = zext i1 %narrow17 to i8
  %63 = getelementptr inbounds %struct.Node, %struct.Node* %56, i64 0, i32 2
  %64 = load %struct.Node*, %struct.Node** %63, align 8
  %65 = icmp eq %struct.Node* %64, null
  br i1 %65, label %._crit_edge, label %.lr.ph.peel37

.lr.ph.peel37:                                    ; preds = %.lr.ph.peel32
  %66 = getelementptr inbounds %struct.Node, %struct.Node* %64, i64 0, i32 0
  %67 = load i32, i32* %66, align 8
  %not.20 = icmp eq i32 %67, 9
  store i8 106, i8* %3, align 1
  store i8 107, i8* %4, align 1
  store i8 108, i8* %5, align 1
  store i8 109, i8* %6, align 1
  store i8 110, i8* %7, align 1
  store i8 111, i8* %8, align 1
  store i8 112, i8* %9, align 1
  store i8 113, i8* %10, align 1
  store i8 114, i8* %11, align 1
  store i8 115, i8* %12, align 1
  %narrow19 = and i1 %narrow17, %not.20
  %68 = getelementptr inbounds %struct.Node, %struct.Node* %64, i64 0, i32 1
  %69 = load i8*, i8** %68, align 8
  %70 = call i32 @strcmp(i8* %69, i8* nonnull %3) #3
  %not.22 = icmp eq i32 %70, 0
  %narrow21 = and i1 %narrow19, %not.22
  %...026.peel40 = zext i1 %narrow21 to i8
  %71 = getelementptr inbounds %struct.Node, %struct.Node* %64, i64 0, i32 2
  %72 = load %struct.Node*, %struct.Node** %71, align 8
  %73 = icmp eq %struct.Node* %72, null
  br i1 %73, label %._crit_edge, label %.lr.ph.peel42

.lr.ph.peel42:                                    ; preds = %.lr.ph.peel37
  %74 = getelementptr inbounds %struct.Node, %struct.Node* %72, i64 0, i32 0
  %75 = load i32, i32* %74, align 8
  %not.24 = icmp eq i32 %75, 10
  store i8 107, i8* %3, align 1
  store i8 108, i8* %4, align 1
  store i8 109, i8* %5, align 1
  store i8 110, i8* %6, align 1
  store i8 111, i8* %7, align 1
  store i8 112, i8* %8, align 1
  store i8 113, i8* %9, align 1
  store i8 114, i8* %10, align 1
  store i8 115, i8* %11, align 1
  store i8 116, i8* %12, align 1
  %narrow23 = and i1 %narrow21, %not.24
  %76 = getelementptr inbounds %struct.Node, %struct.Node* %72, i64 0, i32 1
  %77 = load i8*, i8** %76, align 8
  %78 = call i32 @strcmp(i8* %77, i8* nonnull %3) #3
  %not.26 = icmp eq i32 %78, 0
  %narrow25 = and i1 %narrow23, %not.26
  %...026.peel45 = zext i1 %narrow25 to i8
  %79 = getelementptr inbounds %struct.Node, %struct.Node* %72, i64 0, i32 2
  %80 = load %struct.Node*, %struct.Node** %79, align 8
  %81 = icmp eq %struct.Node* %80, null
  br i1 %81, label %._crit_edge, label %.lr.ph.peel47

.lr.ph.peel47:                                    ; preds = %.lr.ph.peel42
  %82 = getelementptr inbounds %struct.Node, %struct.Node* %80, i64 0, i32 0
  %83 = load i32, i32* %82, align 8
  %not.28 = icmp eq i32 %83, 11
  store i8 108, i8* %3, align 1
  store i8 109, i8* %4, align 1
  store i8 110, i8* %5, align 1
  store i8 111, i8* %6, align 1
  store i8 112, i8* %7, align 1
  store i8 113, i8* %8, align 1
  store i8 114, i8* %9, align 1
  store i8 115, i8* %10, align 1
  store i8 116, i8* %11, align 1
  store i8 117, i8* %12, align 1
  %narrow27 = and i1 %narrow25, %not.28
  %84 = getelementptr inbounds %struct.Node, %struct.Node* %80, i64 0, i32 1
  %85 = load i8*, i8** %84, align 8
  %86 = call i32 @strcmp(i8* %85, i8* nonnull %3) #3
  %not.30 = icmp eq i32 %86, 0
  %narrow29 = and i1 %narrow27, %not.30
  %...026.peel50 = zext i1 %narrow29 to i8
  %87 = getelementptr inbounds %struct.Node, %struct.Node* %80, i64 0, i32 2
  %88 = load %struct.Node*, %struct.Node** %87, align 8
  %89 = icmp eq %struct.Node* %88, null
  br i1 %89, label %._crit_edge, label %.lr.ph.peel52

.lr.ph.peel52:                                    ; preds = %.lr.ph.peel47
  %90 = getelementptr inbounds %struct.Node, %struct.Node* %88, i64 0, i32 0
  %91 = load i32, i32* %90, align 8
  %not.32 = icmp eq i32 %91, 12
  store i8 109, i8* %3, align 1
  store i8 110, i8* %4, align 1
  store i8 111, i8* %5, align 1
  store i8 112, i8* %6, align 1
  store i8 113, i8* %7, align 1
  store i8 114, i8* %8, align 1
  store i8 115, i8* %9, align 1
  store i8 116, i8* %10, align 1
  store i8 117, i8* %11, align 1
  store i8 118, i8* %12, align 1
  %narrow31 = and i1 %narrow29, %not.32
  %92 = getelementptr inbounds %struct.Node, %struct.Node* %88, i64 0, i32 1
  %93 = load i8*, i8** %92, align 8
  %94 = call i32 @strcmp(i8* %93, i8* nonnull %3) #3
  %not.34 = icmp eq i32 %94, 0
  %narrow33 = and i1 %narrow31, %not.34
  %...026.peel55 = zext i1 %narrow33 to i8
  %95 = getelementptr inbounds %struct.Node, %struct.Node* %88, i64 0, i32 2
  %96 = load %struct.Node*, %struct.Node** %95, align 8
  %97 = icmp eq %struct.Node* %96, null
  br i1 %97, label %._crit_edge, label %.lr.ph.peel57

.lr.ph.peel57:                                    ; preds = %.lr.ph.peel52
  %98 = getelementptr inbounds %struct.Node, %struct.Node* %96, i64 0, i32 0
  %99 = load i32, i32* %98, align 8
  %not.36 = icmp eq i32 %99, 13
  store i8 110, i8* %3, align 1
  store i8 111, i8* %4, align 1
  store i8 112, i8* %5, align 1
  store i8 113, i8* %6, align 1
  store i8 114, i8* %7, align 1
  store i8 115, i8* %8, align 1
  store i8 116, i8* %9, align 1
  store i8 117, i8* %10, align 1
  store i8 118, i8* %11, align 1
  store i8 119, i8* %12, align 1
  %narrow35 = and i1 %narrow33, %not.36
  %100 = getelementptr inbounds %struct.Node, %struct.Node* %96, i64 0, i32 1
  %101 = load i8*, i8** %100, align 8
  %102 = call i32 @strcmp(i8* %101, i8* nonnull %3) #3
  %not.38 = icmp eq i32 %102, 0
  %narrow37 = and i1 %narrow35, %not.38
  %...026.peel60 = zext i1 %narrow37 to i8
  %103 = getelementptr inbounds %struct.Node, %struct.Node* %96, i64 0, i32 2
  %104 = load %struct.Node*, %struct.Node** %103, align 8
  %105 = icmp eq %struct.Node* %104, null
  br i1 %105, label %._crit_edge, label %.lr.ph.peel62

.lr.ph.peel62:                                    ; preds = %.lr.ph.peel57
  %106 = getelementptr inbounds %struct.Node, %struct.Node* %104, i64 0, i32 0
  %107 = load i32, i32* %106, align 8
  %not.40 = icmp eq i32 %107, 14
  store i8 111, i8* %3, align 1
  store i8 112, i8* %4, align 1
  store i8 113, i8* %5, align 1
  store i8 114, i8* %6, align 1
  store i8 115, i8* %7, align 1
  store i8 116, i8* %8, align 1
  store i8 117, i8* %9, align 1
  store i8 118, i8* %10, align 1
  store i8 119, i8* %11, align 1
  store i8 120, i8* %12, align 1
  %narrow39 = and i1 %narrow37, %not.40
  %108 = getelementptr inbounds %struct.Node, %struct.Node* %104, i64 0, i32 1
  %109 = load i8*, i8** %108, align 8
  %110 = call i32 @strcmp(i8* %109, i8* nonnull %3) #3
  %not.42 = icmp eq i32 %110, 0
  %narrow41 = and i1 %narrow39, %not.42
  %...026.peel65 = zext i1 %narrow41 to i8
  %111 = getelementptr inbounds %struct.Node, %struct.Node* %104, i64 0, i32 2
  %112 = load %struct.Node*, %struct.Node** %111, align 8
  %113 = icmp eq %struct.Node* %112, null
  br i1 %113, label %._crit_edge, label %.lr.ph.peel67

.lr.ph.peel67:                                    ; preds = %.lr.ph.peel62
  %114 = getelementptr inbounds %struct.Node, %struct.Node* %112, i64 0, i32 0
  %115 = load i32, i32* %114, align 8
  %not.44 = icmp eq i32 %115, 15
  store i8 112, i8* %3, align 1
  store i8 113, i8* %4, align 1
  store i8 114, i8* %5, align 1
  store i8 115, i8* %6, align 1
  store i8 116, i8* %7, align 1
  store i8 117, i8* %8, align 1
  store i8 118, i8* %9, align 1
  store i8 119, i8* %10, align 1
  store i8 120, i8* %11, align 1
  store i8 121, i8* %12, align 1
  %narrow43 = and i1 %narrow41, %not.44
  %116 = getelementptr inbounds %struct.Node, %struct.Node* %112, i64 0, i32 1
  %117 = load i8*, i8** %116, align 8
  %118 = call i32 @strcmp(i8* %117, i8* nonnull %3) #3
  %not.46 = icmp eq i32 %118, 0
  %narrow45 = and i1 %narrow43, %not.46
  %...026.peel70 = zext i1 %narrow45 to i8
  %119 = getelementptr inbounds %struct.Node, %struct.Node* %112, i64 0, i32 2
  %120 = load %struct.Node*, %struct.Node** %119, align 8
  %121 = icmp eq %struct.Node* %120, null
  br i1 %121, label %._crit_edge, label %.lr.ph.peel72

.lr.ph.peel72:                                    ; preds = %.lr.ph.peel67
  %122 = getelementptr inbounds %struct.Node, %struct.Node* %120, i64 0, i32 0
  %123 = load i32, i32* %122, align 8
  %not.48 = icmp eq i32 %123, 16
  store i8 113, i8* %3, align 1
  store i8 114, i8* %4, align 1
  store i8 115, i8* %5, align 1
  store i8 116, i8* %6, align 1
  store i8 117, i8* %7, align 1
  store i8 118, i8* %8, align 1
  store i8 119, i8* %9, align 1
  store i8 120, i8* %10, align 1
  store i8 121, i8* %11, align 1
  store i8 122, i8* %12, align 1
  %narrow47 = and i1 %narrow45, %not.48
  %124 = getelementptr inbounds %struct.Node, %struct.Node* %120, i64 0, i32 1
  %125 = load i8*, i8** %124, align 8
  %126 = call i32 @strcmp(i8* %125, i8* nonnull %3) #3
  %not.50 = icmp eq i32 %126, 0
  %narrow49 = and i1 %narrow47, %not.50
  %...026.peel75 = zext i1 %narrow49 to i8
  %127 = getelementptr inbounds %struct.Node, %struct.Node* %120, i64 0, i32 2
  %128 = load %struct.Node*, %struct.Node** %127, align 8
  %129 = icmp eq %struct.Node* %128, null
  br i1 %129, label %._crit_edge, label %.lr.ph.peel77

.lr.ph.peel77:                                    ; preds = %.lr.ph.peel72
  %130 = getelementptr inbounds %struct.Node, %struct.Node* %128, i64 0, i32 0
  %131 = load i32, i32* %130, align 8
  %not.52 = icmp eq i32 %131, 17
  store i8 114, i8* %3, align 1
  store i8 115, i8* %4, align 1
  store i8 116, i8* %5, align 1
  store i8 117, i8* %6, align 1
  store i8 118, i8* %7, align 1
  store i8 119, i8* %8, align 1
  store i8 120, i8* %9, align 1
  store i8 121, i8* %10, align 1
  store i8 122, i8* %11, align 1
  store i8 123, i8* %12, align 1
  %narrow51 = and i1 %narrow49, %not.52
  %132 = getelementptr inbounds %struct.Node, %struct.Node* %128, i64 0, i32 1
  %133 = load i8*, i8** %132, align 8
  %134 = call i32 @strcmp(i8* %133, i8* nonnull %3) #3
  %not.54 = icmp eq i32 %134, 0
  %narrow53 = and i1 %narrow51, %not.54
  %...026.peel80 = zext i1 %narrow53 to i8
  %135 = getelementptr inbounds %struct.Node, %struct.Node* %128, i64 0, i32 2
  %136 = load %struct.Node*, %struct.Node** %135, align 8
  %137 = icmp eq %struct.Node* %136, null
  br i1 %137, label %._crit_edge, label %.lr.ph.peel82

.lr.ph.peel82:                                    ; preds = %.lr.ph.peel77
  %138 = getelementptr inbounds %struct.Node, %struct.Node* %136, i64 0, i32 0
  %139 = load i32, i32* %138, align 8
  %not.56 = icmp eq i32 %139, 18
  store i8 115, i8* %3, align 1
  store i8 116, i8* %4, align 1
  store i8 117, i8* %5, align 1
  store i8 118, i8* %6, align 1
  store i8 119, i8* %7, align 1
  store i8 120, i8* %8, align 1
  store i8 121, i8* %9, align 1
  store i8 122, i8* %10, align 1
  store i8 123, i8* %11, align 1
  store i8 124, i8* %12, align 1
  %narrow55 = and i1 %narrow53, %not.56
  %140 = getelementptr inbounds %struct.Node, %struct.Node* %136, i64 0, i32 1
  %141 = load i8*, i8** %140, align 8
  %142 = call i32 @strcmp(i8* %141, i8* nonnull %3) #3
  %not.58 = icmp eq i32 %142, 0
  %narrow57 = and i1 %narrow55, %not.58
  %...026.peel85 = zext i1 %narrow57 to i8
  %143 = getelementptr inbounds %struct.Node, %struct.Node* %136, i64 0, i32 2
  %144 = load %struct.Node*, %struct.Node** %143, align 8
  %145 = icmp eq %struct.Node* %144, null
  br i1 %145, label %._crit_edge, label %.lr.ph.peel87

.lr.ph.peel87:                                    ; preds = %.lr.ph.peel82
  %146 = getelementptr inbounds %struct.Node, %struct.Node* %144, i64 0, i32 0
  %147 = load i32, i32* %146, align 8
  %not.60 = icmp eq i32 %147, 19
  store i8 116, i8* %3, align 1
  store i8 117, i8* %4, align 1
  store i8 118, i8* %5, align 1
  store i8 119, i8* %6, align 1
  store i8 120, i8* %7, align 1
  store i8 121, i8* %8, align 1
  store i8 122, i8* %9, align 1
  store i8 123, i8* %10, align 1
  store i8 124, i8* %11, align 1
  store i8 125, i8* %12, align 1
  %narrow59 = and i1 %narrow57, %not.60
  %148 = getelementptr inbounds %struct.Node, %struct.Node* %144, i64 0, i32 1
  %149 = load i8*, i8** %148, align 8
  %150 = call i32 @strcmp(i8* %149, i8* nonnull %3) #3
  %not.62 = icmp eq i32 %150, 0
  %narrow61 = and i1 %narrow59, %not.62
  %...026.peel90 = zext i1 %narrow61 to i8
  %151 = getelementptr inbounds %struct.Node, %struct.Node* %144, i64 0, i32 2
  %152 = load %struct.Node*, %struct.Node** %151, align 8
  %153 = icmp eq %struct.Node* %152, null
  br i1 %153, label %._crit_edge, label %.lr.ph.peel92

.lr.ph.peel92:                                    ; preds = %.lr.ph.peel87
  %154 = getelementptr inbounds %struct.Node, %struct.Node* %152, i64 0, i32 0
  %155 = load i32, i32* %154, align 8
  %not.64 = icmp eq i32 %155, 20
  store i8 117, i8* %3, align 1
  store i8 118, i8* %4, align 1
  store i8 119, i8* %5, align 1
  store i8 120, i8* %6, align 1
  store i8 121, i8* %7, align 1
  store i8 122, i8* %8, align 1
  store i8 123, i8* %9, align 1
  store i8 124, i8* %10, align 1
  store i8 125, i8* %11, align 1
  store i8 126, i8* %12, align 1
  %narrow63 = and i1 %narrow61, %not.64
  %156 = getelementptr inbounds %struct.Node, %struct.Node* %152, i64 0, i32 1
  %157 = load i8*, i8** %156, align 8
  %158 = call i32 @strcmp(i8* %157, i8* nonnull %3) #3
  %not.66 = icmp eq i32 %158, 0
  %narrow65 = and i1 %narrow63, %not.66
  %...026.peel95 = zext i1 %narrow65 to i8
  %159 = getelementptr inbounds %struct.Node, %struct.Node* %152, i64 0, i32 2
  %160 = load %struct.Node*, %struct.Node** %159, align 8
  %161 = icmp eq %struct.Node* %160, null
  br i1 %161, label %._crit_edge, label %.lr.ph.preheader109

.lr.ph.preheader109:                              ; preds = %.lr.ph.peel92
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader109, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 21, %.lr.ph.preheader109 ]
  %.026 = phi i8 [ %...026, %.lr.ph ], [ %...026.peel95, %.lr.ph.preheader109 ]
  %.035 = phi %struct.Node* [ %192, %.lr.ph ], [ %160, %.lr.ph.preheader109 ]
  %162 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 0
  %163 = load i32, i32* %162, align 8
  %164 = add nuw nsw i64 %indvars.iv, 97
  %165 = trunc i64 %164 to i8
  store i8 %165, i8* %3, align 1
  %166 = add nsw i64 %indvars.iv, 98
  %167 = trunc i64 %166 to i8
  store i8 %167, i8* %4, align 1
  %168 = add nsw i64 %indvars.iv, 99
  %169 = trunc i64 %168 to i8
  store i8 %169, i8* %5, align 1
  %170 = add nsw i64 %indvars.iv, 100
  %171 = trunc i64 %170 to i8
  store i8 %171, i8* %6, align 1
  %172 = add nsw i64 %indvars.iv, 101
  %173 = trunc i64 %172 to i8
  store i8 %173, i8* %7, align 1
  %174 = add nsw i64 %indvars.iv, 102
  %175 = trunc i64 %174 to i8
  store i8 %175, i8* %8, align 1
  %176 = add nsw i64 %indvars.iv, 103
  %177 = trunc i64 %176 to i8
  store i8 %177, i8* %9, align 1
  %178 = add nsw i64 %indvars.iv, 104
  %179 = trunc i64 %178 to i8
  store i8 %179, i8* %10, align 1
  %180 = add nsw i64 %indvars.iv, 105
  %181 = trunc i64 %180 to i8
  store i8 %181, i8* %11, align 1
  %182 = add nsw i64 %indvars.iv, 106
  %183 = trunc i64 %182 to i8
  store i8 %183, i8* %12, align 1
  %184 = zext i32 %163 to i64
  %185 = icmp ne i64 %184, %indvars.iv
  %186 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 1
  %187 = load i8*, i8** %186, align 8
  %188 = call i32 @strcmp(i8* %187, i8* nonnull %3) #3
  %189 = icmp ne i32 %188, 0
  %190 = or i1 %185, %189
  %...026 = select i1 %190, i8 0, i8 %.026
  %191 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 2
  %192 = load %struct.Node*, %struct.Node** %191, align 8
  %indvars.iv.next = add nuw i64 %indvars.iv, 1
  %193 = icmp eq %struct.Node* %192, null
  br i1 %193, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %.lr.ph.peel92, %.lr.ph.peel87, %.lr.ph.peel82, %.lr.ph.peel77, %.lr.ph.peel72, %.lr.ph.peel67, %.lr.ph.peel62, %.lr.ph.peel57, %.lr.ph.peel52, %.lr.ph.peel47, %.lr.ph.peel42, %.lr.ph.peel37, %.lr.ph.peel32, %.lr.ph.peel27, %.lr.ph.peel22, %.lr.ph.peel17, %.lr.ph.peel12, %.lr.ph.preheader
  %...026.lcssa = phi i8 [ %...026.peel10, %.lr.ph.preheader ], [ %...026.peel15, %.lr.ph.peel12 ], [ %...026.peel20, %.lr.ph.peel17 ], [ %...026.peel25, %.lr.ph.peel22 ], [ %...026.peel30, %.lr.ph.peel27 ], [ %...026.peel35, %.lr.ph.peel32 ], [ %...026.peel40, %.lr.ph.peel37 ], [ %...026.peel45, %.lr.ph.peel42 ], [ %...026.peel50, %.lr.ph.peel47 ], [ %...026.peel55, %.lr.ph.peel52 ], [ %...026.peel60, %.lr.ph.peel57 ], [ %...026.peel65, %.lr.ph.peel62 ], [ %...026.peel70, %.lr.ph.peel67 ], [ %...026.peel75, %.lr.ph.peel72 ], [ %...026.peel80, %.lr.ph.peel77 ], [ %...026.peel85, %.lr.ph.peel82 ], [ %...026.peel90, %.lr.ph.peel87 ], [ %...026.peel95, %.lr.ph.peel92 ], [ %...026, %._crit_edge.loopexit ]
  %194 = icmp eq i8 %...026.lcssa, 0
  br i1 %194, label %197, label %195

; <label>:195:                                    ; preds = %._crit_edge
  %196 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0))
  br label %197

; <label>:197:                                    ; preds = %._crit_edge, %195
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone_clone.35(%struct.Node* nocapture readonly) local_unnamed_addr #0 {
.lr.ph.preheader:
  %1 = alloca [11 x i8], align 1
  %2 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 10
  store i8 0, i8* %2, align 1
  %3 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 0
  %4 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 1
  %5 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 2
  %6 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 3
  %7 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 4
  %8 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 5
  %9 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 6
  %10 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 7
  %11 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 8
  %12 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 9
  %13 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 2
  %14 = load %struct.Node*, %struct.Node** %13, align 8
  %15 = getelementptr inbounds %struct.Node, %struct.Node* %14, i64 0, i32 2
  %16 = load %struct.Node*, %struct.Node** %15, align 8
  %17 = getelementptr inbounds %struct.Node, %struct.Node* %16, i64 0, i32 2
  %18 = load %struct.Node*, %struct.Node** %17, align 8
  store i8 101, i8* %3, align 1
  store i8 102, i8* %4, align 1
  store i8 103, i8* %5, align 1
  store i8 104, i8* %6, align 1
  store i8 105, i8* %7, align 1
  store i8 106, i8* %8, align 1
  store i8 107, i8* %9, align 1
  store i8 108, i8* %10, align 1
  store i8 109, i8* %11, align 1
  store i8 110, i8* %12, align 1
  %19 = getelementptr inbounds %struct.Node, %struct.Node* %18, i64 0, i32 1
  %20 = load i8*, i8** %19, align 8
  %21 = call i32 @strcmp(i8* %20, i8* nonnull %3) #3
  %not. = icmp eq i32 %21, 0
  %...026.peel15 = zext i1 %not. to i8
  %22 = getelementptr inbounds %struct.Node, %struct.Node* %18, i64 0, i32 2
  %23 = load %struct.Node*, %struct.Node** %22, align 8
  %24 = icmp eq %struct.Node* %23, null
  br i1 %24, label %._crit_edge, label %.lr.ph.peel17

.lr.ph.peel17:                                    ; preds = %.lr.ph.preheader
  %25 = getelementptr inbounds %struct.Node, %struct.Node* %23, i64 0, i32 0
  %26 = load i32, i32* %25, align 8
  store i8 102, i8* %3, align 1
  store i8 103, i8* %4, align 1
  store i8 104, i8* %5, align 1
  store i8 105, i8* %6, align 1
  store i8 106, i8* %7, align 1
  store i8 107, i8* %8, align 1
  store i8 108, i8* %9, align 1
  store i8 109, i8* %10, align 1
  store i8 110, i8* %11, align 1
  store i8 111, i8* %12, align 1
  %not.1 = icmp eq i32 %26, 5
  %27 = getelementptr inbounds %struct.Node, %struct.Node* %23, i64 0, i32 1
  %28 = load i8*, i8** %27, align 8
  %29 = call i32 @strcmp(i8* %28, i8* nonnull %3) #3
  %30 = or i32 %29, %21
  %31 = icmp eq i32 %30, 0
  %32 = and i1 %not.1, %31
  %...026.peel20 = zext i1 %32 to i8
  %33 = getelementptr inbounds %struct.Node, %struct.Node* %23, i64 0, i32 2
  %34 = load %struct.Node*, %struct.Node** %33, align 8
  %35 = icmp eq %struct.Node* %34, null
  br i1 %35, label %._crit_edge, label %.lr.ph.peel22

.lr.ph.peel22:                                    ; preds = %.lr.ph.peel17
  %36 = getelementptr inbounds %struct.Node, %struct.Node* %34, i64 0, i32 0
  %37 = load i32, i32* %36, align 8
  %not.4 = icmp eq i32 %37, 6
  store i8 103, i8* %3, align 1
  store i8 104, i8* %4, align 1
  store i8 105, i8* %5, align 1
  store i8 106, i8* %6, align 1
  store i8 107, i8* %7, align 1
  store i8 108, i8* %8, align 1
  store i8 109, i8* %9, align 1
  store i8 110, i8* %10, align 1
  store i8 111, i8* %11, align 1
  store i8 112, i8* %12, align 1
  %narrow = and i1 %32, %not.4
  %38 = getelementptr inbounds %struct.Node, %struct.Node* %34, i64 0, i32 1
  %39 = load i8*, i8** %38, align 8
  %40 = call i32 @strcmp(i8* %39, i8* nonnull %3) #3
  %not.6 = icmp eq i32 %40, 0
  %narrow5 = and i1 %narrow, %not.6
  %...026.peel25 = zext i1 %narrow5 to i8
  %41 = getelementptr inbounds %struct.Node, %struct.Node* %34, i64 0, i32 2
  %42 = load %struct.Node*, %struct.Node** %41, align 8
  %43 = icmp eq %struct.Node* %42, null
  br i1 %43, label %._crit_edge, label %.lr.ph.peel27

.lr.ph.peel27:                                    ; preds = %.lr.ph.peel22
  %44 = getelementptr inbounds %struct.Node, %struct.Node* %42, i64 0, i32 0
  %45 = load i32, i32* %44, align 8
  %not.8 = icmp eq i32 %45, 7
  store i8 104, i8* %3, align 1
  store i8 105, i8* %4, align 1
  store i8 106, i8* %5, align 1
  store i8 107, i8* %6, align 1
  store i8 108, i8* %7, align 1
  store i8 109, i8* %8, align 1
  store i8 110, i8* %9, align 1
  store i8 111, i8* %10, align 1
  store i8 112, i8* %11, align 1
  store i8 113, i8* %12, align 1
  %narrow7 = and i1 %narrow5, %not.8
  %46 = getelementptr inbounds %struct.Node, %struct.Node* %42, i64 0, i32 1
  %47 = load i8*, i8** %46, align 8
  %48 = call i32 @strcmp(i8* %47, i8* nonnull %3) #3
  %not.10 = icmp eq i32 %48, 0
  %narrow9 = and i1 %narrow7, %not.10
  %...026.peel30 = zext i1 %narrow9 to i8
  %49 = getelementptr inbounds %struct.Node, %struct.Node* %42, i64 0, i32 2
  %50 = load %struct.Node*, %struct.Node** %49, align 8
  %51 = icmp eq %struct.Node* %50, null
  br i1 %51, label %._crit_edge, label %.lr.ph.peel32

.lr.ph.peel32:                                    ; preds = %.lr.ph.peel27
  %52 = getelementptr inbounds %struct.Node, %struct.Node* %50, i64 0, i32 0
  %53 = load i32, i32* %52, align 8
  %not.12 = icmp eq i32 %53, 8
  store i8 105, i8* %3, align 1
  store i8 106, i8* %4, align 1
  store i8 107, i8* %5, align 1
  store i8 108, i8* %6, align 1
  store i8 109, i8* %7, align 1
  store i8 110, i8* %8, align 1
  store i8 111, i8* %9, align 1
  store i8 112, i8* %10, align 1
  store i8 113, i8* %11, align 1
  store i8 114, i8* %12, align 1
  %narrow11 = and i1 %narrow9, %not.12
  %54 = getelementptr inbounds %struct.Node, %struct.Node* %50, i64 0, i32 1
  %55 = load i8*, i8** %54, align 8
  %56 = call i32 @strcmp(i8* %55, i8* nonnull %3) #3
  %not.14 = icmp eq i32 %56, 0
  %narrow13 = and i1 %narrow11, %not.14
  %...026.peel35 = zext i1 %narrow13 to i8
  %57 = getelementptr inbounds %struct.Node, %struct.Node* %50, i64 0, i32 2
  %58 = load %struct.Node*, %struct.Node** %57, align 8
  %59 = icmp eq %struct.Node* %58, null
  br i1 %59, label %._crit_edge, label %.lr.ph.peel37

.lr.ph.peel37:                                    ; preds = %.lr.ph.peel32
  %60 = getelementptr inbounds %struct.Node, %struct.Node* %58, i64 0, i32 0
  %61 = load i32, i32* %60, align 8
  %not.16 = icmp eq i32 %61, 9
  store i8 106, i8* %3, align 1
  store i8 107, i8* %4, align 1
  store i8 108, i8* %5, align 1
  store i8 109, i8* %6, align 1
  store i8 110, i8* %7, align 1
  store i8 111, i8* %8, align 1
  store i8 112, i8* %9, align 1
  store i8 113, i8* %10, align 1
  store i8 114, i8* %11, align 1
  store i8 115, i8* %12, align 1
  %narrow15 = and i1 %narrow13, %not.16
  %62 = getelementptr inbounds %struct.Node, %struct.Node* %58, i64 0, i32 1
  %63 = load i8*, i8** %62, align 8
  %64 = call i32 @strcmp(i8* %63, i8* nonnull %3) #3
  %not.18 = icmp eq i32 %64, 0
  %narrow17 = and i1 %narrow15, %not.18
  %...026.peel40 = zext i1 %narrow17 to i8
  %65 = getelementptr inbounds %struct.Node, %struct.Node* %58, i64 0, i32 2
  %66 = load %struct.Node*, %struct.Node** %65, align 8
  %67 = icmp eq %struct.Node* %66, null
  br i1 %67, label %._crit_edge, label %.lr.ph.peel42

.lr.ph.peel42:                                    ; preds = %.lr.ph.peel37
  %68 = getelementptr inbounds %struct.Node, %struct.Node* %66, i64 0, i32 0
  %69 = load i32, i32* %68, align 8
  %not.20 = icmp eq i32 %69, 10
  store i8 107, i8* %3, align 1
  store i8 108, i8* %4, align 1
  store i8 109, i8* %5, align 1
  store i8 110, i8* %6, align 1
  store i8 111, i8* %7, align 1
  store i8 112, i8* %8, align 1
  store i8 113, i8* %9, align 1
  store i8 114, i8* %10, align 1
  store i8 115, i8* %11, align 1
  store i8 116, i8* %12, align 1
  %narrow19 = and i1 %narrow17, %not.20
  %70 = getelementptr inbounds %struct.Node, %struct.Node* %66, i64 0, i32 1
  %71 = load i8*, i8** %70, align 8
  %72 = call i32 @strcmp(i8* %71, i8* nonnull %3) #3
  %not.22 = icmp eq i32 %72, 0
  %narrow21 = and i1 %narrow19, %not.22
  %...026.peel45 = zext i1 %narrow21 to i8
  %73 = getelementptr inbounds %struct.Node, %struct.Node* %66, i64 0, i32 2
  %74 = load %struct.Node*, %struct.Node** %73, align 8
  %75 = icmp eq %struct.Node* %74, null
  br i1 %75, label %._crit_edge, label %.lr.ph.peel47

.lr.ph.peel47:                                    ; preds = %.lr.ph.peel42
  %76 = getelementptr inbounds %struct.Node, %struct.Node* %74, i64 0, i32 0
  %77 = load i32, i32* %76, align 8
  %not.24 = icmp eq i32 %77, 11
  store i8 108, i8* %3, align 1
  store i8 109, i8* %4, align 1
  store i8 110, i8* %5, align 1
  store i8 111, i8* %6, align 1
  store i8 112, i8* %7, align 1
  store i8 113, i8* %8, align 1
  store i8 114, i8* %9, align 1
  store i8 115, i8* %10, align 1
  store i8 116, i8* %11, align 1
  store i8 117, i8* %12, align 1
  %narrow23 = and i1 %narrow21, %not.24
  %78 = getelementptr inbounds %struct.Node, %struct.Node* %74, i64 0, i32 1
  %79 = load i8*, i8** %78, align 8
  %80 = call i32 @strcmp(i8* %79, i8* nonnull %3) #3
  %not.26 = icmp eq i32 %80, 0
  %narrow25 = and i1 %narrow23, %not.26
  %...026.peel50 = zext i1 %narrow25 to i8
  %81 = getelementptr inbounds %struct.Node, %struct.Node* %74, i64 0, i32 2
  %82 = load %struct.Node*, %struct.Node** %81, align 8
  %83 = icmp eq %struct.Node* %82, null
  br i1 %83, label %._crit_edge, label %.lr.ph.peel52

.lr.ph.peel52:                                    ; preds = %.lr.ph.peel47
  %84 = getelementptr inbounds %struct.Node, %struct.Node* %82, i64 0, i32 0
  %85 = load i32, i32* %84, align 8
  %not.28 = icmp eq i32 %85, 12
  store i8 109, i8* %3, align 1
  store i8 110, i8* %4, align 1
  store i8 111, i8* %5, align 1
  store i8 112, i8* %6, align 1
  store i8 113, i8* %7, align 1
  store i8 114, i8* %8, align 1
  store i8 115, i8* %9, align 1
  store i8 116, i8* %10, align 1
  store i8 117, i8* %11, align 1
  store i8 118, i8* %12, align 1
  %narrow27 = and i1 %narrow25, %not.28
  %86 = getelementptr inbounds %struct.Node, %struct.Node* %82, i64 0, i32 1
  %87 = load i8*, i8** %86, align 8
  %88 = call i32 @strcmp(i8* %87, i8* nonnull %3) #3
  %not.30 = icmp eq i32 %88, 0
  %narrow29 = and i1 %narrow27, %not.30
  %...026.peel55 = zext i1 %narrow29 to i8
  %89 = getelementptr inbounds %struct.Node, %struct.Node* %82, i64 0, i32 2
  %90 = load %struct.Node*, %struct.Node** %89, align 8
  %91 = icmp eq %struct.Node* %90, null
  br i1 %91, label %._crit_edge, label %.lr.ph.peel57

.lr.ph.peel57:                                    ; preds = %.lr.ph.peel52
  %92 = getelementptr inbounds %struct.Node, %struct.Node* %90, i64 0, i32 0
  %93 = load i32, i32* %92, align 8
  %not.32 = icmp eq i32 %93, 13
  store i8 110, i8* %3, align 1
  store i8 111, i8* %4, align 1
  store i8 112, i8* %5, align 1
  store i8 113, i8* %6, align 1
  store i8 114, i8* %7, align 1
  store i8 115, i8* %8, align 1
  store i8 116, i8* %9, align 1
  store i8 117, i8* %10, align 1
  store i8 118, i8* %11, align 1
  store i8 119, i8* %12, align 1
  %narrow31 = and i1 %narrow29, %not.32
  %94 = getelementptr inbounds %struct.Node, %struct.Node* %90, i64 0, i32 1
  %95 = load i8*, i8** %94, align 8
  %96 = call i32 @strcmp(i8* %95, i8* nonnull %3) #3
  %not.34 = icmp eq i32 %96, 0
  %narrow33 = and i1 %narrow31, %not.34
  %...026.peel60 = zext i1 %narrow33 to i8
  %97 = getelementptr inbounds %struct.Node, %struct.Node* %90, i64 0, i32 2
  %98 = load %struct.Node*, %struct.Node** %97, align 8
  %99 = icmp eq %struct.Node* %98, null
  br i1 %99, label %._crit_edge, label %.lr.ph.peel62

.lr.ph.peel62:                                    ; preds = %.lr.ph.peel57
  %100 = getelementptr inbounds %struct.Node, %struct.Node* %98, i64 0, i32 0
  %101 = load i32, i32* %100, align 8
  %not.36 = icmp eq i32 %101, 14
  store i8 111, i8* %3, align 1
  store i8 112, i8* %4, align 1
  store i8 113, i8* %5, align 1
  store i8 114, i8* %6, align 1
  store i8 115, i8* %7, align 1
  store i8 116, i8* %8, align 1
  store i8 117, i8* %9, align 1
  store i8 118, i8* %10, align 1
  store i8 119, i8* %11, align 1
  store i8 120, i8* %12, align 1
  %narrow35 = and i1 %narrow33, %not.36
  %102 = getelementptr inbounds %struct.Node, %struct.Node* %98, i64 0, i32 1
  %103 = load i8*, i8** %102, align 8
  %104 = call i32 @strcmp(i8* %103, i8* nonnull %3) #3
  %not.38 = icmp eq i32 %104, 0
  %narrow37 = and i1 %narrow35, %not.38
  %...026.peel65 = zext i1 %narrow37 to i8
  %105 = getelementptr inbounds %struct.Node, %struct.Node* %98, i64 0, i32 2
  %106 = load %struct.Node*, %struct.Node** %105, align 8
  %107 = icmp eq %struct.Node* %106, null
  br i1 %107, label %._crit_edge, label %.lr.ph.peel67

.lr.ph.peel67:                                    ; preds = %.lr.ph.peel62
  %108 = getelementptr inbounds %struct.Node, %struct.Node* %106, i64 0, i32 0
  %109 = load i32, i32* %108, align 8
  %not.40 = icmp eq i32 %109, 15
  store i8 112, i8* %3, align 1
  store i8 113, i8* %4, align 1
  store i8 114, i8* %5, align 1
  store i8 115, i8* %6, align 1
  store i8 116, i8* %7, align 1
  store i8 117, i8* %8, align 1
  store i8 118, i8* %9, align 1
  store i8 119, i8* %10, align 1
  store i8 120, i8* %11, align 1
  store i8 121, i8* %12, align 1
  %narrow39 = and i1 %narrow37, %not.40
  %110 = getelementptr inbounds %struct.Node, %struct.Node* %106, i64 0, i32 1
  %111 = load i8*, i8** %110, align 8
  %112 = call i32 @strcmp(i8* %111, i8* nonnull %3) #3
  %not.42 = icmp eq i32 %112, 0
  %narrow41 = and i1 %narrow39, %not.42
  %...026.peel70 = zext i1 %narrow41 to i8
  %113 = getelementptr inbounds %struct.Node, %struct.Node* %106, i64 0, i32 2
  %114 = load %struct.Node*, %struct.Node** %113, align 8
  %115 = icmp eq %struct.Node* %114, null
  br i1 %115, label %._crit_edge, label %.lr.ph.peel72

.lr.ph.peel72:                                    ; preds = %.lr.ph.peel67
  %116 = getelementptr inbounds %struct.Node, %struct.Node* %114, i64 0, i32 0
  %117 = load i32, i32* %116, align 8
  %not.44 = icmp eq i32 %117, 16
  store i8 113, i8* %3, align 1
  store i8 114, i8* %4, align 1
  store i8 115, i8* %5, align 1
  store i8 116, i8* %6, align 1
  store i8 117, i8* %7, align 1
  store i8 118, i8* %8, align 1
  store i8 119, i8* %9, align 1
  store i8 120, i8* %10, align 1
  store i8 121, i8* %11, align 1
  store i8 122, i8* %12, align 1
  %narrow43 = and i1 %narrow41, %not.44
  %118 = getelementptr inbounds %struct.Node, %struct.Node* %114, i64 0, i32 1
  %119 = load i8*, i8** %118, align 8
  %120 = call i32 @strcmp(i8* %119, i8* nonnull %3) #3
  %not.46 = icmp eq i32 %120, 0
  %narrow45 = and i1 %narrow43, %not.46
  %...026.peel75 = zext i1 %narrow45 to i8
  %121 = getelementptr inbounds %struct.Node, %struct.Node* %114, i64 0, i32 2
  %122 = load %struct.Node*, %struct.Node** %121, align 8
  %123 = icmp eq %struct.Node* %122, null
  br i1 %123, label %._crit_edge, label %.lr.ph.peel77

.lr.ph.peel77:                                    ; preds = %.lr.ph.peel72
  %124 = getelementptr inbounds %struct.Node, %struct.Node* %122, i64 0, i32 0
  %125 = load i32, i32* %124, align 8
  %not.48 = icmp eq i32 %125, 17
  store i8 114, i8* %3, align 1
  store i8 115, i8* %4, align 1
  store i8 116, i8* %5, align 1
  store i8 117, i8* %6, align 1
  store i8 118, i8* %7, align 1
  store i8 119, i8* %8, align 1
  store i8 120, i8* %9, align 1
  store i8 121, i8* %10, align 1
  store i8 122, i8* %11, align 1
  store i8 123, i8* %12, align 1
  %narrow47 = and i1 %narrow45, %not.48
  %126 = getelementptr inbounds %struct.Node, %struct.Node* %122, i64 0, i32 1
  %127 = load i8*, i8** %126, align 8
  %128 = call i32 @strcmp(i8* %127, i8* nonnull %3) #3
  %not.50 = icmp eq i32 %128, 0
  %narrow49 = and i1 %narrow47, %not.50
  %...026.peel80 = zext i1 %narrow49 to i8
  %129 = getelementptr inbounds %struct.Node, %struct.Node* %122, i64 0, i32 2
  %130 = load %struct.Node*, %struct.Node** %129, align 8
  %131 = icmp eq %struct.Node* %130, null
  br i1 %131, label %._crit_edge, label %.lr.ph.peel82

.lr.ph.peel82:                                    ; preds = %.lr.ph.peel77
  %132 = getelementptr inbounds %struct.Node, %struct.Node* %130, i64 0, i32 0
  %133 = load i32, i32* %132, align 8
  %not.52 = icmp eq i32 %133, 18
  store i8 115, i8* %3, align 1
  store i8 116, i8* %4, align 1
  store i8 117, i8* %5, align 1
  store i8 118, i8* %6, align 1
  store i8 119, i8* %7, align 1
  store i8 120, i8* %8, align 1
  store i8 121, i8* %9, align 1
  store i8 122, i8* %10, align 1
  store i8 123, i8* %11, align 1
  store i8 124, i8* %12, align 1
  %narrow51 = and i1 %narrow49, %not.52
  %134 = getelementptr inbounds %struct.Node, %struct.Node* %130, i64 0, i32 1
  %135 = load i8*, i8** %134, align 8
  %136 = call i32 @strcmp(i8* %135, i8* nonnull %3) #3
  %not.54 = icmp eq i32 %136, 0
  %narrow53 = and i1 %narrow51, %not.54
  %...026.peel85 = zext i1 %narrow53 to i8
  %137 = getelementptr inbounds %struct.Node, %struct.Node* %130, i64 0, i32 2
  %138 = load %struct.Node*, %struct.Node** %137, align 8
  %139 = icmp eq %struct.Node* %138, null
  br i1 %139, label %._crit_edge, label %.lr.ph.peel87

.lr.ph.peel87:                                    ; preds = %.lr.ph.peel82
  %140 = getelementptr inbounds %struct.Node, %struct.Node* %138, i64 0, i32 0
  %141 = load i32, i32* %140, align 8
  %not.56 = icmp eq i32 %141, 19
  store i8 116, i8* %3, align 1
  store i8 117, i8* %4, align 1
  store i8 118, i8* %5, align 1
  store i8 119, i8* %6, align 1
  store i8 120, i8* %7, align 1
  store i8 121, i8* %8, align 1
  store i8 122, i8* %9, align 1
  store i8 123, i8* %10, align 1
  store i8 124, i8* %11, align 1
  store i8 125, i8* %12, align 1
  %narrow55 = and i1 %narrow53, %not.56
  %142 = getelementptr inbounds %struct.Node, %struct.Node* %138, i64 0, i32 1
  %143 = load i8*, i8** %142, align 8
  %144 = call i32 @strcmp(i8* %143, i8* nonnull %3) #3
  %not.58 = icmp eq i32 %144, 0
  %narrow57 = and i1 %narrow55, %not.58
  %...026.peel90 = zext i1 %narrow57 to i8
  %145 = getelementptr inbounds %struct.Node, %struct.Node* %138, i64 0, i32 2
  %146 = load %struct.Node*, %struct.Node** %145, align 8
  %147 = icmp eq %struct.Node* %146, null
  br i1 %147, label %._crit_edge, label %.lr.ph.peel92

.lr.ph.peel92:                                    ; preds = %.lr.ph.peel87
  %148 = getelementptr inbounds %struct.Node, %struct.Node* %146, i64 0, i32 0
  %149 = load i32, i32* %148, align 8
  %not.60 = icmp eq i32 %149, 20
  store i8 117, i8* %3, align 1
  store i8 118, i8* %4, align 1
  store i8 119, i8* %5, align 1
  store i8 120, i8* %6, align 1
  store i8 121, i8* %7, align 1
  store i8 122, i8* %8, align 1
  store i8 123, i8* %9, align 1
  store i8 124, i8* %10, align 1
  store i8 125, i8* %11, align 1
  store i8 126, i8* %12, align 1
  %narrow59 = and i1 %narrow57, %not.60
  %150 = getelementptr inbounds %struct.Node, %struct.Node* %146, i64 0, i32 1
  %151 = load i8*, i8** %150, align 8
  %152 = call i32 @strcmp(i8* %151, i8* nonnull %3) #3
  %not.62 = icmp eq i32 %152, 0
  %narrow61 = and i1 %narrow59, %not.62
  %...026.peel95 = zext i1 %narrow61 to i8
  %153 = getelementptr inbounds %struct.Node, %struct.Node* %146, i64 0, i32 2
  %154 = load %struct.Node*, %struct.Node** %153, align 8
  %155 = icmp eq %struct.Node* %154, null
  br i1 %155, label %._crit_edge, label %.lr.ph.preheader103

.lr.ph.preheader103:                              ; preds = %.lr.ph.peel92
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader103, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 21, %.lr.ph.preheader103 ]
  %.026 = phi i8 [ %...026, %.lr.ph ], [ %...026.peel95, %.lr.ph.preheader103 ]
  %.035 = phi %struct.Node* [ %186, %.lr.ph ], [ %154, %.lr.ph.preheader103 ]
  %156 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 0
  %157 = load i32, i32* %156, align 8
  %158 = add nuw nsw i64 %indvars.iv, 97
  %159 = trunc i64 %158 to i8
  store i8 %159, i8* %3, align 1
  %160 = add nsw i64 %indvars.iv, 98
  %161 = trunc i64 %160 to i8
  store i8 %161, i8* %4, align 1
  %162 = add nsw i64 %indvars.iv, 99
  %163 = trunc i64 %162 to i8
  store i8 %163, i8* %5, align 1
  %164 = add nsw i64 %indvars.iv, 100
  %165 = trunc i64 %164 to i8
  store i8 %165, i8* %6, align 1
  %166 = add nsw i64 %indvars.iv, 101
  %167 = trunc i64 %166 to i8
  store i8 %167, i8* %7, align 1
  %168 = add nsw i64 %indvars.iv, 102
  %169 = trunc i64 %168 to i8
  store i8 %169, i8* %8, align 1
  %170 = add nsw i64 %indvars.iv, 103
  %171 = trunc i64 %170 to i8
  store i8 %171, i8* %9, align 1
  %172 = add nsw i64 %indvars.iv, 104
  %173 = trunc i64 %172 to i8
  store i8 %173, i8* %10, align 1
  %174 = add nsw i64 %indvars.iv, 105
  %175 = trunc i64 %174 to i8
  store i8 %175, i8* %11, align 1
  %176 = add nsw i64 %indvars.iv, 106
  %177 = trunc i64 %176 to i8
  store i8 %177, i8* %12, align 1
  %178 = zext i32 %157 to i64
  %179 = icmp ne i64 %178, %indvars.iv
  %180 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 1
  %181 = load i8*, i8** %180, align 8
  %182 = call i32 @strcmp(i8* %181, i8* nonnull %3) #3
  %183 = icmp ne i32 %182, 0
  %184 = or i1 %179, %183
  %...026 = select i1 %184, i8 0, i8 %.026
  %185 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 2
  %186 = load %struct.Node*, %struct.Node** %185, align 8
  %indvars.iv.next = add nuw i64 %indvars.iv, 1
  %187 = icmp eq %struct.Node* %186, null
  br i1 %187, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %.lr.ph.peel92, %.lr.ph.peel87, %.lr.ph.peel82, %.lr.ph.peel77, %.lr.ph.peel72, %.lr.ph.peel67, %.lr.ph.peel62, %.lr.ph.peel57, %.lr.ph.peel52, %.lr.ph.peel47, %.lr.ph.peel42, %.lr.ph.peel37, %.lr.ph.peel32, %.lr.ph.peel27, %.lr.ph.peel22, %.lr.ph.peel17, %.lr.ph.preheader
  %...026.lcssa = phi i8 [ %...026.peel15, %.lr.ph.preheader ], [ %...026.peel20, %.lr.ph.peel17 ], [ %...026.peel25, %.lr.ph.peel22 ], [ %...026.peel30, %.lr.ph.peel27 ], [ %...026.peel35, %.lr.ph.peel32 ], [ %...026.peel40, %.lr.ph.peel37 ], [ %...026.peel45, %.lr.ph.peel42 ], [ %...026.peel50, %.lr.ph.peel47 ], [ %...026.peel55, %.lr.ph.peel52 ], [ %...026.peel60, %.lr.ph.peel57 ], [ %...026.peel65, %.lr.ph.peel62 ], [ %...026.peel70, %.lr.ph.peel67 ], [ %...026.peel75, %.lr.ph.peel72 ], [ %...026.peel80, %.lr.ph.peel77 ], [ %...026.peel85, %.lr.ph.peel82 ], [ %...026.peel90, %.lr.ph.peel87 ], [ %...026.peel95, %.lr.ph.peel92 ], [ %...026, %._crit_edge.loopexit ]
  %188 = icmp eq i8 %...026.lcssa, 0
  br i1 %188, label %191, label %189

; <label>:189:                                    ; preds = %._crit_edge
  %190 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0))
  br label %191

; <label>:191:                                    ; preds = %._crit_edge, %189
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone_clone.37(%struct.Node* nocapture readonly) local_unnamed_addr #0 {
.lr.ph.preheader:
  %1 = alloca [11 x i8], align 1
  %2 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 10
  store i8 0, i8* %2, align 1
  %3 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 0
  %4 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 1
  %5 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 2
  %6 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 3
  %7 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 4
  %8 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 5
  %9 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 6
  %10 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 7
  %11 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 8
  %12 = getelementptr inbounds [11 x i8], [11 x i8]* %1, i64 0, i64 9
  %13 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 2
  %14 = load %struct.Node*, %struct.Node** %13, align 8
  %15 = getelementptr inbounds %struct.Node, %struct.Node* %14, i64 0, i32 2
  %16 = load %struct.Node*, %struct.Node** %15, align 8
  %17 = getelementptr inbounds %struct.Node, %struct.Node* %16, i64 0, i32 2
  %18 = load %struct.Node*, %struct.Node** %17, align 8
  %19 = getelementptr inbounds %struct.Node, %struct.Node* %18, i64 0, i32 2
  %20 = load %struct.Node*, %struct.Node** %19, align 8
  store i8 102, i8* %3, align 1
  store i8 103, i8* %4, align 1
  store i8 104, i8* %5, align 1
  store i8 105, i8* %6, align 1
  store i8 106, i8* %7, align 1
  store i8 107, i8* %8, align 1
  store i8 108, i8* %9, align 1
  store i8 109, i8* %10, align 1
  store i8 110, i8* %11, align 1
  store i8 111, i8* %12, align 1
  %21 = getelementptr inbounds %struct.Node, %struct.Node* %20, i64 0, i32 1
  %22 = load i8*, i8** %21, align 8
  %23 = call i32 @strcmp(i8* %22, i8* nonnull %3) #3
  %not. = icmp eq i32 %23, 0
  %...026.peel20 = zext i1 %not. to i8
  %24 = getelementptr inbounds %struct.Node, %struct.Node* %20, i64 0, i32 2
  %25 = load %struct.Node*, %struct.Node** %24, align 8
  %26 = icmp eq %struct.Node* %25, null
  br i1 %26, label %._crit_edge, label %.lr.ph.peel22

.lr.ph.peel22:                                    ; preds = %.lr.ph.preheader
  %27 = getelementptr inbounds %struct.Node, %struct.Node* %25, i64 0, i32 0
  %28 = load i32, i32* %27, align 8
  store i8 103, i8* %3, align 1
  store i8 104, i8* %4, align 1
  store i8 105, i8* %5, align 1
  store i8 106, i8* %6, align 1
  store i8 107, i8* %7, align 1
  store i8 108, i8* %8, align 1
  store i8 109, i8* %9, align 1
  store i8 110, i8* %10, align 1
  store i8 111, i8* %11, align 1
  store i8 112, i8* %12, align 1
  %not.1 = icmp eq i32 %28, 6
  %29 = getelementptr inbounds %struct.Node, %struct.Node* %25, i64 0, i32 1
  %30 = load i8*, i8** %29, align 8
  %31 = call i32 @strcmp(i8* %30, i8* nonnull %3) #3
  %32 = or i32 %31, %23
  %33 = icmp eq i32 %32, 0
  %34 = and i1 %not.1, %33
  %...026.peel25 = zext i1 %34 to i8
  %35 = getelementptr inbounds %struct.Node, %struct.Node* %25, i64 0, i32 2
  %36 = load %struct.Node*, %struct.Node** %35, align 8
  %37 = icmp eq %struct.Node* %36, null
  br i1 %37, label %._crit_edge, label %.lr.ph.peel27

.lr.ph.peel27:                                    ; preds = %.lr.ph.peel22
  %38 = getelementptr inbounds %struct.Node, %struct.Node* %36, i64 0, i32 0
  %39 = load i32, i32* %38, align 8
  %not.4 = icmp eq i32 %39, 7
  store i8 104, i8* %3, align 1
  store i8 105, i8* %4, align 1
  store i8 106, i8* %5, align 1
  store i8 107, i8* %6, align 1
  store i8 108, i8* %7, align 1
  store i8 109, i8* %8, align 1
  store i8 110, i8* %9, align 1
  store i8 111, i8* %10, align 1
  store i8 112, i8* %11, align 1
  store i8 113, i8* %12, align 1
  %narrow = and i1 %34, %not.4
  %40 = getelementptr inbounds %struct.Node, %struct.Node* %36, i64 0, i32 1
  %41 = load i8*, i8** %40, align 8
  %42 = call i32 @strcmp(i8* %41, i8* nonnull %3) #3
  %not.6 = icmp eq i32 %42, 0
  %narrow5 = and i1 %narrow, %not.6
  %...026.peel30 = zext i1 %narrow5 to i8
  %43 = getelementptr inbounds %struct.Node, %struct.Node* %36, i64 0, i32 2
  %44 = load %struct.Node*, %struct.Node** %43, align 8
  %45 = icmp eq %struct.Node* %44, null
  br i1 %45, label %._crit_edge, label %.lr.ph.peel32

.lr.ph.peel32:                                    ; preds = %.lr.ph.peel27
  %46 = getelementptr inbounds %struct.Node, %struct.Node* %44, i64 0, i32 0
  %47 = load i32, i32* %46, align 8
  %not.8 = icmp eq i32 %47, 8
  store i8 105, i8* %3, align 1
  store i8 106, i8* %4, align 1
  store i8 107, i8* %5, align 1
  store i8 108, i8* %6, align 1
  store i8 109, i8* %7, align 1
  store i8 110, i8* %8, align 1
  store i8 111, i8* %9, align 1
  store i8 112, i8* %10, align 1
  store i8 113, i8* %11, align 1
  store i8 114, i8* %12, align 1
  %narrow7 = and i1 %narrow5, %not.8
  %48 = getelementptr inbounds %struct.Node, %struct.Node* %44, i64 0, i32 1
  %49 = load i8*, i8** %48, align 8
  %50 = call i32 @strcmp(i8* %49, i8* nonnull %3) #3
  %not.10 = icmp eq i32 %50, 0
  %narrow9 = and i1 %narrow7, %not.10
  %...026.peel35 = zext i1 %narrow9 to i8
  %51 = getelementptr inbounds %struct.Node, %struct.Node* %44, i64 0, i32 2
  %52 = load %struct.Node*, %struct.Node** %51, align 8
  %53 = icmp eq %struct.Node* %52, null
  br i1 %53, label %._crit_edge, label %.lr.ph.peel37

.lr.ph.peel37:                                    ; preds = %.lr.ph.peel32
  %54 = getelementptr inbounds %struct.Node, %struct.Node* %52, i64 0, i32 0
  %55 = load i32, i32* %54, align 8
  %not.12 = icmp eq i32 %55, 9
  store i8 106, i8* %3, align 1
  store i8 107, i8* %4, align 1
  store i8 108, i8* %5, align 1
  store i8 109, i8* %6, align 1
  store i8 110, i8* %7, align 1
  store i8 111, i8* %8, align 1
  store i8 112, i8* %9, align 1
  store i8 113, i8* %10, align 1
  store i8 114, i8* %11, align 1
  store i8 115, i8* %12, align 1
  %narrow11 = and i1 %narrow9, %not.12
  %56 = getelementptr inbounds %struct.Node, %struct.Node* %52, i64 0, i32 1
  %57 = load i8*, i8** %56, align 8
  %58 = call i32 @strcmp(i8* %57, i8* nonnull %3) #3
  %not.14 = icmp eq i32 %58, 0
  %narrow13 = and i1 %narrow11, %not.14
  %...026.peel40 = zext i1 %narrow13 to i8
  %59 = getelementptr inbounds %struct.Node, %struct.Node* %52, i64 0, i32 2
  %60 = load %struct.Node*, %struct.Node** %59, align 8
  %61 = icmp eq %struct.Node* %60, null
  br i1 %61, label %._crit_edge, label %.lr.ph.peel42

.lr.ph.peel42:                                    ; preds = %.lr.ph.peel37
  %62 = getelementptr inbounds %struct.Node, %struct.Node* %60, i64 0, i32 0
  %63 = load i32, i32* %62, align 8
  %not.16 = icmp eq i32 %63, 10
  store i8 107, i8* %3, align 1
  store i8 108, i8* %4, align 1
  store i8 109, i8* %5, align 1
  store i8 110, i8* %6, align 1
  store i8 111, i8* %7, align 1
  store i8 112, i8* %8, align 1
  store i8 113, i8* %9, align 1
  store i8 114, i8* %10, align 1
  store i8 115, i8* %11, align 1
  store i8 116, i8* %12, align 1
  %narrow15 = and i1 %narrow13, %not.16
  %64 = getelementptr inbounds %struct.Node, %struct.Node* %60, i64 0, i32 1
  %65 = load i8*, i8** %64, align 8
  %66 = call i32 @strcmp(i8* %65, i8* nonnull %3) #3
  %not.18 = icmp eq i32 %66, 0
  %narrow17 = and i1 %narrow15, %not.18
  %...026.peel45 = zext i1 %narrow17 to i8
  %67 = getelementptr inbounds %struct.Node, %struct.Node* %60, i64 0, i32 2
  %68 = load %struct.Node*, %struct.Node** %67, align 8
  %69 = icmp eq %struct.Node* %68, null
  br i1 %69, label %._crit_edge, label %.lr.ph.peel47

.lr.ph.peel47:                                    ; preds = %.lr.ph.peel42
  %70 = getelementptr inbounds %struct.Node, %struct.Node* %68, i64 0, i32 0
  %71 = load i32, i32* %70, align 8
  %not.20 = icmp eq i32 %71, 11
  store i8 108, i8* %3, align 1
  store i8 109, i8* %4, align 1
  store i8 110, i8* %5, align 1
  store i8 111, i8* %6, align 1
  store i8 112, i8* %7, align 1
  store i8 113, i8* %8, align 1
  store i8 114, i8* %9, align 1
  store i8 115, i8* %10, align 1
  store i8 116, i8* %11, align 1
  store i8 117, i8* %12, align 1
  %narrow19 = and i1 %narrow17, %not.20
  %72 = getelementptr inbounds %struct.Node, %struct.Node* %68, i64 0, i32 1
  %73 = load i8*, i8** %72, align 8
  %74 = call i32 @strcmp(i8* %73, i8* nonnull %3) #3
  %not.22 = icmp eq i32 %74, 0
  %narrow21 = and i1 %narrow19, %not.22
  %...026.peel50 = zext i1 %narrow21 to i8
  %75 = getelementptr inbounds %struct.Node, %struct.Node* %68, i64 0, i32 2
  %76 = load %struct.Node*, %struct.Node** %75, align 8
  %77 = icmp eq %struct.Node* %76, null
  br i1 %77, label %._crit_edge, label %.lr.ph.peel52

.lr.ph.peel52:                                    ; preds = %.lr.ph.peel47
  %78 = getelementptr inbounds %struct.Node, %struct.Node* %76, i64 0, i32 0
  %79 = load i32, i32* %78, align 8
  %not.24 = icmp eq i32 %79, 12
  store i8 109, i8* %3, align 1
  store i8 110, i8* %4, align 1
  store i8 111, i8* %5, align 1
  store i8 112, i8* %6, align 1
  store i8 113, i8* %7, align 1
  store i8 114, i8* %8, align 1
  store i8 115, i8* %9, align 1
  store i8 116, i8* %10, align 1
  store i8 117, i8* %11, align 1
  store i8 118, i8* %12, align 1
  %narrow23 = and i1 %narrow21, %not.24
  %80 = getelementptr inbounds %struct.Node, %struct.Node* %76, i64 0, i32 1
  %81 = load i8*, i8** %80, align 8
  %82 = call i32 @strcmp(i8* %81, i8* nonnull %3) #3
  %not.26 = icmp eq i32 %82, 0
  %narrow25 = and i1 %narrow23, %not.26
  %...026.peel55 = zext i1 %narrow25 to i8
  %83 = getelementptr inbounds %struct.Node, %struct.Node* %76, i64 0, i32 2
  %84 = load %struct.Node*, %struct.Node** %83, align 8
  %85 = icmp eq %struct.Node* %84, null
  br i1 %85, label %._crit_edge, label %.lr.ph.peel57

.lr.ph.peel57:                                    ; preds = %.lr.ph.peel52
  %86 = getelementptr inbounds %struct.Node, %struct.Node* %84, i64 0, i32 0
  %87 = load i32, i32* %86, align 8
  %not.28 = icmp eq i32 %87, 13
  store i8 110, i8* %3, align 1
  store i8 111, i8* %4, align 1
  store i8 112, i8* %5, align 1
  store i8 113, i8* %6, align 1
  store i8 114, i8* %7, align 1
  store i8 115, i8* %8, align 1
  store i8 116, i8* %9, align 1
  store i8 117, i8* %10, align 1
  store i8 118, i8* %11, align 1
  store i8 119, i8* %12, align 1
  %narrow27 = and i1 %narrow25, %not.28
  %88 = getelementptr inbounds %struct.Node, %struct.Node* %84, i64 0, i32 1
  %89 = load i8*, i8** %88, align 8
  %90 = call i32 @strcmp(i8* %89, i8* nonnull %3) #3
  %not.30 = icmp eq i32 %90, 0
  %narrow29 = and i1 %narrow27, %not.30
  %...026.peel60 = zext i1 %narrow29 to i8
  %91 = getelementptr inbounds %struct.Node, %struct.Node* %84, i64 0, i32 2
  %92 = load %struct.Node*, %struct.Node** %91, align 8
  %93 = icmp eq %struct.Node* %92, null
  br i1 %93, label %._crit_edge, label %.lr.ph.peel62

.lr.ph.peel62:                                    ; preds = %.lr.ph.peel57
  %94 = getelementptr inbounds %struct.Node, %struct.Node* %92, i64 0, i32 0
  %95 = load i32, i32* %94, align 8
  %not.32 = icmp eq i32 %95, 14
  store i8 111, i8* %3, align 1
  store i8 112, i8* %4, align 1
  store i8 113, i8* %5, align 1
  store i8 114, i8* %6, align 1
  store i8 115, i8* %7, align 1
  store i8 116, i8* %8, align 1
  store i8 117, i8* %9, align 1
  store i8 118, i8* %10, align 1
  store i8 119, i8* %11, align 1
  store i8 120, i8* %12, align 1
  %narrow31 = and i1 %narrow29, %not.32
  %96 = getelementptr inbounds %struct.Node, %struct.Node* %92, i64 0, i32 1
  %97 = load i8*, i8** %96, align 8
  %98 = call i32 @strcmp(i8* %97, i8* nonnull %3) #3
  %not.34 = icmp eq i32 %98, 0
  %narrow33 = and i1 %narrow31, %not.34
  %...026.peel65 = zext i1 %narrow33 to i8
  %99 = getelementptr inbounds %struct.Node, %struct.Node* %92, i64 0, i32 2
  %100 = load %struct.Node*, %struct.Node** %99, align 8
  %101 = icmp eq %struct.Node* %100, null
  br i1 %101, label %._crit_edge, label %.lr.ph.peel67

.lr.ph.peel67:                                    ; preds = %.lr.ph.peel62
  %102 = getelementptr inbounds %struct.Node, %struct.Node* %100, i64 0, i32 0
  %103 = load i32, i32* %102, align 8
  %not.36 = icmp eq i32 %103, 15
  store i8 112, i8* %3, align 1
  store i8 113, i8* %4, align 1
  store i8 114, i8* %5, align 1
  store i8 115, i8* %6, align 1
  store i8 116, i8* %7, align 1
  store i8 117, i8* %8, align 1
  store i8 118, i8* %9, align 1
  store i8 119, i8* %10, align 1
  store i8 120, i8* %11, align 1
  store i8 121, i8* %12, align 1
  %narrow35 = and i1 %narrow33, %not.36
  %104 = getelementptr inbounds %struct.Node, %struct.Node* %100, i64 0, i32 1
  %105 = load i8*, i8** %104, align 8
  %106 = call i32 @strcmp(i8* %105, i8* nonnull %3) #3
  %not.38 = icmp eq i32 %106, 0
  %narrow37 = and i1 %narrow35, %not.38
  %...026.peel70 = zext i1 %narrow37 to i8
  %107 = getelementptr inbounds %struct.Node, %struct.Node* %100, i64 0, i32 2
  %108 = load %struct.Node*, %struct.Node** %107, align 8
  %109 = icmp eq %struct.Node* %108, null
  br i1 %109, label %._crit_edge, label %.lr.ph.peel72

.lr.ph.peel72:                                    ; preds = %.lr.ph.peel67
  %110 = getelementptr inbounds %struct.Node, %struct.Node* %108, i64 0, i32 0
  %111 = load i32, i32* %110, align 8
  %not.40 = icmp eq i32 %111, 16
  store i8 113, i8* %3, align 1
  store i8 114, i8* %4, align 1
  store i8 115, i8* %5, align 1
  store i8 116, i8* %6, align 1
  store i8 117, i8* %7, align 1
  store i8 118, i8* %8, align 1
  store i8 119, i8* %9, align 1
  store i8 120, i8* %10, align 1
  store i8 121, i8* %11, align 1
  store i8 122, i8* %12, align 1
  %narrow39 = and i1 %narrow37, %not.40
  %112 = getelementptr inbounds %struct.Node, %struct.Node* %108, i64 0, i32 1
  %113 = load i8*, i8** %112, align 8
  %114 = call i32 @strcmp(i8* %113, i8* nonnull %3) #3
  %not.42 = icmp eq i32 %114, 0
  %narrow41 = and i1 %narrow39, %not.42
  %...026.peel75 = zext i1 %narrow41 to i8
  %115 = getelementptr inbounds %struct.Node, %struct.Node* %108, i64 0, i32 2
  %116 = load %struct.Node*, %struct.Node** %115, align 8
  %117 = icmp eq %struct.Node* %116, null
  br i1 %117, label %._crit_edge, label %.lr.ph.peel77

.lr.ph.peel77:                                    ; preds = %.lr.ph.peel72
  %118 = getelementptr inbounds %struct.Node, %struct.Node* %116, i64 0, i32 0
  %119 = load i32, i32* %118, align 8
  %not.44 = icmp eq i32 %119, 17
  store i8 114, i8* %3, align 1
  store i8 115, i8* %4, align 1
  store i8 116, i8* %5, align 1
  store i8 117, i8* %6, align 1
  store i8 118, i8* %7, align 1
  store i8 119, i8* %8, align 1
  store i8 120, i8* %9, align 1
  store i8 121, i8* %10, align 1
  store i8 122, i8* %11, align 1
  store i8 123, i8* %12, align 1
  %narrow43 = and i1 %narrow41, %not.44
  %120 = getelementptr inbounds %struct.Node, %struct.Node* %116, i64 0, i32 1
  %121 = load i8*, i8** %120, align 8
  %122 = call i32 @strcmp(i8* %121, i8* nonnull %3) #3
  %not.46 = icmp eq i32 %122, 0
  %narrow45 = and i1 %narrow43, %not.46
  %...026.peel80 = zext i1 %narrow45 to i8
  %123 = getelementptr inbounds %struct.Node, %struct.Node* %116, i64 0, i32 2
  %124 = load %struct.Node*, %struct.Node** %123, align 8
  %125 = icmp eq %struct.Node* %124, null
  br i1 %125, label %._crit_edge, label %.lr.ph.peel82

.lr.ph.peel82:                                    ; preds = %.lr.ph.peel77
  %126 = getelementptr inbounds %struct.Node, %struct.Node* %124, i64 0, i32 0
  %127 = load i32, i32* %126, align 8
  %not.48 = icmp eq i32 %127, 18
  store i8 115, i8* %3, align 1
  store i8 116, i8* %4, align 1
  store i8 117, i8* %5, align 1
  store i8 118, i8* %6, align 1
  store i8 119, i8* %7, align 1
  store i8 120, i8* %8, align 1
  store i8 121, i8* %9, align 1
  store i8 122, i8* %10, align 1
  store i8 123, i8* %11, align 1
  store i8 124, i8* %12, align 1
  %narrow47 = and i1 %narrow45, %not.48
  %128 = getelementptr inbounds %struct.Node, %struct.Node* %124, i64 0, i32 1
  %129 = load i8*, i8** %128, align 8
  %130 = call i32 @strcmp(i8* %129, i8* nonnull %3) #3
  %not.50 = icmp eq i32 %130, 0
  %narrow49 = and i1 %narrow47, %not.50
  %...026.peel85 = zext i1 %narrow49 to i8
  %131 = getelementptr inbounds %struct.Node, %struct.Node* %124, i64 0, i32 2
  %132 = load %struct.Node*, %struct.Node** %131, align 8
  %133 = icmp eq %struct.Node* %132, null
  br i1 %133, label %._crit_edge, label %.lr.ph.peel87

.lr.ph.peel87:                                    ; preds = %.lr.ph.peel82
  %134 = getelementptr inbounds %struct.Node, %struct.Node* %132, i64 0, i32 0
  %135 = load i32, i32* %134, align 8
  %not.52 = icmp eq i32 %135, 19
  store i8 116, i8* %3, align 1
  store i8 117, i8* %4, align 1
  store i8 118, i8* %5, align 1
  store i8 119, i8* %6, align 1
  store i8 120, i8* %7, align 1
  store i8 121, i8* %8, align 1
  store i8 122, i8* %9, align 1
  store i8 123, i8* %10, align 1
  store i8 124, i8* %11, align 1
  store i8 125, i8* %12, align 1
  %narrow51 = and i1 %narrow49, %not.52
  %136 = getelementptr inbounds %struct.Node, %struct.Node* %132, i64 0, i32 1
  %137 = load i8*, i8** %136, align 8
  %138 = call i32 @strcmp(i8* %137, i8* nonnull %3) #3
  %not.54 = icmp eq i32 %138, 0
  %narrow53 = and i1 %narrow51, %not.54
  %...026.peel90 = zext i1 %narrow53 to i8
  %139 = getelementptr inbounds %struct.Node, %struct.Node* %132, i64 0, i32 2
  %140 = load %struct.Node*, %struct.Node** %139, align 8
  %141 = icmp eq %struct.Node* %140, null
  br i1 %141, label %._crit_edge, label %.lr.ph.peel92

.lr.ph.peel92:                                    ; preds = %.lr.ph.peel87
  %142 = getelementptr inbounds %struct.Node, %struct.Node* %140, i64 0, i32 0
  %143 = load i32, i32* %142, align 8
  %not.56 = icmp eq i32 %143, 20
  store i8 117, i8* %3, align 1
  store i8 118, i8* %4, align 1
  store i8 119, i8* %5, align 1
  store i8 120, i8* %6, align 1
  store i8 121, i8* %7, align 1
  store i8 122, i8* %8, align 1
  store i8 123, i8* %9, align 1
  store i8 124, i8* %10, align 1
  store i8 125, i8* %11, align 1
  store i8 126, i8* %12, align 1
  %narrow55 = and i1 %narrow53, %not.56
  %144 = getelementptr inbounds %struct.Node, %struct.Node* %140, i64 0, i32 1
  %145 = load i8*, i8** %144, align 8
  %146 = call i32 @strcmp(i8* %145, i8* nonnull %3) #3
  %not.58 = icmp eq i32 %146, 0
  %narrow57 = and i1 %narrow55, %not.58
  %...026.peel95 = zext i1 %narrow57 to i8
  %147 = getelementptr inbounds %struct.Node, %struct.Node* %140, i64 0, i32 2
  %148 = load %struct.Node*, %struct.Node** %147, align 8
  %149 = icmp eq %struct.Node* %148, null
  br i1 %149, label %._crit_edge, label %.lr.ph.preheader97

.lr.ph.preheader97:                               ; preds = %.lr.ph.peel92
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader97, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 21, %.lr.ph.preheader97 ]
  %.026 = phi i8 [ %...026, %.lr.ph ], [ %...026.peel95, %.lr.ph.preheader97 ]
  %.035 = phi %struct.Node* [ %180, %.lr.ph ], [ %148, %.lr.ph.preheader97 ]
  %150 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 0
  %151 = load i32, i32* %150, align 8
  %152 = add nuw nsw i64 %indvars.iv, 97
  %153 = trunc i64 %152 to i8
  store i8 %153, i8* %3, align 1
  %154 = add nsw i64 %indvars.iv, 98
  %155 = trunc i64 %154 to i8
  store i8 %155, i8* %4, align 1
  %156 = add nsw i64 %indvars.iv, 99
  %157 = trunc i64 %156 to i8
  store i8 %157, i8* %5, align 1
  %158 = add nsw i64 %indvars.iv, 100
  %159 = trunc i64 %158 to i8
  store i8 %159, i8* %6, align 1
  %160 = add nsw i64 %indvars.iv, 101
  %161 = trunc i64 %160 to i8
  store i8 %161, i8* %7, align 1
  %162 = add nsw i64 %indvars.iv, 102
  %163 = trunc i64 %162 to i8
  store i8 %163, i8* %8, align 1
  %164 = add nsw i64 %indvars.iv, 103
  %165 = trunc i64 %164 to i8
  store i8 %165, i8* %9, align 1
  %166 = add nsw i64 %indvars.iv, 104
  %167 = trunc i64 %166 to i8
  store i8 %167, i8* %10, align 1
  %168 = add nsw i64 %indvars.iv, 105
  %169 = trunc i64 %168 to i8
  store i8 %169, i8* %11, align 1
  %170 = add nsw i64 %indvars.iv, 106
  %171 = trunc i64 %170 to i8
  store i8 %171, i8* %12, align 1
  %172 = zext i32 %151 to i64
  %173 = icmp ne i64 %172, %indvars.iv
  %174 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 1
  %175 = load i8*, i8** %174, align 8
  %176 = call i32 @strcmp(i8* %175, i8* nonnull %3) #3
  %177 = icmp ne i32 %176, 0
  %178 = or i1 %173, %177
  %...026 = select i1 %178, i8 0, i8 %.026
  %179 = getelementptr inbounds %struct.Node, %struct.Node* %.035, i64 0, i32 2
  %180 = load %struct.Node*, %struct.Node** %179, align 8
  %indvars.iv.next = add nuw i64 %indvars.iv, 1
  %181 = icmp eq %struct.Node* %180, null
  br i1 %181, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %.lr.ph.peel92, %.lr.ph.peel87, %.lr.ph.peel82, %.lr.ph.peel77, %.lr.ph.peel72, %.lr.ph.peel67, %.lr.ph.peel62, %.lr.ph.peel57, %.lr.ph.peel52, %.lr.ph.peel47, %.lr.ph.peel42, %.lr.ph.peel37, %.lr.ph.peel32, %.lr.ph.peel27, %.lr.ph.peel22, %.lr.ph.preheader
  %...026.lcssa = phi i8 [ %...026.peel20, %.lr.ph.preheader ], [ %...026.peel25, %.lr.ph.peel22 ], [ %...026.peel30, %.lr.ph.peel27 ], [ %...026.peel35, %.lr.ph.peel32 ], [ %...026.peel40, %.lr.ph.peel37 ], [ %...026.peel45, %.lr.ph.peel42 ], [ %...026.peel50, %.lr.ph.peel47 ], [ %...026.peel55, %.lr.ph.peel52 ], [ %...026.peel60, %.lr.ph.peel57 ], [ %...026.peel65, %.lr.ph.peel62 ], [ %...026.peel70, %.lr.ph.peel67 ], [ %...026.peel75, %.lr.ph.peel72 ], [ %...026.peel80, %.lr.ph.peel77 ], [ %...026.peel85, %.lr.ph.peel82 ], [ %...026.peel90, %.lr.ph.peel87 ], [ %...026.peel95, %.lr.ph.peel92 ], [ %...026, %._crit_edge.loopexit ]
  %182 = icmp eq i8 %...026.lcssa, 0
  br i1 %182, label %185, label %183

; <label>:183:                                    ; preds = %._crit_edge
  %184 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0))
  br label %185

; <label>:185:                                    ; preds = %._crit_edge, %183
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
