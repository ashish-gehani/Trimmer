; ModuleID = 'workdir/inter25t3.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Node = type { i32, %struct.Node* }

@.str = private unnamed_addr constant [15 x i8] c"condition true\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.Node*) #0 {
  %2 = icmp ne %struct.Node* %0, null
  br i1 %2, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %1, %.lr.ph
  %.05 = phi %struct.Node* [ %7, %.lr.ph ], [ %0, %1 ]
  %.014 = phi i32 [ %8, %.lr.ph ], [ 1, %1 ]
  %.023 = phi i8 [ %..023, %.lr.ph ], [ 1, %1 ]
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %.05, i32 0, i32 0
  %4 = load i32, i32* %3, align 8
  %5 = icmp ne i32 %4, %.014
  %..023 = select i1 %5, i8 0, i8 %.023
  %6 = getelementptr inbounds %struct.Node, %struct.Node* %.05, i32 0, i32 1
  %7 = load %struct.Node*, %struct.Node** %6, align 8
  %8 = add nsw i32 %.014, 1
  %9 = icmp ne %struct.Node* %7, null
  br i1 %9, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %1
  %.02.lcssa = phi i8 [ 1, %1 ], [ %..023, %.lr.ph ]
  %10 = icmp ne i8 %.02.lcssa, 0
  br i1 %10, label %11, label %13

; <label>:11:                                     ; preds = %._crit_edge
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i32 0, i32 0))
  br label %13

; <label>:13:                                     ; preds = %11, %._crit_edge
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind uwtable
define void @initialize(%struct.Node*, i32) #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  store i32 %1, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = call noalias i8* @malloc(i64 16) #3
  %2 = bitcast i8* %1 to %struct.Node*
  %3 = call noalias i8* @malloc(i64 16) #3
  %4 = bitcast i8* %3 to %struct.Node*
  %5 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 1
  store %struct.Node* %4, %struct.Node** %5, align 8
  %6 = call noalias i8* @malloc(i64 16) #3
  %7 = bitcast i8* %6 to %struct.Node*
  %8 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 1
  %9 = load %struct.Node*, %struct.Node** %8, align 8
  %10 = getelementptr inbounds %struct.Node, %struct.Node* %9, i32 0, i32 1
  store %struct.Node* %7, %struct.Node** %10, align 8
  %11 = call noalias i8* @malloc(i64 16) #3
  %12 = bitcast i8* %11 to %struct.Node*
  %13 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 1
  %14 = load %struct.Node*, %struct.Node** %13, align 8
  %15 = getelementptr inbounds %struct.Node, %struct.Node* %14, i32 0, i32 1
  %16 = load %struct.Node*, %struct.Node** %15, align 8
  %17 = getelementptr inbounds %struct.Node, %struct.Node* %16, i32 0, i32 1
  store %struct.Node* %12, %struct.Node** %17, align 8
  %18 = call noalias i8* @malloc(i64 16) #3
  %19 = bitcast i8* %18 to %struct.Node*
  %20 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 1
  %21 = load %struct.Node*, %struct.Node** %20, align 8
  %22 = getelementptr inbounds %struct.Node, %struct.Node* %21, i32 0, i32 1
  %23 = load %struct.Node*, %struct.Node** %22, align 8
  %24 = getelementptr inbounds %struct.Node, %struct.Node* %23, i32 0, i32 1
  %25 = load %struct.Node*, %struct.Node** %24, align 8
  %26 = getelementptr inbounds %struct.Node, %struct.Node* %25, i32 0, i32 1
  store %struct.Node* %19, %struct.Node** %26, align 8
  %27 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 1
  %28 = load %struct.Node*, %struct.Node** %27, align 8
  %29 = getelementptr inbounds %struct.Node, %struct.Node* %28, i32 0, i32 1
  %30 = load %struct.Node*, %struct.Node** %29, align 8
  %31 = getelementptr inbounds %struct.Node, %struct.Node* %30, i32 0, i32 1
  %32 = load %struct.Node*, %struct.Node** %31, align 8
  %33 = getelementptr inbounds %struct.Node, %struct.Node* %32, i32 0, i32 1
  %34 = load %struct.Node*, %struct.Node** %33, align 8
  %35 = getelementptr inbounds %struct.Node, %struct.Node* %34, i32 0, i32 1
  store %struct.Node* null, %struct.Node** %35, align 8
  %36 = icmp ne i1 true, false
  %37 = icmp ne %struct.Node* %2, null
  br i1 true, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph.peel.begin

.lr.ph.peel.begin:                                ; preds = %.lr.ph.preheader
  br label %.lr.ph.peel

.lr.ph.peel:                                      ; preds = %.lr.ph.peel.begin
  call void @initialize_clone.12(%struct.Node* %2, i32 1)
  %38 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 1
  %39 = load %struct.Node*, %struct.Node** %38, align 8
  %40 = add nsw i32 1, 1
  %41 = icmp ne i1 true, false
  %42 = icmp ne %struct.Node* %39, null
  br i1 true, label %.lr.ph.peel.next, label %._crit_edge.loopexit

.lr.ph.peel.next:                                 ; preds = %.lr.ph.peel
  br label %.lr.ph.peel2

.lr.ph.peel2:                                     ; preds = %.lr.ph.peel.next
  call void @initialize_clone.14(%struct.Node* %39, i32 2)
  %43 = getelementptr inbounds %struct.Node, %struct.Node* %39, i32 0, i32 1
  %44 = load %struct.Node*, %struct.Node** %43, align 8
  %45 = add nsw i32 2, 1
  %46 = icmp ne i1 true, false
  %47 = icmp ne %struct.Node* %44, null
  br i1 true, label %.lr.ph.peel.next1, label %._crit_edge.loopexit

.lr.ph.peel.next1:                                ; preds = %.lr.ph.peel2
  br label %.lr.ph.peel4

.lr.ph.peel4:                                     ; preds = %.lr.ph.peel.next1
  call void @initialize_clone.16(%struct.Node* %44, i32 3)
  %48 = getelementptr inbounds %struct.Node, %struct.Node* %44, i32 0, i32 1
  %49 = load %struct.Node*, %struct.Node** %48, align 8
  %50 = add nsw i32 3, 1
  %51 = icmp ne i1 true, false
  %52 = icmp ne %struct.Node* %49, null
  br i1 true, label %.lr.ph.peel.next3, label %._crit_edge.loopexit

.lr.ph.peel.next3:                                ; preds = %.lr.ph.peel4
  br label %.lr.ph.peel6

.lr.ph.peel6:                                     ; preds = %.lr.ph.peel.next3
  call void @initialize_clone.18(%struct.Node* %49, i32 4)
  %53 = getelementptr inbounds %struct.Node, %struct.Node* %49, i32 0, i32 1
  %54 = load %struct.Node*, %struct.Node** %53, align 8
  %55 = add nsw i32 4, 1
  %56 = icmp ne i1 true, false
  %57 = icmp ne %struct.Node* %54, null
  br i1 true, label %.lr.ph.peel.next5, label %._crit_edge.loopexit

.lr.ph.peel.next5:                                ; preds = %.lr.ph.peel6
  br label %.lr.ph.peel8

.lr.ph.peel8:                                     ; preds = %.lr.ph.peel.next5
  call void @initialize_clone.20(%struct.Node* %54, i32 5)
  %58 = getelementptr inbounds %struct.Node, %struct.Node* %54, i32 0, i32 1
  %59 = load %struct.Node*, %struct.Node** %58, align 8
  %60 = add nsw i32 5, 1
  %61 = icmp ne i1 false, false
  %62 = icmp ne %struct.Node* null, null
  br i1 false, label %.lr.ph.peel.next7, label %._crit_edge.loopexit

.lr.ph.peel.next7:                                ; preds = %.lr.ph.peel8
  br label %.lr.ph.peel10

.lr.ph.peel10:                                    ; preds = %.lr.ph.peel.next7
  call void @initialize(%struct.Node* null, i32 6)
  %63 = getelementptr inbounds %struct.Node, %struct.Node* null, i32 0, i32 1
  %64 = load %struct.Node*, %struct.Node** %63, align 8
  %65 = add nsw i32 6, 1
  %66 = icmp ne %struct.Node* %64, null
  br i1 %66, label %.lr.ph.peel.next9, label %._crit_edge.loopexit

.lr.ph.peel.next9:                                ; preds = %.lr.ph.peel10
  br label %.lr.ph.peel12

.lr.ph.peel12:                                    ; preds = %.lr.ph.peel.next9
  call void @initialize(%struct.Node* %64, i32 %65)
  %67 = getelementptr inbounds %struct.Node, %struct.Node* %64, i32 0, i32 1
  %68 = load %struct.Node*, %struct.Node** %67, align 8
  %69 = add nsw i32 %65, 1
  %70 = icmp ne %struct.Node* %68, null
  br i1 %70, label %.lr.ph.peel.next11, label %._crit_edge.loopexit

.lr.ph.peel.next11:                               ; preds = %.lr.ph.peel12
  br label %.lr.ph.peel14

.lr.ph.peel14:                                    ; preds = %.lr.ph.peel.next11
  call void @initialize(%struct.Node* %68, i32 %69)
  %71 = getelementptr inbounds %struct.Node, %struct.Node* %68, i32 0, i32 1
  %72 = load %struct.Node*, %struct.Node** %71, align 8
  %73 = add nsw i32 %69, 1
  %74 = icmp ne %struct.Node* %72, null
  br i1 %74, label %.lr.ph.peel.next13, label %._crit_edge.loopexit

.lr.ph.peel.next13:                               ; preds = %.lr.ph.peel14
  br label %.lr.ph.peel16

