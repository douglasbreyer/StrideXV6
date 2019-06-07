
_stressfs:     formato de ficheiro elf32-i386


Desmontagem da secção .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i;
  char path[] = "stressfs0";
  14:	c7 45 e6 73 74 72 65 	movl   $0x65727473,-0x1a(%ebp)
  1b:	c7 45 ea 73 73 66 73 	movl   $0x73667373,-0x16(%ebp)
  22:	66 c7 45 ee 30 00    	movw   $0x30,-0x12(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	68 da 08 00 00       	push   $0x8da
  30:	6a 01                	push   $0x1
  32:	e8 ed 04 00 00       	call   524 <printf>
  37:	83 c4 10             	add    $0x10,%esp
  memset(data, 'a', sizeof(data));
  3a:	83 ec 04             	sub    $0x4,%esp
  3d:	68 00 02 00 00       	push   $0x200
  42:	6a 61                	push   $0x61
  44:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  4a:	50                   	push   %eax
  4b:	e8 c6 01 00 00       	call   216 <memset>
  50:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  5a:	eb 15                	jmp    71 <main+0x71>
    if(fork(0) > 0)
  5c:	83 ec 0c             	sub    $0xc,%esp
  5f:	6a 00                	push   $0x0
  61:	e8 43 03 00 00       	call   3a9 <fork>
  66:	83 c4 10             	add    $0x10,%esp
  69:	85 c0                	test   %eax,%eax
  6b:	7f 0c                	jg     79 <main+0x79>
  for(i = 0; i < 4; i++)
  6d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  71:	83 7d f4 03          	cmpl   $0x3,-0xc(%ebp)
  75:	7e e5                	jle    5c <main+0x5c>
  77:	eb 01                	jmp    7a <main+0x7a>
      break;
  79:	90                   	nop

  printf(1, "write %d\n", i);
  7a:	83 ec 04             	sub    $0x4,%esp
  7d:	ff 75 f4             	pushl  -0xc(%ebp)
  80:	68 ed 08 00 00       	push   $0x8ed
  85:	6a 01                	push   $0x1
  87:	e8 98 04 00 00       	call   524 <printf>
  8c:	83 c4 10             	add    $0x10,%esp

  path[8] += i;
  8f:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
  93:	89 c2                	mov    %eax,%edx
  95:	8b 45 f4             	mov    -0xc(%ebp),%eax
  98:	01 d0                	add    %edx,%eax
  9a:	88 45 ee             	mov    %al,-0x12(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  9d:	83 ec 08             	sub    $0x8,%esp
  a0:	68 02 02 00 00       	push   $0x202
  a5:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  a8:	50                   	push   %eax
  a9:	e8 43 03 00 00       	call   3f1 <open>
  ae:	83 c4 10             	add    $0x10,%esp
  b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 20; i++)
  b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  bb:	eb 1e                	jmp    db <main+0xdb>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  bd:	83 ec 04             	sub    $0x4,%esp
  c0:	68 00 02 00 00       	push   $0x200
  c5:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  cb:	50                   	push   %eax
  cc:	ff 75 f0             	pushl  -0x10(%ebp)
  cf:	e8 fd 02 00 00       	call   3d1 <write>
  d4:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 20; i++)
  d7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  db:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  df:	7e dc                	jle    bd <main+0xbd>
  close(fd);
  e1:	83 ec 0c             	sub    $0xc,%esp
  e4:	ff 75 f0             	pushl  -0x10(%ebp)
  e7:	e8 ed 02 00 00       	call   3d9 <close>
  ec:	83 c4 10             	add    $0x10,%esp

  printf(1, "read\n");
  ef:	83 ec 08             	sub    $0x8,%esp
  f2:	68 f7 08 00 00       	push   $0x8f7
  f7:	6a 01                	push   $0x1
  f9:	e8 26 04 00 00       	call   524 <printf>
  fe:	83 c4 10             	add    $0x10,%esp

  fd = open(path, O_RDONLY);
 101:	83 ec 08             	sub    $0x8,%esp
 104:	6a 00                	push   $0x0
 106:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 109:	50                   	push   %eax
 10a:	e8 e2 02 00 00       	call   3f1 <open>
 10f:	83 c4 10             	add    $0x10,%esp
 112:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < 20; i++)
 115:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 11c:	eb 1e                	jmp    13c <main+0x13c>
    read(fd, data, sizeof(data));
 11e:	83 ec 04             	sub    $0x4,%esp
 121:	68 00 02 00 00       	push   $0x200
 126:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
 12c:	50                   	push   %eax
 12d:	ff 75 f0             	pushl  -0x10(%ebp)
 130:	e8 94 02 00 00       	call   3c9 <read>
 135:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < 20; i++)
 138:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 13c:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
 140:	7e dc                	jle    11e <main+0x11e>
  close(fd);
 142:	83 ec 0c             	sub    $0xc,%esp
 145:	ff 75 f0             	pushl  -0x10(%ebp)
 148:	e8 8c 02 00 00       	call   3d9 <close>
 14d:	83 c4 10             	add    $0x10,%esp

  wait();
 150:	e8 64 02 00 00       	call   3b9 <wait>
  
  exit();
 155:	e8 57 02 00 00       	call   3b1 <exit>

