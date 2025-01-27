; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdpal -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck --check-prefix=GFX9 %s
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdpal -mcpu=hawaii -verify-machineinstrs < %s | FileCheck --check-prefix=GFX7 %s
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdpal -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck --check-prefix=GFX10 %s

; FIXME:
; XUN: llc -global-isel -mtriple=amdgcn-amd-amdpal -mcpu=tahiti -verify-machineinstrs < %s | FileCheck --check-prefix=GFX6 %s

define <4 x i32> @load_lds_v4i32(<4 x i32> addrspace(3)* %ptr) {
; GFX9-LABEL: load_lds_v4i32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    ds_read_b128 v[0:3], v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: load_lds_v4i32:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    s_mov_b32 m0, -1
; GFX7-NEXT:    ds_read_b128 v[0:3], v0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: load_lds_v4i32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    ds_read_b128 v[0:3], v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %load = load <4 x i32>, <4 x i32> addrspace(3)* %ptr
  ret <4 x i32> %load
}

define <4 x i32> @load_lds_v4i32_align1(<4 x i32> addrspace(3)* %ptr) {
; GFX9-LABEL: load_lds_v4i32_align1:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    ds_read_u8 v1, v0
; GFX9-NEXT:    ds_read_u8 v2, v0 offset:1
; GFX9-NEXT:    ds_read_u8 v4, v0 offset:2
; GFX9-NEXT:    ds_read_u8 v5, v0 offset:3
; GFX9-NEXT:    ds_read_u8 v6, v0 offset:4
; GFX9-NEXT:    ds_read_u8 v7, v0 offset:5
; GFX9-NEXT:    ds_read_u8 v8, v0 offset:6
; GFX9-NEXT:    ds_read_u8 v9, v0 offset:7
; GFX9-NEXT:    s_mov_b32 s5, 8
; GFX9-NEXT:    s_movk_i32 s4, 0xff
; GFX9-NEXT:    s_waitcnt lgkmcnt(6)
; GFX9-NEXT:    v_lshlrev_b32_sdwa v2, s5, v2 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
; GFX9-NEXT:    v_and_or_b32 v1, v1, s4, v2
; GFX9-NEXT:    s_waitcnt lgkmcnt(5)
; GFX9-NEXT:    v_and_b32_e32 v2, s4, v4
; GFX9-NEXT:    s_waitcnt lgkmcnt(4)
; GFX9-NEXT:    v_and_b32_e32 v4, s4, v5
; GFX9-NEXT:    v_mov_b32_e32 v3, 0xff
; GFX9-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; GFX9-NEXT:    v_lshlrev_b32_e32 v4, 24, v4
; GFX9-NEXT:    v_or3_b32 v4, v1, v2, v4
; GFX9-NEXT:    s_waitcnt lgkmcnt(2)
; GFX9-NEXT:    v_lshlrev_b32_sdwa v1, s5, v7 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
; GFX9-NEXT:    s_waitcnt lgkmcnt(1)
; GFX9-NEXT:    v_and_b32_e32 v2, v8, v3
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_and_b32_e32 v5, v9, v3
; GFX9-NEXT:    v_and_or_b32 v1, v6, s4, v1
; GFX9-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; GFX9-NEXT:    v_lshlrev_b32_e32 v5, 24, v5
; GFX9-NEXT:    v_or3_b32 v1, v1, v2, v5
; GFX9-NEXT:    ds_read_u8 v2, v0 offset:8
; GFX9-NEXT:    ds_read_u8 v6, v0 offset:9
; GFX9-NEXT:    ds_read_u8 v7, v0 offset:10
; GFX9-NEXT:    ds_read_u8 v8, v0 offset:11
; GFX9-NEXT:    ds_read_u8 v9, v0 offset:12
; GFX9-NEXT:    ds_read_u8 v10, v0 offset:13
; GFX9-NEXT:    ds_read_u8 v11, v0 offset:14
; GFX9-NEXT:    ds_read_u8 v0, v0 offset:15
; GFX9-NEXT:    v_mov_b32_e32 v5, 8
; GFX9-NEXT:    s_waitcnt lgkmcnt(6)
; GFX9-NEXT:    v_lshlrev_b32_sdwa v6, v5, v6 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
; GFX9-NEXT:    v_and_or_b32 v2, v2, v3, v6
; GFX9-NEXT:    s_waitcnt lgkmcnt(5)
; GFX9-NEXT:    v_and_b32_e32 v6, v7, v3
; GFX9-NEXT:    s_waitcnt lgkmcnt(4)
; GFX9-NEXT:    v_and_b32_e32 v7, v8, v3
; GFX9-NEXT:    v_lshlrev_b32_e32 v6, 16, v6
; GFX9-NEXT:    v_lshlrev_b32_e32 v7, 24, v7
; GFX9-NEXT:    v_or3_b32 v2, v2, v6, v7
; GFX9-NEXT:    s_waitcnt lgkmcnt(2)
; GFX9-NEXT:    v_lshlrev_b32_sdwa v5, v5, v10 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
; GFX9-NEXT:    s_waitcnt lgkmcnt(1)
; GFX9-NEXT:    v_and_b32_e32 v6, v11, v3
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_and_b32_e32 v0, v0, v3
; GFX9-NEXT:    v_and_or_b32 v5, v9, v3, v5
; GFX9-NEXT:    v_lshlrev_b32_e32 v6, 16, v6
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 24, v0
; GFX9-NEXT:    v_or3_b32 v3, v5, v6, v0
; GFX9-NEXT:    v_mov_b32_e32 v0, v4
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: load_lds_v4i32_align1:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    s_mov_b32 m0, -1
; GFX7-NEXT:    s_movk_i32 s4, 0xff
; GFX7-NEXT:    ds_read_u8 v1, v0
; GFX7-NEXT:    ds_read_u8 v2, v0 offset:1
; GFX7-NEXT:    ds_read_u8 v4, v0 offset:2
; GFX7-NEXT:    ds_read_u8 v5, v0 offset:3
; GFX7-NEXT:    ds_read_u8 v6, v0 offset:4
; GFX7-NEXT:    ds_read_u8 v7, v0 offset:5
; GFX7-NEXT:    ds_read_u8 v8, v0 offset:6
; GFX7-NEXT:    ds_read_u8 v9, v0 offset:7
; GFX7-NEXT:    s_waitcnt lgkmcnt(6)
; GFX7-NEXT:    v_and_b32_e32 v2, s4, v2
; GFX7-NEXT:    v_and_b32_e32 v1, s4, v1
; GFX7-NEXT:    v_lshlrev_b32_e32 v2, 8, v2
; GFX7-NEXT:    v_or_b32_e32 v1, v1, v2
; GFX7-NEXT:    s_waitcnt lgkmcnt(5)
; GFX7-NEXT:    v_and_b32_e32 v2, s4, v4
; GFX7-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; GFX7-NEXT:    v_or_b32_e32 v1, v1, v2
; GFX7-NEXT:    s_waitcnt lgkmcnt(4)
; GFX7-NEXT:    v_and_b32_e32 v2, s4, v5
; GFX7-NEXT:    v_mov_b32_e32 v3, 0xff
; GFX7-NEXT:    v_lshlrev_b32_e32 v2, 24, v2
; GFX7-NEXT:    v_or_b32_e32 v4, v1, v2
; GFX7-NEXT:    s_waitcnt lgkmcnt(2)
; GFX7-NEXT:    v_and_b32_e32 v2, v7, v3
; GFX7-NEXT:    v_and_b32_e32 v1, s4, v6
; GFX7-NEXT:    v_lshlrev_b32_e32 v2, 8, v2
; GFX7-NEXT:    v_or_b32_e32 v1, v1, v2
; GFX7-NEXT:    s_waitcnt lgkmcnt(1)
; GFX7-NEXT:    v_and_b32_e32 v2, v8, v3
; GFX7-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; GFX7-NEXT:    v_or_b32_e32 v1, v1, v2
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_and_b32_e32 v2, v9, v3
; GFX7-NEXT:    v_lshlrev_b32_e32 v2, 24, v2
; GFX7-NEXT:    v_or_b32_e32 v1, v1, v2
; GFX7-NEXT:    ds_read_u8 v2, v0 offset:8
; GFX7-NEXT:    ds_read_u8 v5, v0 offset:9
; GFX7-NEXT:    ds_read_u8 v6, v0 offset:10
; GFX7-NEXT:    ds_read_u8 v7, v0 offset:11
; GFX7-NEXT:    ds_read_u8 v8, v0 offset:12
; GFX7-NEXT:    ds_read_u8 v9, v0 offset:13
; GFX7-NEXT:    ds_read_u8 v10, v0 offset:14
; GFX7-NEXT:    ds_read_u8 v0, v0 offset:15
; GFX7-NEXT:    s_waitcnt lgkmcnt(6)
; GFX7-NEXT:    v_and_b32_e32 v5, v5, v3
; GFX7-NEXT:    v_and_b32_e32 v2, v2, v3
; GFX7-NEXT:    v_lshlrev_b32_e32 v5, 8, v5
; GFX7-NEXT:    v_or_b32_e32 v2, v2, v5
; GFX7-NEXT:    s_waitcnt lgkmcnt(5)
; GFX7-NEXT:    v_and_b32_e32 v5, v6, v3
; GFX7-NEXT:    v_lshlrev_b32_e32 v5, 16, v5
; GFX7-NEXT:    v_or_b32_e32 v2, v2, v5
; GFX7-NEXT:    s_waitcnt lgkmcnt(4)
; GFX7-NEXT:    v_and_b32_e32 v5, v7, v3
; GFX7-NEXT:    v_lshlrev_b32_e32 v5, 24, v5
; GFX7-NEXT:    s_waitcnt lgkmcnt(2)
; GFX7-NEXT:    v_and_b32_e32 v6, v9, v3
; GFX7-NEXT:    v_or_b32_e32 v2, v2, v5
; GFX7-NEXT:    v_and_b32_e32 v5, v8, v3
; GFX7-NEXT:    v_lshlrev_b32_e32 v6, 8, v6
; GFX7-NEXT:    v_or_b32_e32 v5, v5, v6
; GFX7-NEXT:    s_waitcnt lgkmcnt(1)
; GFX7-NEXT:    v_and_b32_e32 v6, v10, v3
; GFX7-NEXT:    v_lshlrev_b32_e32 v6, 16, v6
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_and_b32_e32 v0, v0, v3
; GFX7-NEXT:    v_or_b32_e32 v5, v5, v6
; GFX7-NEXT:    v_lshlrev_b32_e32 v0, 24, v0
; GFX7-NEXT:    v_or_b32_e32 v3, v5, v0
; GFX7-NEXT:    v_mov_b32_e32 v0, v4
; GFX7-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: load_lds_v4i32_align1:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    ds_read_u8 v1, v0 offset:1
; GFX10-NEXT:    ds_read_u8 v2, v0 offset:2
; GFX10-NEXT:    ds_read_u8 v3, v0 offset:3
; GFX10-NEXT:    ds_read_u8 v4, v0 offset:5
; GFX10-NEXT:    ds_read_u8 v5, v0 offset:6
; GFX10-NEXT:    ds_read_u8 v6, v0 offset:7
; GFX10-NEXT:    ds_read_u8 v7, v0 offset:9
; GFX10-NEXT:    ds_read_u8 v8, v0
; GFX10-NEXT:    ds_read_u8 v9, v0 offset:4
; GFX10-NEXT:    ds_read_u8 v10, v0 offset:8
; GFX10-NEXT:    ds_read_u8 v12, v0 offset:10
; GFX10-NEXT:    ds_read_u8 v13, v0 offset:11
; GFX10-NEXT:    ds_read_u8 v14, v0 offset:12
; GFX10-NEXT:    ds_read_u8 v15, v0 offset:13
; GFX10-NEXT:    ds_read_u8 v16, v0 offset:14
; GFX10-NEXT:    ds_read_u8 v0, v0 offset:15
; GFX10-NEXT:    v_mov_b32_e32 v17, 8
; GFX10-NEXT:    s_mov_b32 s5, 8
; GFX10-NEXT:    v_mov_b32_e32 v11, 0xff
; GFX10-NEXT:    s_movk_i32 s4, 0xff
; GFX10-NEXT:    s_waitcnt lgkmcnt(15)
; GFX10-NEXT:    v_lshlrev_b32_sdwa v1, s5, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
; GFX10-NEXT:    s_waitcnt lgkmcnt(14)
; GFX10-NEXT:    v_and_b32_e32 v2, s4, v2
; GFX10-NEXT:    s_waitcnt lgkmcnt(13)
; GFX10-NEXT:    v_and_b32_e32 v3, s4, v3
; GFX10-NEXT:    s_waitcnt lgkmcnt(12)
; GFX10-NEXT:    v_lshlrev_b32_sdwa v4, s5, v4 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
; GFX10-NEXT:    s_waitcnt lgkmcnt(11)
; GFX10-NEXT:    v_and_b32_e32 v5, v5, v11
; GFX10-NEXT:    s_waitcnt lgkmcnt(10)
; GFX10-NEXT:    v_and_b32_e32 v6, v6, v11
; GFX10-NEXT:    s_waitcnt lgkmcnt(9)
; GFX10-NEXT:    v_lshlrev_b32_sdwa v7, v17, v7 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
; GFX10-NEXT:    s_waitcnt lgkmcnt(8)
; GFX10-NEXT:    v_and_or_b32 v1, v8, s4, v1
; GFX10-NEXT:    s_waitcnt lgkmcnt(7)
; GFX10-NEXT:    v_and_or_b32 v4, v9, s4, v4
; GFX10-NEXT:    s_waitcnt lgkmcnt(5)
; GFX10-NEXT:    v_and_b32_e32 v8, v12, v11
; GFX10-NEXT:    s_waitcnt lgkmcnt(4)
; GFX10-NEXT:    v_and_b32_e32 v9, v13, v11
; GFX10-NEXT:    v_and_or_b32 v7, v10, v11, v7
; GFX10-NEXT:    s_waitcnt lgkmcnt(2)
; GFX10-NEXT:    v_lshlrev_b32_sdwa v10, v17, v15 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
; GFX10-NEXT:    s_waitcnt lgkmcnt(1)
; GFX10-NEXT:    v_and_b32_e32 v12, v16, v11
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_and_b32_e32 v0, v0, v11
; GFX10-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; GFX10-NEXT:    v_lshlrev_b32_e32 v3, 24, v3
; GFX10-NEXT:    v_lshlrev_b32_e32 v5, 16, v5
; GFX10-NEXT:    v_lshlrev_b32_e32 v6, 24, v6
; GFX10-NEXT:    v_lshlrev_b32_e32 v8, 16, v8
; GFX10-NEXT:    v_lshlrev_b32_e32 v9, 24, v9
; GFX10-NEXT:    v_and_or_b32 v10, v14, v11, v10
; GFX10-NEXT:    v_lshlrev_b32_e32 v11, 16, v12
; GFX10-NEXT:    v_lshlrev_b32_e32 v12, 24, v0
; GFX10-NEXT:    v_or3_b32 v0, v1, v2, v3
; GFX10-NEXT:    v_or3_b32 v1, v4, v5, v6
; GFX10-NEXT:    v_or3_b32 v2, v7, v8, v9
; GFX10-NEXT:    v_or3_b32 v3, v10, v11, v12
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %load = load <4 x i32>, <4 x i32> addrspace(3)* %ptr, align 1
  ret <4 x i32> %load
}