.lr.ph.peel16:                                    ; preds = %.lr.ph.peel.next13
  call void @initialize(%struct.Node* %72, i32 %73)
  %75 = getelementptr inbounds %struct.Node, %struct.Node* %72, i32 0, i32 1
  %76 = load %struct.Node*, %struct.Node** %75, align 8
  %77 = add nsw i32 %73, 1
  %78 = icmp ne %struct.Node* %76, null
  br i1 %78, label %.lr.ph.peel.next15, label %._crit_edge.loopexit

.lr.ph.peel.next15:                               ; preds = %.lr.ph.peel16
  br label %.lr.ph.peel18

.lr.ph.peel18:                                    ; preds = %.lr.ph.peel.next15
  call void @initialize(%struct.Node* %76, i32 %77)
  %79 = getelementptr inbounds %struct.Node, %struct.Node* %76, i32 0, i32 1
  %80 = load %struct.Node*, %struct.Node** %79, align 8
  %81 = add nsw i32 %77, 1
  %82 = icmp ne %struct.Node* %80, null
  br i1 %82, label %.lr.ph.peel.next17, label %._crit_edge.loopexit

.lr.ph.peel.next17:                               ; preds = %.lr.ph.peel18
  br label %.lr.ph.peel20

.lr.ph.peel20:                                    ; preds = %.lr.ph.peel.next17
  call void @initialize(%struct.Node* %80, i32 %81)
  %83 = getelementptr inbounds %struct.Node, %struct.Node* %80, i32 0, i32 1
  %84 = load %struct.Node*, %struct.Node** %83, align 8
  %85 = add nsw i32 %81, 1
  %86 = icmp ne %struct.Node* %84, null
  br i1 %86, label %.lr.ph.peel.next19, label %._crit_edge.loopexit

.lr.ph.peel.next19:                               ; preds = %.lr.ph.peel20
  br label %.lr.ph.peel22

.lr.ph.peel22:                                    ; preds = %.lr.ph.peel.next19
  call void @initialize(%struct.Node* %84, i32 %85)
  %87 = getelementptr inbounds %struct.Node, %struct.Node* %84, i32 0, i32 1
  %88 = load %struct.Node*, %struct.Node** %87, align 8
  %89 = add nsw i32 %85, 1
  %90 = icmp ne %struct.Node* %88, null
  br i1 %90, label %.lr.ph.peel.next21, label %._crit_edge.loopexit

.lr.ph.peel.next21:                               ; preds = %.lr.ph.peel22
  br label %.lr.ph.peel24

.lr.ph.peel24:                                    ; preds = %.lr.ph.peel.next21
  call void @initialize(%struct.Node* %88, i32 %89)
  %91 = getelementptr inbounds %struct.Node, %struct.Node* %88, i32 0, i32 1
  %92 = load %struct.Node*, %struct.Node** %91, align 8
  %93 = add nsw i32 %89, 1
  %94 = icmp ne %struct.Node* %92, null
  br i1 %94, label %.lr.ph.peel.next23, label %._crit_edge.loopexit

.lr.ph.peel.next23:                               ; preds = %.lr.ph.peel24
  br label %.lr.ph.peel26

.lr.ph.peel26:                                    ; preds = %.lr.ph.peel.next23
  call void @initialize(%struct.Node* %92, i32 %93)
  %95 = getelementptr inbounds %struct.Node, %struct.Node* %92, i32 0, i32 1
  %96 = load %struct.Node*, %struct.Node** %95, align 8
  %97 = add nsw i32 %93, 1
  %98 = icmp ne %struct.Node* %96, null
  br i1 %98, label %.lr.ph.peel.next25, label %._crit_edge.loopexit

.lr.ph.peel.next25:                               ; preds = %.lr.ph.peel26
  br label %.lr.ph.peel28

.lr.ph.peel28:                                    ; preds = %.lr.ph.peel.next25
  call void @initialize(%struct.Node* %96, i32 %97)
  %99 = getelementptr inbounds %struct.Node, %struct.Node* %96, i32 0, i32 1
  %100 = load %struct.Node*, %struct.Node** %99, align 8
  %101 = add nsw i32 %97, 1
  %102 = icmp ne %struct.Node* %100, null
  br i1 %102, label %.lr.ph.peel.next27, label %._crit_edge.loopexit

.lr.ph.peel.next27:                               ; preds = %.lr.ph.peel28
  br label %.lr.ph.peel30

.lr.ph.peel30:                                    ; preds = %.lr.ph.peel.next27
  call void @initialize(%struct.Node* %100, i32 %101)
  %103 = getelementptr inbounds %struct.Node, %struct.Node* %100, i32 0, i32 1
  %104 = load %struct.Node*, %struct.Node** %103, align 8
  %105 = add nsw i32 %101, 1
  %106 = icmp ne %struct.Node* %104, null
  br i1 %106, label %.lr.ph.peel.next29, label %._crit_edge.loopexit

.lr.ph.peel.next29:                               ; preds = %.lr.ph.peel30
  br label %.lr.ph.peel32

.lr.ph.peel32:                                    ; preds = %.lr.ph.peel.next29
  call void @initialize(%struct.Node* %104, i32 %105)
  %107 = getelementptr inbounds %struct.Node, %struct.Node* %104, i32 0, i32 1
  %108 = load %struct.Node*, %struct.Node** %107, align 8
  %109 = add nsw i32 %105, 1
  %110 = icmp ne %struct.Node* %108, null
  br i1 %110, label %.lr.ph.peel.next31, label %._crit_edge.loopexit

.lr.ph.peel.next31:                               ; preds = %.lr.ph.peel32
  br label %.lr.ph.peel34

.lr.ph.peel34:                                    ; preds = %.lr.ph.peel.next31
  call void @initialize(%struct.Node* %108, i32 %109)
  %111 = getelementptr inbounds %struct.Node, %struct.Node* %108, i32 0, i32 1
  %112 = load %struct.Node*, %struct.Node** %111, align 8
  %113 = add nsw i32 %109, 1
  %114 = icmp ne %struct.Node* %112, null
  br i1 %114, label %.lr.ph.peel.next33, label %._crit_edge.loopexit

.lr.ph.peel.next33:                               ; preds = %.lr.ph.peel34
  br label %.lr.ph.peel36

.lr.ph.peel36:                                    ; preds = %.lr.ph.peel.next33
  call void @initialize(%struct.Node* %112, i32 %113)
  %115 = getelementptr inbounds %struct.Node, %struct.Node* %112, i32 0, i32 1
  %116 = load %struct.Node*, %struct.Node** %115, align 8
  %117 = add nsw i32 %113, 1
  %118 = icmp ne %struct.Node* %116, null
  br i1 %118, label %.lr.ph.peel.next35, label %._crit_edge.loopexit

.lr.ph.peel.next35:                               ; preds = %.lr.ph.peel36
  br label %.lr.ph.peel38

.lr.ph.peel38:                                    ; preds = %.lr.ph.peel.next35
  call void @initialize(%struct.Node* %116, i32 %117)
  %119 = getelementptr inbounds %struct.Node, %struct.Node* %116, i32 0, i32 1
  %120 = load %struct.Node*, %struct.Node** %119, align 8
  %121 = add nsw i32 %117, 1
  %122 = icmp ne %struct.Node* %120, null
  br i1 %122, label %.lr.ph.peel.next37, label %._crit_edge.loopexit

.lr.ph.peel.next37:                               ; preds = %.lr.ph.peel38
  br label %.lr.ph.peel.next39

.lr.ph.peel.next39:                               ; preds = %.lr.ph.peel.next37
  br label %.lr.ph.preheader.peel.newph

.lr.ph.preheader.peel.newph:                      ; preds = %.lr.ph.peel.next39
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader.peel.newph, %.lr.ph
  %.03 = phi %struct.Node* [ %124, %.lr.ph ], [ %120, %.lr.ph.preheader.peel.newph ]
  %.012 = phi i32 [ %125, %.lr.ph ], [ %121, %.lr.ph.preheader.peel.newph ]
  call void @initialize(%struct.Node* %.03, i32 %.012)
  %123 = getelementptr inbounds %struct.Node, %struct.Node* %.03, i32 0, i32 1
  %124 = load %struct.Node*, %struct.Node** %123, align 8
  %125 = add nsw i32 %.012, 1
  %126 = icmp ne %struct.Node* %124, null
  br i1 %126, label %.lr.ph, label %._crit_edge.loopexit.loopexit

