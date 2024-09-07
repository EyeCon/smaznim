{.compile:"smaz.c".}
proc smaz_compress*(inbuffer: cstring; len: csize_t; outbuffer: cstring;
                        bufsize: csize_t): csize_t {.importc: "smaz_compress", header: "smaz.h".}
proc smaz_decompress*(inbuffer: cstring; len: csize_t; outbuffer: cstring;
                        bufsize: csize_t): csize_t {.importc: "smaz_decompress", header: "smaz.h".}


proc compress*(s: openArray[char]): string =
  let
    inBufSize = s.len.csize_t
    outBufSize = inBufSize
  var
    inBuf = newString(inBufSize)
    outBuf = newString(outBufSize)
  prepareMutation(inBuf)
  copyMem(inBuf[0].addr, s[0].addr, s.len)
  let outSize = smaz_compress(inBuf, inBufSize, outBuf, outBufSize)
  outBuf.setlen(outSize)
  return outBuf

proc decompress*(s: openArray[char]): string =
  let
    inBufSize = s.len.csize_t
    outBufSize = inBufSize * 2
  var
    inBuf = newString(inBufSize)
    outBuf = newString(outBufSize)
  prepareMutation(inBuf)
  copyMem(inBuf[0].addr, s[0].addr, s.len)
  let outSize = smaz_decompress(inBuf, inBufSize, outBuf, outBufSize)
  outBuf.setlen(outSize)
  return outBuf