0000015a <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 15a:	55                   	push   %ebp
 15b:	89 e5                	mov    %esp,%ebp
 15d:	57                   	push   %edi
 15e:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 15f:	8b 4d 08             	mov    0x8(%ebp),%ecx
 162:	8b 55 10             	mov    0x10(%ebp),%edx
 165:	8b 45 0c             	mov    0xc(%ebp),%eax
 168:	89 cb                	mov    %ecx,%ebx
 16a:	89 df                	mov    %ebx,%edi
 16c:	89 d1                	mov    %edx,%ecx
 16e:	fc                   	cld    
 16f:	f3 aa                	rep stos %al,%es:(%edi)
 171:	89 ca                	mov    %ecx,%edx
 173:	89 fb                	mov    %edi,%ebx
 175:	89 5d 08             	mov    %ebx,0x8(%ebp)
 178:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 17b:	90                   	nop
 17c:	5b                   	pop    %ebx
 17d:	5f                   	pop    %edi
 17e:	5d                   	pop    %ebp
 17f:	c3                   	ret    

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 186:	8b 45 08             	mov    0x8(%ebp),%eax
 189:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 18c:	90                   	nop
 18d:	8b 55 0c             	mov    0xc(%ebp),%edx
 190:	8d 42 01             	lea    0x1(%edx),%eax
 193:	89 45 0c             	mov    %eax,0xc(%ebp)
 196:	8b 45 08             	mov    0x8(%ebp),%eax
 199:	8d 48 01             	lea    0x1(%eax),%ecx
 19c:	89 4d 08             	mov    %ecx,0x8(%ebp)
 19f:	0f b6 12             	movzbl (%edx),%edx
 1a2:	88 10                	mov    %dl,(%eax)
 1a4:	0f b6 00             	movzbl (%eax),%eax
 1a7:	84 c0                	test   %al,%al
 1a9:	75 e2                	jne    18d <strcpy+0xd>
    ;
  return os;
 1ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1ae:	c9                   	leave  
 1af:	c3                   	ret    

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1b3:	eb 08                	jmp    1bd <strcmp+0xd>
    p++, q++;
 1b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1b9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
 1c0:	0f b6 00             	movzbl (%eax),%eax
 1c3:	84 c0                	test   %al,%al
 1c5:	74 10                	je     1d7 <strcmp+0x27>
 1c7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ca:	0f b6 10             	movzbl (%eax),%edx
 1cd:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d0:	0f b6 00             	movzbl (%eax),%eax
 1d3:	38 c2                	cmp    %al,%dl
 1d5:	74 de                	je     1b5 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 1d7:	8b 45 08             	mov    0x8(%ebp),%eax
 1da:	0f b6 00             	movzbl (%eax),%eax
 1dd:	0f b6 d0             	movzbl %al,%edx
 1e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e3:	0f b6 00             	movzbl (%eax),%eax
 1e6:	0f b6 c0             	movzbl %al,%eax
 1e9:	29 c2                	sub    %eax,%edx
 1eb:	89 d0                	mov    %edx,%eax
}
 1ed:	5d                   	pop    %ebp
 1ee:	c3                   	ret    

000001ef <strlen>:

