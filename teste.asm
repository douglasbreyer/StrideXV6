
_teste:     formato de ficheiro elf32-i386


Desmontagem da secção .text:

00000000 <loop>:
#include "types.h"      //maybe needed to use some types of variables
#include "user.h"       //functios like printf and syscalls

#define N 4

void loop(){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 10             	sub    $0x10,%esp
    int x, i = 0;
   6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    for(x=0; x<112345678; x++){
   d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  14:	eb 08                	jmp    1e <loop+0x1e>
        i--;
  16:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    for(x=0; x<112345678; x++){
  1a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1e:	81 7d fc 4d 42 b2 06 	cmpl   $0x6b2424d,-0x4(%ebp)
  25:	7e ef                	jle    16 <loop+0x16>
    }

    for(x=0; x<112345621; x++){
  27:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  2e:	eb 08                	jmp    38 <loop+0x38>
        i--;
  30:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    for(x=0; x<112345621; x++){
  34:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  38:	81 7d fc 14 42 b2 06 	cmpl   $0x6b24214,-0x4(%ebp)
  3f:	7e ef                	jle    30 <loop+0x30>
    }

}
  41:	90                   	nop
  42:	c9                   	leave  
  43:	c3                   	ret    

00000044 <main>:

int main(){
  44:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  48:	83 e4 f0             	and    $0xfffffff0,%esp
  4b:	ff 71 fc             	pushl  -0x4(%ecx)
  4e:	55                   	push   %ebp
  4f:	89 e5                	mov    %esp,%ebp
  51:	51                   	push   %ecx
  52:	83 ec 14             	sub    $0x14,%esp
    int pid;
    int i;
    for (i=1;i<=N;i++){
  55:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  5c:	eb 29                	jmp    87 <main+0x43>
            pid=fork(100*i);
  5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  61:	6b c0 64             	imul   $0x64,%eax,%eax
  64:	83 ec 0c             	sub    $0xc,%esp
  67:	50                   	push   %eax
  68:	e8 85 02 00 00       	call   2f2 <fork>
  6d:	83 c4 10             	add    $0x10,%esp
  70:	89 45 f0             	mov    %eax,-0x10(%ebp)
            if(pid==0){
  73:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  77:	75 0a                	jne    83 <main+0x3f>
                loop();
  79:	e8 82 ff ff ff       	call   0 <loop>
                exit();
  7e:	e8 77 02 00 00       	call   2fa <exit>
    for (i=1;i<=N;i++){
  83:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  87:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
  8b:	7e d1                	jle    5e <main+0x1a>
            }
    }
   while(1){
        pid=wait();
  8d:	e8 70 02 00 00       	call   302 <wait>
  92:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if(pid<0)break;
  95:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  99:	78 02                	js     9d <main+0x59>
        pid=wait();
  9b:	eb f0                	jmp    8d <main+0x49>
        if(pid<0)break;
  9d:	90                   	nop
    }



    exit();
  9e:	e8 57 02 00 00       	call   2fa <exit>

000000a3 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  a3:	55                   	push   %ebp
  a4:	89 e5                	mov    %esp,%ebp
  a6:	57                   	push   %edi
  a7:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ab:	8b 55 10             	mov    0x10(%ebp),%edx
  ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  b1:	89 cb                	mov    %ecx,%ebx
  b3:	89 df                	mov    %ebx,%edi
  b5:	89 d1                	mov    %edx,%ecx
  b7:	fc                   	cld    
  b8:	f3 aa                	rep stos %al,%es:(%edi)
  ba:	89 ca                	mov    %ecx,%edx
  bc:	89 fb                	mov    %edi,%ebx
  be:	89 5d 08             	mov    %ebx,0x8(%ebp)
  c1:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  c4:	90                   	nop
  c5:	5b                   	pop    %ebx
  c6:	5f                   	pop    %edi
  c7:	5d                   	pop    %ebp
  c8:	c3                   	ret    

000000c9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  c9:	55                   	push   %ebp
  ca:	89 e5                	mov    %esp,%ebp
  cc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  cf:	8b 45 08             	mov    0x8(%ebp),%eax
  d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  d5:	90                   	nop
  d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  d9:	8d 42 01             	lea    0x1(%edx),%eax
  dc:	89 45 0c             	mov    %eax,0xc(%ebp)
  df:	8b 45 08             	mov    0x8(%ebp),%eax
  e2:	8d 48 01             	lea    0x1(%eax),%ecx
  e5:	89 4d 08             	mov    %ecx,0x8(%ebp)
  e8:	0f b6 12             	movzbl (%edx),%edx
  eb:	88 10                	mov    %dl,(%eax)
  ed:	0f b6 00             	movzbl (%eax),%eax
  f0:	84 c0                	test   %al,%al
  f2:	75 e2                	jne    d6 <strcpy+0xd>
    ;
  return os;
  f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  f7:	c9                   	leave  
  f8:	c3                   	ret    

000000f9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f9:	55                   	push   %ebp
  fa:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  fc:	eb 08                	jmp    106 <strcmp+0xd>
    p++, q++;
  fe:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 102:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 106:	8b 45 08             	mov    0x8(%ebp),%eax
 109:	0f b6 00             	movzbl (%eax),%eax
 10c:	84 c0                	test   %al,%al
 10e:	74 10                	je     120 <strcmp+0x27>
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	0f b6 10             	movzbl (%eax),%edx
 116:	8b 45 0c             	mov    0xc(%ebp),%eax
 119:	0f b6 00             	movzbl (%eax),%eax
 11c:	38 c2                	cmp    %al,%dl
 11e:	74 de                	je     fe <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 120:	8b 45 08             	mov    0x8(%ebp),%eax
 123:	0f b6 00             	movzbl (%eax),%eax
 126:	0f b6 d0             	movzbl %al,%edx
 129:	8b 45 0c             	mov    0xc(%ebp),%eax
 12c:	0f b6 00             	movzbl (%eax),%eax
 12f:	0f b6 c0             	movzbl %al,%eax
 132:	29 c2                	sub    %eax,%edx
 134:	89 d0                	mov    %edx,%eax
}
 136:	5d                   	pop    %ebp
 137:	c3                   	ret    

00000138 <strlen>:

uint
strlen(char *s)
{
 138:	55                   	push   %ebp
 139:	89 e5                	mov    %esp,%ebp
 13b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 13e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 145:	eb 04                	jmp    14b <strlen+0x13>
 147:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 14b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 14e:	8b 45 08             	mov    0x8(%ebp),%eax
 151:	01 d0                	add    %edx,%eax
 153:	0f b6 00             	movzbl (%eax),%eax
 156:	84 c0                	test   %al,%al
 158:	75 ed                	jne    147 <strlen+0xf>
    ;
  return n;
 15a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 15d:	c9                   	leave  
 15e:	c3                   	ret    

0000015f <memset>:

void*
memset(void *dst, int c, uint n)
{
 15f:	55                   	push   %ebp
 160:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 162:	8b 45 10             	mov    0x10(%ebp),%eax
 165:	50                   	push   %eax
 166:	ff 75 0c             	pushl  0xc(%ebp)
 169:	ff 75 08             	pushl  0x8(%ebp)
 16c:	e8 32 ff ff ff       	call   a3 <stosb>
 171:	83 c4 0c             	add    $0xc,%esp
  return dst;
 174:	8b 45 08             	mov    0x8(%ebp),%eax
}
 177:	c9                   	leave  
 178:	c3                   	ret    

00000179 <strchr>:

char*
strchr(const char *s, char c)
{
 179:	55                   	push   %ebp
 17a:	89 e5                	mov    %esp,%ebp
 17c:	83 ec 04             	sub    $0x4,%esp
 17f:	8b 45 0c             	mov    0xc(%ebp),%eax
 182:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 185:	eb 14                	jmp    19b <strchr+0x22>
    if(*s == c)
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	0f b6 00             	movzbl (%eax),%eax
 18d:	38 45 fc             	cmp    %al,-0x4(%ebp)
 190:	75 05                	jne    197 <strchr+0x1e>
      return (char*)s;
 192:	8b 45 08             	mov    0x8(%ebp),%eax
 195:	eb 13                	jmp    1aa <strchr+0x31>
  for(; *s; s++)
 197:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 19b:	8b 45 08             	mov    0x8(%ebp),%eax
 19e:	0f b6 00             	movzbl (%eax),%eax
 1a1:	84 c0                	test   %al,%al
 1a3:	75 e2                	jne    187 <strchr+0xe>
  return 0;
 1a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1aa:	c9                   	leave  
 1ab:	c3                   	ret    

000001ac <gets>:

char*
gets(char *buf, int max)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1b9:	eb 42                	jmp    1fd <gets+0x51>
    cc = read(0, &c, 1);
 1bb:	83 ec 04             	sub    $0x4,%esp
 1be:	6a 01                	push   $0x1
 1c0:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1c3:	50                   	push   %eax
 1c4:	6a 00                	push   $0x0
 1c6:	e8 47 01 00 00       	call   312 <read>
 1cb:	83 c4 10             	add    $0x10,%esp
 1ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1d1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1d5:	7e 33                	jle    20a <gets+0x5e>
      break;
    buf[i++] = c;
 1d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1da:	8d 50 01             	lea    0x1(%eax),%edx
 1dd:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1e0:	89 c2                	mov    %eax,%edx
 1e2:	8b 45 08             	mov    0x8(%ebp),%eax
 1e5:	01 c2                	add    %eax,%edx
 1e7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1eb:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1ed:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f1:	3c 0a                	cmp    $0xa,%al
 1f3:	74 16                	je     20b <gets+0x5f>
 1f5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f9:	3c 0d                	cmp    $0xd,%al
 1fb:	74 0e                	je     20b <gets+0x5f>
  for(i=0; i+1 < max; ){
 1fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 200:	83 c0 01             	add    $0x1,%eax
 203:	39 45 0c             	cmp    %eax,0xc(%ebp)
 206:	7f b3                	jg     1bb <gets+0xf>
 208:	eb 01                	jmp    20b <gets+0x5f>
      break;
 20a:	90                   	nop
      break;
  }
  buf[i] = '\0';
 20b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 20e:	8b 45 08             	mov    0x8(%ebp),%eax
 211:	01 d0                	add    %edx,%eax
 213:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 216:	8b 45 08             	mov    0x8(%ebp),%eax
}
 219:	c9                   	leave  
 21a:	c3                   	ret    

0000021b <stat>:

int
stat(char *n, struct stat *st)
{
 21b:	55                   	push   %ebp
 21c:	89 e5                	mov    %esp,%ebp
 21e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 221:	83 ec 08             	sub    $0x8,%esp
 224:	6a 00                	push   $0x0
 226:	ff 75 08             	pushl  0x8(%ebp)
 229:	e8 0c 01 00 00       	call   33a <open>
 22e:	83 c4 10             	add    $0x10,%esp
 231:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 234:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 238:	79 07                	jns    241 <stat+0x26>
    return -1;
 23a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 23f:	eb 25                	jmp    266 <stat+0x4b>
  r = fstat(fd, st);
 241:	83 ec 08             	sub    $0x8,%esp
 244:	ff 75 0c             	pushl  0xc(%ebp)
 247:	ff 75 f4             	pushl  -0xc(%ebp)
 24a:	e8 03 01 00 00       	call   352 <fstat>
 24f:	83 c4 10             	add    $0x10,%esp
 252:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 255:	83 ec 0c             	sub    $0xc,%esp
 258:	ff 75 f4             	pushl  -0xc(%ebp)
 25b:	e8 c2 00 00 00       	call   322 <close>
 260:	83 c4 10             	add    $0x10,%esp
  return r;
 263:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 266:	c9                   	leave  
 267:	c3                   	ret    

00000268 <atoi>:

int
atoi(const char *s)
{
 268:	55                   	push   %ebp
 269:	89 e5                	mov    %esp,%ebp
 26b:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 26e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 275:	eb 25                	jmp    29c <atoi+0x34>
    n = n*10 + *s++ - '0';
 277:	8b 55 fc             	mov    -0x4(%ebp),%edx
 27a:	89 d0                	mov    %edx,%eax
 27c:	c1 e0 02             	shl    $0x2,%eax
 27f:	01 d0                	add    %edx,%eax
 281:	01 c0                	add    %eax,%eax
 283:	89 c1                	mov    %eax,%ecx
 285:	8b 45 08             	mov    0x8(%ebp),%eax
 288:	8d 50 01             	lea    0x1(%eax),%edx
 28b:	89 55 08             	mov    %edx,0x8(%ebp)
 28e:	0f b6 00             	movzbl (%eax),%eax
 291:	0f be c0             	movsbl %al,%eax
 294:	01 c8                	add    %ecx,%eax
 296:	83 e8 30             	sub    $0x30,%eax
 299:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 29c:	8b 45 08             	mov    0x8(%ebp),%eax
 29f:	0f b6 00             	movzbl (%eax),%eax
 2a2:	3c 2f                	cmp    $0x2f,%al
 2a4:	7e 0a                	jle    2b0 <atoi+0x48>
 2a6:	8b 45 08             	mov    0x8(%ebp),%eax
 2a9:	0f b6 00             	movzbl (%eax),%eax
 2ac:	3c 39                	cmp    $0x39,%al
 2ae:	7e c7                	jle    277 <atoi+0xf>
  return n;
 2b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2b3:	c9                   	leave  
 2b4:	c3                   	ret    

000002b5 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b5:	55                   	push   %ebp
 2b6:	89 e5                	mov    %esp,%ebp
 2b8:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2bb:	8b 45 08             	mov    0x8(%ebp),%eax
 2be:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2c1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2c7:	eb 17                	jmp    2e0 <memmove+0x2b>
    *dst++ = *src++;
 2c9:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2cc:	8d 42 01             	lea    0x1(%edx),%eax
 2cf:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2d5:	8d 48 01             	lea    0x1(%eax),%ecx
 2d8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 2db:	0f b6 12             	movzbl (%edx),%edx
 2de:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 2e0:	8b 45 10             	mov    0x10(%ebp),%eax
 2e3:	8d 50 ff             	lea    -0x1(%eax),%edx
 2e6:	89 55 10             	mov    %edx,0x10(%ebp)
 2e9:	85 c0                	test   %eax,%eax
 2eb:	7f dc                	jg     2c9 <memmove+0x14>
  return vdst;
 2ed:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2f0:	c9                   	leave  
 2f1:	c3                   	ret    

000002f2 <fork>:
 2f2:	b8 01 00 00 00       	mov    $0x1,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <exit>:
 2fa:	b8 02 00 00 00       	mov    $0x2,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <wait>:
 302:	b8 03 00 00 00       	mov    $0x3,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <pipe>:
 30a:	b8 04 00 00 00       	mov    $0x4,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <read>:
 312:	b8 05 00 00 00       	mov    $0x5,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <write>:
 31a:	b8 10 00 00 00       	mov    $0x10,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <close>:
 322:	b8 15 00 00 00       	mov    $0x15,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <kill>:
 32a:	b8 06 00 00 00       	mov    $0x6,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <exec>:
 332:	b8 07 00 00 00       	mov    $0x7,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <open>:
 33a:	b8 0f 00 00 00       	mov    $0xf,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <mknod>:
 342:	b8 11 00 00 00       	mov    $0x11,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <unlink>:
 34a:	b8 12 00 00 00       	mov    $0x12,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <fstat>:
 352:	b8 08 00 00 00       	mov    $0x8,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <link>:
 35a:	b8 13 00 00 00       	mov    $0x13,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <mkdir>:
 362:	b8 14 00 00 00       	mov    $0x14,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <chdir>:
 36a:	b8 09 00 00 00       	mov    $0x9,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <dup>:
 372:	b8 0a 00 00 00       	mov    $0xa,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <getpid>:
 37a:	b8 0b 00 00 00       	mov    $0xb,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <sbrk>:
 382:	b8 0c 00 00 00       	mov    $0xc,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <sleep>:
 38a:	b8 0d 00 00 00       	mov    $0xd,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <uptime>:
 392:	b8 0e 00 00 00       	mov    $0xe,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 39a:	55                   	push   %ebp
 39b:	89 e5                	mov    %esp,%ebp
 39d:	83 ec 18             	sub    $0x18,%esp
 3a0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a3:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3a6:	83 ec 04             	sub    $0x4,%esp
 3a9:	6a 01                	push   $0x1
 3ab:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3ae:	50                   	push   %eax
 3af:	ff 75 08             	pushl  0x8(%ebp)
 3b2:	e8 63 ff ff ff       	call   31a <write>
 3b7:	83 c4 10             	add    $0x10,%esp
}
 3ba:	90                   	nop
 3bb:	c9                   	leave  
 3bc:	c3                   	ret    

000003bd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3bd:	55                   	push   %ebp
 3be:	89 e5                	mov    %esp,%ebp
 3c0:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3ca:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3ce:	74 17                	je     3e7 <printint+0x2a>
 3d0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3d4:	79 11                	jns    3e7 <printint+0x2a>
    neg = 1;
 3d6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3dd:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e0:	f7 d8                	neg    %eax
 3e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e5:	eb 06                	jmp    3ed <printint+0x30>
  } else {
    x = xx;
 3e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3f4:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3fa:	ba 00 00 00 00       	mov    $0x0,%edx
 3ff:	f7 f1                	div    %ecx
 401:	89 d1                	mov    %edx,%ecx
 403:	8b 45 f4             	mov    -0xc(%ebp),%eax
 406:	8d 50 01             	lea    0x1(%eax),%edx
 409:	89 55 f4             	mov    %edx,-0xc(%ebp)
 40c:	0f b6 91 90 0a 00 00 	movzbl 0xa90(%ecx),%edx
 413:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 417:	8b 4d 10             	mov    0x10(%ebp),%ecx
 41a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 41d:	ba 00 00 00 00       	mov    $0x0,%edx
 422:	f7 f1                	div    %ecx
 424:	89 45 ec             	mov    %eax,-0x14(%ebp)
 427:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 42b:	75 c7                	jne    3f4 <printint+0x37>
  if(neg)
 42d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 431:	74 2d                	je     460 <printint+0xa3>
    buf[i++] = '-';
 433:	8b 45 f4             	mov    -0xc(%ebp),%eax
 436:	8d 50 01             	lea    0x1(%eax),%edx
 439:	89 55 f4             	mov    %edx,-0xc(%ebp)
 43c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 441:	eb 1d                	jmp    460 <printint+0xa3>
    putc(fd, buf[i]);
 443:	8d 55 dc             	lea    -0x24(%ebp),%edx
 446:	8b 45 f4             	mov    -0xc(%ebp),%eax
 449:	01 d0                	add    %edx,%eax
 44b:	0f b6 00             	movzbl (%eax),%eax
 44e:	0f be c0             	movsbl %al,%eax
 451:	83 ec 08             	sub    $0x8,%esp
 454:	50                   	push   %eax
 455:	ff 75 08             	pushl  0x8(%ebp)
 458:	e8 3d ff ff ff       	call   39a <putc>
 45d:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 460:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 464:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 468:	79 d9                	jns    443 <printint+0x86>
}
 46a:	90                   	nop
 46b:	c9                   	leave  
 46c:	c3                   	ret    

0000046d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 46d:	55                   	push   %ebp
 46e:	89 e5                	mov    %esp,%ebp
 470:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 473:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 47a:	8d 45 0c             	lea    0xc(%ebp),%eax
 47d:	83 c0 04             	add    $0x4,%eax
 480:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 483:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 48a:	e9 59 01 00 00       	jmp    5e8 <printf+0x17b>
    c = fmt[i] & 0xff;
 48f:	8b 55 0c             	mov    0xc(%ebp),%edx
 492:	8b 45 f0             	mov    -0x10(%ebp),%eax
 495:	01 d0                	add    %edx,%eax
 497:	0f b6 00             	movzbl (%eax),%eax
 49a:	0f be c0             	movsbl %al,%eax
 49d:	25 ff 00 00 00       	and    $0xff,%eax
 4a2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4a5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a9:	75 2c                	jne    4d7 <printf+0x6a>
      if(c == '%'){
 4ab:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4af:	75 0c                	jne    4bd <printf+0x50>
        state = '%';
 4b1:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4b8:	e9 27 01 00 00       	jmp    5e4 <printf+0x177>
      } else {
        putc(fd, c);
 4bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4c0:	0f be c0             	movsbl %al,%eax
 4c3:	83 ec 08             	sub    $0x8,%esp
 4c6:	50                   	push   %eax
 4c7:	ff 75 08             	pushl  0x8(%ebp)
 4ca:	e8 cb fe ff ff       	call   39a <putc>
 4cf:	83 c4 10             	add    $0x10,%esp
 4d2:	e9 0d 01 00 00       	jmp    5e4 <printf+0x177>
      }
    } else if(state == '%'){
 4d7:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4db:	0f 85 03 01 00 00    	jne    5e4 <printf+0x177>
      if(c == 'd'){
 4e1:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4e5:	75 1e                	jne    505 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ea:	8b 00                	mov    (%eax),%eax
 4ec:	6a 01                	push   $0x1
 4ee:	6a 0a                	push   $0xa
 4f0:	50                   	push   %eax
 4f1:	ff 75 08             	pushl  0x8(%ebp)
 4f4:	e8 c4 fe ff ff       	call   3bd <printint>
 4f9:	83 c4 10             	add    $0x10,%esp
        ap++;
 4fc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 500:	e9 d8 00 00 00       	jmp    5dd <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 505:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 509:	74 06                	je     511 <printf+0xa4>
 50b:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 50f:	75 1e                	jne    52f <printf+0xc2>
        printint(fd, *ap, 16, 0);
 511:	8b 45 e8             	mov    -0x18(%ebp),%eax
 514:	8b 00                	mov    (%eax),%eax
 516:	6a 00                	push   $0x0
 518:	6a 10                	push   $0x10
 51a:	50                   	push   %eax
 51b:	ff 75 08             	pushl  0x8(%ebp)
 51e:	e8 9a fe ff ff       	call   3bd <printint>
 523:	83 c4 10             	add    $0x10,%esp
        ap++;
 526:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 52a:	e9 ae 00 00 00       	jmp    5dd <printf+0x170>
      } else if(c == 's'){
 52f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 533:	75 43                	jne    578 <printf+0x10b>
        s = (char*)*ap;
 535:	8b 45 e8             	mov    -0x18(%ebp),%eax
 538:	8b 00                	mov    (%eax),%eax
 53a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 53d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 541:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 545:	75 25                	jne    56c <printf+0xff>
          s = "(null)";
 547:	c7 45 f4 23 08 00 00 	movl   $0x823,-0xc(%ebp)
        while(*s != 0){
 54e:	eb 1c                	jmp    56c <printf+0xff>
          putc(fd, *s);
 550:	8b 45 f4             	mov    -0xc(%ebp),%eax
 553:	0f b6 00             	movzbl (%eax),%eax
 556:	0f be c0             	movsbl %al,%eax
 559:	83 ec 08             	sub    $0x8,%esp
 55c:	50                   	push   %eax
 55d:	ff 75 08             	pushl  0x8(%ebp)
 560:	e8 35 fe ff ff       	call   39a <putc>
 565:	83 c4 10             	add    $0x10,%esp
          s++;
 568:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 56c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 56f:	0f b6 00             	movzbl (%eax),%eax
 572:	84 c0                	test   %al,%al
 574:	75 da                	jne    550 <printf+0xe3>
 576:	eb 65                	jmp    5dd <printf+0x170>
        }
      } else if(c == 'c'){
 578:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 57c:	75 1d                	jne    59b <printf+0x12e>
        putc(fd, *ap);
 57e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 581:	8b 00                	mov    (%eax),%eax
 583:	0f be c0             	movsbl %al,%eax
 586:	83 ec 08             	sub    $0x8,%esp
 589:	50                   	push   %eax
 58a:	ff 75 08             	pushl  0x8(%ebp)
 58d:	e8 08 fe ff ff       	call   39a <putc>
 592:	83 c4 10             	add    $0x10,%esp
        ap++;
 595:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 599:	eb 42                	jmp    5dd <printf+0x170>
      } else if(c == '%'){
 59b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 59f:	75 17                	jne    5b8 <printf+0x14b>
        putc(fd, c);
 5a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a4:	0f be c0             	movsbl %al,%eax
 5a7:	83 ec 08             	sub    $0x8,%esp
 5aa:	50                   	push   %eax
 5ab:	ff 75 08             	pushl  0x8(%ebp)
 5ae:	e8 e7 fd ff ff       	call   39a <putc>
 5b3:	83 c4 10             	add    $0x10,%esp
 5b6:	eb 25                	jmp    5dd <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5b8:	83 ec 08             	sub    $0x8,%esp
 5bb:	6a 25                	push   $0x25
 5bd:	ff 75 08             	pushl  0x8(%ebp)
 5c0:	e8 d5 fd ff ff       	call   39a <putc>
 5c5:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5cb:	0f be c0             	movsbl %al,%eax
 5ce:	83 ec 08             	sub    $0x8,%esp
 5d1:	50                   	push   %eax
 5d2:	ff 75 08             	pushl  0x8(%ebp)
 5d5:	e8 c0 fd ff ff       	call   39a <putc>
 5da:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5dd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 5e4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5e8:	8b 55 0c             	mov    0xc(%ebp),%edx
 5eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5ee:	01 d0                	add    %edx,%eax
 5f0:	0f b6 00             	movzbl (%eax),%eax
 5f3:	84 c0                	test   %al,%al
 5f5:	0f 85 94 fe ff ff    	jne    48f <printf+0x22>
    }
  }
}
 5fb:	90                   	nop
 5fc:	c9                   	leave  
 5fd:	c3                   	ret    

000005fe <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5fe:	55                   	push   %ebp
 5ff:	89 e5                	mov    %esp,%ebp
 601:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 604:	8b 45 08             	mov    0x8(%ebp),%eax
 607:	83 e8 08             	sub    $0x8,%eax
 60a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 60d:	a1 ac 0a 00 00       	mov    0xaac,%eax
 612:	89 45 fc             	mov    %eax,-0x4(%ebp)
 615:	eb 24                	jmp    63b <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 617:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61a:	8b 00                	mov    (%eax),%eax
 61c:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 61f:	72 12                	jb     633 <free+0x35>
 621:	8b 45 f8             	mov    -0x8(%ebp),%eax
 624:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 627:	77 24                	ja     64d <free+0x4f>
 629:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62c:	8b 00                	mov    (%eax),%eax
 62e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 631:	72 1a                	jb     64d <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 633:	8b 45 fc             	mov    -0x4(%ebp),%eax
 636:	8b 00                	mov    (%eax),%eax
 638:	89 45 fc             	mov    %eax,-0x4(%ebp)
 63b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 641:	76 d4                	jbe    617 <free+0x19>
 643:	8b 45 fc             	mov    -0x4(%ebp),%eax
 646:	8b 00                	mov    (%eax),%eax
 648:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 64b:	73 ca                	jae    617 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 64d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 650:	8b 40 04             	mov    0x4(%eax),%eax
 653:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 65a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65d:	01 c2                	add    %eax,%edx
 65f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 662:	8b 00                	mov    (%eax),%eax
 664:	39 c2                	cmp    %eax,%edx
 666:	75 24                	jne    68c <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 668:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66b:	8b 50 04             	mov    0x4(%eax),%edx
 66e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 671:	8b 00                	mov    (%eax),%eax
 673:	8b 40 04             	mov    0x4(%eax),%eax
 676:	01 c2                	add    %eax,%edx
 678:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 67e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 681:	8b 00                	mov    (%eax),%eax
 683:	8b 10                	mov    (%eax),%edx
 685:	8b 45 f8             	mov    -0x8(%ebp),%eax
 688:	89 10                	mov    %edx,(%eax)
 68a:	eb 0a                	jmp    696 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 68c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68f:	8b 10                	mov    (%eax),%edx
 691:	8b 45 f8             	mov    -0x8(%ebp),%eax
 694:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 696:	8b 45 fc             	mov    -0x4(%ebp),%eax
 699:	8b 40 04             	mov    0x4(%eax),%eax
 69c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a6:	01 d0                	add    %edx,%eax
 6a8:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6ab:	75 20                	jne    6cd <free+0xcf>
    p->s.size += bp->s.size;
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	8b 50 04             	mov    0x4(%eax),%edx
 6b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b6:	8b 40 04             	mov    0x4(%eax),%eax
 6b9:	01 c2                	add    %eax,%edx
 6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6be:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c4:	8b 10                	mov    (%eax),%edx
 6c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c9:	89 10                	mov    %edx,(%eax)
 6cb:	eb 08                	jmp    6d5 <free+0xd7>
  } else
    p->s.ptr = bp;
 6cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6d3:	89 10                	mov    %edx,(%eax)
  freep = p;
 6d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d8:	a3 ac 0a 00 00       	mov    %eax,0xaac
}
 6dd:	90                   	nop
 6de:	c9                   	leave  
 6df:	c3                   	ret    

