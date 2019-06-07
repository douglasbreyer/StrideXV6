
_zombie:     formato de ficheiro elf32-i386


Desmontagem da secção .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork(0) > 0)
  11:	83 ec 0c             	sub    $0xc,%esp
  14:	6a 00                	push   $0x0
  16:	e8 68 02 00 00       	call   283 <fork>
  1b:	83 c4 10             	add    $0x10,%esp
  1e:	85 c0                	test   %eax,%eax
  20:	7e 0d                	jle    2f <main+0x2f>
    sleep(5);  // Let child exit before parent.
  22:	83 ec 0c             	sub    $0xc,%esp
  25:	6a 05                	push   $0x5
  27:	e8 ef 02 00 00       	call   31b <sleep>
  2c:	83 c4 10             	add    $0x10,%esp
  exit();
  2f:	e8 57 02 00 00       	call   28b <exit>

00000034 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  34:	55                   	push   %ebp
  35:	89 e5                	mov    %esp,%ebp
  37:	57                   	push   %edi
  38:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  39:	8b 4d 08             	mov    0x8(%ebp),%ecx
  3c:	8b 55 10             	mov    0x10(%ebp),%edx
  3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  42:	89 cb                	mov    %ecx,%ebx
  44:	89 df                	mov    %ebx,%edi
  46:	89 d1                	mov    %edx,%ecx
  48:	fc                   	cld    
  49:	f3 aa                	rep stos %al,%es:(%edi)
  4b:	89 ca                	mov    %ecx,%edx
  4d:	89 fb                	mov    %edi,%ebx
  4f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  52:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  55:	90                   	nop
  56:	5b                   	pop    %ebx
  57:	5f                   	pop    %edi
  58:	5d                   	pop    %ebp
  59:	c3                   	ret    

0000005a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  5a:	55                   	push   %ebp
  5b:	89 e5                	mov    %esp,%ebp
  5d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  60:	8b 45 08             	mov    0x8(%ebp),%eax
  63:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  66:	90                   	nop
  67:	8b 55 0c             	mov    0xc(%ebp),%edx
  6a:	8d 42 01             	lea    0x1(%edx),%eax
  6d:	89 45 0c             	mov    %eax,0xc(%ebp)
  70:	8b 45 08             	mov    0x8(%ebp),%eax
  73:	8d 48 01             	lea    0x1(%eax),%ecx
  76:	89 4d 08             	mov    %ecx,0x8(%ebp)
  79:	0f b6 12             	movzbl (%edx),%edx
  7c:	88 10                	mov    %dl,(%eax)
  7e:	0f b6 00             	movzbl (%eax),%eax
  81:	84 c0                	test   %al,%al
  83:	75 e2                	jne    67 <strcpy+0xd>
    ;
  return os;
  85:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  88:	c9                   	leave  
  89:	c3                   	ret    

0000008a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8a:	55                   	push   %ebp
  8b:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  8d:	eb 08                	jmp    97 <strcmp+0xd>
    p++, q++;
  8f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  93:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  97:	8b 45 08             	mov    0x8(%ebp),%eax
  9a:	0f b6 00             	movzbl (%eax),%eax
  9d:	84 c0                	test   %al,%al
  9f:	74 10                	je     b1 <strcmp+0x27>
  a1:	8b 45 08             	mov    0x8(%ebp),%eax
  a4:	0f b6 10             	movzbl (%eax),%edx
  a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  aa:	0f b6 00             	movzbl (%eax),%eax
  ad:	38 c2                	cmp    %al,%dl
  af:	74 de                	je     8f <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  b1:	8b 45 08             	mov    0x8(%ebp),%eax
  b4:	0f b6 00             	movzbl (%eax),%eax
  b7:	0f b6 d0             	movzbl %al,%edx
  ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  bd:	0f b6 00             	movzbl (%eax),%eax
  c0:	0f b6 c0             	movzbl %al,%eax
  c3:	29 c2                	sub    %eax,%edx
  c5:	89 d0                	mov    %edx,%eax
}
  c7:	5d                   	pop    %ebp
  c8:	c3                   	ret    

