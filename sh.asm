
_sh:     formato de ficheiro elf32-i386


Desmontagem da secção .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 cc 0e 00 00       	call   edd <exit>
  
  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 34 14 00 00 	mov    0x1434(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 08 14 00 00       	push   $0x1408
      2c:	e8 6b 03 00 00       	call   39c <panic>
      31:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      34:	8b 45 08             	mov    0x8(%ebp),%eax
      37:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ecmd->argv[0] == 0)
      3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3d:	8b 40 04             	mov    0x4(%eax),%eax
      40:	85 c0                	test   %eax,%eax
      42:	75 05                	jne    49 <runcmd+0x49>
      exit();
      44:	e8 94 0e 00 00       	call   edd <exit>
    exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 b6 0e 00 00       	call   f15 <exec>
      5f:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 f4             	mov    -0xc(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 0f 14 00 00       	push   $0x140f
      71:	6a 02                	push   $0x2
      73:	e8 d8 0f 00 00       	call   1050 <printf>
      78:	83 c4 10             	add    $0x10,%esp
    break;
      7b:	e9 c6 01 00 00       	jmp    246 <runcmd+0x246>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(rcmd->fd);
      86:	8b 45 f0             	mov    -0x10(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	50                   	push   %eax
      90:	e8 70 0e 00 00       	call   f05 <close>
      95:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      98:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 6f 0e 00 00       	call   f1d <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 1f 14 00 00       	push   $0x141f
      c4:	6a 02                	push   $0x2
      c6:	e8 85 0f 00 00       	call   1050 <printf>
      cb:	83 c4 10             	add    $0x10,%esp
      exit();
      ce:	e8 0a 0e 00 00       	call   edd <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	50                   	push   %eax
      dd:	e8 1e ff ff ff       	call   0 <runcmd>
      e2:	83 c4 10             	add    $0x10,%esp
    break;
      e5:	e9 5c 01 00 00       	jmp    246 <runcmd+0x246>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      ea:	8b 45 08             	mov    0x8(%ebp),%eax
      ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fork1() == 0)
      f0:	e8 c7 02 00 00       	call   3bc <fork1>
      f5:	85 c0                	test   %eax,%eax
      f7:	75 12                	jne    10b <runcmd+0x10b>
      runcmd(lcmd->left);
      f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
      fc:	8b 40 04             	mov    0x4(%eax),%eax
      ff:	83 ec 0c             	sub    $0xc,%esp
     102:	50                   	push   %eax
     103:	e8 f8 fe ff ff       	call   0 <runcmd>
     108:	83 c4 10             	add    $0x10,%esp
    wait();
     10b:	e8 d5 0d 00 00       	call   ee5 <wait>
    runcmd(lcmd->right);
     110:	8b 45 ec             	mov    -0x14(%ebp),%eax
     113:	8b 40 08             	mov    0x8(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
    break;
     122:	e9 1f 01 00 00       	jmp    246 <runcmd+0x246>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     127:	8b 45 08             	mov    0x8(%ebp),%eax
     12a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pipe(p) < 0)
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	8d 45 dc             	lea    -0x24(%ebp),%eax
     133:	50                   	push   %eax
     134:	e8 b4 0d 00 00       	call   eed <pipe>
     139:	83 c4 10             	add    $0x10,%esp
     13c:	85 c0                	test   %eax,%eax
     13e:	79 10                	jns    150 <runcmd+0x150>
      panic("pipe");
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 2f 14 00 00       	push   $0x142f
     148:	e8 4f 02 00 00       	call   39c <panic>
     14d:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     150:	e8 67 02 00 00       	call   3bc <fork1>
     155:	85 c0                	test   %eax,%eax
     157:	75 4c                	jne    1a5 <runcmd+0x1a5>
      close(1);
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	6a 01                	push   $0x1
     15e:	e8 a2 0d 00 00       	call   f05 <close>
     163:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     166:	8b 45 e0             	mov    -0x20(%ebp),%eax
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	50                   	push   %eax
     16d:	e8 e3 0d 00 00       	call   f55 <dup>
     172:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     175:	8b 45 dc             	mov    -0x24(%ebp),%eax
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 84 0d 00 00       	call   f05 <close>
     181:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     184:	8b 45 e0             	mov    -0x20(%ebp),%eax
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	50                   	push   %eax
     18b:	e8 75 0d 00 00       	call   f05 <close>
     190:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     193:	8b 45 e8             	mov    -0x18(%ebp),%eax
     196:	8b 40 04             	mov    0x4(%eax),%eax
     199:	83 ec 0c             	sub    $0xc,%esp
     19c:	50                   	push   %eax
     19d:	e8 5e fe ff ff       	call   0 <runcmd>
     1a2:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
     1a5:	e8 12 02 00 00       	call   3bc <fork1>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	75 4c                	jne    1fa <runcmd+0x1fa>
      close(0);
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	6a 00                	push   $0x0
     1b3:	e8 4d 0d 00 00       	call   f05 <close>
     1b8:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	50                   	push   %eax
     1c2:	e8 8e 0d 00 00       	call   f55 <dup>
     1c7:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	50                   	push   %eax
     1d1:	e8 2f 0d 00 00       	call   f05 <close>
     1d6:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1dc:	83 ec 0c             	sub    $0xc,%esp
     1df:	50                   	push   %eax
     1e0:	e8 20 0d 00 00       	call   f05 <close>
     1e5:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     1e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     1eb:	8b 40 08             	mov    0x8(%eax),%eax
     1ee:	83 ec 0c             	sub    $0xc,%esp
     1f1:	50                   	push   %eax
     1f2:	e8 09 fe ff ff       	call   0 <runcmd>
     1f7:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
     1fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1fd:	83 ec 0c             	sub    $0xc,%esp
     200:	50                   	push   %eax
     201:	e8 ff 0c 00 00       	call   f05 <close>
     206:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     209:	8b 45 e0             	mov    -0x20(%ebp),%eax
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	50                   	push   %eax
     210:	e8 f0 0c 00 00       	call   f05 <close>
     215:	83 c4 10             	add    $0x10,%esp
    wait();
     218:	e8 c8 0c 00 00       	call   ee5 <wait>
    wait();
     21d:	e8 c3 0c 00 00       	call   ee5 <wait>
    break;
     222:	eb 22                	jmp    246 <runcmd+0x246>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     224:	8b 45 08             	mov    0x8(%ebp),%eax
     227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0)
     22a:	e8 8d 01 00 00       	call   3bc <fork1>
     22f:	85 c0                	test   %eax,%eax
     231:	75 12                	jne    245 <runcmd+0x245>
      runcmd(bcmd->cmd);
     233:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     236:	8b 40 04             	mov    0x4(%eax),%eax
     239:	83 ec 0c             	sub    $0xc,%esp
     23c:	50                   	push   %eax
     23d:	e8 be fd ff ff       	call   0 <runcmd>
     242:	83 c4 10             	add    $0x10,%esp
    break;
     245:	90                   	nop
  }
  exit();
     246:	e8 92 0c 00 00       	call   edd <exit>

0000024b <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     24b:	55                   	push   %ebp
     24c:	89 e5                	mov    %esp,%ebp
     24e:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
     251:	83 ec 08             	sub    $0x8,%esp
     254:	68 4c 14 00 00       	push   $0x144c
     259:	6a 02                	push   $0x2
     25b:	e8 f0 0d 00 00       	call   1050 <printf>
     260:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     263:	8b 45 0c             	mov    0xc(%ebp),%eax
     266:	83 ec 04             	sub    $0x4,%esp
     269:	50                   	push   %eax
     26a:	6a 00                	push   $0x0
     26c:	ff 75 08             	pushl  0x8(%ebp)
     26f:	e8 ce 0a 00 00       	call   d42 <memset>
     274:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     277:	83 ec 08             	sub    $0x8,%esp
     27a:	ff 75 0c             	pushl  0xc(%ebp)
     27d:	ff 75 08             	pushl  0x8(%ebp)
     280:	e8 0a 0b 00 00       	call   d8f <gets>
     285:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     288:	8b 45 08             	mov    0x8(%ebp),%eax
     28b:	0f b6 00             	movzbl (%eax),%eax
     28e:	84 c0                	test   %al,%al
     290:	75 07                	jne    299 <getcmd+0x4e>
    return -1;
     292:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     297:	eb 05                	jmp    29e <getcmd+0x53>
  return 0;
     299:	b8 00 00 00 00       	mov    $0x0,%eax
}
     29e:	c9                   	leave  
     29f:	c3                   	ret    

000002a0 <main>:

int
main(void)
{
     2a0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     2a4:	83 e4 f0             	and    $0xfffffff0,%esp
     2a7:	ff 71 fc             	pushl  -0x4(%ecx)
     2aa:	55                   	push   %ebp
     2ab:	89 e5                	mov    %esp,%ebp
     2ad:	51                   	push   %ecx
     2ae:	83 ec 14             	sub    $0x14,%esp
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     2b1:	eb 16                	jmp    2c9 <main+0x29>
    if(fd >= 3){
     2b3:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
     2b7:	7e 10                	jle    2c9 <main+0x29>
      close(fd);
     2b9:	83 ec 0c             	sub    $0xc,%esp
     2bc:	ff 75 f4             	pushl  -0xc(%ebp)
     2bf:	e8 41 0c 00 00       	call   f05 <close>
     2c4:	83 c4 10             	add    $0x10,%esp
      break;
     2c7:	eb 1b                	jmp    2e4 <main+0x44>
  while((fd = open("console", O_RDWR)) >= 0){
     2c9:	83 ec 08             	sub    $0x8,%esp
     2cc:	6a 02                	push   $0x2
     2ce:	68 4f 14 00 00       	push   $0x144f
     2d3:	e8 45 0c 00 00       	call   f1d <open>
     2d8:	83 c4 10             	add    $0x10,%esp
     2db:	89 45 f4             	mov    %eax,-0xc(%ebp)
     2de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2e2:	79 cf                	jns    2b3 <main+0x13>
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     2e4:	e9 94 00 00 00       	jmp    37d <main+0xdd>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2e9:	0f b6 05 c0 19 00 00 	movzbl 0x19c0,%eax
     2f0:	3c 63                	cmp    $0x63,%al
     2f2:	75 5f                	jne    353 <main+0xb3>
     2f4:	0f b6 05 c1 19 00 00 	movzbl 0x19c1,%eax
     2fb:	3c 64                	cmp    $0x64,%al
     2fd:	75 54                	jne    353 <main+0xb3>
     2ff:	0f b6 05 c2 19 00 00 	movzbl 0x19c2,%eax
     306:	3c 20                	cmp    $0x20,%al
     308:	75 49                	jne    353 <main+0xb3>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     30a:	83 ec 0c             	sub    $0xc,%esp
     30d:	68 c0 19 00 00       	push   $0x19c0
     312:	e8 04 0a 00 00       	call   d1b <strlen>
     317:	83 c4 10             	add    $0x10,%esp
     31a:	83 e8 01             	sub    $0x1,%eax
     31d:	c6 80 c0 19 00 00 00 	movb   $0x0,0x19c0(%eax)
      if(chdir(buf+3) < 0)
     324:	b8 c3 19 00 00       	mov    $0x19c3,%eax
     329:	83 ec 0c             	sub    $0xc,%esp
     32c:	50                   	push   %eax
     32d:	e8 1b 0c 00 00       	call   f4d <chdir>
     332:	83 c4 10             	add    $0x10,%esp
     335:	85 c0                	test   %eax,%eax
     337:	79 44                	jns    37d <main+0xdd>
        printf(2, "cannot cd %s\n", buf+3);
     339:	b8 c3 19 00 00       	mov    $0x19c3,%eax
     33e:	83 ec 04             	sub    $0x4,%esp
     341:	50                   	push   %eax
     342:	68 57 14 00 00       	push   $0x1457
     347:	6a 02                	push   $0x2
     349:	e8 02 0d 00 00       	call   1050 <printf>
     34e:	83 c4 10             	add    $0x10,%esp
      continue;
     351:	eb 2a                	jmp    37d <main+0xdd>
    }
    if(fork1() == 0)
     353:	e8 64 00 00 00       	call   3bc <fork1>
     358:	85 c0                	test   %eax,%eax
     35a:	75 1c                	jne    378 <main+0xd8>
      runcmd(parsecmd(buf));
     35c:	83 ec 0c             	sub    $0xc,%esp
     35f:	68 c0 19 00 00       	push   $0x19c0
     364:	e8 b3 03 00 00       	call   71c <parsecmd>
     369:	83 c4 10             	add    $0x10,%esp
     36c:	83 ec 0c             	sub    $0xc,%esp
     36f:	50                   	push   %eax
     370:	e8 8b fc ff ff       	call   0 <runcmd>
     375:	83 c4 10             	add    $0x10,%esp
    wait();
     378:	e8 68 0b 00 00       	call   ee5 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     37d:	83 ec 08             	sub    $0x8,%esp
     380:	6a 64                	push   $0x64
     382:	68 c0 19 00 00       	push   $0x19c0
     387:	e8 bf fe ff ff       	call   24b <getcmd>
     38c:	83 c4 10             	add    $0x10,%esp
     38f:	85 c0                	test   %eax,%eax
     391:	0f 89 52 ff ff ff    	jns    2e9 <main+0x49>
  }
  exit();
     397:	e8 41 0b 00 00       	call   edd <exit>

0000039c <panic>:
}

void
panic(char *s)
{
     39c:	55                   	push   %ebp
     39d:	89 e5                	mov    %esp,%ebp
     39f:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     3a2:	83 ec 04             	sub    $0x4,%esp
     3a5:	ff 75 08             	pushl  0x8(%ebp)
     3a8:	68 65 14 00 00       	push   $0x1465
     3ad:	6a 02                	push   $0x2
     3af:	e8 9c 0c 00 00       	call   1050 <printf>
     3b4:	83 c4 10             	add    $0x10,%esp
  exit();
     3b7:	e8 21 0b 00 00       	call   edd <exit>

000003bc <fork1>:
}

int
fork1(void)
{
     3bc:	55                   	push   %ebp
     3bd:	89 e5                	mov    %esp,%ebp
     3bf:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork(0);
     3c2:	83 ec 0c             	sub    $0xc,%esp
     3c5:	6a 00                	push   $0x0
     3c7:	e8 09 0b 00 00       	call   ed5 <fork>
     3cc:	83 c4 10             	add    $0x10,%esp
     3cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     3d2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     3d6:	75 10                	jne    3e8 <fork1+0x2c>
    panic("fork");
     3d8:	83 ec 0c             	sub    $0xc,%esp
     3db:	68 69 14 00 00       	push   $0x1469
     3e0:	e8 b7 ff ff ff       	call   39c <panic>
     3e5:	83 c4 10             	add    $0x10,%esp
  return pid;
     3e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3eb:	c9                   	leave  
     3ec:	c3                   	ret    

000003ed <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3ed:	55                   	push   %ebp
     3ee:	89 e5                	mov    %esp,%ebp
     3f0:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3f3:	83 ec 0c             	sub    $0xc,%esp
     3f6:	6a 54                	push   $0x54
     3f8:	e8 26 0f 00 00       	call   1323 <malloc>
     3fd:	83 c4 10             	add    $0x10,%esp
     400:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     403:	83 ec 04             	sub    $0x4,%esp
     406:	6a 54                	push   $0x54
     408:	6a 00                	push   $0x0
     40a:	ff 75 f4             	pushl  -0xc(%ebp)
     40d:	e8 30 09 00 00       	call   d42 <memset>
     412:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     415:	8b 45 f4             	mov    -0xc(%ebp),%eax
     418:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     41e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     421:	c9                   	leave  
     422:	c3                   	ret    

00000423 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     423:	55                   	push   %ebp
     424:	89 e5                	mov    %esp,%ebp
     426:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     429:	83 ec 0c             	sub    $0xc,%esp
     42c:	6a 18                	push   $0x18
     42e:	e8 f0 0e 00 00       	call   1323 <malloc>
     433:	83 c4 10             	add    $0x10,%esp
     436:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     439:	83 ec 04             	sub    $0x4,%esp
     43c:	6a 18                	push   $0x18
     43e:	6a 00                	push   $0x0
     440:	ff 75 f4             	pushl  -0xc(%ebp)
     443:	e8 fa 08 00 00       	call   d42 <memset>
     448:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     44b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     44e:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     454:	8b 45 f4             	mov    -0xc(%ebp),%eax
     457:	8b 55 08             	mov    0x8(%ebp),%edx
     45a:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     45d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     460:	8b 55 0c             	mov    0xc(%ebp),%edx
     463:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     466:	8b 45 f4             	mov    -0xc(%ebp),%eax
     469:	8b 55 10             	mov    0x10(%ebp),%edx
     46c:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     46f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     472:	8b 55 14             	mov    0x14(%ebp),%edx
     475:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     478:	8b 45 f4             	mov    -0xc(%ebp),%eax
     47b:	8b 55 18             	mov    0x18(%ebp),%edx
     47e:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     481:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     484:	c9                   	leave  
     485:	c3                   	ret    

00000486 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     486:	55                   	push   %ebp
     487:	89 e5                	mov    %esp,%ebp
     489:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     48c:	83 ec 0c             	sub    $0xc,%esp
     48f:	6a 0c                	push   $0xc
     491:	e8 8d 0e 00 00       	call   1323 <malloc>
     496:	83 c4 10             	add    $0x10,%esp
     499:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     49c:	83 ec 04             	sub    $0x4,%esp
     49f:	6a 0c                	push   $0xc
     4a1:	6a 00                	push   $0x0
     4a3:	ff 75 f4             	pushl  -0xc(%ebp)
     4a6:	e8 97 08 00 00       	call   d42 <memset>
     4ab:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     4ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4b1:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     4b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4ba:	8b 55 08             	mov    0x8(%ebp),%edx
     4bd:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     4c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4c3:	8b 55 0c             	mov    0xc(%ebp),%edx
     4c6:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     4c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4cc:	c9                   	leave  
     4cd:	c3                   	ret    

000004ce <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4ce:	55                   	push   %ebp
     4cf:	89 e5                	mov    %esp,%ebp
     4d1:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4d4:	83 ec 0c             	sub    $0xc,%esp
     4d7:	6a 0c                	push   $0xc
     4d9:	e8 45 0e 00 00       	call   1323 <malloc>
     4de:	83 c4 10             	add    $0x10,%esp
     4e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     4e4:	83 ec 04             	sub    $0x4,%esp
     4e7:	6a 0c                	push   $0xc
     4e9:	6a 00                	push   $0x0
     4eb:	ff 75 f4             	pushl  -0xc(%ebp)
     4ee:	e8 4f 08 00 00       	call   d42 <memset>
     4f3:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     4f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f9:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     4ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     502:	8b 55 08             	mov    0x8(%ebp),%edx
     505:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     508:	8b 45 f4             	mov    -0xc(%ebp),%eax
     50b:	8b 55 0c             	mov    0xc(%ebp),%edx
     50e:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     511:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     514:	c9                   	leave  
     515:	c3                   	ret    

00000516 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     516:	55                   	push   %ebp
     517:	89 e5                	mov    %esp,%ebp
     519:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     51c:	83 ec 0c             	sub    $0xc,%esp
     51f:	6a 08                	push   $0x8
     521:	e8 fd 0d 00 00       	call   1323 <malloc>
     526:	83 c4 10             	add    $0x10,%esp
     529:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     52c:	83 ec 04             	sub    $0x4,%esp
     52f:	6a 08                	push   $0x8
     531:	6a 00                	push   $0x0
     533:	ff 75 f4             	pushl  -0xc(%ebp)
     536:	e8 07 08 00 00       	call   d42 <memset>
     53b:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     53e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     541:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     547:	8b 45 f4             	mov    -0xc(%ebp),%eax
     54a:	8b 55 08             	mov    0x8(%ebp),%edx
     54d:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     550:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     553:	c9                   	leave  
     554:	c3                   	ret    

00000555 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     555:	55                   	push   %ebp
     556:	89 e5                	mov    %esp,%ebp
     558:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     55b:	8b 45 08             	mov    0x8(%ebp),%eax
     55e:	8b 00                	mov    (%eax),%eax
     560:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     563:	eb 04                	jmp    569 <gettoken+0x14>
    s++;
     565:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     569:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     56f:	73 1e                	jae    58f <gettoken+0x3a>
     571:	8b 45 f4             	mov    -0xc(%ebp),%eax
     574:	0f b6 00             	movzbl (%eax),%eax
     577:	0f be c0             	movsbl %al,%eax
     57a:	83 ec 08             	sub    $0x8,%esp
     57d:	50                   	push   %eax
     57e:	68 80 19 00 00       	push   $0x1980
     583:	e8 d4 07 00 00       	call   d5c <strchr>
     588:	83 c4 10             	add    $0x10,%esp
     58b:	85 c0                	test   %eax,%eax
     58d:	75 d6                	jne    565 <gettoken+0x10>
  if(q)
     58f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     593:	74 08                	je     59d <gettoken+0x48>
    *q = s;
     595:	8b 45 10             	mov    0x10(%ebp),%eax
     598:	8b 55 f4             	mov    -0xc(%ebp),%edx
     59b:	89 10                	mov    %edx,(%eax)
  ret = *s;
     59d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a0:	0f b6 00             	movzbl (%eax),%eax
     5a3:	0f be c0             	movsbl %al,%eax
     5a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     5a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5ac:	0f b6 00             	movzbl (%eax),%eax
     5af:	0f be c0             	movsbl %al,%eax
     5b2:	83 f8 29             	cmp    $0x29,%eax
     5b5:	7f 14                	jg     5cb <gettoken+0x76>
     5b7:	83 f8 28             	cmp    $0x28,%eax
     5ba:	7d 28                	jge    5e4 <gettoken+0x8f>
     5bc:	85 c0                	test   %eax,%eax
     5be:	0f 84 94 00 00 00    	je     658 <gettoken+0x103>
     5c4:	83 f8 26             	cmp    $0x26,%eax
     5c7:	74 1b                	je     5e4 <gettoken+0x8f>
     5c9:	eb 3a                	jmp    605 <gettoken+0xb0>
     5cb:	83 f8 3e             	cmp    $0x3e,%eax
     5ce:	74 1a                	je     5ea <gettoken+0x95>
     5d0:	83 f8 3e             	cmp    $0x3e,%eax
     5d3:	7f 0a                	jg     5df <gettoken+0x8a>
     5d5:	83 e8 3b             	sub    $0x3b,%eax
     5d8:	83 f8 01             	cmp    $0x1,%eax
     5db:	77 28                	ja     605 <gettoken+0xb0>
     5dd:	eb 05                	jmp    5e4 <gettoken+0x8f>
     5df:	83 f8 7c             	cmp    $0x7c,%eax
     5e2:	75 21                	jne    605 <gettoken+0xb0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     5e4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     5e8:	eb 75                	jmp    65f <gettoken+0x10a>
  case '>':
    s++;
     5ea:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     5ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f1:	0f b6 00             	movzbl (%eax),%eax
     5f4:	3c 3e                	cmp    $0x3e,%al
     5f6:	75 63                	jne    65b <gettoken+0x106>
      ret = '+';
     5f8:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     5ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     603:	eb 56                	jmp    65b <gettoken+0x106>
  default:
    ret = 'a';
     605:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     60c:	eb 04                	jmp    612 <gettoken+0xbd>
      s++;
     60e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     612:	8b 45 f4             	mov    -0xc(%ebp),%eax
     615:	3b 45 0c             	cmp    0xc(%ebp),%eax
     618:	73 44                	jae    65e <gettoken+0x109>
     61a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     61d:	0f b6 00             	movzbl (%eax),%eax
     620:	0f be c0             	movsbl %al,%eax
     623:	83 ec 08             	sub    $0x8,%esp
     626:	50                   	push   %eax
     627:	68 80 19 00 00       	push   $0x1980
     62c:	e8 2b 07 00 00       	call   d5c <strchr>
     631:	83 c4 10             	add    $0x10,%esp
     634:	85 c0                	test   %eax,%eax
     636:	75 26                	jne    65e <gettoken+0x109>
     638:	8b 45 f4             	mov    -0xc(%ebp),%eax
     63b:	0f b6 00             	movzbl (%eax),%eax
     63e:	0f be c0             	movsbl %al,%eax
     641:	83 ec 08             	sub    $0x8,%esp
     644:	50                   	push   %eax
     645:	68 88 19 00 00       	push   $0x1988
     64a:	e8 0d 07 00 00       	call   d5c <strchr>
     64f:	83 c4 10             	add    $0x10,%esp
     652:	85 c0                	test   %eax,%eax
     654:	74 b8                	je     60e <gettoken+0xb9>
    break;
     656:	eb 06                	jmp    65e <gettoken+0x109>
    break;
     658:	90                   	nop
     659:	eb 04                	jmp    65f <gettoken+0x10a>
    break;
     65b:	90                   	nop
     65c:	eb 01                	jmp    65f <gettoken+0x10a>
    break;
     65e:	90                   	nop
  }
  if(eq)
     65f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     663:	74 0e                	je     673 <gettoken+0x11e>
    *eq = s;
     665:	8b 45 14             	mov    0x14(%ebp),%eax
     668:	8b 55 f4             	mov    -0xc(%ebp),%edx
     66b:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     66d:	eb 04                	jmp    673 <gettoken+0x11e>
    s++;
     66f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     673:	8b 45 f4             	mov    -0xc(%ebp),%eax
     676:	3b 45 0c             	cmp    0xc(%ebp),%eax
     679:	73 1e                	jae    699 <gettoken+0x144>
     67b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     67e:	0f b6 00             	movzbl (%eax),%eax
     681:	0f be c0             	movsbl %al,%eax
     684:	83 ec 08             	sub    $0x8,%esp
     687:	50                   	push   %eax
     688:	68 80 19 00 00       	push   $0x1980
     68d:	e8 ca 06 00 00       	call   d5c <strchr>
     692:	83 c4 10             	add    $0x10,%esp
     695:	85 c0                	test   %eax,%eax
     697:	75 d6                	jne    66f <gettoken+0x11a>
  *ps = s;
     699:	8b 45 08             	mov    0x8(%ebp),%eax
     69c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     69f:	89 10                	mov    %edx,(%eax)
  return ret;
     6a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     6a4:	c9                   	leave  
     6a5:	c3                   	ret    

