# This file was generated, do not modify it. # hide
bit_reverse(::Val{10}, num) = begin
  num = ((num&0x3e0)>>5)|((num&0x01f)<<5)
  num = ((num&0x318)>>3)|(num&0x084)|((num&0x063)<<3)
  ((num&0x252)>>1)|(num&0x084)|((num&0x129)<<1)
end