000000c9 <strlen>:

uint
strlen(char *s)
{
  c9:	55                   	push   %ebp
  ca:	89 e5                	mov    %esp,%ebp
  cc:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  d6:	eb 04                	jmp    dc <strlen+0x13>
  d8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  dc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  df:	8b 45 08             	mov    0x8(%ebp),%eax
  e2:	01 d0                	add    %edx,%eax
  e4:	0f b6 00             	movzbl (%eax),%eax
  e7:	84 c0                	test   %al,%al
  e9:	75 ed                	jne    d8 <strlen+0xf>
    ;
  return n;
  eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ee:	c9                   	leave  
  ef:	c3                   	ret    

000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  f3:	8b 45 10             	mov    0x10(%ebp),%eax
  f6:	50                   	push   %eax
  f7:	ff 75 0c             	pushl  0xc(%ebp)
  fa:	ff 75 08             	pushl  0x8(%ebp)
  fd:	e8 32 ff ff ff       	call   34 <stosb>
 102:	83 c4 0c             	add    $0xc,%esp
  return dst;
 105:	8b 45 08             	mov    0x8(%ebp),%eax
}
 108:	c9                   	leave  
 109:	c3                   	ret    

0000010a <strchr>:

char*
strchr(const char *s, char c)
{
 10a:	55                   	push   %ebp
 10b:	89 e5                	mov    %esp,%ebp
 10d:	83 ec 04             	sub    $0x4,%esp
 110:	8b 45 0c             	mov    0xc(%ebp),%eax
 113:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 116:	eb 14                	jmp    12c <strchr+0x22>
    if(*s == c)
 118:	8b 45 08             	mov    0x8(%ebp),%eax
 11b:	0f b6 00             	movzbl (%eax),%eax
 11e:	38 45 fc             	cmp    %al,-0x4(%ebp)
 121:	75 05                	jne    128 <strchr+0x1e>
      return (char*)s;
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	eb 13                	jmp    13b <strchr+0x31>
  for(; *s; s++)
 128:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 12c:	8b 45 08             	mov    0x8(%ebp),%eax
 12f:	0f b6 00             	movzbl (%eax),%eax
 132:	84 c0                	test   %al,%al
 134:	75 e2                	jne    118 <strchr+0xe>
  return 0;
 136:	b8 00 00 00 00       	mov    $0x0,%eax
}
 13b:	c9                   	leave  
 13c:	c3                   	ret    

0000013d <gets>:

char*
gets(char *buf, int max)
{
 13d:	55                   	push   %ebp
 13e:	89 e5                	mov    %esp,%ebp
 140:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 143:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 14a:	eb 42                	jmp    18e <gets+0x51>
    cc = read(0, &c, 1);
 14c:	83 ec 04             	sub    $0x4,%esp
 14f:	6a 01                	push   $0x1
 151:	8d 45 ef             	lea    -0x11(%ebp),%eax
 154:	50                   	push   %eax
 155:	6a 00                	push   $0x0
 157:	e8 47 01 00 00       	call   2a3 <read>
 15c:	83 c4 10             	add    $0x10,%esp
 15f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 162:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 166:	7e 33                	jle    19b <gets+0x5e>
      break;
    buf[i++] = c;
 168:	8b 45 f4             	mov    -0xc(%ebp),%eax
 16b:	8d 50 01             	lea    0x1(%eax),%edx
 16e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 171:	89 c2                	mov    %eax,%edx
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	01 c2                	add    %eax,%edx
 178:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17c:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 17e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 182:	3c 0a                	cmp    $0xa,%al
 184:	74 16                	je     19c <gets+0x5f>
 186:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 18a:	3c 0d                	cmp    $0xd,%al
 18c:	74 0e                	je     19c <gets+0x5f>
  for(i=0; i+1 < max; ){
 18e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 191:	83 c0 01             	add    $0x1,%eax
 194:	39 45 0c             	cmp    %eax,0xc(%ebp)
 197:	7f b3                	jg     14c <gets+0xf>
 199:	eb 01                	jmp    19c <gets+0x5f>
      break;
 19b:	90                   	nop
      break;
  }
  buf[i] = '\0';
 19c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 19f:	8b 45 08             	mov    0x8(%ebp),%eax
 1a2:	01 d0                	add    %edx,%eax
 1a4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1aa:	c9                   	leave  
 1ab:	c3                   	ret    

000001ac <stat>:

int
stat(char *n, struct stat *st)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b2:	83 ec 08             	sub    $0x8,%esp
 1b5:	6a 00                	push   $0x0
 1b7:	ff 75 08             	pushl  0x8(%ebp)
 1ba:	e8 0c 01 00 00       	call   2cb <open>
 1bf:	83 c4 10             	add    $0x10,%esp
 1c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1c9:	79 07                	jns    1d2 <stat+0x26>
    return -1;
 1cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d0:	eb 25                	jmp    1f7 <stat+0x4b>
  r = fstat(fd, st);
 1d2:	83 ec 08             	sub    $0x8,%esp
 1d5:	ff 75 0c             	pushl  0xc(%ebp)
 1d8:	ff 75 f4             	pushl  -0xc(%ebp)
 1db:	e8 03 01 00 00       	call   2e3 <fstat>
 1e0:	83 c4 10             	add    $0x10,%esp
 1e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1e6:	83 ec 0c             	sub    $0xc,%esp
 1e9:	ff 75 f4             	pushl  -0xc(%ebp)
 1ec:	e8 c2 00 00 00       	call   2b3 <close>
 1f1:	83 c4 10             	add    $0x10,%esp
  return r;
 1f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1f7:	c9                   	leave  
 1f8:	c3                   	ret    

000001f9 <atoi>:

int
atoi(const char *s)
{
 1f9:	55                   	push   %ebp
 1fa:	89 e5                	mov    %esp,%ebp
 1fc:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 206:	eb 25                	jmp    22d <atoi+0x34>
    n = n*10 + *s++ - '0';
 208:	8b 55 fc             	mov    -0x4(%ebp),%edx
 20b:	89 d0                	mov    %edx,%eax
 20d:	c1 e0 02             	shl    $0x2,%eax
 210:	01 d0                	add    %edx,%eax
 212:	01 c0                	add    %eax,%eax
 214:	89 c1                	mov    %eax,%ecx
 216:	8b 45 08             	mov    0x8(%ebp),%eax
 219:	8d 50 01             	lea    0x1(%eax),%edx
 21c:	89 55 08             	mov    %edx,0x8(%ebp)
 21f:	0f b6 00             	movzbl (%eax),%eax
 222:	0f be c0             	movsbl %al,%eax
 225:	01 c8                	add    %ecx,%eax
 227:	83 e8 30             	sub    $0x30,%eax
 22a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 22d:	8b 45 08             	mov    0x8(%ebp),%eax
 230:	0f b6 00             	movzbl (%eax),%eax
 233:	3c 2f                	cmp    $0x2f,%al
 235:	7e 0a                	jle    241 <atoi+0x48>
 237:	8b 45 08             	mov    0x8(%ebp),%eax
 23a:	0f b6 00             	movzbl (%eax),%eax
 23d:	3c 39                	cmp    $0x39,%al
 23f:	7e c7                	jle    208 <atoi+0xf>
  return n;
 241:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 244:	c9                   	leave  
 245:	c3                   	ret    

00000246 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 246:	55                   	push   %ebp
 247:	89 e5                	mov    %esp,%ebp
 249:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 24c:	8b 45 08             	mov    0x8(%ebp),%eax
 24f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 252:	8b 45 0c             	mov    0xc(%ebp),%eax
 255:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 258:	eb 17                	jmp    271 <memmove+0x2b>
    *dst++ = *src++;
 25a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 25d:	8d 42 01             	lea    0x1(%edx),%eax
 260:	89 45 f8             	mov    %eax,-0x8(%ebp)
 263:	8b 45 fc             	mov    -0x4(%ebp),%eax
 266:	8d 48 01             	lea    0x1(%eax),%ecx
 269:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 26c:	0f b6 12             	movzbl (%edx),%edx
 26f:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 271:	8b 45 10             	mov    0x10(%ebp),%eax
 274:	8d 50 ff             	lea    -0x1(%eax),%edx
 277:	89 55 10             	mov    %edx,0x10(%ebp)
 27a:	85 c0                	test   %eax,%eax
 27c:	7f dc                	jg     25a <memmove+0x14>
  return vdst;
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 281:	c9                   	leave  
 282:	c3                   	ret    

00000283 <fork>:
 283:	b8 01 00 00 00       	mov    $0x1,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <exit>:
 28b:	b8 02 00 00 00       	mov    $0x2,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <wait>:
 293:	b8 03 00 00 00       	mov    $0x3,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <pipe>:
 29b:	b8 04 00 00 00       	mov    $0x4,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <read>:
 2a3:	b8 05 00 00 00       	mov    $0x5,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <write>:
 2ab:	b8 10 00 00 00       	mov    $0x10,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <close>:
 2b3:	b8 15 00 00 00       	mov    $0x15,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <kill>:
 2bb:	b8 06 00 00 00       	mov    $0x6,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <exec>:
 2c3:	b8 07 00 00 00       	mov    $0x7,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <open>:
 2cb:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <mknod>:
 2d3:	b8 11 00 00 00       	mov    $0x11,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <unlink>:
 2db:	b8 12 00 00 00       	mov    $0x12,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <fstat>:
 2e3:	b8 08 00 00 00       	mov    $0x8,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <link>:
 2eb:	b8 13 00 00 00       	mov    $0x13,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <mkdir>:
 2f3:	b8 14 00 00 00       	mov    $0x14,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <chdir>:
 2fb:	b8 09 00 00 00       	mov    $0x9,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <dup>:
 303:	b8 0a 00 00 00       	mov    $0xa,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <getpid>:
 30b:	b8 0b 00 00 00       	mov    $0xb,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <sbrk>:
 313:	b8 0c 00 00 00       	mov    $0xc,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <sleep>:
 31b:	b8 0d 00 00 00       	mov    $0xd,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <uptime>:
 323:	b8 0e 00 00 00       	mov    $0xe,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 32b:	55                   	push   %ebp
 32c:	89 e5                	mov    %esp,%ebp
 32e:	83 ec 18             	sub    $0x18,%esp
 331:	8b 45 0c             	mov    0xc(%ebp),%eax
 334:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 337:	83 ec 04             	sub    $0x4,%esp
 33a:	6a 01                	push   $0x1
 33c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 33f:	50                   	push   %eax
 340:	ff 75 08             	pushl  0x8(%ebp)
 343:	e8 63 ff ff ff       	call   2ab <write>
 348:	83 c4 10             	add    $0x10,%esp
}
 34b:	90                   	nop
 34c:	c9                   	leave  
 34d:	c3                   	ret    

0000034e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 34e:	55                   	push   %ebp
 34f:	89 e5                	mov    %esp,%ebp
 351:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 354:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 35b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 35f:	74 17                	je     378 <printint+0x2a>
 361:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 365:	79 11                	jns    378 <printint+0x2a>
    neg = 1;
 367:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 36e:	8b 45 0c             	mov    0xc(%ebp),%eax
 371:	f7 d8                	neg    %eax
 373:	89 45 ec             	mov    %eax,-0x14(%ebp)
 376:	eb 06                	jmp    37e <printint+0x30>
  } else {
    x = xx;
 378:	8b 45 0c             	mov    0xc(%ebp),%eax
 37b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 37e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 385:	8b 4d 10             	mov    0x10(%ebp),%ecx
 388:	8b 45 ec             	mov    -0x14(%ebp),%eax
 38b:	ba 00 00 00 00       	mov    $0x0,%edx
 390:	f7 f1                	div    %ecx
 392:	89 d1                	mov    %edx,%ecx
 394:	8b 45 f4             	mov    -0xc(%ebp),%eax
 397:	8d 50 01             	lea    0x1(%eax),%edx
 39a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 39d:	0f b6 91 00 0a 00 00 	movzbl 0xa00(%ecx),%edx
 3a4:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 3a8:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ae:	ba 00 00 00 00       	mov    $0x0,%edx
 3b3:	f7 f1                	div    %ecx
 3b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3b8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3bc:	75 c7                	jne    385 <printint+0x37>
  if(neg)
 3be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3c2:	74 2d                	je     3f1 <printint+0xa3>
    buf[i++] = '-';
 3c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3c7:	8d 50 01             	lea    0x1(%eax),%edx
 3ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3cd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3d2:	eb 1d                	jmp    3f1 <printint+0xa3>
    putc(fd, buf[i]);
 3d4:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3da:	01 d0                	add    %edx,%eax
 3dc:	0f b6 00             	movzbl (%eax),%eax
 3df:	0f be c0             	movsbl %al,%eax
 3e2:	83 ec 08             	sub    $0x8,%esp
 3e5:	50                   	push   %eax
 3e6:	ff 75 08             	pushl  0x8(%ebp)
 3e9:	e8 3d ff ff ff       	call   32b <putc>
 3ee:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 3f1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 3f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3f9:	79 d9                	jns    3d4 <printint+0x86>
}
 3fb:	90                   	nop
 3fc:	c9                   	leave  
 3fd:	c3                   	ret    