000006a6 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     6a6:	55                   	push   %ebp
     6a7:	89 e5                	mov    %esp,%ebp
     6a9:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     6ac:	8b 45 08             	mov    0x8(%ebp),%eax
     6af:	8b 00                	mov    (%eax),%eax
     6b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     6b4:	eb 04                	jmp    6ba <peek+0x14>
    s++;
     6b6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     6ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6bd:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6c0:	73 1e                	jae    6e0 <peek+0x3a>
     6c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6c5:	0f b6 00             	movzbl (%eax),%eax
     6c8:	0f be c0             	movsbl %al,%eax
     6cb:	83 ec 08             	sub    $0x8,%esp
     6ce:	50                   	push   %eax
     6cf:	68 80 19 00 00       	push   $0x1980
     6d4:	e8 83 06 00 00       	call   d5c <strchr>
     6d9:	83 c4 10             	add    $0x10,%esp
     6dc:	85 c0                	test   %eax,%eax
     6de:	75 d6                	jne    6b6 <peek+0x10>
  *ps = s;
     6e0:	8b 45 08             	mov    0x8(%ebp),%eax
     6e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6e6:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     6e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6eb:	0f b6 00             	movzbl (%eax),%eax
     6ee:	84 c0                	test   %al,%al
     6f0:	74 23                	je     715 <peek+0x6f>
     6f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f5:	0f b6 00             	movzbl (%eax),%eax
     6f8:	0f be c0             	movsbl %al,%eax
     6fb:	83 ec 08             	sub    $0x8,%esp
     6fe:	50                   	push   %eax
     6ff:	ff 75 10             	pushl  0x10(%ebp)
     702:	e8 55 06 00 00       	call   d5c <strchr>
     707:	83 c4 10             	add    $0x10,%esp
     70a:	85 c0                	test   %eax,%eax
     70c:	74 07                	je     715 <peek+0x6f>
     70e:	b8 01 00 00 00       	mov    $0x1,%eax
     713:	eb 05                	jmp    71a <peek+0x74>
     715:	b8 00 00 00 00       	mov    $0x0,%eax
}
     71a:	c9                   	leave  
     71b:	c3                   	ret    

0000071c <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     71c:	55                   	push   %ebp
     71d:	89 e5                	mov    %esp,%ebp
     71f:	53                   	push   %ebx
     720:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     723:	8b 5d 08             	mov    0x8(%ebp),%ebx
     726:	8b 45 08             	mov    0x8(%ebp),%eax
     729:	83 ec 0c             	sub    $0xc,%esp
     72c:	50                   	push   %eax
     72d:	e8 e9 05 00 00       	call   d1b <strlen>
     732:	83 c4 10             	add    $0x10,%esp
     735:	01 d8                	add    %ebx,%eax
     737:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     73a:	83 ec 08             	sub    $0x8,%esp
     73d:	ff 75 f4             	pushl  -0xc(%ebp)
     740:	8d 45 08             	lea    0x8(%ebp),%eax
     743:	50                   	push   %eax
     744:	e8 61 00 00 00       	call   7aa <parseline>
     749:	83 c4 10             	add    $0x10,%esp
     74c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     74f:	83 ec 04             	sub    $0x4,%esp
     752:	68 6e 14 00 00       	push   $0x146e
     757:	ff 75 f4             	pushl  -0xc(%ebp)
     75a:	8d 45 08             	lea    0x8(%ebp),%eax
     75d:	50                   	push   %eax
     75e:	e8 43 ff ff ff       	call   6a6 <peek>
     763:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     766:	8b 45 08             	mov    0x8(%ebp),%eax
     769:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     76c:	74 26                	je     794 <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     76e:	8b 45 08             	mov    0x8(%ebp),%eax
     771:	83 ec 04             	sub    $0x4,%esp
     774:	50                   	push   %eax
     775:	68 6f 14 00 00       	push   $0x146f
     77a:	6a 02                	push   $0x2
     77c:	e8 cf 08 00 00       	call   1050 <printf>
     781:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     784:	83 ec 0c             	sub    $0xc,%esp
     787:	68 7e 14 00 00       	push   $0x147e
     78c:	e8 0b fc ff ff       	call   39c <panic>
     791:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     794:	83 ec 0c             	sub    $0xc,%esp
     797:	ff 75 f0             	pushl  -0x10(%ebp)
     79a:	e8 eb 03 00 00       	call   b8a <nulterminate>
     79f:	83 c4 10             	add    $0x10,%esp
  return cmd;
     7a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     7a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7a8:	c9                   	leave  
     7a9:	c3                   	ret    