._crit_edge.loopexit.loopexit:                    ; preds = %.lr.ph
  br label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %._crit_edge.loopexit.loopexit, %.lr.ph.peel38, %.lr.ph.peel36, %.lr.ph.peel34, %.lr.ph.peel32, %.lr.ph.peel30, %.lr.ph.peel28, %.lr.ph.peel26, %.lr.ph.peel24, %.lr.ph.peel22, %.lr.ph.peel20, %.lr.ph.peel18, %.lr.ph.peel16, %.lr.ph.peel14, %.lr.ph.peel12, %.lr.ph.peel10, %.lr.ph.peel8, %.lr.ph.peel6, %.lr.ph.peel4, %.lr.ph.peel2, %.lr.ph.peel
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  call void @branchPruned_clone(%struct.Node* %2)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define i32 @main_clone() #0 {
  %1 = call noalias i8* @malloc(i64 16) #3
  %2 = bitcast i8* %1 to %struct.Node*
  %3 = call noalias i8* @malloc(i64 16) #3
  %4 = bitcast i8* %3 to %struct.Node*
  %5 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 1
  store %struct.Node* %4, %struct.Node** %5, align 8
  %6 = call noalias i8* @malloc(i64 16) #3
  %7 = bitcast i8* %6 to %struct.Node*
  %8 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 1
  %9 = load %struct.Node*, %struct.Node** %8, align 8
  %10 = getelementptr inbounds %struct.Node, %struct.Node* %9, i32 0, i32 1
  store %struct.Node* %7, %struct.Node** %10, align 8
  %11 = call noalias i8* @malloc(i64 16) #3
  %12 = bitcast i8* %11 to %struct.Node*
  %13 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 1
  %14 = load %struct.Node*, %struct.Node** %13, align 8
  %15 = getelementptr inbounds %struct.Node, %struct.Node* %14, i32 0, i32 1
  %16 = load %struct.Node*, %struct.Node** %15, align 8
  %17 = getelementptr inbounds %struct.Node, %struct.Node* %16, i32 0, i32 1
  store %struct.Node* %12, %struct.Node** %17, align 8
  %18 = call noalias i8* @malloc(i64 16) #3
  %19 = bitcast i8* %18 to %struct.Node*
  %20 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 1
  %21 = load %struct.Node*, %struct.Node** %20, align 8
  %22 = getelementptr inbounds %struct.Node, %struct.Node* %21, i32 0, i32 1
  %23 = load %struct.Node*, %struct.Node** %22, align 8
  %24 = getelementptr inbounds %struct.Node, %struct.Node* %23, i32 0, i32 1
  %25 = load %struct.Node*, %struct.Node** %24, align 8
  %26 = getelementptr inbounds %struct.Node, %struct.Node* %25, i32 0, i32 1
  store %struct.Node* %19, %struct.Node** %26, align 8
  %27 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 1
  %28 = load %struct.Node*, %struct.Node** %27, align 8
  %29 = getelementptr inbounds %struct.Node, %struct.Node* %28, i32 0, i32 1
  %30 = load %struct.Node*, %struct.Node** %29, align 8
  %31 = getelementptr inbounds %struct.Node, %struct.Node* %30, i32 0, i32 1
  %32 = load %struct.Node*, %struct.Node** %31, align 8
  %33 = getelementptr inbounds %struct.Node, %struct.Node* %32, i32 0, i32 1
  %34 = load %struct.Node*, %struct.Node** %33, align 8
  %35 = getelementptr inbounds %struct.Node, %struct.Node* %34, i32 0, i32 1
  store %struct.Node* null, %struct.Node** %35, align 8
  %36 = icmp ne i1 true, false
  %37 = icmp ne %struct.Node* %2, null
  br i1 true, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph.peel.begin

.lr.ph.peel.begin:                                ; preds = %.lr.ph.preheader
  br label %.lr.ph.peel

.lr.ph.peel:                                      ; preds = %.lr.ph.peel.begin
  call void @initialize_clone(%struct.Node* %2, i32 1)
  %38 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 1
  %39 = load %struct.Node*, %struct.Node** %38, align 8
  %40 = add nsw i32 1, 1
  %41 = icmp ne i1 true, false
  %42 = icmp ne %struct.Node* %39, null
  br i1 true, label %.lr.ph.peel.next, label %._crit_edge.loopexit

.lr.ph.peel.next:                                 ; preds = %.lr.ph.peel
  br label %.lr.ph.peel2

.lr.ph.peel2:                                     ; preds = %.lr.ph.peel.next
  call void @initialize_clone.4(%struct.Node* %39, i32 2)
  %43 = getelementptr inbounds %struct.Node, %struct.Node* %39, i32 0, i32 1
  %44 = load %struct.Node*, %struct.Node** %43, align 8
  %45 = add nsw i32 2, 1
  %46 = icmp ne i1 true, false
  %47 = icmp ne %struct.Node* %44, null
  br i1 true, label %.lr.ph.peel.next1, label %._crit_edge.loopexit

.lr.ph.peel.next1:                                ; preds = %.lr.ph.peel2
  br label %.lr.ph.peel4

.lr.ph.peel4:                                     ; preds = %.lr.ph.peel.next1
  call void @initialize_clone.6(%struct.Node* %44, i32 3)
  %48 = getelementptr inbounds %struct.Node, %struct.Node* %44, i32 0, i32 1
  %49 = load %struct.Node*, %struct.Node** %48, align 8
  %50 = add nsw i32 3, 1
  %51 = icmp ne i1 true, false
  %52 = icmp ne %struct.Node* %49, null
  br i1 true, label %.lr.ph.peel.next3, label %._crit_edge.loopexit

.lr.ph.peel.next3:                                ; preds = %.lr.ph.peel4
  br label %.lr.ph.peel6

.lr.ph.peel6:                                     ; preds = %.lr.ph.peel.next3
  call void @initialize_clone.8(%struct.Node* %49, i32 4)
  %53 = getelementptr inbounds %struct.Node, %struct.Node* %49, i32 0, i32 1
  %54 = load %struct.Node*, %struct.Node** %53, align 8
  %55 = add nsw i32 4, 1
  %56 = icmp ne i1 true, false
  %57 = icmp ne %struct.Node* %54, null
  br i1 true, label %.lr.ph.peel.next5, label %._crit_edge.loopexit

.lr.ph.peel.next5:                                ; preds = %.lr.ph.peel6
  br label %.lr.ph.peel8

.lr.ph.peel8:                                     ; preds = %.lr.ph.peel.next5
  call void @initialize_clone.10(%struct.Node* %54, i32 5)
  %58 = getelementptr inbounds %struct.Node, %struct.Node* %54, i32 0, i32 1
  %59 = load %struct.Node*, %struct.Node** %58, align 8
  %60 = add nsw i32 5, 1
  %61 = icmp ne i1 false, false
  %62 = icmp ne %struct.Node* null, null
  br i1 false, label %.lr.ph.peel.next7, label %._crit_edge.loopexit

.lr.ph.peel.next7:                                ; preds = %.lr.ph.peel8
  br label %.lr.ph.peel10

.lr.ph.peel10:                                    ; preds = %.lr.ph.peel.next7
  call void @initialize(%struct.Node* null, i32 6)
  %63 = getelementptr inbounds %struct.Node, %struct.Node* null, i32 0, i32 1
  %64 = load %struct.Node*, %struct.Node** %63, align 8
  %65 = add nsw i32 6, 1
  %66 = icmp ne %struct.Node* %64, null
  br i1 %66, label %.lr.ph.peel.next9, label %._crit_edge.loopexit

.lr.ph.peel.next9:                                ; preds = %.lr.ph.peel10
  br label %.lr.ph.peel12

.lr.ph.peel12:                                    ; preds = %.lr.ph.peel.next9
  call void @initialize(%struct.Node* %64, i32 %65)
  %67 = getelementptr inbounds %struct.Node, %struct.Node* %64, i32 0, i32 1
  %68 = load %struct.Node*, %struct.Node** %67, align 8
  %69 = add nsw i32 %65, 1
  %70 = icmp ne %struct.Node* %68, null
  br i1 %70, label %.lr.ph.peel.next11, label %._crit_edge.loopexit

.lr.ph.peel.next11:                               ; preds = %.lr.ph.peel12
  br label %.lr.ph.peel14

.lr.ph.peel14:                                    ; preds = %.lr.ph.peel.next11
  call void @initialize(%struct.Node* %68, i32 %69)
  %71 = getelementptr inbounds %struct.Node, %struct.Node* %68, i32 0, i32 1
  %72 = load %struct.Node*, %struct.Node** %71, align 8
  %73 = add nsw i32 %69, 1
  %74 = icmp ne %struct.Node* %72, null
  br i1 %74, label %.lr.ph.peel.next13, label %._crit_edge.loopexit

.lr.ph.peel.next13:                               ; preds = %.lr.ph.peel14
  br label %.lr.ph.peel16

.lr.ph.peel16:                                    ; preds = %.lr.ph.peel.next13
  call void @initialize(%struct.Node* %72, i32 %73)
  %75 = getelementptr inbounds %struct.Node, %struct.Node* %72, i32 0, i32 1
  %76 = load %struct.Node*, %struct.Node** %75, align 8
  %77 = add nsw i32 %73, 1
  %78 = icmp ne %struct.Node* %76, null
  br i1 %78, label %.lr.ph.peel.next15, label %._crit_edge.loopexit

.lr.ph.peel.next15:                               ; preds = %.lr.ph.peel16
  br label %.lr.ph.peel18

.lr.ph.peel18:                                    ; preds = %.lr.ph.peel.next15
  call void @initialize(%struct.Node* %76, i32 %77)
  %79 = getelementptr inbounds %struct.Node, %struct.Node* %76, i32 0, i32 1
  %80 = load %struct.Node*, %struct.Node** %79, align 8
  %81 = add nsw i32 %77, 1
  %82 = icmp ne %struct.Node* %80, null
  br i1 %82, label %.lr.ph.peel.next17, label %._crit_edge.loopexit

.lr.ph.peel.next17:                               ; preds = %.lr.ph.peel18
  br label %.lr.ph.peel20

.lr.ph.peel20:                                    ; preds = %.lr.ph.peel.next17
  call void @initialize(%struct.Node* %80, i32 %81)
  %83 = getelementptr inbounds %struct.Node, %struct.Node* %80, i32 0, i32 1
  %84 = load %struct.Node*, %struct.Node** %83, align 8
  %85 = add nsw i32 %81, 1
  %86 = icmp ne %struct.Node* %84, null
  br i1 %86, label %.lr.ph.peel.next19, label %._crit_edge.loopexit

.lr.ph.peel.next19:                               ; preds = %.lr.ph.peel20
  br label %.lr.ph.peel22

.lr.ph.peel22:                                    ; preds = %.lr.ph.peel.next19
  call void @initialize(%struct.Node* %84, i32 %85)
  %87 = getelementptr inbounds %struct.Node, %struct.Node* %84, i32 0, i32 1
  %88 = load %struct.Node*, %struct.Node** %87, align 8
  %89 = add nsw i32 %85, 1
  %90 = icmp ne %struct.Node* %88, null
  br i1 %90, label %.lr.ph.peel.next21, label %._crit_edge.loopexit

