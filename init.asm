
_init:     formato de ficheiro elf32-i386


Desmontagem da secção .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  11:	83 ec 08             	sub    $0x8,%esp
  14:	6a 02                	push   $0x2
  16:	68 8c 08 00 00       	push   $0x88c
  1b:	e8 80 03 00 00       	call   3a0 <open>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
  27:	83 ec 04             	sub    $0x4,%esp
  2a:	6a 01                	push   $0x1
  2c:	6a 01                	push   $0x1
  2e:	68 8c 08 00 00       	push   $0x88c
  33:	e8 70 03 00 00       	call   3a8 <mknod>
  38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	6a 02                	push   $0x2
  40:	68 8c 08 00 00       	push   $0x88c
  45:	e8 56 03 00 00       	call   3a0 <open>
  4a:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	6a 00                	push   $0x0
  52:	e8 81 03 00 00       	call   3d8 <dup>
  57:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
  5a:	83 ec 0c             	sub    $0xc,%esp
  5d:	6a 00                	push   $0x0
  5f:	e8 74 03 00 00       	call   3d8 <dup>
  64:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  67:	83 ec 08             	sub    $0x8,%esp
  6a:	68 94 08 00 00       	push   $0x894
  6f:	6a 01                	push   $0x1
  71:	e8 5d 04 00 00       	call   4d3 <printf>
  76:	83 c4 10             	add    $0x10,%esp
    pid = fork(0);
  79:	83 ec 0c             	sub    $0xc,%esp
  7c:	6a 00                	push   $0x0
  7e:	e8 d5 02 00 00       	call   358 <fork>
  83:	83 c4 10             	add    $0x10,%esp
  86:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
  89:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8d:	79 17                	jns    a6 <main+0xa6>
      printf(1, "init: fork failed\n");
  8f:	83 ec 08             	sub    $0x8,%esp
  92:	68 a7 08 00 00       	push   $0x8a7
  97:	6a 01                	push   $0x1
  99:	e8 35 04 00 00       	call   4d3 <printf>
  9e:	83 c4 10             	add    $0x10,%esp
      exit();
  a1:	e8 ba 02 00 00       	call   360 <exit>
    }
    if(pid == 0){
  a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  aa:	75 3e                	jne    ea <main+0xea>
      exec("sh", argv);
  ac:	83 ec 08             	sub    $0x8,%esp
  af:	68 24 0b 00 00       	push   $0xb24
  b4:	68 89 08 00 00       	push   $0x889
  b9:	e8 da 02 00 00       	call   398 <exec>
  be:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
  c1:	83 ec 08             	sub    $0x8,%esp
  c4:	68 ba 08 00 00       	push   $0x8ba
  c9:	6a 01                	push   $0x1
  cb:	e8 03 04 00 00       	call   4d3 <printf>
  d0:	83 c4 10             	add    $0x10,%esp
      exit();
  d3:	e8 88 02 00 00       	call   360 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  d8:	83 ec 08             	sub    $0x8,%esp
  db:	68 d0 08 00 00       	push   $0x8d0
  e0:	6a 01                	push   $0x1
  e2:	e8 ec 03 00 00       	call   4d3 <printf>
  e7:	83 c4 10             	add    $0x10,%esp
    while((wpid=wait()) >= 0 && wpid != pid)
  ea:	e8 79 02 00 00       	call   368 <wait>
  ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  f6:	0f 88 6b ff ff ff    	js     67 <main+0x67>
  fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  ff:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 102:	75 d4                	jne    d8 <main+0xd8>
    printf(1, "init: starting sh\n");
 104:	e9 5e ff ff ff       	jmp    67 <main+0x67>

00000109 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 109:	55                   	push   %ebp
 10a:	89 e5                	mov    %esp,%ebp
 10c:	57                   	push   %edi
 10d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 10e:	8b 4d 08             	mov    0x8(%ebp),%ecx
 111:	8b 55 10             	mov    0x10(%ebp),%edx
 114:	8b 45 0c             	mov    0xc(%ebp),%eax
 117:	89 cb                	mov    %ecx,%ebx
 119:	89 df                	mov    %ebx,%edi
 11b:	89 d1                	mov    %edx,%ecx
 11d:	fc                   	cld    
 11e:	f3 aa                	rep stos %al,%es:(%edi)
 120:	89 ca                	mov    %ecx,%edx
 122:	89 fb                	mov    %edi,%ebx
 124:	89 5d 08             	mov    %ebx,0x8(%ebp)
 127:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 12a:	90                   	nop
 12b:	5b                   	pop    %ebx
 12c:	5f                   	pop    %edi
 12d:	5d                   	pop    %ebp
 12e:	c3                   	ret    

0000012f <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 12f:	55                   	push   %ebp
 130:	89 e5                	mov    %esp,%ebp
 132:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 135:	8b 45 08             	mov    0x8(%ebp),%eax
 138:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 13b:	90                   	nop
 13c:	8b 55 0c             	mov    0xc(%ebp),%edx
 13f:	8d 42 01             	lea    0x1(%edx),%eax
 142:	89 45 0c             	mov    %eax,0xc(%ebp)
 145:	8b 45 08             	mov    0x8(%ebp),%eax
 148:	8d 48 01             	lea    0x1(%eax),%ecx
 14b:	89 4d 08             	mov    %ecx,0x8(%ebp)
 14e:	0f b6 12             	movzbl (%edx),%edx
 151:	88 10                	mov    %dl,(%eax)
 153:	0f b6 00             	movzbl (%eax),%eax
 156:	84 c0                	test   %al,%al
 158:	75 e2                	jne    13c <strcpy+0xd>
    ;
  return os;
 15a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 15d:	c9                   	leave  
 15e:	c3                   	ret    

0000015f <strcmp>:

int
strcmp(const char *p, const char *q)
{
 15f:	55                   	push   %ebp
 160:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 162:	eb 08                	jmp    16c <strcmp+0xd>
    p++, q++;
 164:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 168:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 16c:	8b 45 08             	mov    0x8(%ebp),%eax
 16f:	0f b6 00             	movzbl (%eax),%eax
 172:	84 c0                	test   %al,%al
 174:	74 10                	je     186 <strcmp+0x27>
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	0f b6 10             	movzbl (%eax),%edx
 17c:	8b 45 0c             	mov    0xc(%ebp),%eax
 17f:	0f b6 00             	movzbl (%eax),%eax
 182:	38 c2                	cmp    %al,%dl
 184:	74 de                	je     164 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 186:	8b 45 08             	mov    0x8(%ebp),%eax
 189:	0f b6 00             	movzbl (%eax),%eax
 18c:	0f b6 d0             	movzbl %al,%edx
 18f:	8b 45 0c             	mov    0xc(%ebp),%eax
 192:	0f b6 00             	movzbl (%eax),%eax
 195:	0f b6 c0             	movzbl %al,%eax
 198:	29 c2                	sub    %eax,%edx
 19a:	89 d0                	mov    %edx,%eax
}
 19c:	5d                   	pop    %ebp
 19d:	c3                   	ret    

0000019e <strlen>:

uint
strlen(char *s)
{
 19e:	55                   	push   %ebp
 19f:	89 e5                	mov    %esp,%ebp
 1a1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1a4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1ab:	eb 04                	jmp    1b1 <strlen+0x13>
 1ad:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1b4:	8b 45 08             	mov    0x8(%ebp),%eax
 1b7:	01 d0                	add    %edx,%eax
 1b9:	0f b6 00             	movzbl (%eax),%eax
 1bc:	84 c0                	test   %al,%al
 1be:	75 ed                	jne    1ad <strlen+0xf>
    ;
  return n;
 1c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1c3:	c9                   	leave  
 1c4:	c3                   	ret    

000001c5 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c5:	55                   	push   %ebp
 1c6:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1c8:	8b 45 10             	mov    0x10(%ebp),%eax
 1cb:	50                   	push   %eax
 1cc:	ff 75 0c             	pushl  0xc(%ebp)
 1cf:	ff 75 08             	pushl  0x8(%ebp)
 1d2:	e8 32 ff ff ff       	call   109 <stosb>
 1d7:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1da:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1dd:	c9                   	leave  
 1de:	c3                   	ret    

000001df <strchr>:

char*
strchr(const char *s, char c)
{
 1df:	55                   	push   %ebp
 1e0:	89 e5                	mov    %esp,%ebp
 1e2:	83 ec 04             	sub    $0x4,%esp
 1e5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1eb:	eb 14                	jmp    201 <strchr+0x22>
    if(*s == c)
 1ed:	8b 45 08             	mov    0x8(%ebp),%eax
 1f0:	0f b6 00             	movzbl (%eax),%eax
 1f3:	38 45 fc             	cmp    %al,-0x4(%ebp)
 1f6:	75 05                	jne    1fd <strchr+0x1e>
      return (char*)s;
 1f8:	8b 45 08             	mov    0x8(%ebp),%eax
 1fb:	eb 13                	jmp    210 <strchr+0x31>
  for(; *s; s++)
 1fd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 201:	8b 45 08             	mov    0x8(%ebp),%eax
 204:	0f b6 00             	movzbl (%eax),%eax
 207:	84 c0                	test   %al,%al
 209:	75 e2                	jne    1ed <strchr+0xe>
  return 0;
 20b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 210:	c9                   	leave  
 211:	c3                   	ret    

00000212 <gets>:

char*
gets(char *buf, int max)
{
 212:	55                   	push   %ebp
 213:	89 e5                	mov    %esp,%ebp
 215:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 218:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 21f:	eb 42                	jmp    263 <gets+0x51>
    cc = read(0, &c, 1);
 221:	83 ec 04             	sub    $0x4,%esp
 224:	6a 01                	push   $0x1
 226:	8d 45 ef             	lea    -0x11(%ebp),%eax
 229:	50                   	push   %eax
 22a:	6a 00                	push   $0x0
 22c:	e8 47 01 00 00       	call   378 <read>
 231:	83 c4 10             	add    $0x10,%esp
 234:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 237:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 23b:	7e 33                	jle    270 <gets+0x5e>
      break;
    buf[i++] = c;
 23d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 240:	8d 50 01             	lea    0x1(%eax),%edx
 243:	89 55 f4             	mov    %edx,-0xc(%ebp)
 246:	89 c2                	mov    %eax,%edx
 248:	8b 45 08             	mov    0x8(%ebp),%eax
 24b:	01 c2                	add    %eax,%edx
 24d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 251:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 253:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 257:	3c 0a                	cmp    $0xa,%al
 259:	74 16                	je     271 <gets+0x5f>
 25b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25f:	3c 0d                	cmp    $0xd,%al
 261:	74 0e                	je     271 <gets+0x5f>
  for(i=0; i+1 < max; ){
 263:	8b 45 f4             	mov    -0xc(%ebp),%eax
 266:	83 c0 01             	add    $0x1,%eax
 269:	39 45 0c             	cmp    %eax,0xc(%ebp)
 26c:	7f b3                	jg     221 <gets+0xf>
 26e:	eb 01                	jmp    271 <gets+0x5f>
      break;
 270:	90                   	nop
      break;
  }
  buf[i] = '\0';
 271:	8b 55 f4             	mov    -0xc(%ebp),%edx
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	01 d0                	add    %edx,%eax
 279:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 27c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27f:	c9                   	leave  
 280:	c3                   	ret    

00000281 <stat>:

int
stat(char *n, struct stat *st)
{
 281:	55                   	push   %ebp
 282:	89 e5                	mov    %esp,%ebp
 284:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 287:	83 ec 08             	sub    $0x8,%esp
 28a:	6a 00                	push   $0x0
 28c:	ff 75 08             	pushl  0x8(%ebp)
 28f:	e8 0c 01 00 00       	call   3a0 <open>
 294:	83 c4 10             	add    $0x10,%esp
 297:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 29a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 29e:	79 07                	jns    2a7 <stat+0x26>
    return -1;
 2a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2a5:	eb 25                	jmp    2cc <stat+0x4b>
  r = fstat(fd, st);
 2a7:	83 ec 08             	sub    $0x8,%esp
 2aa:	ff 75 0c             	pushl  0xc(%ebp)
 2ad:	ff 75 f4             	pushl  -0xc(%ebp)
 2b0:	e8 03 01 00 00       	call   3b8 <fstat>
 2b5:	83 c4 10             	add    $0x10,%esp
 2b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2bb:	83 ec 0c             	sub    $0xc,%esp
 2be:	ff 75 f4             	pushl  -0xc(%ebp)
 2c1:	e8 c2 00 00 00       	call   388 <close>
 2c6:	83 c4 10             	add    $0x10,%esp
  return r;
 2c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2cc:	c9                   	leave  
 2cd:	c3                   	ret    

000002ce <atoi>:

int
atoi(const char *s)
{
 2ce:	55                   	push   %ebp
 2cf:	89 e5                	mov    %esp,%ebp
 2d1:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2d4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2db:	eb 25                	jmp    302 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2dd:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2e0:	89 d0                	mov    %edx,%eax
 2e2:	c1 e0 02             	shl    $0x2,%eax
 2e5:	01 d0                	add    %edx,%eax
 2e7:	01 c0                	add    %eax,%eax
 2e9:	89 c1                	mov    %eax,%ecx
 2eb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ee:	8d 50 01             	lea    0x1(%eax),%edx
 2f1:	89 55 08             	mov    %edx,0x8(%ebp)
 2f4:	0f b6 00             	movzbl (%eax),%eax
 2f7:	0f be c0             	movsbl %al,%eax
 2fa:	01 c8                	add    %ecx,%eax
 2fc:	83 e8 30             	sub    $0x30,%eax
 2ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 302:	8b 45 08             	mov    0x8(%ebp),%eax
 305:	0f b6 00             	movzbl (%eax),%eax
 308:	3c 2f                	cmp    $0x2f,%al
 30a:	7e 0a                	jle    316 <atoi+0x48>
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
 30f:	0f b6 00             	movzbl (%eax),%eax
 312:	3c 39                	cmp    $0x39,%al
 314:	7e c7                	jle    2dd <atoi+0xf>
  return n;
 316:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 319:	c9                   	leave  
 31a:	c3                   	ret    

0000031b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 31b:	55                   	push   %ebp
 31c:	89 e5                	mov    %esp,%ebp
 31e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 321:	8b 45 08             	mov    0x8(%ebp),%eax
 324:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 327:	8b 45 0c             	mov    0xc(%ebp),%eax
 32a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 32d:	eb 17                	jmp    346 <memmove+0x2b>
    *dst++ = *src++;
 32f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 332:	8d 42 01             	lea    0x1(%edx),%eax
 335:	89 45 f8             	mov    %eax,-0x8(%ebp)
 338:	8b 45 fc             	mov    -0x4(%ebp),%eax
 33b:	8d 48 01             	lea    0x1(%eax),%ecx
 33e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 341:	0f b6 12             	movzbl (%edx),%edx
 344:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 346:	8b 45 10             	mov    0x10(%ebp),%eax
 349:	8d 50 ff             	lea    -0x1(%eax),%edx
 34c:	89 55 10             	mov    %edx,0x10(%ebp)
 34f:	85 c0                	test   %eax,%eax
 351:	7f dc                	jg     32f <memmove+0x14>
  return vdst;
 353:	8b 45 08             	mov    0x8(%ebp),%eax
}
 356:	c9                   	leave  
 357:	c3                   	ret    

00000358 <fork>:
 358:	b8 01 00 00 00       	mov    $0x1,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <exit>:
 360:	b8 02 00 00 00       	mov    $0x2,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <wait>:
 368:	b8 03 00 00 00       	mov    $0x3,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <pipe>:
 370:	b8 04 00 00 00       	mov    $0x4,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <read>:
 378:	b8 05 00 00 00       	mov    $0x5,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <write>:
 380:	b8 10 00 00 00       	mov    $0x10,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <close>:
 388:	b8 15 00 00 00       	mov    $0x15,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <kill>:
 390:	b8 06 00 00 00       	mov    $0x6,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <exec>:
 398:	b8 07 00 00 00       	mov    $0x7,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <open>:
 3a0:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <mknod>:
 3a8:	b8 11 00 00 00       	mov    $0x11,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <unlink>:
 3b0:	b8 12 00 00 00       	mov    $0x12,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <fstat>:
 3b8:	b8 08 00 00 00       	mov    $0x8,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <link>:
 3c0:	b8 13 00 00 00       	mov    $0x13,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <mkdir>:
 3c8:	b8 14 00 00 00       	mov    $0x14,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <chdir>:
 3d0:	b8 09 00 00 00       	mov    $0x9,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <dup>:
 3d8:	b8 0a 00 00 00       	mov    $0xa,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <getpid>:
 3e0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <sbrk>:
 3e8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <sleep>:
 3f0:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <uptime>:
 3f8:	b8 0e 00 00 00       	mov    $0xe,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	83 ec 18             	sub    $0x18,%esp
 406:	8b 45 0c             	mov    0xc(%ebp),%eax
 409:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 40c:	83 ec 04             	sub    $0x4,%esp
 40f:	6a 01                	push   $0x1
 411:	8d 45 f4             	lea    -0xc(%ebp),%eax
 414:	50                   	push   %eax
 415:	ff 75 08             	pushl  0x8(%ebp)
 418:	e8 63 ff ff ff       	call   380 <write>
 41d:	83 c4 10             	add    $0x10,%esp
}
 420:	90                   	nop
 421:	c9                   	leave  
 422:	c3                   	ret    

00000423 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 423:	55                   	push   %ebp
 424:	89 e5                	mov    %esp,%ebp
 426:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 429:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 430:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 434:	74 17                	je     44d <printint+0x2a>
 436:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 43a:	79 11                	jns    44d <printint+0x2a>
    neg = 1;
 43c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 443:	8b 45 0c             	mov    0xc(%ebp),%eax
 446:	f7 d8                	neg    %eax
 448:	89 45 ec             	mov    %eax,-0x14(%ebp)
 44b:	eb 06                	jmp    453 <printint+0x30>
  } else {
    x = xx;
 44d:	8b 45 0c             	mov    0xc(%ebp),%eax
 450:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 453:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 45a:	8b 4d 10             	mov    0x10(%ebp),%ecx
 45d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 460:	ba 00 00 00 00       	mov    $0x0,%edx
 465:	f7 f1                	div    %ecx
 467:	89 d1                	mov    %edx,%ecx
 469:	8b 45 f4             	mov    -0xc(%ebp),%eax
 46c:	8d 50 01             	lea    0x1(%eax),%edx
 46f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 472:	0f b6 91 2c 0b 00 00 	movzbl 0xb2c(%ecx),%edx
 479:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 47d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 480:	8b 45 ec             	mov    -0x14(%ebp),%eax
 483:	ba 00 00 00 00       	mov    $0x0,%edx
 488:	f7 f1                	div    %ecx
 48a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 48d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 491:	75 c7                	jne    45a <printint+0x37>
  if(neg)
 493:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 497:	74 2d                	je     4c6 <printint+0xa3>
    buf[i++] = '-';
 499:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49c:	8d 50 01             	lea    0x1(%eax),%edx
 49f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4a2:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4a7:	eb 1d                	jmp    4c6 <printint+0xa3>
    putc(fd, buf[i]);
 4a9:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4af:	01 d0                	add    %edx,%eax
 4b1:	0f b6 00             	movzbl (%eax),%eax
 4b4:	0f be c0             	movsbl %al,%eax
 4b7:	83 ec 08             	sub    $0x8,%esp
 4ba:	50                   	push   %eax
 4bb:	ff 75 08             	pushl  0x8(%ebp)
 4be:	e8 3d ff ff ff       	call   400 <putc>
 4c3:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 4c6:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ce:	79 d9                	jns    4a9 <printint+0x86>
}
 4d0:	90                   	nop
 4d1:	c9                   	leave  
 4d2:	c3                   	ret    

000004d3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4d3:	55                   	push   %ebp
 4d4:	89 e5                	mov    %esp,%ebp
 4d6:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4d9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4e0:	8d 45 0c             	lea    0xc(%ebp),%eax
 4e3:	83 c0 04             	add    $0x4,%eax
 4e6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4e9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4f0:	e9 59 01 00 00       	jmp    64e <printf+0x17b>
    c = fmt[i] & 0xff;
 4f5:	8b 55 0c             	mov    0xc(%ebp),%edx
 4f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4fb:	01 d0                	add    %edx,%eax
 4fd:	0f b6 00             	movzbl (%eax),%eax
 500:	0f be c0             	movsbl %al,%eax
 503:	25 ff 00 00 00       	and    $0xff,%eax
 508:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 50b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 50f:	75 2c                	jne    53d <printf+0x6a>
      if(c == '%'){
 511:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 515:	75 0c                	jne    523 <printf+0x50>
        state = '%';
 517:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 51e:	e9 27 01 00 00       	jmp    64a <printf+0x177>
      } else {
        putc(fd, c);
 523:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 526:	0f be c0             	movsbl %al,%eax
 529:	83 ec 08             	sub    $0x8,%esp
 52c:	50                   	push   %eax
 52d:	ff 75 08             	pushl  0x8(%ebp)
 530:	e8 cb fe ff ff       	call   400 <putc>
 535:	83 c4 10             	add    $0x10,%esp
 538:	e9 0d 01 00 00       	jmp    64a <printf+0x177>
      }
    } else if(state == '%'){
 53d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 541:	0f 85 03 01 00 00    	jne    64a <printf+0x177>
      if(c == 'd'){
 547:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 54b:	75 1e                	jne    56b <printf+0x98>
        printint(fd, *ap, 10, 1);
 54d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 550:	8b 00                	mov    (%eax),%eax
 552:	6a 01                	push   $0x1
 554:	6a 0a                	push   $0xa
 556:	50                   	push   %eax
 557:	ff 75 08             	pushl  0x8(%ebp)
 55a:	e8 c4 fe ff ff       	call   423 <printint>
 55f:	83 c4 10             	add    $0x10,%esp
        ap++;
 562:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 566:	e9 d8 00 00 00       	jmp    643 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 56b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 56f:	74 06                	je     577 <printf+0xa4>
 571:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 575:	75 1e                	jne    595 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 577:	8b 45 e8             	mov    -0x18(%ebp),%eax
 57a:	8b 00                	mov    (%eax),%eax
 57c:	6a 00                	push   $0x0
 57e:	6a 10                	push   $0x10
 580:	50                   	push   %eax
 581:	ff 75 08             	pushl  0x8(%ebp)
 584:	e8 9a fe ff ff       	call   423 <printint>
 589:	83 c4 10             	add    $0x10,%esp
        ap++;
 58c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 590:	e9 ae 00 00 00       	jmp    643 <printf+0x170>
      } else if(c == 's'){
 595:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 599:	75 43                	jne    5de <printf+0x10b>
        s = (char*)*ap;
 59b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 59e:	8b 00                	mov    (%eax),%eax
 5a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5a3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5ab:	75 25                	jne    5d2 <printf+0xff>
          s = "(null)";
 5ad:	c7 45 f4 d9 08 00 00 	movl   $0x8d9,-0xc(%ebp)
        while(*s != 0){
 5b4:	eb 1c                	jmp    5d2 <printf+0xff>
          putc(fd, *s);
 5b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b9:	0f b6 00             	movzbl (%eax),%eax
 5bc:	0f be c0             	movsbl %al,%eax
 5bf:	83 ec 08             	sub    $0x8,%esp
 5c2:	50                   	push   %eax
 5c3:	ff 75 08             	pushl  0x8(%ebp)
 5c6:	e8 35 fe ff ff       	call   400 <putc>
 5cb:	83 c4 10             	add    $0x10,%esp
          s++;
 5ce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d5:	0f b6 00             	movzbl (%eax),%eax
 5d8:	84 c0                	test   %al,%al
 5da:	75 da                	jne    5b6 <printf+0xe3>
 5dc:	eb 65                	jmp    643 <printf+0x170>
        }
      } else if(c == 'c'){
 5de:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5e2:	75 1d                	jne    601 <printf+0x12e>
        putc(fd, *ap);
 5e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e7:	8b 00                	mov    (%eax),%eax
 5e9:	0f be c0             	movsbl %al,%eax
 5ec:	83 ec 08             	sub    $0x8,%esp
 5ef:	50                   	push   %eax
 5f0:	ff 75 08             	pushl  0x8(%ebp)
 5f3:	e8 08 fe ff ff       	call   400 <putc>
 5f8:	83 c4 10             	add    $0x10,%esp
        ap++;
 5fb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ff:	eb 42                	jmp    643 <printf+0x170>
      } else if(c == '%'){
 601:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 605:	75 17                	jne    61e <printf+0x14b>
        putc(fd, c);
 607:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 60a:	0f be c0             	movsbl %al,%eax
 60d:	83 ec 08             	sub    $0x8,%esp
 610:	50                   	push   %eax
 611:	ff 75 08             	pushl  0x8(%ebp)
 614:	e8 e7 fd ff ff       	call   400 <putc>
 619:	83 c4 10             	add    $0x10,%esp
 61c:	eb 25                	jmp    643 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 61e:	83 ec 08             	sub    $0x8,%esp
 621:	6a 25                	push   $0x25
 623:	ff 75 08             	pushl  0x8(%ebp)
 626:	e8 d5 fd ff ff       	call   400 <putc>
 62b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 62e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 631:	0f be c0             	movsbl %al,%eax
 634:	83 ec 08             	sub    $0x8,%esp
 637:	50                   	push   %eax
 638:	ff 75 08             	pushl  0x8(%ebp)
 63b:	e8 c0 fd ff ff       	call   400 <putc>
 640:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 643:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 64a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 64e:	8b 55 0c             	mov    0xc(%ebp),%edx
 651:	8b 45 f0             	mov    -0x10(%ebp),%eax
 654:	01 d0                	add    %edx,%eax
 656:	0f b6 00             	movzbl (%eax),%eax
 659:	84 c0                	test   %al,%al
 65b:	0f 85 94 fe ff ff    	jne    4f5 <printf+0x22>
    }
  }
}
 661:	90                   	nop
 662:	c9                   	leave  
 663:	c3                   	ret    

00000664 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 664:	55                   	push   %ebp
 665:	89 e5                	mov    %esp,%ebp
 667:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 66a:	8b 45 08             	mov    0x8(%ebp),%eax
 66d:	83 e8 08             	sub    $0x8,%eax
 670:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 673:	a1 48 0b 00 00       	mov    0xb48,%eax
 678:	89 45 fc             	mov    %eax,-0x4(%ebp)
 67b:	eb 24                	jmp    6a1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 67d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 680:	8b 00                	mov    (%eax),%eax
 682:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 685:	72 12                	jb     699 <free+0x35>
 687:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 68d:	77 24                	ja     6b3 <free+0x4f>
 68f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 692:	8b 00                	mov    (%eax),%eax
 694:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 697:	72 1a                	jb     6b3 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	8b 00                	mov    (%eax),%eax
 69e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a7:	76 d4                	jbe    67d <free+0x19>
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	8b 00                	mov    (%eax),%eax
 6ae:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6b1:	73 ca                	jae    67d <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b6:	8b 40 04             	mov    0x4(%eax),%eax
 6b9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c3:	01 c2                	add    %eax,%edx
 6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c8:	8b 00                	mov    (%eax),%eax
 6ca:	39 c2                	cmp    %eax,%edx
 6cc:	75 24                	jne    6f2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d1:	8b 50 04             	mov    0x4(%eax),%edx
 6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	8b 40 04             	mov    0x4(%eax),%eax
 6dc:	01 c2                	add    %eax,%edx
 6de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e7:	8b 00                	mov    (%eax),%eax
 6e9:	8b 10                	mov    (%eax),%edx
 6eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ee:	89 10                	mov    %edx,(%eax)
 6f0:	eb 0a                	jmp    6fc <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f5:	8b 10                	mov    (%eax),%edx
 6f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fa:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ff:	8b 40 04             	mov    0x4(%eax),%eax
 702:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 709:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70c:	01 d0                	add    %edx,%eax
 70e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 711:	75 20                	jne    733 <free+0xcf>
    p->s.size += bp->s.size;
 713:	8b 45 fc             	mov    -0x4(%ebp),%eax
 716:	8b 50 04             	mov    0x4(%eax),%edx
 719:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71c:	8b 40 04             	mov    0x4(%eax),%eax
 71f:	01 c2                	add    %eax,%edx
 721:	8b 45 fc             	mov    -0x4(%ebp),%eax
 724:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 727:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72a:	8b 10                	mov    (%eax),%edx
 72c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72f:	89 10                	mov    %edx,(%eax)
 731:	eb 08                	jmp    73b <free+0xd7>
  } else
    p->s.ptr = bp;
 733:	8b 45 fc             	mov    -0x4(%ebp),%eax
 736:	8b 55 f8             	mov    -0x8(%ebp),%edx
 739:	89 10                	mov    %edx,(%eax)
  freep = p;
 73b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73e:	a3 48 0b 00 00       	mov    %eax,0xb48
}
 743:	90                   	nop
 744:	c9                   	leave  
 745:	c3                   	ret    