000007aa <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     7aa:	55                   	push   %ebp
     7ab:	89 e5                	mov    %esp,%ebp
     7ad:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     7b0:	83 ec 08             	sub    $0x8,%esp
     7b3:	ff 75 0c             	pushl  0xc(%ebp)
     7b6:	ff 75 08             	pushl  0x8(%ebp)
     7b9:	e8 99 00 00 00       	call   857 <parsepipe>
     7be:	83 c4 10             	add    $0x10,%esp
     7c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     7c4:	eb 23                	jmp    7e9 <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     7c6:	6a 00                	push   $0x0
     7c8:	6a 00                	push   $0x0
     7ca:	ff 75 0c             	pushl  0xc(%ebp)
     7cd:	ff 75 08             	pushl  0x8(%ebp)
     7d0:	e8 80 fd ff ff       	call   555 <gettoken>
     7d5:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     7d8:	83 ec 0c             	sub    $0xc,%esp
     7db:	ff 75 f4             	pushl  -0xc(%ebp)
     7de:	e8 33 fd ff ff       	call   516 <backcmd>
     7e3:	83 c4 10             	add    $0x10,%esp
     7e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     7e9:	83 ec 04             	sub    $0x4,%esp
     7ec:	68 85 14 00 00       	push   $0x1485
     7f1:	ff 75 0c             	pushl  0xc(%ebp)
     7f4:	ff 75 08             	pushl  0x8(%ebp)
     7f7:	e8 aa fe ff ff       	call   6a6 <peek>
     7fc:	83 c4 10             	add    $0x10,%esp
     7ff:	85 c0                	test   %eax,%eax
     801:	75 c3                	jne    7c6 <parseline+0x1c>
  }
  if(peek(ps, es, ";")){
     803:	83 ec 04             	sub    $0x4,%esp
     806:	68 87 14 00 00       	push   $0x1487
     80b:	ff 75 0c             	pushl  0xc(%ebp)
     80e:	ff 75 08             	pushl  0x8(%ebp)
     811:	e8 90 fe ff ff       	call   6a6 <peek>
     816:	83 c4 10             	add    $0x10,%esp
     819:	85 c0                	test   %eax,%eax
     81b:	74 35                	je     852 <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     81d:	6a 00                	push   $0x0
     81f:	6a 00                	push   $0x0
     821:	ff 75 0c             	pushl  0xc(%ebp)
     824:	ff 75 08             	pushl  0x8(%ebp)
     827:	e8 29 fd ff ff       	call   555 <gettoken>
     82c:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     82f:	83 ec 08             	sub    $0x8,%esp
     832:	ff 75 0c             	pushl  0xc(%ebp)
     835:	ff 75 08             	pushl  0x8(%ebp)
     838:	e8 6d ff ff ff       	call   7aa <parseline>
     83d:	83 c4 10             	add    $0x10,%esp
     840:	83 ec 08             	sub    $0x8,%esp
     843:	50                   	push   %eax
     844:	ff 75 f4             	pushl  -0xc(%ebp)
     847:	e8 82 fc ff ff       	call   4ce <listcmd>
     84c:	83 c4 10             	add    $0x10,%esp
     84f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     852:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     855:	c9                   	leave  
     856:	c3                   	ret    

00000857 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     857:	55                   	push   %ebp
     858:	89 e5                	mov    %esp,%ebp
     85a:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     85d:	83 ec 08             	sub    $0x8,%esp
     860:	ff 75 0c             	pushl  0xc(%ebp)
     863:	ff 75 08             	pushl  0x8(%ebp)
     866:	e8 ec 01 00 00       	call   a57 <parseexec>
     86b:	83 c4 10             	add    $0x10,%esp
     86e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     871:	83 ec 04             	sub    $0x4,%esp
     874:	68 89 14 00 00       	push   $0x1489
     879:	ff 75 0c             	pushl  0xc(%ebp)
     87c:	ff 75 08             	pushl  0x8(%ebp)
     87f:	e8 22 fe ff ff       	call   6a6 <peek>
     884:	83 c4 10             	add    $0x10,%esp
     887:	85 c0                	test   %eax,%eax
     889:	74 35                	je     8c0 <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     88b:	6a 00                	push   $0x0
     88d:	6a 00                	push   $0x0
     88f:	ff 75 0c             	pushl  0xc(%ebp)
     892:	ff 75 08             	pushl  0x8(%ebp)
     895:	e8 bb fc ff ff       	call   555 <gettoken>
     89a:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     89d:	83 ec 08             	sub    $0x8,%esp
     8a0:	ff 75 0c             	pushl  0xc(%ebp)
     8a3:	ff 75 08             	pushl  0x8(%ebp)
     8a6:	e8 ac ff ff ff       	call   857 <parsepipe>
     8ab:	83 c4 10             	add    $0x10,%esp
     8ae:	83 ec 08             	sub    $0x8,%esp
     8b1:	50                   	push   %eax
     8b2:	ff 75 f4             	pushl  -0xc(%ebp)
     8b5:	e8 cc fb ff ff       	call   486 <pipecmd>
     8ba:	83 c4 10             	add    $0x10,%esp
     8bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     8c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     8c3:	c9                   	leave  
     8c4:	c3                   	ret    

000008c5 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     8c5:	55                   	push   %ebp
     8c6:	89 e5                	mov    %esp,%ebp
     8c8:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     8cb:	e9 b6 00 00 00       	jmp    986 <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
     8d0:	6a 00                	push   $0x0
     8d2:	6a 00                	push   $0x0
     8d4:	ff 75 10             	pushl  0x10(%ebp)
     8d7:	ff 75 0c             	pushl  0xc(%ebp)
     8da:	e8 76 fc ff ff       	call   555 <gettoken>
     8df:	83 c4 10             	add    $0x10,%esp
     8e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     8e5:	8d 45 ec             	lea    -0x14(%ebp),%eax
     8e8:	50                   	push   %eax
     8e9:	8d 45 f0             	lea    -0x10(%ebp),%eax
     8ec:	50                   	push   %eax
     8ed:	ff 75 10             	pushl  0x10(%ebp)
     8f0:	ff 75 0c             	pushl  0xc(%ebp)
     8f3:	e8 5d fc ff ff       	call   555 <gettoken>
     8f8:	83 c4 10             	add    $0x10,%esp
     8fb:	83 f8 61             	cmp    $0x61,%eax
     8fe:	74 10                	je     910 <parseredirs+0x4b>
      panic("missing file for redirection");
     900:	83 ec 0c             	sub    $0xc,%esp
     903:	68 8b 14 00 00       	push   $0x148b
     908:	e8 8f fa ff ff       	call   39c <panic>
     90d:	83 c4 10             	add    $0x10,%esp
     910:	83 7d f4 3c          	cmpl   $0x3c,-0xc(%ebp)
     914:	74 0e                	je     924 <parseredirs+0x5f>
     916:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
     91a:	74 27                	je     943 <parseredirs+0x7e>
     91c:	83 7d f4 2b          	cmpl   $0x2b,-0xc(%ebp)
     920:	74 43                	je     965 <parseredirs+0xa0>
     922:	eb 62                	jmp    986 <parseredirs+0xc1>
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     924:	8b 55 ec             	mov    -0x14(%ebp),%edx
     927:	8b 45 f0             	mov    -0x10(%ebp),%eax
     92a:	83 ec 0c             	sub    $0xc,%esp
     92d:	6a 00                	push   $0x0
     92f:	6a 00                	push   $0x0
     931:	52                   	push   %edx
     932:	50                   	push   %eax
     933:	ff 75 08             	pushl  0x8(%ebp)
     936:	e8 e8 fa ff ff       	call   423 <redircmd>
     93b:	83 c4 20             	add    $0x20,%esp
     93e:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     941:	eb 43                	jmp    986 <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     943:	8b 55 ec             	mov    -0x14(%ebp),%edx
     946:	8b 45 f0             	mov    -0x10(%ebp),%eax
     949:	83 ec 0c             	sub    $0xc,%esp
     94c:	6a 01                	push   $0x1
     94e:	68 01 02 00 00       	push   $0x201
     953:	52                   	push   %edx
     954:	50                   	push   %eax
     955:	ff 75 08             	pushl  0x8(%ebp)
     958:	e8 c6 fa ff ff       	call   423 <redircmd>
     95d:	83 c4 20             	add    $0x20,%esp
     960:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     963:	eb 21                	jmp    986 <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     965:	8b 55 ec             	mov    -0x14(%ebp),%edx
     968:	8b 45 f0             	mov    -0x10(%ebp),%eax
     96b:	83 ec 0c             	sub    $0xc,%esp
     96e:	6a 01                	push   $0x1
     970:	68 01 02 00 00       	push   $0x201
     975:	52                   	push   %edx
     976:	50                   	push   %eax
     977:	ff 75 08             	pushl  0x8(%ebp)
     97a:	e8 a4 fa ff ff       	call   423 <redircmd>
     97f:	83 c4 20             	add    $0x20,%esp
     982:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     985:	90                   	nop
  while(peek(ps, es, "<>")){
     986:	83 ec 04             	sub    $0x4,%esp
     989:	68 a8 14 00 00       	push   $0x14a8
     98e:	ff 75 10             	pushl  0x10(%ebp)
     991:	ff 75 0c             	pushl  0xc(%ebp)
     994:	e8 0d fd ff ff       	call   6a6 <peek>
     999:	83 c4 10             	add    $0x10,%esp
     99c:	85 c0                	test   %eax,%eax
     99e:	0f 85 2c ff ff ff    	jne    8d0 <parseredirs+0xb>
    }
  }
  return cmd;
     9a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     9a7:	c9                   	leave  
     9a8:	c3                   	ret    

000009a9 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     9a9:	55                   	push   %ebp
     9aa:	89 e5                	mov    %esp,%ebp
     9ac:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     9af:	83 ec 04             	sub    $0x4,%esp
     9b2:	68 ab 14 00 00       	push   $0x14ab
     9b7:	ff 75 0c             	pushl  0xc(%ebp)
     9ba:	ff 75 08             	pushl  0x8(%ebp)
     9bd:	e8 e4 fc ff ff       	call   6a6 <peek>
     9c2:	83 c4 10             	add    $0x10,%esp
     9c5:	85 c0                	test   %eax,%eax
     9c7:	75 10                	jne    9d9 <parseblock+0x30>
    panic("parseblock");
     9c9:	83 ec 0c             	sub    $0xc,%esp
     9cc:	68 ad 14 00 00       	push   $0x14ad
     9d1:	e8 c6 f9 ff ff       	call   39c <panic>
     9d6:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     9d9:	6a 00                	push   $0x0
     9db:	6a 00                	push   $0x0
     9dd:	ff 75 0c             	pushl  0xc(%ebp)
     9e0:	ff 75 08             	pushl  0x8(%ebp)
     9e3:	e8 6d fb ff ff       	call   555 <gettoken>
     9e8:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     9eb:	83 ec 08             	sub    $0x8,%esp
     9ee:	ff 75 0c             	pushl  0xc(%ebp)
     9f1:	ff 75 08             	pushl  0x8(%ebp)
     9f4:	e8 b1 fd ff ff       	call   7aa <parseline>
     9f9:	83 c4 10             	add    $0x10,%esp
     9fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     9ff:	83 ec 04             	sub    $0x4,%esp
     a02:	68 b8 14 00 00       	push   $0x14b8
     a07:	ff 75 0c             	pushl  0xc(%ebp)
     a0a:	ff 75 08             	pushl  0x8(%ebp)
     a0d:	e8 94 fc ff ff       	call   6a6 <peek>
     a12:	83 c4 10             	add    $0x10,%esp
     a15:	85 c0                	test   %eax,%eax
     a17:	75 10                	jne    a29 <parseblock+0x80>
    panic("syntax - missing )");
     a19:	83 ec 0c             	sub    $0xc,%esp
     a1c:	68 ba 14 00 00       	push   $0x14ba
     a21:	e8 76 f9 ff ff       	call   39c <panic>
     a26:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     a29:	6a 00                	push   $0x0
     a2b:	6a 00                	push   $0x0
     a2d:	ff 75 0c             	pushl  0xc(%ebp)
     a30:	ff 75 08             	pushl  0x8(%ebp)
     a33:	e8 1d fb ff ff       	call   555 <gettoken>
     a38:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     a3b:	83 ec 04             	sub    $0x4,%esp
     a3e:	ff 75 0c             	pushl  0xc(%ebp)
     a41:	ff 75 08             	pushl  0x8(%ebp)
     a44:	ff 75 f4             	pushl  -0xc(%ebp)
     a47:	e8 79 fe ff ff       	call   8c5 <parseredirs>
     a4c:	83 c4 10             	add    $0x10,%esp
     a4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     a52:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a55:	c9                   	leave  
     a56:	c3                   	ret    

