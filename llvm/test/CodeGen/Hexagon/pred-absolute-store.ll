; RUN: llc -march=hexagon -mcpu=hexagonv4 < %s | FileCheck %s
; Check that we are able to predicate instructions with abosolute
; addressing mode.

; CHECK: if{{ *}}(p{{[0-3]+}}){{ *}}memw(##gvar){{ *}}={{ *}}r{{[0-9]+}}

@gvar = external global i32
define i32 @test2(i32 %a, i32 %b) nounwind {
entry:
  %cmp = icmp eq i32 %a, %b
  br i1 %cmp, label %if.then, label %if.end

if.then:
  store i32 %a, i32* @gvar, align 4
  br label %if.end

if.end:
  ret i32 %b
}