.lr.ph.peel.next21:                               ; preds = %.lr.ph.peel22
  br label %.lr.ph.peel24

.lr.ph.peel24:                                    ; preds = %.lr.ph.peel.next21
  call void @initialize(%struct.Node* %88, i32 %89)
  %91 = getelementptr inbounds %struct.Node, %struct.Node* %88, i32 0, i32 1
  %92 = load %struct.Node*, %struct.Node** %91, align 8
  %93 = add nsw i32 %89, 1
  %94 = icmp ne %struct.Node* %92, null
  br i1 %94, label %.lr.ph.peel.next23, label %._crit_edge.loopexit

.lr.ph.peel.next23:                               ; preds = %.lr.ph.peel24
  br label %.lr.ph.peel26

.lr.ph.peel26:                                    ; preds = %.lr.ph.peel.next23
  call void @initialize(%struct.Node* %92, i32 %93)
  %95 = getelementptr inbounds %struct.Node, %struct.Node* %92, i32 0, i32 1
  %96 = load %struct.Node*, %struct.Node** %95, align 8
  %97 = add nsw i32 %93, 1
  %98 = icmp ne %struct.Node* %96, null
  br i1 %98, label %.lr.ph.peel.next25, label %._crit_edge.loopexit

.lr.ph.peel.next25:                               ; preds = %.lr.ph.peel26
  br label %.lr.ph.peel28

.lr.ph.peel28:                                    ; preds = %.lr.ph.peel.next25
  call void @initialize(%struct.Node* %96, i32 %97)
  %99 = getelementptr inbounds %struct.Node, %struct.Node* %96, i32 0, i32 1
  %100 = load %struct.Node*, %struct.Node** %99, align 8
  %101 = add nsw i32 %97, 1
  %102 = icmp ne %struct.Node* %100, null
  br i1 %102, label %.lr.ph.peel.next27, label %._crit_edge.loopexit

.lr.ph.peel.next27:                               ; preds = %.lr.ph.peel28
  br label %.lr.ph.peel30

.lr.ph.peel30:                                    ; preds = %.lr.ph.peel.next27
  call void @initialize(%struct.Node* %100, i32 %101)
  %103 = getelementptr inbounds %struct.Node, %struct.Node* %100, i32 0, i32 1
  %104 = load %struct.Node*, %struct.Node** %103, align 8
  %105 = add nsw i32 %101, 1
  %106 = icmp ne %struct.Node* %104, null
  br i1 %106, label %.lr.ph.peel.next29, label %._crit_edge.loopexit

.lr.ph.peel.next29:                               ; preds = %.lr.ph.peel30
  br label %.lr.ph.peel32

.lr.ph.peel32:                                    ; preds = %.lr.ph.peel.next29
  call void @initialize(%struct.Node* %104, i32 %105)
  %107 = getelementptr inbounds %struct.Node, %struct.Node* %104, i32 0, i32 1
  %108 = load %struct.Node*, %struct.Node** %107, align 8
  %109 = add nsw i32 %105, 1
  %110 = icmp ne %struct.Node* %108, null
  br i1 %110, label %.lr.ph.peel.next31, label %._crit_edge.loopexit

.lr.ph.peel.next31:                               ; preds = %.lr.ph.peel32
  br label %.lr.ph.peel34

.lr.ph.peel34:                                    ; preds = %.lr.ph.peel.next31
  call void @initialize(%struct.Node* %108, i32 %109)
  %111 = getelementptr inbounds %struct.Node, %struct.Node* %108, i32 0, i32 1
  %112 = load %struct.Node*, %struct.Node** %111, align 8
  %113 = add nsw i32 %109, 1
  %114 = icmp ne %struct.Node* %112, null
  br i1 %114, label %.lr.ph.peel.next33, label %._crit_edge.loopexit

.lr.ph.peel.next33:                               ; preds = %.lr.ph.peel34
  br label %.lr.ph.peel36

.lr.ph.peel36:                                    ; preds = %.lr.ph.peel.next33
  call void @initialize(%struct.Node* %112, i32 %113)
  %115 = getelementptr inbounds %struct.Node, %struct.Node* %112, i32 0, i32 1
  %116 = load %struct.Node*, %struct.Node** %115, align 8
  %117 = add nsw i32 %113, 1
  %118 = icmp ne %struct.Node* %116, null
  br i1 %118, label %.lr.ph.peel.next35, label %._crit_edge.loopexit

.lr.ph.peel.next35:                               ; preds = %.lr.ph.peel36
  br label %.lr.ph.peel38

.lr.ph.peel38:                                    ; preds = %.lr.ph.peel.next35
  call void @initialize(%struct.Node* %116, i32 %117)
  %119 = getelementptr inbounds %struct.Node, %struct.Node* %116, i32 0, i32 1
  %120 = load %struct.Node*, %struct.Node** %119, align 8
  %121 = add nsw i32 %117, 1
  %122 = icmp ne %struct.Node* %120, null
  br i1 %122, label %.lr.ph.peel.next37, label %._crit_edge.loopexit

.lr.ph.peel.next37:                               ; preds = %.lr.ph.peel38
  br label %.lr.ph.peel.next39

.lr.ph.peel.next39:                               ; preds = %.lr.ph.peel.next37
  br label %.lr.ph.preheader.peel.newph

.lr.ph.preheader.peel.newph:                      ; preds = %.lr.ph.peel.next39
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %.lr.ph.preheader.peel.newph
  %.03 = phi %struct.Node* [ %124, %.lr.ph ], [ %120, %.lr.ph.preheader.peel.newph ]
  %.012 = phi i32 [ %125, %.lr.ph ], [ %121, %.lr.ph.preheader.peel.newph ]
  call void @initialize(%struct.Node* %.03, i32 %.012)
  %123 = getelementptr inbounds %struct.Node, %struct.Node* %.03, i32 0, i32 1
  %124 = load %struct.Node*, %struct.Node** %123, align 8
  %125 = add nsw i32 %.012, 1
  %126 = icmp ne %struct.Node* %124, null
  br i1 %126, label %.lr.ph, label %._crit_edge.loopexit.loopexit

._crit_edge.loopexit.loopexit:                    ; preds = %.lr.ph
  br label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %._crit_edge.loopexit.loopexit, %.lr.ph.peel38, %.lr.ph.peel36, %.lr.ph.peel34, %.lr.ph.peel32, %.lr.ph.peel30, %.lr.ph.peel28, %.lr.ph.peel26, %.lr.ph.peel24, %.lr.ph.peel22, %.lr.ph.peel20, %.lr.ph.peel18, %.lr.ph.peel16, %.lr.ph.peel14, %.lr.ph.peel12, %.lr.ph.peel10, %.lr.ph.peel8, %.lr.ph.peel6, %.lr.ph.peel4, %.lr.ph.peel2, %.lr.ph.peel
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  call void @branchPruned(%struct.Node* %2)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone(%struct.Node*, i32) #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  store i32 1, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.4(%struct.Node*, i32) #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  store i32 2, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.6(%struct.Node*, i32) #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  store i32 3, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.8(%struct.Node*, i32) #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  store i32 4, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.10(%struct.Node*, i32) #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  store i32 5, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.12(%struct.Node*, i32) #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  store i32 1, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.14(%struct.Node*, i32) #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  store i32 2, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.16(%struct.Node*, i32) #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  store i32 3, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.18(%struct.Node*, i32) #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  store i32 4, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.20(%struct.Node*, i32) #0 {
  %3 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  store i32 5, i32* %3, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.Node*) #0 {
  %2 = icmp ne i1 true, false
  %3 = icmp ne %struct.Node* %0, null
  br i1 true, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %1
  br label %.lr.ph.peel.begin

.lr.ph.peel.begin:                                ; preds = %.lr.ph.preheader
  br label %.lr.ph.peel

.lr.ph.peel:                                      ; preds = %.lr.ph.peel.begin
  %4 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  %5 = load i32, i32* %4, align 8
  %6 = icmp ne i32 1, 1
  %..023.peel = select i1 false, i8 0, i8 1
  %7 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 1
  %8 = load %struct.Node*, %struct.Node** %7, align 8
  %9 = add nsw i32 1, 1
  %10 = icmp ne i1 true, false
  %11 = icmp ne %struct.Node* %8, null
  br i1 true, label %.lr.ph.peel.next, label %._crit_edge.loopexit

.lr.ph.peel.next:                                 ; preds = %.lr.ph.peel
  br label %.lr.ph.peel2

.lr.ph.peel2:                                     ; preds = %.lr.ph.peel.next
  %12 = getelementptr inbounds %struct.Node, %struct.Node* %8, i32 0, i32 0
  %13 = load i32, i32* %12, align 8
  %14 = icmp ne i32 2, 2
  %..023.peel3 = select i1 false, i8 0, i8 1
  %15 = getelementptr inbounds %struct.Node, %struct.Node* %8, i32 0, i32 1
  %16 = load %struct.Node*, %struct.Node** %15, align 8
  %17 = add nsw i32 2, 1
  %18 = icmp ne i1 true, false
  %19 = icmp ne %struct.Node* %16, null
  br i1 true, label %.lr.ph.peel.next1, label %._crit_edge.loopexit

.lr.ph.peel.next1:                                ; preds = %.lr.ph.peel2
  br label %.lr.ph.peel5

.lr.ph.peel5:                                     ; preds = %.lr.ph.peel.next1
  %20 = getelementptr inbounds %struct.Node, %struct.Node* %16, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = icmp ne i32 3, 3
  %..023.peel6 = select i1 false, i8 0, i8 1
  %23 = getelementptr inbounds %struct.Node, %struct.Node* %16, i32 0, i32 1
  %24 = load %struct.Node*, %struct.Node** %23, align 8
  %25 = add nsw i32 3, 1
  %26 = icmp ne i1 true, false
  %27 = icmp ne %struct.Node* %24, null
  br i1 true, label %.lr.ph.peel.next4, label %._crit_edge.loopexit