uint
strlen(char *s)
{
 1ef:	55                   	push   %ebp
 1f0:	89 e5                	mov    %esp,%ebp
 1f2:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1fc:	eb 04                	jmp    202 <strlen+0x13>
 1fe:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 202:	8b 55 fc             	mov    -0x4(%ebp),%edx
 205:	8b 45 08             	mov    0x8(%ebp),%eax
 208:	01 d0                	add    %edx,%eax
 20a:	0f b6 00             	movzbl (%eax),%eax
 20d:	84 c0                	test   %al,%al
 20f:	75 ed                	jne    1fe <strlen+0xf>
    ;
  return n;
 211:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 214:	c9                   	leave  
 215:	c3                   	ret    

00000216 <memset>:

void*
memset(void *dst, int c, uint n)
{
 216:	55                   	push   %ebp
 217:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 219:	8b 45 10             	mov    0x10(%ebp),%eax
 21c:	50                   	push   %eax
 21d:	ff 75 0c             	pushl  0xc(%ebp)
 220:	ff 75 08             	pushl  0x8(%ebp)
 223:	e8 32 ff ff ff       	call   15a <stosb>
 228:	83 c4 0c             	add    $0xc,%esp
  return dst;
 22b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 22e:	c9                   	leave  
 22f:	c3                   	ret    

00000230 <strchr>:

char*
strchr(const char *s, char c)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	83 ec 04             	sub    $0x4,%esp
 236:	8b 45 0c             	mov    0xc(%ebp),%eax
 239:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 23c:	eb 14                	jmp    252 <strchr+0x22>
    if(*s == c)
 23e:	8b 45 08             	mov    0x8(%ebp),%eax
 241:	0f b6 00             	movzbl (%eax),%eax
 244:	38 45 fc             	cmp    %al,-0x4(%ebp)
 247:	75 05                	jne    24e <strchr+0x1e>
      return (char*)s;
 249:	8b 45 08             	mov    0x8(%ebp),%eax
 24c:	eb 13                	jmp    261 <strchr+0x31>
  for(; *s; s++)
 24e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 252:	8b 45 08             	mov    0x8(%ebp),%eax
 255:	0f b6 00             	movzbl (%eax),%eax
 258:	84 c0                	test   %al,%al
 25a:	75 e2                	jne    23e <strchr+0xe>
  return 0;
 25c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 261:	c9                   	leave  
 262:	c3                   	ret    

00000263 <gets>:

char*
gets(char *buf, int max)
{
 263:	55                   	push   %ebp
 264:	89 e5                	mov    %esp,%ebp
 266:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 269:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 270:	eb 42                	jmp    2b4 <gets+0x51>
    cc = read(0, &c, 1);
 272:	83 ec 04             	sub    $0x4,%esp
 275:	6a 01                	push   $0x1
 277:	8d 45 ef             	lea    -0x11(%ebp),%eax
 27a:	50                   	push   %eax
 27b:	6a 00                	push   $0x0
 27d:	e8 47 01 00 00       	call   3c9 <read>
 282:	83 c4 10             	add    $0x10,%esp
 285:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 288:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 28c:	7e 33                	jle    2c1 <gets+0x5e>
      break;
    buf[i++] = c;
 28e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 291:	8d 50 01             	lea    0x1(%eax),%edx
 294:	89 55 f4             	mov    %edx,-0xc(%ebp)
 297:	89 c2                	mov    %eax,%edx
 299:	8b 45 08             	mov    0x8(%ebp),%eax
 29c:	01 c2                	add    %eax,%edx
 29e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a2:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2a4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a8:	3c 0a                	cmp    $0xa,%al
 2aa:	74 16                	je     2c2 <gets+0x5f>
 2ac:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2b0:	3c 0d                	cmp    $0xd,%al
 2b2:	74 0e                	je     2c2 <gets+0x5f>
  for(i=0; i+1 < max; ){
 2b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2b7:	83 c0 01             	add    $0x1,%eax
 2ba:	39 45 0c             	cmp    %eax,0xc(%ebp)
 2bd:	7f b3                	jg     272 <gets+0xf>
 2bf:	eb 01                	jmp    2c2 <gets+0x5f>
      break;
 2c1:	90                   	nop
      break;
  }
  buf[i] = '\0';
 2c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2c5:	8b 45 08             	mov    0x8(%ebp),%eax
 2c8:	01 d0                	add    %edx,%eax
 2ca:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2cd:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2d0:	c9                   	leave  
 2d1:	c3                   	ret    

000002d2 <stat>:

int
stat(char *n, struct stat *st)
{
 2d2:	55                   	push   %ebp
 2d3:	89 e5                	mov    %esp,%ebp
 2d5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d8:	83 ec 08             	sub    $0x8,%esp
 2db:	6a 00                	push   $0x0
 2dd:	ff 75 08             	pushl  0x8(%ebp)
 2e0:	e8 0c 01 00 00       	call   3f1 <open>
 2e5:	83 c4 10             	add    $0x10,%esp
 2e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2ef:	79 07                	jns    2f8 <stat+0x26>
    return -1;
 2f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2f6:	eb 25                	jmp    31d <stat+0x4b>
  r = fstat(fd, st);
 2f8:	83 ec 08             	sub    $0x8,%esp
 2fb:	ff 75 0c             	pushl  0xc(%ebp)
 2fe:	ff 75 f4             	pushl  -0xc(%ebp)
 301:	e8 03 01 00 00       	call   409 <fstat>
 306:	83 c4 10             	add    $0x10,%esp
 309:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 30c:	83 ec 0c             	sub    $0xc,%esp
 30f:	ff 75 f4             	pushl  -0xc(%ebp)
 312:	e8 c2 00 00 00       	call   3d9 <close>
 317:	83 c4 10             	add    $0x10,%esp
  return r;
 31a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 31d:	c9                   	leave  
 31e:	c3                   	ret    

0000031f <atoi>:

int
atoi(const char *s)
{
 31f:	55                   	push   %ebp
 320:	89 e5                	mov    %esp,%ebp
 322:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 325:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 32c:	eb 25                	jmp    353 <atoi+0x34>
    n = n*10 + *s++ - '0';
 32e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 331:	89 d0                	mov    %edx,%eax
 333:	c1 e0 02             	shl    $0x2,%eax
 336:	01 d0                	add    %edx,%eax
 338:	01 c0                	add    %eax,%eax
 33a:	89 c1                	mov    %eax,%ecx
 33c:	8b 45 08             	mov    0x8(%ebp),%eax
 33f:	8d 50 01             	lea    0x1(%eax),%edx
 342:	89 55 08             	mov    %edx,0x8(%ebp)
 345:	0f b6 00             	movzbl (%eax),%eax
 348:	0f be c0             	movsbl %al,%eax
 34b:	01 c8                	add    %ecx,%eax
 34d:	83 e8 30             	sub    $0x30,%eax
 350:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 353:	8b 45 08             	mov    0x8(%ebp),%eax
 356:	0f b6 00             	movzbl (%eax),%eax
 359:	3c 2f                	cmp    $0x2f,%al
 35b:	7e 0a                	jle    367 <atoi+0x48>
 35d:	8b 45 08             	mov    0x8(%ebp),%eax
 360:	0f b6 00             	movzbl (%eax),%eax
 363:	3c 39                	cmp    $0x39,%al
 365:	7e c7                	jle    32e <atoi+0xf>
  return n;
 367:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 36a:	c9                   	leave  
 36b:	c3                   	ret    

0000036c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 36c:	55                   	push   %ebp
 36d:	89 e5                	mov    %esp,%ebp
 36f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 372:	8b 45 08             	mov    0x8(%ebp),%eax
 375:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 378:	8b 45 0c             	mov    0xc(%ebp),%eax
 37b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 37e:	eb 17                	jmp    397 <memmove+0x2b>
    *dst++ = *src++;
 380:	8b 55 f8             	mov    -0x8(%ebp),%edx
 383:	8d 42 01             	lea    0x1(%edx),%eax
 386:	89 45 f8             	mov    %eax,-0x8(%ebp)
 389:	8b 45 fc             	mov    -0x4(%ebp),%eax
 38c:	8d 48 01             	lea    0x1(%eax),%ecx
 38f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 392:	0f b6 12             	movzbl (%edx),%edx
 395:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 397:	8b 45 10             	mov    0x10(%ebp),%eax
 39a:	8d 50 ff             	lea    -0x1(%eax),%edx
 39d:	89 55 10             	mov    %edx,0x10(%ebp)
 3a0:	85 c0                	test   %eax,%eax
 3a2:	7f dc                	jg     380 <memmove+0x14>
  return vdst;
 3a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3a7:	c9                   	leave  
 3a8:	c3                   	ret    

000003a9 <fork>:
 3a9:	b8 01 00 00 00       	mov    $0x1,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <exit>:
 3b1:	b8 02 00 00 00       	mov    $0x2,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <wait>:
 3b9:	b8 03 00 00 00       	mov    $0x3,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <pipe>:
 3c1:	b8 04 00 00 00       	mov    $0x4,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <read>:
 3c9:	b8 05 00 00 00       	mov    $0x5,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <write>:
 3d1:	b8 10 00 00 00       	mov    $0x10,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <close>:
 3d9:	b8 15 00 00 00       	mov    $0x15,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <kill>:
 3e1:	b8 06 00 00 00       	mov    $0x6,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <exec>:
 3e9:	b8 07 00 00 00       	mov    $0x7,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <open>:
 3f1:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <mknod>:
 3f9:	b8 11 00 00 00       	mov    $0x11,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <unlink>:
 401:	b8 12 00 00 00       	mov    $0x12,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <fstat>:
 409:	b8 08 00 00 00       	mov    $0x8,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <link>:
 411:	b8 13 00 00 00       	mov    $0x13,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <mkdir>:
 419:	b8 14 00 00 00       	mov    $0x14,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <chdir>:
 421:	b8 09 00 00 00       	mov    $0x9,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <dup>:
 429:	b8 0a 00 00 00       	mov    $0xa,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <getpid>:
 431:	b8 0b 00 00 00       	mov    $0xb,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <sbrk>:
 439:	b8 0c 00 00 00       	mov    $0xc,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <sleep>:
 441:	b8 0d 00 00 00       	mov    $0xd,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <uptime>:
 449:	b8 0e 00 00 00       	mov    $0xe,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 451:	55                   	push   %ebp
 452:	89 e5                	mov    %esp,%ebp
 454:	83 ec 18             	sub    $0x18,%esp
 457:	8b 45 0c             	mov    0xc(%ebp),%eax
 45a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 45d:	83 ec 04             	sub    $0x4,%esp
 460:	6a 01                	push   $0x1
 462:	8d 45 f4             	lea    -0xc(%ebp),%eax
 465:	50                   	push   %eax
 466:	ff 75 08             	pushl  0x8(%ebp)
 469:	e8 63 ff ff ff       	call   3d1 <write>
 46e:	83 c4 10             	add    $0x10,%esp
}
 471:	90                   	nop
 472:	c9                   	leave  
 473:	c3                   	ret    

00000474 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 474:	55                   	push   %ebp
 475:	89 e5                	mov    %esp,%ebp
 477:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 47a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 481:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 485:	74 17                	je     49e <printint+0x2a>
 487:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 48b:	79 11                	jns    49e <printint+0x2a>
    neg = 1;
 48d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 494:	8b 45 0c             	mov    0xc(%ebp),%eax
 497:	f7 d8                	neg    %eax
 499:	89 45 ec             	mov    %eax,-0x14(%ebp)
 49c:	eb 06                	jmp    4a4 <printint+0x30>
  } else {
    x = xx;
 49e:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4b1:	ba 00 00 00 00       	mov    $0x0,%edx
 4b6:	f7 f1                	div    %ecx
 4b8:	89 d1                	mov    %edx,%ecx
 4ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4bd:	8d 50 01             	lea    0x1(%eax),%edx
 4c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4c3:	0f b6 91 48 0b 00 00 	movzbl 0xb48(%ecx),%edx
 4ca:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 4ce:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4d4:	ba 00 00 00 00       	mov    $0x0,%edx
 4d9:	f7 f1                	div    %ecx
 4db:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4de:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e2:	75 c7                	jne    4ab <printint+0x37>
  if(neg)
 4e4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4e8:	74 2d                	je     517 <printint+0xa3>
    buf[i++] = '-';
 4ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ed:	8d 50 01             	lea    0x1(%eax),%edx
 4f0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4f3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4f8:	eb 1d                	jmp    517 <printint+0xa3>
    putc(fd, buf[i]);
 4fa:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 500:	01 d0                	add    %edx,%eax
 502:	0f b6 00             	movzbl (%eax),%eax
 505:	0f be c0             	movsbl %al,%eax
 508:	83 ec 08             	sub    $0x8,%esp
 50b:	50                   	push   %eax
 50c:	ff 75 08             	pushl  0x8(%ebp)
 50f:	e8 3d ff ff ff       	call   451 <putc>
 514:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 517:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 51b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 51f:	79 d9                	jns    4fa <printint+0x86>
}
 521:	90                   	nop
 522:	c9                   	leave  
 523:	c3                   	ret    

00000524 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 524:	55                   	push   %ebp
 525:	89 e5                	mov    %esp,%ebp
 527:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 52a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 531:	8d 45 0c             	lea    0xc(%ebp),%eax
 534:	83 c0 04             	add    $0x4,%eax
 537:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 53a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 541:	e9 59 01 00 00       	jmp    69f <printf+0x17b>
    c = fmt[i] & 0xff;
 546:	8b 55 0c             	mov    0xc(%ebp),%edx
 549:	8b 45 f0             	mov    -0x10(%ebp),%eax
 54c:	01 d0                	add    %edx,%eax
 54e:	0f b6 00             	movzbl (%eax),%eax
 551:	0f be c0             	movsbl %al,%eax
 554:	25 ff 00 00 00       	and    $0xff,%eax
 559:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 55c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 560:	75 2c                	jne    58e <printf+0x6a>
      if(c == '%'){
 562:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 566:	75 0c                	jne    574 <printf+0x50>
        state = '%';
 568:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 56f:	e9 27 01 00 00       	jmp    69b <printf+0x177>
      } else {
        putc(fd, c);
 574:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 577:	0f be c0             	movsbl %al,%eax
 57a:	83 ec 08             	sub    $0x8,%esp
 57d:	50                   	push   %eax
 57e:	ff 75 08             	pushl  0x8(%ebp)
 581:	e8 cb fe ff ff       	call   451 <putc>
 586:	83 c4 10             	add    $0x10,%esp
 589:	e9 0d 01 00 00       	jmp    69b <printf+0x177>
      }
    } else if(state == '%'){
 58e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 592:	0f 85 03 01 00 00    	jne    69b <printf+0x177>
      if(c == 'd'){
 598:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 59c:	75 1e                	jne    5bc <printf+0x98>
        printint(fd, *ap, 10, 1);
 59e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a1:	8b 00                	mov    (%eax),%eax
 5a3:	6a 01                	push   $0x1
 5a5:	6a 0a                	push   $0xa
 5a7:	50                   	push   %eax
 5a8:	ff 75 08             	pushl  0x8(%ebp)
 5ab:	e8 c4 fe ff ff       	call   474 <printint>
 5b0:	83 c4 10             	add    $0x10,%esp
        ap++;
 5b3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b7:	e9 d8 00 00 00       	jmp    694 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 5bc:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5c0:	74 06                	je     5c8 <printf+0xa4>
 5c2:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5c6:	75 1e                	jne    5e6 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 5c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5cb:	8b 00                	mov    (%eax),%eax
 5cd:	6a 00                	push   $0x0
 5cf:	6a 10                	push   $0x10
 5d1:	50                   	push   %eax
 5d2:	ff 75 08             	pushl  0x8(%ebp)
 5d5:	e8 9a fe ff ff       	call   474 <printint>
 5da:	83 c4 10             	add    $0x10,%esp
        ap++;
 5dd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e1:	e9 ae 00 00 00       	jmp    694 <printf+0x170>
      } else if(c == 's'){
 5e6:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5ea:	75 43                	jne    62f <printf+0x10b>
        s = (char*)*ap;
 5ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ef:	8b 00                	mov    (%eax),%eax
 5f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5f4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5fc:	75 25                	jne    623 <printf+0xff>
          s = "(null)";
 5fe:	c7 45 f4 fd 08 00 00 	movl   $0x8fd,-0xc(%ebp)
        while(*s != 0){
 605:	eb 1c                	jmp    623 <printf+0xff>
          putc(fd, *s);
 607:	8b 45 f4             	mov    -0xc(%ebp),%eax
 60a:	0f b6 00             	movzbl (%eax),%eax
 60d:	0f be c0             	movsbl %al,%eax
 610:	83 ec 08             	sub    $0x8,%esp
 613:	50                   	push   %eax
 614:	ff 75 08             	pushl  0x8(%ebp)
 617:	e8 35 fe ff ff       	call   451 <putc>
 61c:	83 c4 10             	add    $0x10,%esp
          s++;
 61f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 623:	8b 45 f4             	mov    -0xc(%ebp),%eax
 626:	0f b6 00             	movzbl (%eax),%eax
 629:	84 c0                	test   %al,%al
 62b:	75 da                	jne    607 <printf+0xe3>
 62d:	eb 65                	jmp    694 <printf+0x170>
        }
      } else if(c == 'c'){
 62f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 633:	75 1d                	jne    652 <printf+0x12e>
        putc(fd, *ap);
 635:	8b 45 e8             	mov    -0x18(%ebp),%eax
 638:	8b 00                	mov    (%eax),%eax
 63a:	0f be c0             	movsbl %al,%eax
 63d:	83 ec 08             	sub    $0x8,%esp
 640:	50                   	push   %eax
 641:	ff 75 08             	pushl  0x8(%ebp)
 644:	e8 08 fe ff ff       	call   451 <putc>
 649:	83 c4 10             	add    $0x10,%esp
        ap++;
 64c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 650:	eb 42                	jmp    694 <printf+0x170>
      } else if(c == '%'){
 652:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 656:	75 17                	jne    66f <printf+0x14b>
        putc(fd, c);
 658:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 65b:	0f be c0             	movsbl %al,%eax
 65e:	83 ec 08             	sub    $0x8,%esp
 661:	50                   	push   %eax
 662:	ff 75 08             	pushl  0x8(%ebp)
 665:	e8 e7 fd ff ff       	call   451 <putc>
 66a:	83 c4 10             	add    $0x10,%esp
 66d:	eb 25                	jmp    694 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 66f:	83 ec 08             	sub    $0x8,%esp
 672:	6a 25                	push   $0x25
 674:	ff 75 08             	pushl  0x8(%ebp)
 677:	e8 d5 fd ff ff       	call   451 <putc>
 67c:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 67f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 682:	0f be c0             	movsbl %al,%eax
 685:	83 ec 08             	sub    $0x8,%esp
 688:	50                   	push   %eax
 689:	ff 75 08             	pushl  0x8(%ebp)
 68c:	e8 c0 fd ff ff       	call   451 <putc>
 691:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 694:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 69b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 69f:	8b 55 0c             	mov    0xc(%ebp),%edx
 6a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6a5:	01 d0                	add    %edx,%eax
 6a7:	0f b6 00             	movzbl (%eax),%eax
 6aa:	84 c0                	test   %al,%al
 6ac:	0f 85 94 fe ff ff    	jne    546 <printf+0x22>
    }
  }
}
 6b2:	90                   	nop
 6b3:	c9                   	leave  
 6b4:	c3                   	ret    

000006b5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6b5:	55                   	push   %ebp
 6b6:	89 e5                	mov    %esp,%ebp
 6b8:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6bb:	8b 45 08             	mov    0x8(%ebp),%eax
 6be:	83 e8 08             	sub    $0x8,%eax
 6c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c4:	a1 64 0b 00 00       	mov    0xb64,%eax
 6c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6cc:	eb 24                	jmp    6f2 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d1:	8b 00                	mov    (%eax),%eax
 6d3:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 6d6:	72 12                	jb     6ea <free+0x35>
 6d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6db:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6de:	77 24                	ja     704 <free+0x4f>
 6e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e3:	8b 00                	mov    (%eax),%eax
 6e5:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6e8:	72 1a                	jb     704 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ed:	8b 00                	mov    (%eax),%eax
 6ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6f8:	76 d4                	jbe    6ce <free+0x19>
 6fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fd:	8b 00                	mov    (%eax),%eax
 6ff:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 702:	73 ca                	jae    6ce <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 704:	8b 45 f8             	mov    -0x8(%ebp),%eax
 707:	8b 40 04             	mov    0x4(%eax),%eax
 70a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 711:	8b 45 f8             	mov    -0x8(%ebp),%eax
 714:	01 c2                	add    %eax,%edx
 716:	8b 45 fc             	mov    -0x4(%ebp),%eax
 719:	8b 00                	mov    (%eax),%eax
 71b:	39 c2                	cmp    %eax,%edx
 71d:	75 24                	jne    743 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 71f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 722:	8b 50 04             	mov    0x4(%eax),%edx
 725:	8b 45 fc             	mov    -0x4(%ebp),%eax
 728:	8b 00                	mov    (%eax),%eax
 72a:	8b 40 04             	mov    0x4(%eax),%eax
 72d:	01 c2                	add    %eax,%edx
 72f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 732:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 735:	8b 45 fc             	mov    -0x4(%ebp),%eax
 738:	8b 00                	mov    (%eax),%eax
 73a:	8b 10                	mov    (%eax),%edx
 73c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73f:	89 10                	mov    %edx,(%eax)
 741:	eb 0a                	jmp    74d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 743:	8b 45 fc             	mov    -0x4(%ebp),%eax
 746:	8b 10                	mov    (%eax),%edx
 748:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 74d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 750:	8b 40 04             	mov    0x4(%eax),%eax
 753:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 75a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75d:	01 d0                	add    %edx,%eax
 75f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 762:	75 20                	jne    784 <free+0xcf>
    p->s.size += bp->s.size;
 764:	8b 45 fc             	mov    -0x4(%ebp),%eax
 767:	8b 50 04             	mov    0x4(%eax),%edx
 76a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76d:	8b 40 04             	mov    0x4(%eax),%eax
 770:	01 c2                	add    %eax,%edx
 772:	8b 45 fc             	mov    -0x4(%ebp),%eax
 775:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 778:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77b:	8b 10                	mov    (%eax),%edx
 77d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 780:	89 10                	mov    %edx,(%eax)
 782:	eb 08                	jmp    78c <free+0xd7>
  } else
    p->s.ptr = bp;
 784:	8b 45 fc             	mov    -0x4(%ebp),%eax
 787:	8b 55 f8             	mov    -0x8(%ebp),%edx
 78a:	89 10                	mov    %edx,(%eax)
  freep = p;
 78c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78f:	a3 64 0b 00 00       	mov    %eax,0xb64
}
 794:	90                   	nop
 795:	c9                   	leave  
 796:	c3                   	ret    

