# Structure

## Fetch

### PC

选择PC+8、PC+4还是Branch/Jump

暂时不考虑Jump/bpb优化，实现最普通的PC选择，

### Icache

根据PC输出64位的指令信号  
如果遇到TLB边界只能输出32位需要返回一个exception信号

## Decode

### Maindec/ALUdec

解码，可以参考Pipeline的

### Control

判断指令A和指令B的依赖关系

AB只能有一条访存指令

A分支跳转时B无效/B遇到TLB边界时无效

其余指令可以暂时不考虑（指令集可以暂不支持）

## Execute

A先B后，数据后推（类似Pipeline中的Forward）

剩余部分可以参考Pipeline

## Memory

只有一条指令会用到，用选择电路选择后可参照Pipeline

## WriteBack

可直接参照Pipeline，