.lr.ph.peel.next4:                                ; preds = %.lr.ph.peel5
  br label %.lr.ph.peel8

.lr.ph.peel8:                                     ; preds = %.lr.ph.peel.next4
  %28 = getelementptr inbounds %struct.Node, %struct.Node* %24, i32 0, i32 0
  %29 = load i32, i32* %28, align 8
  %30 = icmp ne i32 4, 4
  %..023.peel9 = select i1 false, i8 0, i8 1
  %31 = getelementptr inbounds %struct.Node, %struct.Node* %24, i32 0, i32 1
  %32 = load %struct.Node*, %struct.Node** %31, align 8
  %33 = add nsw i32 4, 1
  %34 = icmp ne i1 true, false
  %35 = icmp ne %struct.Node* %32, null
  br i1 true, label %.lr.ph.peel.next7, label %._crit_edge.loopexit

.lr.ph.peel.next7:                                ; preds = %.lr.ph.peel8
  br label %.lr.ph.peel11

.lr.ph.peel11:                                    ; preds = %.lr.ph.peel.next7
  %36 = getelementptr inbounds %struct.Node, %struct.Node* %32, i32 0, i32 0
  %37 = load i32, i32* %36, align 8
  %38 = icmp ne i32 5, 5
  %..023.peel12 = select i1 false, i8 0, i8 1
  %39 = getelementptr inbounds %struct.Node, %struct.Node* %32, i32 0, i32 1
  %40 = load %struct.Node*, %struct.Node** %39, align 8
  %41 = add nsw i32 5, 1
  %42 = icmp ne i1 false, false
  %43 = icmp ne %struct.Node* null, null
  br i1 false, label %.lr.ph.peel.next10, label %._crit_edge.loopexit

.lr.ph.peel.next10:                               ; preds = %.lr.ph.peel11
  br label %.lr.ph.peel14

.lr.ph.peel14:                                    ; preds = %.lr.ph.peel.next10
  %44 = getelementptr inbounds %struct.Node, %struct.Node* null, i32 0, i32 0
  %45 = load i32, i32* %44, align 8
  %46 = icmp ne i32 %45, 6
  %..023.peel15 = select i1 %46, i8 0, i8 1
  %47 = getelementptr inbounds %struct.Node, %struct.Node* null, i32 0, i32 1
  %48 = load %struct.Node*, %struct.Node** %47, align 8
  %49 = add nsw i32 6, 1
  %50 = icmp ne %struct.Node* %48, null
  br i1 %50, label %.lr.ph.peel.next13, label %._crit_edge.loopexit

.lr.ph.peel.next13:                               ; preds = %.lr.ph.peel14
  br label %.lr.ph.peel17

.lr.ph.peel17:                                    ; preds = %.lr.ph.peel.next13
  %51 = getelementptr inbounds %struct.Node, %struct.Node* %48, i32 0, i32 0
  %52 = load i32, i32* %51, align 8
  %53 = icmp ne i32 %52, %49
  %..023.peel18 = select i1 %53, i8 0, i8 %..023.peel15
  %54 = getelementptr inbounds %struct.Node, %struct.Node* %48, i32 0, i32 1
  %55 = load %struct.Node*, %struct.Node** %54, align 8
  %56 = add nsw i32 %49, 1
  %57 = icmp ne %struct.Node* %55, null
  br i1 %57, label %.lr.ph.peel.next16, label %._crit_edge.loopexit

.lr.ph.peel.next16:                               ; preds = %.lr.ph.peel17
  br label %.lr.ph.peel20

.lr.ph.peel20:                                    ; preds = %.lr.ph.peel.next16
  %58 = getelementptr inbounds %struct.Node, %struct.Node* %55, i32 0, i32 0
  %59 = load i32, i32* %58, align 8
  %60 = icmp ne i32 %59, %56
  %..023.peel21 = select i1 %60, i8 0, i8 %..023.peel18
  %61 = getelementptr inbounds %struct.Node, %struct.Node* %55, i32 0, i32 1
  %62 = load %struct.Node*, %struct.Node** %61, align 8
  %63 = add nsw i32 %56, 1
  %64 = icmp ne %struct.Node* %62, null
  br i1 %64, label %.lr.ph.peel.next19, label %._crit_edge.loopexit

.lr.ph.peel.next19:                               ; preds = %.lr.ph.peel20
  br label %.lr.ph.peel23

.lr.ph.peel23:                                    ; preds = %.lr.ph.peel.next19
  %65 = getelementptr inbounds %struct.Node, %struct.Node* %62, i32 0, i32 0
  %66 = load i32, i32* %65, align 8
  %67 = icmp ne i32 %66, %63
  %..023.peel24 = select i1 %67, i8 0, i8 %..023.peel21
  %68 = getelementptr inbounds %struct.Node, %struct.Node* %62, i32 0, i32 1
  %69 = load %struct.Node*, %struct.Node** %68, align 8
  %70 = add nsw i32 %63, 1
  %71 = icmp ne %struct.Node* %69, null
  br i1 %71, label %.lr.ph.peel.next22, label %._crit_edge.loopexit

.lr.ph.peel.next22:                               ; preds = %.lr.ph.peel23
  br label %.lr.ph.peel26

.lr.ph.peel26:                                    ; preds = %.lr.ph.peel.next22
  %72 = getelementptr inbounds %struct.Node, %struct.Node* %69, i32 0, i32 0
  %73 = load i32, i32* %72, align 8
  %74 = icmp ne i32 %73, %70
  %..023.peel27 = select i1 %74, i8 0, i8 %..023.peel24
  %75 = getelementptr inbounds %struct.Node, %struct.Node* %69, i32 0, i32 1
  %76 = load %struct.Node*, %struct.Node** %75, align 8
  %77 = add nsw i32 %70, 1
  %78 = icmp ne %struct.Node* %76, null
  br i1 %78, label %.lr.ph.peel.next25, label %._crit_edge.loopexit

.lr.ph.peel.next25:                               ; preds = %.lr.ph.peel26
  br label %.lr.ph.peel29

.lr.ph.peel29:                                    ; preds = %.lr.ph.peel.next25
  %79 = getelementptr inbounds %struct.Node, %struct.Node* %76, i32 0, i32 0
  %80 = load i32, i32* %79, align 8
  %81 = icmp ne i32 %80, %77
  %..023.peel30 = select i1 %81, i8 0, i8 %..023.peel27
  %82 = getelementptr inbounds %struct.Node, %struct.Node* %76, i32 0, i32 1
  %83 = load %struct.Node*, %struct.Node** %82, align 8
  %84 = add nsw i32 %77, 1
  %85 = icmp ne %struct.Node* %83, null
  br i1 %85, label %.lr.ph.peel.next28, label %._crit_edge.loopexit

.lr.ph.peel.next28:                               ; preds = %.lr.ph.peel29
  br label %.lr.ph.peel32

.lr.ph.peel32:                                    ; preds = %.lr.ph.peel.next28
  %86 = getelementptr inbounds %struct.Node, %struct.Node* %83, i32 0, i32 0
  %87 = load i32, i32* %86, align 8
  %88 = icmp ne i32 %87, %84
  %..023.peel33 = select i1 %88, i8 0, i8 %..023.peel30
  %89 = getelementptr inbounds %struct.Node, %struct.Node* %83, i32 0, i32 1
  %90 = load %struct.Node*, %struct.Node** %89, align 8
  %91 = add nsw i32 %84, 1
  %92 = icmp ne %struct.Node* %90, null
  br i1 %92, label %.lr.ph.peel.next31, label %._crit_edge.loopexit

.lr.ph.peel.next31:                               ; preds = %.lr.ph.peel32
  br label %.lr.ph.peel35

.lr.ph.peel35:                                    ; preds = %.lr.ph.peel.next31
  %93 = getelementptr inbounds %struct.Node, %struct.Node* %90, i32 0, i32 0
  %94 = load i32, i32* %93, align 8
  %95 = icmp ne i32 %94, %91
  %..023.peel36 = select i1 %95, i8 0, i8 %..023.peel33
  %96 = getelementptr inbounds %struct.Node, %struct.Node* %90, i32 0, i32 1
  %97 = load %struct.Node*, %struct.Node** %96, align 8
  %98 = add nsw i32 %91, 1
  %99 = icmp ne %struct.Node* %97, null
  br i1 %99, label %.lr.ph.peel.next34, label %._crit_edge.loopexit

.lr.ph.peel.next34:                               ; preds = %.lr.ph.peel35
  br label %.lr.ph.peel38

.lr.ph.peel38:                                    ; preds = %.lr.ph.peel.next34
  %100 = getelementptr inbounds %struct.Node, %struct.Node* %97, i32 0, i32 0
  %101 = load i32, i32* %100, align 8
  %102 = icmp ne i32 %101, %98
  %..023.peel39 = select i1 %102, i8 0, i8 %..023.peel36
  %103 = getelementptr inbounds %struct.Node, %struct.Node* %97, i32 0, i32 1
  %104 = load %struct.Node*, %struct.Node** %103, align 8
  %105 = add nsw i32 %98, 1
  %106 = icmp ne %struct.Node* %104, null
  br i1 %106, label %.lr.ph.peel.next37, label %._crit_edge.loopexit

.lr.ph.peel.next37:                               ; preds = %.lr.ph.peel38
  br label %.lr.ph.peel41