00000746 <morecore>:

static Header*
morecore(uint nu)
{
 746:	55                   	push   %ebp
 747:	89 e5                	mov    %esp,%ebp
 749:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 74c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 753:	77 07                	ja     75c <morecore+0x16>
    nu = 4096;
 755:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 75c:	8b 45 08             	mov    0x8(%ebp),%eax
 75f:	c1 e0 03             	shl    $0x3,%eax
 762:	83 ec 0c             	sub    $0xc,%esp
 765:	50                   	push   %eax
 766:	e8 7d fc ff ff       	call   3e8 <sbrk>
 76b:	83 c4 10             	add    $0x10,%esp
 76e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 771:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 775:	75 07                	jne    77e <morecore+0x38>
    return 0;
 777:	b8 00 00 00 00       	mov    $0x0,%eax
 77c:	eb 26                	jmp    7a4 <morecore+0x5e>
  hp = (Header*)p;
 77e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 781:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 784:	8b 45 f0             	mov    -0x10(%ebp),%eax
 787:	8b 55 08             	mov    0x8(%ebp),%edx
 78a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 78d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 790:	83 c0 08             	add    $0x8,%eax
 793:	83 ec 0c             	sub    $0xc,%esp
 796:	50                   	push   %eax
 797:	e8 c8 fe ff ff       	call   664 <free>
 79c:	83 c4 10             	add    $0x10,%esp
  return freep;
 79f:	a1 48 0b 00 00       	mov    0xb48,%eax
}
 7a4:	c9                   	leave  
 7a5:	c3                   	ret    