00000a57 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     a57:	55                   	push   %ebp
     a58:	89 e5                	mov    %esp,%ebp
     a5a:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     a5d:	83 ec 04             	sub    $0x4,%esp
     a60:	68 ab 14 00 00       	push   $0x14ab
     a65:	ff 75 0c             	pushl  0xc(%ebp)
     a68:	ff 75 08             	pushl  0x8(%ebp)
     a6b:	e8 36 fc ff ff       	call   6a6 <peek>
     a70:	83 c4 10             	add    $0x10,%esp
     a73:	85 c0                	test   %eax,%eax
     a75:	74 16                	je     a8d <parseexec+0x36>
    return parseblock(ps, es);
     a77:	83 ec 08             	sub    $0x8,%esp
     a7a:	ff 75 0c             	pushl  0xc(%ebp)
     a7d:	ff 75 08             	pushl  0x8(%ebp)
     a80:	e8 24 ff ff ff       	call   9a9 <parseblock>
     a85:	83 c4 10             	add    $0x10,%esp
     a88:	e9 fb 00 00 00       	jmp    b88 <parseexec+0x131>

  ret = execcmd();
     a8d:	e8 5b f9 ff ff       	call   3ed <execcmd>
     a92:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     a95:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a98:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     a9b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     aa2:	83 ec 04             	sub    $0x4,%esp
     aa5:	ff 75 0c             	pushl  0xc(%ebp)
     aa8:	ff 75 08             	pushl  0x8(%ebp)
     aab:	ff 75 f0             	pushl  -0x10(%ebp)
     aae:	e8 12 fe ff ff       	call   8c5 <parseredirs>
     ab3:	83 c4 10             	add    $0x10,%esp
     ab6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     ab9:	e9 87 00 00 00       	jmp    b45 <parseexec+0xee>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     abe:	8d 45 e0             	lea    -0x20(%ebp),%eax
     ac1:	50                   	push   %eax
     ac2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     ac5:	50                   	push   %eax
     ac6:	ff 75 0c             	pushl  0xc(%ebp)
     ac9:	ff 75 08             	pushl  0x8(%ebp)
     acc:	e8 84 fa ff ff       	call   555 <gettoken>
     ad1:	83 c4 10             	add    $0x10,%esp
     ad4:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ad7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     adb:	0f 84 84 00 00 00    	je     b65 <parseexec+0x10e>
      break;
    if(tok != 'a')
     ae1:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     ae5:	74 10                	je     af7 <parseexec+0xa0>
      panic("syntax");
     ae7:	83 ec 0c             	sub    $0xc,%esp
     aea:	68 7e 14 00 00       	push   $0x147e
     aef:	e8 a8 f8 ff ff       	call   39c <panic>
     af4:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     af7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     afa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     afd:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b00:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     b04:	8b 55 e0             	mov    -0x20(%ebp),%edx
     b07:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b0a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     b0d:	83 c1 08             	add    $0x8,%ecx
     b10:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     b14:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     b18:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     b1c:	7e 10                	jle    b2e <parseexec+0xd7>
      panic("too many args");
     b1e:	83 ec 0c             	sub    $0xc,%esp
     b21:	68 cd 14 00 00       	push   $0x14cd
     b26:	e8 71 f8 ff ff       	call   39c <panic>
     b2b:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     b2e:	83 ec 04             	sub    $0x4,%esp
     b31:	ff 75 0c             	pushl  0xc(%ebp)
     b34:	ff 75 08             	pushl  0x8(%ebp)
     b37:	ff 75 f0             	pushl  -0x10(%ebp)
     b3a:	e8 86 fd ff ff       	call   8c5 <parseredirs>
     b3f:	83 c4 10             	add    $0x10,%esp
     b42:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     b45:	83 ec 04             	sub    $0x4,%esp
     b48:	68 db 14 00 00       	push   $0x14db
     b4d:	ff 75 0c             	pushl  0xc(%ebp)
     b50:	ff 75 08             	pushl  0x8(%ebp)
     b53:	e8 4e fb ff ff       	call   6a6 <peek>
     b58:	83 c4 10             	add    $0x10,%esp
     b5b:	85 c0                	test   %eax,%eax
     b5d:	0f 84 5b ff ff ff    	je     abe <parseexec+0x67>
     b63:	eb 01                	jmp    b66 <parseexec+0x10f>
      break;
     b65:	90                   	nop
  }
  cmd->argv[argc] = 0;
     b66:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b69:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b6c:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     b73:	00 
  cmd->eargv[argc] = 0;
     b74:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b77:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b7a:	83 c2 08             	add    $0x8,%edx
     b7d:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     b84:	00 
  return ret;
     b85:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     b88:	c9                   	leave  
     b89:	c3                   	ret    

00000b8a <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b8a:	55                   	push   %ebp
     b8b:	89 e5                	mov    %esp,%ebp
     b8d:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b90:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     b94:	75 0a                	jne    ba0 <nulterminate+0x16>
    return 0;
     b96:	b8 00 00 00 00       	mov    $0x0,%eax
     b9b:	e9 e4 00 00 00       	jmp    c84 <nulterminate+0xfa>
  
  switch(cmd->type){
     ba0:	8b 45 08             	mov    0x8(%ebp),%eax
     ba3:	8b 00                	mov    (%eax),%eax
     ba5:	83 f8 05             	cmp    $0x5,%eax
     ba8:	0f 87 d3 00 00 00    	ja     c81 <nulterminate+0xf7>
     bae:	8b 04 85 e0 14 00 00 	mov    0x14e0(,%eax,4),%eax
     bb5:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     bb7:	8b 45 08             	mov    0x8(%ebp),%eax
     bba:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     bbd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     bc4:	eb 14                	jmp    bda <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
     bc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bc9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bcc:	83 c2 08             	add    $0x8,%edx
     bcf:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     bd3:	c6 00 00             	movb   $0x0,(%eax)
    for(i=0; ecmd->argv[i]; i++)
     bd6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bda:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bdd:	8b 55 f4             	mov    -0xc(%ebp),%edx
     be0:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     be4:	85 c0                	test   %eax,%eax
     be6:	75 de                	jne    bc6 <nulterminate+0x3c>
    break;
     be8:	e9 94 00 00 00       	jmp    c81 <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     bed:	8b 45 08             	mov    0x8(%ebp),%eax
     bf0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
     bf3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bf6:	8b 40 04             	mov    0x4(%eax),%eax
     bf9:	83 ec 0c             	sub    $0xc,%esp
     bfc:	50                   	push   %eax
     bfd:	e8 88 ff ff ff       	call   b8a <nulterminate>
     c02:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     c05:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c08:	8b 40 0c             	mov    0xc(%eax),%eax
     c0b:	c6 00 00             	movb   $0x0,(%eax)
    break;
     c0e:	eb 71                	jmp    c81 <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     c10:	8b 45 08             	mov    0x8(%ebp),%eax
     c13:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     c16:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c19:	8b 40 04             	mov    0x4(%eax),%eax
     c1c:	83 ec 0c             	sub    $0xc,%esp
     c1f:	50                   	push   %eax
     c20:	e8 65 ff ff ff       	call   b8a <nulterminate>
     c25:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
     c28:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c2b:	8b 40 08             	mov    0x8(%eax),%eax
     c2e:	83 ec 0c             	sub    $0xc,%esp
     c31:	50                   	push   %eax
     c32:	e8 53 ff ff ff       	call   b8a <nulterminate>
     c37:	83 c4 10             	add    $0x10,%esp
    break;
     c3a:	eb 45                	jmp    c81 <nulterminate+0xf7>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     c3c:	8b 45 08             	mov    0x8(%ebp),%eax
     c3f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
     c42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c45:	8b 40 04             	mov    0x4(%eax),%eax
     c48:	83 ec 0c             	sub    $0xc,%esp
     c4b:	50                   	push   %eax
     c4c:	e8 39 ff ff ff       	call   b8a <nulterminate>
     c51:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
     c54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c57:	8b 40 08             	mov    0x8(%eax),%eax
     c5a:	83 ec 0c             	sub    $0xc,%esp
     c5d:	50                   	push   %eax
     c5e:	e8 27 ff ff ff       	call   b8a <nulterminate>
     c63:	83 c4 10             	add    $0x10,%esp
    break;
     c66:	eb 19                	jmp    c81 <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     c68:	8b 45 08             	mov    0x8(%ebp),%eax
     c6b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
     c6e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c71:	8b 40 04             	mov    0x4(%eax),%eax
     c74:	83 ec 0c             	sub    $0xc,%esp
     c77:	50                   	push   %eax
     c78:	e8 0d ff ff ff       	call   b8a <nulterminate>
     c7d:	83 c4 10             	add    $0x10,%esp
    break;
     c80:	90                   	nop
  }
  return cmd;
     c81:	8b 45 08             	mov    0x8(%ebp),%eax
}
     c84:	c9                   	leave  
     c85:	c3                   	ret    

00000c86 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     c86:	55                   	push   %ebp
     c87:	89 e5                	mov    %esp,%ebp
     c89:	57                   	push   %edi
     c8a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     c8b:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c8e:	8b 55 10             	mov    0x10(%ebp),%edx
     c91:	8b 45 0c             	mov    0xc(%ebp),%eax
     c94:	89 cb                	mov    %ecx,%ebx
     c96:	89 df                	mov    %ebx,%edi
     c98:	89 d1                	mov    %edx,%ecx
     c9a:	fc                   	cld    
     c9b:	f3 aa                	rep stos %al,%es:(%edi)
     c9d:	89 ca                	mov    %ecx,%edx
     c9f:	89 fb                	mov    %edi,%ebx
     ca1:	89 5d 08             	mov    %ebx,0x8(%ebp)
     ca4:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     ca7:	90                   	nop
     ca8:	5b                   	pop    %ebx
     ca9:	5f                   	pop    %edi
     caa:	5d                   	pop    %ebp
     cab:	c3                   	ret    

00000cac <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     cac:	55                   	push   %ebp
     cad:	89 e5                	mov    %esp,%ebp
     caf:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     cb2:	8b 45 08             	mov    0x8(%ebp),%eax
     cb5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     cb8:	90                   	nop
     cb9:	8b 55 0c             	mov    0xc(%ebp),%edx
     cbc:	8d 42 01             	lea    0x1(%edx),%eax
     cbf:	89 45 0c             	mov    %eax,0xc(%ebp)
     cc2:	8b 45 08             	mov    0x8(%ebp),%eax
     cc5:	8d 48 01             	lea    0x1(%eax),%ecx
     cc8:	89 4d 08             	mov    %ecx,0x8(%ebp)
     ccb:	0f b6 12             	movzbl (%edx),%edx
     cce:	88 10                	mov    %dl,(%eax)
     cd0:	0f b6 00             	movzbl (%eax),%eax
     cd3:	84 c0                	test   %al,%al
     cd5:	75 e2                	jne    cb9 <strcpy+0xd>
    ;
  return os;
     cd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     cda:	c9                   	leave  
     cdb:	c3                   	ret    

