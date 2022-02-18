# This file was generated, do not modify it. # hide
bit_reverse(::Val{64}, num) = bit_reverse(Val(32), (num&0xffffffff00000000)>>32)|(bit_reverse(Val(32), num&0x00000000ffffff)<<32)
bit_reverse(::Val{32}, num) = bit_reverse(Val(16), (num&0xffff0000)>>16)|(bit_reverse(Val(16), num&0x0000ffff)<<16)
bit_reverse(::Val{16}, num) = bit_reverse(Val(8), (num&0xff00)>>8)|(bit_reverse(Val(8), num&0x00ff)<<8)
bit_reverse(::Val{8}, num) = bit_reverse(Val(4), (num&0xf0)>>4)|(bit_reverse(Val(4), num&0x0f)<<4)
bit_reverse(::Val{4}, num) =bit_reverse(Val(2), (num&0xc)>>2)|(bit_reverse(Val(2), num&0x3)<<2)
bit_reverse(::Val{3}, num) = ((num&0x1)<<2)|((num&0x4)>>2)|(num&0x2)
bit_reverse(::Val{2}, num) = ((num&0x2)>>1 )|((num&0x1)<<1)
bit_reverse(::Val{1}, num) = num