000006e0 <morecore>:

static Header*
morecore(uint nu)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6e6:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6ed:	77 07                	ja     6f6 <morecore+0x16>
    nu = 4096;
 6ef:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6f6:	8b 45 08             	mov    0x8(%ebp),%eax
 6f9:	c1 e0 03             	shl    $0x3,%eax
 6fc:	83 ec 0c             	sub    $0xc,%esp
 6ff:	50                   	push   %eax
 700:	e8 7d fc ff ff       	call   382 <sbrk>
 705:	83 c4 10             	add    $0x10,%esp
 708:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 70b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 70f:	75 07                	jne    718 <morecore+0x38>
    return 0;
 711:	b8 00 00 00 00       	mov    $0x0,%eax
 716:	eb 26                	jmp    73e <morecore+0x5e>
  hp = (Header*)p;
 718:	8b 45 f4             	mov    -0xc(%ebp),%eax
 71b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 71e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 721:	8b 55 08             	mov    0x8(%ebp),%edx
 724:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 727:	8b 45 f0             	mov    -0x10(%ebp),%eax
 72a:	83 c0 08             	add    $0x8,%eax
 72d:	83 ec 0c             	sub    $0xc,%esp
 730:	50                   	push   %eax
 731:	e8 c8 fe ff ff       	call   5fe <free>
 736:	83 c4 10             	add    $0x10,%esp
  return freep;
 739:	a1 ac 0a 00 00       	mov    0xaac,%eax
}
 73e:	c9                   	leave  
 73f:	c3                   	ret    