.lr.ph.peel41:                                    ; preds = %.lr.ph.peel.next37
  %107 = getelementptr inbounds %struct.Node, %struct.Node* %104, i32 0, i32 0
  %108 = load i32, i32* %107, align 8
  %109 = icmp ne i32 %108, %105
  %..023.peel42 = select i1 %109, i8 0, i8 %..023.peel39
  %110 = getelementptr inbounds %struct.Node, %struct.Node* %104, i32 0, i32 1
  %111 = load %struct.Node*, %struct.Node** %110, align 8
  %112 = add nsw i32 %105, 1
  %113 = icmp ne %struct.Node* %111, null
  br i1 %113, label %.lr.ph.peel.next40, label %._crit_edge.loopexit

.lr.ph.peel.next40:                               ; preds = %.lr.ph.peel41
  br label %.lr.ph.peel44

.lr.ph.peel44:                                    ; preds = %.lr.ph.peel.next40
  %114 = getelementptr inbounds %struct.Node, %struct.Node* %111, i32 0, i32 0
  %115 = load i32, i32* %114, align 8
  %116 = icmp ne i32 %115, %112
  %..023.peel45 = select i1 %116, i8 0, i8 %..023.peel42
  %117 = getelementptr inbounds %struct.Node, %struct.Node* %111, i32 0, i32 1
  %118 = load %struct.Node*, %struct.Node** %117, align 8
  %119 = add nsw i32 %112, 1
  %120 = icmp ne %struct.Node* %118, null
  br i1 %120, label %.lr.ph.peel.next43, label %._crit_edge.loopexit

.lr.ph.peel.next43:                               ; preds = %.lr.ph.peel44
  br label %.lr.ph.peel47

.lr.ph.peel47:                                    ; preds = %.lr.ph.peel.next43
  %121 = getelementptr inbounds %struct.Node, %struct.Node* %118, i32 0, i32 0
  %122 = load i32, i32* %121, align 8
  %123 = icmp ne i32 %122, %119
  %..023.peel48 = select i1 %123, i8 0, i8 %..023.peel45
  %124 = getelementptr inbounds %struct.Node, %struct.Node* %118, i32 0, i32 1
  %125 = load %struct.Node*, %struct.Node** %124, align 8
  %126 = add nsw i32 %119, 1
  %127 = icmp ne %struct.Node* %125, null
  br i1 %127, label %.lr.ph.peel.next46, label %._crit_edge.loopexit

.lr.ph.peel.next46:                               ; preds = %.lr.ph.peel47
  br label %.lr.ph.peel50

.lr.ph.peel50:                                    ; preds = %.lr.ph.peel.next46
  %128 = getelementptr inbounds %struct.Node, %struct.Node* %125, i32 0, i32 0
  %129 = load i32, i32* %128, align 8
  %130 = icmp ne i32 %129, %126
  %..023.peel51 = select i1 %130, i8 0, i8 %..023.peel48
  %131 = getelementptr inbounds %struct.Node, %struct.Node* %125, i32 0, i32 1
  %132 = load %struct.Node*, %struct.Node** %131, align 8
  %133 = add nsw i32 %126, 1
  %134 = icmp ne %struct.Node* %132, null
  br i1 %134, label %.lr.ph.peel.next49, label %._crit_edge.loopexit

.lr.ph.peel.next49:                               ; preds = %.lr.ph.peel50
  br label %.lr.ph.peel53

.lr.ph.peel53:                                    ; preds = %.lr.ph.peel.next49
  %135 = getelementptr inbounds %struct.Node, %struct.Node* %132, i32 0, i32 0
  %136 = load i32, i32* %135, align 8
  %137 = icmp ne i32 %136, %133
  %..023.peel54 = select i1 %137, i8 0, i8 %..023.peel51
  %138 = getelementptr inbounds %struct.Node, %struct.Node* %132, i32 0, i32 1
  %139 = load %struct.Node*, %struct.Node** %138, align 8
  %140 = add nsw i32 %133, 1
  %141 = icmp ne %struct.Node* %139, null
  br i1 %141, label %.lr.ph.peel.next52, label %._crit_edge.loopexit

.lr.ph.peel.next52:                               ; preds = %.lr.ph.peel53
  br label %.lr.ph.peel56

.lr.ph.peel56:                                    ; preds = %.lr.ph.peel.next52
  %142 = getelementptr inbounds %struct.Node, %struct.Node* %139, i32 0, i32 0
  %143 = load i32, i32* %142, align 8
  %144 = icmp ne i32 %143, %140
  %..023.peel57 = select i1 %144, i8 0, i8 %..023.peel54
  %145 = getelementptr inbounds %struct.Node, %struct.Node* %139, i32 0, i32 1
  %146 = load %struct.Node*, %struct.Node** %145, align 8
  %147 = add nsw i32 %140, 1
  %148 = icmp ne %struct.Node* %146, null
  br i1 %148, label %.lr.ph.peel.next55, label %._crit_edge.loopexit

.lr.ph.peel.next55:                               ; preds = %.lr.ph.peel56
  br label %.lr.ph.peel.next58

.lr.ph.peel.next58:                               ; preds = %.lr.ph.peel.next55
  br label %.lr.ph.preheader.peel.newph

.lr.ph.preheader.peel.newph:                      ; preds = %.lr.ph.peel.next58
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader.peel.newph, %.lr.ph
  %.05 = phi %struct.Node* [ %153, %.lr.ph ], [ %146, %.lr.ph.preheader.peel.newph ]
  %.014 = phi i32 [ %154, %.lr.ph ], [ %147, %.lr.ph.preheader.peel.newph ]
  %.023 = phi i8 [ %..023, %.lr.ph ], [ %..023.peel57, %.lr.ph.preheader.peel.newph ]
  %149 = getelementptr inbounds %struct.Node, %struct.Node* %.05, i32 0, i32 0
  %150 = load i32, i32* %149, align 8
  %151 = icmp ne i32 %150, %.014
  %..023 = select i1 %151, i8 0, i8 %.023
  %152 = getelementptr inbounds %struct.Node, %struct.Node* %.05, i32 0, i32 1
  %153 = load %struct.Node*, %struct.Node** %152, align 8
  %154 = add nsw i32 %.014, 1
  %155 = icmp ne %struct.Node* %153, null
  br i1 %155, label %.lr.ph, label %._crit_edge.loopexit.loopexit

._crit_edge.loopexit.loopexit:                    ; preds = %.lr.ph
  %..023.lcssa59 = phi i8 [ %..023, %.lr.ph ]
  br label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %._crit_edge.loopexit.loopexit, %.lr.ph.peel56, %.lr.ph.peel53, %.lr.ph.peel50, %.lr.ph.peel47, %.lr.ph.peel44, %.lr.ph.peel41, %.lr.ph.peel38, %.lr.ph.peel35, %.lr.ph.peel32, %.lr.ph.peel29, %.lr.ph.peel26, %.lr.ph.peel23, %.lr.ph.peel20, %.lr.ph.peel17, %.lr.ph.peel14, %.lr.ph.peel11, %.lr.ph.peel8, %.lr.ph.peel5, %.lr.ph.peel2, %.lr.ph.peel
  %..023.lcssa = phi i8 [ 1, %.lr.ph.peel ], [ 1, %.lr.ph.peel2 ], [ 1, %.lr.ph.peel5 ], [ 1, %.lr.ph.peel8 ], [ 1, %.lr.ph.peel11 ], [ %..023.peel15, %.lr.ph.peel14 ], [ %..023.peel18, %.lr.ph.peel17 ], [ %..023.peel21, %.lr.ph.peel20 ], [ %..023.peel24, %.lr.ph.peel23 ], [ %..023.peel27, %.lr.ph.peel26 ], [ %..023.peel30, %.lr.ph.peel29 ], [ %..023.peel33, %.lr.ph.peel32 ], [ %..023.peel36, %.lr.ph.peel35 ], [ %..023.peel39, %.lr.ph.peel38 ], [ %..023.peel42, %.lr.ph.peel41 ], [ %..023.peel45, %.lr.ph.peel44 ], [ %..023.peel48, %.lr.ph.peel47 ], [ %..023.peel51, %.lr.ph.peel50 ], [ %..023.peel54, %.lr.ph.peel53 ], [ %..023.peel57, %.lr.ph.peel56 ], [ %..023.lcssa59, %._crit_edge.loopexit.loopexit ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %1
  %.02.lcssa = phi i8 [ 1, %1 ], [ 1, %._crit_edge.loopexit ]
  %156 = icmp ne i8 1, 0
  br i1 true, label %157, label %159

; <label>:157:                                    ; preds = %._crit_edge
  %158 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i32 0, i32 0))
  br label %159

; <label>:159:                                    ; preds = %157, %._crit_edge
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone_clone(%struct.Node*) #0 {
  %2 = icmp ne i1 true, false
  %3 = icmp ne %struct.Node* %0, null
  br i1 true, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %1
  br label %.lr.ph.peel.begin

.lr.ph.peel.begin:                                ; preds = %.lr.ph.preheader
  br label %.lr.ph.peel

.lr.ph.peel:                                      ; preds = %.lr.ph.peel.begin
  %4 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 0
  %5 = load i32, i32* %4, align 8
  %6 = icmp ne i32 1, 1
  %..023.peel = select i1 false, i8 0, i8 1
  %7 = getelementptr inbounds %struct.Node, %struct.Node* %0, i32 0, i32 1
  %8 = load %struct.Node*, %struct.Node** %7, align 8
  %9 = add nsw i32 1, 1
  %10 = icmp ne i1 true, false
  %11 = icmp ne %struct.Node* %8, null
  br i1 true, label %.lr.ph.peel.next, label %._crit_edge.loopexit

.lr.ph.peel.next:                                 ; preds = %.lr.ph.peel
  br label %.lr.ph.peel2

