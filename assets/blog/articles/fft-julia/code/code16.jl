# This file was generated, do not modify it. # hide
bit_reverse(::Val{31}, num) = begin
bit_reverse(Val(15), num&0x7fff0000>>16)| (num&0x00008000) |(bit_reverse(Val(7),num&0x00007fff)<<16)
end
bit_reverse(::Val{15}, num) = bit_reverse(Val(7), (num&0x7f00)>>8)| (num&0x0080)|(bit_reverse(Val(7),num&0x007f)<<8)
bit_reverse(::Val{7}, num) = bit_reverse(Val(3), (num&0x70)>>4 )| (num&0x08) |(bit_reverse(Val(3), num&0x07)<<4)