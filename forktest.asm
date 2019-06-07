
_forktest:     formato de ficheiro elf32-i386


Desmontagem da secção .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 08             	sub    $0x8,%esp
  write(fd, s, strlen(s));
   6:	83 ec 0c             	sub    $0xc,%esp
   9:	ff 75 0c             	pushl  0xc(%ebp)
   c:	e8 94 01 00 00       	call   1a5 <strlen>
  11:	83 c4 10             	add    $0x10,%esp
  14:	83 ec 04             	sub    $0x4,%esp
  17:	50                   	push   %eax
  18:	ff 75 0c             	pushl  0xc(%ebp)
  1b:	ff 75 08             	pushl  0x8(%ebp)
  1e:	e8 64 03 00 00       	call   387 <write>
  23:	83 c4 10             	add    $0x10,%esp
}
  26:	90                   	nop
  27:	c9                   	leave  
  28:	c3                   	ret    

00000029 <forktest>:

void
forktest(void)
{
  29:	55                   	push   %ebp
  2a:	89 e5                	mov    %esp,%ebp
  2c:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
  2f:	83 ec 08             	sub    $0x8,%esp
  32:	68 08 04 00 00       	push   $0x408
  37:	6a 01                	push   $0x1
  39:	e8 c2 ff ff ff       	call   0 <printf>
  3e:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  48:	eb 25                	jmp    6f <forktest+0x46>
    pid = fork(0);
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	6a 00                	push   $0x0
  4f:	e8 0b 03 00 00       	call   35f <fork>
  54:	83 c4 10             	add    $0x10,%esp
  57:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
  5a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  5e:	78 1a                	js     7a <forktest+0x51>
      break;
    if(pid == 0)
  60:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  64:	75 05                	jne    6b <forktest+0x42>
      exit();
  66:	e8 fc 02 00 00       	call   367 <exit>
  for(n=0; n<N; n++){
  6b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  6f:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
  76:	7e d2                	jle    4a <forktest+0x21>
  78:	eb 01                	jmp    7b <forktest+0x52>
      break;
  7a:	90                   	nop
  }
  
  if(n == N){
  7b:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
  82:	75 40                	jne    c4 <forktest+0x9b>
    printf(1, "fork claimed to work N times!\n", N);
  84:	83 ec 04             	sub    $0x4,%esp
  87:	68 e8 03 00 00       	push   $0x3e8
  8c:	68 14 04 00 00       	push   $0x414
  91:	6a 01                	push   $0x1
  93:	e8 68 ff ff ff       	call   0 <printf>
  98:	83 c4 10             	add    $0x10,%esp
    exit();
  9b:	e8 c7 02 00 00       	call   367 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
  a0:	e8 ca 02 00 00       	call   36f <wait>
  a5:	85 c0                	test   %eax,%eax
  a7:	79 17                	jns    c0 <forktest+0x97>
      printf(1, "wait stopped early\n");
  a9:	83 ec 08             	sub    $0x8,%esp
  ac:	68 33 04 00 00       	push   $0x433
  b1:	6a 01                	push   $0x1
  b3:	e8 48 ff ff ff       	call   0 <printf>
  b8:	83 c4 10             	add    $0x10,%esp
      exit();
  bb:	e8 a7 02 00 00       	call   367 <exit>
  for(; n > 0; n--){
  c0:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  c8:	7f d6                	jg     a0 <forktest+0x77>
    }
  }
  
  if(wait() != -1){
  ca:	e8 a0 02 00 00       	call   36f <wait>
  cf:	83 f8 ff             	cmp    $0xffffffff,%eax
  d2:	74 17                	je     eb <forktest+0xc2>
    printf(1, "wait got too many\n");
  d4:	83 ec 08             	sub    $0x8,%esp
  d7:	68 47 04 00 00       	push   $0x447
  dc:	6a 01                	push   $0x1
  de:	e8 1d ff ff ff       	call   0 <printf>
  e3:	83 c4 10             	add    $0x10,%esp
    exit();
  e6:	e8 7c 02 00 00       	call   367 <exit>
  }
  
  printf(1, "fork test OK\n");
  eb:	83 ec 08             	sub    $0x8,%esp
  ee:	68 5a 04 00 00       	push   $0x45a
  f3:	6a 01                	push   $0x1
  f5:	e8 06 ff ff ff       	call   0 <printf>
  fa:	83 c4 10             	add    $0x10,%esp
}
  fd:	90                   	nop
  fe:	c9                   	leave  
  ff:	c3                   	ret    

00000100 <main>:

