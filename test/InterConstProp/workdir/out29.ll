; ModuleID = 'workdir/out29.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"hello\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"test\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"-a\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"-b\00", align 1
@.str.5 = private unnamed_addr constant [3 x i8] c"-s\00", align 1
@.str.6 = private unnamed_addr constant [5 x i8] c"abs:\00", align 1
@optarg = external local_unnamed_addr global i8*, align 8
@optind = external local_unnamed_addr global i32, align 4
@.str.7 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@str.1 = private unnamed_addr constant [13 x i8] c"branchPruned\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(i64, i8* nocapture readonly) local_unnamed_addr #0 {
  %sext.mask1 = and i64 %0, 255
  %3 = icmp eq i64 %sext.mask1, 1
  br i1 %3, label %4, label %12

; <label>:4:                                      ; preds = %2
  %.sroa.0.1.extract.shift = lshr i64 %0, 8
  %sext2 = shl i64 %.sroa.0.1.extract.shift, 24
  %sext = trunc i64 %sext2 to i32
  %5 = icmp eq i32 %sext, 16777216
  br i1 %5, label %6, label %12

; <label>:6:                                      ; preds = %4
  %.sroa.0.2.extract.shift = lshr i64 %0, 16
  %sext45 = shl i64 %.sroa.0.2.extract.shift, 24
  %sext4 = trunc i64 %sext45 to i32
  %7 = icmp eq i32 %sext4, 16777216
  br i1 %7, label %8, label %12

; <label>:8:                                      ; preds = %6
  %9 = tail call i32 @strcmp(i8* %1, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0)) #5
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %12

; <label>:11:                                     ; preds = %8
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.1, i64 0, i64 0))
  br label %12

; <label>:12:                                     ; preds = %8, %11, %6, %4, %2
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: noinline nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
.lr.ph.preheader:
  %0 = alloca [5 x i8*], align 16
  %1 = getelementptr inbounds [5 x i8*], [5 x i8*]* %0, i64 0, i64 0
  %2 = bitcast [5 x i8*]* %0 to <2 x i8*>*
  store <2 x i8*> <i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i64 0, i64 0)>, <2 x i8*>* %2, align 16
  %3 = getelementptr inbounds [5 x i8*], [5 x i8*]* %0, i64 0, i64 2
  %4 = bitcast i8** %3 to <2 x i8*>*
  store <2 x i8*> <i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.5, i64 0, i64 0)>, <2 x i8*>* %4, align 16
  %5 = getelementptr inbounds [5 x i8*], [5 x i8*]* %0, i64 0, i64 4
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0), i8** %5, align 16
  %6 = call i32 @getopt(i32 5, i8** nonnull %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i64 0, i64 0)) #4
  %7 = call i32 @getopt(i32 5, i8** nonnull %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i64 0, i64 0)) #4
  %8 = call i32 @getopt(i32 5, i8** nonnull %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i64 0, i64 0)) #4
  %9 = call i32 @getopt(i32 5, i8** nonnull %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i64 0, i64 0)) #4
  call void @branchPruned_clone(i64 undef, i8* undef)
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.7, i64 0, i64 0), i32 5)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @getopt(i32, i8**, i8*) local_unnamed_addr #2

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline nounwind uwtable
define i32 @main_clone() local_unnamed_addr #0 {
.lr.ph.preheader:
  %0 = alloca [5 x i8*], align 16
  %1 = getelementptr inbounds [5 x i8*], [5 x i8*]* %0, i64 0, i64 0
  %2 = bitcast [5 x i8*]* %0 to <2 x i8*>*
  store <2 x i8*> <i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i64 0, i64 0)>, <2 x i8*>* %2, align 16
  %3 = getelementptr inbounds [5 x i8*], [5 x i8*]* %0, i64 0, i64 2
  %4 = bitcast i8** %3 to <2 x i8*>*
  store <2 x i8*> <i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.5, i64 0, i64 0)>, <2 x i8*>* %4, align 16
  %5 = getelementptr inbounds [5 x i8*], [5 x i8*]* %0, i64 0, i64 4
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0), i8** %5, align 16
  %6 = call i32 @getopt(i32 5, i8** nonnull %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i64 0, i64 0)) #4
  %7 = call i32 @getopt(i32 5, i8** nonnull %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i64 0, i64 0)) #4
  %8 = call i32 @getopt(i32 5, i8** nonnull %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i64 0, i64 0)) #4
  %9 = call noalias i8* @malloc(i64 5) #4
  %10 = load i8*, i8** @optarg, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %9, i8* %10, i64 5, i32 1, i1 false)
  %11 = call i32 @getopt(i32 5, i8** nonnull %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i64 0, i64 0)) #4
  call void @branchPruned(i64 65793, i8* %9)
  %12 = load i32, i32* @optind, align 4
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.7, i64 0, i64 0), i32 %12)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(i64, i8* nocapture readnone) local_unnamed_addr #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.1, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #4

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
