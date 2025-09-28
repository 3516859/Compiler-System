; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; 全局字符串常量，指针类型使用 ptr
@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; ===============================
; main 函数定义，使用 opaque pointers
; ===============================
define dso_local i32 @main() #0 {
  ; 局部变量分配，alloca 保留原类型（元素类型）
  %1 = alloca i32, align 4      ; a
  %2 = alloca i32, align 4      ; b
  %3 = alloca i32, align 4      ; i
  %4 = alloca i32, align 4      ; n
  %5 = alloca i32, align 4      ; t
  %6 = alloca i32, align 4      ; 临时输入变量

  ; 初始化局部变量
  store i32 0, ptr %1, align 4  ; store 0 -> a
  store i32 0, ptr %2, align 4  ; store 0 -> b
  store i32 1, ptr %3, align 4  ; store 1 -> i
  store i32 1, ptr %4, align 4  ; store 1 -> n (后续用 scanf 覆盖)

  ; -----------------------------
  ; scanf 输入 n
  ; -----------------------------
  %7 = call i32 (i8*, ...) @__isoc99_scanf(
         i8* noundef getelementptr inbounds ([3 x i8], ptr @.str, i64 0, i64 0),
         ptr %6
       )

  ; 输出 a 和 b
  %8  = load i32, ptr %2, align 4
  %9  = call i32 (i8*, ...) @printf(
          i8* noundef getelementptr inbounds ([4 x i8], ptr @.str.1, i64 0, i64 0),
          i32 noundef %8
        )
  %10 = load i32, ptr %3, align 4
  %11 = call i32 (i8*, ...) @printf(
           i8* noundef getelementptr inbounds ([4 x i8], ptr @.str.1, i64 0, i64 0),
           i32 noundef %10
         )

  ; -----------------------------
  ; 循环入口
  ; -----------------------------
  br label %12

12:                                               ; preds = %16, %0
  %13 = load i32, ptr %4, align 4    ; n
  %14 = load i32, ptr %6, align 4    ; 临时输入
  %15 = icmp slt i32 %13, %14        ; i<n ?
  br i1 %15, label %16, label %26    ; 条件跳转

16:                                               ; preds = %12
  %17 = load i32, ptr %3, align 4
  store i32 %17, ptr %5, align 4      ; t = i
  %18 = load i32, ptr %2, align 4
  %19 = load i32, ptr %3, align 4
  %20 = add nsw i32 %18, %19
  store i32 %20, ptr %3, align 4     ; i = a+b
  %21 = load i32, ptr %3, align 4
  %22 = call i32 (i8*, ...) @printf(
           i8* noundef getelementptr inbounds ([4 x i8], ptr @.str.1, i64 0, i64 0),
           i32 noundef %21
         )
  %23 = load i32, ptr %5, align 4
  store i32 %23, ptr %2, align 4     ; b = t
  %24 = load i32, ptr %4, align 4
  %25 = add nsw i32 %24, 1
  store i32 %25, ptr %4, align 4     ; i++
  br label %12, !llvm.loop !6        ; 循环回到头部

26:                                               ; preds = %12
  ret i32 0
}

; -----------------------------
; 外部函数声明
; -----------------------------
declare i32 @__isoc99_scanf(i8* noundef, ...) #1
declare i32 @printf(i8* noundef, ...) #1

; -----------------------------
; 函数/模块属性
; -----------------------------
attributes #0 = { noinline nounwind optnone uwtable
                  "frame-pointer"="all"
                  "min-legal-vector-width"="0"
                  "no-trapping-math"="true"
                  "stack-protector-buffer-size"="8"
                  "target-cpu"="x86-64"
                  "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87"
                  "tune-cpu"="generic"
                }

attributes #1 = { "frame-pointer"="all"
                  "no-trapping-math"="true"
                  "stack-protector-buffer-size"="8"
                  "target-cpu"="x86-64"
                  "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87"
                  "tune-cpu"="generic"
                }

; -----------------------------
; 元数据
; -----------------------------
!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}