00000797 <morecore>:

static Header*
morecore(uint nu)
{
 797:	55                   	push   %ebp
 798:	89 e5                	mov    %esp,%ebp
 79a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 79d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7a4:	77 07                	ja     7ad <morecore+0x16>
    nu = 4096;
 7a6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7ad:	8b 45 08             	mov    0x8(%ebp),%eax
 7b0:	c1 e0 03             	shl    $0x3,%eax
 7b3:	83 ec 0c             	sub    $0xc,%esp
 7b6:	50                   	push   %eax
 7b7:	e8 7d fc ff ff       	call   439 <sbrk>
 7bc:	83 c4 10             	add    $0x10,%esp
 7bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7c2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7c6:	75 07                	jne    7cf <morecore+0x38>
    return 0;
 7c8:	b8 00 00 00 00       	mov    $0x0,%eax
 7cd:	eb 26                	jmp    7f5 <morecore+0x5e>
  hp = (Header*)p;
 7cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d8:	8b 55 08             	mov    0x8(%ebp),%edx
 7db:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7de:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e1:	83 c0 08             	add    $0x8,%eax
 7e4:	83 ec 0c             	sub    $0xc,%esp
 7e7:	50                   	push   %eax
 7e8:	e8 c8 fe ff ff       	call   6b5 <free>
 7ed:	83 c4 10             	add    $0x10,%esp
  return freep;
 7f0:	a1 64 0b 00 00       	mov    0xb64,%eax
}
 7f5:	c9                   	leave  
 7f6:	c3                   	ret    