000003fe <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3fe:	55                   	push   %ebp
 3ff:	89 e5                	mov    %esp,%ebp
 401:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 404:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 40b:	8d 45 0c             	lea    0xc(%ebp),%eax
 40e:	83 c0 04             	add    $0x4,%eax
 411:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 414:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 41b:	e9 59 01 00 00       	jmp    579 <printf+0x17b>
    c = fmt[i] & 0xff;
 420:	8b 55 0c             	mov    0xc(%ebp),%edx
 423:	8b 45 f0             	mov    -0x10(%ebp),%eax
 426:	01 d0                	add    %edx,%eax
 428:	0f b6 00             	movzbl (%eax),%eax
 42b:	0f be c0             	movsbl %al,%eax
 42e:	25 ff 00 00 00       	and    $0xff,%eax
 433:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 436:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 43a:	75 2c                	jne    468 <printf+0x6a>
      if(c == '%'){
 43c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 440:	75 0c                	jne    44e <printf+0x50>
        state = '%';
 442:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 449:	e9 27 01 00 00       	jmp    575 <printf+0x177>
      } else {
        putc(fd, c);
 44e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 451:	0f be c0             	movsbl %al,%eax
 454:	83 ec 08             	sub    $0x8,%esp
 457:	50                   	push   %eax
 458:	ff 75 08             	pushl  0x8(%ebp)
 45b:	e8 cb fe ff ff       	call   32b <putc>
 460:	83 c4 10             	add    $0x10,%esp
 463:	e9 0d 01 00 00       	jmp    575 <printf+0x177>
      }
    } else if(state == '%'){
 468:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 46c:	0f 85 03 01 00 00    	jne    575 <printf+0x177>
      if(c == 'd'){
 472:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 476:	75 1e                	jne    496 <printf+0x98>
        printint(fd, *ap, 10, 1);
 478:	8b 45 e8             	mov    -0x18(%ebp),%eax
 47b:	8b 00                	mov    (%eax),%eax
 47d:	6a 01                	push   $0x1
 47f:	6a 0a                	push   $0xa
 481:	50                   	push   %eax
 482:	ff 75 08             	pushl  0x8(%ebp)
 485:	e8 c4 fe ff ff       	call   34e <printint>
 48a:	83 c4 10             	add    $0x10,%esp
        ap++;
 48d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 491:	e9 d8 00 00 00       	jmp    56e <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 496:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 49a:	74 06                	je     4a2 <printf+0xa4>
 49c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4a0:	75 1e                	jne    4c0 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a5:	8b 00                	mov    (%eax),%eax
 4a7:	6a 00                	push   $0x0
 4a9:	6a 10                	push   $0x10
 4ab:	50                   	push   %eax
 4ac:	ff 75 08             	pushl  0x8(%ebp)
 4af:	e8 9a fe ff ff       	call   34e <printint>
 4b4:	83 c4 10             	add    $0x10,%esp
        ap++;
 4b7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4bb:	e9 ae 00 00 00       	jmp    56e <printf+0x170>
      } else if(c == 's'){
 4c0:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4c4:	75 43                	jne    509 <printf+0x10b>
        s = (char*)*ap;
 4c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c9:	8b 00                	mov    (%eax),%eax
 4cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4d6:	75 25                	jne    4fd <printf+0xff>
          s = "(null)";
 4d8:	c7 45 f4 b4 07 00 00 	movl   $0x7b4,-0xc(%ebp)
        while(*s != 0){
 4df:	eb 1c                	jmp    4fd <printf+0xff>
          putc(fd, *s);
 4e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4e4:	0f b6 00             	movzbl (%eax),%eax
 4e7:	0f be c0             	movsbl %al,%eax
 4ea:	83 ec 08             	sub    $0x8,%esp
 4ed:	50                   	push   %eax
 4ee:	ff 75 08             	pushl  0x8(%ebp)
 4f1:	e8 35 fe ff ff       	call   32b <putc>
 4f6:	83 c4 10             	add    $0x10,%esp
          s++;
 4f9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 4fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 500:	0f b6 00             	movzbl (%eax),%eax
 503:	84 c0                	test   %al,%al
 505:	75 da                	jne    4e1 <printf+0xe3>
 507:	eb 65                	jmp    56e <printf+0x170>
        }
      } else if(c == 'c'){
 509:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 50d:	75 1d                	jne    52c <printf+0x12e>
        putc(fd, *ap);
 50f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 512:	8b 00                	mov    (%eax),%eax
 514:	0f be c0             	movsbl %al,%eax
 517:	83 ec 08             	sub    $0x8,%esp
 51a:	50                   	push   %eax
 51b:	ff 75 08             	pushl  0x8(%ebp)
 51e:	e8 08 fe ff ff       	call   32b <putc>
 523:	83 c4 10             	add    $0x10,%esp
        ap++;
 526:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 52a:	eb 42                	jmp    56e <printf+0x170>
      } else if(c == '%'){
 52c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 530:	75 17                	jne    549 <printf+0x14b>
        putc(fd, c);
 532:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 535:	0f be c0             	movsbl %al,%eax
 538:	83 ec 08             	sub    $0x8,%esp
 53b:	50                   	push   %eax
 53c:	ff 75 08             	pushl  0x8(%ebp)
 53f:	e8 e7 fd ff ff       	call   32b <putc>
 544:	83 c4 10             	add    $0x10,%esp
 547:	eb 25                	jmp    56e <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 549:	83 ec 08             	sub    $0x8,%esp
 54c:	6a 25                	push   $0x25
 54e:	ff 75 08             	pushl  0x8(%ebp)
 551:	e8 d5 fd ff ff       	call   32b <putc>
 556:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 559:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 55c:	0f be c0             	movsbl %al,%eax
 55f:	83 ec 08             	sub    $0x8,%esp
 562:	50                   	push   %eax
 563:	ff 75 08             	pushl  0x8(%ebp)
 566:	e8 c0 fd ff ff       	call   32b <putc>
 56b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 56e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 575:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 579:	8b 55 0c             	mov    0xc(%ebp),%edx
 57c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 57f:	01 d0                	add    %edx,%eax
 581:	0f b6 00             	movzbl (%eax),%eax
 584:	84 c0                	test   %al,%al
 586:	0f 85 94 fe ff ff    	jne    420 <printf+0x22>
    }
  }
}
 58c:	90                   	nop
 58d:	c9                   	leave  
 58e:	c3                   	ret    