.lr.ph.peel2:                                     ; preds = %.lr.ph.peel.next
  %12 = getelementptr inbounds %struct.Node, %struct.Node* %8, i32 0, i32 0
  %13 = load i32, i32* %12, align 8
  %14 = icmp ne i32 2, 2
  %..023.peel3 = select i1 false, i8 0, i8 1
  %15 = getelementptr inbounds %struct.Node, %struct.Node* %8, i32 0, i32 1
  %16 = load %struct.Node*, %struct.Node** %15, align 8
  %17 = add nsw i32 2, 1
  %18 = icmp ne i1 true, false
  %19 = icmp ne %struct.Node* %16, null
  br i1 true, label %.lr.ph.peel.next1, label %._crit_edge.loopexit

.lr.ph.peel.next1:                                ; preds = %.lr.ph.peel2
  br label %.lr.ph.peel5

.lr.ph.peel5:                                     ; preds = %.lr.ph.peel.next1
  %20 = getelementptr inbounds %struct.Node, %struct.Node* %16, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = icmp ne i32 3, 3
  %..023.peel6 = select i1 false, i8 0, i8 1
  %23 = getelementptr inbounds %struct.Node, %struct.Node* %16, i32 0, i32 1
  %24 = load %struct.Node*, %struct.Node** %23, align 8
  %25 = add nsw i32 3, 1
  %26 = icmp ne i1 true, false
  %27 = icmp ne %struct.Node* %24, null
  br i1 true, label %.lr.ph.peel.next4, label %._crit_edge.loopexit

.lr.ph.peel.next4:                                ; preds = %.lr.ph.peel5
  br label %.lr.ph.peel8

.lr.ph.peel8:                                     ; preds = %.lr.ph.peel.next4
  %28 = getelementptr inbounds %struct.Node, %struct.Node* %24, i32 0, i32 0
  %29 = load i32, i32* %28, align 8
  %30 = icmp ne i32 4, 4
  %..023.peel9 = select i1 false, i8 0, i8 1
  %31 = getelementptr inbounds %struct.Node, %struct.Node* %24, i32 0, i32 1
  %32 = load %struct.Node*, %struct.Node** %31, align 8
  %33 = add nsw i32 4, 1
  %34 = icmp ne i1 true, false
  %35 = icmp ne %struct.Node* %32, null
  br i1 true, label %.lr.ph.peel.next7, label %._crit_edge.loopexit

.lr.ph.peel.next7:                                ; preds = %.lr.ph.peel8
  br label %.lr.ph.peel11

.lr.ph.peel11:                                    ; preds = %.lr.ph.peel.next7
  %36 = getelementptr inbounds %struct.Node, %struct.Node* %32, i32 0, i32 0
  %37 = load i32, i32* %36, align 8
  %38 = icmp ne i32 5, 5
  %..023.peel12 = select i1 false, i8 0, i8 1
  %39 = getelementptr inbounds %struct.Node, %struct.Node* %32, i32 0, i32 1
  %40 = load %struct.Node*, %struct.Node** %39, align 8
  %41 = add nsw i32 5, 1
  %42 = icmp ne i1 false, false
  %43 = icmp ne %struct.Node* null, null
  br i1 false, label %.lr.ph.peel.next10, label %._crit_edge.loopexit

.lr.ph.peel.next10:                               ; preds = %.lr.ph.peel11
  br label %.lr.ph.peel14

.lr.ph.peel14:                                    ; preds = %.lr.ph.peel.next10
  %44 = getelementptr inbounds %struct.Node, %struct.Node* null, i32 0, i32 0
  %45 = load i32, i32* %44, align 8
  %46 = icmp ne i32 %45, 6
  %..023.peel15 = select i1 %46, i8 0, i8 1
  %47 = getelementptr inbounds %struct.Node, %struct.Node* null, i32 0, i32 1
  %48 = load %struct.Node*, %struct.Node** %47, align 8
  %49 = add nsw i32 6, 1
  %50 = icmp ne %struct.Node* %48, null
  br i1 %50, label %.lr.ph.peel.next13, label %._crit_edge.loopexit

.lr.ph.peel.next13:                               ; preds = %.lr.ph.peel14
  br label %.lr.ph.peel17

.lr.ph.peel17:                                    ; preds = %.lr.ph.peel.next13
  %51 = getelementptr inbounds %struct.Node, %struct.Node* %48, i32 0, i32 0
  %52 = load i32, i32* %51, align 8
  %53 = icmp ne i32 %52, %49
  %..023.peel18 = select i1 %53, i8 0, i8 %..023.peel15
  %54 = getelementptr inbounds %struct.Node, %struct.Node* %48, i32 0, i32 1
  %55 = load %struct.Node*, %struct.Node** %54, align 8
  %56 = add nsw i32 %49, 1
  %57 = icmp ne %struct.Node* %55, null
  br i1 %57, label %.lr.ph.peel.next16, label %._crit_edge.loopexit

.lr.ph.peel.next16:                               ; preds = %.lr.ph.peel17
  br label %.lr.ph.peel20

.lr.ph.peel20:                                    ; preds = %.lr.ph.peel.next16
  %58 = getelementptr inbounds %struct.Node, %struct.Node* %55, i32 0, i32 0
  %59 = load i32, i32* %58, align 8
  %60 = icmp ne i32 %59, %56
  %..023.peel21 = select i1 %60, i8 0, i8 %..023.peel18
  %61 = getelementptr inbounds %struct.Node, %struct.Node* %55, i32 0, i32 1
  %62 = load %struct.Node*, %struct.Node** %61, align 8
  %63 = add nsw i32 %56, 1
  %64 = icmp ne %struct.Node* %62, null
  br i1 %64, label %.lr.ph.peel.next19, label %._crit_edge.loopexit

.lr.ph.peel.next19:                               ; preds = %.lr.ph.peel20
  br label %.lr.ph.peel23

.lr.ph.peel23:                                    ; preds = %.lr.ph.peel.next19
  %65 = getelementptr inbounds %struct.Node, %struct.Node* %62, i32 0, i32 0
  %66 = load i32, i32* %65, align 8
  %67 = icmp ne i32 %66, %63
  %..023.peel24 = select i1 %67, i8 0, i8 %..023.peel21
  %68 = getelementptr inbounds %struct.Node, %struct.Node* %62, i32 0, i32 1
  %69 = load %struct.Node*, %struct.Node** %68, align 8
  %70 = add nsw i32 %63, 1
  %71 = icmp ne %struct.Node* %69, null
  br i1 %71, label %.lr.ph.peel.next22, label %._crit_edge.loopexit

.lr.ph.peel.next22:                               ; preds = %.lr.ph.peel23
  br label %.lr.ph.peel26

.lr.ph.peel26:                                    ; preds = %.lr.ph.peel.next22
  %72 = getelementptr inbounds %struct.Node, %struct.Node* %69, i32 0, i32 0
  %73 = load i32, i32* %72, align 8
  %74 = icmp ne i32 %73, %70
  %..023.peel27 = select i1 %74, i8 0, i8 %..023.peel24
  %75 = getelementptr inbounds %struct.Node, %struct.Node* %69, i32 0, i32 1
  %76 = load %struct.Node*, %struct.Node** %75, align 8
  %77 = add nsw i32 %70, 1
  %78 = icmp ne %struct.Node* %76, null
  br i1 %78, label %.lr.ph.peel.next25, label %._crit_edge.loopexit

.lr.ph.peel.next25:                               ; preds = %.lr.ph.peel26
  br label %.lr.ph.peel29

.lr.ph.peel29:                                    ; preds = %.lr.ph.peel.next25
  %79 = getelementptr inbounds %struct.Node, %struct.Node* %76, i32 0, i32 0
  %80 = load i32, i32* %79, align 8
  %81 = icmp ne i32 %80, %77
  %..023.peel30 = select i1 %81, i8 0, i8 %..023.peel27
  %82 = getelementptr inbounds %struct.Node, %struct.Node* %76, i32 0, i32 1
  %83 = load %struct.Node*, %struct.Node** %82, align 8
  %84 = add nsw i32 %77, 1
  %85 = icmp ne %struct.Node* %83, null
  br i1 %85, label %.lr.ph.peel.next28, label %._crit_edge.loopexit

.lr.ph.peel.next28:                               ; preds = %.lr.ph.peel29
  br label %.lr.ph.peel32

.lr.ph.peel32:                                    ; preds = %.lr.ph.peel.next28
  %86 = getelementptr inbounds %struct.Node, %struct.Node* %83, i32 0, i32 0
  %87 = load i32, i32* %86, align 8
  %88 = icmp ne i32 %87, %84
  %..023.peel33 = select i1 %88, i8 0, i8 %..023.peel30
  %89 = getelementptr inbounds %struct.Node, %struct.Node* %83, i32 0, i32 1
  %90 = load %struct.Node*, %struct.Node** %89, align 8
  %91 = add nsw i32 %84, 1
  %92 = icmp ne %struct.Node* %90, null
  br i1 %92, label %.lr.ph.peel.next31, label %._crit_edge.loopexit

.lr.ph.peel.next31:                               ; preds = %.lr.ph.peel32
  br label %.lr.ph.peel35

.lr.ph.peel35:                                    ; preds = %.lr.ph.peel.next31
  %93 = getelementptr inbounds %struct.Node, %struct.Node* %90, i32 0, i32 0
  %94 = load i32, i32* %93, align 8
  %95 = icmp ne i32 %94, %91
  %..023.peel36 = select i1 %95, i8 0, i8 %..023.peel33
  %96 = getelementptr inbounds %struct.Node, %struct.Node* %90, i32 0, i32 1
  %97 = load %struct.Node*, %struct.Node** %96, align 8
  %98 = add nsw i32 %91, 1
  %99 = icmp ne %struct.Node* %97, null
  br i1 %99, label %.lr.ph.peel.next34, label %._crit_edge.loopexit