00000740 <malloc>:

void*
malloc(uint nbytes)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 746:	8b 45 08             	mov    0x8(%ebp),%eax
 749:	83 c0 07             	add    $0x7,%eax
 74c:	c1 e8 03             	shr    $0x3,%eax
 74f:	83 c0 01             	add    $0x1,%eax
 752:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 755:	a1 ac 0a 00 00       	mov    0xaac,%eax
 75a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 75d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 761:	75 23                	jne    786 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 763:	c7 45 f0 a4 0a 00 00 	movl   $0xaa4,-0x10(%ebp)
 76a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76d:	a3 ac 0a 00 00       	mov    %eax,0xaac
 772:	a1 ac 0a 00 00       	mov    0xaac,%eax
 777:	a3 a4 0a 00 00       	mov    %eax,0xaa4
    base.s.size = 0;
 77c:	c7 05 a8 0a 00 00 00 	movl   $0x0,0xaa8
 783:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 786:	8b 45 f0             	mov    -0x10(%ebp),%eax
 789:	8b 00                	mov    (%eax),%eax
 78b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 78e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 791:	8b 40 04             	mov    0x4(%eax),%eax
 794:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 797:	77 4d                	ja     7e6 <malloc+0xa6>
      if(p->s.size == nunits)
 799:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79c:	8b 40 04             	mov    0x4(%eax),%eax
 79f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7a2:	75 0c                	jne    7b0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a7:	8b 10                	mov    (%eax),%edx
 7a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ac:	89 10                	mov    %edx,(%eax)
 7ae:	eb 26                	jmp    7d6 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b3:	8b 40 04             	mov    0x4(%eax),%eax
 7b6:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7b9:	89 c2                	mov    %eax,%edx
 7bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7be:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c4:	8b 40 04             	mov    0x4(%eax),%eax
 7c7:	c1 e0 03             	shl    $0x3,%eax
 7ca:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d0:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7d3:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d9:	a3 ac 0a 00 00       	mov    %eax,0xaac
      return (void*)(p + 1);
 7de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e1:	83 c0 08             	add    $0x8,%eax
 7e4:	eb 3b                	jmp    821 <malloc+0xe1>
    }
    if(p == freep)
 7e6:	a1 ac 0a 00 00       	mov    0xaac,%eax
 7eb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7ee:	75 1e                	jne    80e <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7f0:	83 ec 0c             	sub    $0xc,%esp
 7f3:	ff 75 ec             	pushl  -0x14(%ebp)
 7f6:	e8 e5 fe ff ff       	call   6e0 <morecore>
 7fb:	83 c4 10             	add    $0x10,%esp
 7fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
 801:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 805:	75 07                	jne    80e <malloc+0xce>
        return 0;
 807:	b8 00 00 00 00       	mov    $0x0,%eax
 80c:	eb 13                	jmp    821 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 811:	89 45 f0             	mov    %eax,-0x10(%ebp)
 814:	8b 45 f4             	mov    -0xc(%ebp),%eax
 817:	8b 00                	mov    (%eax),%eax
 819:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 81c:	e9 6d ff ff ff       	jmp    78e <malloc+0x4e>
  }
}
 821:	c9                   	leave  
 822:	c3                   	ret    