00000cdc <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cdc:	55                   	push   %ebp
     cdd:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     cdf:	eb 08                	jmp    ce9 <strcmp+0xd>
    p++, q++;
     ce1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     ce5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     ce9:	8b 45 08             	mov    0x8(%ebp),%eax
     cec:	0f b6 00             	movzbl (%eax),%eax
     cef:	84 c0                	test   %al,%al
     cf1:	74 10                	je     d03 <strcmp+0x27>
     cf3:	8b 45 08             	mov    0x8(%ebp),%eax
     cf6:	0f b6 10             	movzbl (%eax),%edx
     cf9:	8b 45 0c             	mov    0xc(%ebp),%eax
     cfc:	0f b6 00             	movzbl (%eax),%eax
     cff:	38 c2                	cmp    %al,%dl
     d01:	74 de                	je     ce1 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     d03:	8b 45 08             	mov    0x8(%ebp),%eax
     d06:	0f b6 00             	movzbl (%eax),%eax
     d09:	0f b6 d0             	movzbl %al,%edx
     d0c:	8b 45 0c             	mov    0xc(%ebp),%eax
     d0f:	0f b6 00             	movzbl (%eax),%eax
     d12:	0f b6 c0             	movzbl %al,%eax
     d15:	29 c2                	sub    %eax,%edx
     d17:	89 d0                	mov    %edx,%eax
}
     d19:	5d                   	pop    %ebp
     d1a:	c3                   	ret    

00000d1b <strlen>:

uint
strlen(char *s)
{
     d1b:	55                   	push   %ebp
     d1c:	89 e5                	mov    %esp,%ebp
     d1e:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     d21:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     d28:	eb 04                	jmp    d2e <strlen+0x13>
     d2a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d2e:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d31:	8b 45 08             	mov    0x8(%ebp),%eax
     d34:	01 d0                	add    %edx,%eax
     d36:	0f b6 00             	movzbl (%eax),%eax
     d39:	84 c0                	test   %al,%al
     d3b:	75 ed                	jne    d2a <strlen+0xf>
    ;
  return n;
     d3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     d40:	c9                   	leave  
     d41:	c3                   	ret    

00000d42 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d42:	55                   	push   %ebp
     d43:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     d45:	8b 45 10             	mov    0x10(%ebp),%eax
     d48:	50                   	push   %eax
     d49:	ff 75 0c             	pushl  0xc(%ebp)
     d4c:	ff 75 08             	pushl  0x8(%ebp)
     d4f:	e8 32 ff ff ff       	call   c86 <stosb>
     d54:	83 c4 0c             	add    $0xc,%esp
  return dst;
     d57:	8b 45 08             	mov    0x8(%ebp),%eax
}
     d5a:	c9                   	leave  
     d5b:	c3                   	ret    

00000d5c <strchr>:

char*
strchr(const char *s, char c)
{
     d5c:	55                   	push   %ebp
     d5d:	89 e5                	mov    %esp,%ebp
     d5f:	83 ec 04             	sub    $0x4,%esp
     d62:	8b 45 0c             	mov    0xc(%ebp),%eax
     d65:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     d68:	eb 14                	jmp    d7e <strchr+0x22>
    if(*s == c)
     d6a:	8b 45 08             	mov    0x8(%ebp),%eax
     d6d:	0f b6 00             	movzbl (%eax),%eax
     d70:	38 45 fc             	cmp    %al,-0x4(%ebp)
     d73:	75 05                	jne    d7a <strchr+0x1e>
      return (char*)s;
     d75:	8b 45 08             	mov    0x8(%ebp),%eax
     d78:	eb 13                	jmp    d8d <strchr+0x31>
  for(; *s; s++)
     d7a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d7e:	8b 45 08             	mov    0x8(%ebp),%eax
     d81:	0f b6 00             	movzbl (%eax),%eax
     d84:	84 c0                	test   %al,%al
     d86:	75 e2                	jne    d6a <strchr+0xe>
  return 0;
     d88:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d8d:	c9                   	leave  
     d8e:	c3                   	ret    

00000d8f <gets>:

char*
gets(char *buf, int max)
{
     d8f:	55                   	push   %ebp
     d90:	89 e5                	mov    %esp,%ebp
     d92:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d95:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d9c:	eb 42                	jmp    de0 <gets+0x51>
    cc = read(0, &c, 1);
     d9e:	83 ec 04             	sub    $0x4,%esp
     da1:	6a 01                	push   $0x1
     da3:	8d 45 ef             	lea    -0x11(%ebp),%eax
     da6:	50                   	push   %eax
     da7:	6a 00                	push   $0x0
     da9:	e8 47 01 00 00       	call   ef5 <read>
     dae:	83 c4 10             	add    $0x10,%esp
     db1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     db4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     db8:	7e 33                	jle    ded <gets+0x5e>
      break;
    buf[i++] = c;
     dba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dbd:	8d 50 01             	lea    0x1(%eax),%edx
     dc0:	89 55 f4             	mov    %edx,-0xc(%ebp)
     dc3:	89 c2                	mov    %eax,%edx
     dc5:	8b 45 08             	mov    0x8(%ebp),%eax
     dc8:	01 c2                	add    %eax,%edx
     dca:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     dce:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     dd0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     dd4:	3c 0a                	cmp    $0xa,%al
     dd6:	74 16                	je     dee <gets+0x5f>
     dd8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     ddc:	3c 0d                	cmp    $0xd,%al
     dde:	74 0e                	je     dee <gets+0x5f>
  for(i=0; i+1 < max; ){
     de0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     de3:	83 c0 01             	add    $0x1,%eax
     de6:	39 45 0c             	cmp    %eax,0xc(%ebp)
     de9:	7f b3                	jg     d9e <gets+0xf>
     deb:	eb 01                	jmp    dee <gets+0x5f>
      break;
     ded:	90                   	nop
      break;
  }
  buf[i] = '\0';
     dee:	8b 55 f4             	mov    -0xc(%ebp),%edx
     df1:	8b 45 08             	mov    0x8(%ebp),%eax
     df4:	01 d0                	add    %edx,%eax
     df6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     df9:	8b 45 08             	mov    0x8(%ebp),%eax
}
     dfc:	c9                   	leave  
     dfd:	c3                   	ret    

00000dfe <stat>:

int
stat(char *n, struct stat *st)
{
     dfe:	55                   	push   %ebp
     dff:	89 e5                	mov    %esp,%ebp
     e01:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e04:	83 ec 08             	sub    $0x8,%esp
     e07:	6a 00                	push   $0x0
     e09:	ff 75 08             	pushl  0x8(%ebp)
     e0c:	e8 0c 01 00 00       	call   f1d <open>
     e11:	83 c4 10             	add    $0x10,%esp
     e14:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     e17:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e1b:	79 07                	jns    e24 <stat+0x26>
    return -1;
     e1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e22:	eb 25                	jmp    e49 <stat+0x4b>
  r = fstat(fd, st);
     e24:	83 ec 08             	sub    $0x8,%esp
     e27:	ff 75 0c             	pushl  0xc(%ebp)
     e2a:	ff 75 f4             	pushl  -0xc(%ebp)
     e2d:	e8 03 01 00 00       	call   f35 <fstat>
     e32:	83 c4 10             	add    $0x10,%esp
     e35:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     e38:	83 ec 0c             	sub    $0xc,%esp
     e3b:	ff 75 f4             	pushl  -0xc(%ebp)
     e3e:	e8 c2 00 00 00       	call   f05 <close>
     e43:	83 c4 10             	add    $0x10,%esp
  return r;
     e46:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     e49:	c9                   	leave  
     e4a:	c3                   	ret    

00000e4b <atoi>:

int
atoi(const char *s)
{
     e4b:	55                   	push   %ebp
     e4c:	89 e5                	mov    %esp,%ebp
     e4e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     e51:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     e58:	eb 25                	jmp    e7f <atoi+0x34>
    n = n*10 + *s++ - '0';
     e5a:	8b 55 fc             	mov    -0x4(%ebp),%edx
     e5d:	89 d0                	mov    %edx,%eax
     e5f:	c1 e0 02             	shl    $0x2,%eax
     e62:	01 d0                	add    %edx,%eax
     e64:	01 c0                	add    %eax,%eax
     e66:	89 c1                	mov    %eax,%ecx
     e68:	8b 45 08             	mov    0x8(%ebp),%eax
     e6b:	8d 50 01             	lea    0x1(%eax),%edx
     e6e:	89 55 08             	mov    %edx,0x8(%ebp)
     e71:	0f b6 00             	movzbl (%eax),%eax
     e74:	0f be c0             	movsbl %al,%eax
     e77:	01 c8                	add    %ecx,%eax
     e79:	83 e8 30             	sub    $0x30,%eax
     e7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     e7f:	8b 45 08             	mov    0x8(%ebp),%eax
     e82:	0f b6 00             	movzbl (%eax),%eax
     e85:	3c 2f                	cmp    $0x2f,%al
     e87:	7e 0a                	jle    e93 <atoi+0x48>
     e89:	8b 45 08             	mov    0x8(%ebp),%eax
     e8c:	0f b6 00             	movzbl (%eax),%eax
     e8f:	3c 39                	cmp    $0x39,%al
     e91:	7e c7                	jle    e5a <atoi+0xf>
  return n;
     e93:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e96:	c9                   	leave  
     e97:	c3                   	ret    

00000e98 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     e98:	55                   	push   %ebp
     e99:	89 e5                	mov    %esp,%ebp
     e9b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     e9e:	8b 45 08             	mov    0x8(%ebp),%eax
     ea1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     ea4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     eaa:	eb 17                	jmp    ec3 <memmove+0x2b>
    *dst++ = *src++;
     eac:	8b 55 f8             	mov    -0x8(%ebp),%edx
     eaf:	8d 42 01             	lea    0x1(%edx),%eax
     eb2:	89 45 f8             	mov    %eax,-0x8(%ebp)
     eb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     eb8:	8d 48 01             	lea    0x1(%eax),%ecx
     ebb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     ebe:	0f b6 12             	movzbl (%edx),%edx
     ec1:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     ec3:	8b 45 10             	mov    0x10(%ebp),%eax
     ec6:	8d 50 ff             	lea    -0x1(%eax),%edx
     ec9:	89 55 10             	mov    %edx,0x10(%ebp)
     ecc:	85 c0                	test   %eax,%eax
     ece:	7f dc                	jg     eac <memmove+0x14>
  return vdst;
     ed0:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ed3:	c9                   	leave  
     ed4:	c3                   	ret    

00000ed5 <fork>:
     ed5:	b8 01 00 00 00       	mov    $0x1,%eax
     eda:	cd 40                	int    $0x40
     edc:	c3                   	ret    

00000edd <exit>:
     edd:	b8 02 00 00 00       	mov    $0x2,%eax
     ee2:	cd 40                	int    $0x40
     ee4:	c3                   	ret    

00000ee5 <wait>:
     ee5:	b8 03 00 00 00       	mov    $0x3,%eax
     eea:	cd 40                	int    $0x40
     eec:	c3                   	ret    

00000eed <pipe>:
     eed:	b8 04 00 00 00       	mov    $0x4,%eax
     ef2:	cd 40                	int    $0x40
     ef4:	c3                   	ret    

00000ef5 <read>:
     ef5:	b8 05 00 00 00       	mov    $0x5,%eax
     efa:	cd 40                	int    $0x40
     efc:	c3                   	ret    

00000efd <write>:
     efd:	b8 10 00 00 00       	mov    $0x10,%eax
     f02:	cd 40                	int    $0x40
     f04:	c3                   	ret    

00000f05 <close>:
     f05:	b8 15 00 00 00       	mov    $0x15,%eax
     f0a:	cd 40                	int    $0x40
     f0c:	c3                   	ret    

00000f0d <kill>:
     f0d:	b8 06 00 00 00       	mov    $0x6,%eax
     f12:	cd 40                	int    $0x40
     f14:	c3                   	ret    

00000f15 <exec>:
     f15:	b8 07 00 00 00       	mov    $0x7,%eax
     f1a:	cd 40                	int    $0x40
     f1c:	c3                   	ret    

00000f1d <open>:
     f1d:	b8 0f 00 00 00       	mov    $0xf,%eax
     f22:	cd 40                	int    $0x40
     f24:	c3                   	ret    

00000f25 <mknod>:
     f25:	b8 11 00 00 00       	mov    $0x11,%eax
     f2a:	cd 40                	int    $0x40
     f2c:	c3                   	ret    

00000f2d <unlink>:
     f2d:	b8 12 00 00 00       	mov    $0x12,%eax
     f32:	cd 40                	int    $0x40
     f34:	c3                   	ret    

00000f35 <fstat>:
     f35:	b8 08 00 00 00       	mov    $0x8,%eax
     f3a:	cd 40                	int    $0x40
     f3c:	c3                   	ret    

00000f3d <link>:
     f3d:	b8 13 00 00 00       	mov    $0x13,%eax
     f42:	cd 40                	int    $0x40
     f44:	c3                   	ret    

00000f45 <mkdir>:
     f45:	b8 14 00 00 00       	mov    $0x14,%eax
     f4a:	cd 40                	int    $0x40
     f4c:	c3                   	ret    

00000f4d <chdir>:
     f4d:	b8 09 00 00 00       	mov    $0x9,%eax
     f52:	cd 40                	int    $0x40
     f54:	c3                   	ret    

00000f55 <dup>:
     f55:	b8 0a 00 00 00       	mov    $0xa,%eax
     f5a:	cd 40                	int    $0x40
     f5c:	c3                   	ret    

00000f5d <getpid>:
     f5d:	b8 0b 00 00 00       	mov    $0xb,%eax
     f62:	cd 40                	int    $0x40
     f64:	c3                   	ret    

00000f65 <sbrk>:
     f65:	b8 0c 00 00 00       	mov    $0xc,%eax
     f6a:	cd 40                	int    $0x40
     f6c:	c3                   	ret    

00000f6d <sleep>:
     f6d:	b8 0d 00 00 00       	mov    $0xd,%eax
     f72:	cd 40                	int    $0x40
     f74:	c3                   	ret    

00000f75 <uptime>:
     f75:	b8 0e 00 00 00       	mov    $0xe,%eax
     f7a:	cd 40                	int    $0x40
     f7c:	c3                   	ret    

00000f7d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     f7d:	55                   	push   %ebp
     f7e:	89 e5                	mov    %esp,%ebp
     f80:	83 ec 18             	sub    $0x18,%esp
     f83:	8b 45 0c             	mov    0xc(%ebp),%eax
     f86:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     f89:	83 ec 04             	sub    $0x4,%esp
     f8c:	6a 01                	push   $0x1
     f8e:	8d 45 f4             	lea    -0xc(%ebp),%eax
     f91:	50                   	push   %eax
     f92:	ff 75 08             	pushl  0x8(%ebp)
     f95:	e8 63 ff ff ff       	call   efd <write>
     f9a:	83 c4 10             	add    $0x10,%esp
}
     f9d:	90                   	nop
     f9e:	c9                   	leave  
     f9f:	c3                   	ret    

00000fa0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     fa6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     fad:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     fb1:	74 17                	je     fca <printint+0x2a>
     fb3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     fb7:	79 11                	jns    fca <printint+0x2a>
    neg = 1;
     fb9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc3:	f7 d8                	neg    %eax
     fc5:	89 45 ec             	mov    %eax,-0x14(%ebp)
     fc8:	eb 06                	jmp    fd0 <printint+0x30>
  } else {
    x = xx;
     fca:	8b 45 0c             	mov    0xc(%ebp),%eax
     fcd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     fd0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     fd7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     fda:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fdd:	ba 00 00 00 00       	mov    $0x0,%edx
     fe2:	f7 f1                	div    %ecx
     fe4:	89 d1                	mov    %edx,%ecx
     fe6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fe9:	8d 50 01             	lea    0x1(%eax),%edx
     fec:	89 55 f4             	mov    %edx,-0xc(%ebp)
     fef:	0f b6 91 90 19 00 00 	movzbl 0x1990(%ecx),%edx
     ff6:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     ffa:	8b 4d 10             	mov    0x10(%ebp),%ecx
     ffd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1000:	ba 00 00 00 00       	mov    $0x0,%edx
    1005:	f7 f1                	div    %ecx
    1007:	89 45 ec             	mov    %eax,-0x14(%ebp)
    100a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    100e:	75 c7                	jne    fd7 <printint+0x37>
  if(neg)
    1010:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1014:	74 2d                	je     1043 <printint+0xa3>
    buf[i++] = '-';
    1016:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1019:	8d 50 01             	lea    0x1(%eax),%edx
    101c:	89 55 f4             	mov    %edx,-0xc(%ebp)
    101f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1024:	eb 1d                	jmp    1043 <printint+0xa3>
    putc(fd, buf[i]);
    1026:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1029:	8b 45 f4             	mov    -0xc(%ebp),%eax
    102c:	01 d0                	add    %edx,%eax
    102e:	0f b6 00             	movzbl (%eax),%eax
    1031:	0f be c0             	movsbl %al,%eax
    1034:	83 ec 08             	sub    $0x8,%esp
    1037:	50                   	push   %eax
    1038:	ff 75 08             	pushl  0x8(%ebp)
    103b:	e8 3d ff ff ff       	call   f7d <putc>
    1040:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    1043:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1047:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    104b:	79 d9                	jns    1026 <printint+0x86>
}
    104d:	90                   	nop
    104e:	c9                   	leave  
    104f:	c3                   	ret    

00001050 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1056:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    105d:	8d 45 0c             	lea    0xc(%ebp),%eax
    1060:	83 c0 04             	add    $0x4,%eax
    1063:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1066:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    106d:	e9 59 01 00 00       	jmp    11cb <printf+0x17b>
    c = fmt[i] & 0xff;
    1072:	8b 55 0c             	mov    0xc(%ebp),%edx
    1075:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1078:	01 d0                	add    %edx,%eax
    107a:	0f b6 00             	movzbl (%eax),%eax
    107d:	0f be c0             	movsbl %al,%eax
    1080:	25 ff 00 00 00       	and    $0xff,%eax
    1085:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1088:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    108c:	75 2c                	jne    10ba <printf+0x6a>
      if(c == '%'){
    108e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1092:	75 0c                	jne    10a0 <printf+0x50>
        state = '%';
    1094:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    109b:	e9 27 01 00 00       	jmp    11c7 <printf+0x177>
      } else {
        putc(fd, c);
    10a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10a3:	0f be c0             	movsbl %al,%eax
    10a6:	83 ec 08             	sub    $0x8,%esp
    10a9:	50                   	push   %eax
    10aa:	ff 75 08             	pushl  0x8(%ebp)
    10ad:	e8 cb fe ff ff       	call   f7d <putc>
    10b2:	83 c4 10             	add    $0x10,%esp
    10b5:	e9 0d 01 00 00       	jmp    11c7 <printf+0x177>
      }
    } else if(state == '%'){
    10ba:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    10be:	0f 85 03 01 00 00    	jne    11c7 <printf+0x177>
      if(c == 'd'){
    10c4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    10c8:	75 1e                	jne    10e8 <printf+0x98>
        printint(fd, *ap, 10, 1);
    10ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10cd:	8b 00                	mov    (%eax),%eax
    10cf:	6a 01                	push   $0x1
    10d1:	6a 0a                	push   $0xa
    10d3:	50                   	push   %eax
    10d4:	ff 75 08             	pushl  0x8(%ebp)
    10d7:	e8 c4 fe ff ff       	call   fa0 <printint>
    10dc:	83 c4 10             	add    $0x10,%esp
        ap++;
    10df:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    10e3:	e9 d8 00 00 00       	jmp    11c0 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    10e8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    10ec:	74 06                	je     10f4 <printf+0xa4>
    10ee:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    10f2:	75 1e                	jne    1112 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    10f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10f7:	8b 00                	mov    (%eax),%eax
    10f9:	6a 00                	push   $0x0
    10fb:	6a 10                	push   $0x10
    10fd:	50                   	push   %eax
    10fe:	ff 75 08             	pushl  0x8(%ebp)
    1101:	e8 9a fe ff ff       	call   fa0 <printint>
    1106:	83 c4 10             	add    $0x10,%esp
        ap++;
    1109:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    110d:	e9 ae 00 00 00       	jmp    11c0 <printf+0x170>
      } else if(c == 's'){
    1112:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1116:	75 43                	jne    115b <printf+0x10b>
        s = (char*)*ap;
    1118:	8b 45 e8             	mov    -0x18(%ebp),%eax
    111b:	8b 00                	mov    (%eax),%eax
    111d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1120:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1124:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1128:	75 25                	jne    114f <printf+0xff>
          s = "(null)";
    112a:	c7 45 f4 f8 14 00 00 	movl   $0x14f8,-0xc(%ebp)
        while(*s != 0){
    1131:	eb 1c                	jmp    114f <printf+0xff>
          putc(fd, *s);
    1133:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1136:	0f b6 00             	movzbl (%eax),%eax
    1139:	0f be c0             	movsbl %al,%eax
    113c:	83 ec 08             	sub    $0x8,%esp
    113f:	50                   	push   %eax
    1140:	ff 75 08             	pushl  0x8(%ebp)
    1143:	e8 35 fe ff ff       	call   f7d <putc>
    1148:	83 c4 10             	add    $0x10,%esp
          s++;
    114b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    114f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1152:	0f b6 00             	movzbl (%eax),%eax
    1155:	84 c0                	test   %al,%al
    1157:	75 da                	jne    1133 <printf+0xe3>
    1159:	eb 65                	jmp    11c0 <printf+0x170>
        }
      } else if(c == 'c'){
    115b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    115f:	75 1d                	jne    117e <printf+0x12e>
        putc(fd, *ap);
    1161:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1164:	8b 00                	mov    (%eax),%eax
    1166:	0f be c0             	movsbl %al,%eax
    1169:	83 ec 08             	sub    $0x8,%esp
    116c:	50                   	push   %eax
    116d:	ff 75 08             	pushl  0x8(%ebp)
    1170:	e8 08 fe ff ff       	call   f7d <putc>
    1175:	83 c4 10             	add    $0x10,%esp
        ap++;
    1178:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    117c:	eb 42                	jmp    11c0 <printf+0x170>
      } else if(c == '%'){
    117e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1182:	75 17                	jne    119b <printf+0x14b>
        putc(fd, c);
    1184:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1187:	0f be c0             	movsbl %al,%eax
    118a:	83 ec 08             	sub    $0x8,%esp
    118d:	50                   	push   %eax
    118e:	ff 75 08             	pushl  0x8(%ebp)
    1191:	e8 e7 fd ff ff       	call   f7d <putc>
    1196:	83 c4 10             	add    $0x10,%esp
    1199:	eb 25                	jmp    11c0 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    119b:	83 ec 08             	sub    $0x8,%esp
    119e:	6a 25                	push   $0x25
    11a0:	ff 75 08             	pushl  0x8(%ebp)
    11a3:	e8 d5 fd ff ff       	call   f7d <putc>
    11a8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    11ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11ae:	0f be c0             	movsbl %al,%eax
    11b1:	83 ec 08             	sub    $0x8,%esp
    11b4:	50                   	push   %eax
    11b5:	ff 75 08             	pushl  0x8(%ebp)
    11b8:	e8 c0 fd ff ff       	call   f7d <putc>
    11bd:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    11c0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    11c7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11cb:	8b 55 0c             	mov    0xc(%ebp),%edx
    11ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11d1:	01 d0                	add    %edx,%eax
    11d3:	0f b6 00             	movzbl (%eax),%eax
    11d6:	84 c0                	test   %al,%al
    11d8:	0f 85 94 fe ff ff    	jne    1072 <printf+0x22>
    }
  }
}
    11de:	90                   	nop
    11df:	c9                   	leave  
    11e0:	c3                   	ret    