int
main(void)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	83 e4 f0             	and    $0xfffffff0,%esp
  forktest();
 106:	e8 1e ff ff ff       	call   29 <forktest>
  exit();
 10b:	e8 57 02 00 00       	call   367 <exit>

00000110 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 115:	8b 4d 08             	mov    0x8(%ebp),%ecx
 118:	8b 55 10             	mov    0x10(%ebp),%edx
 11b:	8b 45 0c             	mov    0xc(%ebp),%eax
 11e:	89 cb                	mov    %ecx,%ebx
 120:	89 df                	mov    %ebx,%edi
 122:	89 d1                	mov    %edx,%ecx
 124:	fc                   	cld    
 125:	f3 aa                	rep stos %al,%es:(%edi)
 127:	89 ca                	mov    %ecx,%edx
 129:	89 fb                	mov    %edi,%ebx
 12b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 12e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 131:	90                   	nop
 132:	5b                   	pop    %ebx
 133:	5f                   	pop    %edi
 134:	5d                   	pop    %ebp
 135:	c3                   	ret    

00000136 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 136:	55                   	push   %ebp
 137:	89 e5                	mov    %esp,%ebp
 139:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13c:	8b 45 08             	mov    0x8(%ebp),%eax
 13f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 142:	90                   	nop
 143:	8b 55 0c             	mov    0xc(%ebp),%edx
 146:	8d 42 01             	lea    0x1(%edx),%eax
 149:	89 45 0c             	mov    %eax,0xc(%ebp)
 14c:	8b 45 08             	mov    0x8(%ebp),%eax
 14f:	8d 48 01             	lea    0x1(%eax),%ecx
 152:	89 4d 08             	mov    %ecx,0x8(%ebp)
 155:	0f b6 12             	movzbl (%edx),%edx
 158:	88 10                	mov    %dl,(%eax)
 15a:	0f b6 00             	movzbl (%eax),%eax
 15d:	84 c0                	test   %al,%al
 15f:	75 e2                	jne    143 <strcpy+0xd>
    ;
  return os;
 161:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 164:	c9                   	leave  
 165:	c3                   	ret    

00000166 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 166:	55                   	push   %ebp
 167:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 169:	eb 08                	jmp    173 <strcmp+0xd>
    p++, q++;
 16b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	0f b6 00             	movzbl (%eax),%eax
 179:	84 c0                	test   %al,%al
 17b:	74 10                	je     18d <strcmp+0x27>
 17d:	8b 45 08             	mov    0x8(%ebp),%eax
 180:	0f b6 10             	movzbl (%eax),%edx
 183:	8b 45 0c             	mov    0xc(%ebp),%eax
 186:	0f b6 00             	movzbl (%eax),%eax
 189:	38 c2                	cmp    %al,%dl
 18b:	74 de                	je     16b <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 18d:	8b 45 08             	mov    0x8(%ebp),%eax
 190:	0f b6 00             	movzbl (%eax),%eax
 193:	0f b6 d0             	movzbl %al,%edx
 196:	8b 45 0c             	mov    0xc(%ebp),%eax
 199:	0f b6 00             	movzbl (%eax),%eax
 19c:	0f b6 c0             	movzbl %al,%eax
 19f:	29 c2                	sub    %eax,%edx
 1a1:	89 d0                	mov    %edx,%eax
}
 1a3:	5d                   	pop    %ebp
 1a4:	c3                   	ret    

000001a5 <strlen>:

uint
strlen(char *s)
{
 1a5:	55                   	push   %ebp
 1a6:	89 e5                	mov    %esp,%ebp
 1a8:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1ab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b2:	eb 04                	jmp    1b8 <strlen+0x13>
 1b4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1bb:	8b 45 08             	mov    0x8(%ebp),%eax
 1be:	01 d0                	add    %edx,%eax
 1c0:	0f b6 00             	movzbl (%eax),%eax
 1c3:	84 c0                	test   %al,%al
 1c5:	75 ed                	jne    1b4 <strlen+0xf>
    ;
  return n;
 1c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1ca:	c9                   	leave  
 1cb:	c3                   	ret    

000001cc <memset>:

void*
memset(void *dst, int c, uint n)
{
 1cc:	55                   	push   %ebp
 1cd:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1cf:	8b 45 10             	mov    0x10(%ebp),%eax
 1d2:	50                   	push   %eax
 1d3:	ff 75 0c             	pushl  0xc(%ebp)
 1d6:	ff 75 08             	pushl  0x8(%ebp)
 1d9:	e8 32 ff ff ff       	call   110 <stosb>
 1de:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e4:	c9                   	leave  
 1e5:	c3                   	ret    

000001e6 <strchr>:

char*
strchr(const char *s, char c)
{
 1e6:	55                   	push   %ebp
 1e7:	89 e5                	mov    %esp,%ebp
 1e9:	83 ec 04             	sub    $0x4,%esp
 1ec:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ef:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1f2:	eb 14                	jmp    208 <strchr+0x22>
    if(*s == c)
 1f4:	8b 45 08             	mov    0x8(%ebp),%eax
 1f7:	0f b6 00             	movzbl (%eax),%eax
 1fa:	38 45 fc             	cmp    %al,-0x4(%ebp)
 1fd:	75 05                	jne    204 <strchr+0x1e>
      return (char*)s;
 1ff:	8b 45 08             	mov    0x8(%ebp),%eax
 202:	eb 13                	jmp    217 <strchr+0x31>
  for(; *s; s++)
 204:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 208:	8b 45 08             	mov    0x8(%ebp),%eax
 20b:	0f b6 00             	movzbl (%eax),%eax
 20e:	84 c0                	test   %al,%al
 210:	75 e2                	jne    1f4 <strchr+0xe>
  return 0;
 212:	b8 00 00 00 00       	mov    $0x0,%eax
}
 217:	c9                   	leave  
 218:	c3                   	ret    

00000219 <gets>:

char*
gets(char *buf, int max)
{
 219:	55                   	push   %ebp
 21a:	89 e5                	mov    %esp,%ebp
 21c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 226:	eb 42                	jmp    26a <gets+0x51>
    cc = read(0, &c, 1);
 228:	83 ec 04             	sub    $0x4,%esp
 22b:	6a 01                	push   $0x1
 22d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 230:	50                   	push   %eax
 231:	6a 00                	push   $0x0
 233:	e8 47 01 00 00       	call   37f <read>
 238:	83 c4 10             	add    $0x10,%esp
 23b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 23e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 242:	7e 33                	jle    277 <gets+0x5e>
      break;
    buf[i++] = c;
 244:	8b 45 f4             	mov    -0xc(%ebp),%eax
 247:	8d 50 01             	lea    0x1(%eax),%edx
 24a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 24d:	89 c2                	mov    %eax,%edx
 24f:	8b 45 08             	mov    0x8(%ebp),%eax
 252:	01 c2                	add    %eax,%edx
 254:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 258:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 25a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25e:	3c 0a                	cmp    $0xa,%al
 260:	74 16                	je     278 <gets+0x5f>
 262:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 266:	3c 0d                	cmp    $0xd,%al
 268:	74 0e                	je     278 <gets+0x5f>
  for(i=0; i+1 < max; ){
 26a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 26d:	83 c0 01             	add    $0x1,%eax
 270:	39 45 0c             	cmp    %eax,0xc(%ebp)
 273:	7f b3                	jg     228 <gets+0xf>
 275:	eb 01                	jmp    278 <gets+0x5f>
      break;
 277:	90                   	nop
      break;
  }
  buf[i] = '\0';
 278:	8b 55 f4             	mov    -0xc(%ebp),%edx
 27b:	8b 45 08             	mov    0x8(%ebp),%eax
 27e:	01 d0                	add    %edx,%eax
 280:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 283:	8b 45 08             	mov    0x8(%ebp),%eax
}
 286:	c9                   	leave  
 287:	c3                   	ret    

00000288 <stat>:

int
stat(char *n, struct stat *st)
{
 288:	55                   	push   %ebp
 289:	89 e5                	mov    %esp,%ebp
 28b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 28e:	83 ec 08             	sub    $0x8,%esp
 291:	6a 00                	push   $0x0
 293:	ff 75 08             	pushl  0x8(%ebp)
 296:	e8 0c 01 00 00       	call   3a7 <open>
 29b:	83 c4 10             	add    $0x10,%esp
 29e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2a5:	79 07                	jns    2ae <stat+0x26>
    return -1;
 2a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ac:	eb 25                	jmp    2d3 <stat+0x4b>
  r = fstat(fd, st);
 2ae:	83 ec 08             	sub    $0x8,%esp
 2b1:	ff 75 0c             	pushl  0xc(%ebp)
 2b4:	ff 75 f4             	pushl  -0xc(%ebp)
 2b7:	e8 03 01 00 00       	call   3bf <fstat>
 2bc:	83 c4 10             	add    $0x10,%esp
 2bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2c2:	83 ec 0c             	sub    $0xc,%esp
 2c5:	ff 75 f4             	pushl  -0xc(%ebp)
 2c8:	e8 c2 00 00 00       	call   38f <close>
 2cd:	83 c4 10             	add    $0x10,%esp
  return r;
 2d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2d3:	c9                   	leave  
 2d4:	c3                   	ret    

000002d5 <atoi>:

int
atoi(const char *s)
{
 2d5:	55                   	push   %ebp
 2d6:	89 e5                	mov    %esp,%ebp
 2d8:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2e2:	eb 25                	jmp    309 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2e4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2e7:	89 d0                	mov    %edx,%eax
 2e9:	c1 e0 02             	shl    $0x2,%eax
 2ec:	01 d0                	add    %edx,%eax
 2ee:	01 c0                	add    %eax,%eax
 2f0:	89 c1                	mov    %eax,%ecx
 2f2:	8b 45 08             	mov    0x8(%ebp),%eax
 2f5:	8d 50 01             	lea    0x1(%eax),%edx
 2f8:	89 55 08             	mov    %edx,0x8(%ebp)
 2fb:	0f b6 00             	movzbl (%eax),%eax
 2fe:	0f be c0             	movsbl %al,%eax
 301:	01 c8                	add    %ecx,%eax
 303:	83 e8 30             	sub    $0x30,%eax
 306:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 309:	8b 45 08             	mov    0x8(%ebp),%eax
 30c:	0f b6 00             	movzbl (%eax),%eax
 30f:	3c 2f                	cmp    $0x2f,%al
 311:	7e 0a                	jle    31d <atoi+0x48>
 313:	8b 45 08             	mov    0x8(%ebp),%eax
 316:	0f b6 00             	movzbl (%eax),%eax
 319:	3c 39                	cmp    $0x39,%al
 31b:	7e c7                	jle    2e4 <atoi+0xf>
  return n;
 31d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 320:	c9                   	leave  
 321:	c3                   	ret    

00000322 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 322:	55                   	push   %ebp
 323:	89 e5                	mov    %esp,%ebp
 325:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 328:	8b 45 08             	mov    0x8(%ebp),%eax
 32b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 32e:	8b 45 0c             	mov    0xc(%ebp),%eax
 331:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 334:	eb 17                	jmp    34d <memmove+0x2b>
    *dst++ = *src++;
 336:	8b 55 f8             	mov    -0x8(%ebp),%edx
 339:	8d 42 01             	lea    0x1(%edx),%eax
 33c:	89 45 f8             	mov    %eax,-0x8(%ebp)
 33f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 342:	8d 48 01             	lea    0x1(%eax),%ecx
 345:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 348:	0f b6 12             	movzbl (%edx),%edx
 34b:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 34d:	8b 45 10             	mov    0x10(%ebp),%eax
 350:	8d 50 ff             	lea    -0x1(%eax),%edx
 353:	89 55 10             	mov    %edx,0x10(%ebp)
 356:	85 c0                	test   %eax,%eax
 358:	7f dc                	jg     336 <memmove+0x14>
  return vdst;
 35a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 35d:	c9                   	leave  
 35e:	c3                   	ret    

0000035f <fork>:
 35f:	b8 01 00 00 00       	mov    $0x1,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <exit>:
 367:	b8 02 00 00 00       	mov    $0x2,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <wait>:
 36f:	b8 03 00 00 00       	mov    $0x3,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <pipe>:
 377:	b8 04 00 00 00       	mov    $0x4,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <read>:
 37f:	b8 05 00 00 00       	mov    $0x5,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <write>:
 387:	b8 10 00 00 00       	mov    $0x10,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <close>:
 38f:	b8 15 00 00 00       	mov    $0x15,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <kill>:
 397:	b8 06 00 00 00       	mov    $0x6,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <exec>:
 39f:	b8 07 00 00 00       	mov    $0x7,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <open>:
 3a7:	b8 0f 00 00 00       	mov    $0xf,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <mknod>:
 3af:	b8 11 00 00 00       	mov    $0x11,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <unlink>:
 3b7:	b8 12 00 00 00       	mov    $0x12,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <fstat>:
 3bf:	b8 08 00 00 00       	mov    $0x8,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <link>:
 3c7:	b8 13 00 00 00       	mov    $0x13,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <mkdir>:
 3cf:	b8 14 00 00 00       	mov    $0x14,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <chdir>:
 3d7:	b8 09 00 00 00       	mov    $0x9,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret    

000003df <dup>:
 3df:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret    

000003e7 <getpid>:
 3e7:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret    

000003ef <sbrk>:
 3ef:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret    

000003f7 <sleep>:
 3f7:	b8 0d 00 00 00       	mov    $0xd,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret    

000003ff <uptime>:
 3ff:	b8 0e 00 00 00       	mov    $0xe,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret    