0000058f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 58f:	55                   	push   %ebp
 590:	89 e5                	mov    %esp,%ebp
 592:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 595:	8b 45 08             	mov    0x8(%ebp),%eax
 598:	83 e8 08             	sub    $0x8,%eax
 59b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 59e:	a1 1c 0a 00 00       	mov    0xa1c,%eax
 5a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5a6:	eb 24                	jmp    5cc <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ab:	8b 00                	mov    (%eax),%eax
 5ad:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5b0:	72 12                	jb     5c4 <free+0x35>
 5b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5b5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5b8:	77 24                	ja     5de <free+0x4f>
 5ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5bd:	8b 00                	mov    (%eax),%eax
 5bf:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5c2:	72 1a                	jb     5de <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5c7:	8b 00                	mov    (%eax),%eax
 5c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5cf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d2:	76 d4                	jbe    5a8 <free+0x19>
 5d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d7:	8b 00                	mov    (%eax),%eax
 5d9:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5dc:	73 ca                	jae    5a8 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5e1:	8b 40 04             	mov    0x4(%eax),%eax
 5e4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ee:	01 c2                	add    %eax,%edx
 5f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f3:	8b 00                	mov    (%eax),%eax
 5f5:	39 c2                	cmp    %eax,%edx
 5f7:	75 24                	jne    61d <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 5f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fc:	8b 50 04             	mov    0x4(%eax),%edx
 5ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 602:	8b 00                	mov    (%eax),%eax
 604:	8b 40 04             	mov    0x4(%eax),%eax
 607:	01 c2                	add    %eax,%edx
 609:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 60f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 612:	8b 00                	mov    (%eax),%eax
 614:	8b 10                	mov    (%eax),%edx
 616:	8b 45 f8             	mov    -0x8(%ebp),%eax
 619:	89 10                	mov    %edx,(%eax)
 61b:	eb 0a                	jmp    627 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 61d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 620:	8b 10                	mov    (%eax),%edx
 622:	8b 45 f8             	mov    -0x8(%ebp),%eax
 625:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 627:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62a:	8b 40 04             	mov    0x4(%eax),%eax
 62d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 634:	8b 45 fc             	mov    -0x4(%ebp),%eax
 637:	01 d0                	add    %edx,%eax
 639:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 63c:	75 20                	jne    65e <free+0xcf>
    p->s.size += bp->s.size;
 63e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 641:	8b 50 04             	mov    0x4(%eax),%edx
 644:	8b 45 f8             	mov    -0x8(%ebp),%eax
 647:	8b 40 04             	mov    0x4(%eax),%eax
 64a:	01 c2                	add    %eax,%edx
 64c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 652:	8b 45 f8             	mov    -0x8(%ebp),%eax
 655:	8b 10                	mov    (%eax),%edx
 657:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65a:	89 10                	mov    %edx,(%eax)
 65c:	eb 08                	jmp    666 <free+0xd7>
  } else
    p->s.ptr = bp;
 65e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 661:	8b 55 f8             	mov    -0x8(%ebp),%edx
 664:	89 10                	mov    %edx,(%eax)
  freep = p;
 666:	8b 45 fc             	mov    -0x4(%ebp),%eax
 669:	a3 1c 0a 00 00       	mov    %eax,0xa1c
}
 66e:	90                   	nop
 66f:	c9                   	leave  
 670:	c3                   	ret    