define <4 x i32> @load_lds_v4i32_align2(<4 x i32> addrspace(3)* %ptr) {
; GFX9-LABEL: load_lds_v4i32_align2:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    s_mov_b32 s4, 0xffff
; GFX9-NEXT:    ds_read_u16 v1, v0
; GFX9-NEXT:    ds_read_u16 v2, v0 offset:2
; GFX9-NEXT:    ds_read_u16 v3, v0 offset:4
; GFX9-NEXT:    ds_read_u16 v4, v0 offset:6
; GFX9-NEXT:    ds_read_u16 v5, v0 offset:8
; GFX9-NEXT:    ds_read_u16 v6, v0 offset:10
; GFX9-NEXT:    ds_read_u16 v7, v0 offset:12
; GFX9-NEXT:    ds_read_u16 v8, v0 offset:14
; GFX9-NEXT:    s_waitcnt lgkmcnt(6)
; GFX9-NEXT:    v_and_b32_e32 v0, s4, v2
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 16, v0
; GFX9-NEXT:    v_and_or_b32 v0, v1, s4, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(4)
; GFX9-NEXT:    v_and_b32_e32 v1, s4, v4
; GFX9-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; GFX9-NEXT:    v_and_or_b32 v1, v3, s4, v1
; GFX9-NEXT:    s_waitcnt lgkmcnt(2)
; GFX9-NEXT:    v_and_b32_e32 v2, s4, v6
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_and_b32_e32 v3, s4, v8
; GFX9-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; GFX9-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; GFX9-NEXT:    v_and_or_b32 v2, v5, s4, v2
; GFX9-NEXT:    v_and_or_b32 v3, v7, s4, v3
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: load_lds_v4i32_align2:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    s_mov_b32 m0, -1
; GFX7-NEXT:    ds_read_u16 v1, v0
; GFX7-NEXT:    ds_read_u16 v2, v0 offset:2
; GFX7-NEXT:    ds_read_u16 v3, v0 offset:4
; GFX7-NEXT:    ds_read_u16 v4, v0 offset:6
; GFX7-NEXT:    ds_read_u16 v5, v0 offset:8
; GFX7-NEXT:    ds_read_u16 v6, v0 offset:10
; GFX7-NEXT:    ds_read_u16 v7, v0 offset:12
; GFX7-NEXT:    ds_read_u16 v8, v0 offset:14
; GFX7-NEXT:    s_mov_b32 s4, 0xffff
; GFX7-NEXT:    s_waitcnt lgkmcnt(7)
; GFX7-NEXT:    v_and_b32_e32 v0, s4, v1
; GFX7-NEXT:    s_waitcnt lgkmcnt(6)
; GFX7-NEXT:    v_and_b32_e32 v1, s4, v2
; GFX7-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; GFX7-NEXT:    s_waitcnt lgkmcnt(4)
; GFX7-NEXT:    v_and_b32_e32 v2, s4, v4
; GFX7-NEXT:    v_or_b32_e32 v0, v0, v1
; GFX7-NEXT:    v_and_b32_e32 v1, s4, v3
; GFX7-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; GFX7-NEXT:    s_waitcnt lgkmcnt(2)
; GFX7-NEXT:    v_and_b32_e32 v3, s4, v6
; GFX7-NEXT:    v_or_b32_e32 v1, v1, v2
; GFX7-NEXT:    v_and_b32_e32 v2, s4, v5
; GFX7-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_and_b32_e32 v4, 0xffff, v8
; GFX7-NEXT:    v_or_b32_e32 v2, v2, v3
; GFX7-NEXT:    v_and_b32_e32 v3, s4, v7
; GFX7-NEXT:    v_lshlrev_b32_e32 v4, 16, v4
; GFX7-NEXT:    v_or_b32_e32 v3, v3, v4
; GFX7-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: load_lds_v4i32_align2:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    ds_read_u16 v1, v0 offset:2
; GFX10-NEXT:    ds_read_u16 v2, v0 offset:6
; GFX10-NEXT:    ds_read_u16 v3, v0 offset:10
; GFX10-NEXT:    ds_read_u16 v4, v0 offset:14
; GFX10-NEXT:    ds_read_u16 v5, v0
; GFX10-NEXT:    ds_read_u16 v6, v0 offset:4
; GFX10-NEXT:    ds_read_u16 v7, v0 offset:8
; GFX10-NEXT:    ds_read_u16 v8, v0 offset:12
; GFX10-NEXT:    s_mov_b32 s4, 0xffff
; GFX10-NEXT:    s_waitcnt lgkmcnt(7)
; GFX10-NEXT:    v_and_b32_e32 v0, s4, v1
; GFX10-NEXT:    s_waitcnt lgkmcnt(6)
; GFX10-NEXT:    v_and_b32_e32 v1, s4, v2
; GFX10-NEXT:    s_waitcnt lgkmcnt(5)
; GFX10-NEXT:    v_and_b32_e32 v2, s4, v3
; GFX10-NEXT:    s_waitcnt lgkmcnt(4)
; GFX10-NEXT:    v_and_b32_e32 v3, s4, v4
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 16, v0
; GFX10-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; GFX10-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; GFX10-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; GFX10-NEXT:    s_waitcnt lgkmcnt(3)
; GFX10-NEXT:    v_and_or_b32 v0, v5, s4, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(2)
; GFX10-NEXT:    v_and_or_b32 v1, v6, s4, v1
; GFX10-NEXT:    s_waitcnt lgkmcnt(1)
; GFX10-NEXT:    v_and_or_b32 v2, v7, s4, v2
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_and_or_b32 v3, v8, s4, v3
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %load = load <4 x i32>, <4 x i32> addrspace(3)* %ptr, align 2
  ret <4 x i32> %load
}