.lr.ph.peel.next34:                               ; preds = %.lr.ph.peel35
  br label %.lr.ph.peel38

.lr.ph.peel38:                                    ; preds = %.lr.ph.peel.next34
  %100 = getelementptr inbounds %struct.Node, %struct.Node* %97, i32 0, i32 0
  %101 = load i32, i32* %100, align 8
  %102 = icmp ne i32 %101, %98
  %..023.peel39 = select i1 %102, i8 0, i8 %..023.peel36
  %103 = getelementptr inbounds %struct.Node, %struct.Node* %97, i32 0, i32 1
  %104 = load %struct.Node*, %struct.Node** %103, align 8
  %105 = add nsw i32 %98, 1
  %106 = icmp ne %struct.Node* %104, null
  br i1 %106, label %.lr.ph.peel.next37, label %._crit_edge.loopexit

.lr.ph.peel.next37:                               ; preds = %.lr.ph.peel38
  br label %.lr.ph.peel41

.lr.ph.peel41:                                    ; preds = %.lr.ph.peel.next37
  %107 = getelementptr inbounds %struct.Node, %struct.Node* %104, i32 0, i32 0
  %108 = load i32, i32* %107, align 8
  %109 = icmp ne i32 %108, %105
  %..023.peel42 = select i1 %109, i8 0, i8 %..023.peel39
  %110 = getelementptr inbounds %struct.Node, %struct.Node* %104, i32 0, i32 1
  %111 = load %struct.Node*, %struct.Node** %110, align 8
  %112 = add nsw i32 %105, 1
  %113 = icmp ne %struct.Node* %111, null
  br i1 %113, label %.lr.ph.peel.next40, label %._crit_edge.loopexit

.lr.ph.peel.next40:                               ; preds = %.lr.ph.peel41
  br label %.lr.ph.peel44

.lr.ph.peel44:                                    ; preds = %.lr.ph.peel.next40
  %114 = getelementptr inbounds %struct.Node, %struct.Node* %111, i32 0, i32 0
  %115 = load i32, i32* %114, align 8
  %116 = icmp ne i32 %115, %112
  %..023.peel45 = select i1 %116, i8 0, i8 %..023.peel42
  %117 = getelementptr inbounds %struct.Node, %struct.Node* %111, i32 0, i32 1
  %118 = load %struct.Node*, %struct.Node** %117, align 8
  %119 = add nsw i32 %112, 1
  %120 = icmp ne %struct.Node* %118, null
  br i1 %120, label %.lr.ph.peel.next43, label %._crit_edge.loopexit

.lr.ph.peel.next43:                               ; preds = %.lr.ph.peel44
  br label %.lr.ph.peel47

.lr.ph.peel47:                                    ; preds = %.lr.ph.peel.next43
  %121 = getelementptr inbounds %struct.Node, %struct.Node* %118, i32 0, i32 0
  %122 = load i32, i32* %121, align 8
  %123 = icmp ne i32 %122, %119
  %..023.peel48 = select i1 %123, i8 0, i8 %..023.peel45
  %124 = getelementptr inbounds %struct.Node, %struct.Node* %118, i32 0, i32 1
  %125 = load %struct.Node*, %struct.Node** %124, align 8
  %126 = add nsw i32 %119, 1
  %127 = icmp ne %struct.Node* %125, null
  br i1 %127, label %.lr.ph.peel.next46, label %._crit_edge.loopexit

.lr.ph.peel.next46:                               ; preds = %.lr.ph.peel47
  br label %.lr.ph.peel50

.lr.ph.peel50:                                    ; preds = %.lr.ph.peel.next46
  %128 = getelementptr inbounds %struct.Node, %struct.Node* %125, i32 0, i32 0
  %129 = load i32, i32* %128, align 8
  %130 = icmp ne i32 %129, %126
  %..023.peel51 = select i1 %130, i8 0, i8 %..023.peel48
  %131 = getelementptr inbounds %struct.Node, %struct.Node* %125, i32 0, i32 1
  %132 = load %struct.Node*, %struct.Node** %131, align 8
  %133 = add nsw i32 %126, 1
  %134 = icmp ne %struct.Node* %132, null
  br i1 %134, label %.lr.ph.peel.next49, label %._crit_edge.loopexit

.lr.ph.peel.next49:                               ; preds = %.lr.ph.peel50
  br label %.lr.ph.peel53

.lr.ph.peel53:                                    ; preds = %.lr.ph.peel.next49
  %135 = getelementptr inbounds %struct.Node, %struct.Node* %132, i32 0, i32 0
  %136 = load i32, i32* %135, align 8
  %137 = icmp ne i32 %136, %133
  %..023.peel54 = select i1 %137, i8 0, i8 %..023.peel51
  %138 = getelementptr inbounds %struct.Node, %struct.Node* %132, i32 0, i32 1
  %139 = load %struct.Node*, %struct.Node** %138, align 8
  %140 = add nsw i32 %133, 1
  %141 = icmp ne %struct.Node* %139, null
  br i1 %141, label %.lr.ph.peel.next52, label %._crit_edge.loopexit

.lr.ph.peel.next52:                               ; preds = %.lr.ph.peel53
  br label %.lr.ph.peel56

.lr.ph.peel56:                                    ; preds = %.lr.ph.peel.next52
  %142 = getelementptr inbounds %struct.Node, %struct.Node* %139, i32 0, i32 0
  %143 = load i32, i32* %142, align 8
  %144 = icmp ne i32 %143, %140
  %..023.peel57 = select i1 %144, i8 0, i8 %..023.peel54
  %145 = getelementptr inbounds %struct.Node, %struct.Node* %139, i32 0, i32 1
  %146 = load %struct.Node*, %struct.Node** %145, align 8
  %147 = add nsw i32 %140, 1
  %148 = icmp ne %struct.Node* %146, null
  br i1 %148, label %.lr.ph.peel.next55, label %._crit_edge.loopexit

.lr.ph.peel.next55:                               ; preds = %.lr.ph.peel56
  br label %.lr.ph.peel.next58

.lr.ph.peel.next58:                               ; preds = %.lr.ph.peel.next55
  br label %.lr.ph.preheader.peel.newph

.lr.ph.preheader.peel.newph:                      ; preds = %.lr.ph.peel.next58
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %.lr.ph.preheader.peel.newph
  %.05 = phi %struct.Node* [ %153, %.lr.ph ], [ %146, %.lr.ph.preheader.peel.newph ]
  %.014 = phi i32 [ %154, %.lr.ph ], [ %147, %.lr.ph.preheader.peel.newph ]
  %.023 = phi i8 [ %..023, %.lr.ph ], [ %..023.peel57, %.lr.ph.preheader.peel.newph ]
  %149 = getelementptr inbounds %struct.Node, %struct.Node* %.05, i32 0, i32 0
  %150 = load i32, i32* %149, align 8
  %151 = icmp ne i32 %150, %.014
  %..023 = select i1 %151, i8 0, i8 %.023
  %152 = getelementptr inbounds %struct.Node, %struct.Node* %.05, i32 0, i32 1
  %153 = load %struct.Node*, %struct.Node** %152, align 8
  %154 = add nsw i32 %.014, 1
  %155 = icmp ne %struct.Node* %153, null
  br i1 %155, label %.lr.ph, label %._crit_edge.loopexit.loopexit

._crit_edge.loopexit.loopexit:                    ; preds = %.lr.ph
  %..023.lcssa59 = phi i8 [ %..023, %.lr.ph ]
  br label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %._crit_edge.loopexit.loopexit, %.lr.ph.peel56, %.lr.ph.peel53, %.lr.ph.peel50, %.lr.ph.peel47, %.lr.ph.peel44, %.lr.ph.peel41, %.lr.ph.peel38, %.lr.ph.peel35, %.lr.ph.peel32, %.lr.ph.peel29, %.lr.ph.peel26, %.lr.ph.peel23, %.lr.ph.peel20, %.lr.ph.peel17, %.lr.ph.peel14, %.lr.ph.peel11, %.lr.ph.peel8, %.lr.ph.peel5, %.lr.ph.peel2, %.lr.ph.peel
  %..023.lcssa = phi i8 [ 1, %.lr.ph.peel ], [ 1, %.lr.ph.peel2 ], [ 1, %.lr.ph.peel5 ], [ 1, %.lr.ph.peel8 ], [ 1, %.lr.ph.peel11 ], [ %..023.peel15, %.lr.ph.peel14 ], [ %..023.peel18, %.lr.ph.peel17 ], [ %..023.peel21, %.lr.ph.peel20 ], [ %..023.peel24, %.lr.ph.peel23 ], [ %..023.peel27, %.lr.ph.peel26 ], [ %..023.peel30, %.lr.ph.peel29 ], [ %..023.peel33, %.lr.ph.peel32 ], [ %..023.peel36, %.lr.ph.peel35 ], [ %..023.peel39, %.lr.ph.peel38 ], [ %..023.peel42, %.lr.ph.peel41 ], [ %..023.peel45, %.lr.ph.peel44 ], [ %..023.peel48, %.lr.ph.peel47 ], [ %..023.peel51, %.lr.ph.peel50 ], [ %..023.peel54, %.lr.ph.peel53 ], [ %..023.peel57, %.lr.ph.peel56 ], [ %..023.lcssa59, %._crit_edge.loopexit.loopexit ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %1
  %.02.lcssa = phi i8 [ 1, %1 ], [ %..023.lcssa, %._crit_edge.loopexit ]
  %156 = icmp ne i8 %.02.lcssa, 0
  br i1 %156, label %157, label %159

; <label>:157:                                    ; preds = %._crit_edge
  %158 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i32 0, i32 0))
  br label %159

; <label>:159:                                    ; preds = %157, %._crit_edge
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