00000671 <morecore>:

static Header*
morecore(uint nu)
{
 671:	55                   	push   %ebp
 672:	89 e5                	mov    %esp,%ebp
 674:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 677:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 67e:	77 07                	ja     687 <morecore+0x16>
    nu = 4096;
 680:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 687:	8b 45 08             	mov    0x8(%ebp),%eax
 68a:	c1 e0 03             	shl    $0x3,%eax
 68d:	83 ec 0c             	sub    $0xc,%esp
 690:	50                   	push   %eax
 691:	e8 7d fc ff ff       	call   313 <sbrk>
 696:	83 c4 10             	add    $0x10,%esp
 699:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 69c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6a0:	75 07                	jne    6a9 <morecore+0x38>
    return 0;
 6a2:	b8 00 00 00 00       	mov    $0x0,%eax
 6a7:	eb 26                	jmp    6cf <morecore+0x5e>
  hp = (Header*)p;
 6a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6af:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b2:	8b 55 08             	mov    0x8(%ebp),%edx
 6b5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6bb:	83 c0 08             	add    $0x8,%eax
 6be:	83 ec 0c             	sub    $0xc,%esp
 6c1:	50                   	push   %eax
 6c2:	e8 c8 fe ff ff       	call   58f <free>
 6c7:	83 c4 10             	add    $0x10,%esp
  return freep;
 6ca:	a1 1c 0a 00 00       	mov    0xa1c,%eax
}
 6cf:	c9                   	leave  
 6d0:	c3                   	ret    