000007a6 <malloc>:

void*
malloc(uint nbytes)
{
 7a6:	55                   	push   %ebp
 7a7:	89 e5                	mov    %esp,%ebp
 7a9:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ac:	8b 45 08             	mov    0x8(%ebp),%eax
 7af:	83 c0 07             	add    $0x7,%eax
 7b2:	c1 e8 03             	shr    $0x3,%eax
 7b5:	83 c0 01             	add    $0x1,%eax
 7b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7bb:	a1 48 0b 00 00       	mov    0xb48,%eax
 7c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7c7:	75 23                	jne    7ec <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7c9:	c7 45 f0 40 0b 00 00 	movl   $0xb40,-0x10(%ebp)
 7d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d3:	a3 48 0b 00 00       	mov    %eax,0xb48
 7d8:	a1 48 0b 00 00       	mov    0xb48,%eax
 7dd:	a3 40 0b 00 00       	mov    %eax,0xb40
    base.s.size = 0;
 7e2:	c7 05 44 0b 00 00 00 	movl   $0x0,0xb44
 7e9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ef:	8b 00                	mov    (%eax),%eax
 7f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f7:	8b 40 04             	mov    0x4(%eax),%eax
 7fa:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7fd:	77 4d                	ja     84c <malloc+0xa6>
      if(p->s.size == nunits)
 7ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 802:	8b 40 04             	mov    0x4(%eax),%eax
 805:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 808:	75 0c                	jne    816 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 80a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80d:	8b 10                	mov    (%eax),%edx
 80f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 812:	89 10                	mov    %edx,(%eax)
 814:	eb 26                	jmp    83c <malloc+0x96>
      else {
        p->s.size -= nunits;
 816:	8b 45 f4             	mov    -0xc(%ebp),%eax
 819:	8b 40 04             	mov    0x4(%eax),%eax
 81c:	2b 45 ec             	sub    -0x14(%ebp),%eax
 81f:	89 c2                	mov    %eax,%edx
 821:	8b 45 f4             	mov    -0xc(%ebp),%eax
 824:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 827:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82a:	8b 40 04             	mov    0x4(%eax),%eax
 82d:	c1 e0 03             	shl    $0x3,%eax
 830:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 833:	8b 45 f4             	mov    -0xc(%ebp),%eax
 836:	8b 55 ec             	mov    -0x14(%ebp),%edx
 839:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 83c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83f:	a3 48 0b 00 00       	mov    %eax,0xb48
      return (void*)(p + 1);
 844:	8b 45 f4             	mov    -0xc(%ebp),%eax
 847:	83 c0 08             	add    $0x8,%eax
 84a:	eb 3b                	jmp    887 <malloc+0xe1>
    }
    if(p == freep)
 84c:	a1 48 0b 00 00       	mov    0xb48,%eax
 851:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 854:	75 1e                	jne    874 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 856:	83 ec 0c             	sub    $0xc,%esp
 859:	ff 75 ec             	pushl  -0x14(%ebp)
 85c:	e8 e5 fe ff ff       	call   746 <morecore>
 861:	83 c4 10             	add    $0x10,%esp
 864:	89 45 f4             	mov    %eax,-0xc(%ebp)
 867:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 86b:	75 07                	jne    874 <malloc+0xce>
        return 0;
 86d:	b8 00 00 00 00       	mov    $0x0,%eax
 872:	eb 13                	jmp    887 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 874:	8b 45 f4             	mov    -0xc(%ebp),%eax
 877:	89 45 f0             	mov    %eax,-0x10(%ebp)
 87a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87d:	8b 00                	mov    (%eax),%eax
 87f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 882:	e9 6d ff ff ff       	jmp    7f4 <malloc+0x4e>
  }
}
 887:	c9                   	leave  
 888:	c3                   	ret    
