# This file was generated, do not modify it. # hide
bit_reverse(::Val{9}, num) = begin
  num = ((num&0x1e0)>>5)|(num&0x010)|((num&0x00f)<<5)
  num = ((num&0x18c)>>2)|(num&0x010)|((num&0x063)<<2)
  ((num&0x14a)>>1)|(num&0x010)|((num&0x0a5)<<1)
end