000006d1 <malloc>:

void*
malloc(uint nbytes)
{
 6d1:	55                   	push   %ebp
 6d2:	89 e5                	mov    %esp,%ebp
 6d4:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d7:	8b 45 08             	mov    0x8(%ebp),%eax
 6da:	83 c0 07             	add    $0x7,%eax
 6dd:	c1 e8 03             	shr    $0x3,%eax
 6e0:	83 c0 01             	add    $0x1,%eax
 6e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6e6:	a1 1c 0a 00 00       	mov    0xa1c,%eax
 6eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6f2:	75 23                	jne    717 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 6f4:	c7 45 f0 14 0a 00 00 	movl   $0xa14,-0x10(%ebp)
 6fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6fe:	a3 1c 0a 00 00       	mov    %eax,0xa1c
 703:	a1 1c 0a 00 00       	mov    0xa1c,%eax
 708:	a3 14 0a 00 00       	mov    %eax,0xa14
    base.s.size = 0;
 70d:	c7 05 18 0a 00 00 00 	movl   $0x0,0xa18
 714:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 717:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71a:	8b 00                	mov    (%eax),%eax
 71c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 71f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 722:	8b 40 04             	mov    0x4(%eax),%eax
 725:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 728:	77 4d                	ja     777 <malloc+0xa6>
      if(p->s.size == nunits)
 72a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72d:	8b 40 04             	mov    0x4(%eax),%eax
 730:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 733:	75 0c                	jne    741 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 735:	8b 45 f4             	mov    -0xc(%ebp),%eax
 738:	8b 10                	mov    (%eax),%edx
 73a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73d:	89 10                	mov    %edx,(%eax)
 73f:	eb 26                	jmp    767 <malloc+0x96>
      else {
        p->s.size -= nunits;
 741:	8b 45 f4             	mov    -0xc(%ebp),%eax
 744:	8b 40 04             	mov    0x4(%eax),%eax
 747:	2b 45 ec             	sub    -0x14(%ebp),%eax
 74a:	89 c2                	mov    %eax,%edx
 74c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 752:	8b 45 f4             	mov    -0xc(%ebp),%eax
 755:	8b 40 04             	mov    0x4(%eax),%eax
 758:	c1 e0 03             	shl    $0x3,%eax
 75b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 75e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 761:	8b 55 ec             	mov    -0x14(%ebp),%edx
 764:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 767:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76a:	a3 1c 0a 00 00       	mov    %eax,0xa1c
      return (void*)(p + 1);
 76f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 772:	83 c0 08             	add    $0x8,%eax
 775:	eb 3b                	jmp    7b2 <malloc+0xe1>
    }
    if(p == freep)
 777:	a1 1c 0a 00 00       	mov    0xa1c,%eax
 77c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 77f:	75 1e                	jne    79f <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 781:	83 ec 0c             	sub    $0xc,%esp
 784:	ff 75 ec             	pushl  -0x14(%ebp)
 787:	e8 e5 fe ff ff       	call   671 <morecore>
 78c:	83 c4 10             	add    $0x10,%esp
 78f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 792:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 796:	75 07                	jne    79f <malloc+0xce>
        return 0;
 798:	b8 00 00 00 00       	mov    $0x0,%eax
 79d:	eb 13                	jmp    7b2 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 79f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a8:	8b 00                	mov    (%eax),%eax
 7aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7ad:	e9 6d ff ff ff       	jmp    71f <malloc+0x4e>
  }
}
 7b2:	c9                   	leave  
 7b3:	c3                   	ret    