define <4 x i32> @load_lds_v4i32_align4(<4 x i32> addrspace(3)* %ptr) {
; GFX9-LABEL: load_lds_v4i32_align4:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v2, v0
; GFX9-NEXT:    ds_read2_b32 v[0:1], v0 offset1:1
; GFX9-NEXT:    ds_read2_b32 v[2:3], v2 offset0:2 offset1:3
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: load_lds_v4i32_align4:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v2, v0
; GFX7-NEXT:    s_mov_b32 m0, -1
; GFX7-NEXT:    ds_read2_b32 v[0:1], v0 offset1:1
; GFX7-NEXT:    ds_read2_b32 v[2:3], v2 offset0:2 offset1:3
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: load_lds_v4i32_align4:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_mov_b32_e32 v2, v0
; GFX10-NEXT:    ds_read2_b32 v[0:1], v0 offset1:1
; GFX10-NEXT:    ds_read2_b32 v[2:3], v2 offset0:2 offset1:3
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %load = load <4 x i32>, <4 x i32> addrspace(3)* %ptr, align 4
  ret <4 x i32> %load
}

define <4 x i32> @load_lds_v4i32_align8(<4 x i32> addrspace(3)* %ptr) {
; GFX9-LABEL: load_lds_v4i32_align8:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    ds_read2_b64 v[0:3], v0 offset1:1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: load_lds_v4i32_align8:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    s_mov_b32 m0, -1
; GFX7-NEXT:    ds_read2_b64 v[0:3], v0 offset1:1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: load_lds_v4i32_align8:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    ds_read2_b64 v[0:3], v0 offset1:1
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %load = load <4 x i32>, <4 x i32> addrspace(3)* %ptr, align 8
  ret <4 x i32> %load
}

define <4 x i32> @load_lds_v4i32_align16(<4 x i32> addrspace(3)* %ptr) {
; GFX9-LABEL: load_lds_v4i32_align16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    ds_read_b128 v[0:3], v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: load_lds_v4i32_align16:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    s_mov_b32 m0, -1
; GFX7-NEXT:    ds_read_b128 v[0:3], v0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: load_lds_v4i32_align16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    ds_read_b128 v[0:3], v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %load = load <4 x i32>, <4 x i32> addrspace(3)* %ptr, align 16
  ret <4 x i32> %load
}