000011e1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11e1:	55                   	push   %ebp
    11e2:	89 e5                	mov    %esp,%ebp
    11e4:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    11e7:	8b 45 08             	mov    0x8(%ebp),%eax
    11ea:	83 e8 08             	sub    $0x8,%eax
    11ed:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11f0:	a1 2c 1a 00 00       	mov    0x1a2c,%eax
    11f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11f8:	eb 24                	jmp    121e <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11fd:	8b 00                	mov    (%eax),%eax
    11ff:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1202:	72 12                	jb     1216 <free+0x35>
    1204:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1207:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    120a:	77 24                	ja     1230 <free+0x4f>
    120c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    120f:	8b 00                	mov    (%eax),%eax
    1211:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1214:	72 1a                	jb     1230 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1216:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1219:	8b 00                	mov    (%eax),%eax
    121b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    121e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1221:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1224:	76 d4                	jbe    11fa <free+0x19>
    1226:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1229:	8b 00                	mov    (%eax),%eax
    122b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    122e:	73 ca                	jae    11fa <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1230:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1233:	8b 40 04             	mov    0x4(%eax),%eax
    1236:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    123d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1240:	01 c2                	add    %eax,%edx
    1242:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1245:	8b 00                	mov    (%eax),%eax
    1247:	39 c2                	cmp    %eax,%edx
    1249:	75 24                	jne    126f <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    124b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    124e:	8b 50 04             	mov    0x4(%eax),%edx
    1251:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1254:	8b 00                	mov    (%eax),%eax
    1256:	8b 40 04             	mov    0x4(%eax),%eax
    1259:	01 c2                	add    %eax,%edx
    125b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    125e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1261:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1264:	8b 00                	mov    (%eax),%eax
    1266:	8b 10                	mov    (%eax),%edx
    1268:	8b 45 f8             	mov    -0x8(%ebp),%eax
    126b:	89 10                	mov    %edx,(%eax)
    126d:	eb 0a                	jmp    1279 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    126f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1272:	8b 10                	mov    (%eax),%edx
    1274:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1277:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1279:	8b 45 fc             	mov    -0x4(%ebp),%eax
    127c:	8b 40 04             	mov    0x4(%eax),%eax
    127f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1286:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1289:	01 d0                	add    %edx,%eax
    128b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    128e:	75 20                	jne    12b0 <free+0xcf>
    p->s.size += bp->s.size;
    1290:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1293:	8b 50 04             	mov    0x4(%eax),%edx
    1296:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1299:	8b 40 04             	mov    0x4(%eax),%eax
    129c:	01 c2                	add    %eax,%edx
    129e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    12a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12a7:	8b 10                	mov    (%eax),%edx
    12a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ac:	89 10                	mov    %edx,(%eax)
    12ae:	eb 08                	jmp    12b8 <free+0xd7>
  } else
    p->s.ptr = bp;
    12b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12b3:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12b6:	89 10                	mov    %edx,(%eax)
  freep = p;
    12b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12bb:	a3 2c 1a 00 00       	mov    %eax,0x1a2c
}
    12c0:	90                   	nop
    12c1:	c9                   	leave  
    12c2:	c3                   	ret    

000012c3 <morecore>:

static Header*
morecore(uint nu)
{
    12c3:	55                   	push   %ebp
    12c4:	89 e5                	mov    %esp,%ebp
    12c6:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    12c9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    12d0:	77 07                	ja     12d9 <morecore+0x16>
    nu = 4096;
    12d2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    12d9:	8b 45 08             	mov    0x8(%ebp),%eax
    12dc:	c1 e0 03             	shl    $0x3,%eax
    12df:	83 ec 0c             	sub    $0xc,%esp
    12e2:	50                   	push   %eax
    12e3:	e8 7d fc ff ff       	call   f65 <sbrk>
    12e8:	83 c4 10             	add    $0x10,%esp
    12eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    12ee:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    12f2:	75 07                	jne    12fb <morecore+0x38>
    return 0;
    12f4:	b8 00 00 00 00       	mov    $0x0,%eax
    12f9:	eb 26                	jmp    1321 <morecore+0x5e>
  hp = (Header*)p;
    12fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1301:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1304:	8b 55 08             	mov    0x8(%ebp),%edx
    1307:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    130a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    130d:	83 c0 08             	add    $0x8,%eax
    1310:	83 ec 0c             	sub    $0xc,%esp
    1313:	50                   	push   %eax
    1314:	e8 c8 fe ff ff       	call   11e1 <free>
    1319:	83 c4 10             	add    $0x10,%esp
  return freep;
    131c:	a1 2c 1a 00 00       	mov    0x1a2c,%eax
}
    1321:	c9                   	leave  
    1322:	c3                   	ret    

00001323 <malloc>:

void*
malloc(uint nbytes)
{
    1323:	55                   	push   %ebp
    1324:	89 e5                	mov    %esp,%ebp
    1326:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1329:	8b 45 08             	mov    0x8(%ebp),%eax
    132c:	83 c0 07             	add    $0x7,%eax
    132f:	c1 e8 03             	shr    $0x3,%eax
    1332:	83 c0 01             	add    $0x1,%eax
    1335:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1338:	a1 2c 1a 00 00       	mov    0x1a2c,%eax
    133d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1340:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1344:	75 23                	jne    1369 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1346:	c7 45 f0 24 1a 00 00 	movl   $0x1a24,-0x10(%ebp)
    134d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1350:	a3 2c 1a 00 00       	mov    %eax,0x1a2c
    1355:	a1 2c 1a 00 00       	mov    0x1a2c,%eax
    135a:	a3 24 1a 00 00       	mov    %eax,0x1a24
    base.s.size = 0;
    135f:	c7 05 28 1a 00 00 00 	movl   $0x0,0x1a28
    1366:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1369:	8b 45 f0             	mov    -0x10(%ebp),%eax
    136c:	8b 00                	mov    (%eax),%eax
    136e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1371:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1374:	8b 40 04             	mov    0x4(%eax),%eax
    1377:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    137a:	77 4d                	ja     13c9 <malloc+0xa6>
      if(p->s.size == nunits)
    137c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    137f:	8b 40 04             	mov    0x4(%eax),%eax
    1382:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1385:	75 0c                	jne    1393 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1387:	8b 45 f4             	mov    -0xc(%ebp),%eax
    138a:	8b 10                	mov    (%eax),%edx
    138c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    138f:	89 10                	mov    %edx,(%eax)
    1391:	eb 26                	jmp    13b9 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1393:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1396:	8b 40 04             	mov    0x4(%eax),%eax
    1399:	2b 45 ec             	sub    -0x14(%ebp),%eax
    139c:	89 c2                	mov    %eax,%edx
    139e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13a1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    13a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13a7:	8b 40 04             	mov    0x4(%eax),%eax
    13aa:	c1 e0 03             	shl    $0x3,%eax
    13ad:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    13b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13b3:	8b 55 ec             	mov    -0x14(%ebp),%edx
    13b6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    13b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13bc:	a3 2c 1a 00 00       	mov    %eax,0x1a2c
      return (void*)(p + 1);
    13c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13c4:	83 c0 08             	add    $0x8,%eax
    13c7:	eb 3b                	jmp    1404 <malloc+0xe1>
    }
    if(p == freep)
    13c9:	a1 2c 1a 00 00       	mov    0x1a2c,%eax
    13ce:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    13d1:	75 1e                	jne    13f1 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    13d3:	83 ec 0c             	sub    $0xc,%esp
    13d6:	ff 75 ec             	pushl  -0x14(%ebp)
    13d9:	e8 e5 fe ff ff       	call   12c3 <morecore>
    13de:	83 c4 10             	add    $0x10,%esp
    13e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13e4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13e8:	75 07                	jne    13f1 <malloc+0xce>
        return 0;
    13ea:	b8 00 00 00 00       	mov    $0x0,%eax
    13ef:	eb 13                	jmp    1404 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    13f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13fa:	8b 00                	mov    (%eax),%eax
    13fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    13ff:	e9 6d ff ff ff       	jmp    1371 <malloc+0x4e>
  }
}
    1404:	c9                   	leave  
    1405:	c3                   	ret    
