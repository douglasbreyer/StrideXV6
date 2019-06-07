
kernel:     formato de ficheiro elf32-i386


Desmontagem da secção .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 50 c6 10 80       	mov    $0x8010c650,%esp
8010002d:	b8 98 38 10 80       	mov    $0x80103898,%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	83 ec 08             	sub    $0x8,%esp
8010003d:	68 14 87 10 80       	push   $0x80108714
80100042:	68 60 c6 10 80       	push   $0x8010c660
80100047:	e8 5e 51 00 00       	call   801051aa <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 70 05 11 80 64 	movl   $0x80110564,0x80110570
80100056:	05 11 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 74 05 11 80 64 	movl   $0x80110564,0x80110574
80100060:	05 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 94 c6 10 80 	movl   $0x8010c694,-0xc(%ebp)
8010006a:	eb 3a                	jmp    801000a6 <binit+0x72>
    b->next = bcache.head.next;
8010006c:	8b 15 74 05 11 80    	mov    0x80110574,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 0c 64 05 11 80 	movl   $0x80110564,0xc(%eax)
    b->dev = -1;
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008c:	a1 74 05 11 80       	mov    0x80110574,%eax
80100091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100094:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009a:	a3 74 05 11 80       	mov    %eax,0x80110574
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009f:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a6:	b8 64 05 11 80       	mov    $0x80110564,%eax
801000ab:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000ae:	72 bc                	jb     8010006c <binit+0x38>
  }
}
801000b0:	90                   	nop
801000b1:	c9                   	leave  
801000b2:	c3                   	ret    

801000b3 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint blockno)
{
801000b3:	55                   	push   %ebp
801000b4:	89 e5                	mov    %esp,%ebp
801000b6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b9:	83 ec 0c             	sub    $0xc,%esp
801000bc:	68 60 c6 10 80       	push   $0x8010c660
801000c1:	e8 06 51 00 00       	call   801051cc <acquire>
801000c6:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c9:	a1 74 05 11 80       	mov    0x80110574,%eax
801000ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000d1:	eb 67                	jmp    8010013a <bget+0x87>
    if(b->dev == dev && b->blockno == blockno){
801000d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d6:	8b 40 04             	mov    0x4(%eax),%eax
801000d9:	39 45 08             	cmp    %eax,0x8(%ebp)
801000dc:	75 53                	jne    80100131 <bget+0x7e>
801000de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e1:	8b 40 08             	mov    0x8(%eax),%eax
801000e4:	39 45 0c             	cmp    %eax,0xc(%ebp)
801000e7:	75 48                	jne    80100131 <bget+0x7e>
      if(!(b->flags & B_BUSY)){
801000e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ec:	8b 00                	mov    (%eax),%eax
801000ee:	83 e0 01             	and    $0x1,%eax
801000f1:	85 c0                	test   %eax,%eax
801000f3:	75 27                	jne    8010011c <bget+0x69>
        b->flags |= B_BUSY;
801000f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f8:	8b 00                	mov    (%eax),%eax
801000fa:	83 c8 01             	or     $0x1,%eax
801000fd:	89 c2                	mov    %eax,%edx
801000ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100102:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
80100104:	83 ec 0c             	sub    $0xc,%esp
80100107:	68 60 c6 10 80       	push   $0x8010c660
8010010c:	e8 22 51 00 00       	call   80105233 <release>
80100111:	83 c4 10             	add    $0x10,%esp
        return b;
80100114:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100117:	e9 98 00 00 00       	jmp    801001b4 <bget+0x101>
      }
      sleep(b, &bcache.lock);
8010011c:	83 ec 08             	sub    $0x8,%esp
8010011f:	68 60 c6 10 80       	push   $0x8010c660
80100124:	ff 75 f4             	pushl  -0xc(%ebp)
80100127:	e8 94 4d 00 00       	call   80104ec0 <sleep>
8010012c:	83 c4 10             	add    $0x10,%esp
      goto loop;
8010012f:	eb 98                	jmp    801000c9 <bget+0x16>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100131:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100134:	8b 40 10             	mov    0x10(%eax),%eax
80100137:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010013a:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
80100141:	75 90                	jne    801000d3 <bget+0x20>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100143:	a1 70 05 11 80       	mov    0x80110570,%eax
80100148:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010014b:	eb 51                	jmp    8010019e <bget+0xeb>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
8010014d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100150:	8b 00                	mov    (%eax),%eax
80100152:	83 e0 01             	and    $0x1,%eax
80100155:	85 c0                	test   %eax,%eax
80100157:	75 3c                	jne    80100195 <bget+0xe2>
80100159:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015c:	8b 00                	mov    (%eax),%eax
8010015e:	83 e0 04             	and    $0x4,%eax
80100161:	85 c0                	test   %eax,%eax
80100163:	75 30                	jne    80100195 <bget+0xe2>
      b->dev = dev;
80100165:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100168:	8b 55 08             	mov    0x8(%ebp),%edx
8010016b:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
8010016e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100171:	8b 55 0c             	mov    0xc(%ebp),%edx
80100174:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
80100177:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010017a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100180:	83 ec 0c             	sub    $0xc,%esp
80100183:	68 60 c6 10 80       	push   $0x8010c660
80100188:	e8 a6 50 00 00       	call   80105233 <release>
8010018d:	83 c4 10             	add    $0x10,%esp
      return b;
80100190:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100193:	eb 1f                	jmp    801001b4 <bget+0x101>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100195:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100198:	8b 40 0c             	mov    0xc(%eax),%eax
8010019b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010019e:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
801001a5:	75 a6                	jne    8010014d <bget+0x9a>
    }
  }
  panic("bget: no buffers");
801001a7:	83 ec 0c             	sub    $0xc,%esp
801001aa:	68 1b 87 10 80       	push   $0x8010871b
801001af:	e8 b3 03 00 00       	call   80100567 <panic>
}
801001b4:	c9                   	leave  
801001b5:	c3                   	ret    

801001b6 <bread>:

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801001b6:	55                   	push   %ebp
801001b7:	89 e5                	mov    %esp,%ebp
801001b9:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, blockno);
801001bc:	83 ec 08             	sub    $0x8,%esp
801001bf:	ff 75 0c             	pushl  0xc(%ebp)
801001c2:	ff 75 08             	pushl  0x8(%ebp)
801001c5:	e8 e9 fe ff ff       	call   801000b3 <bget>
801001ca:	83 c4 10             	add    $0x10,%esp
801001cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID)) {
801001d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d3:	8b 00                	mov    (%eax),%eax
801001d5:	83 e0 02             	and    $0x2,%eax
801001d8:	85 c0                	test   %eax,%eax
801001da:	75 0e                	jne    801001ea <bread+0x34>
    iderw(b);
801001dc:	83 ec 0c             	sub    $0xc,%esp
801001df:	ff 75 f4             	pushl  -0xc(%ebp)
801001e2:	e8 2a 27 00 00       	call   80102911 <iderw>
801001e7:	83 c4 10             	add    $0x10,%esp
  }
  return b;
801001ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001ed:	c9                   	leave  
801001ee:	c3                   	ret    

801001ef <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001ef:	55                   	push   %ebp
801001f0:	89 e5                	mov    %esp,%ebp
801001f2:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
801001f5:	8b 45 08             	mov    0x8(%ebp),%eax
801001f8:	8b 00                	mov    (%eax),%eax
801001fa:	83 e0 01             	and    $0x1,%eax
801001fd:	85 c0                	test   %eax,%eax
801001ff:	75 0d                	jne    8010020e <bwrite+0x1f>
    panic("bwrite");
80100201:	83 ec 0c             	sub    $0xc,%esp
80100204:	68 2c 87 10 80       	push   $0x8010872c
80100209:	e8 59 03 00 00       	call   80100567 <panic>
  b->flags |= B_DIRTY;
8010020e:	8b 45 08             	mov    0x8(%ebp),%eax
80100211:	8b 00                	mov    (%eax),%eax
80100213:	83 c8 04             	or     $0x4,%eax
80100216:	89 c2                	mov    %eax,%edx
80100218:	8b 45 08             	mov    0x8(%ebp),%eax
8010021b:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010021d:	83 ec 0c             	sub    $0xc,%esp
80100220:	ff 75 08             	pushl  0x8(%ebp)
80100223:	e8 e9 26 00 00       	call   80102911 <iderw>
80100228:	83 c4 10             	add    $0x10,%esp
}
8010022b:	90                   	nop
8010022c:	c9                   	leave  
8010022d:	c3                   	ret    

8010022e <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
8010022e:	55                   	push   %ebp
8010022f:	89 e5                	mov    %esp,%ebp
80100231:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100234:	8b 45 08             	mov    0x8(%ebp),%eax
80100237:	8b 00                	mov    (%eax),%eax
80100239:	83 e0 01             	and    $0x1,%eax
8010023c:	85 c0                	test   %eax,%eax
8010023e:	75 0d                	jne    8010024d <brelse+0x1f>
    panic("brelse");
80100240:	83 ec 0c             	sub    $0xc,%esp
80100243:	68 33 87 10 80       	push   $0x80108733
80100248:	e8 1a 03 00 00       	call   80100567 <panic>

  acquire(&bcache.lock);
8010024d:	83 ec 0c             	sub    $0xc,%esp
80100250:	68 60 c6 10 80       	push   $0x8010c660
80100255:	e8 72 4f 00 00       	call   801051cc <acquire>
8010025a:	83 c4 10             	add    $0x10,%esp

  b->next->prev = b->prev;
8010025d:	8b 45 08             	mov    0x8(%ebp),%eax
80100260:	8b 40 10             	mov    0x10(%eax),%eax
80100263:	8b 55 08             	mov    0x8(%ebp),%edx
80100266:	8b 52 0c             	mov    0xc(%edx),%edx
80100269:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
8010026c:	8b 45 08             	mov    0x8(%ebp),%eax
8010026f:	8b 40 0c             	mov    0xc(%eax),%eax
80100272:	8b 55 08             	mov    0x8(%ebp),%edx
80100275:	8b 52 10             	mov    0x10(%edx),%edx
80100278:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
8010027b:	8b 15 74 05 11 80    	mov    0x80110574,%edx
80100281:	8b 45 08             	mov    0x8(%ebp),%eax
80100284:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
80100287:	8b 45 08             	mov    0x8(%ebp),%eax
8010028a:	c7 40 0c 64 05 11 80 	movl   $0x80110564,0xc(%eax)
  bcache.head.next->prev = b;
80100291:	a1 74 05 11 80       	mov    0x80110574,%eax
80100296:	8b 55 08             	mov    0x8(%ebp),%edx
80100299:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
8010029c:	8b 45 08             	mov    0x8(%ebp),%eax
8010029f:	a3 74 05 11 80       	mov    %eax,0x80110574

  b->flags &= ~B_BUSY;
801002a4:	8b 45 08             	mov    0x8(%ebp),%eax
801002a7:	8b 00                	mov    (%eax),%eax
801002a9:	83 e0 fe             	and    $0xfffffffe,%eax
801002ac:	89 c2                	mov    %eax,%edx
801002ae:	8b 45 08             	mov    0x8(%ebp),%eax
801002b1:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801002b3:	83 ec 0c             	sub    $0xc,%esp
801002b6:	ff 75 08             	pushl  0x8(%ebp)
801002b9:	e8 f0 4c 00 00       	call   80104fae <wakeup>
801002be:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002c1:	83 ec 0c             	sub    $0xc,%esp
801002c4:	68 60 c6 10 80       	push   $0x8010c660
801002c9:	e8 65 4f 00 00       	call   80105233 <release>
801002ce:	83 c4 10             	add    $0x10,%esp
}
801002d1:	90                   	nop
801002d2:	c9                   	leave  
801002d3:	c3                   	ret    

801002d4 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002d4:	55                   	push   %ebp
801002d5:	89 e5                	mov    %esp,%ebp
801002d7:	83 ec 14             	sub    $0x14,%esp
801002da:	8b 45 08             	mov    0x8(%ebp),%eax
801002dd:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002e1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002e5:	89 c2                	mov    %eax,%edx
801002e7:	ec                   	in     (%dx),%al
801002e8:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002eb:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002ef:	c9                   	leave  
801002f0:	c3                   	ret    

801002f1 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002f1:	55                   	push   %ebp
801002f2:	89 e5                	mov    %esp,%ebp
801002f4:	83 ec 08             	sub    $0x8,%esp
801002f7:	8b 45 08             	mov    0x8(%ebp),%eax
801002fa:	8b 55 0c             	mov    0xc(%ebp),%edx
801002fd:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80100301:	89 d0                	mov    %edx,%eax
80100303:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100306:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010030a:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010030e:	ee                   	out    %al,(%dx)
}
8010030f:	90                   	nop
80100310:	c9                   	leave  
80100311:	c3                   	ret    

80100312 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100312:	55                   	push   %ebp
80100313:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80100315:	fa                   	cli    
}
80100316:	90                   	nop
80100317:	5d                   	pop    %ebp
80100318:	c3                   	ret    

80100319 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100319:	55                   	push   %ebp
8010031a:	89 e5                	mov    %esp,%ebp
8010031c:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010031f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100323:	74 1c                	je     80100341 <printint+0x28>
80100325:	8b 45 08             	mov    0x8(%ebp),%eax
80100328:	c1 e8 1f             	shr    $0x1f,%eax
8010032b:	0f b6 c0             	movzbl %al,%eax
8010032e:	89 45 10             	mov    %eax,0x10(%ebp)
80100331:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100335:	74 0a                	je     80100341 <printint+0x28>
    x = -xx;
80100337:	8b 45 08             	mov    0x8(%ebp),%eax
8010033a:	f7 d8                	neg    %eax
8010033c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010033f:	eb 06                	jmp    80100347 <printint+0x2e>
  else
    x = xx;
80100341:	8b 45 08             	mov    0x8(%ebp),%eax
80100344:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100347:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
8010034e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100351:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100354:	ba 00 00 00 00       	mov    $0x0,%edx
80100359:	f7 f1                	div    %ecx
8010035b:	89 d1                	mov    %edx,%ecx
8010035d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100360:	8d 50 01             	lea    0x1(%eax),%edx
80100363:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100366:	0f b6 91 04 90 10 80 	movzbl -0x7fef6ffc(%ecx),%edx
8010036d:	88 54 05 e0          	mov    %dl,-0x20(%ebp,%eax,1)
  }while((x /= base) != 0);
80100371:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100374:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100377:	ba 00 00 00 00       	mov    $0x0,%edx
8010037c:	f7 f1                	div    %ecx
8010037e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100381:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100385:	75 c7                	jne    8010034e <printint+0x35>

  if(sign)
80100387:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010038b:	74 2a                	je     801003b7 <printint+0x9e>
    buf[i++] = '-';
8010038d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100390:	8d 50 01             	lea    0x1(%eax),%edx
80100393:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100396:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
8010039b:	eb 1a                	jmp    801003b7 <printint+0x9e>
    consputc(buf[i]);
8010039d:	8d 55 e0             	lea    -0x20(%ebp),%edx
801003a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003a3:	01 d0                	add    %edx,%eax
801003a5:	0f b6 00             	movzbl (%eax),%eax
801003a8:	0f be c0             	movsbl %al,%eax
801003ab:	83 ec 0c             	sub    $0xc,%esp
801003ae:	50                   	push   %eax
801003af:	e8 e7 03 00 00       	call   8010079b <consputc>
801003b4:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
801003b7:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003bf:	79 dc                	jns    8010039d <printint+0x84>
}
801003c1:	90                   	nop
801003c2:	c9                   	leave  
801003c3:	c3                   	ret    

801003c4 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003c4:	55                   	push   %ebp
801003c5:	89 e5                	mov    %esp,%ebp
801003c7:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003ca:	a1 f4 b5 10 80       	mov    0x8010b5f4,%eax
801003cf:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003d2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003d6:	74 10                	je     801003e8 <cprintf+0x24>
    acquire(&cons.lock);
801003d8:	83 ec 0c             	sub    $0xc,%esp
801003db:	68 c0 b5 10 80       	push   $0x8010b5c0
801003e0:	e8 e7 4d 00 00       	call   801051cc <acquire>
801003e5:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003e8:	8b 45 08             	mov    0x8(%ebp),%eax
801003eb:	85 c0                	test   %eax,%eax
801003ed:	75 0d                	jne    801003fc <cprintf+0x38>
    panic("null fmt");
801003ef:	83 ec 0c             	sub    $0xc,%esp
801003f2:	68 3a 87 10 80       	push   $0x8010873a
801003f7:	e8 6b 01 00 00       	call   80100567 <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003fc:	8d 45 0c             	lea    0xc(%ebp),%eax
801003ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100402:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100409:	e9 1d 01 00 00       	jmp    8010052b <cprintf+0x167>
    if(c != '%'){
8010040e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100412:	74 13                	je     80100427 <cprintf+0x63>
      consputc(c);
80100414:	83 ec 0c             	sub    $0xc,%esp
80100417:	ff 75 e4             	pushl  -0x1c(%ebp)
8010041a:	e8 7c 03 00 00       	call   8010079b <consputc>
8010041f:	83 c4 10             	add    $0x10,%esp
      continue;
80100422:	e9 00 01 00 00       	jmp    80100527 <cprintf+0x163>
    }
    c = fmt[++i] & 0xff;
80100427:	8b 55 08             	mov    0x8(%ebp),%edx
8010042a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010042e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100431:	01 d0                	add    %edx,%eax
80100433:	0f b6 00             	movzbl (%eax),%eax
80100436:	0f be c0             	movsbl %al,%eax
80100439:	25 ff 00 00 00       	and    $0xff,%eax
8010043e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
80100441:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100445:	0f 84 02 01 00 00    	je     8010054d <cprintf+0x189>
8010044b:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
8010044f:	74 4c                	je     8010049d <cprintf+0xd9>
80100451:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
80100455:	7f 15                	jg     8010046c <cprintf+0xa8>
80100457:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
8010045b:	0f 84 9b 00 00 00    	je     801004fc <cprintf+0x138>
80100461:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
80100465:	74 16                	je     8010047d <cprintf+0xb9>
80100467:	e9 9f 00 00 00       	jmp    8010050b <cprintf+0x147>
8010046c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
80100470:	74 48                	je     801004ba <cprintf+0xf6>
80100472:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
80100476:	74 25                	je     8010049d <cprintf+0xd9>
80100478:	e9 8e 00 00 00       	jmp    8010050b <cprintf+0x147>
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
8010047d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100480:	8d 50 04             	lea    0x4(%eax),%edx
80100483:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100486:	8b 00                	mov    (%eax),%eax
80100488:	83 ec 04             	sub    $0x4,%esp
8010048b:	6a 01                	push   $0x1
8010048d:	6a 0a                	push   $0xa
8010048f:	50                   	push   %eax
80100490:	e8 84 fe ff ff       	call   80100319 <printint>
80100495:	83 c4 10             	add    $0x10,%esp
      break;
80100498:	e9 8a 00 00 00       	jmp    80100527 <cprintf+0x163>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010049d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004a0:	8d 50 04             	lea    0x4(%eax),%edx
801004a3:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004a6:	8b 00                	mov    (%eax),%eax
801004a8:	83 ec 04             	sub    $0x4,%esp
801004ab:	6a 00                	push   $0x0
801004ad:	6a 10                	push   $0x10
801004af:	50                   	push   %eax
801004b0:	e8 64 fe ff ff       	call   80100319 <printint>
801004b5:	83 c4 10             	add    $0x10,%esp
      break;
801004b8:	eb 6d                	jmp    80100527 <cprintf+0x163>
    case 's':
      if((s = (char*)*argp++) == 0)
801004ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004bd:	8d 50 04             	lea    0x4(%eax),%edx
801004c0:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004c3:	8b 00                	mov    (%eax),%eax
801004c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004c8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004cc:	75 22                	jne    801004f0 <cprintf+0x12c>
        s = "(null)";
801004ce:	c7 45 ec 43 87 10 80 	movl   $0x80108743,-0x14(%ebp)
      for(; *s; s++)
801004d5:	eb 19                	jmp    801004f0 <cprintf+0x12c>
        consputc(*s);
801004d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004da:	0f b6 00             	movzbl (%eax),%eax
801004dd:	0f be c0             	movsbl %al,%eax
801004e0:	83 ec 0c             	sub    $0xc,%esp
801004e3:	50                   	push   %eax
801004e4:	e8 b2 02 00 00       	call   8010079b <consputc>
801004e9:	83 c4 10             	add    $0x10,%esp
      for(; *s; s++)
801004ec:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004f3:	0f b6 00             	movzbl (%eax),%eax
801004f6:	84 c0                	test   %al,%al
801004f8:	75 dd                	jne    801004d7 <cprintf+0x113>
      break;
801004fa:	eb 2b                	jmp    80100527 <cprintf+0x163>
    case '%':
      consputc('%');
801004fc:	83 ec 0c             	sub    $0xc,%esp
801004ff:	6a 25                	push   $0x25
80100501:	e8 95 02 00 00       	call   8010079b <consputc>
80100506:	83 c4 10             	add    $0x10,%esp
      break;
80100509:	eb 1c                	jmp    80100527 <cprintf+0x163>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
8010050b:	83 ec 0c             	sub    $0xc,%esp
8010050e:	6a 25                	push   $0x25
80100510:	e8 86 02 00 00       	call   8010079b <consputc>
80100515:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100518:	83 ec 0c             	sub    $0xc,%esp
8010051b:	ff 75 e4             	pushl  -0x1c(%ebp)
8010051e:	e8 78 02 00 00       	call   8010079b <consputc>
80100523:	83 c4 10             	add    $0x10,%esp
      break;
80100526:	90                   	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100527:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010052b:	8b 55 08             	mov    0x8(%ebp),%edx
8010052e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100531:	01 d0                	add    %edx,%eax
80100533:	0f b6 00             	movzbl (%eax),%eax
80100536:	0f be c0             	movsbl %al,%eax
80100539:	25 ff 00 00 00       	and    $0xff,%eax
8010053e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100541:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100545:	0f 85 c3 fe ff ff    	jne    8010040e <cprintf+0x4a>
8010054b:	eb 01                	jmp    8010054e <cprintf+0x18a>
      break;
8010054d:	90                   	nop
    }
  }

  if(locking)
8010054e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100552:	74 10                	je     80100564 <cprintf+0x1a0>
    release(&cons.lock);
80100554:	83 ec 0c             	sub    $0xc,%esp
80100557:	68 c0 b5 10 80       	push   $0x8010b5c0
8010055c:	e8 d2 4c 00 00       	call   80105233 <release>
80100561:	83 c4 10             	add    $0x10,%esp
}
80100564:	90                   	nop
80100565:	c9                   	leave  
80100566:	c3                   	ret    

80100567 <panic>:

void
panic(char *s)
{
80100567:	55                   	push   %ebp
80100568:	89 e5                	mov    %esp,%ebp
8010056a:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];
  
  cli();
8010056d:	e8 a0 fd ff ff       	call   80100312 <cli>
  cons.locking = 0;
80100572:	c7 05 f4 b5 10 80 00 	movl   $0x0,0x8010b5f4
80100579:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
8010057c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100582:	0f b6 00             	movzbl (%eax),%eax
80100585:	0f b6 c0             	movzbl %al,%eax
80100588:	83 ec 08             	sub    $0x8,%esp
8010058b:	50                   	push   %eax
8010058c:	68 4a 87 10 80       	push   $0x8010874a
80100591:	e8 2e fe ff ff       	call   801003c4 <cprintf>
80100596:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
80100599:	8b 45 08             	mov    0x8(%ebp),%eax
8010059c:	83 ec 0c             	sub    $0xc,%esp
8010059f:	50                   	push   %eax
801005a0:	e8 1f fe ff ff       	call   801003c4 <cprintf>
801005a5:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801005a8:	83 ec 0c             	sub    $0xc,%esp
801005ab:	68 59 87 10 80       	push   $0x80108759
801005b0:	e8 0f fe ff ff       	call   801003c4 <cprintf>
801005b5:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005b8:	83 ec 08             	sub    $0x8,%esp
801005bb:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005be:	50                   	push   %eax
801005bf:	8d 45 08             	lea    0x8(%ebp),%eax
801005c2:	50                   	push   %eax
801005c3:	e8 bd 4c 00 00       	call   80105285 <getcallerpcs>
801005c8:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005d2:	eb 1c                	jmp    801005f0 <panic+0x89>
    cprintf(" %p", pcs[i]);
801005d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005d7:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005db:	83 ec 08             	sub    $0x8,%esp
801005de:	50                   	push   %eax
801005df:	68 5b 87 10 80       	push   $0x8010875b
801005e4:	e8 db fd ff ff       	call   801003c4 <cprintf>
801005e9:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005ec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005f0:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005f4:	7e de                	jle    801005d4 <panic+0x6d>
  panicked = 1; // freeze other CPU
801005f6:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
801005fd:	00 00 00 
  for(;;)
80100600:	eb fe                	jmp    80100600 <panic+0x99>

80100602 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
80100602:	55                   	push   %ebp
80100603:	89 e5                	mov    %esp,%ebp
80100605:	53                   	push   %ebx
80100606:	83 ec 14             	sub    $0x14,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
80100609:	6a 0e                	push   $0xe
8010060b:	68 d4 03 00 00       	push   $0x3d4
80100610:	e8 dc fc ff ff       	call   801002f1 <outb>
80100615:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
80100618:	68 d5 03 00 00       	push   $0x3d5
8010061d:	e8 b2 fc ff ff       	call   801002d4 <inb>
80100622:	83 c4 04             	add    $0x4,%esp
80100625:	0f b6 c0             	movzbl %al,%eax
80100628:	c1 e0 08             	shl    $0x8,%eax
8010062b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
8010062e:	6a 0f                	push   $0xf
80100630:	68 d4 03 00 00       	push   $0x3d4
80100635:	e8 b7 fc ff ff       	call   801002f1 <outb>
8010063a:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
8010063d:	68 d5 03 00 00       	push   $0x3d5
80100642:	e8 8d fc ff ff       	call   801002d4 <inb>
80100647:	83 c4 04             	add    $0x4,%esp
8010064a:	0f b6 c0             	movzbl %al,%eax
8010064d:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100650:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100654:	75 30                	jne    80100686 <cgaputc+0x84>
    pos += 80 - pos%80;
80100656:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100659:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010065e:	89 c8                	mov    %ecx,%eax
80100660:	f7 ea                	imul   %edx
80100662:	c1 fa 05             	sar    $0x5,%edx
80100665:	89 c8                	mov    %ecx,%eax
80100667:	c1 f8 1f             	sar    $0x1f,%eax
8010066a:	29 c2                	sub    %eax,%edx
8010066c:	89 d0                	mov    %edx,%eax
8010066e:	c1 e0 02             	shl    $0x2,%eax
80100671:	01 d0                	add    %edx,%eax
80100673:	c1 e0 04             	shl    $0x4,%eax
80100676:	29 c1                	sub    %eax,%ecx
80100678:	89 ca                	mov    %ecx,%edx
8010067a:	b8 50 00 00 00       	mov    $0x50,%eax
8010067f:	29 d0                	sub    %edx,%eax
80100681:	01 45 f4             	add    %eax,-0xc(%ebp)
80100684:	eb 38                	jmp    801006be <cgaputc+0xbc>
  else if(c == BACKSPACE){
80100686:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010068d:	75 0c                	jne    8010069b <cgaputc+0x99>
    if(pos > 0) --pos;
8010068f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100693:	7e 29                	jle    801006be <cgaputc+0xbc>
80100695:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100699:	eb 23                	jmp    801006be <cgaputc+0xbc>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010069b:	8b 45 08             	mov    0x8(%ebp),%eax
8010069e:	0f b6 c0             	movzbl %al,%eax
801006a1:	80 cc 07             	or     $0x7,%ah
801006a4:	89 c3                	mov    %eax,%ebx
801006a6:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
801006ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006af:	8d 50 01             	lea    0x1(%eax),%edx
801006b2:	89 55 f4             	mov    %edx,-0xc(%ebp)
801006b5:	01 c0                	add    %eax,%eax
801006b7:	01 c8                	add    %ecx,%eax
801006b9:	89 da                	mov    %ebx,%edx
801006bb:	66 89 10             	mov    %dx,(%eax)

  if(pos < 0 || pos > 25*80)
801006be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801006c2:	78 09                	js     801006cd <cgaputc+0xcb>
801006c4:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
801006cb:	7e 0d                	jle    801006da <cgaputc+0xd8>
    panic("pos under/overflow");
801006cd:	83 ec 0c             	sub    $0xc,%esp
801006d0:	68 5f 87 10 80       	push   $0x8010875f
801006d5:	e8 8d fe ff ff       	call   80100567 <panic>
  
  if((pos/80) >= 24){  // Scroll up.
801006da:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006e1:	7e 4c                	jle    8010072f <cgaputc+0x12d>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006e3:	a1 00 90 10 80       	mov    0x80109000,%eax
801006e8:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006ee:	a1 00 90 10 80       	mov    0x80109000,%eax
801006f3:	83 ec 04             	sub    $0x4,%esp
801006f6:	68 60 0e 00 00       	push   $0xe60
801006fb:	52                   	push   %edx
801006fc:	50                   	push   %eax
801006fd:	e8 ec 4d 00 00       	call   801054ee <memmove>
80100702:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
80100705:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100709:	b8 80 07 00 00       	mov    $0x780,%eax
8010070e:	2b 45 f4             	sub    -0xc(%ebp),%eax
80100711:	8d 14 00             	lea    (%eax,%eax,1),%edx
80100714:	a1 00 90 10 80       	mov    0x80109000,%eax
80100719:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010071c:	01 c9                	add    %ecx,%ecx
8010071e:	01 c8                	add    %ecx,%eax
80100720:	83 ec 04             	sub    $0x4,%esp
80100723:	52                   	push   %edx
80100724:	6a 00                	push   $0x0
80100726:	50                   	push   %eax
80100727:	e8 03 4d 00 00       	call   8010542f <memset>
8010072c:	83 c4 10             	add    $0x10,%esp
  }
  
  outb(CRTPORT, 14);
8010072f:	83 ec 08             	sub    $0x8,%esp
80100732:	6a 0e                	push   $0xe
80100734:	68 d4 03 00 00       	push   $0x3d4
80100739:	e8 b3 fb ff ff       	call   801002f1 <outb>
8010073e:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
80100741:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100744:	c1 f8 08             	sar    $0x8,%eax
80100747:	0f b6 c0             	movzbl %al,%eax
8010074a:	83 ec 08             	sub    $0x8,%esp
8010074d:	50                   	push   %eax
8010074e:	68 d5 03 00 00       	push   $0x3d5
80100753:	e8 99 fb ff ff       	call   801002f1 <outb>
80100758:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
8010075b:	83 ec 08             	sub    $0x8,%esp
8010075e:	6a 0f                	push   $0xf
80100760:	68 d4 03 00 00       	push   $0x3d4
80100765:	e8 87 fb ff ff       	call   801002f1 <outb>
8010076a:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
8010076d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100770:	0f b6 c0             	movzbl %al,%eax
80100773:	83 ec 08             	sub    $0x8,%esp
80100776:	50                   	push   %eax
80100777:	68 d5 03 00 00       	push   $0x3d5
8010077c:	e8 70 fb ff ff       	call   801002f1 <outb>
80100781:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
80100784:	a1 00 90 10 80       	mov    0x80109000,%eax
80100789:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010078c:	01 d2                	add    %edx,%edx
8010078e:	01 d0                	add    %edx,%eax
80100790:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100795:	90                   	nop
80100796:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100799:	c9                   	leave  
8010079a:	c3                   	ret    

8010079b <consputc>:

void
consputc(int c)
{
8010079b:	55                   	push   %ebp
8010079c:	89 e5                	mov    %esp,%ebp
8010079e:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
801007a1:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
801007a6:	85 c0                	test   %eax,%eax
801007a8:	74 07                	je     801007b1 <consputc+0x16>
    cli();
801007aa:	e8 63 fb ff ff       	call   80100312 <cli>
    for(;;)
801007af:	eb fe                	jmp    801007af <consputc+0x14>
      ;
  }

  if(c == BACKSPACE){
801007b1:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801007b8:	75 29                	jne    801007e3 <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801007ba:	83 ec 0c             	sub    $0xc,%esp
801007bd:	6a 08                	push   $0x8
801007bf:	e8 d5 65 00 00       	call   80106d99 <uartputc>
801007c4:	83 c4 10             	add    $0x10,%esp
801007c7:	83 ec 0c             	sub    $0xc,%esp
801007ca:	6a 20                	push   $0x20
801007cc:	e8 c8 65 00 00       	call   80106d99 <uartputc>
801007d1:	83 c4 10             	add    $0x10,%esp
801007d4:	83 ec 0c             	sub    $0xc,%esp
801007d7:	6a 08                	push   $0x8
801007d9:	e8 bb 65 00 00       	call   80106d99 <uartputc>
801007de:	83 c4 10             	add    $0x10,%esp
801007e1:	eb 0e                	jmp    801007f1 <consputc+0x56>
  } else
    uartputc(c);
801007e3:	83 ec 0c             	sub    $0xc,%esp
801007e6:	ff 75 08             	pushl  0x8(%ebp)
801007e9:	e8 ab 65 00 00       	call   80106d99 <uartputc>
801007ee:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801007f1:	83 ec 0c             	sub    $0xc,%esp
801007f4:	ff 75 08             	pushl  0x8(%ebp)
801007f7:	e8 06 fe ff ff       	call   80100602 <cgaputc>
801007fc:	83 c4 10             	add    $0x10,%esp
}
801007ff:	90                   	nop
80100800:	c9                   	leave  
80100801:	c3                   	ret    

80100802 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100802:	55                   	push   %ebp
80100803:	89 e5                	mov    %esp,%ebp
80100805:	83 ec 18             	sub    $0x18,%esp
  int c, doprocdump = 0;
80100808:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
8010080f:	83 ec 0c             	sub    $0xc,%esp
80100812:	68 c0 b5 10 80       	push   $0x8010b5c0
80100817:	e8 b0 49 00 00       	call   801051cc <acquire>
8010081c:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
8010081f:	e9 46 01 00 00       	jmp    8010096a <consoleintr+0x168>
80100824:	83 7d f0 10          	cmpl   $0x10,-0x10(%ebp)
80100828:	74 22                	je     8010084c <consoleintr+0x4a>
8010082a:	83 7d f0 10          	cmpl   $0x10,-0x10(%ebp)
8010082e:	7f 0b                	jg     8010083b <consoleintr+0x39>
80100830:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
80100834:	74 6d                	je     801008a3 <consoleintr+0xa1>
80100836:	e9 9d 00 00 00       	jmp    801008d8 <consoleintr+0xd6>
8010083b:	83 7d f0 15          	cmpl   $0x15,-0x10(%ebp)
8010083f:	74 34                	je     80100875 <consoleintr+0x73>
80100841:	83 7d f0 7f          	cmpl   $0x7f,-0x10(%ebp)
80100845:	74 5c                	je     801008a3 <consoleintr+0xa1>
80100847:	e9 8c 00 00 00       	jmp    801008d8 <consoleintr+0xd6>
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
8010084c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
80100853:	e9 12 01 00 00       	jmp    8010096a <consoleintr+0x168>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100858:	a1 08 08 11 80       	mov    0x80110808,%eax
8010085d:	83 e8 01             	sub    $0x1,%eax
80100860:	a3 08 08 11 80       	mov    %eax,0x80110808
        consputc(BACKSPACE);
80100865:	83 ec 0c             	sub    $0xc,%esp
80100868:	68 00 01 00 00       	push   $0x100
8010086d:	e8 29 ff ff ff       	call   8010079b <consputc>
80100872:	83 c4 10             	add    $0x10,%esp
      while(input.e != input.w &&
80100875:	8b 15 08 08 11 80    	mov    0x80110808,%edx
8010087b:	a1 04 08 11 80       	mov    0x80110804,%eax
80100880:	39 c2                	cmp    %eax,%edx
80100882:	0f 84 e2 00 00 00    	je     8010096a <consoleintr+0x168>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100888:	a1 08 08 11 80       	mov    0x80110808,%eax
8010088d:	83 e8 01             	sub    $0x1,%eax
80100890:	83 e0 7f             	and    $0x7f,%eax
80100893:	0f b6 80 80 07 11 80 	movzbl -0x7feef880(%eax),%eax
      while(input.e != input.w &&
8010089a:	3c 0a                	cmp    $0xa,%al
8010089c:	75 ba                	jne    80100858 <consoleintr+0x56>
      }
      break;
8010089e:	e9 c7 00 00 00       	jmp    8010096a <consoleintr+0x168>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
801008a3:	8b 15 08 08 11 80    	mov    0x80110808,%edx
801008a9:	a1 04 08 11 80       	mov    0x80110804,%eax
801008ae:	39 c2                	cmp    %eax,%edx
801008b0:	0f 84 b4 00 00 00    	je     8010096a <consoleintr+0x168>
        input.e--;
801008b6:	a1 08 08 11 80       	mov    0x80110808,%eax
801008bb:	83 e8 01             	sub    $0x1,%eax
801008be:	a3 08 08 11 80       	mov    %eax,0x80110808
        consputc(BACKSPACE);
801008c3:	83 ec 0c             	sub    $0xc,%esp
801008c6:	68 00 01 00 00       	push   $0x100
801008cb:	e8 cb fe ff ff       	call   8010079b <consputc>
801008d0:	83 c4 10             	add    $0x10,%esp
      }
      break;
801008d3:	e9 92 00 00 00       	jmp    8010096a <consoleintr+0x168>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801008dc:	0f 84 87 00 00 00    	je     80100969 <consoleintr+0x167>
801008e2:	8b 15 08 08 11 80    	mov    0x80110808,%edx
801008e8:	a1 00 08 11 80       	mov    0x80110800,%eax
801008ed:	29 c2                	sub    %eax,%edx
801008ef:	89 d0                	mov    %edx,%eax
801008f1:	83 f8 7f             	cmp    $0x7f,%eax
801008f4:	77 73                	ja     80100969 <consoleintr+0x167>
        c = (c == '\r') ? '\n' : c;
801008f6:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801008fa:	74 05                	je     80100901 <consoleintr+0xff>
801008fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008ff:	eb 05                	jmp    80100906 <consoleintr+0x104>
80100901:	b8 0a 00 00 00       	mov    $0xa,%eax
80100906:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
80100909:	a1 08 08 11 80       	mov    0x80110808,%eax
8010090e:	8d 50 01             	lea    0x1(%eax),%edx
80100911:	89 15 08 08 11 80    	mov    %edx,0x80110808
80100917:	83 e0 7f             	and    $0x7f,%eax
8010091a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010091d:	88 90 80 07 11 80    	mov    %dl,-0x7feef880(%eax)
        consputc(c);
80100923:	83 ec 0c             	sub    $0xc,%esp
80100926:	ff 75 f0             	pushl  -0x10(%ebp)
80100929:	e8 6d fe ff ff       	call   8010079b <consputc>
8010092e:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100931:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100935:	74 18                	je     8010094f <consoleintr+0x14d>
80100937:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
8010093b:	74 12                	je     8010094f <consoleintr+0x14d>
8010093d:	a1 08 08 11 80       	mov    0x80110808,%eax
80100942:	8b 15 00 08 11 80    	mov    0x80110800,%edx
80100948:	83 ea 80             	sub    $0xffffff80,%edx
8010094b:	39 d0                	cmp    %edx,%eax
8010094d:	75 1a                	jne    80100969 <consoleintr+0x167>
          input.w = input.e;
8010094f:	a1 08 08 11 80       	mov    0x80110808,%eax
80100954:	a3 04 08 11 80       	mov    %eax,0x80110804
          wakeup(&input.r);
80100959:	83 ec 0c             	sub    $0xc,%esp
8010095c:	68 00 08 11 80       	push   $0x80110800
80100961:	e8 48 46 00 00       	call   80104fae <wakeup>
80100966:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
80100969:	90                   	nop
  while((c = getc()) >= 0){
8010096a:	8b 45 08             	mov    0x8(%ebp),%eax
8010096d:	ff d0                	call   *%eax
8010096f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100972:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100976:	0f 89 a8 fe ff ff    	jns    80100824 <consoleintr+0x22>
    }
  }
  release(&cons.lock);
8010097c:	83 ec 0c             	sub    $0xc,%esp
8010097f:	68 c0 b5 10 80       	push   $0x8010b5c0
80100984:	e8 aa 48 00 00       	call   80105233 <release>
80100989:	83 c4 10             	add    $0x10,%esp
  if(doprocdump) {
8010098c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100990:	74 05                	je     80100997 <consoleintr+0x195>
    procdump();  // now call procdump() wo. cons.lock held
80100992:	e8 d5 46 00 00       	call   8010506c <procdump>
  }
}
80100997:	90                   	nop
80100998:	c9                   	leave  
80100999:	c3                   	ret    

8010099a <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
8010099a:	55                   	push   %ebp
8010099b:	89 e5                	mov    %esp,%ebp
8010099d:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
801009a0:	83 ec 0c             	sub    $0xc,%esp
801009a3:	ff 75 08             	pushl  0x8(%ebp)
801009a6:	e8 28 11 00 00       	call   80101ad3 <iunlock>
801009ab:	83 c4 10             	add    $0x10,%esp
  target = n;
801009ae:	8b 45 10             	mov    0x10(%ebp),%eax
801009b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
801009b4:	83 ec 0c             	sub    $0xc,%esp
801009b7:	68 c0 b5 10 80       	push   $0x8010b5c0
801009bc:	e8 0b 48 00 00       	call   801051cc <acquire>
801009c1:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
801009c4:	e9 ac 00 00 00       	jmp    80100a75 <consoleread+0xdb>
    while(input.r == input.w){
      if(proc->killed){
801009c9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801009cf:	8b 40 24             	mov    0x24(%eax),%eax
801009d2:	85 c0                	test   %eax,%eax
801009d4:	74 28                	je     801009fe <consoleread+0x64>
        release(&cons.lock);
801009d6:	83 ec 0c             	sub    $0xc,%esp
801009d9:	68 c0 b5 10 80       	push   $0x8010b5c0
801009de:	e8 50 48 00 00       	call   80105233 <release>
801009e3:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
801009e6:	83 ec 0c             	sub    $0xc,%esp
801009e9:	ff 75 08             	pushl  0x8(%ebp)
801009ec:	e8 84 0f 00 00       	call   80101975 <ilock>
801009f1:	83 c4 10             	add    $0x10,%esp
        return -1;
801009f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009f9:	e9 ab 00 00 00       	jmp    80100aa9 <consoleread+0x10f>
      }
      sleep(&input.r, &cons.lock);
801009fe:	83 ec 08             	sub    $0x8,%esp
80100a01:	68 c0 b5 10 80       	push   $0x8010b5c0
80100a06:	68 00 08 11 80       	push   $0x80110800
80100a0b:	e8 b0 44 00 00       	call   80104ec0 <sleep>
80100a10:	83 c4 10             	add    $0x10,%esp
    while(input.r == input.w){
80100a13:	8b 15 00 08 11 80    	mov    0x80110800,%edx
80100a19:	a1 04 08 11 80       	mov    0x80110804,%eax
80100a1e:	39 c2                	cmp    %eax,%edx
80100a20:	74 a7                	je     801009c9 <consoleread+0x2f>
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100a22:	a1 00 08 11 80       	mov    0x80110800,%eax
80100a27:	8d 50 01             	lea    0x1(%eax),%edx
80100a2a:	89 15 00 08 11 80    	mov    %edx,0x80110800
80100a30:	83 e0 7f             	and    $0x7f,%eax
80100a33:	0f b6 80 80 07 11 80 	movzbl -0x7feef880(%eax),%eax
80100a3a:	0f be c0             	movsbl %al,%eax
80100a3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100a40:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a44:	75 17                	jne    80100a5d <consoleread+0xc3>
      if(n < target){
80100a46:	8b 45 10             	mov    0x10(%ebp),%eax
80100a49:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100a4c:	76 2f                	jbe    80100a7d <consoleread+0xe3>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a4e:	a1 00 08 11 80       	mov    0x80110800,%eax
80100a53:	83 e8 01             	sub    $0x1,%eax
80100a56:	a3 00 08 11 80       	mov    %eax,0x80110800
      }
      break;
80100a5b:	eb 20                	jmp    80100a7d <consoleread+0xe3>
    }
    *dst++ = c;
80100a5d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a60:	8d 50 01             	lea    0x1(%eax),%edx
80100a63:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a66:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a69:	88 10                	mov    %dl,(%eax)
    --n;
80100a6b:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a6f:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a73:	74 0b                	je     80100a80 <consoleread+0xe6>
  while(n > 0){
80100a75:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a79:	7f 98                	jg     80100a13 <consoleread+0x79>
80100a7b:	eb 04                	jmp    80100a81 <consoleread+0xe7>
      break;
80100a7d:	90                   	nop
80100a7e:	eb 01                	jmp    80100a81 <consoleread+0xe7>
      break;
80100a80:	90                   	nop
  }
  release(&cons.lock);
80100a81:	83 ec 0c             	sub    $0xc,%esp
80100a84:	68 c0 b5 10 80       	push   $0x8010b5c0
80100a89:	e8 a5 47 00 00       	call   80105233 <release>
80100a8e:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100a91:	83 ec 0c             	sub    $0xc,%esp
80100a94:	ff 75 08             	pushl  0x8(%ebp)
80100a97:	e8 d9 0e 00 00       	call   80101975 <ilock>
80100a9c:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100a9f:	8b 45 10             	mov    0x10(%ebp),%eax
80100aa2:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100aa5:	29 c2                	sub    %eax,%edx
80100aa7:	89 d0                	mov    %edx,%eax
}
80100aa9:	c9                   	leave  
80100aaa:	c3                   	ret    

80100aab <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100aab:	55                   	push   %ebp
80100aac:	89 e5                	mov    %esp,%ebp
80100aae:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100ab1:	83 ec 0c             	sub    $0xc,%esp
80100ab4:	ff 75 08             	pushl  0x8(%ebp)
80100ab7:	e8 17 10 00 00       	call   80101ad3 <iunlock>
80100abc:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100abf:	83 ec 0c             	sub    $0xc,%esp
80100ac2:	68 c0 b5 10 80       	push   $0x8010b5c0
80100ac7:	e8 00 47 00 00       	call   801051cc <acquire>
80100acc:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100acf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100ad6:	eb 21                	jmp    80100af9 <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
80100ad8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100adb:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ade:	01 d0                	add    %edx,%eax
80100ae0:	0f b6 00             	movzbl (%eax),%eax
80100ae3:	0f be c0             	movsbl %al,%eax
80100ae6:	0f b6 c0             	movzbl %al,%eax
80100ae9:	83 ec 0c             	sub    $0xc,%esp
80100aec:	50                   	push   %eax
80100aed:	e8 a9 fc ff ff       	call   8010079b <consputc>
80100af2:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100af5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100af9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100afc:	3b 45 10             	cmp    0x10(%ebp),%eax
80100aff:	7c d7                	jl     80100ad8 <consolewrite+0x2d>
  release(&cons.lock);
80100b01:	83 ec 0c             	sub    $0xc,%esp
80100b04:	68 c0 b5 10 80       	push   $0x8010b5c0
80100b09:	e8 25 47 00 00       	call   80105233 <release>
80100b0e:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff 75 08             	pushl  0x8(%ebp)
80100b17:	e8 59 0e 00 00       	call   80101975 <ilock>
80100b1c:	83 c4 10             	add    $0x10,%esp

  return n;
80100b1f:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100b22:	c9                   	leave  
80100b23:	c3                   	ret    

80100b24 <consoleinit>:

void
consoleinit(void)
{
80100b24:	55                   	push   %ebp
80100b25:	89 e5                	mov    %esp,%ebp
80100b27:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100b2a:	83 ec 08             	sub    $0x8,%esp
80100b2d:	68 72 87 10 80       	push   $0x80108772
80100b32:	68 c0 b5 10 80       	push   $0x8010b5c0
80100b37:	e8 6e 46 00 00       	call   801051aa <initlock>
80100b3c:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b3f:	c7 05 cc 11 11 80 ab 	movl   $0x80100aab,0x801111cc
80100b46:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b49:	c7 05 c8 11 11 80 9a 	movl   $0x8010099a,0x801111c8
80100b50:	09 10 80 
  cons.locking = 1;
80100b53:	c7 05 f4 b5 10 80 01 	movl   $0x1,0x8010b5f4
80100b5a:	00 00 00 

  picenable(IRQ_KBD);
80100b5d:	83 ec 0c             	sub    $0xc,%esp
80100b60:	6a 01                	push   $0x1
80100b62:	e8 c9 33 00 00       	call   80103f30 <picenable>
80100b67:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100b6a:	83 ec 08             	sub    $0x8,%esp
80100b6d:	6a 00                	push   $0x0
80100b6f:	6a 01                	push   $0x1
80100b71:	e8 68 1f 00 00       	call   80102ade <ioapicenable>
80100b76:	83 c4 10             	add    $0x10,%esp
}
80100b79:	90                   	nop
80100b7a:	c9                   	leave  
80100b7b:	c3                   	ret    

80100b7c <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b7c:	55                   	push   %ebp
80100b7d:	89 e5                	mov    %esp,%ebp
80100b7f:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100b85:	e8 cc 29 00 00       	call   80103556 <begin_op>
  if((ip = namei(path)) == 0){
80100b8a:	83 ec 0c             	sub    $0xc,%esp
80100b8d:	ff 75 08             	pushl  0x8(%ebp)
80100b90:	e8 95 19 00 00       	call   8010252a <namei>
80100b95:	83 c4 10             	add    $0x10,%esp
80100b98:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b9b:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b9f:	75 0f                	jne    80100bb0 <exec+0x34>
    end_op();
80100ba1:	e8 3c 2a 00 00       	call   801035e2 <end_op>
    return -1;
80100ba6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bab:	e9 ce 03 00 00       	jmp    80100f7e <exec+0x402>
  }
  ilock(ip);
80100bb0:	83 ec 0c             	sub    $0xc,%esp
80100bb3:	ff 75 d8             	pushl  -0x28(%ebp)
80100bb6:	e8 ba 0d 00 00       	call   80101975 <ilock>
80100bbb:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100bbe:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100bc5:	6a 34                	push   $0x34
80100bc7:	6a 00                	push   $0x0
80100bc9:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100bcf:	50                   	push   %eax
80100bd0:	ff 75 d8             	pushl  -0x28(%ebp)
80100bd3:	e8 06 13 00 00       	call   80101ede <readi>
80100bd8:	83 c4 10             	add    $0x10,%esp
80100bdb:	83 f8 33             	cmp    $0x33,%eax
80100bde:	0f 86 49 03 00 00    	jbe    80100f2d <exec+0x3b1>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100be4:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bea:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100bef:	0f 85 3b 03 00 00    	jne    80100f30 <exec+0x3b4>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100bf5:	e8 f4 72 00 00       	call   80107eee <setupkvm>
80100bfa:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bfd:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100c01:	0f 84 2c 03 00 00    	je     80100f33 <exec+0x3b7>
    goto bad;

  // Load program into memory.
  sz = 0;
80100c07:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c0e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100c15:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100c1b:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c1e:	e9 ab 00 00 00       	jmp    80100cce <exec+0x152>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c23:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c26:	6a 20                	push   $0x20
80100c28:	50                   	push   %eax
80100c29:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100c2f:	50                   	push   %eax
80100c30:	ff 75 d8             	pushl  -0x28(%ebp)
80100c33:	e8 a6 12 00 00       	call   80101ede <readi>
80100c38:	83 c4 10             	add    $0x10,%esp
80100c3b:	83 f8 20             	cmp    $0x20,%eax
80100c3e:	0f 85 f2 02 00 00    	jne    80100f36 <exec+0x3ba>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c44:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c4a:	83 f8 01             	cmp    $0x1,%eax
80100c4d:	75 71                	jne    80100cc0 <exec+0x144>
      continue;
    if(ph.memsz < ph.filesz)
80100c4f:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c55:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c5b:	39 c2                	cmp    %eax,%edx
80100c5d:	0f 82 d6 02 00 00    	jb     80100f39 <exec+0x3bd>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c63:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c69:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c6f:	01 d0                	add    %edx,%eax
80100c71:	83 ec 04             	sub    $0x4,%esp
80100c74:	50                   	push   %eax
80100c75:	ff 75 e0             	pushl  -0x20(%ebp)
80100c78:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c7b:	e8 16 76 00 00       	call   80108296 <allocuvm>
80100c80:	83 c4 10             	add    $0x10,%esp
80100c83:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c86:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c8a:	0f 84 ac 02 00 00    	je     80100f3c <exec+0x3c0>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c90:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100c96:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c9c:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100ca2:	83 ec 0c             	sub    $0xc,%esp
80100ca5:	52                   	push   %edx
80100ca6:	50                   	push   %eax
80100ca7:	ff 75 d8             	pushl  -0x28(%ebp)
80100caa:	51                   	push   %ecx
80100cab:	ff 75 d4             	pushl  -0x2c(%ebp)
80100cae:	e8 0c 75 00 00       	call   801081bf <loaduvm>
80100cb3:	83 c4 20             	add    $0x20,%esp
80100cb6:	85 c0                	test   %eax,%eax
80100cb8:	0f 88 81 02 00 00    	js     80100f3f <exec+0x3c3>
80100cbe:	eb 01                	jmp    80100cc1 <exec+0x145>
      continue;
80100cc0:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100cc1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100cc5:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100cc8:	83 c0 20             	add    $0x20,%eax
80100ccb:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100cce:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100cd5:	0f b7 c0             	movzwl %ax,%eax
80100cd8:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80100cdb:	0f 8c 42 ff ff ff    	jl     80100c23 <exec+0xa7>
      goto bad;
  }
  iunlockput(ip);
80100ce1:	83 ec 0c             	sub    $0xc,%esp
80100ce4:	ff 75 d8             	pushl  -0x28(%ebp)
80100ce7:	e8 49 0f 00 00       	call   80101c35 <iunlockput>
80100cec:	83 c4 10             	add    $0x10,%esp
  end_op();
80100cef:	e8 ee 28 00 00       	call   801035e2 <end_op>
  ip = 0;
80100cf4:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100cfb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cfe:	05 ff 0f 00 00       	add    $0xfff,%eax
80100d03:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100d08:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d0b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d0e:	05 00 20 00 00       	add    $0x2000,%eax
80100d13:	83 ec 04             	sub    $0x4,%esp
80100d16:	50                   	push   %eax
80100d17:	ff 75 e0             	pushl  -0x20(%ebp)
80100d1a:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d1d:	e8 74 75 00 00       	call   80108296 <allocuvm>
80100d22:	83 c4 10             	add    $0x10,%esp
80100d25:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d28:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d2c:	0f 84 10 02 00 00    	je     80100f42 <exec+0x3c6>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d32:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d35:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d3a:	83 ec 08             	sub    $0x8,%esp
80100d3d:	50                   	push   %eax
80100d3e:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d41:	e8 76 77 00 00       	call   801084bc <clearpteu>
80100d46:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100d49:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d4c:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d4f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d56:	e9 96 00 00 00       	jmp    80100df1 <exec+0x275>
    if(argc >= MAXARG)
80100d5b:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d5f:	0f 87 e0 01 00 00    	ja     80100f45 <exec+0x3c9>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d65:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d68:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d6f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d72:	01 d0                	add    %edx,%eax
80100d74:	8b 00                	mov    (%eax),%eax
80100d76:	83 ec 0c             	sub    $0xc,%esp
80100d79:	50                   	push   %eax
80100d7a:	e8 fd 48 00 00       	call   8010567c <strlen>
80100d7f:	83 c4 10             	add    $0x10,%esp
80100d82:	89 c2                	mov    %eax,%edx
80100d84:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d87:	29 d0                	sub    %edx,%eax
80100d89:	83 e8 01             	sub    $0x1,%eax
80100d8c:	83 e0 fc             	and    $0xfffffffc,%eax
80100d8f:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d95:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d9c:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d9f:	01 d0                	add    %edx,%eax
80100da1:	8b 00                	mov    (%eax),%eax
80100da3:	83 ec 0c             	sub    $0xc,%esp
80100da6:	50                   	push   %eax
80100da7:	e8 d0 48 00 00       	call   8010567c <strlen>
80100dac:	83 c4 10             	add    $0x10,%esp
80100daf:	83 c0 01             	add    $0x1,%eax
80100db2:	89 c1                	mov    %eax,%ecx
80100db4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100db7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dbe:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dc1:	01 d0                	add    %edx,%eax
80100dc3:	8b 00                	mov    (%eax),%eax
80100dc5:	51                   	push   %ecx
80100dc6:	50                   	push   %eax
80100dc7:	ff 75 dc             	pushl  -0x24(%ebp)
80100dca:	ff 75 d4             	pushl  -0x2c(%ebp)
80100dcd:	e8 a2 78 00 00       	call   80108674 <copyout>
80100dd2:	83 c4 10             	add    $0x10,%esp
80100dd5:	85 c0                	test   %eax,%eax
80100dd7:	0f 88 6b 01 00 00    	js     80100f48 <exec+0x3cc>
      goto bad;
    ustack[3+argc] = sp;
80100ddd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100de0:	8d 50 03             	lea    0x3(%eax),%edx
80100de3:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100de6:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
  for(argc = 0; argv[argc]; argc++) {
80100ded:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100df1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100df4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dfe:	01 d0                	add    %edx,%eax
80100e00:	8b 00                	mov    (%eax),%eax
80100e02:	85 c0                	test   %eax,%eax
80100e04:	0f 85 51 ff ff ff    	jne    80100d5b <exec+0x1df>
  }
  ustack[3+argc] = 0;
80100e0a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e0d:	83 c0 03             	add    $0x3,%eax
80100e10:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100e17:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100e1b:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100e22:	ff ff ff 
  ustack[1] = argc;
80100e25:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e28:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e2e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e31:	83 c0 01             	add    $0x1,%eax
80100e34:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e3b:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e3e:	29 d0                	sub    %edx,%eax
80100e40:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100e46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e49:	83 c0 04             	add    $0x4,%eax
80100e4c:	c1 e0 02             	shl    $0x2,%eax
80100e4f:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e55:	83 c0 04             	add    $0x4,%eax
80100e58:	c1 e0 02             	shl    $0x2,%eax
80100e5b:	50                   	push   %eax
80100e5c:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e62:	50                   	push   %eax
80100e63:	ff 75 dc             	pushl  -0x24(%ebp)
80100e66:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e69:	e8 06 78 00 00       	call   80108674 <copyout>
80100e6e:	83 c4 10             	add    $0x10,%esp
80100e71:	85 c0                	test   %eax,%eax
80100e73:	0f 88 d2 00 00 00    	js     80100f4b <exec+0x3cf>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e79:	8b 45 08             	mov    0x8(%ebp),%eax
80100e7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e82:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e85:	eb 17                	jmp    80100e9e <exec+0x322>
    if(*s == '/')
80100e87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e8a:	0f b6 00             	movzbl (%eax),%eax
80100e8d:	3c 2f                	cmp    $0x2f,%al
80100e8f:	75 09                	jne    80100e9a <exec+0x31e>
      last = s+1;
80100e91:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e94:	83 c0 01             	add    $0x1,%eax
80100e97:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(last=s=path; *s; s++)
80100e9a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ea1:	0f b6 00             	movzbl (%eax),%eax
80100ea4:	84 c0                	test   %al,%al
80100ea6:	75 df                	jne    80100e87 <exec+0x30b>
  safestrcpy(proc->name, last, sizeof(proc->name));
80100ea8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eae:	83 c0 74             	add    $0x74,%eax
80100eb1:	83 ec 04             	sub    $0x4,%esp
80100eb4:	6a 10                	push   $0x10
80100eb6:	ff 75 f0             	pushl  -0x10(%ebp)
80100eb9:	50                   	push   %eax
80100eba:	e8 73 47 00 00       	call   80105632 <safestrcpy>
80100ebf:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100ec2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ec8:	8b 40 04             	mov    0x4(%eax),%eax
80100ecb:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100ece:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ed4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100ed7:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100eda:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ee0:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100ee3:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100ee5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eeb:	8b 40 18             	mov    0x18(%eax),%eax
80100eee:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100ef4:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100ef7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100efd:	8b 40 18             	mov    0x18(%eax),%eax
80100f00:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100f03:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100f06:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f0c:	83 ec 0c             	sub    $0xc,%esp
80100f0f:	50                   	push   %eax
80100f10:	e8 c0 70 00 00       	call   80107fd5 <switchuvm>
80100f15:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100f18:	83 ec 0c             	sub    $0xc,%esp
80100f1b:	ff 75 d0             	pushl  -0x30(%ebp)
80100f1e:	e8 f9 74 00 00       	call   8010841c <freevm>
80100f23:	83 c4 10             	add    $0x10,%esp
  return 0;
80100f26:	b8 00 00 00 00       	mov    $0x0,%eax
80100f2b:	eb 51                	jmp    80100f7e <exec+0x402>
    goto bad;
80100f2d:	90                   	nop
80100f2e:	eb 1c                	jmp    80100f4c <exec+0x3d0>
    goto bad;
80100f30:	90                   	nop
80100f31:	eb 19                	jmp    80100f4c <exec+0x3d0>
    goto bad;
80100f33:	90                   	nop
80100f34:	eb 16                	jmp    80100f4c <exec+0x3d0>
      goto bad;
80100f36:	90                   	nop
80100f37:	eb 13                	jmp    80100f4c <exec+0x3d0>
      goto bad;
80100f39:	90                   	nop
80100f3a:	eb 10                	jmp    80100f4c <exec+0x3d0>
      goto bad;
80100f3c:	90                   	nop
80100f3d:	eb 0d                	jmp    80100f4c <exec+0x3d0>
      goto bad;
80100f3f:	90                   	nop
80100f40:	eb 0a                	jmp    80100f4c <exec+0x3d0>
    goto bad;
80100f42:	90                   	nop
80100f43:	eb 07                	jmp    80100f4c <exec+0x3d0>
      goto bad;
80100f45:	90                   	nop
80100f46:	eb 04                	jmp    80100f4c <exec+0x3d0>
      goto bad;
80100f48:	90                   	nop
80100f49:	eb 01                	jmp    80100f4c <exec+0x3d0>
    goto bad;
80100f4b:	90                   	nop

 bad:
  if(pgdir)
80100f4c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f50:	74 0e                	je     80100f60 <exec+0x3e4>
    freevm(pgdir);
80100f52:	83 ec 0c             	sub    $0xc,%esp
80100f55:	ff 75 d4             	pushl  -0x2c(%ebp)
80100f58:	e8 bf 74 00 00       	call   8010841c <freevm>
80100f5d:	83 c4 10             	add    $0x10,%esp
  if(ip){
80100f60:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f64:	74 13                	je     80100f79 <exec+0x3fd>
    iunlockput(ip);
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	ff 75 d8             	pushl  -0x28(%ebp)
80100f6c:	e8 c4 0c 00 00       	call   80101c35 <iunlockput>
80100f71:	83 c4 10             	add    $0x10,%esp
    end_op();
80100f74:	e8 69 26 00 00       	call   801035e2 <end_op>
  }
  return -1;
80100f79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f7e:	c9                   	leave  
80100f7f:	c3                   	ret    

80100f80 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f80:	55                   	push   %ebp
80100f81:	89 e5                	mov    %esp,%ebp
80100f83:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
80100f86:	83 ec 08             	sub    $0x8,%esp
80100f89:	68 7a 87 10 80       	push   $0x8010877a
80100f8e:	68 20 08 11 80       	push   $0x80110820
80100f93:	e8 12 42 00 00       	call   801051aa <initlock>
80100f98:	83 c4 10             	add    $0x10,%esp
}
80100f9b:	90                   	nop
80100f9c:	c9                   	leave  
80100f9d:	c3                   	ret    

80100f9e <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f9e:	55                   	push   %ebp
80100f9f:	89 e5                	mov    %esp,%ebp
80100fa1:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
80100fa4:	83 ec 0c             	sub    $0xc,%esp
80100fa7:	68 20 08 11 80       	push   $0x80110820
80100fac:	e8 1b 42 00 00       	call   801051cc <acquire>
80100fb1:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fb4:	c7 45 f4 54 08 11 80 	movl   $0x80110854,-0xc(%ebp)
80100fbb:	eb 2d                	jmp    80100fea <filealloc+0x4c>
    if(f->ref == 0){
80100fbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fc0:	8b 40 04             	mov    0x4(%eax),%eax
80100fc3:	85 c0                	test   %eax,%eax
80100fc5:	75 1f                	jne    80100fe6 <filealloc+0x48>
      f->ref = 1;
80100fc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fca:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100fd1:	83 ec 0c             	sub    $0xc,%esp
80100fd4:	68 20 08 11 80       	push   $0x80110820
80100fd9:	e8 55 42 00 00       	call   80105233 <release>
80100fde:	83 c4 10             	add    $0x10,%esp
      return f;
80100fe1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fe4:	eb 23                	jmp    80101009 <filealloc+0x6b>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fe6:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100fea:	b8 b4 11 11 80       	mov    $0x801111b4,%eax
80100fef:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100ff2:	72 c9                	jb     80100fbd <filealloc+0x1f>
    }
  }
  release(&ftable.lock);
80100ff4:	83 ec 0c             	sub    $0xc,%esp
80100ff7:	68 20 08 11 80       	push   $0x80110820
80100ffc:	e8 32 42 00 00       	call   80105233 <release>
80101001:	83 c4 10             	add    $0x10,%esp
  return 0;
80101004:	b8 00 00 00 00       	mov    $0x0,%eax
}
80101009:	c9                   	leave  
8010100a:	c3                   	ret    

8010100b <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
8010100b:	55                   	push   %ebp
8010100c:	89 e5                	mov    %esp,%ebp
8010100e:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80101011:	83 ec 0c             	sub    $0xc,%esp
80101014:	68 20 08 11 80       	push   $0x80110820
80101019:	e8 ae 41 00 00       	call   801051cc <acquire>
8010101e:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101021:	8b 45 08             	mov    0x8(%ebp),%eax
80101024:	8b 40 04             	mov    0x4(%eax),%eax
80101027:	85 c0                	test   %eax,%eax
80101029:	7f 0d                	jg     80101038 <filedup+0x2d>
    panic("filedup");
8010102b:	83 ec 0c             	sub    $0xc,%esp
8010102e:	68 81 87 10 80       	push   $0x80108781
80101033:	e8 2f f5 ff ff       	call   80100567 <panic>
  f->ref++;
80101038:	8b 45 08             	mov    0x8(%ebp),%eax
8010103b:	8b 40 04             	mov    0x4(%eax),%eax
8010103e:	8d 50 01             	lea    0x1(%eax),%edx
80101041:	8b 45 08             	mov    0x8(%ebp),%eax
80101044:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80101047:	83 ec 0c             	sub    $0xc,%esp
8010104a:	68 20 08 11 80       	push   $0x80110820
8010104f:	e8 df 41 00 00       	call   80105233 <release>
80101054:	83 c4 10             	add    $0x10,%esp
  return f;
80101057:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010105a:	c9                   	leave  
8010105b:	c3                   	ret    

8010105c <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
8010105c:	55                   	push   %ebp
8010105d:	89 e5                	mov    %esp,%ebp
8010105f:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
80101062:	83 ec 0c             	sub    $0xc,%esp
80101065:	68 20 08 11 80       	push   $0x80110820
8010106a:	e8 5d 41 00 00       	call   801051cc <acquire>
8010106f:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101072:	8b 45 08             	mov    0x8(%ebp),%eax
80101075:	8b 40 04             	mov    0x4(%eax),%eax
80101078:	85 c0                	test   %eax,%eax
8010107a:	7f 0d                	jg     80101089 <fileclose+0x2d>
    panic("fileclose");
8010107c:	83 ec 0c             	sub    $0xc,%esp
8010107f:	68 89 87 10 80       	push   $0x80108789
80101084:	e8 de f4 ff ff       	call   80100567 <panic>
  if(--f->ref > 0){
80101089:	8b 45 08             	mov    0x8(%ebp),%eax
8010108c:	8b 40 04             	mov    0x4(%eax),%eax
8010108f:	8d 50 ff             	lea    -0x1(%eax),%edx
80101092:	8b 45 08             	mov    0x8(%ebp),%eax
80101095:	89 50 04             	mov    %edx,0x4(%eax)
80101098:	8b 45 08             	mov    0x8(%ebp),%eax
8010109b:	8b 40 04             	mov    0x4(%eax),%eax
8010109e:	85 c0                	test   %eax,%eax
801010a0:	7e 15                	jle    801010b7 <fileclose+0x5b>
    release(&ftable.lock);
801010a2:	83 ec 0c             	sub    $0xc,%esp
801010a5:	68 20 08 11 80       	push   $0x80110820
801010aa:	e8 84 41 00 00       	call   80105233 <release>
801010af:	83 c4 10             	add    $0x10,%esp
801010b2:	e9 8b 00 00 00       	jmp    80101142 <fileclose+0xe6>
    return;
  }
  ff = *f;
801010b7:	8b 45 08             	mov    0x8(%ebp),%eax
801010ba:	8b 10                	mov    (%eax),%edx
801010bc:	89 55 e0             	mov    %edx,-0x20(%ebp)
801010bf:	8b 50 04             	mov    0x4(%eax),%edx
801010c2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801010c5:	8b 50 08             	mov    0x8(%eax),%edx
801010c8:	89 55 e8             	mov    %edx,-0x18(%ebp)
801010cb:	8b 50 0c             	mov    0xc(%eax),%edx
801010ce:	89 55 ec             	mov    %edx,-0x14(%ebp)
801010d1:	8b 50 10             	mov    0x10(%eax),%edx
801010d4:	89 55 f0             	mov    %edx,-0x10(%ebp)
801010d7:	8b 40 14             	mov    0x14(%eax),%eax
801010da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
801010dd:	8b 45 08             	mov    0x8(%ebp),%eax
801010e0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
801010e7:	8b 45 08             	mov    0x8(%ebp),%eax
801010ea:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
801010f0:	83 ec 0c             	sub    $0xc,%esp
801010f3:	68 20 08 11 80       	push   $0x80110820
801010f8:	e8 36 41 00 00       	call   80105233 <release>
801010fd:	83 c4 10             	add    $0x10,%esp
  
  if(ff.type == FD_PIPE)
80101100:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101103:	83 f8 01             	cmp    $0x1,%eax
80101106:	75 19                	jne    80101121 <fileclose+0xc5>
    pipeclose(ff.pipe, ff.writable);
80101108:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
8010110c:	0f be d0             	movsbl %al,%edx
8010110f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101112:	83 ec 08             	sub    $0x8,%esp
80101115:	52                   	push   %edx
80101116:	50                   	push   %eax
80101117:	e8 80 30 00 00       	call   8010419c <pipeclose>
8010111c:	83 c4 10             	add    $0x10,%esp
8010111f:	eb 21                	jmp    80101142 <fileclose+0xe6>
  else if(ff.type == FD_INODE){
80101121:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101124:	83 f8 02             	cmp    $0x2,%eax
80101127:	75 19                	jne    80101142 <fileclose+0xe6>
    begin_op();
80101129:	e8 28 24 00 00       	call   80103556 <begin_op>
    iput(ff.ip);
8010112e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101131:	83 ec 0c             	sub    $0xc,%esp
80101134:	50                   	push   %eax
80101135:	e8 0b 0a 00 00       	call   80101b45 <iput>
8010113a:	83 c4 10             	add    $0x10,%esp
    end_op();
8010113d:	e8 a0 24 00 00       	call   801035e2 <end_op>
  }
}
80101142:	c9                   	leave  
80101143:	c3                   	ret    

80101144 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101144:	55                   	push   %ebp
80101145:	89 e5                	mov    %esp,%ebp
80101147:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
8010114a:	8b 45 08             	mov    0x8(%ebp),%eax
8010114d:	8b 00                	mov    (%eax),%eax
8010114f:	83 f8 02             	cmp    $0x2,%eax
80101152:	75 40                	jne    80101194 <filestat+0x50>
    ilock(f->ip);
80101154:	8b 45 08             	mov    0x8(%ebp),%eax
80101157:	8b 40 10             	mov    0x10(%eax),%eax
8010115a:	83 ec 0c             	sub    $0xc,%esp
8010115d:	50                   	push   %eax
8010115e:	e8 12 08 00 00       	call   80101975 <ilock>
80101163:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
80101166:	8b 45 08             	mov    0x8(%ebp),%eax
80101169:	8b 40 10             	mov    0x10(%eax),%eax
8010116c:	83 ec 08             	sub    $0x8,%esp
8010116f:	ff 75 0c             	pushl  0xc(%ebp)
80101172:	50                   	push   %eax
80101173:	e8 20 0d 00 00       	call   80101e98 <stati>
80101178:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
8010117b:	8b 45 08             	mov    0x8(%ebp),%eax
8010117e:	8b 40 10             	mov    0x10(%eax),%eax
80101181:	83 ec 0c             	sub    $0xc,%esp
80101184:	50                   	push   %eax
80101185:	e8 49 09 00 00       	call   80101ad3 <iunlock>
8010118a:	83 c4 10             	add    $0x10,%esp
    return 0;
8010118d:	b8 00 00 00 00       	mov    $0x0,%eax
80101192:	eb 05                	jmp    80101199 <filestat+0x55>
  }
  return -1;
80101194:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101199:	c9                   	leave  
8010119a:	c3                   	ret    

8010119b <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
8010119b:	55                   	push   %ebp
8010119c:	89 e5                	mov    %esp,%ebp
8010119e:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
801011a1:	8b 45 08             	mov    0x8(%ebp),%eax
801011a4:	0f b6 40 08          	movzbl 0x8(%eax),%eax
801011a8:	84 c0                	test   %al,%al
801011aa:	75 0a                	jne    801011b6 <fileread+0x1b>
    return -1;
801011ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011b1:	e9 9b 00 00 00       	jmp    80101251 <fileread+0xb6>
  if(f->type == FD_PIPE)
801011b6:	8b 45 08             	mov    0x8(%ebp),%eax
801011b9:	8b 00                	mov    (%eax),%eax
801011bb:	83 f8 01             	cmp    $0x1,%eax
801011be:	75 1a                	jne    801011da <fileread+0x3f>
    return piperead(f->pipe, addr, n);
801011c0:	8b 45 08             	mov    0x8(%ebp),%eax
801011c3:	8b 40 0c             	mov    0xc(%eax),%eax
801011c6:	83 ec 04             	sub    $0x4,%esp
801011c9:	ff 75 10             	pushl  0x10(%ebp)
801011cc:	ff 75 0c             	pushl  0xc(%ebp)
801011cf:	50                   	push   %eax
801011d0:	e8 74 31 00 00       	call   80104349 <piperead>
801011d5:	83 c4 10             	add    $0x10,%esp
801011d8:	eb 77                	jmp    80101251 <fileread+0xb6>
  if(f->type == FD_INODE){
801011da:	8b 45 08             	mov    0x8(%ebp),%eax
801011dd:	8b 00                	mov    (%eax),%eax
801011df:	83 f8 02             	cmp    $0x2,%eax
801011e2:	75 60                	jne    80101244 <fileread+0xa9>
    ilock(f->ip);
801011e4:	8b 45 08             	mov    0x8(%ebp),%eax
801011e7:	8b 40 10             	mov    0x10(%eax),%eax
801011ea:	83 ec 0c             	sub    $0xc,%esp
801011ed:	50                   	push   %eax
801011ee:	e8 82 07 00 00       	call   80101975 <ilock>
801011f3:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801011f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801011f9:	8b 45 08             	mov    0x8(%ebp),%eax
801011fc:	8b 50 14             	mov    0x14(%eax),%edx
801011ff:	8b 45 08             	mov    0x8(%ebp),%eax
80101202:	8b 40 10             	mov    0x10(%eax),%eax
80101205:	51                   	push   %ecx
80101206:	52                   	push   %edx
80101207:	ff 75 0c             	pushl  0xc(%ebp)
8010120a:	50                   	push   %eax
8010120b:	e8 ce 0c 00 00       	call   80101ede <readi>
80101210:	83 c4 10             	add    $0x10,%esp
80101213:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101216:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010121a:	7e 11                	jle    8010122d <fileread+0x92>
      f->off += r;
8010121c:	8b 45 08             	mov    0x8(%ebp),%eax
8010121f:	8b 50 14             	mov    0x14(%eax),%edx
80101222:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101225:	01 c2                	add    %eax,%edx
80101227:	8b 45 08             	mov    0x8(%ebp),%eax
8010122a:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
8010122d:	8b 45 08             	mov    0x8(%ebp),%eax
80101230:	8b 40 10             	mov    0x10(%eax),%eax
80101233:	83 ec 0c             	sub    $0xc,%esp
80101236:	50                   	push   %eax
80101237:	e8 97 08 00 00       	call   80101ad3 <iunlock>
8010123c:	83 c4 10             	add    $0x10,%esp
    return r;
8010123f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101242:	eb 0d                	jmp    80101251 <fileread+0xb6>
  }
  panic("fileread");
80101244:	83 ec 0c             	sub    $0xc,%esp
80101247:	68 93 87 10 80       	push   $0x80108793
8010124c:	e8 16 f3 ff ff       	call   80100567 <panic>
}
80101251:	c9                   	leave  
80101252:	c3                   	ret    

80101253 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101253:	55                   	push   %ebp
80101254:	89 e5                	mov    %esp,%ebp
80101256:	53                   	push   %ebx
80101257:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
8010125a:	8b 45 08             	mov    0x8(%ebp),%eax
8010125d:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101261:	84 c0                	test   %al,%al
80101263:	75 0a                	jne    8010126f <filewrite+0x1c>
    return -1;
80101265:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010126a:	e9 1b 01 00 00       	jmp    8010138a <filewrite+0x137>
  if(f->type == FD_PIPE)
8010126f:	8b 45 08             	mov    0x8(%ebp),%eax
80101272:	8b 00                	mov    (%eax),%eax
80101274:	83 f8 01             	cmp    $0x1,%eax
80101277:	75 1d                	jne    80101296 <filewrite+0x43>
    return pipewrite(f->pipe, addr, n);
80101279:	8b 45 08             	mov    0x8(%ebp),%eax
8010127c:	8b 40 0c             	mov    0xc(%eax),%eax
8010127f:	83 ec 04             	sub    $0x4,%esp
80101282:	ff 75 10             	pushl  0x10(%ebp)
80101285:	ff 75 0c             	pushl  0xc(%ebp)
80101288:	50                   	push   %eax
80101289:	e8 b8 2f 00 00       	call   80104246 <pipewrite>
8010128e:	83 c4 10             	add    $0x10,%esp
80101291:	e9 f4 00 00 00       	jmp    8010138a <filewrite+0x137>
  if(f->type == FD_INODE){
80101296:	8b 45 08             	mov    0x8(%ebp),%eax
80101299:	8b 00                	mov    (%eax),%eax
8010129b:	83 f8 02             	cmp    $0x2,%eax
8010129e:	0f 85 d9 00 00 00    	jne    8010137d <filewrite+0x12a>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
801012a4:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
    int i = 0;
801012ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
801012b2:	e9 a3 00 00 00       	jmp    8010135a <filewrite+0x107>
      int n1 = n - i;
801012b7:	8b 45 10             	mov    0x10(%ebp),%eax
801012ba:	2b 45 f4             	sub    -0xc(%ebp),%eax
801012bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
801012c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801012c3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801012c6:	7e 06                	jle    801012ce <filewrite+0x7b>
        n1 = max;
801012c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801012cb:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
801012ce:	e8 83 22 00 00       	call   80103556 <begin_op>
      ilock(f->ip);
801012d3:	8b 45 08             	mov    0x8(%ebp),%eax
801012d6:	8b 40 10             	mov    0x10(%eax),%eax
801012d9:	83 ec 0c             	sub    $0xc,%esp
801012dc:	50                   	push   %eax
801012dd:	e8 93 06 00 00       	call   80101975 <ilock>
801012e2:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801012e5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801012e8:	8b 45 08             	mov    0x8(%ebp),%eax
801012eb:	8b 50 14             	mov    0x14(%eax),%edx
801012ee:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801012f1:	8b 45 0c             	mov    0xc(%ebp),%eax
801012f4:	01 c3                	add    %eax,%ebx
801012f6:	8b 45 08             	mov    0x8(%ebp),%eax
801012f9:	8b 40 10             	mov    0x10(%eax),%eax
801012fc:	51                   	push   %ecx
801012fd:	52                   	push   %edx
801012fe:	53                   	push   %ebx
801012ff:	50                   	push   %eax
80101300:	e8 30 0d 00 00       	call   80102035 <writei>
80101305:	83 c4 10             	add    $0x10,%esp
80101308:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010130b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010130f:	7e 11                	jle    80101322 <filewrite+0xcf>
        f->off += r;
80101311:	8b 45 08             	mov    0x8(%ebp),%eax
80101314:	8b 50 14             	mov    0x14(%eax),%edx
80101317:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010131a:	01 c2                	add    %eax,%edx
8010131c:	8b 45 08             	mov    0x8(%ebp),%eax
8010131f:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
80101322:	8b 45 08             	mov    0x8(%ebp),%eax
80101325:	8b 40 10             	mov    0x10(%eax),%eax
80101328:	83 ec 0c             	sub    $0xc,%esp
8010132b:	50                   	push   %eax
8010132c:	e8 a2 07 00 00       	call   80101ad3 <iunlock>
80101331:	83 c4 10             	add    $0x10,%esp
      end_op();
80101334:	e8 a9 22 00 00       	call   801035e2 <end_op>

      if(r < 0)
80101339:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010133d:	78 29                	js     80101368 <filewrite+0x115>
        break;
      if(r != n1)
8010133f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101342:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80101345:	74 0d                	je     80101354 <filewrite+0x101>
        panic("short filewrite");
80101347:	83 ec 0c             	sub    $0xc,%esp
8010134a:	68 9c 87 10 80       	push   $0x8010879c
8010134f:	e8 13 f2 ff ff       	call   80100567 <panic>
      i += r;
80101354:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101357:	01 45 f4             	add    %eax,-0xc(%ebp)
    while(i < n){
8010135a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010135d:	3b 45 10             	cmp    0x10(%ebp),%eax
80101360:	0f 8c 51 ff ff ff    	jl     801012b7 <filewrite+0x64>
80101366:	eb 01                	jmp    80101369 <filewrite+0x116>
        break;
80101368:	90                   	nop
    }
    return i == n ? n : -1;
80101369:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010136c:	3b 45 10             	cmp    0x10(%ebp),%eax
8010136f:	75 05                	jne    80101376 <filewrite+0x123>
80101371:	8b 45 10             	mov    0x10(%ebp),%eax
80101374:	eb 14                	jmp    8010138a <filewrite+0x137>
80101376:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010137b:	eb 0d                	jmp    8010138a <filewrite+0x137>
  }
  panic("filewrite");
8010137d:	83 ec 0c             	sub    $0xc,%esp
80101380:	68 ac 87 10 80       	push   $0x801087ac
80101385:	e8 dd f1 ff ff       	call   80100567 <panic>
}
8010138a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010138d:	c9                   	leave  
8010138e:	c3                   	ret    

8010138f <readsb>:
struct superblock sb;   // there should be one per dev, but we run with one dev

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
8010138f:	55                   	push   %ebp
80101390:	89 e5                	mov    %esp,%ebp
80101392:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
80101395:	8b 45 08             	mov    0x8(%ebp),%eax
80101398:	83 ec 08             	sub    $0x8,%esp
8010139b:	6a 01                	push   $0x1
8010139d:	50                   	push   %eax
8010139e:	e8 13 ee ff ff       	call   801001b6 <bread>
801013a3:	83 c4 10             	add    $0x10,%esp
801013a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
801013a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013ac:	83 c0 18             	add    $0x18,%eax
801013af:	83 ec 04             	sub    $0x4,%esp
801013b2:	6a 1c                	push   $0x1c
801013b4:	50                   	push   %eax
801013b5:	ff 75 0c             	pushl  0xc(%ebp)
801013b8:	e8 31 41 00 00       	call   801054ee <memmove>
801013bd:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801013c0:	83 ec 0c             	sub    $0xc,%esp
801013c3:	ff 75 f4             	pushl  -0xc(%ebp)
801013c6:	e8 63 ee ff ff       	call   8010022e <brelse>
801013cb:	83 c4 10             	add    $0x10,%esp
}
801013ce:	90                   	nop
801013cf:	c9                   	leave  
801013d0:	c3                   	ret    

801013d1 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
801013d1:	55                   	push   %ebp
801013d2:	89 e5                	mov    %esp,%ebp
801013d4:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
801013d7:	8b 55 0c             	mov    0xc(%ebp),%edx
801013da:	8b 45 08             	mov    0x8(%ebp),%eax
801013dd:	83 ec 08             	sub    $0x8,%esp
801013e0:	52                   	push   %edx
801013e1:	50                   	push   %eax
801013e2:	e8 cf ed ff ff       	call   801001b6 <bread>
801013e7:	83 c4 10             	add    $0x10,%esp
801013ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
801013ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013f0:	83 c0 18             	add    $0x18,%eax
801013f3:	83 ec 04             	sub    $0x4,%esp
801013f6:	68 00 02 00 00       	push   $0x200
801013fb:	6a 00                	push   $0x0
801013fd:	50                   	push   %eax
801013fe:	e8 2c 40 00 00       	call   8010542f <memset>
80101403:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101406:	83 ec 0c             	sub    $0xc,%esp
80101409:	ff 75 f4             	pushl  -0xc(%ebp)
8010140c:	e8 7d 23 00 00       	call   8010378e <log_write>
80101411:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101414:	83 ec 0c             	sub    $0xc,%esp
80101417:	ff 75 f4             	pushl  -0xc(%ebp)
8010141a:	e8 0f ee ff ff       	call   8010022e <brelse>
8010141f:	83 c4 10             	add    $0x10,%esp
}
80101422:	90                   	nop
80101423:	c9                   	leave  
80101424:	c3                   	ret    

80101425 <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101425:	55                   	push   %ebp
80101426:	89 e5                	mov    %esp,%ebp
80101428:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
8010142b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101432:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101439:	e9 13 01 00 00       	jmp    80101551 <balloc+0x12c>
    bp = bread(dev, BBLOCK(b, sb));
8010143e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101441:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80101447:	85 c0                	test   %eax,%eax
80101449:	0f 48 c2             	cmovs  %edx,%eax
8010144c:	c1 f8 0c             	sar    $0xc,%eax
8010144f:	89 c2                	mov    %eax,%edx
80101451:	a1 38 12 11 80       	mov    0x80111238,%eax
80101456:	01 d0                	add    %edx,%eax
80101458:	83 ec 08             	sub    $0x8,%esp
8010145b:	50                   	push   %eax
8010145c:	ff 75 08             	pushl  0x8(%ebp)
8010145f:	e8 52 ed ff ff       	call   801001b6 <bread>
80101464:	83 c4 10             	add    $0x10,%esp
80101467:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010146a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101471:	e9 a6 00 00 00       	jmp    8010151c <balloc+0xf7>
      m = 1 << (bi % 8);
80101476:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101479:	99                   	cltd   
8010147a:	c1 ea 1d             	shr    $0x1d,%edx
8010147d:	01 d0                	add    %edx,%eax
8010147f:	83 e0 07             	and    $0x7,%eax
80101482:	29 d0                	sub    %edx,%eax
80101484:	ba 01 00 00 00       	mov    $0x1,%edx
80101489:	89 c1                	mov    %eax,%ecx
8010148b:	d3 e2                	shl    %cl,%edx
8010148d:	89 d0                	mov    %edx,%eax
8010148f:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101492:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101495:	8d 50 07             	lea    0x7(%eax),%edx
80101498:	85 c0                	test   %eax,%eax
8010149a:	0f 48 c2             	cmovs  %edx,%eax
8010149d:	c1 f8 03             	sar    $0x3,%eax
801014a0:	89 c2                	mov    %eax,%edx
801014a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801014a5:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
801014aa:	0f b6 c0             	movzbl %al,%eax
801014ad:	23 45 e8             	and    -0x18(%ebp),%eax
801014b0:	85 c0                	test   %eax,%eax
801014b2:	75 64                	jne    80101518 <balloc+0xf3>
        bp->data[bi/8] |= m;  // Mark block in use.
801014b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014b7:	8d 50 07             	lea    0x7(%eax),%edx
801014ba:	85 c0                	test   %eax,%eax
801014bc:	0f 48 c2             	cmovs  %edx,%eax
801014bf:	c1 f8 03             	sar    $0x3,%eax
801014c2:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014c5:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801014ca:	89 d1                	mov    %edx,%ecx
801014cc:	8b 55 e8             	mov    -0x18(%ebp),%edx
801014cf:	09 ca                	or     %ecx,%edx
801014d1:	89 d1                	mov    %edx,%ecx
801014d3:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014d6:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
801014da:	83 ec 0c             	sub    $0xc,%esp
801014dd:	ff 75 ec             	pushl  -0x14(%ebp)
801014e0:	e8 a9 22 00 00       	call   8010378e <log_write>
801014e5:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
801014e8:	83 ec 0c             	sub    $0xc,%esp
801014eb:	ff 75 ec             	pushl  -0x14(%ebp)
801014ee:	e8 3b ed ff ff       	call   8010022e <brelse>
801014f3:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
801014f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014fc:	01 c2                	add    %eax,%edx
801014fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101501:	83 ec 08             	sub    $0x8,%esp
80101504:	52                   	push   %edx
80101505:	50                   	push   %eax
80101506:	e8 c6 fe ff ff       	call   801013d1 <bzero>
8010150b:	83 c4 10             	add    $0x10,%esp
        return b + bi;
8010150e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101511:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101514:	01 d0                	add    %edx,%eax
80101516:	eb 57                	jmp    8010156f <balloc+0x14a>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101518:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010151c:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
80101523:	7f 17                	jg     8010153c <balloc+0x117>
80101525:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101528:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010152b:	01 d0                	add    %edx,%eax
8010152d:	89 c2                	mov    %eax,%edx
8010152f:	a1 20 12 11 80       	mov    0x80111220,%eax
80101534:	39 c2                	cmp    %eax,%edx
80101536:	0f 82 3a ff ff ff    	jb     80101476 <balloc+0x51>
      }
    }
    brelse(bp);
8010153c:	83 ec 0c             	sub    $0xc,%esp
8010153f:	ff 75 ec             	pushl  -0x14(%ebp)
80101542:	e8 e7 ec ff ff       	call   8010022e <brelse>
80101547:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
8010154a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80101551:	8b 15 20 12 11 80    	mov    0x80111220,%edx
80101557:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010155a:	39 c2                	cmp    %eax,%edx
8010155c:	0f 87 dc fe ff ff    	ja     8010143e <balloc+0x19>
  }
  panic("balloc: out of blocks");
80101562:	83 ec 0c             	sub    $0xc,%esp
80101565:	68 b8 87 10 80       	push   $0x801087b8
8010156a:	e8 f8 ef ff ff       	call   80100567 <panic>
}
8010156f:	c9                   	leave  
80101570:	c3                   	ret    

80101571 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101571:	55                   	push   %ebp
80101572:	89 e5                	mov    %esp,%ebp
80101574:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
80101577:	83 ec 08             	sub    $0x8,%esp
8010157a:	68 20 12 11 80       	push   $0x80111220
8010157f:	ff 75 08             	pushl  0x8(%ebp)
80101582:	e8 08 fe ff ff       	call   8010138f <readsb>
80101587:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
8010158a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010158d:	c1 e8 0c             	shr    $0xc,%eax
80101590:	89 c2                	mov    %eax,%edx
80101592:	a1 38 12 11 80       	mov    0x80111238,%eax
80101597:	01 c2                	add    %eax,%edx
80101599:	8b 45 08             	mov    0x8(%ebp),%eax
8010159c:	83 ec 08             	sub    $0x8,%esp
8010159f:	52                   	push   %edx
801015a0:	50                   	push   %eax
801015a1:	e8 10 ec ff ff       	call   801001b6 <bread>
801015a6:	83 c4 10             	add    $0x10,%esp
801015a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
801015ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801015af:	25 ff 0f 00 00       	and    $0xfff,%eax
801015b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
801015b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015ba:	99                   	cltd   
801015bb:	c1 ea 1d             	shr    $0x1d,%edx
801015be:	01 d0                	add    %edx,%eax
801015c0:	83 e0 07             	and    $0x7,%eax
801015c3:	29 d0                	sub    %edx,%eax
801015c5:	ba 01 00 00 00       	mov    $0x1,%edx
801015ca:	89 c1                	mov    %eax,%ecx
801015cc:	d3 e2                	shl    %cl,%edx
801015ce:	89 d0                	mov    %edx,%eax
801015d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
801015d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015d6:	8d 50 07             	lea    0x7(%eax),%edx
801015d9:	85 c0                	test   %eax,%eax
801015db:	0f 48 c2             	cmovs  %edx,%eax
801015de:	c1 f8 03             	sar    $0x3,%eax
801015e1:	89 c2                	mov    %eax,%edx
801015e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015e6:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
801015eb:	0f b6 c0             	movzbl %al,%eax
801015ee:	23 45 ec             	and    -0x14(%ebp),%eax
801015f1:	85 c0                	test   %eax,%eax
801015f3:	75 0d                	jne    80101602 <bfree+0x91>
    panic("freeing free block");
801015f5:	83 ec 0c             	sub    $0xc,%esp
801015f8:	68 ce 87 10 80       	push   $0x801087ce
801015fd:	e8 65 ef ff ff       	call   80100567 <panic>
  bp->data[bi/8] &= ~m;
80101602:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101605:	8d 50 07             	lea    0x7(%eax),%edx
80101608:	85 c0                	test   %eax,%eax
8010160a:	0f 48 c2             	cmovs  %edx,%eax
8010160d:	c1 f8 03             	sar    $0x3,%eax
80101610:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101613:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101618:	89 d1                	mov    %edx,%ecx
8010161a:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010161d:	f7 d2                	not    %edx
8010161f:	21 ca                	and    %ecx,%edx
80101621:	89 d1                	mov    %edx,%ecx
80101623:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101626:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
8010162a:	83 ec 0c             	sub    $0xc,%esp
8010162d:	ff 75 f4             	pushl  -0xc(%ebp)
80101630:	e8 59 21 00 00       	call   8010378e <log_write>
80101635:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101638:	83 ec 0c             	sub    $0xc,%esp
8010163b:	ff 75 f4             	pushl  -0xc(%ebp)
8010163e:	e8 eb eb ff ff       	call   8010022e <brelse>
80101643:	83 c4 10             	add    $0x10,%esp
}
80101646:	90                   	nop
80101647:	c9                   	leave  
80101648:	c3                   	ret    

80101649 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101649:	55                   	push   %ebp
8010164a:	89 e5                	mov    %esp,%ebp
8010164c:	57                   	push   %edi
8010164d:	56                   	push   %esi
8010164e:	53                   	push   %ebx
8010164f:	83 ec 1c             	sub    $0x1c,%esp
  initlock(&icache.lock, "icache");
80101652:	83 ec 08             	sub    $0x8,%esp
80101655:	68 e1 87 10 80       	push   $0x801087e1
8010165a:	68 40 12 11 80       	push   $0x80111240
8010165f:	e8 46 3b 00 00       	call   801051aa <initlock>
80101664:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
80101667:	83 ec 08             	sub    $0x8,%esp
8010166a:	68 20 12 11 80       	push   $0x80111220
8010166f:	ff 75 08             	pushl  0x8(%ebp)
80101672:	e8 18 fd ff ff       	call   8010138f <readsb>
80101677:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d inodestart %d bmap start %d\n", sb.size,
8010167a:	a1 38 12 11 80       	mov    0x80111238,%eax
8010167f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101682:	8b 3d 34 12 11 80    	mov    0x80111234,%edi
80101688:	8b 35 30 12 11 80    	mov    0x80111230,%esi
8010168e:	8b 1d 2c 12 11 80    	mov    0x8011122c,%ebx
80101694:	8b 0d 28 12 11 80    	mov    0x80111228,%ecx
8010169a:	8b 15 24 12 11 80    	mov    0x80111224,%edx
801016a0:	a1 20 12 11 80       	mov    0x80111220,%eax
801016a5:	ff 75 e4             	pushl  -0x1c(%ebp)
801016a8:	57                   	push   %edi
801016a9:	56                   	push   %esi
801016aa:	53                   	push   %ebx
801016ab:	51                   	push   %ecx
801016ac:	52                   	push   %edx
801016ad:	50                   	push   %eax
801016ae:	68 e8 87 10 80       	push   $0x801087e8
801016b3:	e8 0c ed ff ff       	call   801003c4 <cprintf>
801016b8:	83 c4 20             	add    $0x20,%esp
          sb.nblocks, sb.ninodes, sb.nlog, sb.logstart, sb.inodestart, sb.bmapstart);
}
801016bb:	90                   	nop
801016bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016bf:	5b                   	pop    %ebx
801016c0:	5e                   	pop    %esi
801016c1:	5f                   	pop    %edi
801016c2:	5d                   	pop    %ebp
801016c3:	c3                   	ret    

801016c4 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801016c4:	55                   	push   %ebp
801016c5:	89 e5                	mov    %esp,%ebp
801016c7:	83 ec 28             	sub    $0x28,%esp
801016ca:	8b 45 0c             	mov    0xc(%ebp),%eax
801016cd:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016d1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
801016d8:	e9 9e 00 00 00       	jmp    8010177b <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
801016dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016e0:	c1 e8 03             	shr    $0x3,%eax
801016e3:	89 c2                	mov    %eax,%edx
801016e5:	a1 34 12 11 80       	mov    0x80111234,%eax
801016ea:	01 d0                	add    %edx,%eax
801016ec:	83 ec 08             	sub    $0x8,%esp
801016ef:	50                   	push   %eax
801016f0:	ff 75 08             	pushl  0x8(%ebp)
801016f3:	e8 be ea ff ff       	call   801001b6 <bread>
801016f8:	83 c4 10             	add    $0x10,%esp
801016fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
801016fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101701:	8d 50 18             	lea    0x18(%eax),%edx
80101704:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101707:	83 e0 07             	and    $0x7,%eax
8010170a:	c1 e0 06             	shl    $0x6,%eax
8010170d:	01 d0                	add    %edx,%eax
8010170f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
80101712:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101715:	0f b7 00             	movzwl (%eax),%eax
80101718:	66 85 c0             	test   %ax,%ax
8010171b:	75 4c                	jne    80101769 <ialloc+0xa5>
      memset(dip, 0, sizeof(*dip));
8010171d:	83 ec 04             	sub    $0x4,%esp
80101720:	6a 40                	push   $0x40
80101722:	6a 00                	push   $0x0
80101724:	ff 75 ec             	pushl  -0x14(%ebp)
80101727:	e8 03 3d 00 00       	call   8010542f <memset>
8010172c:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
8010172f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101732:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
80101736:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
80101739:	83 ec 0c             	sub    $0xc,%esp
8010173c:	ff 75 f0             	pushl  -0x10(%ebp)
8010173f:	e8 4a 20 00 00       	call   8010378e <log_write>
80101744:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
80101747:	83 ec 0c             	sub    $0xc,%esp
8010174a:	ff 75 f0             	pushl  -0x10(%ebp)
8010174d:	e8 dc ea ff ff       	call   8010022e <brelse>
80101752:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
80101755:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101758:	83 ec 08             	sub    $0x8,%esp
8010175b:	50                   	push   %eax
8010175c:	ff 75 08             	pushl  0x8(%ebp)
8010175f:	e8 f8 00 00 00       	call   8010185c <iget>
80101764:	83 c4 10             	add    $0x10,%esp
80101767:	eb 30                	jmp    80101799 <ialloc+0xd5>
    }
    brelse(bp);
80101769:	83 ec 0c             	sub    $0xc,%esp
8010176c:	ff 75 f0             	pushl  -0x10(%ebp)
8010176f:	e8 ba ea ff ff       	call   8010022e <brelse>
80101774:	83 c4 10             	add    $0x10,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101777:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010177b:	8b 15 28 12 11 80    	mov    0x80111228,%edx
80101781:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101784:	39 c2                	cmp    %eax,%edx
80101786:	0f 87 51 ff ff ff    	ja     801016dd <ialloc+0x19>
  }
  panic("ialloc: no inodes");
8010178c:	83 ec 0c             	sub    $0xc,%esp
8010178f:	68 3b 88 10 80       	push   $0x8010883b
80101794:	e8 ce ed ff ff       	call   80100567 <panic>
}
80101799:	c9                   	leave  
8010179a:	c3                   	ret    

8010179b <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
8010179b:	55                   	push   %ebp
8010179c:	89 e5                	mov    %esp,%ebp
8010179e:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017a1:	8b 45 08             	mov    0x8(%ebp),%eax
801017a4:	8b 40 04             	mov    0x4(%eax),%eax
801017a7:	c1 e8 03             	shr    $0x3,%eax
801017aa:	89 c2                	mov    %eax,%edx
801017ac:	a1 34 12 11 80       	mov    0x80111234,%eax
801017b1:	01 c2                	add    %eax,%edx
801017b3:	8b 45 08             	mov    0x8(%ebp),%eax
801017b6:	8b 00                	mov    (%eax),%eax
801017b8:	83 ec 08             	sub    $0x8,%esp
801017bb:	52                   	push   %edx
801017bc:	50                   	push   %eax
801017bd:	e8 f4 e9 ff ff       	call   801001b6 <bread>
801017c2:	83 c4 10             	add    $0x10,%esp
801017c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017cb:	8d 50 18             	lea    0x18(%eax),%edx
801017ce:	8b 45 08             	mov    0x8(%ebp),%eax
801017d1:	8b 40 04             	mov    0x4(%eax),%eax
801017d4:	83 e0 07             	and    $0x7,%eax
801017d7:	c1 e0 06             	shl    $0x6,%eax
801017da:	01 d0                	add    %edx,%eax
801017dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
801017df:	8b 45 08             	mov    0x8(%ebp),%eax
801017e2:	0f b7 50 10          	movzwl 0x10(%eax),%edx
801017e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017e9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801017ec:	8b 45 08             	mov    0x8(%ebp),%eax
801017ef:	0f b7 50 12          	movzwl 0x12(%eax),%edx
801017f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017f6:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
801017fa:	8b 45 08             	mov    0x8(%ebp),%eax
801017fd:	0f b7 50 14          	movzwl 0x14(%eax),%edx
80101801:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101804:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101808:	8b 45 08             	mov    0x8(%ebp),%eax
8010180b:	0f b7 50 16          	movzwl 0x16(%eax),%edx
8010180f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101812:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101816:	8b 45 08             	mov    0x8(%ebp),%eax
80101819:	8b 50 18             	mov    0x18(%eax),%edx
8010181c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010181f:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101822:	8b 45 08             	mov    0x8(%ebp),%eax
80101825:	8d 50 1c             	lea    0x1c(%eax),%edx
80101828:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010182b:	83 c0 0c             	add    $0xc,%eax
8010182e:	83 ec 04             	sub    $0x4,%esp
80101831:	6a 34                	push   $0x34
80101833:	52                   	push   %edx
80101834:	50                   	push   %eax
80101835:	e8 b4 3c 00 00       	call   801054ee <memmove>
8010183a:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
8010183d:	83 ec 0c             	sub    $0xc,%esp
80101840:	ff 75 f4             	pushl  -0xc(%ebp)
80101843:	e8 46 1f 00 00       	call   8010378e <log_write>
80101848:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010184b:	83 ec 0c             	sub    $0xc,%esp
8010184e:	ff 75 f4             	pushl  -0xc(%ebp)
80101851:	e8 d8 e9 ff ff       	call   8010022e <brelse>
80101856:	83 c4 10             	add    $0x10,%esp
}
80101859:	90                   	nop
8010185a:	c9                   	leave  
8010185b:	c3                   	ret    

8010185c <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010185c:	55                   	push   %ebp
8010185d:	89 e5                	mov    %esp,%ebp
8010185f:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101862:	83 ec 0c             	sub    $0xc,%esp
80101865:	68 40 12 11 80       	push   $0x80111240
8010186a:	e8 5d 39 00 00       	call   801051cc <acquire>
8010186f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
80101872:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101879:	c7 45 f4 74 12 11 80 	movl   $0x80111274,-0xc(%ebp)
80101880:	eb 5d                	jmp    801018df <iget+0x83>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101882:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101885:	8b 40 08             	mov    0x8(%eax),%eax
80101888:	85 c0                	test   %eax,%eax
8010188a:	7e 39                	jle    801018c5 <iget+0x69>
8010188c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010188f:	8b 00                	mov    (%eax),%eax
80101891:	39 45 08             	cmp    %eax,0x8(%ebp)
80101894:	75 2f                	jne    801018c5 <iget+0x69>
80101896:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101899:	8b 40 04             	mov    0x4(%eax),%eax
8010189c:	39 45 0c             	cmp    %eax,0xc(%ebp)
8010189f:	75 24                	jne    801018c5 <iget+0x69>
      ip->ref++;
801018a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018a4:	8b 40 08             	mov    0x8(%eax),%eax
801018a7:	8d 50 01             	lea    0x1(%eax),%edx
801018aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018ad:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
801018b0:	83 ec 0c             	sub    $0xc,%esp
801018b3:	68 40 12 11 80       	push   $0x80111240
801018b8:	e8 76 39 00 00       	call   80105233 <release>
801018bd:	83 c4 10             	add    $0x10,%esp
      return ip;
801018c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018c3:	eb 74                	jmp    80101939 <iget+0xdd>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801018c5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801018c9:	75 10                	jne    801018db <iget+0x7f>
801018cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018ce:	8b 40 08             	mov    0x8(%eax),%eax
801018d1:	85 c0                	test   %eax,%eax
801018d3:	75 06                	jne    801018db <iget+0x7f>
      empty = ip;
801018d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018db:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
801018df:	81 7d f4 14 22 11 80 	cmpl   $0x80112214,-0xc(%ebp)
801018e6:	72 9a                	jb     80101882 <iget+0x26>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801018e8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801018ec:	75 0d                	jne    801018fb <iget+0x9f>
    panic("iget: no inodes");
801018ee:	83 ec 0c             	sub    $0xc,%esp
801018f1:	68 4d 88 10 80       	push   $0x8010884d
801018f6:	e8 6c ec ff ff       	call   80100567 <panic>

  ip = empty;
801018fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101901:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101904:	8b 55 08             	mov    0x8(%ebp),%edx
80101907:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101909:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010190c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010190f:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101912:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101915:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
8010191c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010191f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
80101926:	83 ec 0c             	sub    $0xc,%esp
80101929:	68 40 12 11 80       	push   $0x80111240
8010192e:	e8 00 39 00 00       	call   80105233 <release>
80101933:	83 c4 10             	add    $0x10,%esp

  return ip;
80101936:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80101939:	c9                   	leave  
8010193a:	c3                   	ret    

8010193b <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
8010193b:	55                   	push   %ebp
8010193c:	89 e5                	mov    %esp,%ebp
8010193e:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101941:	83 ec 0c             	sub    $0xc,%esp
80101944:	68 40 12 11 80       	push   $0x80111240
80101949:	e8 7e 38 00 00       	call   801051cc <acquire>
8010194e:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
80101951:	8b 45 08             	mov    0x8(%ebp),%eax
80101954:	8b 40 08             	mov    0x8(%eax),%eax
80101957:	8d 50 01             	lea    0x1(%eax),%edx
8010195a:	8b 45 08             	mov    0x8(%ebp),%eax
8010195d:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101960:	83 ec 0c             	sub    $0xc,%esp
80101963:	68 40 12 11 80       	push   $0x80111240
80101968:	e8 c6 38 00 00       	call   80105233 <release>
8010196d:	83 c4 10             	add    $0x10,%esp
  return ip;
80101970:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101973:	c9                   	leave  
80101974:	c3                   	ret    

80101975 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101975:	55                   	push   %ebp
80101976:	89 e5                	mov    %esp,%ebp
80101978:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
8010197b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010197f:	74 0a                	je     8010198b <ilock+0x16>
80101981:	8b 45 08             	mov    0x8(%ebp),%eax
80101984:	8b 40 08             	mov    0x8(%eax),%eax
80101987:	85 c0                	test   %eax,%eax
80101989:	7f 0d                	jg     80101998 <ilock+0x23>
    panic("ilock");
8010198b:	83 ec 0c             	sub    $0xc,%esp
8010198e:	68 5d 88 10 80       	push   $0x8010885d
80101993:	e8 cf eb ff ff       	call   80100567 <panic>

  acquire(&icache.lock);
80101998:	83 ec 0c             	sub    $0xc,%esp
8010199b:	68 40 12 11 80       	push   $0x80111240
801019a0:	e8 27 38 00 00       	call   801051cc <acquire>
801019a5:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
801019a8:	eb 13                	jmp    801019bd <ilock+0x48>
    sleep(ip, &icache.lock);
801019aa:	83 ec 08             	sub    $0x8,%esp
801019ad:	68 40 12 11 80       	push   $0x80111240
801019b2:	ff 75 08             	pushl  0x8(%ebp)
801019b5:	e8 06 35 00 00       	call   80104ec0 <sleep>
801019ba:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
801019bd:	8b 45 08             	mov    0x8(%ebp),%eax
801019c0:	8b 40 0c             	mov    0xc(%eax),%eax
801019c3:	83 e0 01             	and    $0x1,%eax
801019c6:	85 c0                	test   %eax,%eax
801019c8:	75 e0                	jne    801019aa <ilock+0x35>
  ip->flags |= I_BUSY;
801019ca:	8b 45 08             	mov    0x8(%ebp),%eax
801019cd:	8b 40 0c             	mov    0xc(%eax),%eax
801019d0:	83 c8 01             	or     $0x1,%eax
801019d3:	89 c2                	mov    %eax,%edx
801019d5:	8b 45 08             	mov    0x8(%ebp),%eax
801019d8:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
801019db:	83 ec 0c             	sub    $0xc,%esp
801019de:	68 40 12 11 80       	push   $0x80111240
801019e3:	e8 4b 38 00 00       	call   80105233 <release>
801019e8:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
801019eb:	8b 45 08             	mov    0x8(%ebp),%eax
801019ee:	8b 40 0c             	mov    0xc(%eax),%eax
801019f1:	83 e0 02             	and    $0x2,%eax
801019f4:	85 c0                	test   %eax,%eax
801019f6:	0f 85 d4 00 00 00    	jne    80101ad0 <ilock+0x15b>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019fc:	8b 45 08             	mov    0x8(%ebp),%eax
801019ff:	8b 40 04             	mov    0x4(%eax),%eax
80101a02:	c1 e8 03             	shr    $0x3,%eax
80101a05:	89 c2                	mov    %eax,%edx
80101a07:	a1 34 12 11 80       	mov    0x80111234,%eax
80101a0c:	01 c2                	add    %eax,%edx
80101a0e:	8b 45 08             	mov    0x8(%ebp),%eax
80101a11:	8b 00                	mov    (%eax),%eax
80101a13:	83 ec 08             	sub    $0x8,%esp
80101a16:	52                   	push   %edx
80101a17:	50                   	push   %eax
80101a18:	e8 99 e7 ff ff       	call   801001b6 <bread>
80101a1d:	83 c4 10             	add    $0x10,%esp
80101a20:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a26:	8d 50 18             	lea    0x18(%eax),%edx
80101a29:	8b 45 08             	mov    0x8(%ebp),%eax
80101a2c:	8b 40 04             	mov    0x4(%eax),%eax
80101a2f:	83 e0 07             	and    $0x7,%eax
80101a32:	c1 e0 06             	shl    $0x6,%eax
80101a35:	01 d0                	add    %edx,%eax
80101a37:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101a3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a3d:	0f b7 10             	movzwl (%eax),%edx
80101a40:	8b 45 08             	mov    0x8(%ebp),%eax
80101a43:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101a47:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a4a:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101a4e:	8b 45 08             	mov    0x8(%ebp),%eax
80101a51:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80101a55:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a58:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101a5c:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5f:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101a63:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a66:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101a6a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6d:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
80101a71:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a74:	8b 50 08             	mov    0x8(%eax),%edx
80101a77:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7a:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a80:	8d 50 0c             	lea    0xc(%eax),%edx
80101a83:	8b 45 08             	mov    0x8(%ebp),%eax
80101a86:	83 c0 1c             	add    $0x1c,%eax
80101a89:	83 ec 04             	sub    $0x4,%esp
80101a8c:	6a 34                	push   $0x34
80101a8e:	52                   	push   %edx
80101a8f:	50                   	push   %eax
80101a90:	e8 59 3a 00 00       	call   801054ee <memmove>
80101a95:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101a98:	83 ec 0c             	sub    $0xc,%esp
80101a9b:	ff 75 f4             	pushl  -0xc(%ebp)
80101a9e:	e8 8b e7 ff ff       	call   8010022e <brelse>
80101aa3:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101aa6:	8b 45 08             	mov    0x8(%ebp),%eax
80101aa9:	8b 40 0c             	mov    0xc(%eax),%eax
80101aac:	83 c8 02             	or     $0x2,%eax
80101aaf:	89 c2                	mov    %eax,%edx
80101ab1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ab4:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101ab7:	8b 45 08             	mov    0x8(%ebp),%eax
80101aba:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101abe:	66 85 c0             	test   %ax,%ax
80101ac1:	75 0d                	jne    80101ad0 <ilock+0x15b>
      panic("ilock: no type");
80101ac3:	83 ec 0c             	sub    $0xc,%esp
80101ac6:	68 63 88 10 80       	push   $0x80108863
80101acb:	e8 97 ea ff ff       	call   80100567 <panic>
  }
}
80101ad0:	90                   	nop
80101ad1:	c9                   	leave  
80101ad2:	c3                   	ret    

80101ad3 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101ad3:	55                   	push   %ebp
80101ad4:	89 e5                	mov    %esp,%ebp
80101ad6:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101ad9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101add:	74 17                	je     80101af6 <iunlock+0x23>
80101adf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae2:	8b 40 0c             	mov    0xc(%eax),%eax
80101ae5:	83 e0 01             	and    $0x1,%eax
80101ae8:	85 c0                	test   %eax,%eax
80101aea:	74 0a                	je     80101af6 <iunlock+0x23>
80101aec:	8b 45 08             	mov    0x8(%ebp),%eax
80101aef:	8b 40 08             	mov    0x8(%eax),%eax
80101af2:	85 c0                	test   %eax,%eax
80101af4:	7f 0d                	jg     80101b03 <iunlock+0x30>
    panic("iunlock");
80101af6:	83 ec 0c             	sub    $0xc,%esp
80101af9:	68 72 88 10 80       	push   $0x80108872
80101afe:	e8 64 ea ff ff       	call   80100567 <panic>

  acquire(&icache.lock);
80101b03:	83 ec 0c             	sub    $0xc,%esp
80101b06:	68 40 12 11 80       	push   $0x80111240
80101b0b:	e8 bc 36 00 00       	call   801051cc <acquire>
80101b10:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101b13:	8b 45 08             	mov    0x8(%ebp),%eax
80101b16:	8b 40 0c             	mov    0xc(%eax),%eax
80101b19:	83 e0 fe             	and    $0xfffffffe,%eax
80101b1c:	89 c2                	mov    %eax,%edx
80101b1e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b21:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101b24:	83 ec 0c             	sub    $0xc,%esp
80101b27:	ff 75 08             	pushl  0x8(%ebp)
80101b2a:	e8 7f 34 00 00       	call   80104fae <wakeup>
80101b2f:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101b32:	83 ec 0c             	sub    $0xc,%esp
80101b35:	68 40 12 11 80       	push   $0x80111240
80101b3a:	e8 f4 36 00 00       	call   80105233 <release>
80101b3f:	83 c4 10             	add    $0x10,%esp
}
80101b42:	90                   	nop
80101b43:	c9                   	leave  
80101b44:	c3                   	ret    

80101b45 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101b45:	55                   	push   %ebp
80101b46:	89 e5                	mov    %esp,%ebp
80101b48:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101b4b:	83 ec 0c             	sub    $0xc,%esp
80101b4e:	68 40 12 11 80       	push   $0x80111240
80101b53:	e8 74 36 00 00       	call   801051cc <acquire>
80101b58:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101b5b:	8b 45 08             	mov    0x8(%ebp),%eax
80101b5e:	8b 40 08             	mov    0x8(%eax),%eax
80101b61:	83 f8 01             	cmp    $0x1,%eax
80101b64:	0f 85 a9 00 00 00    	jne    80101c13 <iput+0xce>
80101b6a:	8b 45 08             	mov    0x8(%ebp),%eax
80101b6d:	8b 40 0c             	mov    0xc(%eax),%eax
80101b70:	83 e0 02             	and    $0x2,%eax
80101b73:	85 c0                	test   %eax,%eax
80101b75:	0f 84 98 00 00 00    	je     80101c13 <iput+0xce>
80101b7b:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7e:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101b82:	66 85 c0             	test   %ax,%ax
80101b85:	0f 85 88 00 00 00    	jne    80101c13 <iput+0xce>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
80101b8b:	8b 45 08             	mov    0x8(%ebp),%eax
80101b8e:	8b 40 0c             	mov    0xc(%eax),%eax
80101b91:	83 e0 01             	and    $0x1,%eax
80101b94:	85 c0                	test   %eax,%eax
80101b96:	74 0d                	je     80101ba5 <iput+0x60>
      panic("iput busy");
80101b98:	83 ec 0c             	sub    $0xc,%esp
80101b9b:	68 7a 88 10 80       	push   $0x8010887a
80101ba0:	e8 c2 e9 ff ff       	call   80100567 <panic>
    ip->flags |= I_BUSY;
80101ba5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba8:	8b 40 0c             	mov    0xc(%eax),%eax
80101bab:	83 c8 01             	or     $0x1,%eax
80101bae:	89 c2                	mov    %eax,%edx
80101bb0:	8b 45 08             	mov    0x8(%ebp),%eax
80101bb3:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101bb6:	83 ec 0c             	sub    $0xc,%esp
80101bb9:	68 40 12 11 80       	push   $0x80111240
80101bbe:	e8 70 36 00 00       	call   80105233 <release>
80101bc3:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101bc6:	83 ec 0c             	sub    $0xc,%esp
80101bc9:	ff 75 08             	pushl  0x8(%ebp)
80101bcc:	e8 a3 01 00 00       	call   80101d74 <itrunc>
80101bd1:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101bd4:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd7:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101bdd:	83 ec 0c             	sub    $0xc,%esp
80101be0:	ff 75 08             	pushl  0x8(%ebp)
80101be3:	e8 b3 fb ff ff       	call   8010179b <iupdate>
80101be8:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101beb:	83 ec 0c             	sub    $0xc,%esp
80101bee:	68 40 12 11 80       	push   $0x80111240
80101bf3:	e8 d4 35 00 00       	call   801051cc <acquire>
80101bf8:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101bfb:	8b 45 08             	mov    0x8(%ebp),%eax
80101bfe:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101c05:	83 ec 0c             	sub    $0xc,%esp
80101c08:	ff 75 08             	pushl  0x8(%ebp)
80101c0b:	e8 9e 33 00 00       	call   80104fae <wakeup>
80101c10:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101c13:	8b 45 08             	mov    0x8(%ebp),%eax
80101c16:	8b 40 08             	mov    0x8(%eax),%eax
80101c19:	8d 50 ff             	lea    -0x1(%eax),%edx
80101c1c:	8b 45 08             	mov    0x8(%ebp),%eax
80101c1f:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101c22:	83 ec 0c             	sub    $0xc,%esp
80101c25:	68 40 12 11 80       	push   $0x80111240
80101c2a:	e8 04 36 00 00       	call   80105233 <release>
80101c2f:	83 c4 10             	add    $0x10,%esp
}
80101c32:	90                   	nop
80101c33:	c9                   	leave  
80101c34:	c3                   	ret    

80101c35 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101c35:	55                   	push   %ebp
80101c36:	89 e5                	mov    %esp,%ebp
80101c38:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101c3b:	83 ec 0c             	sub    $0xc,%esp
80101c3e:	ff 75 08             	pushl  0x8(%ebp)
80101c41:	e8 8d fe ff ff       	call   80101ad3 <iunlock>
80101c46:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101c49:	83 ec 0c             	sub    $0xc,%esp
80101c4c:	ff 75 08             	pushl  0x8(%ebp)
80101c4f:	e8 f1 fe ff ff       	call   80101b45 <iput>
80101c54:	83 c4 10             	add    $0x10,%esp
}
80101c57:	90                   	nop
80101c58:	c9                   	leave  
80101c59:	c3                   	ret    

80101c5a <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101c5a:	55                   	push   %ebp
80101c5b:	89 e5                	mov    %esp,%ebp
80101c5d:	83 ec 18             	sub    $0x18,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101c60:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101c64:	77 42                	ja     80101ca8 <bmap+0x4e>
    if((addr = ip->addrs[bn]) == 0)
80101c66:	8b 45 08             	mov    0x8(%ebp),%eax
80101c69:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c6c:	83 c2 04             	add    $0x4,%edx
80101c6f:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c73:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c76:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c7a:	75 24                	jne    80101ca0 <bmap+0x46>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101c7c:	8b 45 08             	mov    0x8(%ebp),%eax
80101c7f:	8b 00                	mov    (%eax),%eax
80101c81:	83 ec 0c             	sub    $0xc,%esp
80101c84:	50                   	push   %eax
80101c85:	e8 9b f7 ff ff       	call   80101425 <balloc>
80101c8a:	83 c4 10             	add    $0x10,%esp
80101c8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c90:	8b 45 08             	mov    0x8(%ebp),%eax
80101c93:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c96:	8d 4a 04             	lea    0x4(%edx),%ecx
80101c99:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c9c:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101ca0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ca3:	e9 ca 00 00 00       	jmp    80101d72 <bmap+0x118>
  }
  bn -= NDIRECT;
80101ca8:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101cac:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101cb0:	0f 87 af 00 00 00    	ja     80101d65 <bmap+0x10b>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101cb6:	8b 45 08             	mov    0x8(%ebp),%eax
80101cb9:	8b 40 4c             	mov    0x4c(%eax),%eax
80101cbc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cbf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101cc3:	75 1d                	jne    80101ce2 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101cc5:	8b 45 08             	mov    0x8(%ebp),%eax
80101cc8:	8b 00                	mov    (%eax),%eax
80101cca:	83 ec 0c             	sub    $0xc,%esp
80101ccd:	50                   	push   %eax
80101cce:	e8 52 f7 ff ff       	call   80101425 <balloc>
80101cd3:	83 c4 10             	add    $0x10,%esp
80101cd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cd9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cdc:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cdf:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101ce2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ce5:	8b 00                	mov    (%eax),%eax
80101ce7:	83 ec 08             	sub    $0x8,%esp
80101cea:	ff 75 f4             	pushl  -0xc(%ebp)
80101ced:	50                   	push   %eax
80101cee:	e8 c3 e4 ff ff       	call   801001b6 <bread>
80101cf3:	83 c4 10             	add    $0x10,%esp
80101cf6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101cf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cfc:	83 c0 18             	add    $0x18,%eax
80101cff:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101d02:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d05:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d0f:	01 d0                	add    %edx,%eax
80101d11:	8b 00                	mov    (%eax),%eax
80101d13:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d16:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101d1a:	75 36                	jne    80101d52 <bmap+0xf8>
      a[bn] = addr = balloc(ip->dev);
80101d1c:	8b 45 08             	mov    0x8(%ebp),%eax
80101d1f:	8b 00                	mov    (%eax),%eax
80101d21:	83 ec 0c             	sub    $0xc,%esp
80101d24:	50                   	push   %eax
80101d25:	e8 fb f6 ff ff       	call   80101425 <balloc>
80101d2a:	83 c4 10             	add    $0x10,%esp
80101d2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d30:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d33:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d3d:	01 c2                	add    %eax,%edx
80101d3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d42:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101d44:	83 ec 0c             	sub    $0xc,%esp
80101d47:	ff 75 f0             	pushl  -0x10(%ebp)
80101d4a:	e8 3f 1a 00 00       	call   8010378e <log_write>
80101d4f:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101d52:	83 ec 0c             	sub    $0xc,%esp
80101d55:	ff 75 f0             	pushl  -0x10(%ebp)
80101d58:	e8 d1 e4 ff ff       	call   8010022e <brelse>
80101d5d:	83 c4 10             	add    $0x10,%esp
    return addr;
80101d60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d63:	eb 0d                	jmp    80101d72 <bmap+0x118>
  }

  panic("bmap: out of range");
80101d65:	83 ec 0c             	sub    $0xc,%esp
80101d68:	68 84 88 10 80       	push   $0x80108884
80101d6d:	e8 f5 e7 ff ff       	call   80100567 <panic>
}
80101d72:	c9                   	leave  
80101d73:	c3                   	ret    

80101d74 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101d74:	55                   	push   %ebp
80101d75:	89 e5                	mov    %esp,%ebp
80101d77:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101d81:	eb 45                	jmp    80101dc8 <itrunc+0x54>
    if(ip->addrs[i]){
80101d83:	8b 45 08             	mov    0x8(%ebp),%eax
80101d86:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d89:	83 c2 04             	add    $0x4,%edx
80101d8c:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d90:	85 c0                	test   %eax,%eax
80101d92:	74 30                	je     80101dc4 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101d94:	8b 45 08             	mov    0x8(%ebp),%eax
80101d97:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d9a:	83 c2 04             	add    $0x4,%edx
80101d9d:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101da1:	8b 55 08             	mov    0x8(%ebp),%edx
80101da4:	8b 12                	mov    (%edx),%edx
80101da6:	83 ec 08             	sub    $0x8,%esp
80101da9:	50                   	push   %eax
80101daa:	52                   	push   %edx
80101dab:	e8 c1 f7 ff ff       	call   80101571 <bfree>
80101db0:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101db3:	8b 45 08             	mov    0x8(%ebp),%eax
80101db6:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101db9:	83 c2 04             	add    $0x4,%edx
80101dbc:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101dc3:	00 
  for(i = 0; i < NDIRECT; i++){
80101dc4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101dc8:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101dcc:	7e b5                	jle    80101d83 <itrunc+0xf>
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101dce:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd1:	8b 40 4c             	mov    0x4c(%eax),%eax
80101dd4:	85 c0                	test   %eax,%eax
80101dd6:	0f 84 a1 00 00 00    	je     80101e7d <itrunc+0x109>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101ddc:	8b 45 08             	mov    0x8(%ebp),%eax
80101ddf:	8b 50 4c             	mov    0x4c(%eax),%edx
80101de2:	8b 45 08             	mov    0x8(%ebp),%eax
80101de5:	8b 00                	mov    (%eax),%eax
80101de7:	83 ec 08             	sub    $0x8,%esp
80101dea:	52                   	push   %edx
80101deb:	50                   	push   %eax
80101dec:	e8 c5 e3 ff ff       	call   801001b6 <bread>
80101df1:	83 c4 10             	add    $0x10,%esp
80101df4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101df7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101dfa:	83 c0 18             	add    $0x18,%eax
80101dfd:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101e00:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101e07:	eb 3c                	jmp    80101e45 <itrunc+0xd1>
      if(a[j])
80101e09:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e0c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e13:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e16:	01 d0                	add    %edx,%eax
80101e18:	8b 00                	mov    (%eax),%eax
80101e1a:	85 c0                	test   %eax,%eax
80101e1c:	74 23                	je     80101e41 <itrunc+0xcd>
        bfree(ip->dev, a[j]);
80101e1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e21:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e28:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e2b:	01 d0                	add    %edx,%eax
80101e2d:	8b 00                	mov    (%eax),%eax
80101e2f:	8b 55 08             	mov    0x8(%ebp),%edx
80101e32:	8b 12                	mov    (%edx),%edx
80101e34:	83 ec 08             	sub    $0x8,%esp
80101e37:	50                   	push   %eax
80101e38:	52                   	push   %edx
80101e39:	e8 33 f7 ff ff       	call   80101571 <bfree>
80101e3e:	83 c4 10             	add    $0x10,%esp
    for(j = 0; j < NINDIRECT; j++){
80101e41:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101e45:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e48:	83 f8 7f             	cmp    $0x7f,%eax
80101e4b:	76 bc                	jbe    80101e09 <itrunc+0x95>
    }
    brelse(bp);
80101e4d:	83 ec 0c             	sub    $0xc,%esp
80101e50:	ff 75 ec             	pushl  -0x14(%ebp)
80101e53:	e8 d6 e3 ff ff       	call   8010022e <brelse>
80101e58:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101e5b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e5e:	8b 40 4c             	mov    0x4c(%eax),%eax
80101e61:	8b 55 08             	mov    0x8(%ebp),%edx
80101e64:	8b 12                	mov    (%edx),%edx
80101e66:	83 ec 08             	sub    $0x8,%esp
80101e69:	50                   	push   %eax
80101e6a:	52                   	push   %edx
80101e6b:	e8 01 f7 ff ff       	call   80101571 <bfree>
80101e70:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101e73:	8b 45 08             	mov    0x8(%ebp),%eax
80101e76:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101e7d:	8b 45 08             	mov    0x8(%ebp),%eax
80101e80:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101e87:	83 ec 0c             	sub    $0xc,%esp
80101e8a:	ff 75 08             	pushl  0x8(%ebp)
80101e8d:	e8 09 f9 ff ff       	call   8010179b <iupdate>
80101e92:	83 c4 10             	add    $0x10,%esp
}
80101e95:	90                   	nop
80101e96:	c9                   	leave  
80101e97:	c3                   	ret    

80101e98 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101e98:	55                   	push   %ebp
80101e99:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101e9b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9e:	8b 00                	mov    (%eax),%eax
80101ea0:	89 c2                	mov    %eax,%edx
80101ea2:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ea5:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101ea8:	8b 45 08             	mov    0x8(%ebp),%eax
80101eab:	8b 50 04             	mov    0x4(%eax),%edx
80101eae:	8b 45 0c             	mov    0xc(%ebp),%eax
80101eb1:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101eb4:	8b 45 08             	mov    0x8(%ebp),%eax
80101eb7:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101ebb:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ebe:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101ec1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ec4:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101ec8:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ecb:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101ecf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed2:	8b 50 18             	mov    0x18(%eax),%edx
80101ed5:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ed8:	89 50 10             	mov    %edx,0x10(%eax)
}
80101edb:	90                   	nop
80101edc:	5d                   	pop    %ebp
80101edd:	c3                   	ret    

80101ede <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101ede:	55                   	push   %ebp
80101edf:	89 e5                	mov    %esp,%ebp
80101ee1:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ee4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee7:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101eeb:	66 83 f8 03          	cmp    $0x3,%ax
80101eef:	75 5c                	jne    80101f4d <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ef1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ef4:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ef8:	66 85 c0             	test   %ax,%ax
80101efb:	78 20                	js     80101f1d <readi+0x3f>
80101efd:	8b 45 08             	mov    0x8(%ebp),%eax
80101f00:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f04:	66 83 f8 09          	cmp    $0x9,%ax
80101f08:	7f 13                	jg     80101f1d <readi+0x3f>
80101f0a:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0d:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f11:	98                   	cwtl   
80101f12:	8b 04 c5 c0 11 11 80 	mov    -0x7feeee40(,%eax,8),%eax
80101f19:	85 c0                	test   %eax,%eax
80101f1b:	75 0a                	jne    80101f27 <readi+0x49>
      return -1;
80101f1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f22:	e9 0c 01 00 00       	jmp    80102033 <readi+0x155>
    return devsw[ip->major].read(ip, dst, n);
80101f27:	8b 45 08             	mov    0x8(%ebp),%eax
80101f2a:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f2e:	98                   	cwtl   
80101f2f:	8b 04 c5 c0 11 11 80 	mov    -0x7feeee40(,%eax,8),%eax
80101f36:	8b 55 14             	mov    0x14(%ebp),%edx
80101f39:	83 ec 04             	sub    $0x4,%esp
80101f3c:	52                   	push   %edx
80101f3d:	ff 75 0c             	pushl  0xc(%ebp)
80101f40:	ff 75 08             	pushl  0x8(%ebp)
80101f43:	ff d0                	call   *%eax
80101f45:	83 c4 10             	add    $0x10,%esp
80101f48:	e9 e6 00 00 00       	jmp    80102033 <readi+0x155>
  }

  if(off > ip->size || off + n < off)
80101f4d:	8b 45 08             	mov    0x8(%ebp),%eax
80101f50:	8b 40 18             	mov    0x18(%eax),%eax
80101f53:	39 45 10             	cmp    %eax,0x10(%ebp)
80101f56:	77 0d                	ja     80101f65 <readi+0x87>
80101f58:	8b 55 10             	mov    0x10(%ebp),%edx
80101f5b:	8b 45 14             	mov    0x14(%ebp),%eax
80101f5e:	01 d0                	add    %edx,%eax
80101f60:	39 45 10             	cmp    %eax,0x10(%ebp)
80101f63:	76 0a                	jbe    80101f6f <readi+0x91>
    return -1;
80101f65:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f6a:	e9 c4 00 00 00       	jmp    80102033 <readi+0x155>
  if(off + n > ip->size)
80101f6f:	8b 55 10             	mov    0x10(%ebp),%edx
80101f72:	8b 45 14             	mov    0x14(%ebp),%eax
80101f75:	01 c2                	add    %eax,%edx
80101f77:	8b 45 08             	mov    0x8(%ebp),%eax
80101f7a:	8b 40 18             	mov    0x18(%eax),%eax
80101f7d:	39 c2                	cmp    %eax,%edx
80101f7f:	76 0c                	jbe    80101f8d <readi+0xaf>
    n = ip->size - off;
80101f81:	8b 45 08             	mov    0x8(%ebp),%eax
80101f84:	8b 40 18             	mov    0x18(%eax),%eax
80101f87:	2b 45 10             	sub    0x10(%ebp),%eax
80101f8a:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101f94:	e9 8b 00 00 00       	jmp    80102024 <readi+0x146>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f99:	8b 45 10             	mov    0x10(%ebp),%eax
80101f9c:	c1 e8 09             	shr    $0x9,%eax
80101f9f:	83 ec 08             	sub    $0x8,%esp
80101fa2:	50                   	push   %eax
80101fa3:	ff 75 08             	pushl  0x8(%ebp)
80101fa6:	e8 af fc ff ff       	call   80101c5a <bmap>
80101fab:	83 c4 10             	add    $0x10,%esp
80101fae:	89 c2                	mov    %eax,%edx
80101fb0:	8b 45 08             	mov    0x8(%ebp),%eax
80101fb3:	8b 00                	mov    (%eax),%eax
80101fb5:	83 ec 08             	sub    $0x8,%esp
80101fb8:	52                   	push   %edx
80101fb9:	50                   	push   %eax
80101fba:	e8 f7 e1 ff ff       	call   801001b6 <bread>
80101fbf:	83 c4 10             	add    $0x10,%esp
80101fc2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101fc5:	8b 45 10             	mov    0x10(%ebp),%eax
80101fc8:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fcd:	ba 00 02 00 00       	mov    $0x200,%edx
80101fd2:	29 c2                	sub    %eax,%edx
80101fd4:	8b 45 14             	mov    0x14(%ebp),%eax
80101fd7:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101fda:	39 c2                	cmp    %eax,%edx
80101fdc:	0f 46 c2             	cmovbe %edx,%eax
80101fdf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101fe2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101fe5:	8d 50 18             	lea    0x18(%eax),%edx
80101fe8:	8b 45 10             	mov    0x10(%ebp),%eax
80101feb:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ff0:	01 d0                	add    %edx,%eax
80101ff2:	83 ec 04             	sub    $0x4,%esp
80101ff5:	ff 75 ec             	pushl  -0x14(%ebp)
80101ff8:	50                   	push   %eax
80101ff9:	ff 75 0c             	pushl  0xc(%ebp)
80101ffc:	e8 ed 34 00 00       	call   801054ee <memmove>
80102001:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102004:	83 ec 0c             	sub    $0xc,%esp
80102007:	ff 75 f0             	pushl  -0x10(%ebp)
8010200a:	e8 1f e2 ff ff       	call   8010022e <brelse>
8010200f:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102012:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102015:	01 45 f4             	add    %eax,-0xc(%ebp)
80102018:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010201b:	01 45 10             	add    %eax,0x10(%ebp)
8010201e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102021:	01 45 0c             	add    %eax,0xc(%ebp)
80102024:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102027:	3b 45 14             	cmp    0x14(%ebp),%eax
8010202a:	0f 82 69 ff ff ff    	jb     80101f99 <readi+0xbb>
  }
  return n;
80102030:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102033:	c9                   	leave  
80102034:	c3                   	ret    

80102035 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102035:	55                   	push   %ebp
80102036:	89 e5                	mov    %esp,%ebp
80102038:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010203b:	8b 45 08             	mov    0x8(%ebp),%eax
8010203e:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102042:	66 83 f8 03          	cmp    $0x3,%ax
80102046:	75 5c                	jne    801020a4 <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102048:	8b 45 08             	mov    0x8(%ebp),%eax
8010204b:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010204f:	66 85 c0             	test   %ax,%ax
80102052:	78 20                	js     80102074 <writei+0x3f>
80102054:	8b 45 08             	mov    0x8(%ebp),%eax
80102057:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010205b:	66 83 f8 09          	cmp    $0x9,%ax
8010205f:	7f 13                	jg     80102074 <writei+0x3f>
80102061:	8b 45 08             	mov    0x8(%ebp),%eax
80102064:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102068:	98                   	cwtl   
80102069:	8b 04 c5 c4 11 11 80 	mov    -0x7feeee3c(,%eax,8),%eax
80102070:	85 c0                	test   %eax,%eax
80102072:	75 0a                	jne    8010207e <writei+0x49>
      return -1;
80102074:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102079:	e9 3d 01 00 00       	jmp    801021bb <writei+0x186>
    return devsw[ip->major].write(ip, src, n);
8010207e:	8b 45 08             	mov    0x8(%ebp),%eax
80102081:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102085:	98                   	cwtl   
80102086:	8b 04 c5 c4 11 11 80 	mov    -0x7feeee3c(,%eax,8),%eax
8010208d:	8b 55 14             	mov    0x14(%ebp),%edx
80102090:	83 ec 04             	sub    $0x4,%esp
80102093:	52                   	push   %edx
80102094:	ff 75 0c             	pushl  0xc(%ebp)
80102097:	ff 75 08             	pushl  0x8(%ebp)
8010209a:	ff d0                	call   *%eax
8010209c:	83 c4 10             	add    $0x10,%esp
8010209f:	e9 17 01 00 00       	jmp    801021bb <writei+0x186>
  }

  if(off > ip->size || off + n < off)
801020a4:	8b 45 08             	mov    0x8(%ebp),%eax
801020a7:	8b 40 18             	mov    0x18(%eax),%eax
801020aa:	39 45 10             	cmp    %eax,0x10(%ebp)
801020ad:	77 0d                	ja     801020bc <writei+0x87>
801020af:	8b 55 10             	mov    0x10(%ebp),%edx
801020b2:	8b 45 14             	mov    0x14(%ebp),%eax
801020b5:	01 d0                	add    %edx,%eax
801020b7:	39 45 10             	cmp    %eax,0x10(%ebp)
801020ba:	76 0a                	jbe    801020c6 <writei+0x91>
    return -1;
801020bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020c1:	e9 f5 00 00 00       	jmp    801021bb <writei+0x186>
  if(off + n > MAXFILE*BSIZE)
801020c6:	8b 55 10             	mov    0x10(%ebp),%edx
801020c9:	8b 45 14             	mov    0x14(%ebp),%eax
801020cc:	01 d0                	add    %edx,%eax
801020ce:	3d 00 18 01 00       	cmp    $0x11800,%eax
801020d3:	76 0a                	jbe    801020df <writei+0xaa>
    return -1;
801020d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020da:	e9 dc 00 00 00       	jmp    801021bb <writei+0x186>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801020e6:	e9 99 00 00 00       	jmp    80102184 <writei+0x14f>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801020eb:	8b 45 10             	mov    0x10(%ebp),%eax
801020ee:	c1 e8 09             	shr    $0x9,%eax
801020f1:	83 ec 08             	sub    $0x8,%esp
801020f4:	50                   	push   %eax
801020f5:	ff 75 08             	pushl  0x8(%ebp)
801020f8:	e8 5d fb ff ff       	call   80101c5a <bmap>
801020fd:	83 c4 10             	add    $0x10,%esp
80102100:	89 c2                	mov    %eax,%edx
80102102:	8b 45 08             	mov    0x8(%ebp),%eax
80102105:	8b 00                	mov    (%eax),%eax
80102107:	83 ec 08             	sub    $0x8,%esp
8010210a:	52                   	push   %edx
8010210b:	50                   	push   %eax
8010210c:	e8 a5 e0 ff ff       	call   801001b6 <bread>
80102111:	83 c4 10             	add    $0x10,%esp
80102114:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102117:	8b 45 10             	mov    0x10(%ebp),%eax
8010211a:	25 ff 01 00 00       	and    $0x1ff,%eax
8010211f:	ba 00 02 00 00       	mov    $0x200,%edx
80102124:	29 c2                	sub    %eax,%edx
80102126:	8b 45 14             	mov    0x14(%ebp),%eax
80102129:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010212c:	39 c2                	cmp    %eax,%edx
8010212e:	0f 46 c2             	cmovbe %edx,%eax
80102131:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
80102134:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102137:	8d 50 18             	lea    0x18(%eax),%edx
8010213a:	8b 45 10             	mov    0x10(%ebp),%eax
8010213d:	25 ff 01 00 00       	and    $0x1ff,%eax
80102142:	01 d0                	add    %edx,%eax
80102144:	83 ec 04             	sub    $0x4,%esp
80102147:	ff 75 ec             	pushl  -0x14(%ebp)
8010214a:	ff 75 0c             	pushl  0xc(%ebp)
8010214d:	50                   	push   %eax
8010214e:	e8 9b 33 00 00       	call   801054ee <memmove>
80102153:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
80102156:	83 ec 0c             	sub    $0xc,%esp
80102159:	ff 75 f0             	pushl  -0x10(%ebp)
8010215c:	e8 2d 16 00 00       	call   8010378e <log_write>
80102161:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102164:	83 ec 0c             	sub    $0xc,%esp
80102167:	ff 75 f0             	pushl  -0x10(%ebp)
8010216a:	e8 bf e0 ff ff       	call   8010022e <brelse>
8010216f:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102172:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102175:	01 45 f4             	add    %eax,-0xc(%ebp)
80102178:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010217b:	01 45 10             	add    %eax,0x10(%ebp)
8010217e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102181:	01 45 0c             	add    %eax,0xc(%ebp)
80102184:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102187:	3b 45 14             	cmp    0x14(%ebp),%eax
8010218a:	0f 82 5b ff ff ff    	jb     801020eb <writei+0xb6>
  }

  if(n > 0 && off > ip->size){
80102190:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102194:	74 22                	je     801021b8 <writei+0x183>
80102196:	8b 45 08             	mov    0x8(%ebp),%eax
80102199:	8b 40 18             	mov    0x18(%eax),%eax
8010219c:	39 45 10             	cmp    %eax,0x10(%ebp)
8010219f:	76 17                	jbe    801021b8 <writei+0x183>
    ip->size = off;
801021a1:	8b 45 08             	mov    0x8(%ebp),%eax
801021a4:	8b 55 10             	mov    0x10(%ebp),%edx
801021a7:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
801021aa:	83 ec 0c             	sub    $0xc,%esp
801021ad:	ff 75 08             	pushl  0x8(%ebp)
801021b0:	e8 e6 f5 ff ff       	call   8010179b <iupdate>
801021b5:	83 c4 10             	add    $0x10,%esp
  }
  return n;
801021b8:	8b 45 14             	mov    0x14(%ebp),%eax
}
801021bb:	c9                   	leave  
801021bc:	c3                   	ret    

801021bd <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801021bd:	55                   	push   %ebp
801021be:	89 e5                	mov    %esp,%ebp
801021c0:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
801021c3:	83 ec 04             	sub    $0x4,%esp
801021c6:	6a 0e                	push   $0xe
801021c8:	ff 75 0c             	pushl  0xc(%ebp)
801021cb:	ff 75 08             	pushl  0x8(%ebp)
801021ce:	e8 b1 33 00 00       	call   80105584 <strncmp>
801021d3:	83 c4 10             	add    $0x10,%esp
}
801021d6:	c9                   	leave  
801021d7:	c3                   	ret    

801021d8 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801021d8:	55                   	push   %ebp
801021d9:	89 e5                	mov    %esp,%ebp
801021db:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801021de:	8b 45 08             	mov    0x8(%ebp),%eax
801021e1:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801021e5:	66 83 f8 01          	cmp    $0x1,%ax
801021e9:	74 0d                	je     801021f8 <dirlookup+0x20>
    panic("dirlookup not DIR");
801021eb:	83 ec 0c             	sub    $0xc,%esp
801021ee:	68 97 88 10 80       	push   $0x80108897
801021f3:	e8 6f e3 ff ff       	call   80100567 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801021f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801021ff:	eb 7b                	jmp    8010227c <dirlookup+0xa4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102201:	6a 10                	push   $0x10
80102203:	ff 75 f4             	pushl  -0xc(%ebp)
80102206:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102209:	50                   	push   %eax
8010220a:	ff 75 08             	pushl  0x8(%ebp)
8010220d:	e8 cc fc ff ff       	call   80101ede <readi>
80102212:	83 c4 10             	add    $0x10,%esp
80102215:	83 f8 10             	cmp    $0x10,%eax
80102218:	74 0d                	je     80102227 <dirlookup+0x4f>
      panic("dirlink read");
8010221a:	83 ec 0c             	sub    $0xc,%esp
8010221d:	68 a9 88 10 80       	push   $0x801088a9
80102222:	e8 40 e3 ff ff       	call   80100567 <panic>
    if(de.inum == 0)
80102227:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010222b:	66 85 c0             	test   %ax,%ax
8010222e:	74 47                	je     80102277 <dirlookup+0x9f>
      continue;
    if(namecmp(name, de.name) == 0){
80102230:	83 ec 08             	sub    $0x8,%esp
80102233:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102236:	83 c0 02             	add    $0x2,%eax
80102239:	50                   	push   %eax
8010223a:	ff 75 0c             	pushl  0xc(%ebp)
8010223d:	e8 7b ff ff ff       	call   801021bd <namecmp>
80102242:	83 c4 10             	add    $0x10,%esp
80102245:	85 c0                	test   %eax,%eax
80102247:	75 2f                	jne    80102278 <dirlookup+0xa0>
      // entry matches path element
      if(poff)
80102249:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010224d:	74 08                	je     80102257 <dirlookup+0x7f>
        *poff = off;
8010224f:	8b 45 10             	mov    0x10(%ebp),%eax
80102252:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102255:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102257:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010225b:	0f b7 c0             	movzwl %ax,%eax
8010225e:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
80102261:	8b 45 08             	mov    0x8(%ebp),%eax
80102264:	8b 00                	mov    (%eax),%eax
80102266:	83 ec 08             	sub    $0x8,%esp
80102269:	ff 75 f0             	pushl  -0x10(%ebp)
8010226c:	50                   	push   %eax
8010226d:	e8 ea f5 ff ff       	call   8010185c <iget>
80102272:	83 c4 10             	add    $0x10,%esp
80102275:	eb 19                	jmp    80102290 <dirlookup+0xb8>
      continue;
80102277:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
80102278:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010227c:	8b 45 08             	mov    0x8(%ebp),%eax
8010227f:	8b 40 18             	mov    0x18(%eax),%eax
80102282:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80102285:	0f 82 76 ff ff ff    	jb     80102201 <dirlookup+0x29>
    }
  }

  return 0;
8010228b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102290:	c9                   	leave  
80102291:	c3                   	ret    

80102292 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102292:	55                   	push   %ebp
80102293:	89 e5                	mov    %esp,%ebp
80102295:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102298:	83 ec 04             	sub    $0x4,%esp
8010229b:	6a 00                	push   $0x0
8010229d:	ff 75 0c             	pushl  0xc(%ebp)
801022a0:	ff 75 08             	pushl  0x8(%ebp)
801022a3:	e8 30 ff ff ff       	call   801021d8 <dirlookup>
801022a8:	83 c4 10             	add    $0x10,%esp
801022ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
801022ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801022b2:	74 18                	je     801022cc <dirlink+0x3a>
    iput(ip);
801022b4:	83 ec 0c             	sub    $0xc,%esp
801022b7:	ff 75 f0             	pushl  -0x10(%ebp)
801022ba:	e8 86 f8 ff ff       	call   80101b45 <iput>
801022bf:	83 c4 10             	add    $0x10,%esp
    return -1;
801022c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022c7:	e9 9c 00 00 00       	jmp    80102368 <dirlink+0xd6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801022cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801022d3:	eb 39                	jmp    8010230e <dirlink+0x7c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022d8:	6a 10                	push   $0x10
801022da:	50                   	push   %eax
801022db:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022de:	50                   	push   %eax
801022df:	ff 75 08             	pushl  0x8(%ebp)
801022e2:	e8 f7 fb ff ff       	call   80101ede <readi>
801022e7:	83 c4 10             	add    $0x10,%esp
801022ea:	83 f8 10             	cmp    $0x10,%eax
801022ed:	74 0d                	je     801022fc <dirlink+0x6a>
      panic("dirlink read");
801022ef:	83 ec 0c             	sub    $0xc,%esp
801022f2:	68 a9 88 10 80       	push   $0x801088a9
801022f7:	e8 6b e2 ff ff       	call   80100567 <panic>
    if(de.inum == 0)
801022fc:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102300:	66 85 c0             	test   %ax,%ax
80102303:	74 18                	je     8010231d <dirlink+0x8b>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102305:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102308:	83 c0 10             	add    $0x10,%eax
8010230b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010230e:	8b 45 08             	mov    0x8(%ebp),%eax
80102311:	8b 50 18             	mov    0x18(%eax),%edx
80102314:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102317:	39 c2                	cmp    %eax,%edx
80102319:	77 ba                	ja     801022d5 <dirlink+0x43>
8010231b:	eb 01                	jmp    8010231e <dirlink+0x8c>
      break;
8010231d:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
8010231e:	83 ec 04             	sub    $0x4,%esp
80102321:	6a 0e                	push   $0xe
80102323:	ff 75 0c             	pushl  0xc(%ebp)
80102326:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102329:	83 c0 02             	add    $0x2,%eax
8010232c:	50                   	push   %eax
8010232d:	e8 a8 32 00 00       	call   801055da <strncpy>
80102332:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
80102335:	8b 45 10             	mov    0x10(%ebp),%eax
80102338:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010233c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010233f:	6a 10                	push   $0x10
80102341:	50                   	push   %eax
80102342:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102345:	50                   	push   %eax
80102346:	ff 75 08             	pushl  0x8(%ebp)
80102349:	e8 e7 fc ff ff       	call   80102035 <writei>
8010234e:	83 c4 10             	add    $0x10,%esp
80102351:	83 f8 10             	cmp    $0x10,%eax
80102354:	74 0d                	je     80102363 <dirlink+0xd1>
    panic("dirlink");
80102356:	83 ec 0c             	sub    $0xc,%esp
80102359:	68 b6 88 10 80       	push   $0x801088b6
8010235e:	e8 04 e2 ff ff       	call   80100567 <panic>
  
  return 0;
80102363:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102368:	c9                   	leave  
80102369:	c3                   	ret    

8010236a <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
8010236a:	55                   	push   %ebp
8010236b:	89 e5                	mov    %esp,%ebp
8010236d:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
80102370:	eb 04                	jmp    80102376 <skipelem+0xc>
    path++;
80102372:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
80102376:	8b 45 08             	mov    0x8(%ebp),%eax
80102379:	0f b6 00             	movzbl (%eax),%eax
8010237c:	3c 2f                	cmp    $0x2f,%al
8010237e:	74 f2                	je     80102372 <skipelem+0x8>
  if(*path == 0)
80102380:	8b 45 08             	mov    0x8(%ebp),%eax
80102383:	0f b6 00             	movzbl (%eax),%eax
80102386:	84 c0                	test   %al,%al
80102388:	75 07                	jne    80102391 <skipelem+0x27>
    return 0;
8010238a:	b8 00 00 00 00       	mov    $0x0,%eax
8010238f:	eb 77                	jmp    80102408 <skipelem+0x9e>
  s = path;
80102391:	8b 45 08             	mov    0x8(%ebp),%eax
80102394:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102397:	eb 04                	jmp    8010239d <skipelem+0x33>
    path++;
80102399:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path != '/' && *path != 0)
8010239d:	8b 45 08             	mov    0x8(%ebp),%eax
801023a0:	0f b6 00             	movzbl (%eax),%eax
801023a3:	3c 2f                	cmp    $0x2f,%al
801023a5:	74 0a                	je     801023b1 <skipelem+0x47>
801023a7:	8b 45 08             	mov    0x8(%ebp),%eax
801023aa:	0f b6 00             	movzbl (%eax),%eax
801023ad:	84 c0                	test   %al,%al
801023af:	75 e8                	jne    80102399 <skipelem+0x2f>
  len = path - s;
801023b1:	8b 45 08             	mov    0x8(%ebp),%eax
801023b4:	2b 45 f4             	sub    -0xc(%ebp),%eax
801023b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
801023ba:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801023be:	7e 15                	jle    801023d5 <skipelem+0x6b>
    memmove(name, s, DIRSIZ);
801023c0:	83 ec 04             	sub    $0x4,%esp
801023c3:	6a 0e                	push   $0xe
801023c5:	ff 75 f4             	pushl  -0xc(%ebp)
801023c8:	ff 75 0c             	pushl  0xc(%ebp)
801023cb:	e8 1e 31 00 00       	call   801054ee <memmove>
801023d0:	83 c4 10             	add    $0x10,%esp
801023d3:	eb 26                	jmp    801023fb <skipelem+0x91>
  else {
    memmove(name, s, len);
801023d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023d8:	83 ec 04             	sub    $0x4,%esp
801023db:	50                   	push   %eax
801023dc:	ff 75 f4             	pushl  -0xc(%ebp)
801023df:	ff 75 0c             	pushl  0xc(%ebp)
801023e2:	e8 07 31 00 00       	call   801054ee <memmove>
801023e7:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
801023ea:	8b 55 f0             	mov    -0x10(%ebp),%edx
801023ed:	8b 45 0c             	mov    0xc(%ebp),%eax
801023f0:	01 d0                	add    %edx,%eax
801023f2:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801023f5:	eb 04                	jmp    801023fb <skipelem+0x91>
    path++;
801023f7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
801023fb:	8b 45 08             	mov    0x8(%ebp),%eax
801023fe:	0f b6 00             	movzbl (%eax),%eax
80102401:	3c 2f                	cmp    $0x2f,%al
80102403:	74 f2                	je     801023f7 <skipelem+0x8d>
  return path;
80102405:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102408:	c9                   	leave  
80102409:	c3                   	ret    

8010240a <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
8010240a:	55                   	push   %ebp
8010240b:	89 e5                	mov    %esp,%ebp
8010240d:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102410:	8b 45 08             	mov    0x8(%ebp),%eax
80102413:	0f b6 00             	movzbl (%eax),%eax
80102416:	3c 2f                	cmp    $0x2f,%al
80102418:	75 17                	jne    80102431 <namex+0x27>
    ip = iget(ROOTDEV, ROOTINO);
8010241a:	83 ec 08             	sub    $0x8,%esp
8010241d:	6a 01                	push   $0x1
8010241f:	6a 01                	push   $0x1
80102421:	e8 36 f4 ff ff       	call   8010185c <iget>
80102426:	83 c4 10             	add    $0x10,%esp
80102429:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010242c:	e9 bb 00 00 00       	jmp    801024ec <namex+0xe2>
  else
    ip = idup(proc->cwd);
80102431:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80102437:	8b 40 68             	mov    0x68(%eax),%eax
8010243a:	83 ec 0c             	sub    $0xc,%esp
8010243d:	50                   	push   %eax
8010243e:	e8 f8 f4 ff ff       	call   8010193b <idup>
80102443:	83 c4 10             	add    $0x10,%esp
80102446:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80102449:	e9 9e 00 00 00       	jmp    801024ec <namex+0xe2>
    ilock(ip);
8010244e:	83 ec 0c             	sub    $0xc,%esp
80102451:	ff 75 f4             	pushl  -0xc(%ebp)
80102454:	e8 1c f5 ff ff       	call   80101975 <ilock>
80102459:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
8010245c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010245f:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102463:	66 83 f8 01          	cmp    $0x1,%ax
80102467:	74 18                	je     80102481 <namex+0x77>
      iunlockput(ip);
80102469:	83 ec 0c             	sub    $0xc,%esp
8010246c:	ff 75 f4             	pushl  -0xc(%ebp)
8010246f:	e8 c1 f7 ff ff       	call   80101c35 <iunlockput>
80102474:	83 c4 10             	add    $0x10,%esp
      return 0;
80102477:	b8 00 00 00 00       	mov    $0x0,%eax
8010247c:	e9 a7 00 00 00       	jmp    80102528 <namex+0x11e>
    }
    if(nameiparent && *path == '\0'){
80102481:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102485:	74 20                	je     801024a7 <namex+0x9d>
80102487:	8b 45 08             	mov    0x8(%ebp),%eax
8010248a:	0f b6 00             	movzbl (%eax),%eax
8010248d:	84 c0                	test   %al,%al
8010248f:	75 16                	jne    801024a7 <namex+0x9d>
      // Stop one level early.
      iunlock(ip);
80102491:	83 ec 0c             	sub    $0xc,%esp
80102494:	ff 75 f4             	pushl  -0xc(%ebp)
80102497:	e8 37 f6 ff ff       	call   80101ad3 <iunlock>
8010249c:	83 c4 10             	add    $0x10,%esp
      return ip;
8010249f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024a2:	e9 81 00 00 00       	jmp    80102528 <namex+0x11e>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801024a7:	83 ec 04             	sub    $0x4,%esp
801024aa:	6a 00                	push   $0x0
801024ac:	ff 75 10             	pushl  0x10(%ebp)
801024af:	ff 75 f4             	pushl  -0xc(%ebp)
801024b2:	e8 21 fd ff ff       	call   801021d8 <dirlookup>
801024b7:	83 c4 10             	add    $0x10,%esp
801024ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
801024bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801024c1:	75 15                	jne    801024d8 <namex+0xce>
      iunlockput(ip);
801024c3:	83 ec 0c             	sub    $0xc,%esp
801024c6:	ff 75 f4             	pushl  -0xc(%ebp)
801024c9:	e8 67 f7 ff ff       	call   80101c35 <iunlockput>
801024ce:	83 c4 10             	add    $0x10,%esp
      return 0;
801024d1:	b8 00 00 00 00       	mov    $0x0,%eax
801024d6:	eb 50                	jmp    80102528 <namex+0x11e>
    }
    iunlockput(ip);
801024d8:	83 ec 0c             	sub    $0xc,%esp
801024db:	ff 75 f4             	pushl  -0xc(%ebp)
801024de:	e8 52 f7 ff ff       	call   80101c35 <iunlockput>
801024e3:	83 c4 10             	add    $0x10,%esp
    ip = next;
801024e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while((path = skipelem(path, name)) != 0){
801024ec:	83 ec 08             	sub    $0x8,%esp
801024ef:	ff 75 10             	pushl  0x10(%ebp)
801024f2:	ff 75 08             	pushl  0x8(%ebp)
801024f5:	e8 70 fe ff ff       	call   8010236a <skipelem>
801024fa:	83 c4 10             	add    $0x10,%esp
801024fd:	89 45 08             	mov    %eax,0x8(%ebp)
80102500:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102504:	0f 85 44 ff ff ff    	jne    8010244e <namex+0x44>
  }
  if(nameiparent){
8010250a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010250e:	74 15                	je     80102525 <namex+0x11b>
    iput(ip);
80102510:	83 ec 0c             	sub    $0xc,%esp
80102513:	ff 75 f4             	pushl  -0xc(%ebp)
80102516:	e8 2a f6 ff ff       	call   80101b45 <iput>
8010251b:	83 c4 10             	add    $0x10,%esp
    return 0;
8010251e:	b8 00 00 00 00       	mov    $0x0,%eax
80102523:	eb 03                	jmp    80102528 <namex+0x11e>
  }
  return ip;
80102525:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102528:	c9                   	leave  
80102529:	c3                   	ret    

8010252a <namei>:

struct inode*
namei(char *path)
{
8010252a:	55                   	push   %ebp
8010252b:	89 e5                	mov    %esp,%ebp
8010252d:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102530:	83 ec 04             	sub    $0x4,%esp
80102533:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102536:	50                   	push   %eax
80102537:	6a 00                	push   $0x0
80102539:	ff 75 08             	pushl  0x8(%ebp)
8010253c:	e8 c9 fe ff ff       	call   8010240a <namex>
80102541:	83 c4 10             	add    $0x10,%esp
}
80102544:	c9                   	leave  
80102545:	c3                   	ret    

80102546 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102546:	55                   	push   %ebp
80102547:	89 e5                	mov    %esp,%ebp
80102549:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
8010254c:	83 ec 04             	sub    $0x4,%esp
8010254f:	ff 75 0c             	pushl  0xc(%ebp)
80102552:	6a 01                	push   $0x1
80102554:	ff 75 08             	pushl  0x8(%ebp)
80102557:	e8 ae fe ff ff       	call   8010240a <namex>
8010255c:	83 c4 10             	add    $0x10,%esp
}
8010255f:	c9                   	leave  
80102560:	c3                   	ret    

80102561 <inb>:
{
80102561:	55                   	push   %ebp
80102562:	89 e5                	mov    %esp,%ebp
80102564:	83 ec 14             	sub    $0x14,%esp
80102567:	8b 45 08             	mov    0x8(%ebp),%eax
8010256a:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010256e:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102572:	89 c2                	mov    %eax,%edx
80102574:	ec                   	in     (%dx),%al
80102575:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102578:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010257c:	c9                   	leave  
8010257d:	c3                   	ret    

8010257e <insl>:
{
8010257e:	55                   	push   %ebp
8010257f:	89 e5                	mov    %esp,%ebp
80102581:	57                   	push   %edi
80102582:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
80102583:	8b 55 08             	mov    0x8(%ebp),%edx
80102586:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102589:	8b 45 10             	mov    0x10(%ebp),%eax
8010258c:	89 cb                	mov    %ecx,%ebx
8010258e:	89 df                	mov    %ebx,%edi
80102590:	89 c1                	mov    %eax,%ecx
80102592:	fc                   	cld    
80102593:	f3 6d                	rep insl (%dx),%es:(%edi)
80102595:	89 c8                	mov    %ecx,%eax
80102597:	89 fb                	mov    %edi,%ebx
80102599:	89 5d 0c             	mov    %ebx,0xc(%ebp)
8010259c:	89 45 10             	mov    %eax,0x10(%ebp)
}
8010259f:	90                   	nop
801025a0:	5b                   	pop    %ebx
801025a1:	5f                   	pop    %edi
801025a2:	5d                   	pop    %ebp
801025a3:	c3                   	ret    

801025a4 <outb>:
{
801025a4:	55                   	push   %ebp
801025a5:	89 e5                	mov    %esp,%ebp
801025a7:	83 ec 08             	sub    $0x8,%esp
801025aa:	8b 45 08             	mov    0x8(%ebp),%eax
801025ad:	8b 55 0c             	mov    0xc(%ebp),%edx
801025b0:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801025b4:	89 d0                	mov    %edx,%eax
801025b6:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025b9:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801025bd:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801025c1:	ee                   	out    %al,(%dx)
}
801025c2:	90                   	nop
801025c3:	c9                   	leave  
801025c4:	c3                   	ret    

801025c5 <outsl>:
{
801025c5:	55                   	push   %ebp
801025c6:	89 e5                	mov    %esp,%ebp
801025c8:	56                   	push   %esi
801025c9:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801025ca:	8b 55 08             	mov    0x8(%ebp),%edx
801025cd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801025d0:	8b 45 10             	mov    0x10(%ebp),%eax
801025d3:	89 cb                	mov    %ecx,%ebx
801025d5:	89 de                	mov    %ebx,%esi
801025d7:	89 c1                	mov    %eax,%ecx
801025d9:	fc                   	cld    
801025da:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801025dc:	89 c8                	mov    %ecx,%eax
801025de:	89 f3                	mov    %esi,%ebx
801025e0:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801025e3:	89 45 10             	mov    %eax,0x10(%ebp)
}
801025e6:	90                   	nop
801025e7:	5b                   	pop    %ebx
801025e8:	5e                   	pop    %esi
801025e9:	5d                   	pop    %ebp
801025ea:	c3                   	ret    

801025eb <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801025eb:	55                   	push   %ebp
801025ec:	89 e5                	mov    %esp,%ebp
801025ee:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
801025f1:	90                   	nop
801025f2:	68 f7 01 00 00       	push   $0x1f7
801025f7:	e8 65 ff ff ff       	call   80102561 <inb>
801025fc:	83 c4 04             	add    $0x4,%esp
801025ff:	0f b6 c0             	movzbl %al,%eax
80102602:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102605:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102608:	25 c0 00 00 00       	and    $0xc0,%eax
8010260d:	83 f8 40             	cmp    $0x40,%eax
80102610:	75 e0                	jne    801025f2 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102612:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102616:	74 11                	je     80102629 <idewait+0x3e>
80102618:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010261b:	83 e0 21             	and    $0x21,%eax
8010261e:	85 c0                	test   %eax,%eax
80102620:	74 07                	je     80102629 <idewait+0x3e>
    return -1;
80102622:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102627:	eb 05                	jmp    8010262e <idewait+0x43>
  return 0;
80102629:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010262e:	c9                   	leave  
8010262f:	c3                   	ret    

80102630 <ideinit>:

void
ideinit(void)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  initlock(&idelock, "ide");
80102636:	83 ec 08             	sub    $0x8,%esp
80102639:	68 be 88 10 80       	push   $0x801088be
8010263e:	68 00 b6 10 80       	push   $0x8010b600
80102643:	e8 62 2b 00 00       	call   801051aa <initlock>
80102648:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
8010264b:	83 ec 0c             	sub    $0xc,%esp
8010264e:	6a 0e                	push   $0xe
80102650:	e8 db 18 00 00       	call   80103f30 <picenable>
80102655:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
80102658:	a1 40 29 11 80       	mov    0x80112940,%eax
8010265d:	83 e8 01             	sub    $0x1,%eax
80102660:	83 ec 08             	sub    $0x8,%esp
80102663:	50                   	push   %eax
80102664:	6a 0e                	push   $0xe
80102666:	e8 73 04 00 00       	call   80102ade <ioapicenable>
8010266b:	83 c4 10             	add    $0x10,%esp
  idewait(0);
8010266e:	83 ec 0c             	sub    $0xc,%esp
80102671:	6a 00                	push   $0x0
80102673:	e8 73 ff ff ff       	call   801025eb <idewait>
80102678:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
8010267b:	83 ec 08             	sub    $0x8,%esp
8010267e:	68 f0 00 00 00       	push   $0xf0
80102683:	68 f6 01 00 00       	push   $0x1f6
80102688:	e8 17 ff ff ff       	call   801025a4 <outb>
8010268d:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
80102690:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102697:	eb 24                	jmp    801026bd <ideinit+0x8d>
    if(inb(0x1f7) != 0){
80102699:	83 ec 0c             	sub    $0xc,%esp
8010269c:	68 f7 01 00 00       	push   $0x1f7
801026a1:	e8 bb fe ff ff       	call   80102561 <inb>
801026a6:	83 c4 10             	add    $0x10,%esp
801026a9:	84 c0                	test   %al,%al
801026ab:	74 0c                	je     801026b9 <ideinit+0x89>
      havedisk1 = 1;
801026ad:	c7 05 38 b6 10 80 01 	movl   $0x1,0x8010b638
801026b4:	00 00 00 
      break;
801026b7:	eb 0d                	jmp    801026c6 <ideinit+0x96>
  for(i=0; i<1000; i++){
801026b9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801026bd:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
801026c4:	7e d3                	jle    80102699 <ideinit+0x69>
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801026c6:	83 ec 08             	sub    $0x8,%esp
801026c9:	68 e0 00 00 00       	push   $0xe0
801026ce:	68 f6 01 00 00       	push   $0x1f6
801026d3:	e8 cc fe ff ff       	call   801025a4 <outb>
801026d8:	83 c4 10             	add    $0x10,%esp
}
801026db:	90                   	nop
801026dc:	c9                   	leave  
801026dd:	c3                   	ret    

801026de <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801026de:	55                   	push   %ebp
801026df:	89 e5                	mov    %esp,%ebp
801026e1:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
801026e4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801026e8:	75 0d                	jne    801026f7 <idestart+0x19>
    panic("idestart");
801026ea:	83 ec 0c             	sub    $0xc,%esp
801026ed:	68 c2 88 10 80       	push   $0x801088c2
801026f2:	e8 70 de ff ff       	call   80100567 <panic>
  if(b->blockno >= FSSIZE)
801026f7:	8b 45 08             	mov    0x8(%ebp),%eax
801026fa:	8b 40 08             	mov    0x8(%eax),%eax
801026fd:	3d e7 03 00 00       	cmp    $0x3e7,%eax
80102702:	76 0d                	jbe    80102711 <idestart+0x33>
    panic("incorrect blockno");
80102704:	83 ec 0c             	sub    $0xc,%esp
80102707:	68 cb 88 10 80       	push   $0x801088cb
8010270c:	e8 56 de ff ff       	call   80100567 <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
80102711:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
80102718:	8b 45 08             	mov    0x8(%ebp),%eax
8010271b:	8b 50 08             	mov    0x8(%eax),%edx
8010271e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102721:	0f af c2             	imul   %edx,%eax
80102724:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if (sector_per_block > 7) panic("idestart");
80102727:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
8010272b:	7e 0d                	jle    8010273a <idestart+0x5c>
8010272d:	83 ec 0c             	sub    $0xc,%esp
80102730:	68 c2 88 10 80       	push   $0x801088c2
80102735:	e8 2d de ff ff       	call   80100567 <panic>
  
  idewait(0);
8010273a:	83 ec 0c             	sub    $0xc,%esp
8010273d:	6a 00                	push   $0x0
8010273f:	e8 a7 fe ff ff       	call   801025eb <idewait>
80102744:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
80102747:	83 ec 08             	sub    $0x8,%esp
8010274a:	6a 00                	push   $0x0
8010274c:	68 f6 03 00 00       	push   $0x3f6
80102751:	e8 4e fe ff ff       	call   801025a4 <outb>
80102756:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
80102759:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010275c:	0f b6 c0             	movzbl %al,%eax
8010275f:	83 ec 08             	sub    $0x8,%esp
80102762:	50                   	push   %eax
80102763:	68 f2 01 00 00       	push   $0x1f2
80102768:	e8 37 fe ff ff       	call   801025a4 <outb>
8010276d:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
80102770:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102773:	0f b6 c0             	movzbl %al,%eax
80102776:	83 ec 08             	sub    $0x8,%esp
80102779:	50                   	push   %eax
8010277a:	68 f3 01 00 00       	push   $0x1f3
8010277f:	e8 20 fe ff ff       	call   801025a4 <outb>
80102784:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
80102787:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010278a:	c1 f8 08             	sar    $0x8,%eax
8010278d:	0f b6 c0             	movzbl %al,%eax
80102790:	83 ec 08             	sub    $0x8,%esp
80102793:	50                   	push   %eax
80102794:	68 f4 01 00 00       	push   $0x1f4
80102799:	e8 06 fe ff ff       	call   801025a4 <outb>
8010279e:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
801027a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027a4:	c1 f8 10             	sar    $0x10,%eax
801027a7:	0f b6 c0             	movzbl %al,%eax
801027aa:	83 ec 08             	sub    $0x8,%esp
801027ad:	50                   	push   %eax
801027ae:	68 f5 01 00 00       	push   $0x1f5
801027b3:	e8 ec fd ff ff       	call   801025a4 <outb>
801027b8:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801027bb:	8b 45 08             	mov    0x8(%ebp),%eax
801027be:	8b 40 04             	mov    0x4(%eax),%eax
801027c1:	c1 e0 04             	shl    $0x4,%eax
801027c4:	83 e0 10             	and    $0x10,%eax
801027c7:	89 c2                	mov    %eax,%edx
801027c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027cc:	c1 f8 18             	sar    $0x18,%eax
801027cf:	83 e0 0f             	and    $0xf,%eax
801027d2:	09 d0                	or     %edx,%eax
801027d4:	83 c8 e0             	or     $0xffffffe0,%eax
801027d7:	0f b6 c0             	movzbl %al,%eax
801027da:	83 ec 08             	sub    $0x8,%esp
801027dd:	50                   	push   %eax
801027de:	68 f6 01 00 00       	push   $0x1f6
801027e3:	e8 bc fd ff ff       	call   801025a4 <outb>
801027e8:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
801027eb:	8b 45 08             	mov    0x8(%ebp),%eax
801027ee:	8b 00                	mov    (%eax),%eax
801027f0:	83 e0 04             	and    $0x4,%eax
801027f3:	85 c0                	test   %eax,%eax
801027f5:	74 30                	je     80102827 <idestart+0x149>
    outb(0x1f7, IDE_CMD_WRITE);
801027f7:	83 ec 08             	sub    $0x8,%esp
801027fa:	6a 30                	push   $0x30
801027fc:	68 f7 01 00 00       	push   $0x1f7
80102801:	e8 9e fd ff ff       	call   801025a4 <outb>
80102806:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
80102809:	8b 45 08             	mov    0x8(%ebp),%eax
8010280c:	83 c0 18             	add    $0x18,%eax
8010280f:	83 ec 04             	sub    $0x4,%esp
80102812:	68 80 00 00 00       	push   $0x80
80102817:	50                   	push   %eax
80102818:	68 f0 01 00 00       	push   $0x1f0
8010281d:	e8 a3 fd ff ff       	call   801025c5 <outsl>
80102822:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
80102825:	eb 12                	jmp    80102839 <idestart+0x15b>
    outb(0x1f7, IDE_CMD_READ);
80102827:	83 ec 08             	sub    $0x8,%esp
8010282a:	6a 20                	push   $0x20
8010282c:	68 f7 01 00 00       	push   $0x1f7
80102831:	e8 6e fd ff ff       	call   801025a4 <outb>
80102836:	83 c4 10             	add    $0x10,%esp
}
80102839:	90                   	nop
8010283a:	c9                   	leave  
8010283b:	c3                   	ret    

8010283c <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
8010283c:	55                   	push   %ebp
8010283d:	89 e5                	mov    %esp,%ebp
8010283f:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102842:	83 ec 0c             	sub    $0xc,%esp
80102845:	68 00 b6 10 80       	push   $0x8010b600
8010284a:	e8 7d 29 00 00       	call   801051cc <acquire>
8010284f:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
80102852:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102857:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010285a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010285e:	75 15                	jne    80102875 <ideintr+0x39>
    release(&idelock);
80102860:	83 ec 0c             	sub    $0xc,%esp
80102863:	68 00 b6 10 80       	push   $0x8010b600
80102868:	e8 c6 29 00 00       	call   80105233 <release>
8010286d:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
80102870:	e9 9a 00 00 00       	jmp    8010290f <ideintr+0xd3>
  }
  idequeue = b->qnext;
80102875:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102878:	8b 40 14             	mov    0x14(%eax),%eax
8010287b:	a3 34 b6 10 80       	mov    %eax,0x8010b634

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102880:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102883:	8b 00                	mov    (%eax),%eax
80102885:	83 e0 04             	and    $0x4,%eax
80102888:	85 c0                	test   %eax,%eax
8010288a:	75 2d                	jne    801028b9 <ideintr+0x7d>
8010288c:	83 ec 0c             	sub    $0xc,%esp
8010288f:	6a 01                	push   $0x1
80102891:	e8 55 fd ff ff       	call   801025eb <idewait>
80102896:	83 c4 10             	add    $0x10,%esp
80102899:	85 c0                	test   %eax,%eax
8010289b:	78 1c                	js     801028b9 <ideintr+0x7d>
    insl(0x1f0, b->data, BSIZE/4);
8010289d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028a0:	83 c0 18             	add    $0x18,%eax
801028a3:	83 ec 04             	sub    $0x4,%esp
801028a6:	68 80 00 00 00       	push   $0x80
801028ab:	50                   	push   %eax
801028ac:	68 f0 01 00 00       	push   $0x1f0
801028b1:	e8 c8 fc ff ff       	call   8010257e <insl>
801028b6:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801028b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028bc:	8b 00                	mov    (%eax),%eax
801028be:	83 c8 02             	or     $0x2,%eax
801028c1:	89 c2                	mov    %eax,%edx
801028c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028c6:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
801028c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028cb:	8b 00                	mov    (%eax),%eax
801028cd:	83 e0 fb             	and    $0xfffffffb,%eax
801028d0:	89 c2                	mov    %eax,%edx
801028d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028d5:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801028d7:	83 ec 0c             	sub    $0xc,%esp
801028da:	ff 75 f4             	pushl  -0xc(%ebp)
801028dd:	e8 cc 26 00 00       	call   80104fae <wakeup>
801028e2:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
801028e5:	a1 34 b6 10 80       	mov    0x8010b634,%eax
801028ea:	85 c0                	test   %eax,%eax
801028ec:	74 11                	je     801028ff <ideintr+0xc3>
    idestart(idequeue);
801028ee:	a1 34 b6 10 80       	mov    0x8010b634,%eax
801028f3:	83 ec 0c             	sub    $0xc,%esp
801028f6:	50                   	push   %eax
801028f7:	e8 e2 fd ff ff       	call   801026de <idestart>
801028fc:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
801028ff:	83 ec 0c             	sub    $0xc,%esp
80102902:	68 00 b6 10 80       	push   $0x8010b600
80102907:	e8 27 29 00 00       	call   80105233 <release>
8010290c:	83 c4 10             	add    $0x10,%esp
}
8010290f:	c9                   	leave  
80102910:	c3                   	ret    

80102911 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102911:	55                   	push   %ebp
80102912:	89 e5                	mov    %esp,%ebp
80102914:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
80102917:	8b 45 08             	mov    0x8(%ebp),%eax
8010291a:	8b 00                	mov    (%eax),%eax
8010291c:	83 e0 01             	and    $0x1,%eax
8010291f:	85 c0                	test   %eax,%eax
80102921:	75 0d                	jne    80102930 <iderw+0x1f>
    panic("iderw: buf not busy");
80102923:	83 ec 0c             	sub    $0xc,%esp
80102926:	68 dd 88 10 80       	push   $0x801088dd
8010292b:	e8 37 dc ff ff       	call   80100567 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102930:	8b 45 08             	mov    0x8(%ebp),%eax
80102933:	8b 00                	mov    (%eax),%eax
80102935:	83 e0 06             	and    $0x6,%eax
80102938:	83 f8 02             	cmp    $0x2,%eax
8010293b:	75 0d                	jne    8010294a <iderw+0x39>
    panic("iderw: nothing to do");
8010293d:	83 ec 0c             	sub    $0xc,%esp
80102940:	68 f1 88 10 80       	push   $0x801088f1
80102945:	e8 1d dc ff ff       	call   80100567 <panic>
  if(b->dev != 0 && !havedisk1)
8010294a:	8b 45 08             	mov    0x8(%ebp),%eax
8010294d:	8b 40 04             	mov    0x4(%eax),%eax
80102950:	85 c0                	test   %eax,%eax
80102952:	74 16                	je     8010296a <iderw+0x59>
80102954:	a1 38 b6 10 80       	mov    0x8010b638,%eax
80102959:	85 c0                	test   %eax,%eax
8010295b:	75 0d                	jne    8010296a <iderw+0x59>
    panic("iderw: ide disk 1 not present");
8010295d:	83 ec 0c             	sub    $0xc,%esp
80102960:	68 06 89 10 80       	push   $0x80108906
80102965:	e8 fd db ff ff       	call   80100567 <panic>

  acquire(&idelock);  //DOC:acquire-lock
8010296a:	83 ec 0c             	sub    $0xc,%esp
8010296d:	68 00 b6 10 80       	push   $0x8010b600
80102972:	e8 55 28 00 00       	call   801051cc <acquire>
80102977:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
8010297a:	8b 45 08             	mov    0x8(%ebp),%eax
8010297d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102984:	c7 45 f4 34 b6 10 80 	movl   $0x8010b634,-0xc(%ebp)
8010298b:	eb 0b                	jmp    80102998 <iderw+0x87>
8010298d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102990:	8b 00                	mov    (%eax),%eax
80102992:	83 c0 14             	add    $0x14,%eax
80102995:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102998:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010299b:	8b 00                	mov    (%eax),%eax
8010299d:	85 c0                	test   %eax,%eax
8010299f:	75 ec                	jne    8010298d <iderw+0x7c>
    ;
  *pp = b;
801029a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029a4:	8b 55 08             	mov    0x8(%ebp),%edx
801029a7:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
801029a9:	a1 34 b6 10 80       	mov    0x8010b634,%eax
801029ae:	39 45 08             	cmp    %eax,0x8(%ebp)
801029b1:	75 23                	jne    801029d6 <iderw+0xc5>
    idestart(b);
801029b3:	83 ec 0c             	sub    $0xc,%esp
801029b6:	ff 75 08             	pushl  0x8(%ebp)
801029b9:	e8 20 fd ff ff       	call   801026de <idestart>
801029be:	83 c4 10             	add    $0x10,%esp
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801029c1:	eb 13                	jmp    801029d6 <iderw+0xc5>
    sleep(b, &idelock);
801029c3:	83 ec 08             	sub    $0x8,%esp
801029c6:	68 00 b6 10 80       	push   $0x8010b600
801029cb:	ff 75 08             	pushl  0x8(%ebp)
801029ce:	e8 ed 24 00 00       	call   80104ec0 <sleep>
801029d3:	83 c4 10             	add    $0x10,%esp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801029d6:	8b 45 08             	mov    0x8(%ebp),%eax
801029d9:	8b 00                	mov    (%eax),%eax
801029db:	83 e0 06             	and    $0x6,%eax
801029de:	83 f8 02             	cmp    $0x2,%eax
801029e1:	75 e0                	jne    801029c3 <iderw+0xb2>
  }

  release(&idelock);
801029e3:	83 ec 0c             	sub    $0xc,%esp
801029e6:	68 00 b6 10 80       	push   $0x8010b600
801029eb:	e8 43 28 00 00       	call   80105233 <release>
801029f0:	83 c4 10             	add    $0x10,%esp
}
801029f3:	90                   	nop
801029f4:	c9                   	leave  
801029f5:	c3                   	ret    

801029f6 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
801029f6:	55                   	push   %ebp
801029f7:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
801029f9:	a1 14 22 11 80       	mov    0x80112214,%eax
801029fe:	8b 55 08             	mov    0x8(%ebp),%edx
80102a01:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102a03:	a1 14 22 11 80       	mov    0x80112214,%eax
80102a08:	8b 40 10             	mov    0x10(%eax),%eax
}
80102a0b:	5d                   	pop    %ebp
80102a0c:	c3                   	ret    

80102a0d <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102a0d:	55                   	push   %ebp
80102a0e:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102a10:	a1 14 22 11 80       	mov    0x80112214,%eax
80102a15:	8b 55 08             	mov    0x8(%ebp),%edx
80102a18:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102a1a:	a1 14 22 11 80       	mov    0x80112214,%eax
80102a1f:	8b 55 0c             	mov    0xc(%ebp),%edx
80102a22:	89 50 10             	mov    %edx,0x10(%eax)
}
80102a25:	90                   	nop
80102a26:	5d                   	pop    %ebp
80102a27:	c3                   	ret    

80102a28 <ioapicinit>:

void
ioapicinit(void)
{
80102a28:	55                   	push   %ebp
80102a29:	89 e5                	mov    %esp,%ebp
80102a2b:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
80102a2e:	a1 44 23 11 80       	mov    0x80112344,%eax
80102a33:	85 c0                	test   %eax,%eax
80102a35:	0f 84 a0 00 00 00    	je     80102adb <ioapicinit+0xb3>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102a3b:	c7 05 14 22 11 80 00 	movl   $0xfec00000,0x80112214
80102a42:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102a45:	6a 01                	push   $0x1
80102a47:	e8 aa ff ff ff       	call   801029f6 <ioapicread>
80102a4c:	83 c4 04             	add    $0x4,%esp
80102a4f:	c1 e8 10             	shr    $0x10,%eax
80102a52:	25 ff 00 00 00       	and    $0xff,%eax
80102a57:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102a5a:	6a 00                	push   $0x0
80102a5c:	e8 95 ff ff ff       	call   801029f6 <ioapicread>
80102a61:	83 c4 04             	add    $0x4,%esp
80102a64:	c1 e8 18             	shr    $0x18,%eax
80102a67:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102a6a:	0f b6 05 40 23 11 80 	movzbl 0x80112340,%eax
80102a71:	0f b6 c0             	movzbl %al,%eax
80102a74:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80102a77:	74 10                	je     80102a89 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102a79:	83 ec 0c             	sub    $0xc,%esp
80102a7c:	68 24 89 10 80       	push   $0x80108924
80102a81:	e8 3e d9 ff ff       	call   801003c4 <cprintf>
80102a86:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102a89:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102a90:	eb 3f                	jmp    80102ad1 <ioapicinit+0xa9>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a95:	83 c0 20             	add    $0x20,%eax
80102a98:	0d 00 00 01 00       	or     $0x10000,%eax
80102a9d:	89 c2                	mov    %eax,%edx
80102a9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102aa2:	83 c0 08             	add    $0x8,%eax
80102aa5:	01 c0                	add    %eax,%eax
80102aa7:	83 ec 08             	sub    $0x8,%esp
80102aaa:	52                   	push   %edx
80102aab:	50                   	push   %eax
80102aac:	e8 5c ff ff ff       	call   80102a0d <ioapicwrite>
80102ab1:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ab7:	83 c0 08             	add    $0x8,%eax
80102aba:	01 c0                	add    %eax,%eax
80102abc:	83 c0 01             	add    $0x1,%eax
80102abf:	83 ec 08             	sub    $0x8,%esp
80102ac2:	6a 00                	push   $0x0
80102ac4:	50                   	push   %eax
80102ac5:	e8 43 ff ff ff       	call   80102a0d <ioapicwrite>
80102aca:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i <= maxintr; i++){
80102acd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ad4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102ad7:	7e b9                	jle    80102a92 <ioapicinit+0x6a>
80102ad9:	eb 01                	jmp    80102adc <ioapicinit+0xb4>
    return;
80102adb:	90                   	nop
  }
}
80102adc:	c9                   	leave  
80102add:	c3                   	ret    

80102ade <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102ade:	55                   	push   %ebp
80102adf:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102ae1:	a1 44 23 11 80       	mov    0x80112344,%eax
80102ae6:	85 c0                	test   %eax,%eax
80102ae8:	74 39                	je     80102b23 <ioapicenable+0x45>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102aea:	8b 45 08             	mov    0x8(%ebp),%eax
80102aed:	83 c0 20             	add    $0x20,%eax
80102af0:	89 c2                	mov    %eax,%edx
80102af2:	8b 45 08             	mov    0x8(%ebp),%eax
80102af5:	83 c0 08             	add    $0x8,%eax
80102af8:	01 c0                	add    %eax,%eax
80102afa:	52                   	push   %edx
80102afb:	50                   	push   %eax
80102afc:	e8 0c ff ff ff       	call   80102a0d <ioapicwrite>
80102b01:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102b04:	8b 45 0c             	mov    0xc(%ebp),%eax
80102b07:	c1 e0 18             	shl    $0x18,%eax
80102b0a:	89 c2                	mov    %eax,%edx
80102b0c:	8b 45 08             	mov    0x8(%ebp),%eax
80102b0f:	83 c0 08             	add    $0x8,%eax
80102b12:	01 c0                	add    %eax,%eax
80102b14:	83 c0 01             	add    $0x1,%eax
80102b17:	52                   	push   %edx
80102b18:	50                   	push   %eax
80102b19:	e8 ef fe ff ff       	call   80102a0d <ioapicwrite>
80102b1e:	83 c4 08             	add    $0x8,%esp
80102b21:	eb 01                	jmp    80102b24 <ioapicenable+0x46>
    return;
80102b23:	90                   	nop
}
80102b24:	c9                   	leave  
80102b25:	c3                   	ret    

80102b26 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102b26:	55                   	push   %ebp
80102b27:	89 e5                	mov    %esp,%ebp
80102b29:	8b 45 08             	mov    0x8(%ebp),%eax
80102b2c:	05 00 00 00 80       	add    $0x80000000,%eax
80102b31:	5d                   	pop    %ebp
80102b32:	c3                   	ret    

80102b33 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102b33:	55                   	push   %ebp
80102b34:	89 e5                	mov    %esp,%ebp
80102b36:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102b39:	83 ec 08             	sub    $0x8,%esp
80102b3c:	68 56 89 10 80       	push   $0x80108956
80102b41:	68 20 22 11 80       	push   $0x80112220
80102b46:	e8 5f 26 00 00       	call   801051aa <initlock>
80102b4b:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102b4e:	c7 05 54 22 11 80 00 	movl   $0x0,0x80112254
80102b55:	00 00 00 
  freerange(vstart, vend);
80102b58:	83 ec 08             	sub    $0x8,%esp
80102b5b:	ff 75 0c             	pushl  0xc(%ebp)
80102b5e:	ff 75 08             	pushl  0x8(%ebp)
80102b61:	e8 2a 00 00 00       	call   80102b90 <freerange>
80102b66:	83 c4 10             	add    $0x10,%esp
}
80102b69:	90                   	nop
80102b6a:	c9                   	leave  
80102b6b:	c3                   	ret    

80102b6c <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102b6c:	55                   	push   %ebp
80102b6d:	89 e5                	mov    %esp,%ebp
80102b6f:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102b72:	83 ec 08             	sub    $0x8,%esp
80102b75:	ff 75 0c             	pushl  0xc(%ebp)
80102b78:	ff 75 08             	pushl  0x8(%ebp)
80102b7b:	e8 10 00 00 00       	call   80102b90 <freerange>
80102b80:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102b83:	c7 05 54 22 11 80 01 	movl   $0x1,0x80112254
80102b8a:	00 00 00 
}
80102b8d:	90                   	nop
80102b8e:	c9                   	leave  
80102b8f:	c3                   	ret    

80102b90 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102b90:	55                   	push   %ebp
80102b91:	89 e5                	mov    %esp,%ebp
80102b93:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102b96:	8b 45 08             	mov    0x8(%ebp),%eax
80102b99:	05 ff 0f 00 00       	add    $0xfff,%eax
80102b9e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102ba3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102ba6:	eb 15                	jmp    80102bbd <freerange+0x2d>
    kfree(p);
80102ba8:	83 ec 0c             	sub    $0xc,%esp
80102bab:	ff 75 f4             	pushl  -0xc(%ebp)
80102bae:	e8 1a 00 00 00       	call   80102bcd <kfree>
80102bb3:	83 c4 10             	add    $0x10,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102bb6:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102bbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bc0:	05 00 10 00 00       	add    $0x1000,%eax
80102bc5:	39 45 0c             	cmp    %eax,0xc(%ebp)
80102bc8:	73 de                	jae    80102ba8 <freerange+0x18>
}
80102bca:	90                   	nop
80102bcb:	c9                   	leave  
80102bcc:	c3                   	ret    

80102bcd <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102bcd:	55                   	push   %ebp
80102bce:	89 e5                	mov    %esp,%ebp
80102bd0:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102bd3:	8b 45 08             	mov    0x8(%ebp),%eax
80102bd6:	25 ff 0f 00 00       	and    $0xfff,%eax
80102bdb:	85 c0                	test   %eax,%eax
80102bdd:	75 1b                	jne    80102bfa <kfree+0x2d>
80102bdf:	81 7d 08 3c 53 11 80 	cmpl   $0x8011533c,0x8(%ebp)
80102be6:	72 12                	jb     80102bfa <kfree+0x2d>
80102be8:	ff 75 08             	pushl  0x8(%ebp)
80102beb:	e8 36 ff ff ff       	call   80102b26 <v2p>
80102bf0:	83 c4 04             	add    $0x4,%esp
80102bf3:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102bf8:	76 0d                	jbe    80102c07 <kfree+0x3a>
    panic("kfree");
80102bfa:	83 ec 0c             	sub    $0xc,%esp
80102bfd:	68 5b 89 10 80       	push   $0x8010895b
80102c02:	e8 60 d9 ff ff       	call   80100567 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102c07:	83 ec 04             	sub    $0x4,%esp
80102c0a:	68 00 10 00 00       	push   $0x1000
80102c0f:	6a 01                	push   $0x1
80102c11:	ff 75 08             	pushl  0x8(%ebp)
80102c14:	e8 16 28 00 00       	call   8010542f <memset>
80102c19:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102c1c:	a1 54 22 11 80       	mov    0x80112254,%eax
80102c21:	85 c0                	test   %eax,%eax
80102c23:	74 10                	je     80102c35 <kfree+0x68>
    acquire(&kmem.lock);
80102c25:	83 ec 0c             	sub    $0xc,%esp
80102c28:	68 20 22 11 80       	push   $0x80112220
80102c2d:	e8 9a 25 00 00       	call   801051cc <acquire>
80102c32:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102c35:	8b 45 08             	mov    0x8(%ebp),%eax
80102c38:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102c3b:	8b 15 58 22 11 80    	mov    0x80112258,%edx
80102c41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c44:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102c46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c49:	a3 58 22 11 80       	mov    %eax,0x80112258
  if(kmem.use_lock)
80102c4e:	a1 54 22 11 80       	mov    0x80112254,%eax
80102c53:	85 c0                	test   %eax,%eax
80102c55:	74 10                	je     80102c67 <kfree+0x9a>
    release(&kmem.lock);
80102c57:	83 ec 0c             	sub    $0xc,%esp
80102c5a:	68 20 22 11 80       	push   $0x80112220
80102c5f:	e8 cf 25 00 00       	call   80105233 <release>
80102c64:	83 c4 10             	add    $0x10,%esp
}
80102c67:	90                   	nop
80102c68:	c9                   	leave  
80102c69:	c3                   	ret    

80102c6a <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102c6a:	55                   	push   %ebp
80102c6b:	89 e5                	mov    %esp,%ebp
80102c6d:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102c70:	a1 54 22 11 80       	mov    0x80112254,%eax
80102c75:	85 c0                	test   %eax,%eax
80102c77:	74 10                	je     80102c89 <kalloc+0x1f>
    acquire(&kmem.lock);
80102c79:	83 ec 0c             	sub    $0xc,%esp
80102c7c:	68 20 22 11 80       	push   $0x80112220
80102c81:	e8 46 25 00 00       	call   801051cc <acquire>
80102c86:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102c89:	a1 58 22 11 80       	mov    0x80112258,%eax
80102c8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102c91:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102c95:	74 0a                	je     80102ca1 <kalloc+0x37>
    kmem.freelist = r->next;
80102c97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c9a:	8b 00                	mov    (%eax),%eax
80102c9c:	a3 58 22 11 80       	mov    %eax,0x80112258
  if(kmem.use_lock)
80102ca1:	a1 54 22 11 80       	mov    0x80112254,%eax
80102ca6:	85 c0                	test   %eax,%eax
80102ca8:	74 10                	je     80102cba <kalloc+0x50>
    release(&kmem.lock);
80102caa:	83 ec 0c             	sub    $0xc,%esp
80102cad:	68 20 22 11 80       	push   $0x80112220
80102cb2:	e8 7c 25 00 00       	call   80105233 <release>
80102cb7:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102cba:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102cbd:	c9                   	leave  
80102cbe:	c3                   	ret    

80102cbf <inb>:
{
80102cbf:	55                   	push   %ebp
80102cc0:	89 e5                	mov    %esp,%ebp
80102cc2:	83 ec 14             	sub    $0x14,%esp
80102cc5:	8b 45 08             	mov    0x8(%ebp),%eax
80102cc8:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ccc:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102cd0:	89 c2                	mov    %eax,%edx
80102cd2:	ec                   	in     (%dx),%al
80102cd3:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102cd6:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102cda:	c9                   	leave  
80102cdb:	c3                   	ret    

80102cdc <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102cdc:	55                   	push   %ebp
80102cdd:	89 e5                	mov    %esp,%ebp
80102cdf:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102ce2:	6a 64                	push   $0x64
80102ce4:	e8 d6 ff ff ff       	call   80102cbf <inb>
80102ce9:	83 c4 04             	add    $0x4,%esp
80102cec:	0f b6 c0             	movzbl %al,%eax
80102cef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102cf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cf5:	83 e0 01             	and    $0x1,%eax
80102cf8:	85 c0                	test   %eax,%eax
80102cfa:	75 0a                	jne    80102d06 <kbdgetc+0x2a>
    return -1;
80102cfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102d01:	e9 23 01 00 00       	jmp    80102e29 <kbdgetc+0x14d>
  data = inb(KBDATAP);
80102d06:	6a 60                	push   $0x60
80102d08:	e8 b2 ff ff ff       	call   80102cbf <inb>
80102d0d:	83 c4 04             	add    $0x4,%esp
80102d10:	0f b6 c0             	movzbl %al,%eax
80102d13:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102d16:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102d1d:	75 17                	jne    80102d36 <kbdgetc+0x5a>
    shift |= E0ESC;
80102d1f:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d24:	83 c8 40             	or     $0x40,%eax
80102d27:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102d2c:	b8 00 00 00 00       	mov    $0x0,%eax
80102d31:	e9 f3 00 00 00       	jmp    80102e29 <kbdgetc+0x14d>
  } else if(data & 0x80){
80102d36:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d39:	25 80 00 00 00       	and    $0x80,%eax
80102d3e:	85 c0                	test   %eax,%eax
80102d40:	74 45                	je     80102d87 <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102d42:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d47:	83 e0 40             	and    $0x40,%eax
80102d4a:	85 c0                	test   %eax,%eax
80102d4c:	75 08                	jne    80102d56 <kbdgetc+0x7a>
80102d4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d51:	83 e0 7f             	and    $0x7f,%eax
80102d54:	eb 03                	jmp    80102d59 <kbdgetc+0x7d>
80102d56:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d59:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102d5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d5f:	05 20 90 10 80       	add    $0x80109020,%eax
80102d64:	0f b6 00             	movzbl (%eax),%eax
80102d67:	83 c8 40             	or     $0x40,%eax
80102d6a:	0f b6 c0             	movzbl %al,%eax
80102d6d:	f7 d0                	not    %eax
80102d6f:	89 c2                	mov    %eax,%edx
80102d71:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d76:	21 d0                	and    %edx,%eax
80102d78:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102d7d:	b8 00 00 00 00       	mov    $0x0,%eax
80102d82:	e9 a2 00 00 00       	jmp    80102e29 <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80102d87:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d8c:	83 e0 40             	and    $0x40,%eax
80102d8f:	85 c0                	test   %eax,%eax
80102d91:	74 14                	je     80102da7 <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102d93:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102d9a:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d9f:	83 e0 bf             	and    $0xffffffbf,%eax
80102da2:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  }

  shift |= shiftcode[data];
80102da7:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102daa:	05 20 90 10 80       	add    $0x80109020,%eax
80102daf:	0f b6 00             	movzbl (%eax),%eax
80102db2:	0f b6 d0             	movzbl %al,%edx
80102db5:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102dba:	09 d0                	or     %edx,%eax
80102dbc:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  shift ^= togglecode[data];
80102dc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102dc4:	05 20 91 10 80       	add    $0x80109120,%eax
80102dc9:	0f b6 00             	movzbl (%eax),%eax
80102dcc:	0f b6 d0             	movzbl %al,%edx
80102dcf:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102dd4:	31 d0                	xor    %edx,%eax
80102dd6:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  c = charcode[shift & (CTL | SHIFT)][data];
80102ddb:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102de0:	83 e0 03             	and    $0x3,%eax
80102de3:	8b 14 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%edx
80102dea:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102ded:	01 d0                	add    %edx,%eax
80102def:	0f b6 00             	movzbl (%eax),%eax
80102df2:	0f b6 c0             	movzbl %al,%eax
80102df5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102df8:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102dfd:	83 e0 08             	and    $0x8,%eax
80102e00:	85 c0                	test   %eax,%eax
80102e02:	74 22                	je     80102e26 <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
80102e04:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102e08:	76 0c                	jbe    80102e16 <kbdgetc+0x13a>
80102e0a:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102e0e:	77 06                	ja     80102e16 <kbdgetc+0x13a>
      c += 'A' - 'a';
80102e10:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102e14:	eb 10                	jmp    80102e26 <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
80102e16:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102e1a:	76 0a                	jbe    80102e26 <kbdgetc+0x14a>
80102e1c:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102e20:	77 04                	ja     80102e26 <kbdgetc+0x14a>
      c += 'a' - 'A';
80102e22:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102e26:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102e29:	c9                   	leave  
80102e2a:	c3                   	ret    

80102e2b <kbdintr>:

void
kbdintr(void)
{
80102e2b:	55                   	push   %ebp
80102e2c:	89 e5                	mov    %esp,%ebp
80102e2e:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80102e31:	83 ec 0c             	sub    $0xc,%esp
80102e34:	68 dc 2c 10 80       	push   $0x80102cdc
80102e39:	e8 c4 d9 ff ff       	call   80100802 <consoleintr>
80102e3e:	83 c4 10             	add    $0x10,%esp
}
80102e41:	90                   	nop
80102e42:	c9                   	leave  
80102e43:	c3                   	ret    

80102e44 <inb>:
{
80102e44:	55                   	push   %ebp
80102e45:	89 e5                	mov    %esp,%ebp
80102e47:	83 ec 14             	sub    $0x14,%esp
80102e4a:	8b 45 08             	mov    0x8(%ebp),%eax
80102e4d:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e51:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102e55:	89 c2                	mov    %eax,%edx
80102e57:	ec                   	in     (%dx),%al
80102e58:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102e5b:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102e5f:	c9                   	leave  
80102e60:	c3                   	ret    

80102e61 <outb>:
{
80102e61:	55                   	push   %ebp
80102e62:	89 e5                	mov    %esp,%ebp
80102e64:	83 ec 08             	sub    $0x8,%esp
80102e67:	8b 45 08             	mov    0x8(%ebp),%eax
80102e6a:	8b 55 0c             	mov    0xc(%ebp),%edx
80102e6d:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80102e71:	89 d0                	mov    %edx,%eax
80102e73:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e76:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102e7a:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102e7e:	ee                   	out    %al,(%dx)
}
80102e7f:	90                   	nop
80102e80:	c9                   	leave  
80102e81:	c3                   	ret    

80102e82 <readeflags>:
{
80102e82:	55                   	push   %ebp
80102e83:	89 e5                	mov    %esp,%ebp
80102e85:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102e88:	9c                   	pushf  
80102e89:	58                   	pop    %eax
80102e8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102e8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102e90:	c9                   	leave  
80102e91:	c3                   	ret    

80102e92 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102e92:	55                   	push   %ebp
80102e93:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102e95:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102e9a:	8b 55 08             	mov    0x8(%ebp),%edx
80102e9d:	c1 e2 02             	shl    $0x2,%edx
80102ea0:	01 c2                	add    %eax,%edx
80102ea2:	8b 45 0c             	mov    0xc(%ebp),%eax
80102ea5:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102ea7:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102eac:	83 c0 20             	add    $0x20,%eax
80102eaf:	8b 00                	mov    (%eax),%eax
}
80102eb1:	90                   	nop
80102eb2:	5d                   	pop    %ebp
80102eb3:	c3                   	ret    

80102eb4 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102eb4:	55                   	push   %ebp
80102eb5:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
80102eb7:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102ebc:	85 c0                	test   %eax,%eax
80102ebe:	0f 84 0c 01 00 00    	je     80102fd0 <lapicinit+0x11c>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102ec4:	68 3f 01 00 00       	push   $0x13f
80102ec9:	6a 3c                	push   $0x3c
80102ecb:	e8 c2 ff ff ff       	call   80102e92 <lapicw>
80102ed0:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102ed3:	6a 0b                	push   $0xb
80102ed5:	68 f8 00 00 00       	push   $0xf8
80102eda:	e8 b3 ff ff ff       	call   80102e92 <lapicw>
80102edf:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102ee2:	68 20 00 02 00       	push   $0x20020
80102ee7:	68 c8 00 00 00       	push   $0xc8
80102eec:	e8 a1 ff ff ff       	call   80102e92 <lapicw>
80102ef1:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
80102ef4:	68 80 96 98 00       	push   $0x989680
80102ef9:	68 e0 00 00 00       	push   $0xe0
80102efe:	e8 8f ff ff ff       	call   80102e92 <lapicw>
80102f03:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102f06:	68 00 00 01 00       	push   $0x10000
80102f0b:	68 d4 00 00 00       	push   $0xd4
80102f10:	e8 7d ff ff ff       	call   80102e92 <lapicw>
80102f15:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80102f18:	68 00 00 01 00       	push   $0x10000
80102f1d:	68 d8 00 00 00       	push   $0xd8
80102f22:	e8 6b ff ff ff       	call   80102e92 <lapicw>
80102f27:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102f2a:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102f2f:	83 c0 30             	add    $0x30,%eax
80102f32:	8b 00                	mov    (%eax),%eax
80102f34:	c1 e8 10             	shr    $0x10,%eax
80102f37:	25 fc 00 00 00       	and    $0xfc,%eax
80102f3c:	85 c0                	test   %eax,%eax
80102f3e:	74 12                	je     80102f52 <lapicinit+0x9e>
    lapicw(PCINT, MASKED);
80102f40:	68 00 00 01 00       	push   $0x10000
80102f45:	68 d0 00 00 00       	push   $0xd0
80102f4a:	e8 43 ff ff ff       	call   80102e92 <lapicw>
80102f4f:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102f52:	6a 33                	push   $0x33
80102f54:	68 dc 00 00 00       	push   $0xdc
80102f59:	e8 34 ff ff ff       	call   80102e92 <lapicw>
80102f5e:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102f61:	6a 00                	push   $0x0
80102f63:	68 a0 00 00 00       	push   $0xa0
80102f68:	e8 25 ff ff ff       	call   80102e92 <lapicw>
80102f6d:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80102f70:	6a 00                	push   $0x0
80102f72:	68 a0 00 00 00       	push   $0xa0
80102f77:	e8 16 ff ff ff       	call   80102e92 <lapicw>
80102f7c:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102f7f:	6a 00                	push   $0x0
80102f81:	6a 2c                	push   $0x2c
80102f83:	e8 0a ff ff ff       	call   80102e92 <lapicw>
80102f88:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102f8b:	6a 00                	push   $0x0
80102f8d:	68 c4 00 00 00       	push   $0xc4
80102f92:	e8 fb fe ff ff       	call   80102e92 <lapicw>
80102f97:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102f9a:	68 00 85 08 00       	push   $0x88500
80102f9f:	68 c0 00 00 00       	push   $0xc0
80102fa4:	e8 e9 fe ff ff       	call   80102e92 <lapicw>
80102fa9:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80102fac:	90                   	nop
80102fad:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102fb2:	05 00 03 00 00       	add    $0x300,%eax
80102fb7:	8b 00                	mov    (%eax),%eax
80102fb9:	25 00 10 00 00       	and    $0x1000,%eax
80102fbe:	85 c0                	test   %eax,%eax
80102fc0:	75 eb                	jne    80102fad <lapicinit+0xf9>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102fc2:	6a 00                	push   $0x0
80102fc4:	6a 20                	push   $0x20
80102fc6:	e8 c7 fe ff ff       	call   80102e92 <lapicw>
80102fcb:	83 c4 08             	add    $0x8,%esp
80102fce:	eb 01                	jmp    80102fd1 <lapicinit+0x11d>
    return;
80102fd0:	90                   	nop
}
80102fd1:	c9                   	leave  
80102fd2:	c3                   	ret    

80102fd3 <cpunum>:

int
cpunum(void)
{
80102fd3:	55                   	push   %ebp
80102fd4:	89 e5                	mov    %esp,%ebp
80102fd6:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102fd9:	e8 a4 fe ff ff       	call   80102e82 <readeflags>
80102fde:	25 00 02 00 00       	and    $0x200,%eax
80102fe3:	85 c0                	test   %eax,%eax
80102fe5:	74 26                	je     8010300d <cpunum+0x3a>
    static int n;
    if(n++ == 0)
80102fe7:	a1 40 b6 10 80       	mov    0x8010b640,%eax
80102fec:	8d 50 01             	lea    0x1(%eax),%edx
80102fef:	89 15 40 b6 10 80    	mov    %edx,0x8010b640
80102ff5:	85 c0                	test   %eax,%eax
80102ff7:	75 14                	jne    8010300d <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
80102ff9:	8b 45 04             	mov    0x4(%ebp),%eax
80102ffc:	83 ec 08             	sub    $0x8,%esp
80102fff:	50                   	push   %eax
80103000:	68 64 89 10 80       	push   $0x80108964
80103005:	e8 ba d3 ff ff       	call   801003c4 <cprintf>
8010300a:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
8010300d:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80103012:	85 c0                	test   %eax,%eax
80103014:	74 0f                	je     80103025 <cpunum+0x52>
    return lapic[ID]>>24;
80103016:	a1 5c 22 11 80       	mov    0x8011225c,%eax
8010301b:	83 c0 20             	add    $0x20,%eax
8010301e:	8b 00                	mov    (%eax),%eax
80103020:	c1 e8 18             	shr    $0x18,%eax
80103023:	eb 05                	jmp    8010302a <cpunum+0x57>
  return 0;
80103025:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010302a:	c9                   	leave  
8010302b:	c3                   	ret    

8010302c <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
8010302c:	55                   	push   %ebp
8010302d:	89 e5                	mov    %esp,%ebp
  if(lapic)
8010302f:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80103034:	85 c0                	test   %eax,%eax
80103036:	74 0c                	je     80103044 <lapiceoi+0x18>
    lapicw(EOI, 0);
80103038:	6a 00                	push   $0x0
8010303a:	6a 2c                	push   $0x2c
8010303c:	e8 51 fe ff ff       	call   80102e92 <lapicw>
80103041:	83 c4 08             	add    $0x8,%esp
}
80103044:	90                   	nop
80103045:	c9                   	leave  
80103046:	c3                   	ret    

80103047 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80103047:	55                   	push   %ebp
80103048:	89 e5                	mov    %esp,%ebp
}
8010304a:	90                   	nop
8010304b:	5d                   	pop    %ebp
8010304c:	c3                   	ret    

8010304d <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
8010304d:	55                   	push   %ebp
8010304e:	89 e5                	mov    %esp,%ebp
80103050:	83 ec 14             	sub    $0x14,%esp
80103053:	8b 45 08             	mov    0x8(%ebp),%eax
80103056:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
80103059:	6a 0f                	push   $0xf
8010305b:	6a 70                	push   $0x70
8010305d:	e8 ff fd ff ff       	call   80102e61 <outb>
80103062:	83 c4 08             	add    $0x8,%esp
  outb(CMOS_PORT+1, 0x0A);
80103065:	6a 0a                	push   $0xa
80103067:	6a 71                	push   $0x71
80103069:	e8 f3 fd ff ff       	call   80102e61 <outb>
8010306e:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80103071:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80103078:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010307b:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80103080:	8b 45 0c             	mov    0xc(%ebp),%eax
80103083:	c1 e8 04             	shr    $0x4,%eax
80103086:	89 c2                	mov    %eax,%edx
80103088:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010308b:	83 c0 02             	add    $0x2,%eax
8010308e:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103091:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103095:	c1 e0 18             	shl    $0x18,%eax
80103098:	50                   	push   %eax
80103099:	68 c4 00 00 00       	push   $0xc4
8010309e:	e8 ef fd ff ff       	call   80102e92 <lapicw>
801030a3:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
801030a6:	68 00 c5 00 00       	push   $0xc500
801030ab:	68 c0 00 00 00       	push   $0xc0
801030b0:	e8 dd fd ff ff       	call   80102e92 <lapicw>
801030b5:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
801030b8:	68 c8 00 00 00       	push   $0xc8
801030bd:	e8 85 ff ff ff       	call   80103047 <microdelay>
801030c2:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
801030c5:	68 00 85 00 00       	push   $0x8500
801030ca:	68 c0 00 00 00       	push   $0xc0
801030cf:	e8 be fd ff ff       	call   80102e92 <lapicw>
801030d4:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
801030d7:	6a 64                	push   $0x64
801030d9:	e8 69 ff ff ff       	call   80103047 <microdelay>
801030de:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801030e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801030e8:	eb 3d                	jmp    80103127 <lapicstartap+0xda>
    lapicw(ICRHI, apicid<<24);
801030ea:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801030ee:	c1 e0 18             	shl    $0x18,%eax
801030f1:	50                   	push   %eax
801030f2:	68 c4 00 00 00       	push   $0xc4
801030f7:	e8 96 fd ff ff       	call   80102e92 <lapicw>
801030fc:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
801030ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80103102:	c1 e8 0c             	shr    $0xc,%eax
80103105:	80 cc 06             	or     $0x6,%ah
80103108:	50                   	push   %eax
80103109:	68 c0 00 00 00       	push   $0xc0
8010310e:	e8 7f fd ff ff       	call   80102e92 <lapicw>
80103113:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
80103116:	68 c8 00 00 00       	push   $0xc8
8010311b:	e8 27 ff ff ff       	call   80103047 <microdelay>
80103120:	83 c4 04             	add    $0x4,%esp
  for(i = 0; i < 2; i++){
80103123:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103127:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
8010312b:	7e bd                	jle    801030ea <lapicstartap+0x9d>
  }
}
8010312d:	90                   	nop
8010312e:	c9                   	leave  
8010312f:	c3                   	ret    

80103130 <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
80103130:	55                   	push   %ebp
80103131:	89 e5                	mov    %esp,%ebp
  outb(CMOS_PORT,  reg);
80103133:	8b 45 08             	mov    0x8(%ebp),%eax
80103136:	0f b6 c0             	movzbl %al,%eax
80103139:	50                   	push   %eax
8010313a:	6a 70                	push   $0x70
8010313c:	e8 20 fd ff ff       	call   80102e61 <outb>
80103141:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103144:	68 c8 00 00 00       	push   $0xc8
80103149:	e8 f9 fe ff ff       	call   80103047 <microdelay>
8010314e:	83 c4 04             	add    $0x4,%esp

  return inb(CMOS_RETURN);
80103151:	6a 71                	push   $0x71
80103153:	e8 ec fc ff ff       	call   80102e44 <inb>
80103158:	83 c4 04             	add    $0x4,%esp
8010315b:	0f b6 c0             	movzbl %al,%eax
}
8010315e:	c9                   	leave  
8010315f:	c3                   	ret    

80103160 <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
80103160:	55                   	push   %ebp
80103161:	89 e5                	mov    %esp,%ebp
  r->second = cmos_read(SECS);
80103163:	6a 00                	push   $0x0
80103165:	e8 c6 ff ff ff       	call   80103130 <cmos_read>
8010316a:	83 c4 04             	add    $0x4,%esp
8010316d:	89 c2                	mov    %eax,%edx
8010316f:	8b 45 08             	mov    0x8(%ebp),%eax
80103172:	89 10                	mov    %edx,(%eax)
  r->minute = cmos_read(MINS);
80103174:	6a 02                	push   $0x2
80103176:	e8 b5 ff ff ff       	call   80103130 <cmos_read>
8010317b:	83 c4 04             	add    $0x4,%esp
8010317e:	89 c2                	mov    %eax,%edx
80103180:	8b 45 08             	mov    0x8(%ebp),%eax
80103183:	89 50 04             	mov    %edx,0x4(%eax)
  r->hour   = cmos_read(HOURS);
80103186:	6a 04                	push   $0x4
80103188:	e8 a3 ff ff ff       	call   80103130 <cmos_read>
8010318d:	83 c4 04             	add    $0x4,%esp
80103190:	89 c2                	mov    %eax,%edx
80103192:	8b 45 08             	mov    0x8(%ebp),%eax
80103195:	89 50 08             	mov    %edx,0x8(%eax)
  r->day    = cmos_read(DAY);
80103198:	6a 07                	push   $0x7
8010319a:	e8 91 ff ff ff       	call   80103130 <cmos_read>
8010319f:	83 c4 04             	add    $0x4,%esp
801031a2:	89 c2                	mov    %eax,%edx
801031a4:	8b 45 08             	mov    0x8(%ebp),%eax
801031a7:	89 50 0c             	mov    %edx,0xc(%eax)
  r->month  = cmos_read(MONTH);
801031aa:	6a 08                	push   $0x8
801031ac:	e8 7f ff ff ff       	call   80103130 <cmos_read>
801031b1:	83 c4 04             	add    $0x4,%esp
801031b4:	89 c2                	mov    %eax,%edx
801031b6:	8b 45 08             	mov    0x8(%ebp),%eax
801031b9:	89 50 10             	mov    %edx,0x10(%eax)
  r->year   = cmos_read(YEAR);
801031bc:	6a 09                	push   $0x9
801031be:	e8 6d ff ff ff       	call   80103130 <cmos_read>
801031c3:	83 c4 04             	add    $0x4,%esp
801031c6:	89 c2                	mov    %eax,%edx
801031c8:	8b 45 08             	mov    0x8(%ebp),%eax
801031cb:	89 50 14             	mov    %edx,0x14(%eax)
}
801031ce:	90                   	nop
801031cf:	c9                   	leave  
801031d0:	c3                   	ret    

801031d1 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801031d1:	55                   	push   %ebp
801031d2:	89 e5                	mov    %esp,%ebp
801031d4:	83 ec 48             	sub    $0x48,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
801031d7:	6a 0b                	push   $0xb
801031d9:	e8 52 ff ff ff       	call   80103130 <cmos_read>
801031de:	83 c4 04             	add    $0x4,%esp
801031e1:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
801031e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031e7:	83 e0 04             	and    $0x4,%eax
801031ea:	85 c0                	test   %eax,%eax
801031ec:	0f 94 c0             	sete   %al
801031ef:	0f b6 c0             	movzbl %al,%eax
801031f2:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for (;;) {
    fill_rtcdate(&t1);
801031f5:	8d 45 d8             	lea    -0x28(%ebp),%eax
801031f8:	50                   	push   %eax
801031f9:	e8 62 ff ff ff       	call   80103160 <fill_rtcdate>
801031fe:	83 c4 04             	add    $0x4,%esp
    if (cmos_read(CMOS_STATA) & CMOS_UIP)
80103201:	6a 0a                	push   $0xa
80103203:	e8 28 ff ff ff       	call   80103130 <cmos_read>
80103208:	83 c4 04             	add    $0x4,%esp
8010320b:	25 80 00 00 00       	and    $0x80,%eax
80103210:	85 c0                	test   %eax,%eax
80103212:	75 27                	jne    8010323b <cmostime+0x6a>
        continue;
    fill_rtcdate(&t2);
80103214:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103217:	50                   	push   %eax
80103218:	e8 43 ff ff ff       	call   80103160 <fill_rtcdate>
8010321d:	83 c4 04             	add    $0x4,%esp
    if (memcmp(&t1, &t2, sizeof(t1)) == 0)
80103220:	83 ec 04             	sub    $0x4,%esp
80103223:	6a 18                	push   $0x18
80103225:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103228:	50                   	push   %eax
80103229:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010322c:	50                   	push   %eax
8010322d:	e8 64 22 00 00       	call   80105496 <memcmp>
80103232:	83 c4 10             	add    $0x10,%esp
80103235:	85 c0                	test   %eax,%eax
80103237:	74 05                	je     8010323e <cmostime+0x6d>
80103239:	eb ba                	jmp    801031f5 <cmostime+0x24>
        continue;
8010323b:	90                   	nop
    fill_rtcdate(&t1);
8010323c:	eb b7                	jmp    801031f5 <cmostime+0x24>
      break;
8010323e:	90                   	nop
  }

  // convert
  if (bcd) {
8010323f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103243:	0f 84 b4 00 00 00    	je     801032fd <cmostime+0x12c>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103249:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010324c:	c1 e8 04             	shr    $0x4,%eax
8010324f:	89 c2                	mov    %eax,%edx
80103251:	89 d0                	mov    %edx,%eax
80103253:	c1 e0 02             	shl    $0x2,%eax
80103256:	01 d0                	add    %edx,%eax
80103258:	01 c0                	add    %eax,%eax
8010325a:	89 c2                	mov    %eax,%edx
8010325c:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010325f:	83 e0 0f             	and    $0xf,%eax
80103262:	01 d0                	add    %edx,%eax
80103264:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
80103267:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010326a:	c1 e8 04             	shr    $0x4,%eax
8010326d:	89 c2                	mov    %eax,%edx
8010326f:	89 d0                	mov    %edx,%eax
80103271:	c1 e0 02             	shl    $0x2,%eax
80103274:	01 d0                	add    %edx,%eax
80103276:	01 c0                	add    %eax,%eax
80103278:	89 c2                	mov    %eax,%edx
8010327a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010327d:	83 e0 0f             	and    $0xf,%eax
80103280:	01 d0                	add    %edx,%eax
80103282:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
80103285:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103288:	c1 e8 04             	shr    $0x4,%eax
8010328b:	89 c2                	mov    %eax,%edx
8010328d:	89 d0                	mov    %edx,%eax
8010328f:	c1 e0 02             	shl    $0x2,%eax
80103292:	01 d0                	add    %edx,%eax
80103294:	01 c0                	add    %eax,%eax
80103296:	89 c2                	mov    %eax,%edx
80103298:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010329b:	83 e0 0f             	and    $0xf,%eax
8010329e:	01 d0                	add    %edx,%eax
801032a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
801032a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032a6:	c1 e8 04             	shr    $0x4,%eax
801032a9:	89 c2                	mov    %eax,%edx
801032ab:	89 d0                	mov    %edx,%eax
801032ad:	c1 e0 02             	shl    $0x2,%eax
801032b0:	01 d0                	add    %edx,%eax
801032b2:	01 c0                	add    %eax,%eax
801032b4:	89 c2                	mov    %eax,%edx
801032b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032b9:	83 e0 0f             	and    $0xf,%eax
801032bc:	01 d0                	add    %edx,%eax
801032be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
801032c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801032c4:	c1 e8 04             	shr    $0x4,%eax
801032c7:	89 c2                	mov    %eax,%edx
801032c9:	89 d0                	mov    %edx,%eax
801032cb:	c1 e0 02             	shl    $0x2,%eax
801032ce:	01 d0                	add    %edx,%eax
801032d0:	01 c0                	add    %eax,%eax
801032d2:	89 c2                	mov    %eax,%edx
801032d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
801032d7:	83 e0 0f             	and    $0xf,%eax
801032da:	01 d0                	add    %edx,%eax
801032dc:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
801032df:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032e2:	c1 e8 04             	shr    $0x4,%eax
801032e5:	89 c2                	mov    %eax,%edx
801032e7:	89 d0                	mov    %edx,%eax
801032e9:	c1 e0 02             	shl    $0x2,%eax
801032ec:	01 d0                	add    %edx,%eax
801032ee:	01 c0                	add    %eax,%eax
801032f0:	89 c2                	mov    %eax,%edx
801032f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032f5:	83 e0 0f             	and    $0xf,%eax
801032f8:	01 d0                	add    %edx,%eax
801032fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
801032fd:	8b 45 08             	mov    0x8(%ebp),%eax
80103300:	8b 55 d8             	mov    -0x28(%ebp),%edx
80103303:	89 10                	mov    %edx,(%eax)
80103305:	8b 55 dc             	mov    -0x24(%ebp),%edx
80103308:	89 50 04             	mov    %edx,0x4(%eax)
8010330b:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010330e:	89 50 08             	mov    %edx,0x8(%eax)
80103311:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103314:	89 50 0c             	mov    %edx,0xc(%eax)
80103317:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010331a:	89 50 10             	mov    %edx,0x10(%eax)
8010331d:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103320:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
80103323:	8b 45 08             	mov    0x8(%ebp),%eax
80103326:	8b 40 14             	mov    0x14(%eax),%eax
80103329:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
8010332f:	8b 45 08             	mov    0x8(%ebp),%eax
80103332:	89 50 14             	mov    %edx,0x14(%eax)
}
80103335:	90                   	nop
80103336:	c9                   	leave  
80103337:	c3                   	ret    

80103338 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80103338:	55                   	push   %ebp
80103339:	89 e5                	mov    %esp,%ebp
8010333b:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
8010333e:	83 ec 08             	sub    $0x8,%esp
80103341:	68 90 89 10 80       	push   $0x80108990
80103346:	68 60 22 11 80       	push   $0x80112260
8010334b:	e8 5a 1e 00 00       	call   801051aa <initlock>
80103350:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
80103353:	83 ec 08             	sub    $0x8,%esp
80103356:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103359:	50                   	push   %eax
8010335a:	ff 75 08             	pushl  0x8(%ebp)
8010335d:	e8 2d e0 ff ff       	call   8010138f <readsb>
80103362:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
80103365:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103368:	a3 94 22 11 80       	mov    %eax,0x80112294
  log.size = sb.nlog;
8010336d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103370:	a3 98 22 11 80       	mov    %eax,0x80112298
  log.dev = dev;
80103375:	8b 45 08             	mov    0x8(%ebp),%eax
80103378:	a3 a4 22 11 80       	mov    %eax,0x801122a4
  recover_from_log();
8010337d:	e8 b2 01 00 00       	call   80103534 <recover_from_log>
}
80103382:	90                   	nop
80103383:	c9                   	leave  
80103384:	c3                   	ret    

80103385 <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
80103385:	55                   	push   %ebp
80103386:	89 e5                	mov    %esp,%ebp
80103388:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010338b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103392:	e9 95 00 00 00       	jmp    8010342c <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103397:	8b 15 94 22 11 80    	mov    0x80112294,%edx
8010339d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801033a0:	01 d0                	add    %edx,%eax
801033a2:	83 c0 01             	add    $0x1,%eax
801033a5:	89 c2                	mov    %eax,%edx
801033a7:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801033ac:	83 ec 08             	sub    $0x8,%esp
801033af:	52                   	push   %edx
801033b0:	50                   	push   %eax
801033b1:	e8 00 ce ff ff       	call   801001b6 <bread>
801033b6:	83 c4 10             	add    $0x10,%esp
801033b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801033bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801033bf:	83 c0 10             	add    $0x10,%eax
801033c2:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
801033c9:	89 c2                	mov    %eax,%edx
801033cb:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801033d0:	83 ec 08             	sub    $0x8,%esp
801033d3:	52                   	push   %edx
801033d4:	50                   	push   %eax
801033d5:	e8 dc cd ff ff       	call   801001b6 <bread>
801033da:	83 c4 10             	add    $0x10,%esp
801033dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801033e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033e3:	8d 50 18             	lea    0x18(%eax),%edx
801033e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033e9:	83 c0 18             	add    $0x18,%eax
801033ec:	83 ec 04             	sub    $0x4,%esp
801033ef:	68 00 02 00 00       	push   $0x200
801033f4:	52                   	push   %edx
801033f5:	50                   	push   %eax
801033f6:	e8 f3 20 00 00       	call   801054ee <memmove>
801033fb:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
801033fe:	83 ec 0c             	sub    $0xc,%esp
80103401:	ff 75 ec             	pushl  -0x14(%ebp)
80103404:	e8 e6 cd ff ff       	call   801001ef <bwrite>
80103409:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
8010340c:	83 ec 0c             	sub    $0xc,%esp
8010340f:	ff 75 f0             	pushl  -0x10(%ebp)
80103412:	e8 17 ce ff ff       	call   8010022e <brelse>
80103417:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
8010341a:	83 ec 0c             	sub    $0xc,%esp
8010341d:	ff 75 ec             	pushl  -0x14(%ebp)
80103420:	e8 09 ce ff ff       	call   8010022e <brelse>
80103425:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
80103428:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010342c:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103431:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103434:	0f 8c 5d ff ff ff    	jl     80103397 <install_trans+0x12>
  }
}
8010343a:	90                   	nop
8010343b:	c9                   	leave  
8010343c:	c3                   	ret    

8010343d <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
8010343d:	55                   	push   %ebp
8010343e:	89 e5                	mov    %esp,%ebp
80103440:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103443:	a1 94 22 11 80       	mov    0x80112294,%eax
80103448:	89 c2                	mov    %eax,%edx
8010344a:	a1 a4 22 11 80       	mov    0x801122a4,%eax
8010344f:	83 ec 08             	sub    $0x8,%esp
80103452:	52                   	push   %edx
80103453:	50                   	push   %eax
80103454:	e8 5d cd ff ff       	call   801001b6 <bread>
80103459:	83 c4 10             	add    $0x10,%esp
8010345c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
8010345f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103462:	83 c0 18             	add    $0x18,%eax
80103465:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103468:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010346b:	8b 00                	mov    (%eax),%eax
8010346d:	a3 a8 22 11 80       	mov    %eax,0x801122a8
  for (i = 0; i < log.lh.n; i++) {
80103472:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103479:	eb 1b                	jmp    80103496 <read_head+0x59>
    log.lh.block[i] = lh->block[i];
8010347b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010347e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103481:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103485:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103488:	83 c2 10             	add    $0x10,%edx
8010348b:	89 04 95 6c 22 11 80 	mov    %eax,-0x7feedd94(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103492:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103496:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010349b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010349e:	7c db                	jl     8010347b <read_head+0x3e>
  }
  brelse(buf);
801034a0:	83 ec 0c             	sub    $0xc,%esp
801034a3:	ff 75 f0             	pushl  -0x10(%ebp)
801034a6:	e8 83 cd ff ff       	call   8010022e <brelse>
801034ab:	83 c4 10             	add    $0x10,%esp
}
801034ae:	90                   	nop
801034af:	c9                   	leave  
801034b0:	c3                   	ret    

801034b1 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801034b1:	55                   	push   %ebp
801034b2:	89 e5                	mov    %esp,%ebp
801034b4:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801034b7:	a1 94 22 11 80       	mov    0x80112294,%eax
801034bc:	89 c2                	mov    %eax,%edx
801034be:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801034c3:	83 ec 08             	sub    $0x8,%esp
801034c6:	52                   	push   %edx
801034c7:	50                   	push   %eax
801034c8:	e8 e9 cc ff ff       	call   801001b6 <bread>
801034cd:	83 c4 10             	add    $0x10,%esp
801034d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
801034d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801034d6:	83 c0 18             	add    $0x18,%eax
801034d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
801034dc:	8b 15 a8 22 11 80    	mov    0x801122a8,%edx
801034e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034e5:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801034e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034ee:	eb 1b                	jmp    8010350b <write_head+0x5a>
    hb->block[i] = log.lh.block[i];
801034f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034f3:	83 c0 10             	add    $0x10,%eax
801034f6:	8b 0c 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%ecx
801034fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103500:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103503:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103507:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010350b:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103510:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103513:	7c db                	jl     801034f0 <write_head+0x3f>
  }
  bwrite(buf);
80103515:	83 ec 0c             	sub    $0xc,%esp
80103518:	ff 75 f0             	pushl  -0x10(%ebp)
8010351b:	e8 cf cc ff ff       	call   801001ef <bwrite>
80103520:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
80103523:	83 ec 0c             	sub    $0xc,%esp
80103526:	ff 75 f0             	pushl  -0x10(%ebp)
80103529:	e8 00 cd ff ff       	call   8010022e <brelse>
8010352e:	83 c4 10             	add    $0x10,%esp
}
80103531:	90                   	nop
80103532:	c9                   	leave  
80103533:	c3                   	ret    

80103534 <recover_from_log>:

static void
recover_from_log(void)
{
80103534:	55                   	push   %ebp
80103535:	89 e5                	mov    %esp,%ebp
80103537:	83 ec 08             	sub    $0x8,%esp
  read_head();      
8010353a:	e8 fe fe ff ff       	call   8010343d <read_head>
  install_trans(); // if committed, copy from log to disk
8010353f:	e8 41 fe ff ff       	call   80103385 <install_trans>
  log.lh.n = 0;
80103544:	c7 05 a8 22 11 80 00 	movl   $0x0,0x801122a8
8010354b:	00 00 00 
  write_head(); // clear the log
8010354e:	e8 5e ff ff ff       	call   801034b1 <write_head>
}
80103553:	90                   	nop
80103554:	c9                   	leave  
80103555:	c3                   	ret    

80103556 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
80103556:	55                   	push   %ebp
80103557:	89 e5                	mov    %esp,%ebp
80103559:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
8010355c:	83 ec 0c             	sub    $0xc,%esp
8010355f:	68 60 22 11 80       	push   $0x80112260
80103564:	e8 63 1c 00 00       	call   801051cc <acquire>
80103569:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
8010356c:	a1 a0 22 11 80       	mov    0x801122a0,%eax
80103571:	85 c0                	test   %eax,%eax
80103573:	74 17                	je     8010358c <begin_op+0x36>
      sleep(&log, &log.lock);
80103575:	83 ec 08             	sub    $0x8,%esp
80103578:	68 60 22 11 80       	push   $0x80112260
8010357d:	68 60 22 11 80       	push   $0x80112260
80103582:	e8 39 19 00 00       	call   80104ec0 <sleep>
80103587:	83 c4 10             	add    $0x10,%esp
8010358a:	eb e0                	jmp    8010356c <begin_op+0x16>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010358c:	8b 0d a8 22 11 80    	mov    0x801122a8,%ecx
80103592:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103597:	8d 50 01             	lea    0x1(%eax),%edx
8010359a:	89 d0                	mov    %edx,%eax
8010359c:	c1 e0 02             	shl    $0x2,%eax
8010359f:	01 d0                	add    %edx,%eax
801035a1:	01 c0                	add    %eax,%eax
801035a3:	01 c8                	add    %ecx,%eax
801035a5:	83 f8 1e             	cmp    $0x1e,%eax
801035a8:	7e 17                	jle    801035c1 <begin_op+0x6b>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
801035aa:	83 ec 08             	sub    $0x8,%esp
801035ad:	68 60 22 11 80       	push   $0x80112260
801035b2:	68 60 22 11 80       	push   $0x80112260
801035b7:	e8 04 19 00 00       	call   80104ec0 <sleep>
801035bc:	83 c4 10             	add    $0x10,%esp
801035bf:	eb ab                	jmp    8010356c <begin_op+0x16>
    } else {
      log.outstanding += 1;
801035c1:	a1 9c 22 11 80       	mov    0x8011229c,%eax
801035c6:	83 c0 01             	add    $0x1,%eax
801035c9:	a3 9c 22 11 80       	mov    %eax,0x8011229c
      release(&log.lock);
801035ce:	83 ec 0c             	sub    $0xc,%esp
801035d1:	68 60 22 11 80       	push   $0x80112260
801035d6:	e8 58 1c 00 00       	call   80105233 <release>
801035db:	83 c4 10             	add    $0x10,%esp
      break;
801035de:	90                   	nop
    }
  }
}
801035df:	90                   	nop
801035e0:	c9                   	leave  
801035e1:	c3                   	ret    

801035e2 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801035e2:	55                   	push   %ebp
801035e3:	89 e5                	mov    %esp,%ebp
801035e5:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;
801035e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
801035ef:	83 ec 0c             	sub    $0xc,%esp
801035f2:	68 60 22 11 80       	push   $0x80112260
801035f7:	e8 d0 1b 00 00       	call   801051cc <acquire>
801035fc:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801035ff:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103604:	83 e8 01             	sub    $0x1,%eax
80103607:	a3 9c 22 11 80       	mov    %eax,0x8011229c
  if(log.committing)
8010360c:	a1 a0 22 11 80       	mov    0x801122a0,%eax
80103611:	85 c0                	test   %eax,%eax
80103613:	74 0d                	je     80103622 <end_op+0x40>
    panic("log.committing");
80103615:	83 ec 0c             	sub    $0xc,%esp
80103618:	68 94 89 10 80       	push   $0x80108994
8010361d:	e8 45 cf ff ff       	call   80100567 <panic>
  if(log.outstanding == 0){
80103622:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103627:	85 c0                	test   %eax,%eax
80103629:	75 13                	jne    8010363e <end_op+0x5c>
    do_commit = 1;
8010362b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
80103632:	c7 05 a0 22 11 80 01 	movl   $0x1,0x801122a0
80103639:	00 00 00 
8010363c:	eb 10                	jmp    8010364e <end_op+0x6c>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
8010363e:	83 ec 0c             	sub    $0xc,%esp
80103641:	68 60 22 11 80       	push   $0x80112260
80103646:	e8 63 19 00 00       	call   80104fae <wakeup>
8010364b:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
8010364e:	83 ec 0c             	sub    $0xc,%esp
80103651:	68 60 22 11 80       	push   $0x80112260
80103656:	e8 d8 1b 00 00       	call   80105233 <release>
8010365b:	83 c4 10             	add    $0x10,%esp

  if(do_commit){
8010365e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103662:	74 3f                	je     801036a3 <end_op+0xc1>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
80103664:	e8 f5 00 00 00       	call   8010375e <commit>
    acquire(&log.lock);
80103669:	83 ec 0c             	sub    $0xc,%esp
8010366c:	68 60 22 11 80       	push   $0x80112260
80103671:	e8 56 1b 00 00       	call   801051cc <acquire>
80103676:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
80103679:	c7 05 a0 22 11 80 00 	movl   $0x0,0x801122a0
80103680:	00 00 00 
    wakeup(&log);
80103683:	83 ec 0c             	sub    $0xc,%esp
80103686:	68 60 22 11 80       	push   $0x80112260
8010368b:	e8 1e 19 00 00       	call   80104fae <wakeup>
80103690:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
80103693:	83 ec 0c             	sub    $0xc,%esp
80103696:	68 60 22 11 80       	push   $0x80112260
8010369b:	e8 93 1b 00 00       	call   80105233 <release>
801036a0:	83 c4 10             	add    $0x10,%esp
  }
}
801036a3:	90                   	nop
801036a4:	c9                   	leave  
801036a5:	c3                   	ret    

801036a6 <write_log>:

// Copy modified blocks from cache to log.
static void 
write_log(void)
{
801036a6:	55                   	push   %ebp
801036a7:	89 e5                	mov    %esp,%ebp
801036a9:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801036ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801036b3:	e9 95 00 00 00       	jmp    8010374d <write_log+0xa7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801036b8:	8b 15 94 22 11 80    	mov    0x80112294,%edx
801036be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036c1:	01 d0                	add    %edx,%eax
801036c3:	83 c0 01             	add    $0x1,%eax
801036c6:	89 c2                	mov    %eax,%edx
801036c8:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801036cd:	83 ec 08             	sub    $0x8,%esp
801036d0:	52                   	push   %edx
801036d1:	50                   	push   %eax
801036d2:	e8 df ca ff ff       	call   801001b6 <bread>
801036d7:	83 c4 10             	add    $0x10,%esp
801036da:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801036dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036e0:	83 c0 10             	add    $0x10,%eax
801036e3:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
801036ea:	89 c2                	mov    %eax,%edx
801036ec:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801036f1:	83 ec 08             	sub    $0x8,%esp
801036f4:	52                   	push   %edx
801036f5:	50                   	push   %eax
801036f6:	e8 bb ca ff ff       	call   801001b6 <bread>
801036fb:	83 c4 10             	add    $0x10,%esp
801036fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
80103701:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103704:	8d 50 18             	lea    0x18(%eax),%edx
80103707:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010370a:	83 c0 18             	add    $0x18,%eax
8010370d:	83 ec 04             	sub    $0x4,%esp
80103710:	68 00 02 00 00       	push   $0x200
80103715:	52                   	push   %edx
80103716:	50                   	push   %eax
80103717:	e8 d2 1d 00 00       	call   801054ee <memmove>
8010371c:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
8010371f:	83 ec 0c             	sub    $0xc,%esp
80103722:	ff 75 f0             	pushl  -0x10(%ebp)
80103725:	e8 c5 ca ff ff       	call   801001ef <bwrite>
8010372a:	83 c4 10             	add    $0x10,%esp
    brelse(from); 
8010372d:	83 ec 0c             	sub    $0xc,%esp
80103730:	ff 75 ec             	pushl  -0x14(%ebp)
80103733:	e8 f6 ca ff ff       	call   8010022e <brelse>
80103738:	83 c4 10             	add    $0x10,%esp
    brelse(to);
8010373b:	83 ec 0c             	sub    $0xc,%esp
8010373e:	ff 75 f0             	pushl  -0x10(%ebp)
80103741:	e8 e8 ca ff ff       	call   8010022e <brelse>
80103746:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
80103749:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010374d:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103752:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103755:	0f 8c 5d ff ff ff    	jl     801036b8 <write_log+0x12>
  }
}
8010375b:	90                   	nop
8010375c:	c9                   	leave  
8010375d:	c3                   	ret    

8010375e <commit>:

static void
commit()
{
8010375e:	55                   	push   %ebp
8010375f:	89 e5                	mov    %esp,%ebp
80103761:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
80103764:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103769:	85 c0                	test   %eax,%eax
8010376b:	7e 1e                	jle    8010378b <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
8010376d:	e8 34 ff ff ff       	call   801036a6 <write_log>
    write_head();    // Write header to disk -- the real commit
80103772:	e8 3a fd ff ff       	call   801034b1 <write_head>
    install_trans(); // Now install writes to home locations
80103777:	e8 09 fc ff ff       	call   80103385 <install_trans>
    log.lh.n = 0; 
8010377c:	c7 05 a8 22 11 80 00 	movl   $0x0,0x801122a8
80103783:	00 00 00 
    write_head();    // Erase the transaction from the log
80103786:	e8 26 fd ff ff       	call   801034b1 <write_head>
  }
}
8010378b:	90                   	nop
8010378c:	c9                   	leave  
8010378d:	c3                   	ret    

8010378e <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
8010378e:	55                   	push   %ebp
8010378f:	89 e5                	mov    %esp,%ebp
80103791:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103794:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103799:	83 f8 1d             	cmp    $0x1d,%eax
8010379c:	7f 12                	jg     801037b0 <log_write+0x22>
8010379e:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801037a3:	8b 15 98 22 11 80    	mov    0x80112298,%edx
801037a9:	83 ea 01             	sub    $0x1,%edx
801037ac:	39 d0                	cmp    %edx,%eax
801037ae:	7c 0d                	jl     801037bd <log_write+0x2f>
    panic("too big a transaction");
801037b0:	83 ec 0c             	sub    $0xc,%esp
801037b3:	68 a3 89 10 80       	push   $0x801089a3
801037b8:	e8 aa cd ff ff       	call   80100567 <panic>
  if (log.outstanding < 1)
801037bd:	a1 9c 22 11 80       	mov    0x8011229c,%eax
801037c2:	85 c0                	test   %eax,%eax
801037c4:	7f 0d                	jg     801037d3 <log_write+0x45>
    panic("log_write outside of trans");
801037c6:	83 ec 0c             	sub    $0xc,%esp
801037c9:	68 b9 89 10 80       	push   $0x801089b9
801037ce:	e8 94 cd ff ff       	call   80100567 <panic>

  acquire(&log.lock);
801037d3:	83 ec 0c             	sub    $0xc,%esp
801037d6:	68 60 22 11 80       	push   $0x80112260
801037db:	e8 ec 19 00 00       	call   801051cc <acquire>
801037e0:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
801037e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801037ea:	eb 1d                	jmp    80103809 <log_write+0x7b>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801037ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037ef:	83 c0 10             	add    $0x10,%eax
801037f2:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
801037f9:	89 c2                	mov    %eax,%edx
801037fb:	8b 45 08             	mov    0x8(%ebp),%eax
801037fe:	8b 40 08             	mov    0x8(%eax),%eax
80103801:	39 c2                	cmp    %eax,%edx
80103803:	74 10                	je     80103815 <log_write+0x87>
  for (i = 0; i < log.lh.n; i++) {
80103805:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103809:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010380e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103811:	7c d9                	jl     801037ec <log_write+0x5e>
80103813:	eb 01                	jmp    80103816 <log_write+0x88>
      break;
80103815:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
80103816:	8b 45 08             	mov    0x8(%ebp),%eax
80103819:	8b 40 08             	mov    0x8(%eax),%eax
8010381c:	89 c2                	mov    %eax,%edx
8010381e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103821:	83 c0 10             	add    $0x10,%eax
80103824:	89 14 85 6c 22 11 80 	mov    %edx,-0x7feedd94(,%eax,4)
  if (i == log.lh.n)
8010382b:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103830:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103833:	75 0d                	jne    80103842 <log_write+0xb4>
    log.lh.n++;
80103835:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010383a:	83 c0 01             	add    $0x1,%eax
8010383d:	a3 a8 22 11 80       	mov    %eax,0x801122a8
  b->flags |= B_DIRTY; // prevent eviction
80103842:	8b 45 08             	mov    0x8(%ebp),%eax
80103845:	8b 00                	mov    (%eax),%eax
80103847:	83 c8 04             	or     $0x4,%eax
8010384a:	89 c2                	mov    %eax,%edx
8010384c:	8b 45 08             	mov    0x8(%ebp),%eax
8010384f:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
80103851:	83 ec 0c             	sub    $0xc,%esp
80103854:	68 60 22 11 80       	push   $0x80112260
80103859:	e8 d5 19 00 00       	call   80105233 <release>
8010385e:	83 c4 10             	add    $0x10,%esp
}
80103861:	90                   	nop
80103862:	c9                   	leave  
80103863:	c3                   	ret    

80103864 <v2p>:
80103864:	55                   	push   %ebp
80103865:	89 e5                	mov    %esp,%ebp
80103867:	8b 45 08             	mov    0x8(%ebp),%eax
8010386a:	05 00 00 00 80       	add    $0x80000000,%eax
8010386f:	5d                   	pop    %ebp
80103870:	c3                   	ret    

80103871 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80103871:	55                   	push   %ebp
80103872:	89 e5                	mov    %esp,%ebp
80103874:	8b 45 08             	mov    0x8(%ebp),%eax
80103877:	05 00 00 00 80       	add    $0x80000000,%eax
8010387c:	5d                   	pop    %ebp
8010387d:	c3                   	ret    

8010387e <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
8010387e:	55                   	push   %ebp
8010387f:	89 e5                	mov    %esp,%ebp
80103881:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103884:	8b 55 08             	mov    0x8(%ebp),%edx
80103887:	8b 45 0c             	mov    0xc(%ebp),%eax
8010388a:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010388d:	f0 87 02             	lock xchg %eax,(%edx)
80103890:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103893:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103896:	c9                   	leave  
80103897:	c3                   	ret    

80103898 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103898:	8d 4c 24 04          	lea    0x4(%esp),%ecx
8010389c:	83 e4 f0             	and    $0xfffffff0,%esp
8010389f:	ff 71 fc             	pushl  -0x4(%ecx)
801038a2:	55                   	push   %ebp
801038a3:	89 e5                	mov    %esp,%ebp
801038a5:	51                   	push   %ecx
801038a6:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801038a9:	83 ec 08             	sub    $0x8,%esp
801038ac:	68 00 00 40 80       	push   $0x80400000
801038b1:	68 3c 53 11 80       	push   $0x8011533c
801038b6:	e8 78 f2 ff ff       	call   80102b33 <kinit1>
801038bb:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
801038be:	e8 dd 46 00 00       	call   80107fa0 <kvmalloc>
  mpinit();        // collect info about this machine
801038c3:	e8 3d 04 00 00       	call   80103d05 <mpinit>
  lapicinit();
801038c8:	e8 e7 f5 ff ff       	call   80102eb4 <lapicinit>
  seginit();       // set up segments
801038cd:	e8 77 40 00 00       	call   80107949 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
801038d2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801038d8:	0f b6 00             	movzbl (%eax),%eax
801038db:	0f b6 c0             	movzbl %al,%eax
801038de:	83 ec 08             	sub    $0x8,%esp
801038e1:	50                   	push   %eax
801038e2:	68 d4 89 10 80       	push   $0x801089d4
801038e7:	e8 d8 ca ff ff       	call   801003c4 <cprintf>
801038ec:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
801038ef:	e8 69 06 00 00       	call   80103f5d <picinit>
  ioapicinit();    // another interrupt controller
801038f4:	e8 2f f1 ff ff       	call   80102a28 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
801038f9:	e8 26 d2 ff ff       	call   80100b24 <consoleinit>
  uartinit();      // serial port
801038fe:	e8 a2 33 00 00       	call   80106ca5 <uartinit>
  pinit();         // process table
80103903:	e8 55 0b 00 00       	call   8010445d <pinit>
  tvinit();        // trap vectors
80103908:	e8 60 2f 00 00       	call   8010686d <tvinit>
  binit();         // buffer cache
8010390d:	e8 22 c7 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103912:	e8 69 d6 ff ff       	call   80100f80 <fileinit>
  ideinit();       // disk
80103917:	e8 14 ed ff ff       	call   80102630 <ideinit>
  if(!ismp)
8010391c:	a1 44 23 11 80       	mov    0x80112344,%eax
80103921:	85 c0                	test   %eax,%eax
80103923:	75 05                	jne    8010392a <main+0x92>
    timerinit();   // uniprocessor timer
80103925:	e8 a0 2e 00 00       	call   801067ca <timerinit>
  startothers();   // start other processors
8010392a:	e8 7f 00 00 00       	call   801039ae <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
8010392f:	83 ec 08             	sub    $0x8,%esp
80103932:	68 00 00 00 8e       	push   $0x8e000000
80103937:	68 00 00 40 80       	push   $0x80400000
8010393c:	e8 2b f2 ff ff       	call   80102b6c <kinit2>
80103941:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
80103944:	e8 e1 0c 00 00       	call   8010462a <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
80103949:	e8 1a 00 00 00       	call   80103968 <mpmain>

8010394e <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
8010394e:	55                   	push   %ebp
8010394f:	89 e5                	mov    %esp,%ebp
80103951:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
80103954:	e8 5f 46 00 00       	call   80107fb8 <switchkvm>
  seginit();
80103959:	e8 eb 3f 00 00       	call   80107949 <seginit>
  lapicinit();
8010395e:	e8 51 f5 ff ff       	call   80102eb4 <lapicinit>
  mpmain();
80103963:	e8 00 00 00 00       	call   80103968 <mpmain>

80103968 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103968:	55                   	push   %ebp
80103969:	89 e5                	mov    %esp,%ebp
8010396b:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
8010396e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103974:	0f b6 00             	movzbl (%eax),%eax
80103977:	0f b6 c0             	movzbl %al,%eax
8010397a:	83 ec 08             	sub    $0x8,%esp
8010397d:	50                   	push   %eax
8010397e:	68 eb 89 10 80       	push   $0x801089eb
80103983:	e8 3c ca ff ff       	call   801003c4 <cprintf>
80103988:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
8010398b:	e8 53 30 00 00       	call   801069e3 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103990:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103996:	05 a8 00 00 00       	add    $0xa8,%eax
8010399b:	83 ec 08             	sub    $0x8,%esp
8010399e:	6a 01                	push   $0x1
801039a0:	50                   	push   %eax
801039a1:	e8 d8 fe ff ff       	call   8010387e <xchg>
801039a6:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
801039a9:	e8 ef 12 00 00       	call   80104c9d <scheduler>

801039ae <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
801039ae:	55                   	push   %ebp
801039af:	89 e5                	mov    %esp,%ebp
801039b1:	83 ec 18             	sub    $0x18,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
801039b4:	68 00 70 00 00       	push   $0x7000
801039b9:	e8 b3 fe ff ff       	call   80103871 <p2v>
801039be:	83 c4 04             	add    $0x4,%esp
801039c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801039c4:	b8 8a 00 00 00       	mov    $0x8a,%eax
801039c9:	83 ec 04             	sub    $0x4,%esp
801039cc:	50                   	push   %eax
801039cd:	68 0c b5 10 80       	push   $0x8010b50c
801039d2:	ff 75 f0             	pushl  -0x10(%ebp)
801039d5:	e8 14 1b 00 00       	call   801054ee <memmove>
801039da:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
801039dd:	c7 45 f4 60 23 11 80 	movl   $0x80112360,-0xc(%ebp)
801039e4:	e9 92 00 00 00       	jmp    80103a7b <startothers+0xcd>
    if(c == cpus+cpunum())  // We've started already.
801039e9:	e8 e5 f5 ff ff       	call   80102fd3 <cpunum>
801039ee:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801039f4:	05 60 23 11 80       	add    $0x80112360,%eax
801039f9:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801039fc:	74 75                	je     80103a73 <startothers+0xc5>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801039fe:	e8 67 f2 ff ff       	call   80102c6a <kalloc>
80103a03:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103a06:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a09:	83 e8 04             	sub    $0x4,%eax
80103a0c:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103a0f:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103a15:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103a17:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a1a:	83 e8 08             	sub    $0x8,%eax
80103a1d:	c7 00 4e 39 10 80    	movl   $0x8010394e,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103a23:	83 ec 0c             	sub    $0xc,%esp
80103a26:	68 00 a0 10 80       	push   $0x8010a000
80103a2b:	e8 34 fe ff ff       	call   80103864 <v2p>
80103a30:	83 c4 10             	add    $0x10,%esp
80103a33:	89 c2                	mov    %eax,%edx
80103a35:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a38:	83 e8 0c             	sub    $0xc,%eax
80103a3b:	89 10                	mov    %edx,(%eax)

    lapicstartap(c->id, v2p(code));
80103a3d:	83 ec 0c             	sub    $0xc,%esp
80103a40:	ff 75 f0             	pushl  -0x10(%ebp)
80103a43:	e8 1c fe ff ff       	call   80103864 <v2p>
80103a48:	83 c4 10             	add    $0x10,%esp
80103a4b:	89 c2                	mov    %eax,%edx
80103a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a50:	0f b6 00             	movzbl (%eax),%eax
80103a53:	0f b6 c0             	movzbl %al,%eax
80103a56:	83 ec 08             	sub    $0x8,%esp
80103a59:	52                   	push   %edx
80103a5a:	50                   	push   %eax
80103a5b:	e8 ed f5 ff ff       	call   8010304d <lapicstartap>
80103a60:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103a63:	90                   	nop
80103a64:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a67:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103a6d:	85 c0                	test   %eax,%eax
80103a6f:	74 f3                	je     80103a64 <startothers+0xb6>
80103a71:	eb 01                	jmp    80103a74 <startothers+0xc6>
      continue;
80103a73:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
80103a74:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103a7b:	a1 40 29 11 80       	mov    0x80112940,%eax
80103a80:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103a86:	05 60 23 11 80       	add    $0x80112360,%eax
80103a8b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103a8e:	0f 82 55 ff ff ff    	jb     801039e9 <startothers+0x3b>
      ;
  }
}
80103a94:	90                   	nop
80103a95:	c9                   	leave  
80103a96:	c3                   	ret    

80103a97 <p2v>:
80103a97:	55                   	push   %ebp
80103a98:	89 e5                	mov    %esp,%ebp
80103a9a:	8b 45 08             	mov    0x8(%ebp),%eax
80103a9d:	05 00 00 00 80       	add    $0x80000000,%eax
80103aa2:	5d                   	pop    %ebp
80103aa3:	c3                   	ret    

80103aa4 <inb>:
{
80103aa4:	55                   	push   %ebp
80103aa5:	89 e5                	mov    %esp,%ebp
80103aa7:	83 ec 14             	sub    $0x14,%esp
80103aaa:	8b 45 08             	mov    0x8(%ebp),%eax
80103aad:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103ab1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103ab5:	89 c2                	mov    %eax,%edx
80103ab7:	ec                   	in     (%dx),%al
80103ab8:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103abb:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103abf:	c9                   	leave  
80103ac0:	c3                   	ret    

80103ac1 <outb>:
{
80103ac1:	55                   	push   %ebp
80103ac2:	89 e5                	mov    %esp,%ebp
80103ac4:	83 ec 08             	sub    $0x8,%esp
80103ac7:	8b 45 08             	mov    0x8(%ebp),%eax
80103aca:	8b 55 0c             	mov    0xc(%ebp),%edx
80103acd:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103ad1:	89 d0                	mov    %edx,%eax
80103ad3:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ad6:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103ada:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103ade:	ee                   	out    %al,(%dx)
}
80103adf:	90                   	nop
80103ae0:	c9                   	leave  
80103ae1:	c3                   	ret    

80103ae2 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103ae2:	55                   	push   %ebp
80103ae3:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103ae5:	a1 44 b6 10 80       	mov    0x8010b644,%eax
80103aea:	2d 60 23 11 80       	sub    $0x80112360,%eax
80103aef:	c1 f8 02             	sar    $0x2,%eax
80103af2:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103af8:	5d                   	pop    %ebp
80103af9:	c3                   	ret    

80103afa <sum>:

static uchar
sum(uchar *addr, int len)
{
80103afa:	55                   	push   %ebp
80103afb:	89 e5                	mov    %esp,%ebp
80103afd:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103b00:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103b07:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103b0e:	eb 15                	jmp    80103b25 <sum+0x2b>
    sum += addr[i];
80103b10:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103b13:	8b 45 08             	mov    0x8(%ebp),%eax
80103b16:	01 d0                	add    %edx,%eax
80103b18:	0f b6 00             	movzbl (%eax),%eax
80103b1b:	0f b6 c0             	movzbl %al,%eax
80103b1e:	01 45 f8             	add    %eax,-0x8(%ebp)
  for(i=0; i<len; i++)
80103b21:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103b25:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103b28:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103b2b:	7c e3                	jl     80103b10 <sum+0x16>
  return sum;
80103b2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103b30:	c9                   	leave  
80103b31:	c3                   	ret    

80103b32 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103b32:	55                   	push   %ebp
80103b33:	89 e5                	mov    %esp,%ebp
80103b35:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103b38:	ff 75 08             	pushl  0x8(%ebp)
80103b3b:	e8 57 ff ff ff       	call   80103a97 <p2v>
80103b40:	83 c4 04             	add    $0x4,%esp
80103b43:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103b46:	8b 55 0c             	mov    0xc(%ebp),%edx
80103b49:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b4c:	01 d0                	add    %edx,%eax
80103b4e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103b51:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b54:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103b57:	eb 36                	jmp    80103b8f <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103b59:	83 ec 04             	sub    $0x4,%esp
80103b5c:	6a 04                	push   $0x4
80103b5e:	68 fc 89 10 80       	push   $0x801089fc
80103b63:	ff 75 f4             	pushl  -0xc(%ebp)
80103b66:	e8 2b 19 00 00       	call   80105496 <memcmp>
80103b6b:	83 c4 10             	add    $0x10,%esp
80103b6e:	85 c0                	test   %eax,%eax
80103b70:	75 19                	jne    80103b8b <mpsearch1+0x59>
80103b72:	83 ec 08             	sub    $0x8,%esp
80103b75:	6a 10                	push   $0x10
80103b77:	ff 75 f4             	pushl  -0xc(%ebp)
80103b7a:	e8 7b ff ff ff       	call   80103afa <sum>
80103b7f:	83 c4 10             	add    $0x10,%esp
80103b82:	84 c0                	test   %al,%al
80103b84:	75 05                	jne    80103b8b <mpsearch1+0x59>
      return (struct mp*)p;
80103b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b89:	eb 11                	jmp    80103b9c <mpsearch1+0x6a>
  for(p = addr; p < e; p += sizeof(struct mp))
80103b8b:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103b8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b92:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103b95:	72 c2                	jb     80103b59 <mpsearch1+0x27>
  return 0;
80103b97:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103b9c:	c9                   	leave  
80103b9d:	c3                   	ret    

80103b9e <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103b9e:	55                   	push   %ebp
80103b9f:	89 e5                	mov    %esp,%ebp
80103ba1:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103ba4:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103bab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bae:	83 c0 0f             	add    $0xf,%eax
80103bb1:	0f b6 00             	movzbl (%eax),%eax
80103bb4:	0f b6 c0             	movzbl %al,%eax
80103bb7:	c1 e0 08             	shl    $0x8,%eax
80103bba:	89 c2                	mov    %eax,%edx
80103bbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bbf:	83 c0 0e             	add    $0xe,%eax
80103bc2:	0f b6 00             	movzbl (%eax),%eax
80103bc5:	0f b6 c0             	movzbl %al,%eax
80103bc8:	09 d0                	or     %edx,%eax
80103bca:	c1 e0 04             	shl    $0x4,%eax
80103bcd:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103bd0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103bd4:	74 21                	je     80103bf7 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103bd6:	83 ec 08             	sub    $0x8,%esp
80103bd9:	68 00 04 00 00       	push   $0x400
80103bde:	ff 75 f0             	pushl  -0x10(%ebp)
80103be1:	e8 4c ff ff ff       	call   80103b32 <mpsearch1>
80103be6:	83 c4 10             	add    $0x10,%esp
80103be9:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103bec:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103bf0:	74 51                	je     80103c43 <mpsearch+0xa5>
      return mp;
80103bf2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103bf5:	eb 61                	jmp    80103c58 <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103bf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bfa:	83 c0 14             	add    $0x14,%eax
80103bfd:	0f b6 00             	movzbl (%eax),%eax
80103c00:	0f b6 c0             	movzbl %al,%eax
80103c03:	c1 e0 08             	shl    $0x8,%eax
80103c06:	89 c2                	mov    %eax,%edx
80103c08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c0b:	83 c0 13             	add    $0x13,%eax
80103c0e:	0f b6 00             	movzbl (%eax),%eax
80103c11:	0f b6 c0             	movzbl %al,%eax
80103c14:	09 d0                	or     %edx,%eax
80103c16:	c1 e0 0a             	shl    $0xa,%eax
80103c19:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103c1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c1f:	2d 00 04 00 00       	sub    $0x400,%eax
80103c24:	83 ec 08             	sub    $0x8,%esp
80103c27:	68 00 04 00 00       	push   $0x400
80103c2c:	50                   	push   %eax
80103c2d:	e8 00 ff ff ff       	call   80103b32 <mpsearch1>
80103c32:	83 c4 10             	add    $0x10,%esp
80103c35:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c38:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103c3c:	74 05                	je     80103c43 <mpsearch+0xa5>
      return mp;
80103c3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c41:	eb 15                	jmp    80103c58 <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103c43:	83 ec 08             	sub    $0x8,%esp
80103c46:	68 00 00 01 00       	push   $0x10000
80103c4b:	68 00 00 0f 00       	push   $0xf0000
80103c50:	e8 dd fe ff ff       	call   80103b32 <mpsearch1>
80103c55:	83 c4 10             	add    $0x10,%esp
}
80103c58:	c9                   	leave  
80103c59:	c3                   	ret    

80103c5a <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103c5a:	55                   	push   %ebp
80103c5b:	89 e5                	mov    %esp,%ebp
80103c5d:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103c60:	e8 39 ff ff ff       	call   80103b9e <mpsearch>
80103c65:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c68:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c6c:	74 0a                	je     80103c78 <mpconfig+0x1e>
80103c6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c71:	8b 40 04             	mov    0x4(%eax),%eax
80103c74:	85 c0                	test   %eax,%eax
80103c76:	75 0a                	jne    80103c82 <mpconfig+0x28>
    return 0;
80103c78:	b8 00 00 00 00       	mov    $0x0,%eax
80103c7d:	e9 81 00 00 00       	jmp    80103d03 <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103c82:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c85:	8b 40 04             	mov    0x4(%eax),%eax
80103c88:	83 ec 0c             	sub    $0xc,%esp
80103c8b:	50                   	push   %eax
80103c8c:	e8 06 fe ff ff       	call   80103a97 <p2v>
80103c91:	83 c4 10             	add    $0x10,%esp
80103c94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103c97:	83 ec 04             	sub    $0x4,%esp
80103c9a:	6a 04                	push   $0x4
80103c9c:	68 01 8a 10 80       	push   $0x80108a01
80103ca1:	ff 75 f0             	pushl  -0x10(%ebp)
80103ca4:	e8 ed 17 00 00       	call   80105496 <memcmp>
80103ca9:	83 c4 10             	add    $0x10,%esp
80103cac:	85 c0                	test   %eax,%eax
80103cae:	74 07                	je     80103cb7 <mpconfig+0x5d>
    return 0;
80103cb0:	b8 00 00 00 00       	mov    $0x0,%eax
80103cb5:	eb 4c                	jmp    80103d03 <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
80103cb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cba:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103cbe:	3c 01                	cmp    $0x1,%al
80103cc0:	74 12                	je     80103cd4 <mpconfig+0x7a>
80103cc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cc5:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103cc9:	3c 04                	cmp    $0x4,%al
80103ccb:	74 07                	je     80103cd4 <mpconfig+0x7a>
    return 0;
80103ccd:	b8 00 00 00 00       	mov    $0x0,%eax
80103cd2:	eb 2f                	jmp    80103d03 <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
80103cd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cd7:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103cdb:	0f b7 c0             	movzwl %ax,%eax
80103cde:	83 ec 08             	sub    $0x8,%esp
80103ce1:	50                   	push   %eax
80103ce2:	ff 75 f0             	pushl  -0x10(%ebp)
80103ce5:	e8 10 fe ff ff       	call   80103afa <sum>
80103cea:	83 c4 10             	add    $0x10,%esp
80103ced:	84 c0                	test   %al,%al
80103cef:	74 07                	je     80103cf8 <mpconfig+0x9e>
    return 0;
80103cf1:	b8 00 00 00 00       	mov    $0x0,%eax
80103cf6:	eb 0b                	jmp    80103d03 <mpconfig+0xa9>
  *pmp = mp;
80103cf8:	8b 45 08             	mov    0x8(%ebp),%eax
80103cfb:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103cfe:	89 10                	mov    %edx,(%eax)
  return conf;
80103d00:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103d03:	c9                   	leave  
80103d04:	c3                   	ret    

80103d05 <mpinit>:

void
mpinit(void)
{
80103d05:	55                   	push   %ebp
80103d06:	89 e5                	mov    %esp,%ebp
80103d08:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103d0b:	c7 05 44 b6 10 80 60 	movl   $0x80112360,0x8010b644
80103d12:	23 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103d15:	83 ec 0c             	sub    $0xc,%esp
80103d18:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103d1b:	50                   	push   %eax
80103d1c:	e8 39 ff ff ff       	call   80103c5a <mpconfig>
80103d21:	83 c4 10             	add    $0x10,%esp
80103d24:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103d27:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103d2b:	0f 84 96 01 00 00    	je     80103ec7 <mpinit+0x1c2>
    return;
  ismp = 1;
80103d31:	c7 05 44 23 11 80 01 	movl   $0x1,0x80112344
80103d38:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103d3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d3e:	8b 40 24             	mov    0x24(%eax),%eax
80103d41:	a3 5c 22 11 80       	mov    %eax,0x8011225c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d46:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d49:	83 c0 2c             	add    $0x2c,%eax
80103d4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103d4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d52:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103d56:	0f b7 d0             	movzwl %ax,%edx
80103d59:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d5c:	01 d0                	add    %edx,%eax
80103d5e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103d61:	e9 f2 00 00 00       	jmp    80103e58 <mpinit+0x153>
    switch(*p){
80103d66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d69:	0f b6 00             	movzbl (%eax),%eax
80103d6c:	0f b6 c0             	movzbl %al,%eax
80103d6f:	83 f8 04             	cmp    $0x4,%eax
80103d72:	0f 87 bc 00 00 00    	ja     80103e34 <mpinit+0x12f>
80103d78:	8b 04 85 44 8a 10 80 	mov    -0x7fef75bc(,%eax,4),%eax
80103d7f:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103d81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d84:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103d87:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d8a:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d8e:	0f b6 d0             	movzbl %al,%edx
80103d91:	a1 40 29 11 80       	mov    0x80112940,%eax
80103d96:	39 c2                	cmp    %eax,%edx
80103d98:	74 2b                	je     80103dc5 <mpinit+0xc0>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103d9a:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d9d:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103da1:	0f b6 d0             	movzbl %al,%edx
80103da4:	a1 40 29 11 80       	mov    0x80112940,%eax
80103da9:	83 ec 04             	sub    $0x4,%esp
80103dac:	52                   	push   %edx
80103dad:	50                   	push   %eax
80103dae:	68 06 8a 10 80       	push   $0x80108a06
80103db3:	e8 0c c6 ff ff       	call   801003c4 <cprintf>
80103db8:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103dbb:	c7 05 44 23 11 80 00 	movl   $0x0,0x80112344
80103dc2:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103dc5:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103dc8:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103dcc:	0f b6 c0             	movzbl %al,%eax
80103dcf:	83 e0 02             	and    $0x2,%eax
80103dd2:	85 c0                	test   %eax,%eax
80103dd4:	74 15                	je     80103deb <mpinit+0xe6>
        bcpu = &cpus[ncpu];
80103dd6:	a1 40 29 11 80       	mov    0x80112940,%eax
80103ddb:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103de1:	05 60 23 11 80       	add    $0x80112360,%eax
80103de6:	a3 44 b6 10 80       	mov    %eax,0x8010b644
      cpus[ncpu].id = ncpu;
80103deb:	8b 15 40 29 11 80    	mov    0x80112940,%edx
80103df1:	a1 40 29 11 80       	mov    0x80112940,%eax
80103df6:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103dfc:	05 60 23 11 80       	add    $0x80112360,%eax
80103e01:	88 10                	mov    %dl,(%eax)
      ncpu++;
80103e03:	a1 40 29 11 80       	mov    0x80112940,%eax
80103e08:	83 c0 01             	add    $0x1,%eax
80103e0b:	a3 40 29 11 80       	mov    %eax,0x80112940
      p += sizeof(struct mpproc);
80103e10:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103e14:	eb 42                	jmp    80103e58 <mpinit+0x153>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103e16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103e1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103e1f:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103e23:	a2 40 23 11 80       	mov    %al,0x80112340
      p += sizeof(struct mpioapic);
80103e28:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103e2c:	eb 2a                	jmp    80103e58 <mpinit+0x153>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103e2e:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103e32:	eb 24                	jmp    80103e58 <mpinit+0x153>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103e34:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e37:	0f b6 00             	movzbl (%eax),%eax
80103e3a:	0f b6 c0             	movzbl %al,%eax
80103e3d:	83 ec 08             	sub    $0x8,%esp
80103e40:	50                   	push   %eax
80103e41:	68 24 8a 10 80       	push   $0x80108a24
80103e46:	e8 79 c5 ff ff       	call   801003c4 <cprintf>
80103e4b:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103e4e:	c7 05 44 23 11 80 00 	movl   $0x0,0x80112344
80103e55:	00 00 00 
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e5b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103e5e:	0f 82 02 ff ff ff    	jb     80103d66 <mpinit+0x61>
    }
  }
  if(!ismp){
80103e64:	a1 44 23 11 80       	mov    0x80112344,%eax
80103e69:	85 c0                	test   %eax,%eax
80103e6b:	75 1d                	jne    80103e8a <mpinit+0x185>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103e6d:	c7 05 40 29 11 80 01 	movl   $0x1,0x80112940
80103e74:	00 00 00 
    lapic = 0;
80103e77:	c7 05 5c 22 11 80 00 	movl   $0x0,0x8011225c
80103e7e:	00 00 00 
    ioapicid = 0;
80103e81:	c6 05 40 23 11 80 00 	movb   $0x0,0x80112340
    return;
80103e88:	eb 3e                	jmp    80103ec8 <mpinit+0x1c3>
  }

  if(mp->imcrp){
80103e8a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103e8d:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103e91:	84 c0                	test   %al,%al
80103e93:	74 33                	je     80103ec8 <mpinit+0x1c3>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103e95:	83 ec 08             	sub    $0x8,%esp
80103e98:	6a 70                	push   $0x70
80103e9a:	6a 22                	push   $0x22
80103e9c:	e8 20 fc ff ff       	call   80103ac1 <outb>
80103ea1:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103ea4:	83 ec 0c             	sub    $0xc,%esp
80103ea7:	6a 23                	push   $0x23
80103ea9:	e8 f6 fb ff ff       	call   80103aa4 <inb>
80103eae:	83 c4 10             	add    $0x10,%esp
80103eb1:	83 c8 01             	or     $0x1,%eax
80103eb4:	0f b6 c0             	movzbl %al,%eax
80103eb7:	83 ec 08             	sub    $0x8,%esp
80103eba:	50                   	push   %eax
80103ebb:	6a 23                	push   $0x23
80103ebd:	e8 ff fb ff ff       	call   80103ac1 <outb>
80103ec2:	83 c4 10             	add    $0x10,%esp
80103ec5:	eb 01                	jmp    80103ec8 <mpinit+0x1c3>
    return;
80103ec7:	90                   	nop
  }
}
80103ec8:	c9                   	leave  
80103ec9:	c3                   	ret    

80103eca <outb>:
{
80103eca:	55                   	push   %ebp
80103ecb:	89 e5                	mov    %esp,%ebp
80103ecd:	83 ec 08             	sub    $0x8,%esp
80103ed0:	8b 45 08             	mov    0x8(%ebp),%eax
80103ed3:	8b 55 0c             	mov    0xc(%ebp),%edx
80103ed6:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103eda:	89 d0                	mov    %edx,%eax
80103edc:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103edf:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103ee3:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103ee7:	ee                   	out    %al,(%dx)
}
80103ee8:	90                   	nop
80103ee9:	c9                   	leave  
80103eea:	c3                   	ret    

80103eeb <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103eeb:	55                   	push   %ebp
80103eec:	89 e5                	mov    %esp,%ebp
80103eee:	83 ec 04             	sub    $0x4,%esp
80103ef1:	8b 45 08             	mov    0x8(%ebp),%eax
80103ef4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103ef8:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103efc:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103f02:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103f06:	0f b6 c0             	movzbl %al,%eax
80103f09:	50                   	push   %eax
80103f0a:	6a 21                	push   $0x21
80103f0c:	e8 b9 ff ff ff       	call   80103eca <outb>
80103f11:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103f14:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103f18:	66 c1 e8 08          	shr    $0x8,%ax
80103f1c:	0f b6 c0             	movzbl %al,%eax
80103f1f:	50                   	push   %eax
80103f20:	68 a1 00 00 00       	push   $0xa1
80103f25:	e8 a0 ff ff ff       	call   80103eca <outb>
80103f2a:	83 c4 08             	add    $0x8,%esp
}
80103f2d:	90                   	nop
80103f2e:	c9                   	leave  
80103f2f:	c3                   	ret    

80103f30 <picenable>:

void
picenable(int irq)
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103f33:	8b 45 08             	mov    0x8(%ebp),%eax
80103f36:	ba 01 00 00 00       	mov    $0x1,%edx
80103f3b:	89 c1                	mov    %eax,%ecx
80103f3d:	d3 e2                	shl    %cl,%edx
80103f3f:	89 d0                	mov    %edx,%eax
80103f41:	f7 d0                	not    %eax
80103f43:	89 c2                	mov    %eax,%edx
80103f45:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103f4c:	21 d0                	and    %edx,%eax
80103f4e:	0f b7 c0             	movzwl %ax,%eax
80103f51:	50                   	push   %eax
80103f52:	e8 94 ff ff ff       	call   80103eeb <picsetmask>
80103f57:	83 c4 04             	add    $0x4,%esp
}
80103f5a:	90                   	nop
80103f5b:	c9                   	leave  
80103f5c:	c3                   	ret    

80103f5d <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103f5d:	55                   	push   %ebp
80103f5e:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103f60:	68 ff 00 00 00       	push   $0xff
80103f65:	6a 21                	push   $0x21
80103f67:	e8 5e ff ff ff       	call   80103eca <outb>
80103f6c:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103f6f:	68 ff 00 00 00       	push   $0xff
80103f74:	68 a1 00 00 00       	push   $0xa1
80103f79:	e8 4c ff ff ff       	call   80103eca <outb>
80103f7e:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103f81:	6a 11                	push   $0x11
80103f83:	6a 20                	push   $0x20
80103f85:	e8 40 ff ff ff       	call   80103eca <outb>
80103f8a:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103f8d:	6a 20                	push   $0x20
80103f8f:	6a 21                	push   $0x21
80103f91:	e8 34 ff ff ff       	call   80103eca <outb>
80103f96:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103f99:	6a 04                	push   $0x4
80103f9b:	6a 21                	push   $0x21
80103f9d:	e8 28 ff ff ff       	call   80103eca <outb>
80103fa2:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103fa5:	6a 03                	push   $0x3
80103fa7:	6a 21                	push   $0x21
80103fa9:	e8 1c ff ff ff       	call   80103eca <outb>
80103fae:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103fb1:	6a 11                	push   $0x11
80103fb3:	68 a0 00 00 00       	push   $0xa0
80103fb8:	e8 0d ff ff ff       	call   80103eca <outb>
80103fbd:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103fc0:	6a 28                	push   $0x28
80103fc2:	68 a1 00 00 00       	push   $0xa1
80103fc7:	e8 fe fe ff ff       	call   80103eca <outb>
80103fcc:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103fcf:	6a 02                	push   $0x2
80103fd1:	68 a1 00 00 00       	push   $0xa1
80103fd6:	e8 ef fe ff ff       	call   80103eca <outb>
80103fdb:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103fde:	6a 03                	push   $0x3
80103fe0:	68 a1 00 00 00       	push   $0xa1
80103fe5:	e8 e0 fe ff ff       	call   80103eca <outb>
80103fea:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103fed:	6a 68                	push   $0x68
80103fef:	6a 20                	push   $0x20
80103ff1:	e8 d4 fe ff ff       	call   80103eca <outb>
80103ff6:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103ff9:	6a 0a                	push   $0xa
80103ffb:	6a 20                	push   $0x20
80103ffd:	e8 c8 fe ff ff       	call   80103eca <outb>
80104002:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80104005:	6a 68                	push   $0x68
80104007:	68 a0 00 00 00       	push   $0xa0
8010400c:	e8 b9 fe ff ff       	call   80103eca <outb>
80104011:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80104014:	6a 0a                	push   $0xa
80104016:	68 a0 00 00 00       	push   $0xa0
8010401b:	e8 aa fe ff ff       	call   80103eca <outb>
80104020:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80104023:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
8010402a:	66 83 f8 ff          	cmp    $0xffff,%ax
8010402e:	74 13                	je     80104043 <picinit+0xe6>
    picsetmask(irqmask);
80104030:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80104037:	0f b7 c0             	movzwl %ax,%eax
8010403a:	50                   	push   %eax
8010403b:	e8 ab fe ff ff       	call   80103eeb <picsetmask>
80104040:	83 c4 04             	add    $0x4,%esp
}
80104043:	90                   	nop
80104044:	c9                   	leave  
80104045:	c3                   	ret    

80104046 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104046:	55                   	push   %ebp
80104047:	89 e5                	mov    %esp,%ebp
80104049:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
8010404c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80104053:	8b 45 0c             	mov    0xc(%ebp),%eax
80104056:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010405c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010405f:	8b 10                	mov    (%eax),%edx
80104061:	8b 45 08             	mov    0x8(%ebp),%eax
80104064:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80104066:	e8 33 cf ff ff       	call   80100f9e <filealloc>
8010406b:	89 c2                	mov    %eax,%edx
8010406d:	8b 45 08             	mov    0x8(%ebp),%eax
80104070:	89 10                	mov    %edx,(%eax)
80104072:	8b 45 08             	mov    0x8(%ebp),%eax
80104075:	8b 00                	mov    (%eax),%eax
80104077:	85 c0                	test   %eax,%eax
80104079:	0f 84 ca 00 00 00    	je     80104149 <pipealloc+0x103>
8010407f:	e8 1a cf ff ff       	call   80100f9e <filealloc>
80104084:	89 c2                	mov    %eax,%edx
80104086:	8b 45 0c             	mov    0xc(%ebp),%eax
80104089:	89 10                	mov    %edx,(%eax)
8010408b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010408e:	8b 00                	mov    (%eax),%eax
80104090:	85 c0                	test   %eax,%eax
80104092:	0f 84 b1 00 00 00    	je     80104149 <pipealloc+0x103>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104098:	e8 cd eb ff ff       	call   80102c6a <kalloc>
8010409d:	89 45 f4             	mov    %eax,-0xc(%ebp)
801040a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801040a4:	0f 84 a2 00 00 00    	je     8010414c <pipealloc+0x106>
    goto bad;
  p->readopen = 1;
801040aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040ad:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801040b4:	00 00 00 
  p->writeopen = 1;
801040b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040ba:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801040c1:	00 00 00 
  p->nwrite = 0;
801040c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040c7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801040ce:	00 00 00 
  p->nread = 0;
801040d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040d4:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801040db:	00 00 00 
  initlock(&p->lock, "pipe");
801040de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040e1:	83 ec 08             	sub    $0x8,%esp
801040e4:	68 58 8a 10 80       	push   $0x80108a58
801040e9:	50                   	push   %eax
801040ea:	e8 bb 10 00 00       	call   801051aa <initlock>
801040ef:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801040f2:	8b 45 08             	mov    0x8(%ebp),%eax
801040f5:	8b 00                	mov    (%eax),%eax
801040f7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801040fd:	8b 45 08             	mov    0x8(%ebp),%eax
80104100:	8b 00                	mov    (%eax),%eax
80104102:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80104106:	8b 45 08             	mov    0x8(%ebp),%eax
80104109:	8b 00                	mov    (%eax),%eax
8010410b:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010410f:	8b 45 08             	mov    0x8(%ebp),%eax
80104112:	8b 00                	mov    (%eax),%eax
80104114:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104117:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010411a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010411d:	8b 00                	mov    (%eax),%eax
8010411f:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104125:	8b 45 0c             	mov    0xc(%ebp),%eax
80104128:	8b 00                	mov    (%eax),%eax
8010412a:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010412e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104131:	8b 00                	mov    (%eax),%eax
80104133:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80104137:	8b 45 0c             	mov    0xc(%ebp),%eax
8010413a:	8b 00                	mov    (%eax),%eax
8010413c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010413f:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80104142:	b8 00 00 00 00       	mov    $0x0,%eax
80104147:	eb 51                	jmp    8010419a <pipealloc+0x154>
    goto bad;
80104149:	90                   	nop
8010414a:	eb 01                	jmp    8010414d <pipealloc+0x107>
    goto bad;
8010414c:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
8010414d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104151:	74 0e                	je     80104161 <pipealloc+0x11b>
    kfree((char*)p);
80104153:	83 ec 0c             	sub    $0xc,%esp
80104156:	ff 75 f4             	pushl  -0xc(%ebp)
80104159:	e8 6f ea ff ff       	call   80102bcd <kfree>
8010415e:	83 c4 10             	add    $0x10,%esp
  if(*f0)
80104161:	8b 45 08             	mov    0x8(%ebp),%eax
80104164:	8b 00                	mov    (%eax),%eax
80104166:	85 c0                	test   %eax,%eax
80104168:	74 11                	je     8010417b <pipealloc+0x135>
    fileclose(*f0);
8010416a:	8b 45 08             	mov    0x8(%ebp),%eax
8010416d:	8b 00                	mov    (%eax),%eax
8010416f:	83 ec 0c             	sub    $0xc,%esp
80104172:	50                   	push   %eax
80104173:	e8 e4 ce ff ff       	call   8010105c <fileclose>
80104178:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010417b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010417e:	8b 00                	mov    (%eax),%eax
80104180:	85 c0                	test   %eax,%eax
80104182:	74 11                	je     80104195 <pipealloc+0x14f>
    fileclose(*f1);
80104184:	8b 45 0c             	mov    0xc(%ebp),%eax
80104187:	8b 00                	mov    (%eax),%eax
80104189:	83 ec 0c             	sub    $0xc,%esp
8010418c:	50                   	push   %eax
8010418d:	e8 ca ce ff ff       	call   8010105c <fileclose>
80104192:	83 c4 10             	add    $0x10,%esp
  return -1;
80104195:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010419a:	c9                   	leave  
8010419b:	c3                   	ret    

8010419c <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
8010419c:	55                   	push   %ebp
8010419d:	89 e5                	mov    %esp,%ebp
8010419f:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
801041a2:	8b 45 08             	mov    0x8(%ebp),%eax
801041a5:	83 ec 0c             	sub    $0xc,%esp
801041a8:	50                   	push   %eax
801041a9:	e8 1e 10 00 00       	call   801051cc <acquire>
801041ae:	83 c4 10             	add    $0x10,%esp
  if(writable){
801041b1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801041b5:	74 23                	je     801041da <pipeclose+0x3e>
    p->writeopen = 0;
801041b7:	8b 45 08             	mov    0x8(%ebp),%eax
801041ba:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
801041c1:	00 00 00 
    wakeup(&p->nread);
801041c4:	8b 45 08             	mov    0x8(%ebp),%eax
801041c7:	05 34 02 00 00       	add    $0x234,%eax
801041cc:	83 ec 0c             	sub    $0xc,%esp
801041cf:	50                   	push   %eax
801041d0:	e8 d9 0d 00 00       	call   80104fae <wakeup>
801041d5:	83 c4 10             	add    $0x10,%esp
801041d8:	eb 21                	jmp    801041fb <pipeclose+0x5f>
  } else {
    p->readopen = 0;
801041da:	8b 45 08             	mov    0x8(%ebp),%eax
801041dd:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
801041e4:	00 00 00 
    wakeup(&p->nwrite);
801041e7:	8b 45 08             	mov    0x8(%ebp),%eax
801041ea:	05 38 02 00 00       	add    $0x238,%eax
801041ef:	83 ec 0c             	sub    $0xc,%esp
801041f2:	50                   	push   %eax
801041f3:	e8 b6 0d 00 00       	call   80104fae <wakeup>
801041f8:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
801041fb:	8b 45 08             	mov    0x8(%ebp),%eax
801041fe:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104204:	85 c0                	test   %eax,%eax
80104206:	75 2c                	jne    80104234 <pipeclose+0x98>
80104208:	8b 45 08             	mov    0x8(%ebp),%eax
8010420b:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104211:	85 c0                	test   %eax,%eax
80104213:	75 1f                	jne    80104234 <pipeclose+0x98>
    release(&p->lock);
80104215:	8b 45 08             	mov    0x8(%ebp),%eax
80104218:	83 ec 0c             	sub    $0xc,%esp
8010421b:	50                   	push   %eax
8010421c:	e8 12 10 00 00       	call   80105233 <release>
80104221:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
80104224:	83 ec 0c             	sub    $0xc,%esp
80104227:	ff 75 08             	pushl  0x8(%ebp)
8010422a:	e8 9e e9 ff ff       	call   80102bcd <kfree>
8010422f:	83 c4 10             	add    $0x10,%esp
80104232:	eb 0f                	jmp    80104243 <pipeclose+0xa7>
  } else
    release(&p->lock);
80104234:	8b 45 08             	mov    0x8(%ebp),%eax
80104237:	83 ec 0c             	sub    $0xc,%esp
8010423a:	50                   	push   %eax
8010423b:	e8 f3 0f 00 00       	call   80105233 <release>
80104240:	83 c4 10             	add    $0x10,%esp
}
80104243:	90                   	nop
80104244:	c9                   	leave  
80104245:	c3                   	ret    

80104246 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104246:	55                   	push   %ebp
80104247:	89 e5                	mov    %esp,%ebp
80104249:	53                   	push   %ebx
8010424a:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
8010424d:	8b 45 08             	mov    0x8(%ebp),%eax
80104250:	83 ec 0c             	sub    $0xc,%esp
80104253:	50                   	push   %eax
80104254:	e8 73 0f 00 00       	call   801051cc <acquire>
80104259:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
8010425c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104263:	e9 ae 00 00 00       	jmp    80104316 <pipewrite+0xd0>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
80104268:	8b 45 08             	mov    0x8(%ebp),%eax
8010426b:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104271:	85 c0                	test   %eax,%eax
80104273:	74 0d                	je     80104282 <pipewrite+0x3c>
80104275:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010427b:	8b 40 24             	mov    0x24(%eax),%eax
8010427e:	85 c0                	test   %eax,%eax
80104280:	74 19                	je     8010429b <pipewrite+0x55>
        release(&p->lock);
80104282:	8b 45 08             	mov    0x8(%ebp),%eax
80104285:	83 ec 0c             	sub    $0xc,%esp
80104288:	50                   	push   %eax
80104289:	e8 a5 0f 00 00       	call   80105233 <release>
8010428e:	83 c4 10             	add    $0x10,%esp
        return -1;
80104291:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104296:	e9 a9 00 00 00       	jmp    80104344 <pipewrite+0xfe>
      }
      wakeup(&p->nread);
8010429b:	8b 45 08             	mov    0x8(%ebp),%eax
8010429e:	05 34 02 00 00       	add    $0x234,%eax
801042a3:	83 ec 0c             	sub    $0xc,%esp
801042a6:	50                   	push   %eax
801042a7:	e8 02 0d 00 00       	call   80104fae <wakeup>
801042ac:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801042af:	8b 45 08             	mov    0x8(%ebp),%eax
801042b2:	8b 55 08             	mov    0x8(%ebp),%edx
801042b5:	81 c2 38 02 00 00    	add    $0x238,%edx
801042bb:	83 ec 08             	sub    $0x8,%esp
801042be:	50                   	push   %eax
801042bf:	52                   	push   %edx
801042c0:	e8 fb 0b 00 00       	call   80104ec0 <sleep>
801042c5:	83 c4 10             	add    $0x10,%esp
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801042c8:	8b 45 08             	mov    0x8(%ebp),%eax
801042cb:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
801042d1:	8b 45 08             	mov    0x8(%ebp),%eax
801042d4:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801042da:	05 00 02 00 00       	add    $0x200,%eax
801042df:	39 c2                	cmp    %eax,%edx
801042e1:	74 85                	je     80104268 <pipewrite+0x22>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801042e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042e6:	8b 45 0c             	mov    0xc(%ebp),%eax
801042e9:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
801042ec:	8b 45 08             	mov    0x8(%ebp),%eax
801042ef:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801042f5:	8d 48 01             	lea    0x1(%eax),%ecx
801042f8:	8b 55 08             	mov    0x8(%ebp),%edx
801042fb:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80104301:	25 ff 01 00 00       	and    $0x1ff,%eax
80104306:	89 c1                	mov    %eax,%ecx
80104308:	0f b6 13             	movzbl (%ebx),%edx
8010430b:	8b 45 08             	mov    0x8(%ebp),%eax
8010430e:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
  for(i = 0; i < n; i++){
80104312:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104316:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104319:	3b 45 10             	cmp    0x10(%ebp),%eax
8010431c:	7c aa                	jl     801042c8 <pipewrite+0x82>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010431e:	8b 45 08             	mov    0x8(%ebp),%eax
80104321:	05 34 02 00 00       	add    $0x234,%eax
80104326:	83 ec 0c             	sub    $0xc,%esp
80104329:	50                   	push   %eax
8010432a:	e8 7f 0c 00 00       	call   80104fae <wakeup>
8010432f:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80104332:	8b 45 08             	mov    0x8(%ebp),%eax
80104335:	83 ec 0c             	sub    $0xc,%esp
80104338:	50                   	push   %eax
80104339:	e8 f5 0e 00 00       	call   80105233 <release>
8010433e:	83 c4 10             	add    $0x10,%esp
  return n;
80104341:	8b 45 10             	mov    0x10(%ebp),%eax
}
80104344:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104347:	c9                   	leave  
80104348:	c3                   	ret    

80104349 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104349:	55                   	push   %ebp
8010434a:	89 e5                	mov    %esp,%ebp
8010434c:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
8010434f:	8b 45 08             	mov    0x8(%ebp),%eax
80104352:	83 ec 0c             	sub    $0xc,%esp
80104355:	50                   	push   %eax
80104356:	e8 71 0e 00 00       	call   801051cc <acquire>
8010435b:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010435e:	eb 3f                	jmp    8010439f <piperead+0x56>
    if(proc->killed){
80104360:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104366:	8b 40 24             	mov    0x24(%eax),%eax
80104369:	85 c0                	test   %eax,%eax
8010436b:	74 19                	je     80104386 <piperead+0x3d>
      release(&p->lock);
8010436d:	8b 45 08             	mov    0x8(%ebp),%eax
80104370:	83 ec 0c             	sub    $0xc,%esp
80104373:	50                   	push   %eax
80104374:	e8 ba 0e 00 00       	call   80105233 <release>
80104379:	83 c4 10             	add    $0x10,%esp
      return -1;
8010437c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104381:	e9 be 00 00 00       	jmp    80104444 <piperead+0xfb>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104386:	8b 45 08             	mov    0x8(%ebp),%eax
80104389:	8b 55 08             	mov    0x8(%ebp),%edx
8010438c:	81 c2 34 02 00 00    	add    $0x234,%edx
80104392:	83 ec 08             	sub    $0x8,%esp
80104395:	50                   	push   %eax
80104396:	52                   	push   %edx
80104397:	e8 24 0b 00 00       	call   80104ec0 <sleep>
8010439c:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010439f:	8b 45 08             	mov    0x8(%ebp),%eax
801043a2:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801043a8:	8b 45 08             	mov    0x8(%ebp),%eax
801043ab:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801043b1:	39 c2                	cmp    %eax,%edx
801043b3:	75 0d                	jne    801043c2 <piperead+0x79>
801043b5:	8b 45 08             	mov    0x8(%ebp),%eax
801043b8:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801043be:	85 c0                	test   %eax,%eax
801043c0:	75 9e                	jne    80104360 <piperead+0x17>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801043c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801043c9:	eb 48                	jmp    80104413 <piperead+0xca>
    if(p->nread == p->nwrite)
801043cb:	8b 45 08             	mov    0x8(%ebp),%eax
801043ce:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801043d4:	8b 45 08             	mov    0x8(%ebp),%eax
801043d7:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801043dd:	39 c2                	cmp    %eax,%edx
801043df:	74 3c                	je     8010441d <piperead+0xd4>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801043e1:	8b 45 08             	mov    0x8(%ebp),%eax
801043e4:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801043ea:	8d 48 01             	lea    0x1(%eax),%ecx
801043ed:	8b 55 08             	mov    0x8(%ebp),%edx
801043f0:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
801043f6:	25 ff 01 00 00       	and    $0x1ff,%eax
801043fb:	89 c1                	mov    %eax,%ecx
801043fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104400:	8b 45 0c             	mov    0xc(%ebp),%eax
80104403:	01 c2                	add    %eax,%edx
80104405:	8b 45 08             	mov    0x8(%ebp),%eax
80104408:	0f b6 44 08 34       	movzbl 0x34(%eax,%ecx,1),%eax
8010440d:	88 02                	mov    %al,(%edx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010440f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104413:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104416:	3b 45 10             	cmp    0x10(%ebp),%eax
80104419:	7c b0                	jl     801043cb <piperead+0x82>
8010441b:	eb 01                	jmp    8010441e <piperead+0xd5>
      break;
8010441d:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010441e:	8b 45 08             	mov    0x8(%ebp),%eax
80104421:	05 38 02 00 00       	add    $0x238,%eax
80104426:	83 ec 0c             	sub    $0xc,%esp
80104429:	50                   	push   %eax
8010442a:	e8 7f 0b 00 00       	call   80104fae <wakeup>
8010442f:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80104432:	8b 45 08             	mov    0x8(%ebp),%eax
80104435:	83 ec 0c             	sub    $0xc,%esp
80104438:	50                   	push   %eax
80104439:	e8 f5 0d 00 00       	call   80105233 <release>
8010443e:	83 c4 10             	add    $0x10,%esp
  return i;
80104441:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104444:	c9                   	leave  
80104445:	c3                   	ret    

80104446 <readeflags>:
{
80104446:	55                   	push   %ebp
80104447:	89 e5                	mov    %esp,%ebp
80104449:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010444c:	9c                   	pushf  
8010444d:	58                   	pop    %eax
8010444e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104451:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104454:	c9                   	leave  
80104455:	c3                   	ret    

80104456 <sti>:
{
80104456:	55                   	push   %ebp
80104457:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104459:	fb                   	sti    
}
8010445a:	90                   	nop
8010445b:	5d                   	pop    %ebp
8010445c:	c3                   	ret    

8010445d <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
8010445d:	55                   	push   %ebp
8010445e:	89 e5                	mov    %esp,%ebp
80104460:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
80104463:	83 ec 08             	sub    $0x8,%esp
80104466:	68 5d 8a 10 80       	push   $0x80108a5d
8010446b:	68 60 29 11 80       	push   $0x80112960
80104470:	e8 35 0d 00 00       	call   801051aa <initlock>
80104475:	83 c4 10             	add    $0x10,%esp
}
80104478:	90                   	nop
80104479:	c9                   	leave  
8010447a:	c3                   	ret    

8010447b <verifica_estado_processo>:

//Verificar se o processo está iniciando ou terminando

void verifica_estado_processo(struct proc *p, int estado){
8010447b:	55                   	push   %ebp
8010447c:	89 e5                	mov    %esp,%ebp
8010447e:	83 ec 08             	sub    $0x8,%esp
  if (estado){
80104481:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104485:	74 4e                	je     801044d5 <verifica_estado_processo+0x5a>
    cprintf("Processo iniciando\n");
80104487:	83 ec 0c             	sub    $0xc,%esp
8010448a:	68 64 8a 10 80       	push   $0x80108a64
8010448f:	e8 30 bf ff ff       	call   801003c4 <cprintf>
80104494:	83 c4 10             	add    $0x10,%esp
    cprintf("Id: %d Passo calculado %d\n", p->pid, p->passo);
80104497:	8b 45 08             	mov    0x8(%ebp),%eax
8010449a:	8b 50 6c             	mov    0x6c(%eax),%edx
8010449d:	8b 45 08             	mov    0x8(%ebp),%eax
801044a0:	8b 40 10             	mov    0x10(%eax),%eax
801044a3:	83 ec 04             	sub    $0x4,%esp
801044a6:	52                   	push   %edx
801044a7:	50                   	push   %eax
801044a8:	68 78 8a 10 80       	push   $0x80108a78
801044ad:	e8 12 bf ff ff       	call   801003c4 <cprintf>
801044b2:	83 c4 10             	add    $0x10,%esp
    cprintf("Id: %d Passo atual %d\n", p->pid, p->passada);
801044b5:	8b 45 08             	mov    0x8(%ebp),%eax
801044b8:	8b 50 70             	mov    0x70(%eax),%edx
801044bb:	8b 45 08             	mov    0x8(%ebp),%eax
801044be:	8b 40 10             	mov    0x10(%eax),%eax
801044c1:	83 ec 04             	sub    $0x4,%esp
801044c4:	52                   	push   %edx
801044c5:	50                   	push   %eax
801044c6:	68 93 8a 10 80       	push   $0x80108a93
801044cb:	e8 f4 be ff ff       	call   801003c4 <cprintf>
801044d0:	83 c4 10             	add    $0x10,%esp
  }else{
    cprintf("Processo finalizado\n");
    cprintf("Id: %d Passo atual %d\n", p->pid,p->passada);
  }
}
801044d3:	eb 2e                	jmp    80104503 <verifica_estado_processo+0x88>
    cprintf("Processo finalizado\n");
801044d5:	83 ec 0c             	sub    $0xc,%esp
801044d8:	68 aa 8a 10 80       	push   $0x80108aaa
801044dd:	e8 e2 be ff ff       	call   801003c4 <cprintf>
801044e2:	83 c4 10             	add    $0x10,%esp
    cprintf("Id: %d Passo atual %d\n", p->pid,p->passada);
801044e5:	8b 45 08             	mov    0x8(%ebp),%eax
801044e8:	8b 50 70             	mov    0x70(%eax),%edx
801044eb:	8b 45 08             	mov    0x8(%ebp),%eax
801044ee:	8b 40 10             	mov    0x10(%eax),%eax
801044f1:	83 ec 04             	sub    $0x4,%esp
801044f4:	52                   	push   %edx
801044f5:	50                   	push   %eax
801044f6:	68 93 8a 10 80       	push   $0x80108a93
801044fb:	e8 c4 be ff ff       	call   801003c4 <cprintf>
80104500:	83 c4 10             	add    $0x10,%esp
}
80104503:	90                   	nop
80104504:	c9                   	leave  
80104505:	c3                   	ret    

80104506 <allocproc>:
//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc* allocproc(int stride){
80104506:	55                   	push   %ebp
80104507:	89 e5                	mov    %esp,%ebp
80104509:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010450c:	83 ec 0c             	sub    $0xc,%esp
8010450f:	68 60 29 11 80       	push   $0x80112960
80104514:	e8 b3 0c 00 00       	call   801051cc <acquire>
80104519:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010451c:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104523:	eb 11                	jmp    80104536 <allocproc+0x30>
    if(p->state == UNUSED)
80104525:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104528:	8b 40 0c             	mov    0xc(%eax),%eax
8010452b:	85 c0                	test   %eax,%eax
8010452d:	74 2a                	je     80104559 <allocproc+0x53>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010452f:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
80104536:	81 7d f4 94 4a 11 80 	cmpl   $0x80114a94,-0xc(%ebp)
8010453d:	72 e6                	jb     80104525 <allocproc+0x1f>
      goto found;
  release(&ptable.lock);
8010453f:	83 ec 0c             	sub    $0xc,%esp
80104542:	68 60 29 11 80       	push   $0x80112960
80104547:	e8 e7 0c 00 00       	call   80105233 <release>
8010454c:	83 c4 10             	add    $0x10,%esp
  return 0;
8010454f:	b8 00 00 00 00       	mov    $0x0,%eax
80104554:	e9 cf 00 00 00       	jmp    80104628 <allocproc+0x122>
      goto found;
80104559:	90                   	nop

found:
  p->state = EMBRYO;
8010455a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010455d:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
80104564:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80104569:	8d 50 01             	lea    0x1(%eax),%edx
8010456c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80104572:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104575:	89 42 10             	mov    %eax,0x10(%edx)
  p->passo = 10000/stride;
80104578:	b8 10 27 00 00       	mov    $0x2710,%eax
8010457d:	99                   	cltd   
8010457e:	f7 7d 08             	idivl  0x8(%ebp)
80104581:	89 c2                	mov    %eax,%edx
80104583:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104586:	89 50 6c             	mov    %edx,0x6c(%eax)
  p->passada = 0;
80104589:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010458c:	c7 40 70 00 00 00 00 	movl   $0x0,0x70(%eax)
  release(&ptable.lock);
80104593:	83 ec 0c             	sub    $0xc,%esp
80104596:	68 60 29 11 80       	push   $0x80112960
8010459b:	e8 93 0c 00 00       	call   80105233 <release>
801045a0:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801045a3:	e8 c2 e6 ff ff       	call   80102c6a <kalloc>
801045a8:	89 c2                	mov    %eax,%edx
801045aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045ad:	89 50 08             	mov    %edx,0x8(%eax)
801045b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045b3:	8b 40 08             	mov    0x8(%eax),%eax
801045b6:	85 c0                	test   %eax,%eax
801045b8:	75 11                	jne    801045cb <allocproc+0xc5>
    p->state = UNUSED;
801045ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045bd:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
801045c4:	b8 00 00 00 00       	mov    $0x0,%eax
801045c9:	eb 5d                	jmp    80104628 <allocproc+0x122>
  }
  sp = p->kstack + KSTACKSIZE;
801045cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045ce:	8b 40 08             	mov    0x8(%eax),%eax
801045d1:	05 00 10 00 00       	add    $0x1000,%eax
801045d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801045d9:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
801045dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045e0:	8b 55 f0             	mov    -0x10(%ebp),%edx
801045e3:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
801045e6:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
801045ea:	ba 27 68 10 80       	mov    $0x80106827,%edx
801045ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801045f2:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
801045f4:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
801045f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045fb:	8b 55 f0             	mov    -0x10(%ebp),%edx
801045fe:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80104601:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104604:	8b 40 1c             	mov    0x1c(%eax),%eax
80104607:	83 ec 04             	sub    $0x4,%esp
8010460a:	6a 14                	push   $0x14
8010460c:	6a 00                	push   $0x0
8010460e:	50                   	push   %eax
8010460f:	e8 1b 0e 00 00       	call   8010542f <memset>
80104614:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104617:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010461a:	8b 40 1c             	mov    0x1c(%eax),%eax
8010461d:	ba 7a 4e 10 80       	mov    $0x80104e7a,%edx
80104622:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80104625:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104628:	c9                   	leave  
80104629:	c3                   	ret    

8010462a <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
8010462a:	55                   	push   %ebp
8010462b:	89 e5                	mov    %esp,%ebp
8010462d:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc(DEFAULT_TICKETS);
80104630:	83 ec 0c             	sub    $0xc,%esp
80104633:	68 fa 00 00 00       	push   $0xfa
80104638:	e8 c9 fe ff ff       	call   80104506 <allocproc>
8010463d:	83 c4 10             	add    $0x10,%esp
80104640:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
80104643:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104646:	a3 48 b6 10 80       	mov    %eax,0x8010b648
  if((p->pgdir = setupkvm()) == 0)
8010464b:	e8 9e 38 00 00       	call   80107eee <setupkvm>
80104650:	89 c2                	mov    %eax,%edx
80104652:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104655:	89 50 04             	mov    %edx,0x4(%eax)
80104658:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010465b:	8b 40 04             	mov    0x4(%eax),%eax
8010465e:	85 c0                	test   %eax,%eax
80104660:	75 0d                	jne    8010466f <userinit+0x45>
    panic("userinit: out of memory?");
80104662:	83 ec 0c             	sub    $0xc,%esp
80104665:	68 bf 8a 10 80       	push   $0x80108abf
8010466a:	e8 f8 be ff ff       	call   80100567 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
8010466f:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104674:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104677:	8b 40 04             	mov    0x4(%eax),%eax
8010467a:	83 ec 04             	sub    $0x4,%esp
8010467d:	52                   	push   %edx
8010467e:	68 e0 b4 10 80       	push   $0x8010b4e0
80104683:	50                   	push   %eax
80104684:	e8 c0 3a 00 00       	call   80108149 <inituvm>
80104689:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
8010468c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010468f:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104695:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104698:	8b 40 18             	mov    0x18(%eax),%eax
8010469b:	83 ec 04             	sub    $0x4,%esp
8010469e:	6a 4c                	push   $0x4c
801046a0:	6a 00                	push   $0x0
801046a2:	50                   	push   %eax
801046a3:	e8 87 0d 00 00       	call   8010542f <memset>
801046a8:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801046ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046ae:	8b 40 18             	mov    0x18(%eax),%eax
801046b1:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801046b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046ba:	8b 40 18             	mov    0x18(%eax),%eax
801046bd:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801046c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046c6:	8b 50 18             	mov    0x18(%eax),%edx
801046c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046cc:	8b 40 18             	mov    0x18(%eax),%eax
801046cf:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801046d3:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801046d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046da:	8b 50 18             	mov    0x18(%eax),%edx
801046dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046e0:	8b 40 18             	mov    0x18(%eax),%eax
801046e3:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801046e7:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801046eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046ee:	8b 40 18             	mov    0x18(%eax),%eax
801046f1:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801046f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046fb:	8b 40 18             	mov    0x18(%eax),%eax
801046fe:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104705:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104708:	8b 40 18             	mov    0x18(%eax),%eax
8010470b:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104712:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104715:	83 c0 74             	add    $0x74,%eax
80104718:	83 ec 04             	sub    $0x4,%esp
8010471b:	6a 10                	push   $0x10
8010471d:	68 d8 8a 10 80       	push   $0x80108ad8
80104722:	50                   	push   %eax
80104723:	e8 0a 0f 00 00       	call   80105632 <safestrcpy>
80104728:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
8010472b:	83 ec 0c             	sub    $0xc,%esp
8010472e:	68 e1 8a 10 80       	push   $0x80108ae1
80104733:	e8 f2 dd ff ff       	call   8010252a <namei>
80104738:	83 c4 10             	add    $0x10,%esp
8010473b:	89 c2                	mov    %eax,%edx
8010473d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104740:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
80104743:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104746:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
8010474d:	90                   	nop
8010474e:	c9                   	leave  
8010474f:	c3                   	ret    

80104750 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
80104756:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010475c:	8b 00                	mov    (%eax),%eax
8010475e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104761:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104765:	7e 31                	jle    80104798 <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104767:	8b 55 08             	mov    0x8(%ebp),%edx
8010476a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010476d:	01 c2                	add    %eax,%edx
8010476f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104775:	8b 40 04             	mov    0x4(%eax),%eax
80104778:	83 ec 04             	sub    $0x4,%esp
8010477b:	52                   	push   %edx
8010477c:	ff 75 f4             	pushl  -0xc(%ebp)
8010477f:	50                   	push   %eax
80104780:	e8 11 3b 00 00       	call   80108296 <allocuvm>
80104785:	83 c4 10             	add    $0x10,%esp
80104788:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010478b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010478f:	75 3e                	jne    801047cf <growproc+0x7f>
      return -1;
80104791:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104796:	eb 59                	jmp    801047f1 <growproc+0xa1>
  } else if(n < 0){
80104798:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010479c:	79 31                	jns    801047cf <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
8010479e:	8b 55 08             	mov    0x8(%ebp),%edx
801047a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047a4:	01 c2                	add    %eax,%edx
801047a6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047ac:	8b 40 04             	mov    0x4(%eax),%eax
801047af:	83 ec 04             	sub    $0x4,%esp
801047b2:	52                   	push   %edx
801047b3:	ff 75 f4             	pushl  -0xc(%ebp)
801047b6:	50                   	push   %eax
801047b7:	e8 a3 3b 00 00       	call   8010835f <deallocuvm>
801047bc:	83 c4 10             	add    $0x10,%esp
801047bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
801047c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801047c6:	75 07                	jne    801047cf <growproc+0x7f>
      return -1;
801047c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047cd:	eb 22                	jmp    801047f1 <growproc+0xa1>
  }
  proc->sz = sz;
801047cf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801047d8:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
801047da:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047e0:	83 ec 0c             	sub    $0xc,%esp
801047e3:	50                   	push   %eax
801047e4:	e8 ec 37 00 00       	call   80107fd5 <switchuvm>
801047e9:	83 c4 10             	add    $0x10,%esp
  return 0;
801047ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
801047f1:	c9                   	leave  
801047f2:	c3                   	ret    

801047f3 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(int stride)
{
801047f3:	55                   	push   %ebp
801047f4:	89 e5                	mov    %esp,%ebp
801047f6:	57                   	push   %edi
801047f7:	56                   	push   %esi
801047f8:	53                   	push   %ebx
801047f9:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;
  if(!stride){
801047fc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104800:	75 07                	jne    80104809 <fork+0x16>
      stride = DEFAULT_TICKETS;
80104802:	c7 45 08 fa 00 00 00 	movl   $0xfa,0x8(%ebp)
  }
  // Allocate process.
  if((np = allocproc(stride)) == 0)
80104809:	83 ec 0c             	sub    $0xc,%esp
8010480c:	ff 75 08             	pushl  0x8(%ebp)
8010480f:	e8 f2 fc ff ff       	call   80104506 <allocproc>
80104814:	83 c4 10             	add    $0x10,%esp
80104817:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010481a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010481e:	75 0a                	jne    8010482a <fork+0x37>
    return -1;
80104820:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104825:	e9 c4 01 00 00       	jmp    801049ee <fork+0x1fb>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
8010482a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104830:	8b 10                	mov    (%eax),%edx
80104832:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104838:	8b 40 04             	mov    0x4(%eax),%eax
8010483b:	83 ec 08             	sub    $0x8,%esp
8010483e:	52                   	push   %edx
8010483f:	50                   	push   %eax
80104840:	e8 b8 3c 00 00       	call   801084fd <copyuvm>
80104845:	83 c4 10             	add    $0x10,%esp
80104848:	89 c2                	mov    %eax,%edx
8010484a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010484d:	89 50 04             	mov    %edx,0x4(%eax)
80104850:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104853:	8b 40 04             	mov    0x4(%eax),%eax
80104856:	85 c0                	test   %eax,%eax
80104858:	75 30                	jne    8010488a <fork+0x97>
    kfree(np->kstack);
8010485a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010485d:	8b 40 08             	mov    0x8(%eax),%eax
80104860:	83 ec 0c             	sub    $0xc,%esp
80104863:	50                   	push   %eax
80104864:	e8 64 e3 ff ff       	call   80102bcd <kfree>
80104869:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
8010486c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010486f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104876:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104879:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
80104880:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104885:	e9 64 01 00 00       	jmp    801049ee <fork+0x1fb>
  }
  np->sz = proc->sz;
8010488a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104890:	8b 10                	mov    (%eax),%edx
80104892:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104895:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104897:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010489e:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048a1:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
801048a4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048aa:	8b 48 18             	mov    0x18(%eax),%ecx
801048ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048b0:	8b 40 18             	mov    0x18(%eax),%eax
801048b3:	89 c2                	mov    %eax,%edx
801048b5:	89 cb                	mov    %ecx,%ebx
801048b7:	b8 13 00 00 00       	mov    $0x13,%eax
801048bc:	89 d7                	mov    %edx,%edi
801048be:	89 de                	mov    %ebx,%esi
801048c0:	89 c1                	mov    %eax,%ecx
801048c2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  
  if(!stride)
801048c4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801048c8:	75 0c                	jne    801048d6 <fork+0xe3>
    np->passo=MAX_TICKETS/DEFAULT_TICKETS;
801048ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048cd:	c7 40 6c 08 00 00 00 	movl   $0x8,0x6c(%eax)
801048d4:	eb 38                	jmp    8010490e <fork+0x11b>
  else if (stride<MIN_TICKETS)
801048d6:	83 7d 08 18          	cmpl   $0x18,0x8(%ebp)
801048da:	7f 0c                	jg     801048e8 <fork+0xf5>
      np->passo=MAX_TICKETS/MIN_TICKETS;
801048dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048df:	c7 40 6c 50 00 00 00 	movl   $0x50,0x6c(%eax)
801048e6:	eb 26                	jmp    8010490e <fork+0x11b>
  else if (stride>MAX_TICKETS)
801048e8:	81 7d 08 d0 07 00 00 	cmpl   $0x7d0,0x8(%ebp)
801048ef:	7e 0c                	jle    801048fd <fork+0x10a>
      np->passo=MAX_TICKETS/MAX_TICKETS;
801048f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048f4:	c7 40 6c 01 00 00 00 	movl   $0x1,0x6c(%eax)
801048fb:	eb 11                	jmp    8010490e <fork+0x11b>
  else
      np->passo=MAX_TICKETS/stride;
801048fd:	b8 d0 07 00 00       	mov    $0x7d0,%eax
80104902:	99                   	cltd   
80104903:	f7 7d 08             	idivl  0x8(%ebp)
80104906:	89 c2                	mov    %eax,%edx
80104908:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010490b:	89 50 6c             	mov    %edx,0x6c(%eax)
  
  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
8010490e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104911:	8b 40 18             	mov    0x18(%eax),%eax
80104914:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
8010491b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104922:	eb 43                	jmp    80104967 <fork+0x174>
    if(proc->ofile[i])
80104924:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010492a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010492d:	83 c2 08             	add    $0x8,%edx
80104930:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104934:	85 c0                	test   %eax,%eax
80104936:	74 2b                	je     80104963 <fork+0x170>
      np->ofile[i] = filedup(proc->ofile[i]);
80104938:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010493e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104941:	83 c2 08             	add    $0x8,%edx
80104944:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104948:	83 ec 0c             	sub    $0xc,%esp
8010494b:	50                   	push   %eax
8010494c:	e8 ba c6 ff ff       	call   8010100b <filedup>
80104951:	83 c4 10             	add    $0x10,%esp
80104954:	89 c1                	mov    %eax,%ecx
80104956:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104959:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010495c:	83 c2 08             	add    $0x8,%edx
8010495f:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  for(i = 0; i < NOFILE; i++)
80104963:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104967:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
8010496b:	7e b7                	jle    80104924 <fork+0x131>
  np->cwd = idup(proc->cwd);
8010496d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104973:	8b 40 68             	mov    0x68(%eax),%eax
80104976:	83 ec 0c             	sub    $0xc,%esp
80104979:	50                   	push   %eax
8010497a:	e8 bc cf ff ff       	call   8010193b <idup>
8010497f:	83 c4 10             	add    $0x10,%esp
80104982:	89 c2                	mov    %eax,%edx
80104984:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104987:	89 50 68             	mov    %edx,0x68(%eax)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
8010498a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104990:	8d 50 74             	lea    0x74(%eax),%edx
80104993:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104996:	83 c0 74             	add    $0x74,%eax
80104999:	83 ec 04             	sub    $0x4,%esp
8010499c:	6a 10                	push   $0x10
8010499e:	52                   	push   %edx
8010499f:	50                   	push   %eax
801049a0:	e8 8d 0c 00 00       	call   80105632 <safestrcpy>
801049a5:	83 c4 10             	add    $0x10,%esp
 
  pid = np->pid;
801049a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801049ab:	8b 40 10             	mov    0x10(%eax),%eax
801049ae:	89 45 dc             	mov    %eax,-0x24(%ebp)
  verifica_estado_processo(np, 1);
801049b1:	83 ec 08             	sub    $0x8,%esp
801049b4:	6a 01                	push   $0x1
801049b6:	ff 75 e0             	pushl  -0x20(%ebp)
801049b9:	e8 bd fa ff ff       	call   8010447b <verifica_estado_processo>
801049be:	83 c4 10             	add    $0x10,%esp

  // lock to force the compiler to emit the np->state write last.
  acquire(&ptable.lock);
801049c1:	83 ec 0c             	sub    $0xc,%esp
801049c4:	68 60 29 11 80       	push   $0x80112960
801049c9:	e8 fe 07 00 00       	call   801051cc <acquire>
801049ce:	83 c4 10             	add    $0x10,%esp
  np->state = RUNNABLE;
801049d1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801049d4:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  //WARNING: if use a variable to control tickets for all process, maybe need add here
  release(&ptable.lock);
801049db:	83 ec 0c             	sub    $0xc,%esp
801049de:	68 60 29 11 80       	push   $0x80112960
801049e3:	e8 4b 08 00 00       	call   80105233 <release>
801049e8:	83 c4 10             	add    $0x10,%esp
  
  return pid;
801049eb:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
801049ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049f1:	5b                   	pop    %ebx
801049f2:	5e                   	pop    %esi
801049f3:	5f                   	pop    %edi
801049f4:	5d                   	pop    %ebp
801049f5:	c3                   	ret    

801049f6 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
801049f6:	55                   	push   %ebp
801049f7:	89 e5                	mov    %esp,%ebp
801049f9:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
801049fc:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a03:	a1 48 b6 10 80       	mov    0x8010b648,%eax
80104a08:	39 c2                	cmp    %eax,%edx
80104a0a:	75 0d                	jne    80104a19 <exit+0x23>
    panic("init exiting");
80104a0c:	83 ec 0c             	sub    $0xc,%esp
80104a0f:	68 e3 8a 10 80       	push   $0x80108ae3
80104a14:	e8 4e bb ff ff       	call   80100567 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104a19:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104a20:	eb 48                	jmp    80104a6a <exit+0x74>
    if(proc->ofile[fd]){
80104a22:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a28:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104a2b:	83 c2 08             	add    $0x8,%edx
80104a2e:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104a32:	85 c0                	test   %eax,%eax
80104a34:	74 30                	je     80104a66 <exit+0x70>
      fileclose(proc->ofile[fd]);
80104a36:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a3c:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104a3f:	83 c2 08             	add    $0x8,%edx
80104a42:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104a46:	83 ec 0c             	sub    $0xc,%esp
80104a49:	50                   	push   %eax
80104a4a:	e8 0d c6 ff ff       	call   8010105c <fileclose>
80104a4f:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
80104a52:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a58:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104a5b:	83 c2 08             	add    $0x8,%edx
80104a5e:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104a65:	00 
  for(fd = 0; fd < NOFILE; fd++){
80104a66:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104a6a:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104a6e:	7e b2                	jle    80104a22 <exit+0x2c>
    }
  }

  begin_op();
80104a70:	e8 e1 ea ff ff       	call   80103556 <begin_op>
  iput(proc->cwd);
80104a75:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a7b:	8b 40 68             	mov    0x68(%eax),%eax
80104a7e:	83 ec 0c             	sub    $0xc,%esp
80104a81:	50                   	push   %eax
80104a82:	e8 be d0 ff ff       	call   80101b45 <iput>
80104a87:	83 c4 10             	add    $0x10,%esp
  end_op();
80104a8a:	e8 53 eb ff ff       	call   801035e2 <end_op>
  proc->cwd = 0;
80104a8f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a95:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80104a9c:	83 ec 0c             	sub    $0xc,%esp
80104a9f:	68 60 29 11 80       	push   $0x80112960
80104aa4:	e8 23 07 00 00       	call   801051cc <acquire>
80104aa9:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104aac:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ab2:	8b 40 14             	mov    0x14(%eax),%eax
80104ab5:	83 ec 0c             	sub    $0xc,%esp
80104ab8:	50                   	push   %eax
80104ab9:	e8 ae 04 00 00       	call   80104f6c <wakeup1>
80104abe:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ac1:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104ac8:	eb 3f                	jmp    80104b09 <exit+0x113>
    if(p->parent == proc){
80104aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104acd:	8b 50 14             	mov    0x14(%eax),%edx
80104ad0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ad6:	39 c2                	cmp    %eax,%edx
80104ad8:	75 28                	jne    80104b02 <exit+0x10c>
      p->parent = initproc;
80104ada:	8b 15 48 b6 10 80    	mov    0x8010b648,%edx
80104ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ae3:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80104ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ae9:	8b 40 0c             	mov    0xc(%eax),%eax
80104aec:	83 f8 05             	cmp    $0x5,%eax
80104aef:	75 11                	jne    80104b02 <exit+0x10c>
        wakeup1(initproc);
80104af1:	a1 48 b6 10 80       	mov    0x8010b648,%eax
80104af6:	83 ec 0c             	sub    $0xc,%esp
80104af9:	50                   	push   %eax
80104afa:	e8 6d 04 00 00       	call   80104f6c <wakeup1>
80104aff:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b02:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
80104b09:	81 7d f4 94 4a 11 80 	cmpl   $0x80114a94,-0xc(%ebp)
80104b10:	72 b8                	jb     80104aca <exit+0xd4>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80104b12:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b18:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80104b1f:	e8 5f 02 00 00       	call   80104d83 <sched>
  panic("zombie exit");
80104b24:	83 ec 0c             	sub    $0xc,%esp
80104b27:	68 f0 8a 10 80       	push   $0x80108af0
80104b2c:	e8 36 ba ff ff       	call   80100567 <panic>

80104b31 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104b31:	55                   	push   %ebp
80104b32:	89 e5                	mov    %esp,%ebp
80104b34:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104b37:	83 ec 0c             	sub    $0xc,%esp
80104b3a:	68 60 29 11 80       	push   $0x80112960
80104b3f:	e8 88 06 00 00       	call   801051cc <acquire>
80104b44:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104b47:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b4e:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104b55:	e9 bd 00 00 00       	jmp    80104c17 <wait+0xe6>
      if(p->parent != proc)
80104b5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b5d:	8b 50 14             	mov    0x14(%eax),%edx
80104b60:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b66:	39 c2                	cmp    %eax,%edx
80104b68:	0f 85 a1 00 00 00    	jne    80104c0f <wait+0xde>
        continue;
      havekids = 1;
80104b6e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104b75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b78:	8b 40 0c             	mov    0xc(%eax),%eax
80104b7b:	83 f8 05             	cmp    $0x5,%eax
80104b7e:	0f 85 8c 00 00 00    	jne    80104c10 <wait+0xdf>
        // Found one.
        verifica_estado_processo(p, 0);
80104b84:	83 ec 08             	sub    $0x8,%esp
80104b87:	6a 00                	push   $0x0
80104b89:	ff 75 f4             	pushl  -0xc(%ebp)
80104b8c:	e8 ea f8 ff ff       	call   8010447b <verifica_estado_processo>
80104b91:	83 c4 10             	add    $0x10,%esp
        pid = p->pid;
80104b94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b97:	8b 40 10             	mov    0x10(%eax),%eax
80104b9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ba0:	8b 40 08             	mov    0x8(%eax),%eax
80104ba3:	83 ec 0c             	sub    $0xc,%esp
80104ba6:	50                   	push   %eax
80104ba7:	e8 21 e0 ff ff       	call   80102bcd <kfree>
80104bac:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104baf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bb2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bbc:	8b 40 04             	mov    0x4(%eax),%eax
80104bbf:	83 ec 0c             	sub    $0xc,%esp
80104bc2:	50                   	push   %eax
80104bc3:	e8 54 38 00 00       	call   8010841c <freevm>
80104bc8:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
80104bcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bce:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
80104bd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bd8:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104bdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104be2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bec:	c6 40 74 00          	movb   $0x0,0x74(%eax)
        p->killed = 0;
80104bf0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bf3:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
80104bfa:	83 ec 0c             	sub    $0xc,%esp
80104bfd:	68 60 29 11 80       	push   $0x80112960
80104c02:	e8 2c 06 00 00       	call   80105233 <release>
80104c07:	83 c4 10             	add    $0x10,%esp
        return pid;
80104c0a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104c0d:	eb 5b                	jmp    80104c6a <wait+0x139>
        continue;
80104c0f:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c10:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
80104c17:	81 7d f4 94 4a 11 80 	cmpl   $0x80114a94,-0xc(%ebp)
80104c1e:	0f 82 36 ff ff ff    	jb     80104b5a <wait+0x29>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104c24:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104c28:	74 0d                	je     80104c37 <wait+0x106>
80104c2a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c30:	8b 40 24             	mov    0x24(%eax),%eax
80104c33:	85 c0                	test   %eax,%eax
80104c35:	74 17                	je     80104c4e <wait+0x11d>
      release(&ptable.lock);
80104c37:	83 ec 0c             	sub    $0xc,%esp
80104c3a:	68 60 29 11 80       	push   $0x80112960
80104c3f:	e8 ef 05 00 00       	call   80105233 <release>
80104c44:	83 c4 10             	add    $0x10,%esp
      return -1;
80104c47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c4c:	eb 1c                	jmp    80104c6a <wait+0x139>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104c4e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c54:	83 ec 08             	sub    $0x8,%esp
80104c57:	68 60 29 11 80       	push   $0x80112960
80104c5c:	50                   	push   %eax
80104c5d:	e8 5e 02 00 00       	call   80104ec0 <sleep>
80104c62:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104c65:	e9 dd fe ff ff       	jmp    80104b47 <wait+0x16>
  }
}
80104c6a:	c9                   	leave  
80104c6b:	c3                   	ret    

80104c6c <random>:


int randstate=2;
int random(){
80104c6c:	55                   	push   %ebp
80104c6d:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
80104c6f:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104c74:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
80104c7a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
80104c7f:	a3 08 b0 10 80       	mov    %eax,0x8010b008
  if(randstate<0){
80104c84:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104c89:	85 c0                	test   %eax,%eax
80104c8b:	79 09                	jns    80104c96 <random+0x2a>
    return (randstate*-1);
80104c8d:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104c92:	f7 d8                	neg    %eax
80104c94:	eb 05                	jmp    80104c9b <random+0x2f>
  }
  return randstate;
80104c96:	a1 08 b0 10 80       	mov    0x8010b008,%eax
}
80104c9b:	5d                   	pop    %ebp
80104c9c:	c3                   	ret    

80104c9d <scheduler>:
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void scheduler(void){
80104c9d:	55                   	push   %ebp
80104c9e:	89 e5                	mov    %esp,%ebp
80104ca0:	83 ec 18             	sub    $0x18,%esp
  struct proc *p, *min_proc;
  int min;
  for(;;){
    sti();
80104ca3:	e8 ae f7 ff ff       	call   80104456 <sti>
    acquire(&ptable.lock);
80104ca8:	83 ec 0c             	sub    $0xc,%esp
80104cab:	68 60 29 11 80       	push   $0x80112960
80104cb0:	e8 17 05 00 00       	call   801051cc <acquire>
80104cb5:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc,min = 0; p < &ptable.proc[NPROC]; p++){
80104cb8:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104cbf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80104cc6:	eb 32                	jmp    80104cfa <scheduler+0x5d>
      if(p->state == RUNNABLE && (p->passada <= min || min == 0)){
80104cc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ccb:	8b 40 0c             	mov    0xc(%eax),%eax
80104cce:	83 f8 03             	cmp    $0x3,%eax
80104cd1:	75 20                	jne    80104cf3 <scheduler+0x56>
80104cd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cd6:	8b 40 70             	mov    0x70(%eax),%eax
80104cd9:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80104cdc:	7d 06                	jge    80104ce4 <scheduler+0x47>
80104cde:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80104ce2:	75 0f                	jne    80104cf3 <scheduler+0x56>
          min = p->passada;
80104ce4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ce7:	8b 40 70             	mov    0x70(%eax),%eax
80104cea:	89 45 ec             	mov    %eax,-0x14(%ebp)
          min_proc = p;
80104ced:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cf0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(p = ptable.proc,min = 0; p < &ptable.proc[NPROC]; p++){
80104cf3:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
80104cfa:	81 7d f4 94 4a 11 80 	cmpl   $0x80114a94,-0xc(%ebp)
80104d01:	72 c5                	jb     80104cc8 <scheduler+0x2b>
      }
    }

    if(min_proc){
80104d03:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104d07:	74 65                	je     80104d6e <scheduler+0xd1>
        min_proc->passada += min_proc->passo;
80104d09:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d0c:	8b 50 70             	mov    0x70(%eax),%edx
80104d0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d12:	8b 40 6c             	mov    0x6c(%eax),%eax
80104d15:	01 c2                	add    %eax,%edx
80104d17:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d1a:	89 50 70             	mov    %edx,0x70(%eax)
      proc = min_proc;
80104d1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d20:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(min_proc);
80104d26:	83 ec 0c             	sub    $0xc,%esp
80104d29:	ff 75 f0             	pushl  -0x10(%ebp)
80104d2c:	e8 a4 32 00 00       	call   80107fd5 <switchuvm>
80104d31:	83 c4 10             	add    $0x10,%esp
      min_proc->state = RUNNING;
80104d34:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d37:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
80104d3e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d44:	8b 40 1c             	mov    0x1c(%eax),%eax
80104d47:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104d4e:	83 c2 04             	add    $0x4,%edx
80104d51:	83 ec 08             	sub    $0x8,%esp
80104d54:	50                   	push   %eax
80104d55:	52                   	push   %edx
80104d56:	e8 48 09 00 00       	call   801056a3 <swtch>
80104d5b:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80104d5e:	e8 55 32 00 00       	call   80107fb8 <switchkvm>

      proc = 0;
80104d63:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104d6a:	00 00 00 00 
    }
    release(&ptable.lock);
80104d6e:	83 ec 0c             	sub    $0xc,%esp
80104d71:	68 60 29 11 80       	push   $0x80112960
80104d76:	e8 b8 04 00 00       	call   80105233 <release>
80104d7b:	83 c4 10             	add    $0x10,%esp
    sti();
80104d7e:	e9 20 ff ff ff       	jmp    80104ca3 <scheduler+0x6>

80104d83 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104d83:	55                   	push   %ebp
80104d84:	89 e5                	mov    %esp,%ebp
80104d86:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104d89:	83 ec 0c             	sub    $0xc,%esp
80104d8c:	68 60 29 11 80       	push   $0x80112960
80104d91:	e8 69 05 00 00       	call   801052ff <holding>
80104d96:	83 c4 10             	add    $0x10,%esp
80104d99:	85 c0                	test   %eax,%eax
80104d9b:	75 0d                	jne    80104daa <sched+0x27>
    panic("sched ptable.lock");
80104d9d:	83 ec 0c             	sub    $0xc,%esp
80104da0:	68 fc 8a 10 80       	push   $0x80108afc
80104da5:	e8 bd b7 ff ff       	call   80100567 <panic>
  if(cpu->ncli != 1)
80104daa:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104db0:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104db6:	83 f8 01             	cmp    $0x1,%eax
80104db9:	74 0d                	je     80104dc8 <sched+0x45>
    panic("sched locks");
80104dbb:	83 ec 0c             	sub    $0xc,%esp
80104dbe:	68 0e 8b 10 80       	push   $0x80108b0e
80104dc3:	e8 9f b7 ff ff       	call   80100567 <panic>
  if(proc->state == RUNNING)
80104dc8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104dce:	8b 40 0c             	mov    0xc(%eax),%eax
80104dd1:	83 f8 04             	cmp    $0x4,%eax
80104dd4:	75 0d                	jne    80104de3 <sched+0x60>
    panic("sched running");
80104dd6:	83 ec 0c             	sub    $0xc,%esp
80104dd9:	68 1a 8b 10 80       	push   $0x80108b1a
80104dde:	e8 84 b7 ff ff       	call   80100567 <panic>
  if(readeflags()&FL_IF)
80104de3:	e8 5e f6 ff ff       	call   80104446 <readeflags>
80104de8:	25 00 02 00 00       	and    $0x200,%eax
80104ded:	85 c0                	test   %eax,%eax
80104def:	74 0d                	je     80104dfe <sched+0x7b>
    panic("sched interruptible");
80104df1:	83 ec 0c             	sub    $0xc,%esp
80104df4:	68 28 8b 10 80       	push   $0x80108b28
80104df9:	e8 69 b7 ff ff       	call   80100567 <panic>
  intena = cpu->intena;
80104dfe:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104e04:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104e0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104e0d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104e13:	8b 40 04             	mov    0x4(%eax),%eax
80104e16:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104e1d:	83 c2 1c             	add    $0x1c,%edx
80104e20:	83 ec 08             	sub    $0x8,%esp
80104e23:	50                   	push   %eax
80104e24:	52                   	push   %edx
80104e25:	e8 79 08 00 00       	call   801056a3 <swtch>
80104e2a:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104e2d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104e33:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e36:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104e3c:	90                   	nop
80104e3d:	c9                   	leave  
80104e3e:	c3                   	ret    

80104e3f <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104e3f:	55                   	push   %ebp
80104e40:	89 e5                	mov    %esp,%ebp
80104e42:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104e45:	83 ec 0c             	sub    $0xc,%esp
80104e48:	68 60 29 11 80       	push   $0x80112960
80104e4d:	e8 7a 03 00 00       	call   801051cc <acquire>
80104e52:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104e55:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e5b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104e62:	e8 1c ff ff ff       	call   80104d83 <sched>
  release(&ptable.lock);
80104e67:	83 ec 0c             	sub    $0xc,%esp
80104e6a:	68 60 29 11 80       	push   $0x80112960
80104e6f:	e8 bf 03 00 00       	call   80105233 <release>
80104e74:	83 c4 10             	add    $0x10,%esp
}
80104e77:	90                   	nop
80104e78:	c9                   	leave  
80104e79:	c3                   	ret    

80104e7a <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104e7a:	55                   	push   %ebp
80104e7b:	89 e5                	mov    %esp,%ebp
80104e7d:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104e80:	83 ec 0c             	sub    $0xc,%esp
80104e83:	68 60 29 11 80       	push   $0x80112960
80104e88:	e8 a6 03 00 00       	call   80105233 <release>
80104e8d:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104e90:	a1 0c b0 10 80       	mov    0x8010b00c,%eax
80104e95:	85 c0                	test   %eax,%eax
80104e97:	74 24                	je     80104ebd <forkret+0x43>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104e99:	c7 05 0c b0 10 80 00 	movl   $0x0,0x8010b00c
80104ea0:	00 00 00 
    iinit(ROOTDEV);
80104ea3:	83 ec 0c             	sub    $0xc,%esp
80104ea6:	6a 01                	push   $0x1
80104ea8:	e8 9c c7 ff ff       	call   80101649 <iinit>
80104ead:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
80104eb0:	83 ec 0c             	sub    $0xc,%esp
80104eb3:	6a 01                	push   $0x1
80104eb5:	e8 7e e4 ff ff       	call   80103338 <initlog>
80104eba:	83 c4 10             	add    $0x10,%esp
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104ebd:	90                   	nop
80104ebe:	c9                   	leave  
80104ebf:	c3                   	ret    

80104ec0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104ec6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ecc:	85 c0                	test   %eax,%eax
80104ece:	75 0d                	jne    80104edd <sleep+0x1d>
    panic("sleep");
80104ed0:	83 ec 0c             	sub    $0xc,%esp
80104ed3:	68 3c 8b 10 80       	push   $0x80108b3c
80104ed8:	e8 8a b6 ff ff       	call   80100567 <panic>

  if(lk == 0)
80104edd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104ee1:	75 0d                	jne    80104ef0 <sleep+0x30>
    panic("sleep without lk");
80104ee3:	83 ec 0c             	sub    $0xc,%esp
80104ee6:	68 42 8b 10 80       	push   $0x80108b42
80104eeb:	e8 77 b6 ff ff       	call   80100567 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104ef0:	81 7d 0c 60 29 11 80 	cmpl   $0x80112960,0xc(%ebp)
80104ef7:	74 1e                	je     80104f17 <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104ef9:	83 ec 0c             	sub    $0xc,%esp
80104efc:	68 60 29 11 80       	push   $0x80112960
80104f01:	e8 c6 02 00 00       	call   801051cc <acquire>
80104f06:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104f09:	83 ec 0c             	sub    $0xc,%esp
80104f0c:	ff 75 0c             	pushl  0xc(%ebp)
80104f0f:	e8 1f 03 00 00       	call   80105233 <release>
80104f14:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104f17:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f1d:	8b 55 08             	mov    0x8(%ebp),%edx
80104f20:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104f23:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f29:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104f30:	e8 4e fe ff ff       	call   80104d83 <sched>

  // Tidy up.
  proc->chan = 0;
80104f35:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f3b:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104f42:	81 7d 0c 60 29 11 80 	cmpl   $0x80112960,0xc(%ebp)
80104f49:	74 1e                	je     80104f69 <sleep+0xa9>
    release(&ptable.lock);
80104f4b:	83 ec 0c             	sub    $0xc,%esp
80104f4e:	68 60 29 11 80       	push   $0x80112960
80104f53:	e8 db 02 00 00       	call   80105233 <release>
80104f58:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104f5b:	83 ec 0c             	sub    $0xc,%esp
80104f5e:	ff 75 0c             	pushl  0xc(%ebp)
80104f61:	e8 66 02 00 00       	call   801051cc <acquire>
80104f66:	83 c4 10             	add    $0x10,%esp
  }
}
80104f69:	90                   	nop
80104f6a:	c9                   	leave  
80104f6b:	c3                   	ret    

80104f6c <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104f6c:	55                   	push   %ebp
80104f6d:	89 e5                	mov    %esp,%ebp
80104f6f:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f72:	c7 45 fc 94 29 11 80 	movl   $0x80112994,-0x4(%ebp)
80104f79:	eb 27                	jmp    80104fa2 <wakeup1+0x36>
    if(p->state == SLEEPING && p->chan == chan)
80104f7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f7e:	8b 40 0c             	mov    0xc(%eax),%eax
80104f81:	83 f8 02             	cmp    $0x2,%eax
80104f84:	75 15                	jne    80104f9b <wakeup1+0x2f>
80104f86:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f89:	8b 40 20             	mov    0x20(%eax),%eax
80104f8c:	39 45 08             	cmp    %eax,0x8(%ebp)
80104f8f:	75 0a                	jne    80104f9b <wakeup1+0x2f>
      p->state = RUNNABLE;
80104f91:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f94:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f9b:	81 45 fc 84 00 00 00 	addl   $0x84,-0x4(%ebp)
80104fa2:	81 7d fc 94 4a 11 80 	cmpl   $0x80114a94,-0x4(%ebp)
80104fa9:	72 d0                	jb     80104f7b <wakeup1+0xf>
}
80104fab:	90                   	nop
80104fac:	c9                   	leave  
80104fad:	c3                   	ret    

80104fae <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104fae:	55                   	push   %ebp
80104faf:	89 e5                	mov    %esp,%ebp
80104fb1:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104fb4:	83 ec 0c             	sub    $0xc,%esp
80104fb7:	68 60 29 11 80       	push   $0x80112960
80104fbc:	e8 0b 02 00 00       	call   801051cc <acquire>
80104fc1:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104fc4:	83 ec 0c             	sub    $0xc,%esp
80104fc7:	ff 75 08             	pushl  0x8(%ebp)
80104fca:	e8 9d ff ff ff       	call   80104f6c <wakeup1>
80104fcf:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104fd2:	83 ec 0c             	sub    $0xc,%esp
80104fd5:	68 60 29 11 80       	push   $0x80112960
80104fda:	e8 54 02 00 00       	call   80105233 <release>
80104fdf:	83 c4 10             	add    $0x10,%esp
}
80104fe2:	90                   	nop
80104fe3:	c9                   	leave  
80104fe4:	c3                   	ret    

80104fe5 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104fe5:	55                   	push   %ebp
80104fe6:	89 e5                	mov    %esp,%ebp
80104fe8:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104feb:	83 ec 0c             	sub    $0xc,%esp
80104fee:	68 60 29 11 80       	push   $0x80112960
80104ff3:	e8 d4 01 00 00       	call   801051cc <acquire>
80104ff8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ffb:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80105002:	eb 48                	jmp    8010504c <kill+0x67>
    if(p->pid == pid){
80105004:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105007:	8b 40 10             	mov    0x10(%eax),%eax
8010500a:	39 45 08             	cmp    %eax,0x8(%ebp)
8010500d:	75 36                	jne    80105045 <kill+0x60>
      p->killed = 1;
8010500f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105012:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80105019:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010501c:	8b 40 0c             	mov    0xc(%eax),%eax
8010501f:	83 f8 02             	cmp    $0x2,%eax
80105022:	75 0a                	jne    8010502e <kill+0x49>
        p->state = RUNNABLE;
80105024:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105027:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
8010502e:	83 ec 0c             	sub    $0xc,%esp
80105031:	68 60 29 11 80       	push   $0x80112960
80105036:	e8 f8 01 00 00       	call   80105233 <release>
8010503b:	83 c4 10             	add    $0x10,%esp
      return 0;
8010503e:	b8 00 00 00 00       	mov    $0x0,%eax
80105043:	eb 25                	jmp    8010506a <kill+0x85>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105045:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
8010504c:	81 7d f4 94 4a 11 80 	cmpl   $0x80114a94,-0xc(%ebp)
80105053:	72 af                	jb     80105004 <kill+0x1f>
    }
  }
  release(&ptable.lock);
80105055:	83 ec 0c             	sub    $0xc,%esp
80105058:	68 60 29 11 80       	push   $0x80112960
8010505d:	e8 d1 01 00 00       	call   80105233 <release>
80105062:	83 c4 10             	add    $0x10,%esp
  return -1;
80105065:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010506a:	c9                   	leave  
8010506b:	c3                   	ret    

8010506c <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
8010506c:	55                   	push   %ebp
8010506d:	89 e5                	mov    %esp,%ebp
8010506f:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105072:	c7 45 f0 94 29 11 80 	movl   $0x80112994,-0x10(%ebp)
80105079:	e9 e4 00 00 00       	jmp    80105162 <procdump+0xf6>
    if(p->state == UNUSED)
8010507e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105081:	8b 40 0c             	mov    0xc(%eax),%eax
80105084:	85 c0                	test   %eax,%eax
80105086:	0f 84 ce 00 00 00    	je     8010515a <procdump+0xee>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010508c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010508f:	8b 40 0c             	mov    0xc(%eax),%eax
80105092:	83 f8 05             	cmp    $0x5,%eax
80105095:	77 23                	ja     801050ba <procdump+0x4e>
80105097:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010509a:	8b 40 0c             	mov    0xc(%eax),%eax
8010509d:	8b 04 85 10 b0 10 80 	mov    -0x7fef4ff0(,%eax,4),%eax
801050a4:	85 c0                	test   %eax,%eax
801050a6:	74 12                	je     801050ba <procdump+0x4e>
      state = states[p->state];
801050a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801050ab:	8b 40 0c             	mov    0xc(%eax),%eax
801050ae:	8b 04 85 10 b0 10 80 	mov    -0x7fef4ff0(,%eax,4),%eax
801050b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
801050b8:	eb 07                	jmp    801050c1 <procdump+0x55>
    else
      state = "???";
801050ba:	c7 45 ec 53 8b 10 80 	movl   $0x80108b53,-0x14(%ebp)
    cprintf("%d %d %s %s", p->pid, p->passada, state, p->name);
801050c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801050c4:	8d 48 74             	lea    0x74(%eax),%ecx
801050c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801050ca:	8b 50 70             	mov    0x70(%eax),%edx
801050cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801050d0:	8b 40 10             	mov    0x10(%eax),%eax
801050d3:	83 ec 0c             	sub    $0xc,%esp
801050d6:	51                   	push   %ecx
801050d7:	ff 75 ec             	pushl  -0x14(%ebp)
801050da:	52                   	push   %edx
801050db:	50                   	push   %eax
801050dc:	68 57 8b 10 80       	push   $0x80108b57
801050e1:	e8 de b2 ff ff       	call   801003c4 <cprintf>
801050e6:	83 c4 20             	add    $0x20,%esp
    if(p->state == SLEEPING){
801050e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801050ec:	8b 40 0c             	mov    0xc(%eax),%eax
801050ef:	83 f8 02             	cmp    $0x2,%eax
801050f2:	75 54                	jne    80105148 <procdump+0xdc>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801050f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801050f7:	8b 40 1c             	mov    0x1c(%eax),%eax
801050fa:	8b 40 0c             	mov    0xc(%eax),%eax
801050fd:	83 c0 08             	add    $0x8,%eax
80105100:	89 c2                	mov    %eax,%edx
80105102:	83 ec 08             	sub    $0x8,%esp
80105105:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105108:	50                   	push   %eax
80105109:	52                   	push   %edx
8010510a:	e8 76 01 00 00       	call   80105285 <getcallerpcs>
8010510f:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80105112:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80105119:	eb 1c                	jmp    80105137 <procdump+0xcb>
        cprintf(" %p", pc[i]);
8010511b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010511e:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80105122:	83 ec 08             	sub    $0x8,%esp
80105125:	50                   	push   %eax
80105126:	68 63 8b 10 80       	push   $0x80108b63
8010512b:	e8 94 b2 ff ff       	call   801003c4 <cprintf>
80105130:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80105133:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80105137:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010513b:	7f 0b                	jg     80105148 <procdump+0xdc>
8010513d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105140:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80105144:	85 c0                	test   %eax,%eax
80105146:	75 d3                	jne    8010511b <procdump+0xaf>
    }
    cprintf("\n");
80105148:	83 ec 0c             	sub    $0xc,%esp
8010514b:	68 67 8b 10 80       	push   $0x80108b67
80105150:	e8 6f b2 ff ff       	call   801003c4 <cprintf>
80105155:	83 c4 10             	add    $0x10,%esp
80105158:	eb 01                	jmp    8010515b <procdump+0xef>
      continue;
8010515a:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010515b:	81 45 f0 84 00 00 00 	addl   $0x84,-0x10(%ebp)
80105162:	81 7d f0 94 4a 11 80 	cmpl   $0x80114a94,-0x10(%ebp)
80105169:	0f 82 0f ff ff ff    	jb     8010507e <procdump+0x12>
  }
}
8010516f:	90                   	nop
80105170:	c9                   	leave  
80105171:	c3                   	ret    

80105172 <readeflags>:
{
80105172:	55                   	push   %ebp
80105173:	89 e5                	mov    %esp,%ebp
80105175:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105178:	9c                   	pushf  
80105179:	58                   	pop    %eax
8010517a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010517d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105180:	c9                   	leave  
80105181:	c3                   	ret    

80105182 <cli>:
{
80105182:	55                   	push   %ebp
80105183:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80105185:	fa                   	cli    
}
80105186:	90                   	nop
80105187:	5d                   	pop    %ebp
80105188:	c3                   	ret    

80105189 <sti>:
{
80105189:	55                   	push   %ebp
8010518a:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
8010518c:	fb                   	sti    
}
8010518d:	90                   	nop
8010518e:	5d                   	pop    %ebp
8010518f:	c3                   	ret    

80105190 <xchg>:
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	83 ec 10             	sub    $0x10,%esp
  asm volatile("lock; xchgl %0, %1" :
80105196:	8b 55 08             	mov    0x8(%ebp),%edx
80105199:	8b 45 0c             	mov    0xc(%ebp),%eax
8010519c:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010519f:	f0 87 02             	lock xchg %eax,(%edx)
801051a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return result;
801051a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801051a8:	c9                   	leave  
801051a9:	c3                   	ret    

801051aa <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801051aa:	55                   	push   %ebp
801051ab:	89 e5                	mov    %esp,%ebp
  lk->name = name;
801051ad:	8b 45 08             	mov    0x8(%ebp),%eax
801051b0:	8b 55 0c             	mov    0xc(%ebp),%edx
801051b3:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
801051b6:	8b 45 08             	mov    0x8(%ebp),%eax
801051b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
801051bf:	8b 45 08             	mov    0x8(%ebp),%eax
801051c2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801051c9:	90                   	nop
801051ca:	5d                   	pop    %ebp
801051cb:	c3                   	ret    

801051cc <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801051cc:	55                   	push   %ebp
801051cd:	89 e5                	mov    %esp,%ebp
801051cf:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801051d2:	e8 52 01 00 00       	call   80105329 <pushcli>
  if(holding(lk))
801051d7:	8b 45 08             	mov    0x8(%ebp),%eax
801051da:	83 ec 0c             	sub    $0xc,%esp
801051dd:	50                   	push   %eax
801051de:	e8 1c 01 00 00       	call   801052ff <holding>
801051e3:	83 c4 10             	add    $0x10,%esp
801051e6:	85 c0                	test   %eax,%eax
801051e8:	74 0d                	je     801051f7 <acquire+0x2b>
    panic("acquire");
801051ea:	83 ec 0c             	sub    $0xc,%esp
801051ed:	68 93 8b 10 80       	push   $0x80108b93
801051f2:	e8 70 b3 ff ff       	call   80100567 <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
801051f7:	90                   	nop
801051f8:	8b 45 08             	mov    0x8(%ebp),%eax
801051fb:	83 ec 08             	sub    $0x8,%esp
801051fe:	6a 01                	push   $0x1
80105200:	50                   	push   %eax
80105201:	e8 8a ff ff ff       	call   80105190 <xchg>
80105206:	83 c4 10             	add    $0x10,%esp
80105209:	85 c0                	test   %eax,%eax
8010520b:	75 eb                	jne    801051f8 <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
8010520d:	8b 45 08             	mov    0x8(%ebp),%eax
80105210:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105217:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
8010521a:	8b 45 08             	mov    0x8(%ebp),%eax
8010521d:	83 c0 0c             	add    $0xc,%eax
80105220:	83 ec 08             	sub    $0x8,%esp
80105223:	50                   	push   %eax
80105224:	8d 45 08             	lea    0x8(%ebp),%eax
80105227:	50                   	push   %eax
80105228:	e8 58 00 00 00       	call   80105285 <getcallerpcs>
8010522d:	83 c4 10             	add    $0x10,%esp
}
80105230:	90                   	nop
80105231:	c9                   	leave  
80105232:	c3                   	ret    

80105233 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80105233:	55                   	push   %ebp
80105234:	89 e5                	mov    %esp,%ebp
80105236:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80105239:	83 ec 0c             	sub    $0xc,%esp
8010523c:	ff 75 08             	pushl  0x8(%ebp)
8010523f:	e8 bb 00 00 00       	call   801052ff <holding>
80105244:	83 c4 10             	add    $0x10,%esp
80105247:	85 c0                	test   %eax,%eax
80105249:	75 0d                	jne    80105258 <release+0x25>
    panic("release");
8010524b:	83 ec 0c             	sub    $0xc,%esp
8010524e:	68 9b 8b 10 80       	push   $0x80108b9b
80105253:	e8 0f b3 ff ff       	call   80100567 <panic>

  lk->pcs[0] = 0;
80105258:	8b 45 08             	mov    0x8(%ebp),%eax
8010525b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80105262:	8b 45 08             	mov    0x8(%ebp),%eax
80105265:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
8010526c:	8b 45 08             	mov    0x8(%ebp),%eax
8010526f:	83 ec 08             	sub    $0x8,%esp
80105272:	6a 00                	push   $0x0
80105274:	50                   	push   %eax
80105275:	e8 16 ff ff ff       	call   80105190 <xchg>
8010527a:	83 c4 10             	add    $0x10,%esp

  popcli();
8010527d:	e8 ec 00 00 00       	call   8010536e <popcli>
}
80105282:	90                   	nop
80105283:	c9                   	leave  
80105284:	c3                   	ret    

80105285 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105285:	55                   	push   %ebp
80105286:	89 e5                	mov    %esp,%ebp
80105288:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
8010528b:	8b 45 08             	mov    0x8(%ebp),%eax
8010528e:	83 e8 08             	sub    $0x8,%eax
80105291:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80105294:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
8010529b:	eb 38                	jmp    801052d5 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010529d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
801052a1:	74 53                	je     801052f6 <getcallerpcs+0x71>
801052a3:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
801052aa:	76 4a                	jbe    801052f6 <getcallerpcs+0x71>
801052ac:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
801052b0:	74 44                	je     801052f6 <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
801052b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
801052b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801052bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801052bf:	01 c2                	add    %eax,%edx
801052c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052c4:	8b 40 04             	mov    0x4(%eax),%eax
801052c7:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
801052c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052cc:	8b 00                	mov    (%eax),%eax
801052ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
801052d1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801052d5:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801052d9:	7e c2                	jle    8010529d <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
801052db:	eb 19                	jmp    801052f6 <getcallerpcs+0x71>
    pcs[i] = 0;
801052dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
801052e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801052e7:	8b 45 0c             	mov    0xc(%ebp),%eax
801052ea:	01 d0                	add    %edx,%eax
801052ec:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801052f2:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801052f6:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801052fa:	7e e1                	jle    801052dd <getcallerpcs+0x58>
}
801052fc:	90                   	nop
801052fd:	c9                   	leave  
801052fe:	c3                   	ret    

801052ff <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801052ff:	55                   	push   %ebp
80105300:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80105302:	8b 45 08             	mov    0x8(%ebp),%eax
80105305:	8b 00                	mov    (%eax),%eax
80105307:	85 c0                	test   %eax,%eax
80105309:	74 17                	je     80105322 <holding+0x23>
8010530b:	8b 45 08             	mov    0x8(%ebp),%eax
8010530e:	8b 50 08             	mov    0x8(%eax),%edx
80105311:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105317:	39 c2                	cmp    %eax,%edx
80105319:	75 07                	jne    80105322 <holding+0x23>
8010531b:	b8 01 00 00 00       	mov    $0x1,%eax
80105320:	eb 05                	jmp    80105327 <holding+0x28>
80105322:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105327:	5d                   	pop    %ebp
80105328:	c3                   	ret    

80105329 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105329:	55                   	push   %ebp
8010532a:	89 e5                	mov    %esp,%ebp
8010532c:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
8010532f:	e8 3e fe ff ff       	call   80105172 <readeflags>
80105334:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80105337:	e8 46 fe ff ff       	call   80105182 <cli>
  if(cpu->ncli++ == 0)
8010533c:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105343:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80105349:	8d 48 01             	lea    0x1(%eax),%ecx
8010534c:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
80105352:	85 c0                	test   %eax,%eax
80105354:	75 15                	jne    8010536b <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
80105356:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010535c:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010535f:	81 e2 00 02 00 00    	and    $0x200,%edx
80105365:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
8010536b:	90                   	nop
8010536c:	c9                   	leave  
8010536d:	c3                   	ret    

8010536e <popcli>:

void
popcli(void)
{
8010536e:	55                   	push   %ebp
8010536f:	89 e5                	mov    %esp,%ebp
80105371:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
80105374:	e8 f9 fd ff ff       	call   80105172 <readeflags>
80105379:	25 00 02 00 00       	and    $0x200,%eax
8010537e:	85 c0                	test   %eax,%eax
80105380:	74 0d                	je     8010538f <popcli+0x21>
    panic("popcli - interruptible");
80105382:	83 ec 0c             	sub    $0xc,%esp
80105385:	68 a3 8b 10 80       	push   $0x80108ba3
8010538a:	e8 d8 b1 ff ff       	call   80100567 <panic>
  if(--cpu->ncli < 0)
8010538f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105395:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
8010539b:	83 ea 01             	sub    $0x1,%edx
8010539e:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
801053a4:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801053aa:	85 c0                	test   %eax,%eax
801053ac:	79 0d                	jns    801053bb <popcli+0x4d>
    panic("popcli");
801053ae:	83 ec 0c             	sub    $0xc,%esp
801053b1:	68 ba 8b 10 80       	push   $0x80108bba
801053b6:	e8 ac b1 ff ff       	call   80100567 <panic>
  if(cpu->ncli == 0 && cpu->intena)
801053bb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801053c1:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801053c7:	85 c0                	test   %eax,%eax
801053c9:	75 15                	jne    801053e0 <popcli+0x72>
801053cb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801053d1:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
801053d7:	85 c0                	test   %eax,%eax
801053d9:	74 05                	je     801053e0 <popcli+0x72>
    sti();
801053db:	e8 a9 fd ff ff       	call   80105189 <sti>
}
801053e0:	90                   	nop
801053e1:	c9                   	leave  
801053e2:	c3                   	ret    

801053e3 <stosb>:
{
801053e3:	55                   	push   %ebp
801053e4:	89 e5                	mov    %esp,%ebp
801053e6:	57                   	push   %edi
801053e7:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
801053e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
801053eb:	8b 55 10             	mov    0x10(%ebp),%edx
801053ee:	8b 45 0c             	mov    0xc(%ebp),%eax
801053f1:	89 cb                	mov    %ecx,%ebx
801053f3:	89 df                	mov    %ebx,%edi
801053f5:	89 d1                	mov    %edx,%ecx
801053f7:	fc                   	cld    
801053f8:	f3 aa                	rep stos %al,%es:(%edi)
801053fa:	89 ca                	mov    %ecx,%edx
801053fc:	89 fb                	mov    %edi,%ebx
801053fe:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105401:	89 55 10             	mov    %edx,0x10(%ebp)
}
80105404:	90                   	nop
80105405:	5b                   	pop    %ebx
80105406:	5f                   	pop    %edi
80105407:	5d                   	pop    %ebp
80105408:	c3                   	ret    

80105409 <stosl>:
{
80105409:	55                   	push   %ebp
8010540a:	89 e5                	mov    %esp,%ebp
8010540c:	57                   	push   %edi
8010540d:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
8010540e:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105411:	8b 55 10             	mov    0x10(%ebp),%edx
80105414:	8b 45 0c             	mov    0xc(%ebp),%eax
80105417:	89 cb                	mov    %ecx,%ebx
80105419:	89 df                	mov    %ebx,%edi
8010541b:	89 d1                	mov    %edx,%ecx
8010541d:	fc                   	cld    
8010541e:	f3 ab                	rep stos %eax,%es:(%edi)
80105420:	89 ca                	mov    %ecx,%edx
80105422:	89 fb                	mov    %edi,%ebx
80105424:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105427:	89 55 10             	mov    %edx,0x10(%ebp)
}
8010542a:	90                   	nop
8010542b:	5b                   	pop    %ebx
8010542c:	5f                   	pop    %edi
8010542d:	5d                   	pop    %ebp
8010542e:	c3                   	ret    

8010542f <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
8010542f:	55                   	push   %ebp
80105430:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
80105432:	8b 45 08             	mov    0x8(%ebp),%eax
80105435:	83 e0 03             	and    $0x3,%eax
80105438:	85 c0                	test   %eax,%eax
8010543a:	75 43                	jne    8010547f <memset+0x50>
8010543c:	8b 45 10             	mov    0x10(%ebp),%eax
8010543f:	83 e0 03             	and    $0x3,%eax
80105442:	85 c0                	test   %eax,%eax
80105444:	75 39                	jne    8010547f <memset+0x50>
    c &= 0xFF;
80105446:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010544d:	8b 45 10             	mov    0x10(%ebp),%eax
80105450:	c1 e8 02             	shr    $0x2,%eax
80105453:	89 c1                	mov    %eax,%ecx
80105455:	8b 45 0c             	mov    0xc(%ebp),%eax
80105458:	c1 e0 18             	shl    $0x18,%eax
8010545b:	89 c2                	mov    %eax,%edx
8010545d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105460:	c1 e0 10             	shl    $0x10,%eax
80105463:	09 c2                	or     %eax,%edx
80105465:	8b 45 0c             	mov    0xc(%ebp),%eax
80105468:	c1 e0 08             	shl    $0x8,%eax
8010546b:	09 d0                	or     %edx,%eax
8010546d:	0b 45 0c             	or     0xc(%ebp),%eax
80105470:	51                   	push   %ecx
80105471:	50                   	push   %eax
80105472:	ff 75 08             	pushl  0x8(%ebp)
80105475:	e8 8f ff ff ff       	call   80105409 <stosl>
8010547a:	83 c4 0c             	add    $0xc,%esp
8010547d:	eb 12                	jmp    80105491 <memset+0x62>
  } else
    stosb(dst, c, n);
8010547f:	8b 45 10             	mov    0x10(%ebp),%eax
80105482:	50                   	push   %eax
80105483:	ff 75 0c             	pushl  0xc(%ebp)
80105486:	ff 75 08             	pushl  0x8(%ebp)
80105489:	e8 55 ff ff ff       	call   801053e3 <stosb>
8010548e:	83 c4 0c             	add    $0xc,%esp
  return dst;
80105491:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105494:	c9                   	leave  
80105495:	c3                   	ret    

80105496 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105496:	55                   	push   %ebp
80105497:	89 e5                	mov    %esp,%ebp
80105499:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
8010549c:	8b 45 08             	mov    0x8(%ebp),%eax
8010549f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
801054a2:	8b 45 0c             	mov    0xc(%ebp),%eax
801054a5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
801054a8:	eb 30                	jmp    801054da <memcmp+0x44>
    if(*s1 != *s2)
801054aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
801054ad:	0f b6 10             	movzbl (%eax),%edx
801054b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
801054b3:	0f b6 00             	movzbl (%eax),%eax
801054b6:	38 c2                	cmp    %al,%dl
801054b8:	74 18                	je     801054d2 <memcmp+0x3c>
      return *s1 - *s2;
801054ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
801054bd:	0f b6 00             	movzbl (%eax),%eax
801054c0:	0f b6 d0             	movzbl %al,%edx
801054c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
801054c6:	0f b6 00             	movzbl (%eax),%eax
801054c9:	0f b6 c0             	movzbl %al,%eax
801054cc:	29 c2                	sub    %eax,%edx
801054ce:	89 d0                	mov    %edx,%eax
801054d0:	eb 1a                	jmp    801054ec <memcmp+0x56>
    s1++, s2++;
801054d2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801054d6:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  while(n-- > 0){
801054da:	8b 45 10             	mov    0x10(%ebp),%eax
801054dd:	8d 50 ff             	lea    -0x1(%eax),%edx
801054e0:	89 55 10             	mov    %edx,0x10(%ebp)
801054e3:	85 c0                	test   %eax,%eax
801054e5:	75 c3                	jne    801054aa <memcmp+0x14>
  }

  return 0;
801054e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
801054ec:	c9                   	leave  
801054ed:	c3                   	ret    

801054ee <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801054ee:	55                   	push   %ebp
801054ef:	89 e5                	mov    %esp,%ebp
801054f1:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
801054f4:	8b 45 0c             	mov    0xc(%ebp),%eax
801054f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
801054fa:	8b 45 08             	mov    0x8(%ebp),%eax
801054fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80105500:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105503:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105506:	73 54                	jae    8010555c <memmove+0x6e>
80105508:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010550b:	8b 45 10             	mov    0x10(%ebp),%eax
8010550e:	01 d0                	add    %edx,%eax
80105510:	39 45 f8             	cmp    %eax,-0x8(%ebp)
80105513:	73 47                	jae    8010555c <memmove+0x6e>
    s += n;
80105515:	8b 45 10             	mov    0x10(%ebp),%eax
80105518:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
8010551b:	8b 45 10             	mov    0x10(%ebp),%eax
8010551e:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80105521:	eb 13                	jmp    80105536 <memmove+0x48>
      *--d = *--s;
80105523:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80105527:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
8010552b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010552e:	0f b6 10             	movzbl (%eax),%edx
80105531:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105534:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
80105536:	8b 45 10             	mov    0x10(%ebp),%eax
80105539:	8d 50 ff             	lea    -0x1(%eax),%edx
8010553c:	89 55 10             	mov    %edx,0x10(%ebp)
8010553f:	85 c0                	test   %eax,%eax
80105541:	75 e0                	jne    80105523 <memmove+0x35>
  if(s < d && s + n > d){
80105543:	eb 24                	jmp    80105569 <memmove+0x7b>
  } else
    while(n-- > 0)
      *d++ = *s++;
80105545:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105548:	8d 42 01             	lea    0x1(%edx),%eax
8010554b:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010554e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105551:	8d 48 01             	lea    0x1(%eax),%ecx
80105554:	89 4d f8             	mov    %ecx,-0x8(%ebp)
80105557:	0f b6 12             	movzbl (%edx),%edx
8010555a:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
8010555c:	8b 45 10             	mov    0x10(%ebp),%eax
8010555f:	8d 50 ff             	lea    -0x1(%eax),%edx
80105562:	89 55 10             	mov    %edx,0x10(%ebp)
80105565:	85 c0                	test   %eax,%eax
80105567:	75 dc                	jne    80105545 <memmove+0x57>

  return dst;
80105569:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010556c:	c9                   	leave  
8010556d:	c3                   	ret    

8010556e <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
8010556e:	55                   	push   %ebp
8010556f:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
80105571:	ff 75 10             	pushl  0x10(%ebp)
80105574:	ff 75 0c             	pushl  0xc(%ebp)
80105577:	ff 75 08             	pushl  0x8(%ebp)
8010557a:	e8 6f ff ff ff       	call   801054ee <memmove>
8010557f:	83 c4 0c             	add    $0xc,%esp
}
80105582:	c9                   	leave  
80105583:	c3                   	ret    

80105584 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105584:	55                   	push   %ebp
80105585:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
80105587:	eb 0c                	jmp    80105595 <strncmp+0x11>
    n--, p++, q++;
80105589:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010558d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105591:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(n > 0 && *p && *p == *q)
80105595:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105599:	74 1a                	je     801055b5 <strncmp+0x31>
8010559b:	8b 45 08             	mov    0x8(%ebp),%eax
8010559e:	0f b6 00             	movzbl (%eax),%eax
801055a1:	84 c0                	test   %al,%al
801055a3:	74 10                	je     801055b5 <strncmp+0x31>
801055a5:	8b 45 08             	mov    0x8(%ebp),%eax
801055a8:	0f b6 10             	movzbl (%eax),%edx
801055ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801055ae:	0f b6 00             	movzbl (%eax),%eax
801055b1:	38 c2                	cmp    %al,%dl
801055b3:	74 d4                	je     80105589 <strncmp+0x5>
  if(n == 0)
801055b5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801055b9:	75 07                	jne    801055c2 <strncmp+0x3e>
    return 0;
801055bb:	b8 00 00 00 00       	mov    $0x0,%eax
801055c0:	eb 16                	jmp    801055d8 <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
801055c2:	8b 45 08             	mov    0x8(%ebp),%eax
801055c5:	0f b6 00             	movzbl (%eax),%eax
801055c8:	0f b6 d0             	movzbl %al,%edx
801055cb:	8b 45 0c             	mov    0xc(%ebp),%eax
801055ce:	0f b6 00             	movzbl (%eax),%eax
801055d1:	0f b6 c0             	movzbl %al,%eax
801055d4:	29 c2                	sub    %eax,%edx
801055d6:	89 d0                	mov    %edx,%eax
}
801055d8:	5d                   	pop    %ebp
801055d9:	c3                   	ret    

801055da <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801055da:	55                   	push   %ebp
801055db:	89 e5                	mov    %esp,%ebp
801055dd:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801055e0:	8b 45 08             	mov    0x8(%ebp),%eax
801055e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
801055e6:	90                   	nop
801055e7:	8b 45 10             	mov    0x10(%ebp),%eax
801055ea:	8d 50 ff             	lea    -0x1(%eax),%edx
801055ed:	89 55 10             	mov    %edx,0x10(%ebp)
801055f0:	85 c0                	test   %eax,%eax
801055f2:	7e 2c                	jle    80105620 <strncpy+0x46>
801055f4:	8b 55 0c             	mov    0xc(%ebp),%edx
801055f7:	8d 42 01             	lea    0x1(%edx),%eax
801055fa:	89 45 0c             	mov    %eax,0xc(%ebp)
801055fd:	8b 45 08             	mov    0x8(%ebp),%eax
80105600:	8d 48 01             	lea    0x1(%eax),%ecx
80105603:	89 4d 08             	mov    %ecx,0x8(%ebp)
80105606:	0f b6 12             	movzbl (%edx),%edx
80105609:	88 10                	mov    %dl,(%eax)
8010560b:	0f b6 00             	movzbl (%eax),%eax
8010560e:	84 c0                	test   %al,%al
80105610:	75 d5                	jne    801055e7 <strncpy+0xd>
    ;
  while(n-- > 0)
80105612:	eb 0c                	jmp    80105620 <strncpy+0x46>
    *s++ = 0;
80105614:	8b 45 08             	mov    0x8(%ebp),%eax
80105617:	8d 50 01             	lea    0x1(%eax),%edx
8010561a:	89 55 08             	mov    %edx,0x8(%ebp)
8010561d:	c6 00 00             	movb   $0x0,(%eax)
  while(n-- > 0)
80105620:	8b 45 10             	mov    0x10(%ebp),%eax
80105623:	8d 50 ff             	lea    -0x1(%eax),%edx
80105626:	89 55 10             	mov    %edx,0x10(%ebp)
80105629:	85 c0                	test   %eax,%eax
8010562b:	7f e7                	jg     80105614 <strncpy+0x3a>
  return os;
8010562d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105630:	c9                   	leave  
80105631:	c3                   	ret    

80105632 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105632:	55                   	push   %ebp
80105633:	89 e5                	mov    %esp,%ebp
80105635:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105638:	8b 45 08             	mov    0x8(%ebp),%eax
8010563b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
8010563e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105642:	7f 05                	jg     80105649 <safestrcpy+0x17>
    return os;
80105644:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105647:	eb 31                	jmp    8010567a <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
80105649:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010564d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105651:	7e 1e                	jle    80105671 <safestrcpy+0x3f>
80105653:	8b 55 0c             	mov    0xc(%ebp),%edx
80105656:	8d 42 01             	lea    0x1(%edx),%eax
80105659:	89 45 0c             	mov    %eax,0xc(%ebp)
8010565c:	8b 45 08             	mov    0x8(%ebp),%eax
8010565f:	8d 48 01             	lea    0x1(%eax),%ecx
80105662:	89 4d 08             	mov    %ecx,0x8(%ebp)
80105665:	0f b6 12             	movzbl (%edx),%edx
80105668:	88 10                	mov    %dl,(%eax)
8010566a:	0f b6 00             	movzbl (%eax),%eax
8010566d:	84 c0                	test   %al,%al
8010566f:	75 d8                	jne    80105649 <safestrcpy+0x17>
    ;
  *s = 0;
80105671:	8b 45 08             	mov    0x8(%ebp),%eax
80105674:	c6 00 00             	movb   $0x0,(%eax)
  return os;
80105677:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010567a:	c9                   	leave  
8010567b:	c3                   	ret    

8010567c <strlen>:

int
strlen(const char *s)
{
8010567c:	55                   	push   %ebp
8010567d:	89 e5                	mov    %esp,%ebp
8010567f:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80105682:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105689:	eb 04                	jmp    8010568f <strlen+0x13>
8010568b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010568f:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105692:	8b 45 08             	mov    0x8(%ebp),%eax
80105695:	01 d0                	add    %edx,%eax
80105697:	0f b6 00             	movzbl (%eax),%eax
8010569a:	84 c0                	test   %al,%al
8010569c:	75 ed                	jne    8010568b <strlen+0xf>
    ;
  return n;
8010569e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801056a1:	c9                   	leave  
801056a2:	c3                   	ret    

801056a3 <swtch>:
801056a3:	8b 44 24 04          	mov    0x4(%esp),%eax
801056a7:	8b 54 24 08          	mov    0x8(%esp),%edx
801056ab:	55                   	push   %ebp
801056ac:	53                   	push   %ebx
801056ad:	56                   	push   %esi
801056ae:	57                   	push   %edi
801056af:	89 20                	mov    %esp,(%eax)
801056b1:	89 d4                	mov    %edx,%esp
801056b3:	5f                   	pop    %edi
801056b4:	5e                   	pop    %esi
801056b5:	5b                   	pop    %ebx
801056b6:	5d                   	pop    %ebp
801056b7:	c3                   	ret    

801056b8 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801056b8:	55                   	push   %ebp
801056b9:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
801056bb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056c1:	8b 00                	mov    (%eax),%eax
801056c3:	39 45 08             	cmp    %eax,0x8(%ebp)
801056c6:	73 12                	jae    801056da <fetchint+0x22>
801056c8:	8b 45 08             	mov    0x8(%ebp),%eax
801056cb:	8d 50 04             	lea    0x4(%eax),%edx
801056ce:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056d4:	8b 00                	mov    (%eax),%eax
801056d6:	39 c2                	cmp    %eax,%edx
801056d8:	76 07                	jbe    801056e1 <fetchint+0x29>
    return -1;
801056da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056df:	eb 0f                	jmp    801056f0 <fetchint+0x38>
  *ip = *(int*)(addr);
801056e1:	8b 45 08             	mov    0x8(%ebp),%eax
801056e4:	8b 10                	mov    (%eax),%edx
801056e6:	8b 45 0c             	mov    0xc(%ebp),%eax
801056e9:	89 10                	mov    %edx,(%eax)
  return 0;
801056eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
801056f0:	5d                   	pop    %ebp
801056f1:	c3                   	ret    

801056f2 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801056f2:	55                   	push   %ebp
801056f3:	89 e5                	mov    %esp,%ebp
801056f5:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
801056f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056fe:	8b 00                	mov    (%eax),%eax
80105700:	39 45 08             	cmp    %eax,0x8(%ebp)
80105703:	72 07                	jb     8010570c <fetchstr+0x1a>
    return -1;
80105705:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010570a:	eb 46                	jmp    80105752 <fetchstr+0x60>
  *pp = (char*)addr;
8010570c:	8b 55 08             	mov    0x8(%ebp),%edx
8010570f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105712:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
80105714:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010571a:	8b 00                	mov    (%eax),%eax
8010571c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
8010571f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105722:	8b 00                	mov    (%eax),%eax
80105724:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105727:	eb 1c                	jmp    80105745 <fetchstr+0x53>
    if(*s == 0)
80105729:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010572c:	0f b6 00             	movzbl (%eax),%eax
8010572f:	84 c0                	test   %al,%al
80105731:	75 0e                	jne    80105741 <fetchstr+0x4f>
      return s - *pp;
80105733:	8b 45 0c             	mov    0xc(%ebp),%eax
80105736:	8b 00                	mov    (%eax),%eax
80105738:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010573b:	29 c2                	sub    %eax,%edx
8010573d:	89 d0                	mov    %edx,%eax
8010573f:	eb 11                	jmp    80105752 <fetchstr+0x60>
  for(s = *pp; s < ep; s++)
80105741:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105745:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105748:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010574b:	72 dc                	jb     80105729 <fetchstr+0x37>
  return -1;
8010574d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105752:	c9                   	leave  
80105753:	c3                   	ret    

80105754 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105754:	55                   	push   %ebp
80105755:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80105757:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010575d:	8b 40 18             	mov    0x18(%eax),%eax
80105760:	8b 40 44             	mov    0x44(%eax),%eax
80105763:	8b 55 08             	mov    0x8(%ebp),%edx
80105766:	c1 e2 02             	shl    $0x2,%edx
80105769:	01 d0                	add    %edx,%eax
8010576b:	83 c0 04             	add    $0x4,%eax
8010576e:	ff 75 0c             	pushl  0xc(%ebp)
80105771:	50                   	push   %eax
80105772:	e8 41 ff ff ff       	call   801056b8 <fetchint>
80105777:	83 c4 08             	add    $0x8,%esp
}
8010577a:	c9                   	leave  
8010577b:	c3                   	ret    

8010577c <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
8010577c:	55                   	push   %ebp
8010577d:	89 e5                	mov    %esp,%ebp
8010577f:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
80105782:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105785:	50                   	push   %eax
80105786:	ff 75 08             	pushl  0x8(%ebp)
80105789:	e8 c6 ff ff ff       	call   80105754 <argint>
8010578e:	83 c4 08             	add    $0x8,%esp
80105791:	85 c0                	test   %eax,%eax
80105793:	79 07                	jns    8010579c <argptr+0x20>
    return -1;
80105795:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010579a:	eb 3b                	jmp    801057d7 <argptr+0x5b>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
8010579c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057a2:	8b 00                	mov    (%eax),%eax
801057a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
801057a7:	39 d0                	cmp    %edx,%eax
801057a9:	76 16                	jbe    801057c1 <argptr+0x45>
801057ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
801057ae:	89 c2                	mov    %eax,%edx
801057b0:	8b 45 10             	mov    0x10(%ebp),%eax
801057b3:	01 c2                	add    %eax,%edx
801057b5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057bb:	8b 00                	mov    (%eax),%eax
801057bd:	39 c2                	cmp    %eax,%edx
801057bf:	76 07                	jbe    801057c8 <argptr+0x4c>
    return -1;
801057c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057c6:	eb 0f                	jmp    801057d7 <argptr+0x5b>
  *pp = (char*)i;
801057c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
801057cb:	89 c2                	mov    %eax,%edx
801057cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801057d0:	89 10                	mov    %edx,(%eax)
  return 0;
801057d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801057d7:	c9                   	leave  
801057d8:	c3                   	ret    

801057d9 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801057d9:	55                   	push   %ebp
801057da:	89 e5                	mov    %esp,%ebp
801057dc:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
801057df:	8d 45 fc             	lea    -0x4(%ebp),%eax
801057e2:	50                   	push   %eax
801057e3:	ff 75 08             	pushl  0x8(%ebp)
801057e6:	e8 69 ff ff ff       	call   80105754 <argint>
801057eb:	83 c4 08             	add    $0x8,%esp
801057ee:	85 c0                	test   %eax,%eax
801057f0:	79 07                	jns    801057f9 <argstr+0x20>
    return -1;
801057f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057f7:	eb 0f                	jmp    80105808 <argstr+0x2f>
  return fetchstr(addr, pp);
801057f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801057fc:	ff 75 0c             	pushl  0xc(%ebp)
801057ff:	50                   	push   %eax
80105800:	e8 ed fe ff ff       	call   801056f2 <fetchstr>
80105805:	83 c4 08             	add    $0x8,%esp
}
80105808:	c9                   	leave  
80105809:	c3                   	ret    

8010580a <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
8010580a:	55                   	push   %ebp
8010580b:	89 e5                	mov    %esp,%ebp
8010580d:	83 ec 18             	sub    $0x18,%esp
  int num;

  num = proc->tf->eax;
80105810:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105816:	8b 40 18             	mov    0x18(%eax),%eax
80105819:	8b 40 1c             	mov    0x1c(%eax),%eax
8010581c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010581f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105823:	7e 32                	jle    80105857 <syscall+0x4d>
80105825:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105828:	83 f8 15             	cmp    $0x15,%eax
8010582b:	77 2a                	ja     80105857 <syscall+0x4d>
8010582d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105830:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105837:	85 c0                	test   %eax,%eax
80105839:	74 1c                	je     80105857 <syscall+0x4d>
    proc->tf->eax = syscalls[num]();
8010583b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010583e:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105845:	ff d0                	call   *%eax
80105847:	89 c2                	mov    %eax,%edx
80105849:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010584f:	8b 40 18             	mov    0x18(%eax),%eax
80105852:	89 50 1c             	mov    %edx,0x1c(%eax)
80105855:	eb 34                	jmp    8010588b <syscall+0x81>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
80105857:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010585d:	8d 50 74             	lea    0x74(%eax),%edx
80105860:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    cprintf("%d %s: unknown sys call %d\n",
80105866:	8b 40 10             	mov    0x10(%eax),%eax
80105869:	ff 75 f4             	pushl  -0xc(%ebp)
8010586c:	52                   	push   %edx
8010586d:	50                   	push   %eax
8010586e:	68 c1 8b 10 80       	push   $0x80108bc1
80105873:	e8 4c ab ff ff       	call   801003c4 <cprintf>
80105878:	83 c4 10             	add    $0x10,%esp
    proc->tf->eax = -1;
8010587b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105881:	8b 40 18             	mov    0x18(%eax),%eax
80105884:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
8010588b:	90                   	nop
8010588c:	c9                   	leave  
8010588d:	c3                   	ret    

8010588e <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
8010588e:	55                   	push   %ebp
8010588f:	89 e5                	mov    %esp,%ebp
80105891:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105894:	83 ec 08             	sub    $0x8,%esp
80105897:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010589a:	50                   	push   %eax
8010589b:	ff 75 08             	pushl  0x8(%ebp)
8010589e:	e8 b1 fe ff ff       	call   80105754 <argint>
801058a3:	83 c4 10             	add    $0x10,%esp
801058a6:	85 c0                	test   %eax,%eax
801058a8:	79 07                	jns    801058b1 <argfd+0x23>
    return -1;
801058aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058af:	eb 50                	jmp    80105901 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
801058b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058b4:	85 c0                	test   %eax,%eax
801058b6:	78 21                	js     801058d9 <argfd+0x4b>
801058b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058bb:	83 f8 0f             	cmp    $0xf,%eax
801058be:	7f 19                	jg     801058d9 <argfd+0x4b>
801058c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058c6:	8b 55 f0             	mov    -0x10(%ebp),%edx
801058c9:	83 c2 08             	add    $0x8,%edx
801058cc:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801058d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801058d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801058d7:	75 07                	jne    801058e0 <argfd+0x52>
    return -1;
801058d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058de:	eb 21                	jmp    80105901 <argfd+0x73>
  if(pfd)
801058e0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801058e4:	74 08                	je     801058ee <argfd+0x60>
    *pfd = fd;
801058e6:	8b 55 f0             	mov    -0x10(%ebp),%edx
801058e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801058ec:	89 10                	mov    %edx,(%eax)
  if(pf)
801058ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801058f2:	74 08                	je     801058fc <argfd+0x6e>
    *pf = f;
801058f4:	8b 45 10             	mov    0x10(%ebp),%eax
801058f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058fa:	89 10                	mov    %edx,(%eax)
  return 0;
801058fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105901:	c9                   	leave  
80105902:	c3                   	ret    

80105903 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80105903:	55                   	push   %ebp
80105904:	89 e5                	mov    %esp,%ebp
80105906:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105909:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105910:	eb 30                	jmp    80105942 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
80105912:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105918:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010591b:	83 c2 08             	add    $0x8,%edx
8010591e:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105922:	85 c0                	test   %eax,%eax
80105924:	75 18                	jne    8010593e <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105926:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010592c:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010592f:	8d 4a 08             	lea    0x8(%edx),%ecx
80105932:	8b 55 08             	mov    0x8(%ebp),%edx
80105935:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80105939:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010593c:	eb 0f                	jmp    8010594d <fdalloc+0x4a>
  for(fd = 0; fd < NOFILE; fd++){
8010593e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105942:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105946:	7e ca                	jle    80105912 <fdalloc+0xf>
    }
  }
  return -1;
80105948:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010594d:	c9                   	leave  
8010594e:	c3                   	ret    

8010594f <sys_dup>:

int
sys_dup(void)
{
8010594f:	55                   	push   %ebp
80105950:	89 e5                	mov    %esp,%ebp
80105952:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
80105955:	83 ec 04             	sub    $0x4,%esp
80105958:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010595b:	50                   	push   %eax
8010595c:	6a 00                	push   $0x0
8010595e:	6a 00                	push   $0x0
80105960:	e8 29 ff ff ff       	call   8010588e <argfd>
80105965:	83 c4 10             	add    $0x10,%esp
80105968:	85 c0                	test   %eax,%eax
8010596a:	79 07                	jns    80105973 <sys_dup+0x24>
    return -1;
8010596c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105971:	eb 31                	jmp    801059a4 <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80105973:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105976:	83 ec 0c             	sub    $0xc,%esp
80105979:	50                   	push   %eax
8010597a:	e8 84 ff ff ff       	call   80105903 <fdalloc>
8010597f:	83 c4 10             	add    $0x10,%esp
80105982:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105985:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105989:	79 07                	jns    80105992 <sys_dup+0x43>
    return -1;
8010598b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105990:	eb 12                	jmp    801059a4 <sys_dup+0x55>
  filedup(f);
80105992:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105995:	83 ec 0c             	sub    $0xc,%esp
80105998:	50                   	push   %eax
80105999:	e8 6d b6 ff ff       	call   8010100b <filedup>
8010599e:	83 c4 10             	add    $0x10,%esp
  return fd;
801059a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801059a4:	c9                   	leave  
801059a5:	c3                   	ret    

801059a6 <sys_read>:

int
sys_read(void)
{
801059a6:	55                   	push   %ebp
801059a7:	89 e5                	mov    %esp,%ebp
801059a9:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801059ac:	83 ec 04             	sub    $0x4,%esp
801059af:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059b2:	50                   	push   %eax
801059b3:	6a 00                	push   $0x0
801059b5:	6a 00                	push   $0x0
801059b7:	e8 d2 fe ff ff       	call   8010588e <argfd>
801059bc:	83 c4 10             	add    $0x10,%esp
801059bf:	85 c0                	test   %eax,%eax
801059c1:	78 2e                	js     801059f1 <sys_read+0x4b>
801059c3:	83 ec 08             	sub    $0x8,%esp
801059c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059c9:	50                   	push   %eax
801059ca:	6a 02                	push   $0x2
801059cc:	e8 83 fd ff ff       	call   80105754 <argint>
801059d1:	83 c4 10             	add    $0x10,%esp
801059d4:	85 c0                	test   %eax,%eax
801059d6:	78 19                	js     801059f1 <sys_read+0x4b>
801059d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059db:	83 ec 04             	sub    $0x4,%esp
801059de:	50                   	push   %eax
801059df:	8d 45 ec             	lea    -0x14(%ebp),%eax
801059e2:	50                   	push   %eax
801059e3:	6a 01                	push   $0x1
801059e5:	e8 92 fd ff ff       	call   8010577c <argptr>
801059ea:	83 c4 10             	add    $0x10,%esp
801059ed:	85 c0                	test   %eax,%eax
801059ef:	79 07                	jns    801059f8 <sys_read+0x52>
    return -1;
801059f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059f6:	eb 17                	jmp    80105a0f <sys_read+0x69>
  return fileread(f, p, n);
801059f8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801059fb:	8b 55 ec             	mov    -0x14(%ebp),%edx
801059fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a01:	83 ec 04             	sub    $0x4,%esp
80105a04:	51                   	push   %ecx
80105a05:	52                   	push   %edx
80105a06:	50                   	push   %eax
80105a07:	e8 8f b7 ff ff       	call   8010119b <fileread>
80105a0c:	83 c4 10             	add    $0x10,%esp
}
80105a0f:	c9                   	leave  
80105a10:	c3                   	ret    

80105a11 <sys_write>:

int
sys_write(void)
{
80105a11:	55                   	push   %ebp
80105a12:	89 e5                	mov    %esp,%ebp
80105a14:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105a17:	83 ec 04             	sub    $0x4,%esp
80105a1a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a1d:	50                   	push   %eax
80105a1e:	6a 00                	push   $0x0
80105a20:	6a 00                	push   $0x0
80105a22:	e8 67 fe ff ff       	call   8010588e <argfd>
80105a27:	83 c4 10             	add    $0x10,%esp
80105a2a:	85 c0                	test   %eax,%eax
80105a2c:	78 2e                	js     80105a5c <sys_write+0x4b>
80105a2e:	83 ec 08             	sub    $0x8,%esp
80105a31:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a34:	50                   	push   %eax
80105a35:	6a 02                	push   $0x2
80105a37:	e8 18 fd ff ff       	call   80105754 <argint>
80105a3c:	83 c4 10             	add    $0x10,%esp
80105a3f:	85 c0                	test   %eax,%eax
80105a41:	78 19                	js     80105a5c <sys_write+0x4b>
80105a43:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a46:	83 ec 04             	sub    $0x4,%esp
80105a49:	50                   	push   %eax
80105a4a:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105a4d:	50                   	push   %eax
80105a4e:	6a 01                	push   $0x1
80105a50:	e8 27 fd ff ff       	call   8010577c <argptr>
80105a55:	83 c4 10             	add    $0x10,%esp
80105a58:	85 c0                	test   %eax,%eax
80105a5a:	79 07                	jns    80105a63 <sys_write+0x52>
    return -1;
80105a5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a61:	eb 17                	jmp    80105a7a <sys_write+0x69>
  return filewrite(f, p, n);
80105a63:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105a66:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a6c:	83 ec 04             	sub    $0x4,%esp
80105a6f:	51                   	push   %ecx
80105a70:	52                   	push   %edx
80105a71:	50                   	push   %eax
80105a72:	e8 dc b7 ff ff       	call   80101253 <filewrite>
80105a77:	83 c4 10             	add    $0x10,%esp
}
80105a7a:	c9                   	leave  
80105a7b:	c3                   	ret    

80105a7c <sys_close>:

int
sys_close(void)
{
80105a7c:	55                   	push   %ebp
80105a7d:	89 e5                	mov    %esp,%ebp
80105a7f:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
80105a82:	83 ec 04             	sub    $0x4,%esp
80105a85:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a88:	50                   	push   %eax
80105a89:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a8c:	50                   	push   %eax
80105a8d:	6a 00                	push   $0x0
80105a8f:	e8 fa fd ff ff       	call   8010588e <argfd>
80105a94:	83 c4 10             	add    $0x10,%esp
80105a97:	85 c0                	test   %eax,%eax
80105a99:	79 07                	jns    80105aa2 <sys_close+0x26>
    return -1;
80105a9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105aa0:	eb 28                	jmp    80105aca <sys_close+0x4e>
  proc->ofile[fd] = 0;
80105aa2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105aa8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105aab:	83 c2 08             	add    $0x8,%edx
80105aae:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105ab5:	00 
  fileclose(f);
80105ab6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ab9:	83 ec 0c             	sub    $0xc,%esp
80105abc:	50                   	push   %eax
80105abd:	e8 9a b5 ff ff       	call   8010105c <fileclose>
80105ac2:	83 c4 10             	add    $0x10,%esp
  return 0;
80105ac5:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105aca:	c9                   	leave  
80105acb:	c3                   	ret    

80105acc <sys_fstat>:

int
sys_fstat(void)
{
80105acc:	55                   	push   %ebp
80105acd:	89 e5                	mov    %esp,%ebp
80105acf:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105ad2:	83 ec 04             	sub    $0x4,%esp
80105ad5:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ad8:	50                   	push   %eax
80105ad9:	6a 00                	push   $0x0
80105adb:	6a 00                	push   $0x0
80105add:	e8 ac fd ff ff       	call   8010588e <argfd>
80105ae2:	83 c4 10             	add    $0x10,%esp
80105ae5:	85 c0                	test   %eax,%eax
80105ae7:	78 17                	js     80105b00 <sys_fstat+0x34>
80105ae9:	83 ec 04             	sub    $0x4,%esp
80105aec:	6a 14                	push   $0x14
80105aee:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105af1:	50                   	push   %eax
80105af2:	6a 01                	push   $0x1
80105af4:	e8 83 fc ff ff       	call   8010577c <argptr>
80105af9:	83 c4 10             	add    $0x10,%esp
80105afc:	85 c0                	test   %eax,%eax
80105afe:	79 07                	jns    80105b07 <sys_fstat+0x3b>
    return -1;
80105b00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b05:	eb 13                	jmp    80105b1a <sys_fstat+0x4e>
  return filestat(f, st);
80105b07:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105b0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b0d:	83 ec 08             	sub    $0x8,%esp
80105b10:	52                   	push   %edx
80105b11:	50                   	push   %eax
80105b12:	e8 2d b6 ff ff       	call   80101144 <filestat>
80105b17:	83 c4 10             	add    $0x10,%esp
}
80105b1a:	c9                   	leave  
80105b1b:	c3                   	ret    

80105b1c <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105b1c:	55                   	push   %ebp
80105b1d:	89 e5                	mov    %esp,%ebp
80105b1f:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105b22:	83 ec 08             	sub    $0x8,%esp
80105b25:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105b28:	50                   	push   %eax
80105b29:	6a 00                	push   $0x0
80105b2b:	e8 a9 fc ff ff       	call   801057d9 <argstr>
80105b30:	83 c4 10             	add    $0x10,%esp
80105b33:	85 c0                	test   %eax,%eax
80105b35:	78 15                	js     80105b4c <sys_link+0x30>
80105b37:	83 ec 08             	sub    $0x8,%esp
80105b3a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105b3d:	50                   	push   %eax
80105b3e:	6a 01                	push   $0x1
80105b40:	e8 94 fc ff ff       	call   801057d9 <argstr>
80105b45:	83 c4 10             	add    $0x10,%esp
80105b48:	85 c0                	test   %eax,%eax
80105b4a:	79 0a                	jns    80105b56 <sys_link+0x3a>
    return -1;
80105b4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b51:	e9 68 01 00 00       	jmp    80105cbe <sys_link+0x1a2>

  begin_op();
80105b56:	e8 fb d9 ff ff       	call   80103556 <begin_op>
  if((ip = namei(old)) == 0){
80105b5b:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105b5e:	83 ec 0c             	sub    $0xc,%esp
80105b61:	50                   	push   %eax
80105b62:	e8 c3 c9 ff ff       	call   8010252a <namei>
80105b67:	83 c4 10             	add    $0x10,%esp
80105b6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b6d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b71:	75 0f                	jne    80105b82 <sys_link+0x66>
    end_op();
80105b73:	e8 6a da ff ff       	call   801035e2 <end_op>
    return -1;
80105b78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b7d:	e9 3c 01 00 00       	jmp    80105cbe <sys_link+0x1a2>
  }

  ilock(ip);
80105b82:	83 ec 0c             	sub    $0xc,%esp
80105b85:	ff 75 f4             	pushl  -0xc(%ebp)
80105b88:	e8 e8 bd ff ff       	call   80101975 <ilock>
80105b8d:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105b90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b93:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105b97:	66 83 f8 01          	cmp    $0x1,%ax
80105b9b:	75 1d                	jne    80105bba <sys_link+0x9e>
    iunlockput(ip);
80105b9d:	83 ec 0c             	sub    $0xc,%esp
80105ba0:	ff 75 f4             	pushl  -0xc(%ebp)
80105ba3:	e8 8d c0 ff ff       	call   80101c35 <iunlockput>
80105ba8:	83 c4 10             	add    $0x10,%esp
    end_op();
80105bab:	e8 32 da ff ff       	call   801035e2 <end_op>
    return -1;
80105bb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bb5:	e9 04 01 00 00       	jmp    80105cbe <sys_link+0x1a2>
  }

  ip->nlink++;
80105bba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bbd:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105bc1:	83 c0 01             	add    $0x1,%eax
80105bc4:	89 c2                	mov    %eax,%edx
80105bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bc9:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105bcd:	83 ec 0c             	sub    $0xc,%esp
80105bd0:	ff 75 f4             	pushl  -0xc(%ebp)
80105bd3:	e8 c3 bb ff ff       	call   8010179b <iupdate>
80105bd8:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105bdb:	83 ec 0c             	sub    $0xc,%esp
80105bde:	ff 75 f4             	pushl  -0xc(%ebp)
80105be1:	e8 ed be ff ff       	call   80101ad3 <iunlock>
80105be6:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80105be9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105bec:	83 ec 08             	sub    $0x8,%esp
80105bef:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105bf2:	52                   	push   %edx
80105bf3:	50                   	push   %eax
80105bf4:	e8 4d c9 ff ff       	call   80102546 <nameiparent>
80105bf9:	83 c4 10             	add    $0x10,%esp
80105bfc:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105bff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c03:	74 71                	je     80105c76 <sys_link+0x15a>
    goto bad;
  ilock(dp);
80105c05:	83 ec 0c             	sub    $0xc,%esp
80105c08:	ff 75 f0             	pushl  -0x10(%ebp)
80105c0b:	e8 65 bd ff ff       	call   80101975 <ilock>
80105c10:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105c13:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c16:	8b 10                	mov    (%eax),%edx
80105c18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c1b:	8b 00                	mov    (%eax),%eax
80105c1d:	39 c2                	cmp    %eax,%edx
80105c1f:	75 1d                	jne    80105c3e <sys_link+0x122>
80105c21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c24:	8b 40 04             	mov    0x4(%eax),%eax
80105c27:	83 ec 04             	sub    $0x4,%esp
80105c2a:	50                   	push   %eax
80105c2b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105c2e:	50                   	push   %eax
80105c2f:	ff 75 f0             	pushl  -0x10(%ebp)
80105c32:	e8 5b c6 ff ff       	call   80102292 <dirlink>
80105c37:	83 c4 10             	add    $0x10,%esp
80105c3a:	85 c0                	test   %eax,%eax
80105c3c:	79 10                	jns    80105c4e <sys_link+0x132>
    iunlockput(dp);
80105c3e:	83 ec 0c             	sub    $0xc,%esp
80105c41:	ff 75 f0             	pushl  -0x10(%ebp)
80105c44:	e8 ec bf ff ff       	call   80101c35 <iunlockput>
80105c49:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105c4c:	eb 29                	jmp    80105c77 <sys_link+0x15b>
  }
  iunlockput(dp);
80105c4e:	83 ec 0c             	sub    $0xc,%esp
80105c51:	ff 75 f0             	pushl  -0x10(%ebp)
80105c54:	e8 dc bf ff ff       	call   80101c35 <iunlockput>
80105c59:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80105c5c:	83 ec 0c             	sub    $0xc,%esp
80105c5f:	ff 75 f4             	pushl  -0xc(%ebp)
80105c62:	e8 de be ff ff       	call   80101b45 <iput>
80105c67:	83 c4 10             	add    $0x10,%esp

  end_op();
80105c6a:	e8 73 d9 ff ff       	call   801035e2 <end_op>

  return 0;
80105c6f:	b8 00 00 00 00       	mov    $0x0,%eax
80105c74:	eb 48                	jmp    80105cbe <sys_link+0x1a2>
    goto bad;
80105c76:	90                   	nop

bad:
  ilock(ip);
80105c77:	83 ec 0c             	sub    $0xc,%esp
80105c7a:	ff 75 f4             	pushl  -0xc(%ebp)
80105c7d:	e8 f3 bc ff ff       	call   80101975 <ilock>
80105c82:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80105c85:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c88:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105c8c:	83 e8 01             	sub    $0x1,%eax
80105c8f:	89 c2                	mov    %eax,%edx
80105c91:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c94:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105c98:	83 ec 0c             	sub    $0xc,%esp
80105c9b:	ff 75 f4             	pushl  -0xc(%ebp)
80105c9e:	e8 f8 ba ff ff       	call   8010179b <iupdate>
80105ca3:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105ca6:	83 ec 0c             	sub    $0xc,%esp
80105ca9:	ff 75 f4             	pushl  -0xc(%ebp)
80105cac:	e8 84 bf ff ff       	call   80101c35 <iunlockput>
80105cb1:	83 c4 10             	add    $0x10,%esp
  end_op();
80105cb4:	e8 29 d9 ff ff       	call   801035e2 <end_op>
  return -1;
80105cb9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cbe:	c9                   	leave  
80105cbf:	c3                   	ret    

80105cc0 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105cc0:	55                   	push   %ebp
80105cc1:	89 e5                	mov    %esp,%ebp
80105cc3:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105cc6:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105ccd:	eb 40                	jmp    80105d0f <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105ccf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cd2:	6a 10                	push   $0x10
80105cd4:	50                   	push   %eax
80105cd5:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105cd8:	50                   	push   %eax
80105cd9:	ff 75 08             	pushl  0x8(%ebp)
80105cdc:	e8 fd c1 ff ff       	call   80101ede <readi>
80105ce1:	83 c4 10             	add    $0x10,%esp
80105ce4:	83 f8 10             	cmp    $0x10,%eax
80105ce7:	74 0d                	je     80105cf6 <isdirempty+0x36>
      panic("isdirempty: readi");
80105ce9:	83 ec 0c             	sub    $0xc,%esp
80105cec:	68 dd 8b 10 80       	push   $0x80108bdd
80105cf1:	e8 71 a8 ff ff       	call   80100567 <panic>
    if(de.inum != 0)
80105cf6:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105cfa:	66 85 c0             	test   %ax,%ax
80105cfd:	74 07                	je     80105d06 <isdirempty+0x46>
      return 0;
80105cff:	b8 00 00 00 00       	mov    $0x0,%eax
80105d04:	eb 1b                	jmp    80105d21 <isdirempty+0x61>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105d06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d09:	83 c0 10             	add    $0x10,%eax
80105d0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d0f:	8b 45 08             	mov    0x8(%ebp),%eax
80105d12:	8b 50 18             	mov    0x18(%eax),%edx
80105d15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d18:	39 c2                	cmp    %eax,%edx
80105d1a:	77 b3                	ja     80105ccf <isdirempty+0xf>
  }
  return 1;
80105d1c:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105d21:	c9                   	leave  
80105d22:	c3                   	ret    

80105d23 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105d23:	55                   	push   %ebp
80105d24:	89 e5                	mov    %esp,%ebp
80105d26:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105d29:	83 ec 08             	sub    $0x8,%esp
80105d2c:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105d2f:	50                   	push   %eax
80105d30:	6a 00                	push   $0x0
80105d32:	e8 a2 fa ff ff       	call   801057d9 <argstr>
80105d37:	83 c4 10             	add    $0x10,%esp
80105d3a:	85 c0                	test   %eax,%eax
80105d3c:	79 0a                	jns    80105d48 <sys_unlink+0x25>
    return -1;
80105d3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d43:	e9 bf 01 00 00       	jmp    80105f07 <sys_unlink+0x1e4>

  begin_op();
80105d48:	e8 09 d8 ff ff       	call   80103556 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105d4d:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105d50:	83 ec 08             	sub    $0x8,%esp
80105d53:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105d56:	52                   	push   %edx
80105d57:	50                   	push   %eax
80105d58:	e8 e9 c7 ff ff       	call   80102546 <nameiparent>
80105d5d:	83 c4 10             	add    $0x10,%esp
80105d60:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d63:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d67:	75 0f                	jne    80105d78 <sys_unlink+0x55>
    end_op();
80105d69:	e8 74 d8 ff ff       	call   801035e2 <end_op>
    return -1;
80105d6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d73:	e9 8f 01 00 00       	jmp    80105f07 <sys_unlink+0x1e4>
  }

  ilock(dp);
80105d78:	83 ec 0c             	sub    $0xc,%esp
80105d7b:	ff 75 f4             	pushl  -0xc(%ebp)
80105d7e:	e8 f2 bb ff ff       	call   80101975 <ilock>
80105d83:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105d86:	83 ec 08             	sub    $0x8,%esp
80105d89:	68 ef 8b 10 80       	push   $0x80108bef
80105d8e:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105d91:	50                   	push   %eax
80105d92:	e8 26 c4 ff ff       	call   801021bd <namecmp>
80105d97:	83 c4 10             	add    $0x10,%esp
80105d9a:	85 c0                	test   %eax,%eax
80105d9c:	0f 84 49 01 00 00    	je     80105eeb <sys_unlink+0x1c8>
80105da2:	83 ec 08             	sub    $0x8,%esp
80105da5:	68 f1 8b 10 80       	push   $0x80108bf1
80105daa:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105dad:	50                   	push   %eax
80105dae:	e8 0a c4 ff ff       	call   801021bd <namecmp>
80105db3:	83 c4 10             	add    $0x10,%esp
80105db6:	85 c0                	test   %eax,%eax
80105db8:	0f 84 2d 01 00 00    	je     80105eeb <sys_unlink+0x1c8>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105dbe:	83 ec 04             	sub    $0x4,%esp
80105dc1:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105dc4:	50                   	push   %eax
80105dc5:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105dc8:	50                   	push   %eax
80105dc9:	ff 75 f4             	pushl  -0xc(%ebp)
80105dcc:	e8 07 c4 ff ff       	call   801021d8 <dirlookup>
80105dd1:	83 c4 10             	add    $0x10,%esp
80105dd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105dd7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105ddb:	0f 84 0d 01 00 00    	je     80105eee <sys_unlink+0x1cb>
    goto bad;
  ilock(ip);
80105de1:	83 ec 0c             	sub    $0xc,%esp
80105de4:	ff 75 f0             	pushl  -0x10(%ebp)
80105de7:	e8 89 bb ff ff       	call   80101975 <ilock>
80105dec:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105def:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105df2:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105df6:	66 85 c0             	test   %ax,%ax
80105df9:	7f 0d                	jg     80105e08 <sys_unlink+0xe5>
    panic("unlink: nlink < 1");
80105dfb:	83 ec 0c             	sub    $0xc,%esp
80105dfe:	68 f4 8b 10 80       	push   $0x80108bf4
80105e03:	e8 5f a7 ff ff       	call   80100567 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105e08:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e0b:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105e0f:	66 83 f8 01          	cmp    $0x1,%ax
80105e13:	75 25                	jne    80105e3a <sys_unlink+0x117>
80105e15:	83 ec 0c             	sub    $0xc,%esp
80105e18:	ff 75 f0             	pushl  -0x10(%ebp)
80105e1b:	e8 a0 fe ff ff       	call   80105cc0 <isdirempty>
80105e20:	83 c4 10             	add    $0x10,%esp
80105e23:	85 c0                	test   %eax,%eax
80105e25:	75 13                	jne    80105e3a <sys_unlink+0x117>
    iunlockput(ip);
80105e27:	83 ec 0c             	sub    $0xc,%esp
80105e2a:	ff 75 f0             	pushl  -0x10(%ebp)
80105e2d:	e8 03 be ff ff       	call   80101c35 <iunlockput>
80105e32:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105e35:	e9 b5 00 00 00       	jmp    80105eef <sys_unlink+0x1cc>
  }

  memset(&de, 0, sizeof(de));
80105e3a:	83 ec 04             	sub    $0x4,%esp
80105e3d:	6a 10                	push   $0x10
80105e3f:	6a 00                	push   $0x0
80105e41:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105e44:	50                   	push   %eax
80105e45:	e8 e5 f5 ff ff       	call   8010542f <memset>
80105e4a:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105e4d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105e50:	6a 10                	push   $0x10
80105e52:	50                   	push   %eax
80105e53:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105e56:	50                   	push   %eax
80105e57:	ff 75 f4             	pushl  -0xc(%ebp)
80105e5a:	e8 d6 c1 ff ff       	call   80102035 <writei>
80105e5f:	83 c4 10             	add    $0x10,%esp
80105e62:	83 f8 10             	cmp    $0x10,%eax
80105e65:	74 0d                	je     80105e74 <sys_unlink+0x151>
    panic("unlink: writei");
80105e67:	83 ec 0c             	sub    $0xc,%esp
80105e6a:	68 06 8c 10 80       	push   $0x80108c06
80105e6f:	e8 f3 a6 ff ff       	call   80100567 <panic>
  if(ip->type == T_DIR){
80105e74:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e77:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105e7b:	66 83 f8 01          	cmp    $0x1,%ax
80105e7f:	75 21                	jne    80105ea2 <sys_unlink+0x17f>
    dp->nlink--;
80105e81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e84:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105e88:	83 e8 01             	sub    $0x1,%eax
80105e8b:	89 c2                	mov    %eax,%edx
80105e8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e90:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105e94:	83 ec 0c             	sub    $0xc,%esp
80105e97:	ff 75 f4             	pushl  -0xc(%ebp)
80105e9a:	e8 fc b8 ff ff       	call   8010179b <iupdate>
80105e9f:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105ea2:	83 ec 0c             	sub    $0xc,%esp
80105ea5:	ff 75 f4             	pushl  -0xc(%ebp)
80105ea8:	e8 88 bd ff ff       	call   80101c35 <iunlockput>
80105ead:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105eb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105eb3:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105eb7:	83 e8 01             	sub    $0x1,%eax
80105eba:	89 c2                	mov    %eax,%edx
80105ebc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ebf:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105ec3:	83 ec 0c             	sub    $0xc,%esp
80105ec6:	ff 75 f0             	pushl  -0x10(%ebp)
80105ec9:	e8 cd b8 ff ff       	call   8010179b <iupdate>
80105ece:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105ed1:	83 ec 0c             	sub    $0xc,%esp
80105ed4:	ff 75 f0             	pushl  -0x10(%ebp)
80105ed7:	e8 59 bd ff ff       	call   80101c35 <iunlockput>
80105edc:	83 c4 10             	add    $0x10,%esp

  end_op();
80105edf:	e8 fe d6 ff ff       	call   801035e2 <end_op>

  return 0;
80105ee4:	b8 00 00 00 00       	mov    $0x0,%eax
80105ee9:	eb 1c                	jmp    80105f07 <sys_unlink+0x1e4>
    goto bad;
80105eeb:	90                   	nop
80105eec:	eb 01                	jmp    80105eef <sys_unlink+0x1cc>
    goto bad;
80105eee:	90                   	nop

bad:
  iunlockput(dp);
80105eef:	83 ec 0c             	sub    $0xc,%esp
80105ef2:	ff 75 f4             	pushl  -0xc(%ebp)
80105ef5:	e8 3b bd ff ff       	call   80101c35 <iunlockput>
80105efa:	83 c4 10             	add    $0x10,%esp
  end_op();
80105efd:	e8 e0 d6 ff ff       	call   801035e2 <end_op>
  return -1;
80105f02:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f07:	c9                   	leave  
80105f08:	c3                   	ret    

80105f09 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105f09:	55                   	push   %ebp
80105f0a:	89 e5                	mov    %esp,%ebp
80105f0c:	83 ec 38             	sub    $0x38,%esp
80105f0f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105f12:	8b 55 10             	mov    0x10(%ebp),%edx
80105f15:	8b 45 14             	mov    0x14(%ebp),%eax
80105f18:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105f1c:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105f20:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105f24:	83 ec 08             	sub    $0x8,%esp
80105f27:	8d 45 de             	lea    -0x22(%ebp),%eax
80105f2a:	50                   	push   %eax
80105f2b:	ff 75 08             	pushl  0x8(%ebp)
80105f2e:	e8 13 c6 ff ff       	call   80102546 <nameiparent>
80105f33:	83 c4 10             	add    $0x10,%esp
80105f36:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f39:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f3d:	75 0a                	jne    80105f49 <create+0x40>
    return 0;
80105f3f:	b8 00 00 00 00       	mov    $0x0,%eax
80105f44:	e9 90 01 00 00       	jmp    801060d9 <create+0x1d0>
  ilock(dp);
80105f49:	83 ec 0c             	sub    $0xc,%esp
80105f4c:	ff 75 f4             	pushl  -0xc(%ebp)
80105f4f:	e8 21 ba ff ff       	call   80101975 <ilock>
80105f54:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105f57:	83 ec 04             	sub    $0x4,%esp
80105f5a:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f5d:	50                   	push   %eax
80105f5e:	8d 45 de             	lea    -0x22(%ebp),%eax
80105f61:	50                   	push   %eax
80105f62:	ff 75 f4             	pushl  -0xc(%ebp)
80105f65:	e8 6e c2 ff ff       	call   801021d8 <dirlookup>
80105f6a:	83 c4 10             	add    $0x10,%esp
80105f6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f70:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f74:	74 50                	je     80105fc6 <create+0xbd>
    iunlockput(dp);
80105f76:	83 ec 0c             	sub    $0xc,%esp
80105f79:	ff 75 f4             	pushl  -0xc(%ebp)
80105f7c:	e8 b4 bc ff ff       	call   80101c35 <iunlockput>
80105f81:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105f84:	83 ec 0c             	sub    $0xc,%esp
80105f87:	ff 75 f0             	pushl  -0x10(%ebp)
80105f8a:	e8 e6 b9 ff ff       	call   80101975 <ilock>
80105f8f:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105f92:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105f97:	75 15                	jne    80105fae <create+0xa5>
80105f99:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f9c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105fa0:	66 83 f8 02          	cmp    $0x2,%ax
80105fa4:	75 08                	jne    80105fae <create+0xa5>
      return ip;
80105fa6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fa9:	e9 2b 01 00 00       	jmp    801060d9 <create+0x1d0>
    iunlockput(ip);
80105fae:	83 ec 0c             	sub    $0xc,%esp
80105fb1:	ff 75 f0             	pushl  -0x10(%ebp)
80105fb4:	e8 7c bc ff ff       	call   80101c35 <iunlockput>
80105fb9:	83 c4 10             	add    $0x10,%esp
    return 0;
80105fbc:	b8 00 00 00 00       	mov    $0x0,%eax
80105fc1:	e9 13 01 00 00       	jmp    801060d9 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105fc6:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105fca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fcd:	8b 00                	mov    (%eax),%eax
80105fcf:	83 ec 08             	sub    $0x8,%esp
80105fd2:	52                   	push   %edx
80105fd3:	50                   	push   %eax
80105fd4:	e8 eb b6 ff ff       	call   801016c4 <ialloc>
80105fd9:	83 c4 10             	add    $0x10,%esp
80105fdc:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105fdf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105fe3:	75 0d                	jne    80105ff2 <create+0xe9>
    panic("create: ialloc");
80105fe5:	83 ec 0c             	sub    $0xc,%esp
80105fe8:	68 15 8c 10 80       	push   $0x80108c15
80105fed:	e8 75 a5 ff ff       	call   80100567 <panic>

  ilock(ip);
80105ff2:	83 ec 0c             	sub    $0xc,%esp
80105ff5:	ff 75 f0             	pushl  -0x10(%ebp)
80105ff8:	e8 78 b9 ff ff       	call   80101975 <ilock>
80105ffd:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80106000:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106003:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80106007:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
8010600b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010600e:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80106012:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80106016:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106019:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
8010601f:	83 ec 0c             	sub    $0xc,%esp
80106022:	ff 75 f0             	pushl  -0x10(%ebp)
80106025:	e8 71 b7 ff ff       	call   8010179b <iupdate>
8010602a:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
8010602d:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80106032:	75 6a                	jne    8010609e <create+0x195>
    dp->nlink++;  // for ".."
80106034:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106037:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010603b:	83 c0 01             	add    $0x1,%eax
8010603e:	89 c2                	mov    %eax,%edx
80106040:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106043:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80106047:	83 ec 0c             	sub    $0xc,%esp
8010604a:	ff 75 f4             	pushl  -0xc(%ebp)
8010604d:	e8 49 b7 ff ff       	call   8010179b <iupdate>
80106052:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80106055:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106058:	8b 40 04             	mov    0x4(%eax),%eax
8010605b:	83 ec 04             	sub    $0x4,%esp
8010605e:	50                   	push   %eax
8010605f:	68 ef 8b 10 80       	push   $0x80108bef
80106064:	ff 75 f0             	pushl  -0x10(%ebp)
80106067:	e8 26 c2 ff ff       	call   80102292 <dirlink>
8010606c:	83 c4 10             	add    $0x10,%esp
8010606f:	85 c0                	test   %eax,%eax
80106071:	78 1e                	js     80106091 <create+0x188>
80106073:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106076:	8b 40 04             	mov    0x4(%eax),%eax
80106079:	83 ec 04             	sub    $0x4,%esp
8010607c:	50                   	push   %eax
8010607d:	68 f1 8b 10 80       	push   $0x80108bf1
80106082:	ff 75 f0             	pushl  -0x10(%ebp)
80106085:	e8 08 c2 ff ff       	call   80102292 <dirlink>
8010608a:	83 c4 10             	add    $0x10,%esp
8010608d:	85 c0                	test   %eax,%eax
8010608f:	79 0d                	jns    8010609e <create+0x195>
      panic("create dots");
80106091:	83 ec 0c             	sub    $0xc,%esp
80106094:	68 24 8c 10 80       	push   $0x80108c24
80106099:	e8 c9 a4 ff ff       	call   80100567 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
8010609e:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060a1:	8b 40 04             	mov    0x4(%eax),%eax
801060a4:	83 ec 04             	sub    $0x4,%esp
801060a7:	50                   	push   %eax
801060a8:	8d 45 de             	lea    -0x22(%ebp),%eax
801060ab:	50                   	push   %eax
801060ac:	ff 75 f4             	pushl  -0xc(%ebp)
801060af:	e8 de c1 ff ff       	call   80102292 <dirlink>
801060b4:	83 c4 10             	add    $0x10,%esp
801060b7:	85 c0                	test   %eax,%eax
801060b9:	79 0d                	jns    801060c8 <create+0x1bf>
    panic("create: dirlink");
801060bb:	83 ec 0c             	sub    $0xc,%esp
801060be:	68 30 8c 10 80       	push   $0x80108c30
801060c3:	e8 9f a4 ff ff       	call   80100567 <panic>

  iunlockput(dp);
801060c8:	83 ec 0c             	sub    $0xc,%esp
801060cb:	ff 75 f4             	pushl  -0xc(%ebp)
801060ce:	e8 62 bb ff ff       	call   80101c35 <iunlockput>
801060d3:	83 c4 10             	add    $0x10,%esp

  return ip;
801060d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
801060d9:	c9                   	leave  
801060da:	c3                   	ret    

801060db <sys_open>:

int
sys_open(void)
{
801060db:	55                   	push   %ebp
801060dc:	89 e5                	mov    %esp,%ebp
801060de:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801060e1:	83 ec 08             	sub    $0x8,%esp
801060e4:	8d 45 e8             	lea    -0x18(%ebp),%eax
801060e7:	50                   	push   %eax
801060e8:	6a 00                	push   $0x0
801060ea:	e8 ea f6 ff ff       	call   801057d9 <argstr>
801060ef:	83 c4 10             	add    $0x10,%esp
801060f2:	85 c0                	test   %eax,%eax
801060f4:	78 15                	js     8010610b <sys_open+0x30>
801060f6:	83 ec 08             	sub    $0x8,%esp
801060f9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801060fc:	50                   	push   %eax
801060fd:	6a 01                	push   $0x1
801060ff:	e8 50 f6 ff ff       	call   80105754 <argint>
80106104:	83 c4 10             	add    $0x10,%esp
80106107:	85 c0                	test   %eax,%eax
80106109:	79 0a                	jns    80106115 <sys_open+0x3a>
    return -1;
8010610b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106110:	e9 61 01 00 00       	jmp    80106276 <sys_open+0x19b>

  begin_op();
80106115:	e8 3c d4 ff ff       	call   80103556 <begin_op>

  if(omode & O_CREATE){
8010611a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010611d:	25 00 02 00 00       	and    $0x200,%eax
80106122:	85 c0                	test   %eax,%eax
80106124:	74 2a                	je     80106150 <sys_open+0x75>
    ip = create(path, T_FILE, 0, 0);
80106126:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106129:	6a 00                	push   $0x0
8010612b:	6a 00                	push   $0x0
8010612d:	6a 02                	push   $0x2
8010612f:	50                   	push   %eax
80106130:	e8 d4 fd ff ff       	call   80105f09 <create>
80106135:	83 c4 10             	add    $0x10,%esp
80106138:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
8010613b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010613f:	75 75                	jne    801061b6 <sys_open+0xdb>
      end_op();
80106141:	e8 9c d4 ff ff       	call   801035e2 <end_op>
      return -1;
80106146:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010614b:	e9 26 01 00 00       	jmp    80106276 <sys_open+0x19b>
    }
  } else {
    if((ip = namei(path)) == 0){
80106150:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106153:	83 ec 0c             	sub    $0xc,%esp
80106156:	50                   	push   %eax
80106157:	e8 ce c3 ff ff       	call   8010252a <namei>
8010615c:	83 c4 10             	add    $0x10,%esp
8010615f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106162:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106166:	75 0f                	jne    80106177 <sys_open+0x9c>
      end_op();
80106168:	e8 75 d4 ff ff       	call   801035e2 <end_op>
      return -1;
8010616d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106172:	e9 ff 00 00 00       	jmp    80106276 <sys_open+0x19b>
    }
    ilock(ip);
80106177:	83 ec 0c             	sub    $0xc,%esp
8010617a:	ff 75 f4             	pushl  -0xc(%ebp)
8010617d:	e8 f3 b7 ff ff       	call   80101975 <ilock>
80106182:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80106185:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106188:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010618c:	66 83 f8 01          	cmp    $0x1,%ax
80106190:	75 24                	jne    801061b6 <sys_open+0xdb>
80106192:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106195:	85 c0                	test   %eax,%eax
80106197:	74 1d                	je     801061b6 <sys_open+0xdb>
      iunlockput(ip);
80106199:	83 ec 0c             	sub    $0xc,%esp
8010619c:	ff 75 f4             	pushl  -0xc(%ebp)
8010619f:	e8 91 ba ff ff       	call   80101c35 <iunlockput>
801061a4:	83 c4 10             	add    $0x10,%esp
      end_op();
801061a7:	e8 36 d4 ff ff       	call   801035e2 <end_op>
      return -1;
801061ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061b1:	e9 c0 00 00 00       	jmp    80106276 <sys_open+0x19b>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801061b6:	e8 e3 ad ff ff       	call   80100f9e <filealloc>
801061bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
801061be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801061c2:	74 17                	je     801061db <sys_open+0x100>
801061c4:	83 ec 0c             	sub    $0xc,%esp
801061c7:	ff 75 f0             	pushl  -0x10(%ebp)
801061ca:	e8 34 f7 ff ff       	call   80105903 <fdalloc>
801061cf:	83 c4 10             	add    $0x10,%esp
801061d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
801061d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801061d9:	79 2e                	jns    80106209 <sys_open+0x12e>
    if(f)
801061db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801061df:	74 0e                	je     801061ef <sys_open+0x114>
      fileclose(f);
801061e1:	83 ec 0c             	sub    $0xc,%esp
801061e4:	ff 75 f0             	pushl  -0x10(%ebp)
801061e7:	e8 70 ae ff ff       	call   8010105c <fileclose>
801061ec:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801061ef:	83 ec 0c             	sub    $0xc,%esp
801061f2:	ff 75 f4             	pushl  -0xc(%ebp)
801061f5:	e8 3b ba ff ff       	call   80101c35 <iunlockput>
801061fa:	83 c4 10             	add    $0x10,%esp
    end_op();
801061fd:	e8 e0 d3 ff ff       	call   801035e2 <end_op>
    return -1;
80106202:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106207:	eb 6d                	jmp    80106276 <sys_open+0x19b>
  }
  iunlock(ip);
80106209:	83 ec 0c             	sub    $0xc,%esp
8010620c:	ff 75 f4             	pushl  -0xc(%ebp)
8010620f:	e8 bf b8 ff ff       	call   80101ad3 <iunlock>
80106214:	83 c4 10             	add    $0x10,%esp
  end_op();
80106217:	e8 c6 d3 ff ff       	call   801035e2 <end_op>

  f->type = FD_INODE;
8010621c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010621f:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80106225:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106228:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010622b:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
8010622e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106231:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80106238:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010623b:	83 e0 01             	and    $0x1,%eax
8010623e:	85 c0                	test   %eax,%eax
80106240:	0f 94 c0             	sete   %al
80106243:	89 c2                	mov    %eax,%edx
80106245:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106248:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010624b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010624e:	83 e0 01             	and    $0x1,%eax
80106251:	85 c0                	test   %eax,%eax
80106253:	75 0a                	jne    8010625f <sys_open+0x184>
80106255:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106258:	83 e0 02             	and    $0x2,%eax
8010625b:	85 c0                	test   %eax,%eax
8010625d:	74 07                	je     80106266 <sys_open+0x18b>
8010625f:	b8 01 00 00 00       	mov    $0x1,%eax
80106264:	eb 05                	jmp    8010626b <sys_open+0x190>
80106266:	b8 00 00 00 00       	mov    $0x0,%eax
8010626b:	89 c2                	mov    %eax,%edx
8010626d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106270:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80106273:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80106276:	c9                   	leave  
80106277:	c3                   	ret    

80106278 <sys_mkdir>:

int
sys_mkdir(void)
{
80106278:	55                   	push   %ebp
80106279:	89 e5                	mov    %esp,%ebp
8010627b:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
8010627e:	e8 d3 d2 ff ff       	call   80103556 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106283:	83 ec 08             	sub    $0x8,%esp
80106286:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106289:	50                   	push   %eax
8010628a:	6a 00                	push   $0x0
8010628c:	e8 48 f5 ff ff       	call   801057d9 <argstr>
80106291:	83 c4 10             	add    $0x10,%esp
80106294:	85 c0                	test   %eax,%eax
80106296:	78 1b                	js     801062b3 <sys_mkdir+0x3b>
80106298:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010629b:	6a 00                	push   $0x0
8010629d:	6a 00                	push   $0x0
8010629f:	6a 01                	push   $0x1
801062a1:	50                   	push   %eax
801062a2:	e8 62 fc ff ff       	call   80105f09 <create>
801062a7:	83 c4 10             	add    $0x10,%esp
801062aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
801062ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062b1:	75 0c                	jne    801062bf <sys_mkdir+0x47>
    end_op();
801062b3:	e8 2a d3 ff ff       	call   801035e2 <end_op>
    return -1;
801062b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062bd:	eb 18                	jmp    801062d7 <sys_mkdir+0x5f>
  }
  iunlockput(ip);
801062bf:	83 ec 0c             	sub    $0xc,%esp
801062c2:	ff 75 f4             	pushl  -0xc(%ebp)
801062c5:	e8 6b b9 ff ff       	call   80101c35 <iunlockput>
801062ca:	83 c4 10             	add    $0x10,%esp
  end_op();
801062cd:	e8 10 d3 ff ff       	call   801035e2 <end_op>
  return 0;
801062d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801062d7:	c9                   	leave  
801062d8:	c3                   	ret    

801062d9 <sys_mknod>:

int
sys_mknod(void)
{
801062d9:	55                   	push   %ebp
801062da:	89 e5                	mov    %esp,%ebp
801062dc:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_op();
801062df:	e8 72 d2 ff ff       	call   80103556 <begin_op>
  if((len=argstr(0, &path)) < 0 ||
801062e4:	83 ec 08             	sub    $0x8,%esp
801062e7:	8d 45 ec             	lea    -0x14(%ebp),%eax
801062ea:	50                   	push   %eax
801062eb:	6a 00                	push   $0x0
801062ed:	e8 e7 f4 ff ff       	call   801057d9 <argstr>
801062f2:	83 c4 10             	add    $0x10,%esp
801062f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801062f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062fc:	78 4f                	js     8010634d <sys_mknod+0x74>
     argint(1, &major) < 0 ||
801062fe:	83 ec 08             	sub    $0x8,%esp
80106301:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106304:	50                   	push   %eax
80106305:	6a 01                	push   $0x1
80106307:	e8 48 f4 ff ff       	call   80105754 <argint>
8010630c:	83 c4 10             	add    $0x10,%esp
  if((len=argstr(0, &path)) < 0 ||
8010630f:	85 c0                	test   %eax,%eax
80106311:	78 3a                	js     8010634d <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
80106313:	83 ec 08             	sub    $0x8,%esp
80106316:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106319:	50                   	push   %eax
8010631a:	6a 02                	push   $0x2
8010631c:	e8 33 f4 ff ff       	call   80105754 <argint>
80106321:	83 c4 10             	add    $0x10,%esp
     argint(1, &major) < 0 ||
80106324:	85 c0                	test   %eax,%eax
80106326:	78 25                	js     8010634d <sys_mknod+0x74>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106328:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010632b:	0f bf c8             	movswl %ax,%ecx
8010632e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106331:	0f bf d0             	movswl %ax,%edx
80106334:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106337:	51                   	push   %ecx
80106338:	52                   	push   %edx
80106339:	6a 03                	push   $0x3
8010633b:	50                   	push   %eax
8010633c:	e8 c8 fb ff ff       	call   80105f09 <create>
80106341:	83 c4 10             	add    $0x10,%esp
80106344:	89 45 f0             	mov    %eax,-0x10(%ebp)
     argint(2, &minor) < 0 ||
80106347:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010634b:	75 0c                	jne    80106359 <sys_mknod+0x80>
    end_op();
8010634d:	e8 90 d2 ff ff       	call   801035e2 <end_op>
    return -1;
80106352:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106357:	eb 18                	jmp    80106371 <sys_mknod+0x98>
  }
  iunlockput(ip);
80106359:	83 ec 0c             	sub    $0xc,%esp
8010635c:	ff 75 f0             	pushl  -0x10(%ebp)
8010635f:	e8 d1 b8 ff ff       	call   80101c35 <iunlockput>
80106364:	83 c4 10             	add    $0x10,%esp
  end_op();
80106367:	e8 76 d2 ff ff       	call   801035e2 <end_op>
  return 0;
8010636c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106371:	c9                   	leave  
80106372:	c3                   	ret    

80106373 <sys_chdir>:

int
sys_chdir(void)
{
80106373:	55                   	push   %ebp
80106374:	89 e5                	mov    %esp,%ebp
80106376:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106379:	e8 d8 d1 ff ff       	call   80103556 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
8010637e:	83 ec 08             	sub    $0x8,%esp
80106381:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106384:	50                   	push   %eax
80106385:	6a 00                	push   $0x0
80106387:	e8 4d f4 ff ff       	call   801057d9 <argstr>
8010638c:	83 c4 10             	add    $0x10,%esp
8010638f:	85 c0                	test   %eax,%eax
80106391:	78 18                	js     801063ab <sys_chdir+0x38>
80106393:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106396:	83 ec 0c             	sub    $0xc,%esp
80106399:	50                   	push   %eax
8010639a:	e8 8b c1 ff ff       	call   8010252a <namei>
8010639f:	83 c4 10             	add    $0x10,%esp
801063a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
801063a5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801063a9:	75 0c                	jne    801063b7 <sys_chdir+0x44>
    end_op();
801063ab:	e8 32 d2 ff ff       	call   801035e2 <end_op>
    return -1;
801063b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063b5:	eb 6e                	jmp    80106425 <sys_chdir+0xb2>
  }
  ilock(ip);
801063b7:	83 ec 0c             	sub    $0xc,%esp
801063ba:	ff 75 f4             	pushl  -0xc(%ebp)
801063bd:	e8 b3 b5 ff ff       	call   80101975 <ilock>
801063c2:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
801063c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063c8:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801063cc:	66 83 f8 01          	cmp    $0x1,%ax
801063d0:	74 1a                	je     801063ec <sys_chdir+0x79>
    iunlockput(ip);
801063d2:	83 ec 0c             	sub    $0xc,%esp
801063d5:	ff 75 f4             	pushl  -0xc(%ebp)
801063d8:	e8 58 b8 ff ff       	call   80101c35 <iunlockput>
801063dd:	83 c4 10             	add    $0x10,%esp
    end_op();
801063e0:	e8 fd d1 ff ff       	call   801035e2 <end_op>
    return -1;
801063e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063ea:	eb 39                	jmp    80106425 <sys_chdir+0xb2>
  }
  iunlock(ip);
801063ec:	83 ec 0c             	sub    $0xc,%esp
801063ef:	ff 75 f4             	pushl  -0xc(%ebp)
801063f2:	e8 dc b6 ff ff       	call   80101ad3 <iunlock>
801063f7:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
801063fa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106400:	8b 40 68             	mov    0x68(%eax),%eax
80106403:	83 ec 0c             	sub    $0xc,%esp
80106406:	50                   	push   %eax
80106407:	e8 39 b7 ff ff       	call   80101b45 <iput>
8010640c:	83 c4 10             	add    $0x10,%esp
  end_op();
8010640f:	e8 ce d1 ff ff       	call   801035e2 <end_op>
  proc->cwd = ip;
80106414:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010641a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010641d:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80106420:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106425:	c9                   	leave  
80106426:	c3                   	ret    

80106427 <sys_exec>:

int
sys_exec(void)
{
80106427:	55                   	push   %ebp
80106428:	89 e5                	mov    %esp,%ebp
8010642a:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106430:	83 ec 08             	sub    $0x8,%esp
80106433:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106436:	50                   	push   %eax
80106437:	6a 00                	push   $0x0
80106439:	e8 9b f3 ff ff       	call   801057d9 <argstr>
8010643e:	83 c4 10             	add    $0x10,%esp
80106441:	85 c0                	test   %eax,%eax
80106443:	78 18                	js     8010645d <sys_exec+0x36>
80106445:	83 ec 08             	sub    $0x8,%esp
80106448:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
8010644e:	50                   	push   %eax
8010644f:	6a 01                	push   $0x1
80106451:	e8 fe f2 ff ff       	call   80105754 <argint>
80106456:	83 c4 10             	add    $0x10,%esp
80106459:	85 c0                	test   %eax,%eax
8010645b:	79 0a                	jns    80106467 <sys_exec+0x40>
    return -1;
8010645d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106462:	e9 c6 00 00 00       	jmp    8010652d <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
80106467:	83 ec 04             	sub    $0x4,%esp
8010646a:	68 80 00 00 00       	push   $0x80
8010646f:	6a 00                	push   $0x0
80106471:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106477:	50                   	push   %eax
80106478:	e8 b2 ef ff ff       	call   8010542f <memset>
8010647d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
80106480:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
80106487:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010648a:	83 f8 1f             	cmp    $0x1f,%eax
8010648d:	76 0a                	jbe    80106499 <sys_exec+0x72>
      return -1;
8010648f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106494:	e9 94 00 00 00       	jmp    8010652d <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106499:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010649c:	c1 e0 02             	shl    $0x2,%eax
8010649f:	89 c2                	mov    %eax,%edx
801064a1:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801064a7:	01 c2                	add    %eax,%edx
801064a9:	83 ec 08             	sub    $0x8,%esp
801064ac:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801064b2:	50                   	push   %eax
801064b3:	52                   	push   %edx
801064b4:	e8 ff f1 ff ff       	call   801056b8 <fetchint>
801064b9:	83 c4 10             	add    $0x10,%esp
801064bc:	85 c0                	test   %eax,%eax
801064be:	79 07                	jns    801064c7 <sys_exec+0xa0>
      return -1;
801064c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064c5:	eb 66                	jmp    8010652d <sys_exec+0x106>
    if(uarg == 0){
801064c7:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801064cd:	85 c0                	test   %eax,%eax
801064cf:	75 27                	jne    801064f8 <sys_exec+0xd1>
      argv[i] = 0;
801064d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064d4:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
801064db:	00 00 00 00 
      break;
801064df:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801064e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064e3:	83 ec 08             	sub    $0x8,%esp
801064e6:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
801064ec:	52                   	push   %edx
801064ed:	50                   	push   %eax
801064ee:	e8 89 a6 ff ff       	call   80100b7c <exec>
801064f3:	83 c4 10             	add    $0x10,%esp
801064f6:	eb 35                	jmp    8010652d <sys_exec+0x106>
    if(fetchstr(uarg, &argv[i]) < 0)
801064f8:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801064fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106501:	c1 e2 02             	shl    $0x2,%edx
80106504:	01 c2                	add    %eax,%edx
80106506:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010650c:	83 ec 08             	sub    $0x8,%esp
8010650f:	52                   	push   %edx
80106510:	50                   	push   %eax
80106511:	e8 dc f1 ff ff       	call   801056f2 <fetchstr>
80106516:	83 c4 10             	add    $0x10,%esp
80106519:	85 c0                	test   %eax,%eax
8010651b:	79 07                	jns    80106524 <sys_exec+0xfd>
      return -1;
8010651d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106522:	eb 09                	jmp    8010652d <sys_exec+0x106>
  for(i=0;; i++){
80106524:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(i >= NELEM(argv))
80106528:	e9 5a ff ff ff       	jmp    80106487 <sys_exec+0x60>
}
8010652d:	c9                   	leave  
8010652e:	c3                   	ret    

8010652f <sys_pipe>:

int
sys_pipe(void)
{
8010652f:	55                   	push   %ebp
80106530:	89 e5                	mov    %esp,%ebp
80106532:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106535:	83 ec 04             	sub    $0x4,%esp
80106538:	6a 08                	push   $0x8
8010653a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010653d:	50                   	push   %eax
8010653e:	6a 00                	push   $0x0
80106540:	e8 37 f2 ff ff       	call   8010577c <argptr>
80106545:	83 c4 10             	add    $0x10,%esp
80106548:	85 c0                	test   %eax,%eax
8010654a:	79 0a                	jns    80106556 <sys_pipe+0x27>
    return -1;
8010654c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106551:	e9 af 00 00 00       	jmp    80106605 <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
80106556:	83 ec 08             	sub    $0x8,%esp
80106559:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010655c:	50                   	push   %eax
8010655d:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106560:	50                   	push   %eax
80106561:	e8 e0 da ff ff       	call   80104046 <pipealloc>
80106566:	83 c4 10             	add    $0x10,%esp
80106569:	85 c0                	test   %eax,%eax
8010656b:	79 0a                	jns    80106577 <sys_pipe+0x48>
    return -1;
8010656d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106572:	e9 8e 00 00 00       	jmp    80106605 <sys_pipe+0xd6>
  fd0 = -1;
80106577:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010657e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106581:	83 ec 0c             	sub    $0xc,%esp
80106584:	50                   	push   %eax
80106585:	e8 79 f3 ff ff       	call   80105903 <fdalloc>
8010658a:	83 c4 10             	add    $0x10,%esp
8010658d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106590:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106594:	78 18                	js     801065ae <sys_pipe+0x7f>
80106596:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106599:	83 ec 0c             	sub    $0xc,%esp
8010659c:	50                   	push   %eax
8010659d:	e8 61 f3 ff ff       	call   80105903 <fdalloc>
801065a2:	83 c4 10             	add    $0x10,%esp
801065a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
801065a8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801065ac:	79 3f                	jns    801065ed <sys_pipe+0xbe>
    if(fd0 >= 0)
801065ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801065b2:	78 14                	js     801065c8 <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
801065b4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
801065bd:	83 c2 08             	add    $0x8,%edx
801065c0:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801065c7:	00 
    fileclose(rf);
801065c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
801065cb:	83 ec 0c             	sub    $0xc,%esp
801065ce:	50                   	push   %eax
801065cf:	e8 88 aa ff ff       	call   8010105c <fileclose>
801065d4:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
801065d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801065da:	83 ec 0c             	sub    $0xc,%esp
801065dd:	50                   	push   %eax
801065de:	e8 79 aa ff ff       	call   8010105c <fileclose>
801065e3:	83 c4 10             	add    $0x10,%esp
    return -1;
801065e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065eb:	eb 18                	jmp    80106605 <sys_pipe+0xd6>
  }
  fd[0] = fd0;
801065ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
801065f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801065f3:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
801065f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801065f8:	8d 50 04             	lea    0x4(%eax),%edx
801065fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065fe:	89 02                	mov    %eax,(%edx)
  return 0;
80106600:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106605:	c9                   	leave  
80106606:	c3                   	ret    

80106607 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106607:	55                   	push   %ebp
80106608:	89 e5                	mov    %esp,%ebp
8010660a:	83 ec 18             	sub    $0x18,%esp
  int argtickets;
  argint(0,&argtickets);
8010660d:	83 ec 08             	sub    $0x8,%esp
80106610:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106613:	50                   	push   %eax
80106614:	6a 00                	push   $0x0
80106616:	e8 39 f1 ff ff       	call   80105754 <argint>
8010661b:	83 c4 10             	add    $0x10,%esp
  return fork(argtickets);
8010661e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106621:	83 ec 0c             	sub    $0xc,%esp
80106624:	50                   	push   %eax
80106625:	e8 c9 e1 ff ff       	call   801047f3 <fork>
8010662a:	83 c4 10             	add    $0x10,%esp
}
8010662d:	c9                   	leave  
8010662e:	c3                   	ret    

8010662f <sys_exit>:

int
sys_exit(void)
{
8010662f:	55                   	push   %ebp
80106630:	89 e5                	mov    %esp,%ebp
80106632:	83 ec 08             	sub    $0x8,%esp
  exit();
80106635:	e8 bc e3 ff ff       	call   801049f6 <exit>
  return 0;  // not reached
8010663a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010663f:	c9                   	leave  
80106640:	c3                   	ret    

80106641 <sys_wait>:

int
sys_wait(void)
{
80106641:	55                   	push   %ebp
80106642:	89 e5                	mov    %esp,%ebp
80106644:	83 ec 08             	sub    $0x8,%esp
  return wait();
80106647:	e8 e5 e4 ff ff       	call   80104b31 <wait>
}
8010664c:	c9                   	leave  
8010664d:	c3                   	ret    

8010664e <sys_kill>:

int
sys_kill(void)
{
8010664e:	55                   	push   %ebp
8010664f:	89 e5                	mov    %esp,%ebp
80106651:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106654:	83 ec 08             	sub    $0x8,%esp
80106657:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010665a:	50                   	push   %eax
8010665b:	6a 00                	push   $0x0
8010665d:	e8 f2 f0 ff ff       	call   80105754 <argint>
80106662:	83 c4 10             	add    $0x10,%esp
80106665:	85 c0                	test   %eax,%eax
80106667:	79 07                	jns    80106670 <sys_kill+0x22>
    return -1;
80106669:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010666e:	eb 0f                	jmp    8010667f <sys_kill+0x31>
  return kill(pid);
80106670:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106673:	83 ec 0c             	sub    $0xc,%esp
80106676:	50                   	push   %eax
80106677:	e8 69 e9 ff ff       	call   80104fe5 <kill>
8010667c:	83 c4 10             	add    $0x10,%esp
}
8010667f:	c9                   	leave  
80106680:	c3                   	ret    

80106681 <sys_getpid>:

int
sys_getpid(void)
{
80106681:	55                   	push   %ebp
80106682:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80106684:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010668a:	8b 40 10             	mov    0x10(%eax),%eax
}
8010668d:	5d                   	pop    %ebp
8010668e:	c3                   	ret    

8010668f <sys_sbrk>:

int
sys_sbrk(void)
{
8010668f:	55                   	push   %ebp
80106690:	89 e5                	mov    %esp,%ebp
80106692:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106695:	83 ec 08             	sub    $0x8,%esp
80106698:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010669b:	50                   	push   %eax
8010669c:	6a 00                	push   $0x0
8010669e:	e8 b1 f0 ff ff       	call   80105754 <argint>
801066a3:	83 c4 10             	add    $0x10,%esp
801066a6:	85 c0                	test   %eax,%eax
801066a8:	79 07                	jns    801066b1 <sys_sbrk+0x22>
    return -1;
801066aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066af:	eb 28                	jmp    801066d9 <sys_sbrk+0x4a>
  addr = proc->sz;
801066b1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801066b7:	8b 00                	mov    (%eax),%eax
801066b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
801066bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801066bf:	83 ec 0c             	sub    $0xc,%esp
801066c2:	50                   	push   %eax
801066c3:	e8 88 e0 ff ff       	call   80104750 <growproc>
801066c8:	83 c4 10             	add    $0x10,%esp
801066cb:	85 c0                	test   %eax,%eax
801066cd:	79 07                	jns    801066d6 <sys_sbrk+0x47>
    return -1;
801066cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066d4:	eb 03                	jmp    801066d9 <sys_sbrk+0x4a>
  return addr;
801066d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801066d9:	c9                   	leave  
801066da:	c3                   	ret    

801066db <sys_sleep>:

int
sys_sleep(void)
{
801066db:	55                   	push   %ebp
801066dc:	89 e5                	mov    %esp,%ebp
801066de:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
801066e1:	83 ec 08             	sub    $0x8,%esp
801066e4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801066e7:	50                   	push   %eax
801066e8:	6a 00                	push   $0x0
801066ea:	e8 65 f0 ff ff       	call   80105754 <argint>
801066ef:	83 c4 10             	add    $0x10,%esp
801066f2:	85 c0                	test   %eax,%eax
801066f4:	79 07                	jns    801066fd <sys_sleep+0x22>
    return -1;
801066f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066fb:	eb 77                	jmp    80106774 <sys_sleep+0x99>
  acquire(&tickslock);
801066fd:	83 ec 0c             	sub    $0xc,%esp
80106700:	68 a0 4a 11 80       	push   $0x80114aa0
80106705:	e8 c2 ea ff ff       	call   801051cc <acquire>
8010670a:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
8010670d:	a1 e0 52 11 80       	mov    0x801152e0,%eax
80106712:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106715:	eb 39                	jmp    80106750 <sys_sleep+0x75>
    if(proc->killed){
80106717:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010671d:	8b 40 24             	mov    0x24(%eax),%eax
80106720:	85 c0                	test   %eax,%eax
80106722:	74 17                	je     8010673b <sys_sleep+0x60>
      release(&tickslock);
80106724:	83 ec 0c             	sub    $0xc,%esp
80106727:	68 a0 4a 11 80       	push   $0x80114aa0
8010672c:	e8 02 eb ff ff       	call   80105233 <release>
80106731:	83 c4 10             	add    $0x10,%esp
      return -1;
80106734:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106739:	eb 39                	jmp    80106774 <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
8010673b:	83 ec 08             	sub    $0x8,%esp
8010673e:	68 a0 4a 11 80       	push   $0x80114aa0
80106743:	68 e0 52 11 80       	push   $0x801152e0
80106748:	e8 73 e7 ff ff       	call   80104ec0 <sleep>
8010674d:	83 c4 10             	add    $0x10,%esp
  while(ticks - ticks0 < n){
80106750:	a1 e0 52 11 80       	mov    0x801152e0,%eax
80106755:	2b 45 f4             	sub    -0xc(%ebp),%eax
80106758:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010675b:	39 d0                	cmp    %edx,%eax
8010675d:	72 b8                	jb     80106717 <sys_sleep+0x3c>
  }
  release(&tickslock);
8010675f:	83 ec 0c             	sub    $0xc,%esp
80106762:	68 a0 4a 11 80       	push   $0x80114aa0
80106767:	e8 c7 ea ff ff       	call   80105233 <release>
8010676c:	83 c4 10             	add    $0x10,%esp
  return 0;
8010676f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106774:	c9                   	leave  
80106775:	c3                   	ret    

80106776 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106776:	55                   	push   %ebp
80106777:	89 e5                	mov    %esp,%ebp
80106779:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
8010677c:	83 ec 0c             	sub    $0xc,%esp
8010677f:	68 a0 4a 11 80       	push   $0x80114aa0
80106784:	e8 43 ea ff ff       	call   801051cc <acquire>
80106789:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
8010678c:	a1 e0 52 11 80       	mov    0x801152e0,%eax
80106791:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106794:	83 ec 0c             	sub    $0xc,%esp
80106797:	68 a0 4a 11 80       	push   $0x80114aa0
8010679c:	e8 92 ea ff ff       	call   80105233 <release>
801067a1:	83 c4 10             	add    $0x10,%esp
  return xticks;
801067a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801067a7:	c9                   	leave  
801067a8:	c3                   	ret    

801067a9 <outb>:
{
801067a9:	55                   	push   %ebp
801067aa:	89 e5                	mov    %esp,%ebp
801067ac:	83 ec 08             	sub    $0x8,%esp
801067af:	8b 45 08             	mov    0x8(%ebp),%eax
801067b2:	8b 55 0c             	mov    0xc(%ebp),%edx
801067b5:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801067b9:	89 d0                	mov    %edx,%eax
801067bb:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801067be:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801067c2:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801067c6:	ee                   	out    %al,(%dx)
}
801067c7:	90                   	nop
801067c8:	c9                   	leave  
801067c9:	c3                   	ret    

801067ca <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801067ca:	55                   	push   %ebp
801067cb:	89 e5                	mov    %esp,%ebp
801067cd:	83 ec 08             	sub    $0x8,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
801067d0:	6a 34                	push   $0x34
801067d2:	6a 43                	push   $0x43
801067d4:	e8 d0 ff ff ff       	call   801067a9 <outb>
801067d9:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
801067dc:	68 9c 00 00 00       	push   $0x9c
801067e1:	6a 40                	push   $0x40
801067e3:	e8 c1 ff ff ff       	call   801067a9 <outb>
801067e8:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
801067eb:	6a 2e                	push   $0x2e
801067ed:	6a 40                	push   $0x40
801067ef:	e8 b5 ff ff ff       	call   801067a9 <outb>
801067f4:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
801067f7:	83 ec 0c             	sub    $0xc,%esp
801067fa:	6a 00                	push   $0x0
801067fc:	e8 2f d7 ff ff       	call   80103f30 <picenable>
80106801:	83 c4 10             	add    $0x10,%esp
}
80106804:	90                   	nop
80106805:	c9                   	leave  
80106806:	c3                   	ret    

80106807 <alltraps>:
80106807:	1e                   	push   %ds
80106808:	06                   	push   %es
80106809:	0f a0                	push   %fs
8010680b:	0f a8                	push   %gs
8010680d:	60                   	pusha  
8010680e:	66 b8 10 00          	mov    $0x10,%ax
80106812:	8e d8                	mov    %eax,%ds
80106814:	8e c0                	mov    %eax,%es
80106816:	66 b8 18 00          	mov    $0x18,%ax
8010681a:	8e e0                	mov    %eax,%fs
8010681c:	8e e8                	mov    %eax,%gs
8010681e:	54                   	push   %esp
8010681f:	e8 d7 01 00 00       	call   801069fb <trap>
80106824:	83 c4 04             	add    $0x4,%esp

80106827 <trapret>:
80106827:	61                   	popa   
80106828:	0f a9                	pop    %gs
8010682a:	0f a1                	pop    %fs
8010682c:	07                   	pop    %es
8010682d:	1f                   	pop    %ds
8010682e:	83 c4 08             	add    $0x8,%esp
80106831:	cf                   	iret   

80106832 <lidt>:
{
80106832:	55                   	push   %ebp
80106833:	89 e5                	mov    %esp,%ebp
80106835:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80106838:	8b 45 0c             	mov    0xc(%ebp),%eax
8010683b:	83 e8 01             	sub    $0x1,%eax
8010683e:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106842:	8b 45 08             	mov    0x8(%ebp),%eax
80106845:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106849:	8b 45 08             	mov    0x8(%ebp),%eax
8010684c:	c1 e8 10             	shr    $0x10,%eax
8010684f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106853:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106856:	0f 01 18             	lidtl  (%eax)
}
80106859:	90                   	nop
8010685a:	c9                   	leave  
8010685b:	c3                   	ret    

8010685c <rcr2>:

static inline uint
rcr2(void)
{
8010685c:	55                   	push   %ebp
8010685d:	89 e5                	mov    %esp,%ebp
8010685f:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106862:	0f 20 d0             	mov    %cr2,%eax
80106865:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80106868:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010686b:	c9                   	leave  
8010686c:	c3                   	ret    

8010686d <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010686d:	55                   	push   %ebp
8010686e:	89 e5                	mov    %esp,%ebp
80106870:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
80106873:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010687a:	e9 c3 00 00 00       	jmp    80106942 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
8010687f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106882:	8b 04 85 98 b0 10 80 	mov    -0x7fef4f68(,%eax,4),%eax
80106889:	89 c2                	mov    %eax,%edx
8010688b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010688e:	66 89 14 c5 e0 4a 11 	mov    %dx,-0x7feeb520(,%eax,8)
80106895:	80 
80106896:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106899:	66 c7 04 c5 e2 4a 11 	movw   $0x8,-0x7feeb51e(,%eax,8)
801068a0:	80 08 00 
801068a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068a6:	0f b6 14 c5 e4 4a 11 	movzbl -0x7feeb51c(,%eax,8),%edx
801068ad:	80 
801068ae:	83 e2 e0             	and    $0xffffffe0,%edx
801068b1:	88 14 c5 e4 4a 11 80 	mov    %dl,-0x7feeb51c(,%eax,8)
801068b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068bb:	0f b6 14 c5 e4 4a 11 	movzbl -0x7feeb51c(,%eax,8),%edx
801068c2:	80 
801068c3:	83 e2 1f             	and    $0x1f,%edx
801068c6:	88 14 c5 e4 4a 11 80 	mov    %dl,-0x7feeb51c(,%eax,8)
801068cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068d0:	0f b6 14 c5 e5 4a 11 	movzbl -0x7feeb51b(,%eax,8),%edx
801068d7:	80 
801068d8:	83 e2 f0             	and    $0xfffffff0,%edx
801068db:	83 ca 0e             	or     $0xe,%edx
801068de:	88 14 c5 e5 4a 11 80 	mov    %dl,-0x7feeb51b(,%eax,8)
801068e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068e8:	0f b6 14 c5 e5 4a 11 	movzbl -0x7feeb51b(,%eax,8),%edx
801068ef:	80 
801068f0:	83 e2 ef             	and    $0xffffffef,%edx
801068f3:	88 14 c5 e5 4a 11 80 	mov    %dl,-0x7feeb51b(,%eax,8)
801068fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068fd:	0f b6 14 c5 e5 4a 11 	movzbl -0x7feeb51b(,%eax,8),%edx
80106904:	80 
80106905:	83 e2 9f             	and    $0xffffff9f,%edx
80106908:	88 14 c5 e5 4a 11 80 	mov    %dl,-0x7feeb51b(,%eax,8)
8010690f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106912:	0f b6 14 c5 e5 4a 11 	movzbl -0x7feeb51b(,%eax,8),%edx
80106919:	80 
8010691a:	83 ca 80             	or     $0xffffff80,%edx
8010691d:	88 14 c5 e5 4a 11 80 	mov    %dl,-0x7feeb51b(,%eax,8)
80106924:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106927:	8b 04 85 98 b0 10 80 	mov    -0x7fef4f68(,%eax,4),%eax
8010692e:	c1 e8 10             	shr    $0x10,%eax
80106931:	89 c2                	mov    %eax,%edx
80106933:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106936:	66 89 14 c5 e6 4a 11 	mov    %dx,-0x7feeb51a(,%eax,8)
8010693d:	80 
  for(i = 0; i < 256; i++)
8010693e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106942:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80106949:	0f 8e 30 ff ff ff    	jle    8010687f <tvinit+0x12>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010694f:	a1 98 b1 10 80       	mov    0x8010b198,%eax
80106954:	66 a3 e0 4c 11 80    	mov    %ax,0x80114ce0
8010695a:	66 c7 05 e2 4c 11 80 	movw   $0x8,0x80114ce2
80106961:	08 00 
80106963:	0f b6 05 e4 4c 11 80 	movzbl 0x80114ce4,%eax
8010696a:	83 e0 e0             	and    $0xffffffe0,%eax
8010696d:	a2 e4 4c 11 80       	mov    %al,0x80114ce4
80106972:	0f b6 05 e4 4c 11 80 	movzbl 0x80114ce4,%eax
80106979:	83 e0 1f             	and    $0x1f,%eax
8010697c:	a2 e4 4c 11 80       	mov    %al,0x80114ce4
80106981:	0f b6 05 e5 4c 11 80 	movzbl 0x80114ce5,%eax
80106988:	83 c8 0f             	or     $0xf,%eax
8010698b:	a2 e5 4c 11 80       	mov    %al,0x80114ce5
80106990:	0f b6 05 e5 4c 11 80 	movzbl 0x80114ce5,%eax
80106997:	83 e0 ef             	and    $0xffffffef,%eax
8010699a:	a2 e5 4c 11 80       	mov    %al,0x80114ce5
8010699f:	0f b6 05 e5 4c 11 80 	movzbl 0x80114ce5,%eax
801069a6:	83 c8 60             	or     $0x60,%eax
801069a9:	a2 e5 4c 11 80       	mov    %al,0x80114ce5
801069ae:	0f b6 05 e5 4c 11 80 	movzbl 0x80114ce5,%eax
801069b5:	83 c8 80             	or     $0xffffff80,%eax
801069b8:	a2 e5 4c 11 80       	mov    %al,0x80114ce5
801069bd:	a1 98 b1 10 80       	mov    0x8010b198,%eax
801069c2:	c1 e8 10             	shr    $0x10,%eax
801069c5:	66 a3 e6 4c 11 80    	mov    %ax,0x80114ce6
  
  initlock(&tickslock, "time");
801069cb:	83 ec 08             	sub    $0x8,%esp
801069ce:	68 40 8c 10 80       	push   $0x80108c40
801069d3:	68 a0 4a 11 80       	push   $0x80114aa0
801069d8:	e8 cd e7 ff ff       	call   801051aa <initlock>
801069dd:	83 c4 10             	add    $0x10,%esp
}
801069e0:	90                   	nop
801069e1:	c9                   	leave  
801069e2:	c3                   	ret    

801069e3 <idtinit>:

void
idtinit(void)
{
801069e3:	55                   	push   %ebp
801069e4:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
801069e6:	68 00 08 00 00       	push   $0x800
801069eb:	68 e0 4a 11 80       	push   $0x80114ae0
801069f0:	e8 3d fe ff ff       	call   80106832 <lidt>
801069f5:	83 c4 08             	add    $0x8,%esp
}
801069f8:	90                   	nop
801069f9:	c9                   	leave  
801069fa:	c3                   	ret    

801069fb <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801069fb:	55                   	push   %ebp
801069fc:	89 e5                	mov    %esp,%ebp
801069fe:	57                   	push   %edi
801069ff:	56                   	push   %esi
80106a00:	53                   	push   %ebx
80106a01:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80106a04:	8b 45 08             	mov    0x8(%ebp),%eax
80106a07:	8b 40 30             	mov    0x30(%eax),%eax
80106a0a:	83 f8 40             	cmp    $0x40,%eax
80106a0d:	75 3e                	jne    80106a4d <trap+0x52>
    if(proc->killed)
80106a0f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a15:	8b 40 24             	mov    0x24(%eax),%eax
80106a18:	85 c0                	test   %eax,%eax
80106a1a:	74 05                	je     80106a21 <trap+0x26>
      exit();
80106a1c:	e8 d5 df ff ff       	call   801049f6 <exit>
    proc->tf = tf;
80106a21:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a27:	8b 55 08             	mov    0x8(%ebp),%edx
80106a2a:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106a2d:	e8 d8 ed ff ff       	call   8010580a <syscall>
    if(proc->killed)
80106a32:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a38:	8b 40 24             	mov    0x24(%eax),%eax
80106a3b:	85 c0                	test   %eax,%eax
80106a3d:	0f 84 1b 02 00 00    	je     80106c5e <trap+0x263>
      exit();
80106a43:	e8 ae df ff ff       	call   801049f6 <exit>
    return;
80106a48:	e9 11 02 00 00       	jmp    80106c5e <trap+0x263>
  }

  switch(tf->trapno){
80106a4d:	8b 45 08             	mov    0x8(%ebp),%eax
80106a50:	8b 40 30             	mov    0x30(%eax),%eax
80106a53:	83 e8 20             	sub    $0x20,%eax
80106a56:	83 f8 1f             	cmp    $0x1f,%eax
80106a59:	0f 87 c0 00 00 00    	ja     80106b1f <trap+0x124>
80106a5f:	8b 04 85 e8 8c 10 80 	mov    -0x7fef7318(,%eax,4),%eax
80106a66:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80106a68:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106a6e:	0f b6 00             	movzbl (%eax),%eax
80106a71:	84 c0                	test   %al,%al
80106a73:	75 3d                	jne    80106ab2 <trap+0xb7>
      acquire(&tickslock);
80106a75:	83 ec 0c             	sub    $0xc,%esp
80106a78:	68 a0 4a 11 80       	push   $0x80114aa0
80106a7d:	e8 4a e7 ff ff       	call   801051cc <acquire>
80106a82:	83 c4 10             	add    $0x10,%esp
      ticks++;
80106a85:	a1 e0 52 11 80       	mov    0x801152e0,%eax
80106a8a:	83 c0 01             	add    $0x1,%eax
80106a8d:	a3 e0 52 11 80       	mov    %eax,0x801152e0
      wakeup(&ticks);
80106a92:	83 ec 0c             	sub    $0xc,%esp
80106a95:	68 e0 52 11 80       	push   $0x801152e0
80106a9a:	e8 0f e5 ff ff       	call   80104fae <wakeup>
80106a9f:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80106aa2:	83 ec 0c             	sub    $0xc,%esp
80106aa5:	68 a0 4a 11 80       	push   $0x80114aa0
80106aaa:	e8 84 e7 ff ff       	call   80105233 <release>
80106aaf:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80106ab2:	e8 75 c5 ff ff       	call   8010302c <lapiceoi>
    break;
80106ab7:	e9 1c 01 00 00       	jmp    80106bd8 <trap+0x1dd>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106abc:	e8 7b bd ff ff       	call   8010283c <ideintr>
    lapiceoi();
80106ac1:	e8 66 c5 ff ff       	call   8010302c <lapiceoi>
    break;
80106ac6:	e9 0d 01 00 00       	jmp    80106bd8 <trap+0x1dd>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106acb:	e8 5b c3 ff ff       	call   80102e2b <kbdintr>
    lapiceoi();
80106ad0:	e8 57 c5 ff ff       	call   8010302c <lapiceoi>
    break;
80106ad5:	e9 fe 00 00 00       	jmp    80106bd8 <trap+0x1dd>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106ada:	e8 62 03 00 00       	call   80106e41 <uartintr>
    lapiceoi();
80106adf:	e8 48 c5 ff ff       	call   8010302c <lapiceoi>
    break;
80106ae4:	e9 ef 00 00 00       	jmp    80106bd8 <trap+0x1dd>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106ae9:	8b 45 08             	mov    0x8(%ebp),%eax
80106aec:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106aef:	8b 45 08             	mov    0x8(%ebp),%eax
80106af2:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106af6:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106af9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106aff:	0f b6 00             	movzbl (%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106b02:	0f b6 c0             	movzbl %al,%eax
80106b05:	51                   	push   %ecx
80106b06:	52                   	push   %edx
80106b07:	50                   	push   %eax
80106b08:	68 48 8c 10 80       	push   $0x80108c48
80106b0d:	e8 b2 98 ff ff       	call   801003c4 <cprintf>
80106b12:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106b15:	e8 12 c5 ff ff       	call   8010302c <lapiceoi>
    break;
80106b1a:	e9 b9 00 00 00       	jmp    80106bd8 <trap+0x1dd>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106b1f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b25:	85 c0                	test   %eax,%eax
80106b27:	74 11                	je     80106b3a <trap+0x13f>
80106b29:	8b 45 08             	mov    0x8(%ebp),%eax
80106b2c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106b30:	0f b7 c0             	movzwl %ax,%eax
80106b33:	83 e0 03             	and    $0x3,%eax
80106b36:	85 c0                	test   %eax,%eax
80106b38:	75 40                	jne    80106b7a <trap+0x17f>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106b3a:	e8 1d fd ff ff       	call   8010685c <rcr2>
80106b3f:	89 c3                	mov    %eax,%ebx
80106b41:	8b 45 08             	mov    0x8(%ebp),%eax
80106b44:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106b47:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106b4d:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106b50:	0f b6 d0             	movzbl %al,%edx
80106b53:	8b 45 08             	mov    0x8(%ebp),%eax
80106b56:	8b 40 30             	mov    0x30(%eax),%eax
80106b59:	83 ec 0c             	sub    $0xc,%esp
80106b5c:	53                   	push   %ebx
80106b5d:	51                   	push   %ecx
80106b5e:	52                   	push   %edx
80106b5f:	50                   	push   %eax
80106b60:	68 6c 8c 10 80       	push   $0x80108c6c
80106b65:	e8 5a 98 ff ff       	call   801003c4 <cprintf>
80106b6a:	83 c4 20             	add    $0x20,%esp
      panic("trap");
80106b6d:	83 ec 0c             	sub    $0xc,%esp
80106b70:	68 9e 8c 10 80       	push   $0x80108c9e
80106b75:	e8 ed 99 ff ff       	call   80100567 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106b7a:	e8 dd fc ff ff       	call   8010685c <rcr2>
80106b7f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b82:	8b 45 08             	mov    0x8(%ebp),%eax
80106b85:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106b88:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106b8e:	0f b6 00             	movzbl (%eax),%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106b91:	0f b6 d8             	movzbl %al,%ebx
80106b94:	8b 45 08             	mov    0x8(%ebp),%eax
80106b97:	8b 48 34             	mov    0x34(%eax),%ecx
80106b9a:	8b 45 08             	mov    0x8(%ebp),%eax
80106b9d:	8b 50 30             	mov    0x30(%eax),%edx
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106ba0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ba6:	8d 78 74             	lea    0x74(%eax),%edi
80106ba9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106baf:	8b 40 10             	mov    0x10(%eax),%eax
80106bb2:	ff 75 e4             	pushl  -0x1c(%ebp)
80106bb5:	56                   	push   %esi
80106bb6:	53                   	push   %ebx
80106bb7:	51                   	push   %ecx
80106bb8:	52                   	push   %edx
80106bb9:	57                   	push   %edi
80106bba:	50                   	push   %eax
80106bbb:	68 a4 8c 10 80       	push   $0x80108ca4
80106bc0:	e8 ff 97 ff ff       	call   801003c4 <cprintf>
80106bc5:	83 c4 20             	add    $0x20,%esp
            rcr2());
    proc->killed = 1;
80106bc8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106bce:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106bd5:	eb 01                	jmp    80106bd8 <trap+0x1dd>
    break;
80106bd7:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106bd8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106bde:	85 c0                	test   %eax,%eax
80106be0:	74 24                	je     80106c06 <trap+0x20b>
80106be2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106be8:	8b 40 24             	mov    0x24(%eax),%eax
80106beb:	85 c0                	test   %eax,%eax
80106bed:	74 17                	je     80106c06 <trap+0x20b>
80106bef:	8b 45 08             	mov    0x8(%ebp),%eax
80106bf2:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106bf6:	0f b7 c0             	movzwl %ax,%eax
80106bf9:	83 e0 03             	and    $0x3,%eax
80106bfc:	83 f8 03             	cmp    $0x3,%eax
80106bff:	75 05                	jne    80106c06 <trap+0x20b>
    exit();
80106c01:	e8 f0 dd ff ff       	call   801049f6 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106c06:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c0c:	85 c0                	test   %eax,%eax
80106c0e:	74 1e                	je     80106c2e <trap+0x233>
80106c10:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c16:	8b 40 0c             	mov    0xc(%eax),%eax
80106c19:	83 f8 04             	cmp    $0x4,%eax
80106c1c:	75 10                	jne    80106c2e <trap+0x233>
80106c1e:	8b 45 08             	mov    0x8(%ebp),%eax
80106c21:	8b 40 30             	mov    0x30(%eax),%eax
80106c24:	83 f8 20             	cmp    $0x20,%eax
80106c27:	75 05                	jne    80106c2e <trap+0x233>
    yield();
80106c29:	e8 11 e2 ff ff       	call   80104e3f <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106c2e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c34:	85 c0                	test   %eax,%eax
80106c36:	74 27                	je     80106c5f <trap+0x264>
80106c38:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c3e:	8b 40 24             	mov    0x24(%eax),%eax
80106c41:	85 c0                	test   %eax,%eax
80106c43:	74 1a                	je     80106c5f <trap+0x264>
80106c45:	8b 45 08             	mov    0x8(%ebp),%eax
80106c48:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106c4c:	0f b7 c0             	movzwl %ax,%eax
80106c4f:	83 e0 03             	and    $0x3,%eax
80106c52:	83 f8 03             	cmp    $0x3,%eax
80106c55:	75 08                	jne    80106c5f <trap+0x264>
    exit();
80106c57:	e8 9a dd ff ff       	call   801049f6 <exit>
80106c5c:	eb 01                	jmp    80106c5f <trap+0x264>
    return;
80106c5e:	90                   	nop
}
80106c5f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c62:	5b                   	pop    %ebx
80106c63:	5e                   	pop    %esi
80106c64:	5f                   	pop    %edi
80106c65:	5d                   	pop    %ebp
80106c66:	c3                   	ret    

80106c67 <inb>:
{
80106c67:	55                   	push   %ebp
80106c68:	89 e5                	mov    %esp,%ebp
80106c6a:	83 ec 14             	sub    $0x14,%esp
80106c6d:	8b 45 08             	mov    0x8(%ebp),%eax
80106c70:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106c74:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106c78:	89 c2                	mov    %eax,%edx
80106c7a:	ec                   	in     (%dx),%al
80106c7b:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106c7e:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106c82:	c9                   	leave  
80106c83:	c3                   	ret    

80106c84 <outb>:
{
80106c84:	55                   	push   %ebp
80106c85:	89 e5                	mov    %esp,%ebp
80106c87:	83 ec 08             	sub    $0x8,%esp
80106c8a:	8b 45 08             	mov    0x8(%ebp),%eax
80106c8d:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c90:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80106c94:	89 d0                	mov    %edx,%eax
80106c96:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106c99:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106c9d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106ca1:	ee                   	out    %al,(%dx)
}
80106ca2:	90                   	nop
80106ca3:	c9                   	leave  
80106ca4:	c3                   	ret    

80106ca5 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106ca5:	55                   	push   %ebp
80106ca6:	89 e5                	mov    %esp,%ebp
80106ca8:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106cab:	6a 00                	push   $0x0
80106cad:	68 fa 03 00 00       	push   $0x3fa
80106cb2:	e8 cd ff ff ff       	call   80106c84 <outb>
80106cb7:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106cba:	68 80 00 00 00       	push   $0x80
80106cbf:	68 fb 03 00 00       	push   $0x3fb
80106cc4:	e8 bb ff ff ff       	call   80106c84 <outb>
80106cc9:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80106ccc:	6a 0c                	push   $0xc
80106cce:	68 f8 03 00 00       	push   $0x3f8
80106cd3:	e8 ac ff ff ff       	call   80106c84 <outb>
80106cd8:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80106cdb:	6a 00                	push   $0x0
80106cdd:	68 f9 03 00 00       	push   $0x3f9
80106ce2:	e8 9d ff ff ff       	call   80106c84 <outb>
80106ce7:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106cea:	6a 03                	push   $0x3
80106cec:	68 fb 03 00 00       	push   $0x3fb
80106cf1:	e8 8e ff ff ff       	call   80106c84 <outb>
80106cf6:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106cf9:	6a 00                	push   $0x0
80106cfb:	68 fc 03 00 00       	push   $0x3fc
80106d00:	e8 7f ff ff ff       	call   80106c84 <outb>
80106d05:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106d08:	6a 01                	push   $0x1
80106d0a:	68 f9 03 00 00       	push   $0x3f9
80106d0f:	e8 70 ff ff ff       	call   80106c84 <outb>
80106d14:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106d17:	68 fd 03 00 00       	push   $0x3fd
80106d1c:	e8 46 ff ff ff       	call   80106c67 <inb>
80106d21:	83 c4 04             	add    $0x4,%esp
80106d24:	3c ff                	cmp    $0xff,%al
80106d26:	74 6e                	je     80106d96 <uartinit+0xf1>
    return;
  uart = 1;
80106d28:	c7 05 4c b6 10 80 01 	movl   $0x1,0x8010b64c
80106d2f:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106d32:	68 fa 03 00 00       	push   $0x3fa
80106d37:	e8 2b ff ff ff       	call   80106c67 <inb>
80106d3c:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106d3f:	68 f8 03 00 00       	push   $0x3f8
80106d44:	e8 1e ff ff ff       	call   80106c67 <inb>
80106d49:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80106d4c:	83 ec 0c             	sub    $0xc,%esp
80106d4f:	6a 04                	push   $0x4
80106d51:	e8 da d1 ff ff       	call   80103f30 <picenable>
80106d56:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
80106d59:	83 ec 08             	sub    $0x8,%esp
80106d5c:	6a 00                	push   $0x0
80106d5e:	6a 04                	push   $0x4
80106d60:	e8 79 bd ff ff       	call   80102ade <ioapicenable>
80106d65:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106d68:	c7 45 f4 68 8d 10 80 	movl   $0x80108d68,-0xc(%ebp)
80106d6f:	eb 19                	jmp    80106d8a <uartinit+0xe5>
    uartputc(*p);
80106d71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d74:	0f b6 00             	movzbl (%eax),%eax
80106d77:	0f be c0             	movsbl %al,%eax
80106d7a:	83 ec 0c             	sub    $0xc,%esp
80106d7d:	50                   	push   %eax
80106d7e:	e8 16 00 00 00       	call   80106d99 <uartputc>
80106d83:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106d86:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106d8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d8d:	0f b6 00             	movzbl (%eax),%eax
80106d90:	84 c0                	test   %al,%al
80106d92:	75 dd                	jne    80106d71 <uartinit+0xcc>
80106d94:	eb 01                	jmp    80106d97 <uartinit+0xf2>
    return;
80106d96:	90                   	nop
}
80106d97:	c9                   	leave  
80106d98:	c3                   	ret    

80106d99 <uartputc>:

void
uartputc(int c)
{
80106d99:	55                   	push   %ebp
80106d9a:	89 e5                	mov    %esp,%ebp
80106d9c:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80106d9f:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106da4:	85 c0                	test   %eax,%eax
80106da6:	74 53                	je     80106dfb <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106da8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106daf:	eb 11                	jmp    80106dc2 <uartputc+0x29>
    microdelay(10);
80106db1:	83 ec 0c             	sub    $0xc,%esp
80106db4:	6a 0a                	push   $0xa
80106db6:	e8 8c c2 ff ff       	call   80103047 <microdelay>
80106dbb:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106dbe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106dc2:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106dc6:	7f 1a                	jg     80106de2 <uartputc+0x49>
80106dc8:	83 ec 0c             	sub    $0xc,%esp
80106dcb:	68 fd 03 00 00       	push   $0x3fd
80106dd0:	e8 92 fe ff ff       	call   80106c67 <inb>
80106dd5:	83 c4 10             	add    $0x10,%esp
80106dd8:	0f b6 c0             	movzbl %al,%eax
80106ddb:	83 e0 20             	and    $0x20,%eax
80106dde:	85 c0                	test   %eax,%eax
80106de0:	74 cf                	je     80106db1 <uartputc+0x18>
  outb(COM1+0, c);
80106de2:	8b 45 08             	mov    0x8(%ebp),%eax
80106de5:	0f b6 c0             	movzbl %al,%eax
80106de8:	83 ec 08             	sub    $0x8,%esp
80106deb:	50                   	push   %eax
80106dec:	68 f8 03 00 00       	push   $0x3f8
80106df1:	e8 8e fe ff ff       	call   80106c84 <outb>
80106df6:	83 c4 10             	add    $0x10,%esp
80106df9:	eb 01                	jmp    80106dfc <uartputc+0x63>
    return;
80106dfb:	90                   	nop
}
80106dfc:	c9                   	leave  
80106dfd:	c3                   	ret    

80106dfe <uartgetc>:

static int
uartgetc(void)
{
80106dfe:	55                   	push   %ebp
80106dff:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106e01:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106e06:	85 c0                	test   %eax,%eax
80106e08:	75 07                	jne    80106e11 <uartgetc+0x13>
    return -1;
80106e0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e0f:	eb 2e                	jmp    80106e3f <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106e11:	68 fd 03 00 00       	push   $0x3fd
80106e16:	e8 4c fe ff ff       	call   80106c67 <inb>
80106e1b:	83 c4 04             	add    $0x4,%esp
80106e1e:	0f b6 c0             	movzbl %al,%eax
80106e21:	83 e0 01             	and    $0x1,%eax
80106e24:	85 c0                	test   %eax,%eax
80106e26:	75 07                	jne    80106e2f <uartgetc+0x31>
    return -1;
80106e28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e2d:	eb 10                	jmp    80106e3f <uartgetc+0x41>
  return inb(COM1+0);
80106e2f:	68 f8 03 00 00       	push   $0x3f8
80106e34:	e8 2e fe ff ff       	call   80106c67 <inb>
80106e39:	83 c4 04             	add    $0x4,%esp
80106e3c:	0f b6 c0             	movzbl %al,%eax
}
80106e3f:	c9                   	leave  
80106e40:	c3                   	ret    

80106e41 <uartintr>:

void
uartintr(void)
{
80106e41:	55                   	push   %ebp
80106e42:	89 e5                	mov    %esp,%ebp
80106e44:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80106e47:	83 ec 0c             	sub    $0xc,%esp
80106e4a:	68 fe 6d 10 80       	push   $0x80106dfe
80106e4f:	e8 ae 99 ff ff       	call   80100802 <consoleintr>
80106e54:	83 c4 10             	add    $0x10,%esp
}
80106e57:	90                   	nop
80106e58:	c9                   	leave  
80106e59:	c3                   	ret    

80106e5a <vector0>:
80106e5a:	6a 00                	push   $0x0
80106e5c:	6a 00                	push   $0x0
80106e5e:	e9 a4 f9 ff ff       	jmp    80106807 <alltraps>

80106e63 <vector1>:
80106e63:	6a 00                	push   $0x0
80106e65:	6a 01                	push   $0x1
80106e67:	e9 9b f9 ff ff       	jmp    80106807 <alltraps>

80106e6c <vector2>:
80106e6c:	6a 00                	push   $0x0
80106e6e:	6a 02                	push   $0x2
80106e70:	e9 92 f9 ff ff       	jmp    80106807 <alltraps>

80106e75 <vector3>:
80106e75:	6a 00                	push   $0x0
80106e77:	6a 03                	push   $0x3
80106e79:	e9 89 f9 ff ff       	jmp    80106807 <alltraps>

80106e7e <vector4>:
80106e7e:	6a 00                	push   $0x0
80106e80:	6a 04                	push   $0x4
80106e82:	e9 80 f9 ff ff       	jmp    80106807 <alltraps>

80106e87 <vector5>:
80106e87:	6a 00                	push   $0x0
80106e89:	6a 05                	push   $0x5
80106e8b:	e9 77 f9 ff ff       	jmp    80106807 <alltraps>

80106e90 <vector6>:
80106e90:	6a 00                	push   $0x0
80106e92:	6a 06                	push   $0x6
80106e94:	e9 6e f9 ff ff       	jmp    80106807 <alltraps>

80106e99 <vector7>:
80106e99:	6a 00                	push   $0x0
80106e9b:	6a 07                	push   $0x7
80106e9d:	e9 65 f9 ff ff       	jmp    80106807 <alltraps>

80106ea2 <vector8>:
80106ea2:	6a 08                	push   $0x8
80106ea4:	e9 5e f9 ff ff       	jmp    80106807 <alltraps>

80106ea9 <vector9>:
80106ea9:	6a 00                	push   $0x0
80106eab:	6a 09                	push   $0x9
80106ead:	e9 55 f9 ff ff       	jmp    80106807 <alltraps>

80106eb2 <vector10>:
80106eb2:	6a 0a                	push   $0xa
80106eb4:	e9 4e f9 ff ff       	jmp    80106807 <alltraps>

80106eb9 <vector11>:
80106eb9:	6a 0b                	push   $0xb
80106ebb:	e9 47 f9 ff ff       	jmp    80106807 <alltraps>

80106ec0 <vector12>:
80106ec0:	6a 0c                	push   $0xc
80106ec2:	e9 40 f9 ff ff       	jmp    80106807 <alltraps>

80106ec7 <vector13>:
80106ec7:	6a 0d                	push   $0xd
80106ec9:	e9 39 f9 ff ff       	jmp    80106807 <alltraps>

80106ece <vector14>:
80106ece:	6a 0e                	push   $0xe
80106ed0:	e9 32 f9 ff ff       	jmp    80106807 <alltraps>

80106ed5 <vector15>:
80106ed5:	6a 00                	push   $0x0
80106ed7:	6a 0f                	push   $0xf
80106ed9:	e9 29 f9 ff ff       	jmp    80106807 <alltraps>

80106ede <vector16>:
80106ede:	6a 00                	push   $0x0
80106ee0:	6a 10                	push   $0x10
80106ee2:	e9 20 f9 ff ff       	jmp    80106807 <alltraps>

80106ee7 <vector17>:
80106ee7:	6a 11                	push   $0x11
80106ee9:	e9 19 f9 ff ff       	jmp    80106807 <alltraps>

80106eee <vector18>:
80106eee:	6a 00                	push   $0x0
80106ef0:	6a 12                	push   $0x12
80106ef2:	e9 10 f9 ff ff       	jmp    80106807 <alltraps>

80106ef7 <vector19>:
80106ef7:	6a 00                	push   $0x0
80106ef9:	6a 13                	push   $0x13
80106efb:	e9 07 f9 ff ff       	jmp    80106807 <alltraps>

80106f00 <vector20>:
80106f00:	6a 00                	push   $0x0
80106f02:	6a 14                	push   $0x14
80106f04:	e9 fe f8 ff ff       	jmp    80106807 <alltraps>

80106f09 <vector21>:
80106f09:	6a 00                	push   $0x0
80106f0b:	6a 15                	push   $0x15
80106f0d:	e9 f5 f8 ff ff       	jmp    80106807 <alltraps>

80106f12 <vector22>:
80106f12:	6a 00                	push   $0x0
80106f14:	6a 16                	push   $0x16
80106f16:	e9 ec f8 ff ff       	jmp    80106807 <alltraps>

80106f1b <vector23>:
80106f1b:	6a 00                	push   $0x0
80106f1d:	6a 17                	push   $0x17
80106f1f:	e9 e3 f8 ff ff       	jmp    80106807 <alltraps>

80106f24 <vector24>:
80106f24:	6a 00                	push   $0x0
80106f26:	6a 18                	push   $0x18
80106f28:	e9 da f8 ff ff       	jmp    80106807 <alltraps>

80106f2d <vector25>:
80106f2d:	6a 00                	push   $0x0
80106f2f:	6a 19                	push   $0x19
80106f31:	e9 d1 f8 ff ff       	jmp    80106807 <alltraps>

80106f36 <vector26>:
80106f36:	6a 00                	push   $0x0
80106f38:	6a 1a                	push   $0x1a
80106f3a:	e9 c8 f8 ff ff       	jmp    80106807 <alltraps>

80106f3f <vector27>:
80106f3f:	6a 00                	push   $0x0
80106f41:	6a 1b                	push   $0x1b
80106f43:	e9 bf f8 ff ff       	jmp    80106807 <alltraps>

80106f48 <vector28>:
80106f48:	6a 00                	push   $0x0
80106f4a:	6a 1c                	push   $0x1c
80106f4c:	e9 b6 f8 ff ff       	jmp    80106807 <alltraps>

80106f51 <vector29>:
80106f51:	6a 00                	push   $0x0
80106f53:	6a 1d                	push   $0x1d
80106f55:	e9 ad f8 ff ff       	jmp    80106807 <alltraps>

80106f5a <vector30>:
80106f5a:	6a 00                	push   $0x0
80106f5c:	6a 1e                	push   $0x1e
80106f5e:	e9 a4 f8 ff ff       	jmp    80106807 <alltraps>

80106f63 <vector31>:
80106f63:	6a 00                	push   $0x0
80106f65:	6a 1f                	push   $0x1f
80106f67:	e9 9b f8 ff ff       	jmp    80106807 <alltraps>

80106f6c <vector32>:
80106f6c:	6a 00                	push   $0x0
80106f6e:	6a 20                	push   $0x20
80106f70:	e9 92 f8 ff ff       	jmp    80106807 <alltraps>

80106f75 <vector33>:
80106f75:	6a 00                	push   $0x0
80106f77:	6a 21                	push   $0x21
80106f79:	e9 89 f8 ff ff       	jmp    80106807 <alltraps>

80106f7e <vector34>:
80106f7e:	6a 00                	push   $0x0
80106f80:	6a 22                	push   $0x22
80106f82:	e9 80 f8 ff ff       	jmp    80106807 <alltraps>

80106f87 <vector35>:
80106f87:	6a 00                	push   $0x0
80106f89:	6a 23                	push   $0x23
80106f8b:	e9 77 f8 ff ff       	jmp    80106807 <alltraps>

80106f90 <vector36>:
80106f90:	6a 00                	push   $0x0
80106f92:	6a 24                	push   $0x24
80106f94:	e9 6e f8 ff ff       	jmp    80106807 <alltraps>

80106f99 <vector37>:
80106f99:	6a 00                	push   $0x0
80106f9b:	6a 25                	push   $0x25
80106f9d:	e9 65 f8 ff ff       	jmp    80106807 <alltraps>

80106fa2 <vector38>:
80106fa2:	6a 00                	push   $0x0
80106fa4:	6a 26                	push   $0x26
80106fa6:	e9 5c f8 ff ff       	jmp    80106807 <alltraps>

80106fab <vector39>:
80106fab:	6a 00                	push   $0x0
80106fad:	6a 27                	push   $0x27
80106faf:	e9 53 f8 ff ff       	jmp    80106807 <alltraps>

80106fb4 <vector40>:
80106fb4:	6a 00                	push   $0x0
80106fb6:	6a 28                	push   $0x28
80106fb8:	e9 4a f8 ff ff       	jmp    80106807 <alltraps>

80106fbd <vector41>:
80106fbd:	6a 00                	push   $0x0
80106fbf:	6a 29                	push   $0x29
80106fc1:	e9 41 f8 ff ff       	jmp    80106807 <alltraps>

80106fc6 <vector42>:
80106fc6:	6a 00                	push   $0x0
80106fc8:	6a 2a                	push   $0x2a
80106fca:	e9 38 f8 ff ff       	jmp    80106807 <alltraps>

80106fcf <vector43>:
80106fcf:	6a 00                	push   $0x0
80106fd1:	6a 2b                	push   $0x2b
80106fd3:	e9 2f f8 ff ff       	jmp    80106807 <alltraps>

80106fd8 <vector44>:
80106fd8:	6a 00                	push   $0x0
80106fda:	6a 2c                	push   $0x2c
80106fdc:	e9 26 f8 ff ff       	jmp    80106807 <alltraps>

80106fe1 <vector45>:
80106fe1:	6a 00                	push   $0x0
80106fe3:	6a 2d                	push   $0x2d
80106fe5:	e9 1d f8 ff ff       	jmp    80106807 <alltraps>

80106fea <vector46>:
80106fea:	6a 00                	push   $0x0
80106fec:	6a 2e                	push   $0x2e
80106fee:	e9 14 f8 ff ff       	jmp    80106807 <alltraps>

80106ff3 <vector47>:
80106ff3:	6a 00                	push   $0x0
80106ff5:	6a 2f                	push   $0x2f
80106ff7:	e9 0b f8 ff ff       	jmp    80106807 <alltraps>

80106ffc <vector48>:
80106ffc:	6a 00                	push   $0x0
80106ffe:	6a 30                	push   $0x30
80107000:	e9 02 f8 ff ff       	jmp    80106807 <alltraps>

80107005 <vector49>:
80107005:	6a 00                	push   $0x0
80107007:	6a 31                	push   $0x31
80107009:	e9 f9 f7 ff ff       	jmp    80106807 <alltraps>

8010700e <vector50>:
8010700e:	6a 00                	push   $0x0
80107010:	6a 32                	push   $0x32
80107012:	e9 f0 f7 ff ff       	jmp    80106807 <alltraps>

80107017 <vector51>:
80107017:	6a 00                	push   $0x0
80107019:	6a 33                	push   $0x33
8010701b:	e9 e7 f7 ff ff       	jmp    80106807 <alltraps>

80107020 <vector52>:
80107020:	6a 00                	push   $0x0
80107022:	6a 34                	push   $0x34
80107024:	e9 de f7 ff ff       	jmp    80106807 <alltraps>

80107029 <vector53>:
80107029:	6a 00                	push   $0x0
8010702b:	6a 35                	push   $0x35
8010702d:	e9 d5 f7 ff ff       	jmp    80106807 <alltraps>

80107032 <vector54>:
80107032:	6a 00                	push   $0x0
80107034:	6a 36                	push   $0x36
80107036:	e9 cc f7 ff ff       	jmp    80106807 <alltraps>

8010703b <vector55>:
8010703b:	6a 00                	push   $0x0
8010703d:	6a 37                	push   $0x37
8010703f:	e9 c3 f7 ff ff       	jmp    80106807 <alltraps>

80107044 <vector56>:
80107044:	6a 00                	push   $0x0
80107046:	6a 38                	push   $0x38
80107048:	e9 ba f7 ff ff       	jmp    80106807 <alltraps>

8010704d <vector57>:
8010704d:	6a 00                	push   $0x0
8010704f:	6a 39                	push   $0x39
80107051:	e9 b1 f7 ff ff       	jmp    80106807 <alltraps>

80107056 <vector58>:
80107056:	6a 00                	push   $0x0
80107058:	6a 3a                	push   $0x3a
8010705a:	e9 a8 f7 ff ff       	jmp    80106807 <alltraps>

8010705f <vector59>:
8010705f:	6a 00                	push   $0x0
80107061:	6a 3b                	push   $0x3b
80107063:	e9 9f f7 ff ff       	jmp    80106807 <alltraps>

80107068 <vector60>:
80107068:	6a 00                	push   $0x0
8010706a:	6a 3c                	push   $0x3c
8010706c:	e9 96 f7 ff ff       	jmp    80106807 <alltraps>

80107071 <vector61>:
80107071:	6a 00                	push   $0x0
80107073:	6a 3d                	push   $0x3d
80107075:	e9 8d f7 ff ff       	jmp    80106807 <alltraps>

8010707a <vector62>:
8010707a:	6a 00                	push   $0x0
8010707c:	6a 3e                	push   $0x3e
8010707e:	e9 84 f7 ff ff       	jmp    80106807 <alltraps>

80107083 <vector63>:
80107083:	6a 00                	push   $0x0
80107085:	6a 3f                	push   $0x3f
80107087:	e9 7b f7 ff ff       	jmp    80106807 <alltraps>

8010708c <vector64>:
8010708c:	6a 00                	push   $0x0
8010708e:	6a 40                	push   $0x40
80107090:	e9 72 f7 ff ff       	jmp    80106807 <alltraps>

80107095 <vector65>:
80107095:	6a 00                	push   $0x0
80107097:	6a 41                	push   $0x41
80107099:	e9 69 f7 ff ff       	jmp    80106807 <alltraps>

8010709e <vector66>:
8010709e:	6a 00                	push   $0x0
801070a0:	6a 42                	push   $0x42
801070a2:	e9 60 f7 ff ff       	jmp    80106807 <alltraps>

801070a7 <vector67>:
801070a7:	6a 00                	push   $0x0
801070a9:	6a 43                	push   $0x43
801070ab:	e9 57 f7 ff ff       	jmp    80106807 <alltraps>

801070b0 <vector68>:
801070b0:	6a 00                	push   $0x0
801070b2:	6a 44                	push   $0x44
801070b4:	e9 4e f7 ff ff       	jmp    80106807 <alltraps>

801070b9 <vector69>:
801070b9:	6a 00                	push   $0x0
801070bb:	6a 45                	push   $0x45
801070bd:	e9 45 f7 ff ff       	jmp    80106807 <alltraps>

801070c2 <vector70>:
801070c2:	6a 00                	push   $0x0
801070c4:	6a 46                	push   $0x46
801070c6:	e9 3c f7 ff ff       	jmp    80106807 <alltraps>

801070cb <vector71>:
801070cb:	6a 00                	push   $0x0
801070cd:	6a 47                	push   $0x47
801070cf:	e9 33 f7 ff ff       	jmp    80106807 <alltraps>

801070d4 <vector72>:
801070d4:	6a 00                	push   $0x0
801070d6:	6a 48                	push   $0x48
801070d8:	e9 2a f7 ff ff       	jmp    80106807 <alltraps>

801070dd <vector73>:
801070dd:	6a 00                	push   $0x0
801070df:	6a 49                	push   $0x49
801070e1:	e9 21 f7 ff ff       	jmp    80106807 <alltraps>

801070e6 <vector74>:
801070e6:	6a 00                	push   $0x0
801070e8:	6a 4a                	push   $0x4a
801070ea:	e9 18 f7 ff ff       	jmp    80106807 <alltraps>

801070ef <vector75>:
801070ef:	6a 00                	push   $0x0
801070f1:	6a 4b                	push   $0x4b
801070f3:	e9 0f f7 ff ff       	jmp    80106807 <alltraps>

801070f8 <vector76>:
801070f8:	6a 00                	push   $0x0
801070fa:	6a 4c                	push   $0x4c
801070fc:	e9 06 f7 ff ff       	jmp    80106807 <alltraps>

80107101 <vector77>:
80107101:	6a 00                	push   $0x0
80107103:	6a 4d                	push   $0x4d
80107105:	e9 fd f6 ff ff       	jmp    80106807 <alltraps>

8010710a <vector78>:
8010710a:	6a 00                	push   $0x0
8010710c:	6a 4e                	push   $0x4e
8010710e:	e9 f4 f6 ff ff       	jmp    80106807 <alltraps>

80107113 <vector79>:
80107113:	6a 00                	push   $0x0
80107115:	6a 4f                	push   $0x4f
80107117:	e9 eb f6 ff ff       	jmp    80106807 <alltraps>

8010711c <vector80>:
8010711c:	6a 00                	push   $0x0
8010711e:	6a 50                	push   $0x50
80107120:	e9 e2 f6 ff ff       	jmp    80106807 <alltraps>

80107125 <vector81>:
80107125:	6a 00                	push   $0x0
80107127:	6a 51                	push   $0x51
80107129:	e9 d9 f6 ff ff       	jmp    80106807 <alltraps>

8010712e <vector82>:
8010712e:	6a 00                	push   $0x0
80107130:	6a 52                	push   $0x52
80107132:	e9 d0 f6 ff ff       	jmp    80106807 <alltraps>

80107137 <vector83>:
80107137:	6a 00                	push   $0x0
80107139:	6a 53                	push   $0x53
8010713b:	e9 c7 f6 ff ff       	jmp    80106807 <alltraps>

80107140 <vector84>:
80107140:	6a 00                	push   $0x0
80107142:	6a 54                	push   $0x54
80107144:	e9 be f6 ff ff       	jmp    80106807 <alltraps>

80107149 <vector85>:
80107149:	6a 00                	push   $0x0
8010714b:	6a 55                	push   $0x55
8010714d:	e9 b5 f6 ff ff       	jmp    80106807 <alltraps>

80107152 <vector86>:
80107152:	6a 00                	push   $0x0
80107154:	6a 56                	push   $0x56
80107156:	e9 ac f6 ff ff       	jmp    80106807 <alltraps>

8010715b <vector87>:
8010715b:	6a 00                	push   $0x0
8010715d:	6a 57                	push   $0x57
8010715f:	e9 a3 f6 ff ff       	jmp    80106807 <alltraps>

80107164 <vector88>:
80107164:	6a 00                	push   $0x0
80107166:	6a 58                	push   $0x58
80107168:	e9 9a f6 ff ff       	jmp    80106807 <alltraps>

8010716d <vector89>:
8010716d:	6a 00                	push   $0x0
8010716f:	6a 59                	push   $0x59
80107171:	e9 91 f6 ff ff       	jmp    80106807 <alltraps>

80107176 <vector90>:
80107176:	6a 00                	push   $0x0
80107178:	6a 5a                	push   $0x5a
8010717a:	e9 88 f6 ff ff       	jmp    80106807 <alltraps>

8010717f <vector91>:
8010717f:	6a 00                	push   $0x0
80107181:	6a 5b                	push   $0x5b
80107183:	e9 7f f6 ff ff       	jmp    80106807 <alltraps>

80107188 <vector92>:
80107188:	6a 00                	push   $0x0
8010718a:	6a 5c                	push   $0x5c
8010718c:	e9 76 f6 ff ff       	jmp    80106807 <alltraps>

80107191 <vector93>:
80107191:	6a 00                	push   $0x0
80107193:	6a 5d                	push   $0x5d
80107195:	e9 6d f6 ff ff       	jmp    80106807 <alltraps>

8010719a <vector94>:
8010719a:	6a 00                	push   $0x0
8010719c:	6a 5e                	push   $0x5e
8010719e:	e9 64 f6 ff ff       	jmp    80106807 <alltraps>

801071a3 <vector95>:
801071a3:	6a 00                	push   $0x0
801071a5:	6a 5f                	push   $0x5f
801071a7:	e9 5b f6 ff ff       	jmp    80106807 <alltraps>

801071ac <vector96>:
801071ac:	6a 00                	push   $0x0
801071ae:	6a 60                	push   $0x60
801071b0:	e9 52 f6 ff ff       	jmp    80106807 <alltraps>

801071b5 <vector97>:
801071b5:	6a 00                	push   $0x0
801071b7:	6a 61                	push   $0x61
801071b9:	e9 49 f6 ff ff       	jmp    80106807 <alltraps>

801071be <vector98>:
801071be:	6a 00                	push   $0x0
801071c0:	6a 62                	push   $0x62
801071c2:	e9 40 f6 ff ff       	jmp    80106807 <alltraps>

801071c7 <vector99>:
801071c7:	6a 00                	push   $0x0
801071c9:	6a 63                	push   $0x63
801071cb:	e9 37 f6 ff ff       	jmp    80106807 <alltraps>

801071d0 <vector100>:
801071d0:	6a 00                	push   $0x0
801071d2:	6a 64                	push   $0x64
801071d4:	e9 2e f6 ff ff       	jmp    80106807 <alltraps>

801071d9 <vector101>:
801071d9:	6a 00                	push   $0x0
801071db:	6a 65                	push   $0x65
801071dd:	e9 25 f6 ff ff       	jmp    80106807 <alltraps>

801071e2 <vector102>:
801071e2:	6a 00                	push   $0x0
801071e4:	6a 66                	push   $0x66
801071e6:	e9 1c f6 ff ff       	jmp    80106807 <alltraps>

801071eb <vector103>:
801071eb:	6a 00                	push   $0x0
801071ed:	6a 67                	push   $0x67
801071ef:	e9 13 f6 ff ff       	jmp    80106807 <alltraps>

801071f4 <vector104>:
801071f4:	6a 00                	push   $0x0
801071f6:	6a 68                	push   $0x68
801071f8:	e9 0a f6 ff ff       	jmp    80106807 <alltraps>

801071fd <vector105>:
801071fd:	6a 00                	push   $0x0
801071ff:	6a 69                	push   $0x69
80107201:	e9 01 f6 ff ff       	jmp    80106807 <alltraps>

80107206 <vector106>:
80107206:	6a 00                	push   $0x0
80107208:	6a 6a                	push   $0x6a
8010720a:	e9 f8 f5 ff ff       	jmp    80106807 <alltraps>

8010720f <vector107>:
8010720f:	6a 00                	push   $0x0
80107211:	6a 6b                	push   $0x6b
80107213:	e9 ef f5 ff ff       	jmp    80106807 <alltraps>

80107218 <vector108>:
80107218:	6a 00                	push   $0x0
8010721a:	6a 6c                	push   $0x6c
8010721c:	e9 e6 f5 ff ff       	jmp    80106807 <alltraps>

80107221 <vector109>:
80107221:	6a 00                	push   $0x0
80107223:	6a 6d                	push   $0x6d
80107225:	e9 dd f5 ff ff       	jmp    80106807 <alltraps>

8010722a <vector110>:
8010722a:	6a 00                	push   $0x0
8010722c:	6a 6e                	push   $0x6e
8010722e:	e9 d4 f5 ff ff       	jmp    80106807 <alltraps>

80107233 <vector111>:
80107233:	6a 00                	push   $0x0
80107235:	6a 6f                	push   $0x6f
80107237:	e9 cb f5 ff ff       	jmp    80106807 <alltraps>

8010723c <vector112>:
8010723c:	6a 00                	push   $0x0
8010723e:	6a 70                	push   $0x70
80107240:	e9 c2 f5 ff ff       	jmp    80106807 <alltraps>

80107245 <vector113>:
80107245:	6a 00                	push   $0x0
80107247:	6a 71                	push   $0x71
80107249:	e9 b9 f5 ff ff       	jmp    80106807 <alltraps>

8010724e <vector114>:
8010724e:	6a 00                	push   $0x0
80107250:	6a 72                	push   $0x72
80107252:	e9 b0 f5 ff ff       	jmp    80106807 <alltraps>

80107257 <vector115>:
80107257:	6a 00                	push   $0x0
80107259:	6a 73                	push   $0x73
8010725b:	e9 a7 f5 ff ff       	jmp    80106807 <alltraps>

80107260 <vector116>:
80107260:	6a 00                	push   $0x0
80107262:	6a 74                	push   $0x74
80107264:	e9 9e f5 ff ff       	jmp    80106807 <alltraps>

80107269 <vector117>:
80107269:	6a 00                	push   $0x0
8010726b:	6a 75                	push   $0x75
8010726d:	e9 95 f5 ff ff       	jmp    80106807 <alltraps>

80107272 <vector118>:
80107272:	6a 00                	push   $0x0
80107274:	6a 76                	push   $0x76
80107276:	e9 8c f5 ff ff       	jmp    80106807 <alltraps>

8010727b <vector119>:
8010727b:	6a 00                	push   $0x0
8010727d:	6a 77                	push   $0x77
8010727f:	e9 83 f5 ff ff       	jmp    80106807 <alltraps>

80107284 <vector120>:
80107284:	6a 00                	push   $0x0
80107286:	6a 78                	push   $0x78
80107288:	e9 7a f5 ff ff       	jmp    80106807 <alltraps>

8010728d <vector121>:
8010728d:	6a 00                	push   $0x0
8010728f:	6a 79                	push   $0x79
80107291:	e9 71 f5 ff ff       	jmp    80106807 <alltraps>

80107296 <vector122>:
80107296:	6a 00                	push   $0x0
80107298:	6a 7a                	push   $0x7a
8010729a:	e9 68 f5 ff ff       	jmp    80106807 <alltraps>

8010729f <vector123>:
8010729f:	6a 00                	push   $0x0
801072a1:	6a 7b                	push   $0x7b
801072a3:	e9 5f f5 ff ff       	jmp    80106807 <alltraps>

801072a8 <vector124>:
801072a8:	6a 00                	push   $0x0
801072aa:	6a 7c                	push   $0x7c
801072ac:	e9 56 f5 ff ff       	jmp    80106807 <alltraps>

801072b1 <vector125>:
801072b1:	6a 00                	push   $0x0
801072b3:	6a 7d                	push   $0x7d
801072b5:	e9 4d f5 ff ff       	jmp    80106807 <alltraps>

801072ba <vector126>:
801072ba:	6a 00                	push   $0x0
801072bc:	6a 7e                	push   $0x7e
801072be:	e9 44 f5 ff ff       	jmp    80106807 <alltraps>

801072c3 <vector127>:
801072c3:	6a 00                	push   $0x0
801072c5:	6a 7f                	push   $0x7f
801072c7:	e9 3b f5 ff ff       	jmp    80106807 <alltraps>

801072cc <vector128>:
801072cc:	6a 00                	push   $0x0
801072ce:	68 80 00 00 00       	push   $0x80
801072d3:	e9 2f f5 ff ff       	jmp    80106807 <alltraps>

801072d8 <vector129>:
801072d8:	6a 00                	push   $0x0
801072da:	68 81 00 00 00       	push   $0x81
801072df:	e9 23 f5 ff ff       	jmp    80106807 <alltraps>

801072e4 <vector130>:
801072e4:	6a 00                	push   $0x0
801072e6:	68 82 00 00 00       	push   $0x82
801072eb:	e9 17 f5 ff ff       	jmp    80106807 <alltraps>

801072f0 <vector131>:
801072f0:	6a 00                	push   $0x0
801072f2:	68 83 00 00 00       	push   $0x83
801072f7:	e9 0b f5 ff ff       	jmp    80106807 <alltraps>

801072fc <vector132>:
801072fc:	6a 00                	push   $0x0
801072fe:	68 84 00 00 00       	push   $0x84
80107303:	e9 ff f4 ff ff       	jmp    80106807 <alltraps>

80107308 <vector133>:
80107308:	6a 00                	push   $0x0
8010730a:	68 85 00 00 00       	push   $0x85
8010730f:	e9 f3 f4 ff ff       	jmp    80106807 <alltraps>

80107314 <vector134>:
80107314:	6a 00                	push   $0x0
80107316:	68 86 00 00 00       	push   $0x86
8010731b:	e9 e7 f4 ff ff       	jmp    80106807 <alltraps>

80107320 <vector135>:
80107320:	6a 00                	push   $0x0
80107322:	68 87 00 00 00       	push   $0x87
80107327:	e9 db f4 ff ff       	jmp    80106807 <alltraps>

8010732c <vector136>:
8010732c:	6a 00                	push   $0x0
8010732e:	68 88 00 00 00       	push   $0x88
80107333:	e9 cf f4 ff ff       	jmp    80106807 <alltraps>

80107338 <vector137>:
80107338:	6a 00                	push   $0x0
8010733a:	68 89 00 00 00       	push   $0x89
8010733f:	e9 c3 f4 ff ff       	jmp    80106807 <alltraps>

80107344 <vector138>:
80107344:	6a 00                	push   $0x0
80107346:	68 8a 00 00 00       	push   $0x8a
8010734b:	e9 b7 f4 ff ff       	jmp    80106807 <alltraps>

80107350 <vector139>:
80107350:	6a 00                	push   $0x0
80107352:	68 8b 00 00 00       	push   $0x8b
80107357:	e9 ab f4 ff ff       	jmp    80106807 <alltraps>

8010735c <vector140>:
8010735c:	6a 00                	push   $0x0
8010735e:	68 8c 00 00 00       	push   $0x8c
80107363:	e9 9f f4 ff ff       	jmp    80106807 <alltraps>

80107368 <vector141>:
80107368:	6a 00                	push   $0x0
8010736a:	68 8d 00 00 00       	push   $0x8d
8010736f:	e9 93 f4 ff ff       	jmp    80106807 <alltraps>

80107374 <vector142>:
80107374:	6a 00                	push   $0x0
80107376:	68 8e 00 00 00       	push   $0x8e
8010737b:	e9 87 f4 ff ff       	jmp    80106807 <alltraps>

80107380 <vector143>:
80107380:	6a 00                	push   $0x0
80107382:	68 8f 00 00 00       	push   $0x8f
80107387:	e9 7b f4 ff ff       	jmp    80106807 <alltraps>

8010738c <vector144>:
8010738c:	6a 00                	push   $0x0
8010738e:	68 90 00 00 00       	push   $0x90
80107393:	e9 6f f4 ff ff       	jmp    80106807 <alltraps>

80107398 <vector145>:
80107398:	6a 00                	push   $0x0
8010739a:	68 91 00 00 00       	push   $0x91
8010739f:	e9 63 f4 ff ff       	jmp    80106807 <alltraps>

801073a4 <vector146>:
801073a4:	6a 00                	push   $0x0
801073a6:	68 92 00 00 00       	push   $0x92
801073ab:	e9 57 f4 ff ff       	jmp    80106807 <alltraps>

801073b0 <vector147>:
801073b0:	6a 00                	push   $0x0
801073b2:	68 93 00 00 00       	push   $0x93
801073b7:	e9 4b f4 ff ff       	jmp    80106807 <alltraps>

801073bc <vector148>:
801073bc:	6a 00                	push   $0x0
801073be:	68 94 00 00 00       	push   $0x94
801073c3:	e9 3f f4 ff ff       	jmp    80106807 <alltraps>

801073c8 <vector149>:
801073c8:	6a 00                	push   $0x0
801073ca:	68 95 00 00 00       	push   $0x95
801073cf:	e9 33 f4 ff ff       	jmp    80106807 <alltraps>

801073d4 <vector150>:
801073d4:	6a 00                	push   $0x0
801073d6:	68 96 00 00 00       	push   $0x96
801073db:	e9 27 f4 ff ff       	jmp    80106807 <alltraps>

801073e0 <vector151>:
801073e0:	6a 00                	push   $0x0
801073e2:	68 97 00 00 00       	push   $0x97
801073e7:	e9 1b f4 ff ff       	jmp    80106807 <alltraps>

801073ec <vector152>:
801073ec:	6a 00                	push   $0x0
801073ee:	68 98 00 00 00       	push   $0x98
801073f3:	e9 0f f4 ff ff       	jmp    80106807 <alltraps>

801073f8 <vector153>:
801073f8:	6a 00                	push   $0x0
801073fa:	68 99 00 00 00       	push   $0x99
801073ff:	e9 03 f4 ff ff       	jmp    80106807 <alltraps>

80107404 <vector154>:
80107404:	6a 00                	push   $0x0
80107406:	68 9a 00 00 00       	push   $0x9a
8010740b:	e9 f7 f3 ff ff       	jmp    80106807 <alltraps>

80107410 <vector155>:
80107410:	6a 00                	push   $0x0
80107412:	68 9b 00 00 00       	push   $0x9b
80107417:	e9 eb f3 ff ff       	jmp    80106807 <alltraps>

8010741c <vector156>:
8010741c:	6a 00                	push   $0x0
8010741e:	68 9c 00 00 00       	push   $0x9c
80107423:	e9 df f3 ff ff       	jmp    80106807 <alltraps>

80107428 <vector157>:
80107428:	6a 00                	push   $0x0
8010742a:	68 9d 00 00 00       	push   $0x9d
8010742f:	e9 d3 f3 ff ff       	jmp    80106807 <alltraps>

80107434 <vector158>:
80107434:	6a 00                	push   $0x0
80107436:	68 9e 00 00 00       	push   $0x9e
8010743b:	e9 c7 f3 ff ff       	jmp    80106807 <alltraps>

80107440 <vector159>:
80107440:	6a 00                	push   $0x0
80107442:	68 9f 00 00 00       	push   $0x9f
80107447:	e9 bb f3 ff ff       	jmp    80106807 <alltraps>

8010744c <vector160>:
8010744c:	6a 00                	push   $0x0
8010744e:	68 a0 00 00 00       	push   $0xa0
80107453:	e9 af f3 ff ff       	jmp    80106807 <alltraps>

80107458 <vector161>:
80107458:	6a 00                	push   $0x0
8010745a:	68 a1 00 00 00       	push   $0xa1
8010745f:	e9 a3 f3 ff ff       	jmp    80106807 <alltraps>

80107464 <vector162>:
80107464:	6a 00                	push   $0x0
80107466:	68 a2 00 00 00       	push   $0xa2
8010746b:	e9 97 f3 ff ff       	jmp    80106807 <alltraps>

80107470 <vector163>:
80107470:	6a 00                	push   $0x0
80107472:	68 a3 00 00 00       	push   $0xa3
80107477:	e9 8b f3 ff ff       	jmp    80106807 <alltraps>

8010747c <vector164>:
8010747c:	6a 00                	push   $0x0
8010747e:	68 a4 00 00 00       	push   $0xa4
80107483:	e9 7f f3 ff ff       	jmp    80106807 <alltraps>

80107488 <vector165>:
80107488:	6a 00                	push   $0x0
8010748a:	68 a5 00 00 00       	push   $0xa5
8010748f:	e9 73 f3 ff ff       	jmp    80106807 <alltraps>

80107494 <vector166>:
80107494:	6a 00                	push   $0x0
80107496:	68 a6 00 00 00       	push   $0xa6
8010749b:	e9 67 f3 ff ff       	jmp    80106807 <alltraps>

801074a0 <vector167>:
801074a0:	6a 00                	push   $0x0
801074a2:	68 a7 00 00 00       	push   $0xa7
801074a7:	e9 5b f3 ff ff       	jmp    80106807 <alltraps>

801074ac <vector168>:
801074ac:	6a 00                	push   $0x0
801074ae:	68 a8 00 00 00       	push   $0xa8
801074b3:	e9 4f f3 ff ff       	jmp    80106807 <alltraps>

801074b8 <vector169>:
801074b8:	6a 00                	push   $0x0
801074ba:	68 a9 00 00 00       	push   $0xa9
801074bf:	e9 43 f3 ff ff       	jmp    80106807 <alltraps>

801074c4 <vector170>:
801074c4:	6a 00                	push   $0x0
801074c6:	68 aa 00 00 00       	push   $0xaa
801074cb:	e9 37 f3 ff ff       	jmp    80106807 <alltraps>

801074d0 <vector171>:
801074d0:	6a 00                	push   $0x0
801074d2:	68 ab 00 00 00       	push   $0xab
801074d7:	e9 2b f3 ff ff       	jmp    80106807 <alltraps>

801074dc <vector172>:
801074dc:	6a 00                	push   $0x0
801074de:	68 ac 00 00 00       	push   $0xac
801074e3:	e9 1f f3 ff ff       	jmp    80106807 <alltraps>

801074e8 <vector173>:
801074e8:	6a 00                	push   $0x0
801074ea:	68 ad 00 00 00       	push   $0xad
801074ef:	e9 13 f3 ff ff       	jmp    80106807 <alltraps>

801074f4 <vector174>:
801074f4:	6a 00                	push   $0x0
801074f6:	68 ae 00 00 00       	push   $0xae
801074fb:	e9 07 f3 ff ff       	jmp    80106807 <alltraps>

80107500 <vector175>:
80107500:	6a 00                	push   $0x0
80107502:	68 af 00 00 00       	push   $0xaf
80107507:	e9 fb f2 ff ff       	jmp    80106807 <alltraps>

8010750c <vector176>:
8010750c:	6a 00                	push   $0x0
8010750e:	68 b0 00 00 00       	push   $0xb0
80107513:	e9 ef f2 ff ff       	jmp    80106807 <alltraps>

80107518 <vector177>:
80107518:	6a 00                	push   $0x0
8010751a:	68 b1 00 00 00       	push   $0xb1
8010751f:	e9 e3 f2 ff ff       	jmp    80106807 <alltraps>

80107524 <vector178>:
80107524:	6a 00                	push   $0x0
80107526:	68 b2 00 00 00       	push   $0xb2
8010752b:	e9 d7 f2 ff ff       	jmp    80106807 <alltraps>

80107530 <vector179>:
80107530:	6a 00                	push   $0x0
80107532:	68 b3 00 00 00       	push   $0xb3
80107537:	e9 cb f2 ff ff       	jmp    80106807 <alltraps>

8010753c <vector180>:
8010753c:	6a 00                	push   $0x0
8010753e:	68 b4 00 00 00       	push   $0xb4
80107543:	e9 bf f2 ff ff       	jmp    80106807 <alltraps>

80107548 <vector181>:
80107548:	6a 00                	push   $0x0
8010754a:	68 b5 00 00 00       	push   $0xb5
8010754f:	e9 b3 f2 ff ff       	jmp    80106807 <alltraps>

80107554 <vector182>:
80107554:	6a 00                	push   $0x0
80107556:	68 b6 00 00 00       	push   $0xb6
8010755b:	e9 a7 f2 ff ff       	jmp    80106807 <alltraps>

80107560 <vector183>:
80107560:	6a 00                	push   $0x0
80107562:	68 b7 00 00 00       	push   $0xb7
80107567:	e9 9b f2 ff ff       	jmp    80106807 <alltraps>

8010756c <vector184>:
8010756c:	6a 00                	push   $0x0
8010756e:	68 b8 00 00 00       	push   $0xb8
80107573:	e9 8f f2 ff ff       	jmp    80106807 <alltraps>

80107578 <vector185>:
80107578:	6a 00                	push   $0x0
8010757a:	68 b9 00 00 00       	push   $0xb9
8010757f:	e9 83 f2 ff ff       	jmp    80106807 <alltraps>

80107584 <vector186>:
80107584:	6a 00                	push   $0x0
80107586:	68 ba 00 00 00       	push   $0xba
8010758b:	e9 77 f2 ff ff       	jmp    80106807 <alltraps>

80107590 <vector187>:
80107590:	6a 00                	push   $0x0
80107592:	68 bb 00 00 00       	push   $0xbb
80107597:	e9 6b f2 ff ff       	jmp    80106807 <alltraps>

8010759c <vector188>:
8010759c:	6a 00                	push   $0x0
8010759e:	68 bc 00 00 00       	push   $0xbc
801075a3:	e9 5f f2 ff ff       	jmp    80106807 <alltraps>

801075a8 <vector189>:
801075a8:	6a 00                	push   $0x0
801075aa:	68 bd 00 00 00       	push   $0xbd
801075af:	e9 53 f2 ff ff       	jmp    80106807 <alltraps>

801075b4 <vector190>:
801075b4:	6a 00                	push   $0x0
801075b6:	68 be 00 00 00       	push   $0xbe
801075bb:	e9 47 f2 ff ff       	jmp    80106807 <alltraps>

801075c0 <vector191>:
801075c0:	6a 00                	push   $0x0
801075c2:	68 bf 00 00 00       	push   $0xbf
801075c7:	e9 3b f2 ff ff       	jmp    80106807 <alltraps>

801075cc <vector192>:
801075cc:	6a 00                	push   $0x0
801075ce:	68 c0 00 00 00       	push   $0xc0
801075d3:	e9 2f f2 ff ff       	jmp    80106807 <alltraps>

801075d8 <vector193>:
801075d8:	6a 00                	push   $0x0
801075da:	68 c1 00 00 00       	push   $0xc1
801075df:	e9 23 f2 ff ff       	jmp    80106807 <alltraps>

801075e4 <vector194>:
801075e4:	6a 00                	push   $0x0
801075e6:	68 c2 00 00 00       	push   $0xc2
801075eb:	e9 17 f2 ff ff       	jmp    80106807 <alltraps>

801075f0 <vector195>:
801075f0:	6a 00                	push   $0x0
801075f2:	68 c3 00 00 00       	push   $0xc3
801075f7:	e9 0b f2 ff ff       	jmp    80106807 <alltraps>

801075fc <vector196>:
801075fc:	6a 00                	push   $0x0
801075fe:	68 c4 00 00 00       	push   $0xc4
80107603:	e9 ff f1 ff ff       	jmp    80106807 <alltraps>

80107608 <vector197>:
80107608:	6a 00                	push   $0x0
8010760a:	68 c5 00 00 00       	push   $0xc5
8010760f:	e9 f3 f1 ff ff       	jmp    80106807 <alltraps>

80107614 <vector198>:
80107614:	6a 00                	push   $0x0
80107616:	68 c6 00 00 00       	push   $0xc6
8010761b:	e9 e7 f1 ff ff       	jmp    80106807 <alltraps>

80107620 <vector199>:
80107620:	6a 00                	push   $0x0
80107622:	68 c7 00 00 00       	push   $0xc7
80107627:	e9 db f1 ff ff       	jmp    80106807 <alltraps>

8010762c <vector200>:
8010762c:	6a 00                	push   $0x0
8010762e:	68 c8 00 00 00       	push   $0xc8
80107633:	e9 cf f1 ff ff       	jmp    80106807 <alltraps>

80107638 <vector201>:
80107638:	6a 00                	push   $0x0
8010763a:	68 c9 00 00 00       	push   $0xc9
8010763f:	e9 c3 f1 ff ff       	jmp    80106807 <alltraps>

80107644 <vector202>:
80107644:	6a 00                	push   $0x0
80107646:	68 ca 00 00 00       	push   $0xca
8010764b:	e9 b7 f1 ff ff       	jmp    80106807 <alltraps>

80107650 <vector203>:
80107650:	6a 00                	push   $0x0
80107652:	68 cb 00 00 00       	push   $0xcb
80107657:	e9 ab f1 ff ff       	jmp    80106807 <alltraps>

8010765c <vector204>:
8010765c:	6a 00                	push   $0x0
8010765e:	68 cc 00 00 00       	push   $0xcc
80107663:	e9 9f f1 ff ff       	jmp    80106807 <alltraps>

80107668 <vector205>:
80107668:	6a 00                	push   $0x0
8010766a:	68 cd 00 00 00       	push   $0xcd
8010766f:	e9 93 f1 ff ff       	jmp    80106807 <alltraps>

80107674 <vector206>:
80107674:	6a 00                	push   $0x0
80107676:	68 ce 00 00 00       	push   $0xce
8010767b:	e9 87 f1 ff ff       	jmp    80106807 <alltraps>

80107680 <vector207>:
80107680:	6a 00                	push   $0x0
80107682:	68 cf 00 00 00       	push   $0xcf
80107687:	e9 7b f1 ff ff       	jmp    80106807 <alltraps>

8010768c <vector208>:
8010768c:	6a 00                	push   $0x0
8010768e:	68 d0 00 00 00       	push   $0xd0
80107693:	e9 6f f1 ff ff       	jmp    80106807 <alltraps>

80107698 <vector209>:
80107698:	6a 00                	push   $0x0
8010769a:	68 d1 00 00 00       	push   $0xd1
8010769f:	e9 63 f1 ff ff       	jmp    80106807 <alltraps>

801076a4 <vector210>:
801076a4:	6a 00                	push   $0x0
801076a6:	68 d2 00 00 00       	push   $0xd2
801076ab:	e9 57 f1 ff ff       	jmp    80106807 <alltraps>

801076b0 <vector211>:
801076b0:	6a 00                	push   $0x0
801076b2:	68 d3 00 00 00       	push   $0xd3
801076b7:	e9 4b f1 ff ff       	jmp    80106807 <alltraps>

801076bc <vector212>:
801076bc:	6a 00                	push   $0x0
801076be:	68 d4 00 00 00       	push   $0xd4
801076c3:	e9 3f f1 ff ff       	jmp    80106807 <alltraps>

801076c8 <vector213>:
801076c8:	6a 00                	push   $0x0
801076ca:	68 d5 00 00 00       	push   $0xd5
801076cf:	e9 33 f1 ff ff       	jmp    80106807 <alltraps>

801076d4 <vector214>:
801076d4:	6a 00                	push   $0x0
801076d6:	68 d6 00 00 00       	push   $0xd6
801076db:	e9 27 f1 ff ff       	jmp    80106807 <alltraps>

801076e0 <vector215>:
801076e0:	6a 00                	push   $0x0
801076e2:	68 d7 00 00 00       	push   $0xd7
801076e7:	e9 1b f1 ff ff       	jmp    80106807 <alltraps>

801076ec <vector216>:
801076ec:	6a 00                	push   $0x0
801076ee:	68 d8 00 00 00       	push   $0xd8
801076f3:	e9 0f f1 ff ff       	jmp    80106807 <alltraps>

801076f8 <vector217>:
801076f8:	6a 00                	push   $0x0
801076fa:	68 d9 00 00 00       	push   $0xd9
801076ff:	e9 03 f1 ff ff       	jmp    80106807 <alltraps>

80107704 <vector218>:
80107704:	6a 00                	push   $0x0
80107706:	68 da 00 00 00       	push   $0xda
8010770b:	e9 f7 f0 ff ff       	jmp    80106807 <alltraps>

80107710 <vector219>:
80107710:	6a 00                	push   $0x0
80107712:	68 db 00 00 00       	push   $0xdb
80107717:	e9 eb f0 ff ff       	jmp    80106807 <alltraps>

8010771c <vector220>:
8010771c:	6a 00                	push   $0x0
8010771e:	68 dc 00 00 00       	push   $0xdc
80107723:	e9 df f0 ff ff       	jmp    80106807 <alltraps>

80107728 <vector221>:
80107728:	6a 00                	push   $0x0
8010772a:	68 dd 00 00 00       	push   $0xdd
8010772f:	e9 d3 f0 ff ff       	jmp    80106807 <alltraps>

80107734 <vector222>:
80107734:	6a 00                	push   $0x0
80107736:	68 de 00 00 00       	push   $0xde
8010773b:	e9 c7 f0 ff ff       	jmp    80106807 <alltraps>

80107740 <vector223>:
80107740:	6a 00                	push   $0x0
80107742:	68 df 00 00 00       	push   $0xdf
80107747:	e9 bb f0 ff ff       	jmp    80106807 <alltraps>

8010774c <vector224>:
8010774c:	6a 00                	push   $0x0
8010774e:	68 e0 00 00 00       	push   $0xe0
80107753:	e9 af f0 ff ff       	jmp    80106807 <alltraps>

80107758 <vector225>:
80107758:	6a 00                	push   $0x0
8010775a:	68 e1 00 00 00       	push   $0xe1
8010775f:	e9 a3 f0 ff ff       	jmp    80106807 <alltraps>

80107764 <vector226>:
80107764:	6a 00                	push   $0x0
80107766:	68 e2 00 00 00       	push   $0xe2
8010776b:	e9 97 f0 ff ff       	jmp    80106807 <alltraps>

80107770 <vector227>:
80107770:	6a 00                	push   $0x0
80107772:	68 e3 00 00 00       	push   $0xe3
80107777:	e9 8b f0 ff ff       	jmp    80106807 <alltraps>

8010777c <vector228>:
8010777c:	6a 00                	push   $0x0
8010777e:	68 e4 00 00 00       	push   $0xe4
80107783:	e9 7f f0 ff ff       	jmp    80106807 <alltraps>

80107788 <vector229>:
80107788:	6a 00                	push   $0x0
8010778a:	68 e5 00 00 00       	push   $0xe5
8010778f:	e9 73 f0 ff ff       	jmp    80106807 <alltraps>

80107794 <vector230>:
80107794:	6a 00                	push   $0x0
80107796:	68 e6 00 00 00       	push   $0xe6
8010779b:	e9 67 f0 ff ff       	jmp    80106807 <alltraps>

801077a0 <vector231>:
801077a0:	6a 00                	push   $0x0
801077a2:	68 e7 00 00 00       	push   $0xe7
801077a7:	e9 5b f0 ff ff       	jmp    80106807 <alltraps>

801077ac <vector232>:
801077ac:	6a 00                	push   $0x0
801077ae:	68 e8 00 00 00       	push   $0xe8
801077b3:	e9 4f f0 ff ff       	jmp    80106807 <alltraps>

801077b8 <vector233>:
801077b8:	6a 00                	push   $0x0
801077ba:	68 e9 00 00 00       	push   $0xe9
801077bf:	e9 43 f0 ff ff       	jmp    80106807 <alltraps>

801077c4 <vector234>:
801077c4:	6a 00                	push   $0x0
801077c6:	68 ea 00 00 00       	push   $0xea
801077cb:	e9 37 f0 ff ff       	jmp    80106807 <alltraps>

801077d0 <vector235>:
801077d0:	6a 00                	push   $0x0
801077d2:	68 eb 00 00 00       	push   $0xeb
801077d7:	e9 2b f0 ff ff       	jmp    80106807 <alltraps>

801077dc <vector236>:
801077dc:	6a 00                	push   $0x0
801077de:	68 ec 00 00 00       	push   $0xec
801077e3:	e9 1f f0 ff ff       	jmp    80106807 <alltraps>

801077e8 <vector237>:
801077e8:	6a 00                	push   $0x0
801077ea:	68 ed 00 00 00       	push   $0xed
801077ef:	e9 13 f0 ff ff       	jmp    80106807 <alltraps>

801077f4 <vector238>:
801077f4:	6a 00                	push   $0x0
801077f6:	68 ee 00 00 00       	push   $0xee
801077fb:	e9 07 f0 ff ff       	jmp    80106807 <alltraps>

80107800 <vector239>:
80107800:	6a 00                	push   $0x0
80107802:	68 ef 00 00 00       	push   $0xef
80107807:	e9 fb ef ff ff       	jmp    80106807 <alltraps>

8010780c <vector240>:
8010780c:	6a 00                	push   $0x0
8010780e:	68 f0 00 00 00       	push   $0xf0
80107813:	e9 ef ef ff ff       	jmp    80106807 <alltraps>

80107818 <vector241>:
80107818:	6a 00                	push   $0x0
8010781a:	68 f1 00 00 00       	push   $0xf1
8010781f:	e9 e3 ef ff ff       	jmp    80106807 <alltraps>

80107824 <vector242>:
80107824:	6a 00                	push   $0x0
80107826:	68 f2 00 00 00       	push   $0xf2
8010782b:	e9 d7 ef ff ff       	jmp    80106807 <alltraps>

80107830 <vector243>:
80107830:	6a 00                	push   $0x0
80107832:	68 f3 00 00 00       	push   $0xf3
80107837:	e9 cb ef ff ff       	jmp    80106807 <alltraps>

8010783c <vector244>:
8010783c:	6a 00                	push   $0x0
8010783e:	68 f4 00 00 00       	push   $0xf4
80107843:	e9 bf ef ff ff       	jmp    80106807 <alltraps>

80107848 <vector245>:
80107848:	6a 00                	push   $0x0
8010784a:	68 f5 00 00 00       	push   $0xf5
8010784f:	e9 b3 ef ff ff       	jmp    80106807 <alltraps>

80107854 <vector246>:
80107854:	6a 00                	push   $0x0
80107856:	68 f6 00 00 00       	push   $0xf6
8010785b:	e9 a7 ef ff ff       	jmp    80106807 <alltraps>

80107860 <vector247>:
80107860:	6a 00                	push   $0x0
80107862:	68 f7 00 00 00       	push   $0xf7
80107867:	e9 9b ef ff ff       	jmp    80106807 <alltraps>

8010786c <vector248>:
8010786c:	6a 00                	push   $0x0
8010786e:	68 f8 00 00 00       	push   $0xf8
80107873:	e9 8f ef ff ff       	jmp    80106807 <alltraps>

80107878 <vector249>:
80107878:	6a 00                	push   $0x0
8010787a:	68 f9 00 00 00       	push   $0xf9
8010787f:	e9 83 ef ff ff       	jmp    80106807 <alltraps>

80107884 <vector250>:
80107884:	6a 00                	push   $0x0
80107886:	68 fa 00 00 00       	push   $0xfa
8010788b:	e9 77 ef ff ff       	jmp    80106807 <alltraps>

80107890 <vector251>:
80107890:	6a 00                	push   $0x0
80107892:	68 fb 00 00 00       	push   $0xfb
80107897:	e9 6b ef ff ff       	jmp    80106807 <alltraps>

8010789c <vector252>:
8010789c:	6a 00                	push   $0x0
8010789e:	68 fc 00 00 00       	push   $0xfc
801078a3:	e9 5f ef ff ff       	jmp    80106807 <alltraps>

801078a8 <vector253>:
801078a8:	6a 00                	push   $0x0
801078aa:	68 fd 00 00 00       	push   $0xfd
801078af:	e9 53 ef ff ff       	jmp    80106807 <alltraps>

801078b4 <vector254>:
801078b4:	6a 00                	push   $0x0
801078b6:	68 fe 00 00 00       	push   $0xfe
801078bb:	e9 47 ef ff ff       	jmp    80106807 <alltraps>

801078c0 <vector255>:
801078c0:	6a 00                	push   $0x0
801078c2:	68 ff 00 00 00       	push   $0xff
801078c7:	e9 3b ef ff ff       	jmp    80106807 <alltraps>

801078cc <lgdt>:
{
801078cc:	55                   	push   %ebp
801078cd:	89 e5                	mov    %esp,%ebp
801078cf:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
801078d2:	8b 45 0c             	mov    0xc(%ebp),%eax
801078d5:	83 e8 01             	sub    $0x1,%eax
801078d8:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801078dc:	8b 45 08             	mov    0x8(%ebp),%eax
801078df:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801078e3:	8b 45 08             	mov    0x8(%ebp),%eax
801078e6:	c1 e8 10             	shr    $0x10,%eax
801078e9:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801078ed:	8d 45 fa             	lea    -0x6(%ebp),%eax
801078f0:	0f 01 10             	lgdtl  (%eax)
}
801078f3:	90                   	nop
801078f4:	c9                   	leave  
801078f5:	c3                   	ret    

801078f6 <ltr>:
{
801078f6:	55                   	push   %ebp
801078f7:	89 e5                	mov    %esp,%ebp
801078f9:	83 ec 04             	sub    $0x4,%esp
801078fc:	8b 45 08             	mov    0x8(%ebp),%eax
801078ff:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80107903:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107907:	0f 00 d8             	ltr    %ax
}
8010790a:	90                   	nop
8010790b:	c9                   	leave  
8010790c:	c3                   	ret    

8010790d <loadgs>:
{
8010790d:	55                   	push   %ebp
8010790e:	89 e5                	mov    %esp,%ebp
80107910:	83 ec 04             	sub    $0x4,%esp
80107913:	8b 45 08             	mov    0x8(%ebp),%eax
80107916:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
8010791a:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010791e:	8e e8                	mov    %eax,%gs
}
80107920:	90                   	nop
80107921:	c9                   	leave  
80107922:	c3                   	ret    

80107923 <lcr3>:

static inline void
lcr3(uint val) 
{
80107923:	55                   	push   %ebp
80107924:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107926:	8b 45 08             	mov    0x8(%ebp),%eax
80107929:	0f 22 d8             	mov    %eax,%cr3
}
8010792c:	90                   	nop
8010792d:	5d                   	pop    %ebp
8010792e:	c3                   	ret    

8010792f <v2p>:
static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
8010792f:	55                   	push   %ebp
80107930:	89 e5                	mov    %esp,%ebp
80107932:	8b 45 08             	mov    0x8(%ebp),%eax
80107935:	05 00 00 00 80       	add    $0x80000000,%eax
8010793a:	5d                   	pop    %ebp
8010793b:	c3                   	ret    

8010793c <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
8010793c:	55                   	push   %ebp
8010793d:	89 e5                	mov    %esp,%ebp
8010793f:	8b 45 08             	mov    0x8(%ebp),%eax
80107942:	05 00 00 00 80       	add    $0x80000000,%eax
80107947:	5d                   	pop    %ebp
80107948:	c3                   	ret    

80107949 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107949:	55                   	push   %ebp
8010794a:	89 e5                	mov    %esp,%ebp
8010794c:	53                   	push   %ebx
8010794d:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107950:	e8 7e b6 ff ff       	call   80102fd3 <cpunum>
80107955:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010795b:	05 60 23 11 80       	add    $0x80112360,%eax
80107960:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107963:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107966:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
8010796c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010796f:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107975:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107978:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
8010797c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010797f:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107983:	83 e2 f0             	and    $0xfffffff0,%edx
80107986:	83 ca 0a             	or     $0xa,%edx
80107989:	88 50 7d             	mov    %dl,0x7d(%eax)
8010798c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010798f:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107993:	83 ca 10             	or     $0x10,%edx
80107996:	88 50 7d             	mov    %dl,0x7d(%eax)
80107999:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010799c:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801079a0:	83 e2 9f             	and    $0xffffff9f,%edx
801079a3:	88 50 7d             	mov    %dl,0x7d(%eax)
801079a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079a9:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801079ad:	83 ca 80             	or     $0xffffff80,%edx
801079b0:	88 50 7d             	mov    %dl,0x7d(%eax)
801079b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b6:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801079ba:	83 ca 0f             	or     $0xf,%edx
801079bd:	88 50 7e             	mov    %dl,0x7e(%eax)
801079c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079c3:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801079c7:	83 e2 ef             	and    $0xffffffef,%edx
801079ca:	88 50 7e             	mov    %dl,0x7e(%eax)
801079cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079d0:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801079d4:	83 e2 df             	and    $0xffffffdf,%edx
801079d7:	88 50 7e             	mov    %dl,0x7e(%eax)
801079da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079dd:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801079e1:	83 ca 40             	or     $0x40,%edx
801079e4:	88 50 7e             	mov    %dl,0x7e(%eax)
801079e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ea:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801079ee:	83 ca 80             	or     $0xffffff80,%edx
801079f1:	88 50 7e             	mov    %dl,0x7e(%eax)
801079f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079f7:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801079fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079fe:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107a05:	ff ff 
80107a07:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a0a:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107a11:	00 00 
80107a13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a16:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107a1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a20:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107a27:	83 e2 f0             	and    $0xfffffff0,%edx
80107a2a:	83 ca 02             	or     $0x2,%edx
80107a2d:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a36:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107a3d:	83 ca 10             	or     $0x10,%edx
80107a40:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a49:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107a50:	83 e2 9f             	and    $0xffffff9f,%edx
80107a53:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a5c:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107a63:	83 ca 80             	or     $0xffffff80,%edx
80107a66:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107a6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a6f:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107a76:	83 ca 0f             	or     $0xf,%edx
80107a79:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107a7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a82:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107a89:	83 e2 ef             	and    $0xffffffef,%edx
80107a8c:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a95:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107a9c:	83 e2 df             	and    $0xffffffdf,%edx
80107a9f:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107aa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aa8:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107aaf:	83 ca 40             	or     $0x40,%edx
80107ab2:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107ab8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107abb:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107ac2:	83 ca 80             	or     $0xffffff80,%edx
80107ac5:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107acb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ace:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107ad5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ad8:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107adf:	ff ff 
80107ae1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ae4:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107aeb:	00 00 
80107aed:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107af0:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107afa:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107b01:	83 e2 f0             	and    $0xfffffff0,%edx
80107b04:	83 ca 0a             	or     $0xa,%edx
80107b07:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107b0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b10:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107b17:	83 ca 10             	or     $0x10,%edx
80107b1a:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107b20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b23:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107b2a:	83 ca 60             	or     $0x60,%edx
80107b2d:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107b33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b36:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107b3d:	83 ca 80             	or     $0xffffff80,%edx
80107b40:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107b46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b49:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b50:	83 ca 0f             	or     $0xf,%edx
80107b53:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107b59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b5c:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b63:	83 e2 ef             	and    $0xffffffef,%edx
80107b66:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107b6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b6f:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b76:	83 e2 df             	and    $0xffffffdf,%edx
80107b79:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107b7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b82:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b89:	83 ca 40             	or     $0x40,%edx
80107b8c:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b95:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b9c:	83 ca 80             	or     $0xffffff80,%edx
80107b9f:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107ba5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ba8:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107baf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb2:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107bb9:	ff ff 
80107bbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bbe:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107bc5:	00 00 
80107bc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bca:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107bd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd4:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107bdb:	83 e2 f0             	and    $0xfffffff0,%edx
80107bde:	83 ca 02             	or     $0x2,%edx
80107be1:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107be7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bea:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107bf1:	83 ca 10             	or     $0x10,%edx
80107bf4:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107bfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bfd:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107c04:	83 ca 60             	or     $0x60,%edx
80107c07:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107c0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c10:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107c17:	83 ca 80             	or     $0xffffff80,%edx
80107c1a:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107c20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c23:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c2a:	83 ca 0f             	or     $0xf,%edx
80107c2d:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c36:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c3d:	83 e2 ef             	and    $0xffffffef,%edx
80107c40:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c49:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c50:	83 e2 df             	and    $0xffffffdf,%edx
80107c53:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c5c:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c63:	83 ca 40             	or     $0x40,%edx
80107c66:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c6f:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c76:	83 ca 80             	or     $0xffffff80,%edx
80107c79:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c82:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107c89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c8c:	05 b4 00 00 00       	add    $0xb4,%eax
80107c91:	89 c3                	mov    %eax,%ebx
80107c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c96:	05 b4 00 00 00       	add    $0xb4,%eax
80107c9b:	c1 e8 10             	shr    $0x10,%eax
80107c9e:	89 c2                	mov    %eax,%edx
80107ca0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ca3:	05 b4 00 00 00       	add    $0xb4,%eax
80107ca8:	c1 e8 18             	shr    $0x18,%eax
80107cab:	89 c1                	mov    %eax,%ecx
80107cad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cb0:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107cb7:	00 00 
80107cb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cbc:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107cc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cc6:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107ccc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ccf:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107cd6:	83 e2 f0             	and    $0xfffffff0,%edx
80107cd9:	83 ca 02             	or     $0x2,%edx
80107cdc:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107ce2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ce5:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107cec:	83 ca 10             	or     $0x10,%edx
80107cef:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107cf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cf8:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107cff:	83 e2 9f             	and    $0xffffff9f,%edx
80107d02:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107d08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d0b:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107d12:	83 ca 80             	or     $0xffffff80,%edx
80107d15:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107d1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d1e:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d25:	83 e2 f0             	and    $0xfffffff0,%edx
80107d28:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d31:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d38:	83 e2 ef             	and    $0xffffffef,%edx
80107d3b:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d44:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d4b:	83 e2 df             	and    $0xffffffdf,%edx
80107d4e:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d57:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d5e:	83 ca 40             	or     $0x40,%edx
80107d61:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d6a:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d71:	83 ca 80             	or     $0xffffff80,%edx
80107d74:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d7d:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107d83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d86:	83 c0 70             	add    $0x70,%eax
80107d89:	83 ec 08             	sub    $0x8,%esp
80107d8c:	6a 38                	push   $0x38
80107d8e:	50                   	push   %eax
80107d8f:	e8 38 fb ff ff       	call   801078cc <lgdt>
80107d94:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
80107d97:	83 ec 0c             	sub    $0xc,%esp
80107d9a:	6a 18                	push   $0x18
80107d9c:	e8 6c fb ff ff       	call   8010790d <loadgs>
80107da1:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
80107da4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107da7:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107dad:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107db4:	00 00 00 00 
}
80107db8:	90                   	nop
80107db9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107dbc:	c9                   	leave  
80107dbd:	c3                   	ret    

80107dbe <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107dbe:	55                   	push   %ebp
80107dbf:	89 e5                	mov    %esp,%ebp
80107dc1:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107dc4:	8b 45 0c             	mov    0xc(%ebp),%eax
80107dc7:	c1 e8 16             	shr    $0x16,%eax
80107dca:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107dd1:	8b 45 08             	mov    0x8(%ebp),%eax
80107dd4:	01 d0                	add    %edx,%eax
80107dd6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107dd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ddc:	8b 00                	mov    (%eax),%eax
80107dde:	83 e0 01             	and    $0x1,%eax
80107de1:	85 c0                	test   %eax,%eax
80107de3:	74 18                	je     80107dfd <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107de5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107de8:	8b 00                	mov    (%eax),%eax
80107dea:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107def:	50                   	push   %eax
80107df0:	e8 47 fb ff ff       	call   8010793c <p2v>
80107df5:	83 c4 04             	add    $0x4,%esp
80107df8:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107dfb:	eb 48                	jmp    80107e45 <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107dfd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107e01:	74 0e                	je     80107e11 <walkpgdir+0x53>
80107e03:	e8 62 ae ff ff       	call   80102c6a <kalloc>
80107e08:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107e0b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107e0f:	75 07                	jne    80107e18 <walkpgdir+0x5a>
      return 0;
80107e11:	b8 00 00 00 00       	mov    $0x0,%eax
80107e16:	eb 44                	jmp    80107e5c <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107e18:	83 ec 04             	sub    $0x4,%esp
80107e1b:	68 00 10 00 00       	push   $0x1000
80107e20:	6a 00                	push   $0x0
80107e22:	ff 75 f4             	pushl  -0xc(%ebp)
80107e25:	e8 05 d6 ff ff       	call   8010542f <memset>
80107e2a:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107e2d:	83 ec 0c             	sub    $0xc,%esp
80107e30:	ff 75 f4             	pushl  -0xc(%ebp)
80107e33:	e8 f7 fa ff ff       	call   8010792f <v2p>
80107e38:	83 c4 10             	add    $0x10,%esp
80107e3b:	83 c8 07             	or     $0x7,%eax
80107e3e:	89 c2                	mov    %eax,%edx
80107e40:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e43:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107e45:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e48:	c1 e8 0c             	shr    $0xc,%eax
80107e4b:	25 ff 03 00 00       	and    $0x3ff,%eax
80107e50:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107e57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e5a:	01 d0                	add    %edx,%eax
}
80107e5c:	c9                   	leave  
80107e5d:	c3                   	ret    

80107e5e <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107e5e:	55                   	push   %ebp
80107e5f:	89 e5                	mov    %esp,%ebp
80107e61:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107e64:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e67:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107e6f:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e72:	8b 45 10             	mov    0x10(%ebp),%eax
80107e75:	01 d0                	add    %edx,%eax
80107e77:	83 e8 01             	sub    $0x1,%eax
80107e7a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107e82:	83 ec 04             	sub    $0x4,%esp
80107e85:	6a 01                	push   $0x1
80107e87:	ff 75 f4             	pushl  -0xc(%ebp)
80107e8a:	ff 75 08             	pushl  0x8(%ebp)
80107e8d:	e8 2c ff ff ff       	call   80107dbe <walkpgdir>
80107e92:	83 c4 10             	add    $0x10,%esp
80107e95:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107e98:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107e9c:	75 07                	jne    80107ea5 <mappages+0x47>
      return -1;
80107e9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107ea3:	eb 47                	jmp    80107eec <mappages+0x8e>
    if(*pte & PTE_P)
80107ea5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107ea8:	8b 00                	mov    (%eax),%eax
80107eaa:	83 e0 01             	and    $0x1,%eax
80107ead:	85 c0                	test   %eax,%eax
80107eaf:	74 0d                	je     80107ebe <mappages+0x60>
      panic("remap");
80107eb1:	83 ec 0c             	sub    $0xc,%esp
80107eb4:	68 70 8d 10 80       	push   $0x80108d70
80107eb9:	e8 a9 86 ff ff       	call   80100567 <panic>
    *pte = pa | perm | PTE_P;
80107ebe:	8b 45 18             	mov    0x18(%ebp),%eax
80107ec1:	0b 45 14             	or     0x14(%ebp),%eax
80107ec4:	83 c8 01             	or     $0x1,%eax
80107ec7:	89 c2                	mov    %eax,%edx
80107ec9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107ecc:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107ece:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ed1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107ed4:	74 10                	je     80107ee6 <mappages+0x88>
      break;
    a += PGSIZE;
80107ed6:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107edd:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107ee4:	eb 9c                	jmp    80107e82 <mappages+0x24>
      break;
80107ee6:	90                   	nop
  }
  return 0;
80107ee7:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107eec:	c9                   	leave  
80107eed:	c3                   	ret    

80107eee <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107eee:	55                   	push   %ebp
80107eef:	89 e5                	mov    %esp,%ebp
80107ef1:	53                   	push   %ebx
80107ef2:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107ef5:	e8 70 ad ff ff       	call   80102c6a <kalloc>
80107efa:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107efd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107f01:	75 0a                	jne    80107f0d <setupkvm+0x1f>
    return 0;
80107f03:	b8 00 00 00 00       	mov    $0x0,%eax
80107f08:	e9 8e 00 00 00       	jmp    80107f9b <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
80107f0d:	83 ec 04             	sub    $0x4,%esp
80107f10:	68 00 10 00 00       	push   $0x1000
80107f15:	6a 00                	push   $0x0
80107f17:	ff 75 f0             	pushl  -0x10(%ebp)
80107f1a:	e8 10 d5 ff ff       	call   8010542f <memset>
80107f1f:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107f22:	83 ec 0c             	sub    $0xc,%esp
80107f25:	68 00 00 00 0e       	push   $0xe000000
80107f2a:	e8 0d fa ff ff       	call   8010793c <p2v>
80107f2f:	83 c4 10             	add    $0x10,%esp
80107f32:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107f37:	76 0d                	jbe    80107f46 <setupkvm+0x58>
    panic("PHYSTOP too high");
80107f39:	83 ec 0c             	sub    $0xc,%esp
80107f3c:	68 76 8d 10 80       	push   $0x80108d76
80107f41:	e8 21 86 ff ff       	call   80100567 <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107f46:	c7 45 f4 a0 b4 10 80 	movl   $0x8010b4a0,-0xc(%ebp)
80107f4d:	eb 40                	jmp    80107f8f <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107f4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f52:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80107f55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f58:	8b 50 04             	mov    0x4(%eax),%edx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107f5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f5e:	8b 58 08             	mov    0x8(%eax),%ebx
80107f61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f64:	8b 40 04             	mov    0x4(%eax),%eax
80107f67:	29 c3                	sub    %eax,%ebx
80107f69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f6c:	8b 00                	mov    (%eax),%eax
80107f6e:	83 ec 0c             	sub    $0xc,%esp
80107f71:	51                   	push   %ecx
80107f72:	52                   	push   %edx
80107f73:	53                   	push   %ebx
80107f74:	50                   	push   %eax
80107f75:	ff 75 f0             	pushl  -0x10(%ebp)
80107f78:	e8 e1 fe ff ff       	call   80107e5e <mappages>
80107f7d:	83 c4 20             	add    $0x20,%esp
80107f80:	85 c0                	test   %eax,%eax
80107f82:	79 07                	jns    80107f8b <setupkvm+0x9d>
      return 0;
80107f84:	b8 00 00 00 00       	mov    $0x0,%eax
80107f89:	eb 10                	jmp    80107f9b <setupkvm+0xad>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107f8b:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107f8f:	81 7d f4 e0 b4 10 80 	cmpl   $0x8010b4e0,-0xc(%ebp)
80107f96:	72 b7                	jb     80107f4f <setupkvm+0x61>
  return pgdir;
80107f98:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107f9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107f9e:	c9                   	leave  
80107f9f:	c3                   	ret    

80107fa0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107fa0:	55                   	push   %ebp
80107fa1:	89 e5                	mov    %esp,%ebp
80107fa3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107fa6:	e8 43 ff ff ff       	call   80107eee <setupkvm>
80107fab:	a3 38 53 11 80       	mov    %eax,0x80115338
  switchkvm();
80107fb0:	e8 03 00 00 00       	call   80107fb8 <switchkvm>
}
80107fb5:	90                   	nop
80107fb6:	c9                   	leave  
80107fb7:	c3                   	ret    

80107fb8 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107fb8:	55                   	push   %ebp
80107fb9:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107fbb:	a1 38 53 11 80       	mov    0x80115338,%eax
80107fc0:	50                   	push   %eax
80107fc1:	e8 69 f9 ff ff       	call   8010792f <v2p>
80107fc6:	83 c4 04             	add    $0x4,%esp
80107fc9:	50                   	push   %eax
80107fca:	e8 54 f9 ff ff       	call   80107923 <lcr3>
80107fcf:	83 c4 04             	add    $0x4,%esp
}
80107fd2:	90                   	nop
80107fd3:	c9                   	leave  
80107fd4:	c3                   	ret    

80107fd5 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107fd5:	55                   	push   %ebp
80107fd6:	89 e5                	mov    %esp,%ebp
80107fd8:	56                   	push   %esi
80107fd9:	53                   	push   %ebx
  pushcli();
80107fda:	e8 4a d3 ff ff       	call   80105329 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107fdf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107fe5:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107fec:	83 c2 08             	add    $0x8,%edx
80107fef:	89 d6                	mov    %edx,%esi
80107ff1:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107ff8:	83 c2 08             	add    $0x8,%edx
80107ffb:	c1 ea 10             	shr    $0x10,%edx
80107ffe:	89 d3                	mov    %edx,%ebx
80108000:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108007:	83 c2 08             	add    $0x8,%edx
8010800a:	c1 ea 18             	shr    $0x18,%edx
8010800d:	89 d1                	mov    %edx,%ecx
8010800f:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80108016:	67 00 
80108018:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
8010801f:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80108025:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010802c:	83 e2 f0             	and    $0xfffffff0,%edx
8010802f:	83 ca 09             	or     $0x9,%edx
80108032:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108038:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010803f:	83 ca 10             	or     $0x10,%edx
80108042:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108048:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010804f:	83 e2 9f             	and    $0xffffff9f,%edx
80108052:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108058:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010805f:	83 ca 80             	or     $0xffffff80,%edx
80108062:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108068:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010806f:	83 e2 f0             	and    $0xfffffff0,%edx
80108072:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80108078:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010807f:	83 e2 ef             	and    $0xffffffef,%edx
80108082:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80108088:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010808f:	83 e2 df             	and    $0xffffffdf,%edx
80108092:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80108098:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010809f:	83 ca 40             	or     $0x40,%edx
801080a2:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801080a8:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801080af:	83 e2 7f             	and    $0x7f,%edx
801080b2:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801080b8:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
801080be:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801080c4:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801080cb:	83 e2 ef             	and    $0xffffffef,%edx
801080ce:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
801080d4:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801080da:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
801080e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801080e6:	8b 40 08             	mov    0x8(%eax),%eax
801080e9:	89 c2                	mov    %eax,%edx
801080eb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801080f1:	81 c2 00 10 00 00    	add    $0x1000,%edx
801080f7:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
801080fa:	83 ec 0c             	sub    $0xc,%esp
801080fd:	6a 30                	push   $0x30
801080ff:	e8 f2 f7 ff ff       	call   801078f6 <ltr>
80108104:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80108107:	8b 45 08             	mov    0x8(%ebp),%eax
8010810a:	8b 40 04             	mov    0x4(%eax),%eax
8010810d:	85 c0                	test   %eax,%eax
8010810f:	75 0d                	jne    8010811e <switchuvm+0x149>
    panic("switchuvm: no pgdir");
80108111:	83 ec 0c             	sub    $0xc,%esp
80108114:	68 87 8d 10 80       	push   $0x80108d87
80108119:	e8 49 84 ff ff       	call   80100567 <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
8010811e:	8b 45 08             	mov    0x8(%ebp),%eax
80108121:	8b 40 04             	mov    0x4(%eax),%eax
80108124:	83 ec 0c             	sub    $0xc,%esp
80108127:	50                   	push   %eax
80108128:	e8 02 f8 ff ff       	call   8010792f <v2p>
8010812d:	83 c4 10             	add    $0x10,%esp
80108130:	83 ec 0c             	sub    $0xc,%esp
80108133:	50                   	push   %eax
80108134:	e8 ea f7 ff ff       	call   80107923 <lcr3>
80108139:	83 c4 10             	add    $0x10,%esp
  popcli();
8010813c:	e8 2d d2 ff ff       	call   8010536e <popcli>
}
80108141:	90                   	nop
80108142:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108145:	5b                   	pop    %ebx
80108146:	5e                   	pop    %esi
80108147:	5d                   	pop    %ebp
80108148:	c3                   	ret    

80108149 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80108149:	55                   	push   %ebp
8010814a:	89 e5                	mov    %esp,%ebp
8010814c:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
8010814f:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108156:	76 0d                	jbe    80108165 <inituvm+0x1c>
    panic("inituvm: more than a page");
80108158:	83 ec 0c             	sub    $0xc,%esp
8010815b:	68 9b 8d 10 80       	push   $0x80108d9b
80108160:	e8 02 84 ff ff       	call   80100567 <panic>
  mem = kalloc();
80108165:	e8 00 ab ff ff       	call   80102c6a <kalloc>
8010816a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
8010816d:	83 ec 04             	sub    $0x4,%esp
80108170:	68 00 10 00 00       	push   $0x1000
80108175:	6a 00                	push   $0x0
80108177:	ff 75 f4             	pushl  -0xc(%ebp)
8010817a:	e8 b0 d2 ff ff       	call   8010542f <memset>
8010817f:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108182:	83 ec 0c             	sub    $0xc,%esp
80108185:	ff 75 f4             	pushl  -0xc(%ebp)
80108188:	e8 a2 f7 ff ff       	call   8010792f <v2p>
8010818d:	83 c4 10             	add    $0x10,%esp
80108190:	83 ec 0c             	sub    $0xc,%esp
80108193:	6a 06                	push   $0x6
80108195:	50                   	push   %eax
80108196:	68 00 10 00 00       	push   $0x1000
8010819b:	6a 00                	push   $0x0
8010819d:	ff 75 08             	pushl  0x8(%ebp)
801081a0:	e8 b9 fc ff ff       	call   80107e5e <mappages>
801081a5:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
801081a8:	83 ec 04             	sub    $0x4,%esp
801081ab:	ff 75 10             	pushl  0x10(%ebp)
801081ae:	ff 75 0c             	pushl  0xc(%ebp)
801081b1:	ff 75 f4             	pushl  -0xc(%ebp)
801081b4:	e8 35 d3 ff ff       	call   801054ee <memmove>
801081b9:	83 c4 10             	add    $0x10,%esp
}
801081bc:	90                   	nop
801081bd:	c9                   	leave  
801081be:	c3                   	ret    

801081bf <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801081bf:	55                   	push   %ebp
801081c0:	89 e5                	mov    %esp,%ebp
801081c2:	53                   	push   %ebx
801081c3:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801081c6:	8b 45 0c             	mov    0xc(%ebp),%eax
801081c9:	25 ff 0f 00 00       	and    $0xfff,%eax
801081ce:	85 c0                	test   %eax,%eax
801081d0:	74 0d                	je     801081df <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
801081d2:	83 ec 0c             	sub    $0xc,%esp
801081d5:	68 b8 8d 10 80       	push   $0x80108db8
801081da:	e8 88 83 ff ff       	call   80100567 <panic>
  for(i = 0; i < sz; i += PGSIZE){
801081df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801081e6:	e9 95 00 00 00       	jmp    80108280 <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801081eb:	8b 55 0c             	mov    0xc(%ebp),%edx
801081ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081f1:	01 d0                	add    %edx,%eax
801081f3:	83 ec 04             	sub    $0x4,%esp
801081f6:	6a 00                	push   $0x0
801081f8:	50                   	push   %eax
801081f9:	ff 75 08             	pushl  0x8(%ebp)
801081fc:	e8 bd fb ff ff       	call   80107dbe <walkpgdir>
80108201:	83 c4 10             	add    $0x10,%esp
80108204:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108207:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010820b:	75 0d                	jne    8010821a <loaduvm+0x5b>
      panic("loaduvm: address should exist");
8010820d:	83 ec 0c             	sub    $0xc,%esp
80108210:	68 db 8d 10 80       	push   $0x80108ddb
80108215:	e8 4d 83 ff ff       	call   80100567 <panic>
    pa = PTE_ADDR(*pte);
8010821a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010821d:	8b 00                	mov    (%eax),%eax
8010821f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108224:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80108227:	8b 45 18             	mov    0x18(%ebp),%eax
8010822a:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010822d:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80108232:	77 0b                	ja     8010823f <loaduvm+0x80>
      n = sz - i;
80108234:	8b 45 18             	mov    0x18(%ebp),%eax
80108237:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010823a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010823d:	eb 07                	jmp    80108246 <loaduvm+0x87>
    else
      n = PGSIZE;
8010823f:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80108246:	8b 55 14             	mov    0x14(%ebp),%edx
80108249:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010824c:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010824f:	83 ec 0c             	sub    $0xc,%esp
80108252:	ff 75 e8             	pushl  -0x18(%ebp)
80108255:	e8 e2 f6 ff ff       	call   8010793c <p2v>
8010825a:	83 c4 10             	add    $0x10,%esp
8010825d:	ff 75 f0             	pushl  -0x10(%ebp)
80108260:	53                   	push   %ebx
80108261:	50                   	push   %eax
80108262:	ff 75 10             	pushl  0x10(%ebp)
80108265:	e8 74 9c ff ff       	call   80101ede <readi>
8010826a:	83 c4 10             	add    $0x10,%esp
8010826d:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80108270:	74 07                	je     80108279 <loaduvm+0xba>
      return -1;
80108272:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108277:	eb 18                	jmp    80108291 <loaduvm+0xd2>
  for(i = 0; i < sz; i += PGSIZE){
80108279:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108280:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108283:	3b 45 18             	cmp    0x18(%ebp),%eax
80108286:	0f 82 5f ff ff ff    	jb     801081eb <loaduvm+0x2c>
  }
  return 0;
8010828c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108291:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108294:	c9                   	leave  
80108295:	c3                   	ret    

80108296 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108296:	55                   	push   %ebp
80108297:	89 e5                	mov    %esp,%ebp
80108299:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010829c:	8b 45 10             	mov    0x10(%ebp),%eax
8010829f:	85 c0                	test   %eax,%eax
801082a1:	79 0a                	jns    801082ad <allocuvm+0x17>
    return 0;
801082a3:	b8 00 00 00 00       	mov    $0x0,%eax
801082a8:	e9 b0 00 00 00       	jmp    8010835d <allocuvm+0xc7>
  if(newsz < oldsz)
801082ad:	8b 45 10             	mov    0x10(%ebp),%eax
801082b0:	3b 45 0c             	cmp    0xc(%ebp),%eax
801082b3:	73 08                	jae    801082bd <allocuvm+0x27>
    return oldsz;
801082b5:	8b 45 0c             	mov    0xc(%ebp),%eax
801082b8:	e9 a0 00 00 00       	jmp    8010835d <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
801082bd:	8b 45 0c             	mov    0xc(%ebp),%eax
801082c0:	05 ff 0f 00 00       	add    $0xfff,%eax
801082c5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
801082cd:	eb 7f                	jmp    8010834e <allocuvm+0xb8>
    mem = kalloc();
801082cf:	e8 96 a9 ff ff       	call   80102c6a <kalloc>
801082d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
801082d7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801082db:	75 2b                	jne    80108308 <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
801082dd:	83 ec 0c             	sub    $0xc,%esp
801082e0:	68 f9 8d 10 80       	push   $0x80108df9
801082e5:	e8 da 80 ff ff       	call   801003c4 <cprintf>
801082ea:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
801082ed:	83 ec 04             	sub    $0x4,%esp
801082f0:	ff 75 0c             	pushl  0xc(%ebp)
801082f3:	ff 75 10             	pushl  0x10(%ebp)
801082f6:	ff 75 08             	pushl  0x8(%ebp)
801082f9:	e8 61 00 00 00       	call   8010835f <deallocuvm>
801082fe:	83 c4 10             	add    $0x10,%esp
      return 0;
80108301:	b8 00 00 00 00       	mov    $0x0,%eax
80108306:	eb 55                	jmp    8010835d <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
80108308:	83 ec 04             	sub    $0x4,%esp
8010830b:	68 00 10 00 00       	push   $0x1000
80108310:	6a 00                	push   $0x0
80108312:	ff 75 f0             	pushl  -0x10(%ebp)
80108315:	e8 15 d1 ff ff       	call   8010542f <memset>
8010831a:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
8010831d:	83 ec 0c             	sub    $0xc,%esp
80108320:	ff 75 f0             	pushl  -0x10(%ebp)
80108323:	e8 07 f6 ff ff       	call   8010792f <v2p>
80108328:	83 c4 10             	add    $0x10,%esp
8010832b:	89 c2                	mov    %eax,%edx
8010832d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108330:	83 ec 0c             	sub    $0xc,%esp
80108333:	6a 06                	push   $0x6
80108335:	52                   	push   %edx
80108336:	68 00 10 00 00       	push   $0x1000
8010833b:	50                   	push   %eax
8010833c:	ff 75 08             	pushl  0x8(%ebp)
8010833f:	e8 1a fb ff ff       	call   80107e5e <mappages>
80108344:	83 c4 20             	add    $0x20,%esp
  for(; a < newsz; a += PGSIZE){
80108347:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010834e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108351:	3b 45 10             	cmp    0x10(%ebp),%eax
80108354:	0f 82 75 ff ff ff    	jb     801082cf <allocuvm+0x39>
  }
  return newsz;
8010835a:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010835d:	c9                   	leave  
8010835e:	c3                   	ret    

8010835f <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010835f:	55                   	push   %ebp
80108360:	89 e5                	mov    %esp,%ebp
80108362:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108365:	8b 45 10             	mov    0x10(%ebp),%eax
80108368:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010836b:	72 08                	jb     80108375 <deallocuvm+0x16>
    return oldsz;
8010836d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108370:	e9 a5 00 00 00       	jmp    8010841a <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
80108375:	8b 45 10             	mov    0x10(%ebp),%eax
80108378:	05 ff 0f 00 00       	add    $0xfff,%eax
8010837d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108382:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108385:	e9 81 00 00 00       	jmp    8010840b <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010838a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010838d:	83 ec 04             	sub    $0x4,%esp
80108390:	6a 00                	push   $0x0
80108392:	50                   	push   %eax
80108393:	ff 75 08             	pushl  0x8(%ebp)
80108396:	e8 23 fa ff ff       	call   80107dbe <walkpgdir>
8010839b:	83 c4 10             	add    $0x10,%esp
8010839e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
801083a1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801083a5:	75 09                	jne    801083b0 <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
801083a7:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
801083ae:	eb 54                	jmp    80108404 <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
801083b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801083b3:	8b 00                	mov    (%eax),%eax
801083b5:	83 e0 01             	and    $0x1,%eax
801083b8:	85 c0                	test   %eax,%eax
801083ba:	74 48                	je     80108404 <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
801083bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801083bf:	8b 00                	mov    (%eax),%eax
801083c1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801083c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
801083c9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801083cd:	75 0d                	jne    801083dc <deallocuvm+0x7d>
        panic("kfree");
801083cf:	83 ec 0c             	sub    $0xc,%esp
801083d2:	68 11 8e 10 80       	push   $0x80108e11
801083d7:	e8 8b 81 ff ff       	call   80100567 <panic>
      char *v = p2v(pa);
801083dc:	83 ec 0c             	sub    $0xc,%esp
801083df:	ff 75 ec             	pushl  -0x14(%ebp)
801083e2:	e8 55 f5 ff ff       	call   8010793c <p2v>
801083e7:	83 c4 10             	add    $0x10,%esp
801083ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
801083ed:	83 ec 0c             	sub    $0xc,%esp
801083f0:	ff 75 e8             	pushl  -0x18(%ebp)
801083f3:	e8 d5 a7 ff ff       	call   80102bcd <kfree>
801083f8:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
801083fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801083fe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80108404:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010840b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010840e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108411:	0f 82 73 ff ff ff    	jb     8010838a <deallocuvm+0x2b>
    }
  }
  return newsz;
80108417:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010841a:	c9                   	leave  
8010841b:	c3                   	ret    

8010841c <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
8010841c:	55                   	push   %ebp
8010841d:	89 e5                	mov    %esp,%ebp
8010841f:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
80108422:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108426:	75 0d                	jne    80108435 <freevm+0x19>
    panic("freevm: no pgdir");
80108428:	83 ec 0c             	sub    $0xc,%esp
8010842b:	68 17 8e 10 80       	push   $0x80108e17
80108430:	e8 32 81 ff ff       	call   80100567 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80108435:	83 ec 04             	sub    $0x4,%esp
80108438:	6a 00                	push   $0x0
8010843a:	68 00 00 00 80       	push   $0x80000000
8010843f:	ff 75 08             	pushl  0x8(%ebp)
80108442:	e8 18 ff ff ff       	call   8010835f <deallocuvm>
80108447:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010844a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108451:	eb 4f                	jmp    801084a2 <freevm+0x86>
    if(pgdir[i] & PTE_P){
80108453:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108456:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010845d:	8b 45 08             	mov    0x8(%ebp),%eax
80108460:	01 d0                	add    %edx,%eax
80108462:	8b 00                	mov    (%eax),%eax
80108464:	83 e0 01             	and    $0x1,%eax
80108467:	85 c0                	test   %eax,%eax
80108469:	74 33                	je     8010849e <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
8010846b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010846e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108475:	8b 45 08             	mov    0x8(%ebp),%eax
80108478:	01 d0                	add    %edx,%eax
8010847a:	8b 00                	mov    (%eax),%eax
8010847c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108481:	83 ec 0c             	sub    $0xc,%esp
80108484:	50                   	push   %eax
80108485:	e8 b2 f4 ff ff       	call   8010793c <p2v>
8010848a:	83 c4 10             	add    $0x10,%esp
8010848d:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80108490:	83 ec 0c             	sub    $0xc,%esp
80108493:	ff 75 f0             	pushl  -0x10(%ebp)
80108496:	e8 32 a7 ff ff       	call   80102bcd <kfree>
8010849b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010849e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801084a2:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
801084a9:	76 a8                	jbe    80108453 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801084ab:	83 ec 0c             	sub    $0xc,%esp
801084ae:	ff 75 08             	pushl  0x8(%ebp)
801084b1:	e8 17 a7 ff ff       	call   80102bcd <kfree>
801084b6:	83 c4 10             	add    $0x10,%esp
}
801084b9:	90                   	nop
801084ba:	c9                   	leave  
801084bb:	c3                   	ret    

801084bc <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801084bc:	55                   	push   %ebp
801084bd:	89 e5                	mov    %esp,%ebp
801084bf:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801084c2:	83 ec 04             	sub    $0x4,%esp
801084c5:	6a 00                	push   $0x0
801084c7:	ff 75 0c             	pushl  0xc(%ebp)
801084ca:	ff 75 08             	pushl  0x8(%ebp)
801084cd:	e8 ec f8 ff ff       	call   80107dbe <walkpgdir>
801084d2:	83 c4 10             	add    $0x10,%esp
801084d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
801084d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801084dc:	75 0d                	jne    801084eb <clearpteu+0x2f>
    panic("clearpteu");
801084de:	83 ec 0c             	sub    $0xc,%esp
801084e1:	68 28 8e 10 80       	push   $0x80108e28
801084e6:	e8 7c 80 ff ff       	call   80100567 <panic>
  *pte &= ~PTE_U;
801084eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084ee:	8b 00                	mov    (%eax),%eax
801084f0:	83 e0 fb             	and    $0xfffffffb,%eax
801084f3:	89 c2                	mov    %eax,%edx
801084f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084f8:	89 10                	mov    %edx,(%eax)
}
801084fa:	90                   	nop
801084fb:	c9                   	leave  
801084fc:	c3                   	ret    

801084fd <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801084fd:	55                   	push   %ebp
801084fe:	89 e5                	mov    %esp,%ebp
80108500:	53                   	push   %ebx
80108501:	83 ec 24             	sub    $0x24,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108504:	e8 e5 f9 ff ff       	call   80107eee <setupkvm>
80108509:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010850c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108510:	75 0a                	jne    8010851c <copyuvm+0x1f>
    return 0;
80108512:	b8 00 00 00 00       	mov    $0x0,%eax
80108517:	e9 f8 00 00 00       	jmp    80108614 <copyuvm+0x117>
  for(i = 0; i < sz; i += PGSIZE){
8010851c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108523:	e9 c4 00 00 00       	jmp    801085ec <copyuvm+0xef>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108528:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010852b:	83 ec 04             	sub    $0x4,%esp
8010852e:	6a 00                	push   $0x0
80108530:	50                   	push   %eax
80108531:	ff 75 08             	pushl  0x8(%ebp)
80108534:	e8 85 f8 ff ff       	call   80107dbe <walkpgdir>
80108539:	83 c4 10             	add    $0x10,%esp
8010853c:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010853f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108543:	75 0d                	jne    80108552 <copyuvm+0x55>
      panic("copyuvm: pte should exist");
80108545:	83 ec 0c             	sub    $0xc,%esp
80108548:	68 32 8e 10 80       	push   $0x80108e32
8010854d:	e8 15 80 ff ff       	call   80100567 <panic>
    if(!(*pte & PTE_P))
80108552:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108555:	8b 00                	mov    (%eax),%eax
80108557:	83 e0 01             	and    $0x1,%eax
8010855a:	85 c0                	test   %eax,%eax
8010855c:	75 0d                	jne    8010856b <copyuvm+0x6e>
      panic("copyuvm: page not present");
8010855e:	83 ec 0c             	sub    $0xc,%esp
80108561:	68 4c 8e 10 80       	push   $0x80108e4c
80108566:	e8 fc 7f ff ff       	call   80100567 <panic>
    pa = PTE_ADDR(*pte);
8010856b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010856e:	8b 00                	mov    (%eax),%eax
80108570:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108575:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
80108578:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010857b:	8b 00                	mov    (%eax),%eax
8010857d:	25 ff 0f 00 00       	and    $0xfff,%eax
80108582:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80108585:	e8 e0 a6 ff ff       	call   80102c6a <kalloc>
8010858a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010858d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80108591:	74 6a                	je     801085fd <copyuvm+0x100>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
80108593:	83 ec 0c             	sub    $0xc,%esp
80108596:	ff 75 e8             	pushl  -0x18(%ebp)
80108599:	e8 9e f3 ff ff       	call   8010793c <p2v>
8010859e:	83 c4 10             	add    $0x10,%esp
801085a1:	83 ec 04             	sub    $0x4,%esp
801085a4:	68 00 10 00 00       	push   $0x1000
801085a9:	50                   	push   %eax
801085aa:	ff 75 e0             	pushl  -0x20(%ebp)
801085ad:	e8 3c cf ff ff       	call   801054ee <memmove>
801085b2:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
801085b5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801085b8:	83 ec 0c             	sub    $0xc,%esp
801085bb:	ff 75 e0             	pushl  -0x20(%ebp)
801085be:	e8 6c f3 ff ff       	call   8010792f <v2p>
801085c3:	83 c4 10             	add    $0x10,%esp
801085c6:	89 c2                	mov    %eax,%edx
801085c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085cb:	83 ec 0c             	sub    $0xc,%esp
801085ce:	53                   	push   %ebx
801085cf:	52                   	push   %edx
801085d0:	68 00 10 00 00       	push   $0x1000
801085d5:	50                   	push   %eax
801085d6:	ff 75 f0             	pushl  -0x10(%ebp)
801085d9:	e8 80 f8 ff ff       	call   80107e5e <mappages>
801085de:	83 c4 20             	add    $0x20,%esp
801085e1:	85 c0                	test   %eax,%eax
801085e3:	78 1b                	js     80108600 <copyuvm+0x103>
  for(i = 0; i < sz; i += PGSIZE){
801085e5:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801085ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085ef:	3b 45 0c             	cmp    0xc(%ebp),%eax
801085f2:	0f 82 30 ff ff ff    	jb     80108528 <copyuvm+0x2b>
      goto bad;
  }
  return d;
801085f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801085fb:	eb 17                	jmp    80108614 <copyuvm+0x117>
      goto bad;
801085fd:	90                   	nop
801085fe:	eb 01                	jmp    80108601 <copyuvm+0x104>
      goto bad;
80108600:	90                   	nop

bad:
  freevm(d);
80108601:	83 ec 0c             	sub    $0xc,%esp
80108604:	ff 75 f0             	pushl  -0x10(%ebp)
80108607:	e8 10 fe ff ff       	call   8010841c <freevm>
8010860c:	83 c4 10             	add    $0x10,%esp
  return 0;
8010860f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108614:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108617:	c9                   	leave  
80108618:	c3                   	ret    

80108619 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108619:	55                   	push   %ebp
8010861a:	89 e5                	mov    %esp,%ebp
8010861c:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010861f:	83 ec 04             	sub    $0x4,%esp
80108622:	6a 00                	push   $0x0
80108624:	ff 75 0c             	pushl  0xc(%ebp)
80108627:	ff 75 08             	pushl  0x8(%ebp)
8010862a:	e8 8f f7 ff ff       	call   80107dbe <walkpgdir>
8010862f:	83 c4 10             	add    $0x10,%esp
80108632:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80108635:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108638:	8b 00                	mov    (%eax),%eax
8010863a:	83 e0 01             	and    $0x1,%eax
8010863d:	85 c0                	test   %eax,%eax
8010863f:	75 07                	jne    80108648 <uva2ka+0x2f>
    return 0;
80108641:	b8 00 00 00 00       	mov    $0x0,%eax
80108646:	eb 2a                	jmp    80108672 <uva2ka+0x59>
  if((*pte & PTE_U) == 0)
80108648:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010864b:	8b 00                	mov    (%eax),%eax
8010864d:	83 e0 04             	and    $0x4,%eax
80108650:	85 c0                	test   %eax,%eax
80108652:	75 07                	jne    8010865b <uva2ka+0x42>
    return 0;
80108654:	b8 00 00 00 00       	mov    $0x0,%eax
80108659:	eb 17                	jmp    80108672 <uva2ka+0x59>
  return (char*)p2v(PTE_ADDR(*pte));
8010865b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010865e:	8b 00                	mov    (%eax),%eax
80108660:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108665:	83 ec 0c             	sub    $0xc,%esp
80108668:	50                   	push   %eax
80108669:	e8 ce f2 ff ff       	call   8010793c <p2v>
8010866e:	83 c4 10             	add    $0x10,%esp
80108671:	90                   	nop
}
80108672:	c9                   	leave  
80108673:	c3                   	ret    

80108674 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108674:	55                   	push   %ebp
80108675:	89 e5                	mov    %esp,%ebp
80108677:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
8010867a:	8b 45 10             	mov    0x10(%ebp),%eax
8010867d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80108680:	eb 7f                	jmp    80108701 <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
80108682:	8b 45 0c             	mov    0xc(%ebp),%eax
80108685:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010868a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
8010868d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108690:	83 ec 08             	sub    $0x8,%esp
80108693:	50                   	push   %eax
80108694:	ff 75 08             	pushl  0x8(%ebp)
80108697:	e8 7d ff ff ff       	call   80108619 <uva2ka>
8010869c:	83 c4 10             	add    $0x10,%esp
8010869f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
801086a2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801086a6:	75 07                	jne    801086af <copyout+0x3b>
      return -1;
801086a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801086ad:	eb 61                	jmp    80108710 <copyout+0x9c>
    n = PGSIZE - (va - va0);
801086af:	8b 45 ec             	mov    -0x14(%ebp),%eax
801086b2:	2b 45 0c             	sub    0xc(%ebp),%eax
801086b5:	05 00 10 00 00       	add    $0x1000,%eax
801086ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
801086bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801086c0:	3b 45 14             	cmp    0x14(%ebp),%eax
801086c3:	76 06                	jbe    801086cb <copyout+0x57>
      n = len;
801086c5:	8b 45 14             	mov    0x14(%ebp),%eax
801086c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
801086cb:	8b 45 0c             	mov    0xc(%ebp),%eax
801086ce:	2b 45 ec             	sub    -0x14(%ebp),%eax
801086d1:	89 c2                	mov    %eax,%edx
801086d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801086d6:	01 d0                	add    %edx,%eax
801086d8:	83 ec 04             	sub    $0x4,%esp
801086db:	ff 75 f0             	pushl  -0x10(%ebp)
801086de:	ff 75 f4             	pushl  -0xc(%ebp)
801086e1:	50                   	push   %eax
801086e2:	e8 07 ce ff ff       	call   801054ee <memmove>
801086e7:	83 c4 10             	add    $0x10,%esp
    len -= n;
801086ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
801086ed:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
801086f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801086f3:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
801086f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801086f9:	05 00 10 00 00       	add    $0x1000,%eax
801086fe:	89 45 0c             	mov    %eax,0xc(%ebp)
  while(len > 0){
80108701:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108705:	0f 85 77 ff ff ff    	jne    80108682 <copyout+0xe>
  }
  return 0;
8010870b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108710:	c9                   	leave  
80108711:	c3                   	ret    