000007f7 <malloc>:

void*
malloc(uint nbytes)
{
 7f7:	55                   	push   %ebp
 7f8:	89 e5                	mov    %esp,%ebp
 7fa:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7fd:	8b 45 08             	mov    0x8(%ebp),%eax
 800:	83 c0 07             	add    $0x7,%eax
 803:	c1 e8 03             	shr    $0x3,%eax
 806:	83 c0 01             	add    $0x1,%eax
 809:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 80c:	a1 64 0b 00 00       	mov    0xb64,%eax
 811:	89 45 f0             	mov    %eax,-0x10(%ebp)
 814:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 818:	75 23                	jne    83d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 81a:	c7 45 f0 5c 0b 00 00 	movl   $0xb5c,-0x10(%ebp)
 821:	8b 45 f0             	mov    -0x10(%ebp),%eax
 824:	a3 64 0b 00 00       	mov    %eax,0xb64
 829:	a1 64 0b 00 00       	mov    0xb64,%eax
 82e:	a3 5c 0b 00 00       	mov    %eax,0xb5c
    base.s.size = 0;
 833:	c7 05 60 0b 00 00 00 	movl   $0x0,0xb60
 83a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 83d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 840:	8b 00                	mov    (%eax),%eax
 842:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 845:	8b 45 f4             	mov    -0xc(%ebp),%eax
 848:	8b 40 04             	mov    0x4(%eax),%eax
 84b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 84e:	77 4d                	ja     89d <malloc+0xa6>
      if(p->s.size == nunits)
 850:	8b 45 f4             	mov    -0xc(%ebp),%eax
 853:	8b 40 04             	mov    0x4(%eax),%eax
 856:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 859:	75 0c                	jne    867 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 85b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85e:	8b 10                	mov    (%eax),%edx
 860:	8b 45 f0             	mov    -0x10(%ebp),%eax
 863:	89 10                	mov    %edx,(%eax)
 865:	eb 26                	jmp    88d <malloc+0x96>
      else {
        p->s.size -= nunits;
 867:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86a:	8b 40 04             	mov    0x4(%eax),%eax
 86d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 870:	89 c2                	mov    %eax,%edx
 872:	8b 45 f4             	mov    -0xc(%ebp),%eax
 875:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 878:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87b:	8b 40 04             	mov    0x4(%eax),%eax
 87e:	c1 e0 03             	shl    $0x3,%eax
 881:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 884:	8b 45 f4             	mov    -0xc(%ebp),%eax
 887:	8b 55 ec             	mov    -0x14(%ebp),%edx
 88a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 88d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 890:	a3 64 0b 00 00       	mov    %eax,0xb64
      return (void*)(p + 1);
 895:	8b 45 f4             	mov    -0xc(%ebp),%eax
 898:	83 c0 08             	add    $0x8,%eax
 89b:	eb 3b                	jmp    8d8 <malloc+0xe1>
    }
    if(p == freep)
 89d:	a1 64 0b 00 00       	mov    0xb64,%eax
 8a2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8a5:	75 1e                	jne    8c5 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 8a7:	83 ec 0c             	sub    $0xc,%esp
 8aa:	ff 75 ec             	pushl  -0x14(%ebp)
 8ad:	e8 e5 fe ff ff       	call   797 <morecore>
 8b2:	83 c4 10             	add    $0x10,%esp
 8b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8bc:	75 07                	jne    8c5 <malloc+0xce>
        return 0;
 8be:	b8 00 00 00 00       	mov    $0x0,%eax
 8c3:	eb 13                	jmp    8d8 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ce:	8b 00                	mov    (%eax),%eax
 8d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8d3:	e9 6d ff ff ff       	jmp    845 <malloc+0x4e>
  }
}
 8d8:	c9                   	leave  
 8d9:	c3                   	ret    
