
_usertests:     formato de ficheiro elf32-i386


Desmontagem da secção .text:

00000000 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "iput test\n");
       6:	a1 4c 63 00 00       	mov    0x634c,%eax
       b:	83 ec 08             	sub    $0x8,%esp
       e:	68 ae 44 00 00       	push   $0x44ae
      13:	50                   	push   %eax
      14:	e8 c9 40 00 00       	call   40e2 <printf>
      19:	83 c4 10             	add    $0x10,%esp

  if(mkdir("iputdir") < 0){
      1c:	83 ec 0c             	sub    $0xc,%esp
      1f:	68 b9 44 00 00       	push   $0x44b9
      24:	e8 ae 3f 00 00       	call   3fd7 <mkdir>
      29:	83 c4 10             	add    $0x10,%esp
      2c:	85 c0                	test   %eax,%eax
      2e:	79 1b                	jns    4b <iputtest+0x4b>
    printf(stdout, "mkdir failed\n");
      30:	a1 4c 63 00 00       	mov    0x634c,%eax
      35:	83 ec 08             	sub    $0x8,%esp
      38:	68 c1 44 00 00       	push   $0x44c1
      3d:	50                   	push   %eax
      3e:	e8 9f 40 00 00       	call   40e2 <printf>
      43:	83 c4 10             	add    $0x10,%esp
    exit();
      46:	e8 24 3f 00 00       	call   3f6f <exit>
  }
  if(chdir("iputdir") < 0){
      4b:	83 ec 0c             	sub    $0xc,%esp
      4e:	68 b9 44 00 00       	push   $0x44b9
      53:	e8 87 3f 00 00       	call   3fdf <chdir>
      58:	83 c4 10             	add    $0x10,%esp
      5b:	85 c0                	test   %eax,%eax
      5d:	79 1b                	jns    7a <iputtest+0x7a>
    printf(stdout, "chdir iputdir failed\n");
      5f:	a1 4c 63 00 00       	mov    0x634c,%eax
      64:	83 ec 08             	sub    $0x8,%esp
      67:	68 cf 44 00 00       	push   $0x44cf
      6c:	50                   	push   %eax
      6d:	e8 70 40 00 00       	call   40e2 <printf>
      72:	83 c4 10             	add    $0x10,%esp
    exit();
      75:	e8 f5 3e 00 00       	call   3f6f <exit>
  }
  if(unlink("../iputdir") < 0){
      7a:	83 ec 0c             	sub    $0xc,%esp
      7d:	68 e5 44 00 00       	push   $0x44e5
      82:	e8 38 3f 00 00       	call   3fbf <unlink>
      87:	83 c4 10             	add    $0x10,%esp
      8a:	85 c0                	test   %eax,%eax
      8c:	79 1b                	jns    a9 <iputtest+0xa9>
    printf(stdout, "unlink ../iputdir failed\n");
      8e:	a1 4c 63 00 00       	mov    0x634c,%eax
      93:	83 ec 08             	sub    $0x8,%esp
      96:	68 f0 44 00 00       	push   $0x44f0
      9b:	50                   	push   %eax
      9c:	e8 41 40 00 00       	call   40e2 <printf>
      a1:	83 c4 10             	add    $0x10,%esp
    exit();
      a4:	e8 c6 3e 00 00       	call   3f6f <exit>
  }
  if(chdir("/") < 0){
      a9:	83 ec 0c             	sub    $0xc,%esp
      ac:	68 0a 45 00 00       	push   $0x450a
      b1:	e8 29 3f 00 00       	call   3fdf <chdir>
      b6:	83 c4 10             	add    $0x10,%esp
      b9:	85 c0                	test   %eax,%eax
      bb:	79 1b                	jns    d8 <iputtest+0xd8>
    printf(stdout, "chdir / failed\n");
      bd:	a1 4c 63 00 00       	mov    0x634c,%eax
      c2:	83 ec 08             	sub    $0x8,%esp
      c5:	68 0c 45 00 00       	push   $0x450c
      ca:	50                   	push   %eax
      cb:	e8 12 40 00 00       	call   40e2 <printf>
      d0:	83 c4 10             	add    $0x10,%esp
    exit();
      d3:	e8 97 3e 00 00       	call   3f6f <exit>
  }
  printf(stdout, "iput test ok\n");
      d8:	a1 4c 63 00 00       	mov    0x634c,%eax
      dd:	83 ec 08             	sub    $0x8,%esp
      e0:	68 1c 45 00 00       	push   $0x451c
      e5:	50                   	push   %eax
      e6:	e8 f7 3f 00 00       	call   40e2 <printf>
      eb:	83 c4 10             	add    $0x10,%esp
}
      ee:	90                   	nop
      ef:	c9                   	leave  
      f0:	c3                   	ret    

000000f1 <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
      f1:	55                   	push   %ebp
      f2:	89 e5                	mov    %esp,%ebp
      f4:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "exitiput test\n");
      f7:	a1 4c 63 00 00       	mov    0x634c,%eax
      fc:	83 ec 08             	sub    $0x8,%esp
      ff:	68 2a 45 00 00       	push   $0x452a
     104:	50                   	push   %eax
     105:	e8 d8 3f 00 00       	call   40e2 <printf>
     10a:	83 c4 10             	add    $0x10,%esp

  pid = fork(0);
     10d:	83 ec 0c             	sub    $0xc,%esp
     110:	6a 00                	push   $0x0
     112:	e8 50 3e 00 00       	call   3f67 <fork>
     117:	83 c4 10             	add    $0x10,%esp
     11a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     11d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     121:	79 1b                	jns    13e <exitiputtest+0x4d>
    printf(stdout, "fork failed\n");
     123:	a1 4c 63 00 00       	mov    0x634c,%eax
     128:	83 ec 08             	sub    $0x8,%esp
     12b:	68 39 45 00 00       	push   $0x4539
     130:	50                   	push   %eax
     131:	e8 ac 3f 00 00       	call   40e2 <printf>
     136:	83 c4 10             	add    $0x10,%esp
    exit();
     139:	e8 31 3e 00 00       	call   3f6f <exit>
  }
  if(pid == 0){
     13e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     142:	0f 85 92 00 00 00    	jne    1da <exitiputtest+0xe9>
    if(mkdir("iputdir") < 0){
     148:	83 ec 0c             	sub    $0xc,%esp
     14b:	68 b9 44 00 00       	push   $0x44b9
     150:	e8 82 3e 00 00       	call   3fd7 <mkdir>
     155:	83 c4 10             	add    $0x10,%esp
     158:	85 c0                	test   %eax,%eax
     15a:	79 1b                	jns    177 <exitiputtest+0x86>
      printf(stdout, "mkdir failed\n");
     15c:	a1 4c 63 00 00       	mov    0x634c,%eax
     161:	83 ec 08             	sub    $0x8,%esp
     164:	68 c1 44 00 00       	push   $0x44c1
     169:	50                   	push   %eax
     16a:	e8 73 3f 00 00       	call   40e2 <printf>
     16f:	83 c4 10             	add    $0x10,%esp
      exit();
     172:	e8 f8 3d 00 00       	call   3f6f <exit>
    }
    if(chdir("iputdir") < 0){
     177:	83 ec 0c             	sub    $0xc,%esp
     17a:	68 b9 44 00 00       	push   $0x44b9
     17f:	e8 5b 3e 00 00       	call   3fdf <chdir>
     184:	83 c4 10             	add    $0x10,%esp
     187:	85 c0                	test   %eax,%eax
     189:	79 1b                	jns    1a6 <exitiputtest+0xb5>
      printf(stdout, "child chdir failed\n");
     18b:	a1 4c 63 00 00       	mov    0x634c,%eax
     190:	83 ec 08             	sub    $0x8,%esp
     193:	68 46 45 00 00       	push   $0x4546
     198:	50                   	push   %eax
     199:	e8 44 3f 00 00       	call   40e2 <printf>
     19e:	83 c4 10             	add    $0x10,%esp
      exit();
     1a1:	e8 c9 3d 00 00       	call   3f6f <exit>
    }
    if(unlink("../iputdir") < 0){
     1a6:	83 ec 0c             	sub    $0xc,%esp
     1a9:	68 e5 44 00 00       	push   $0x44e5
     1ae:	e8 0c 3e 00 00       	call   3fbf <unlink>
     1b3:	83 c4 10             	add    $0x10,%esp
     1b6:	85 c0                	test   %eax,%eax
     1b8:	79 1b                	jns    1d5 <exitiputtest+0xe4>
      printf(stdout, "unlink ../iputdir failed\n");
     1ba:	a1 4c 63 00 00       	mov    0x634c,%eax
     1bf:	83 ec 08             	sub    $0x8,%esp
     1c2:	68 f0 44 00 00       	push   $0x44f0
     1c7:	50                   	push   %eax
     1c8:	e8 15 3f 00 00       	call   40e2 <printf>
     1cd:	83 c4 10             	add    $0x10,%esp
      exit();
     1d0:	e8 9a 3d 00 00       	call   3f6f <exit>
    }
    exit();
     1d5:	e8 95 3d 00 00       	call   3f6f <exit>
  }
  wait();
     1da:	e8 98 3d 00 00       	call   3f77 <wait>
  printf(stdout, "exitiput test ok\n");
     1df:	a1 4c 63 00 00       	mov    0x634c,%eax
     1e4:	83 ec 08             	sub    $0x8,%esp
     1e7:	68 5a 45 00 00       	push   $0x455a
     1ec:	50                   	push   %eax
     1ed:	e8 f0 3e 00 00       	call   40e2 <printf>
     1f2:	83 c4 10             	add    $0x10,%esp
}
     1f5:	90                   	nop
     1f6:	c9                   	leave  
     1f7:	c3                   	ret    

000001f8 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     1f8:	55                   	push   %ebp
     1f9:	89 e5                	mov    %esp,%ebp
     1fb:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "openiput test\n");
     1fe:	a1 4c 63 00 00       	mov    0x634c,%eax
     203:	83 ec 08             	sub    $0x8,%esp
     206:	68 6c 45 00 00       	push   $0x456c
     20b:	50                   	push   %eax
     20c:	e8 d1 3e 00 00       	call   40e2 <printf>
     211:	83 c4 10             	add    $0x10,%esp
  if(mkdir("oidir") < 0){
     214:	83 ec 0c             	sub    $0xc,%esp
     217:	68 7b 45 00 00       	push   $0x457b
     21c:	e8 b6 3d 00 00       	call   3fd7 <mkdir>
     221:	83 c4 10             	add    $0x10,%esp
     224:	85 c0                	test   %eax,%eax
     226:	79 1b                	jns    243 <openiputtest+0x4b>
    printf(stdout, "mkdir oidir failed\n");
     228:	a1 4c 63 00 00       	mov    0x634c,%eax
     22d:	83 ec 08             	sub    $0x8,%esp
     230:	68 81 45 00 00       	push   $0x4581
     235:	50                   	push   %eax
     236:	e8 a7 3e 00 00       	call   40e2 <printf>
     23b:	83 c4 10             	add    $0x10,%esp
    exit();
     23e:	e8 2c 3d 00 00       	call   3f6f <exit>
  }
  pid = fork(0);
     243:	83 ec 0c             	sub    $0xc,%esp
     246:	6a 00                	push   $0x0
     248:	e8 1a 3d 00 00       	call   3f67 <fork>
     24d:	83 c4 10             	add    $0x10,%esp
     250:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     253:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     257:	79 1b                	jns    274 <openiputtest+0x7c>
    printf(stdout, "fork failed\n");
     259:	a1 4c 63 00 00       	mov    0x634c,%eax
     25e:	83 ec 08             	sub    $0x8,%esp
     261:	68 39 45 00 00       	push   $0x4539
     266:	50                   	push   %eax
     267:	e8 76 3e 00 00       	call   40e2 <printf>
     26c:	83 c4 10             	add    $0x10,%esp
    exit();
     26f:	e8 fb 3c 00 00       	call   3f6f <exit>
  }
  if(pid == 0){
     274:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     278:	75 3b                	jne    2b5 <openiputtest+0xbd>
    int fd = open("oidir", O_RDWR);
     27a:	83 ec 08             	sub    $0x8,%esp
     27d:	6a 02                	push   $0x2
     27f:	68 7b 45 00 00       	push   $0x457b
     284:	e8 26 3d 00 00       	call   3faf <open>
     289:	83 c4 10             	add    $0x10,%esp
     28c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0){
     28f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     293:	78 1b                	js     2b0 <openiputtest+0xb8>
      printf(stdout, "open directory for write succeeded\n");
     295:	a1 4c 63 00 00       	mov    0x634c,%eax
     29a:	83 ec 08             	sub    $0x8,%esp
     29d:	68 98 45 00 00       	push   $0x4598
     2a2:	50                   	push   %eax
     2a3:	e8 3a 3e 00 00       	call   40e2 <printf>
     2a8:	83 c4 10             	add    $0x10,%esp
      exit();
     2ab:	e8 bf 3c 00 00       	call   3f6f <exit>
    }
    exit();
     2b0:	e8 ba 3c 00 00       	call   3f6f <exit>
  }
  sleep(1);
     2b5:	83 ec 0c             	sub    $0xc,%esp
     2b8:	6a 01                	push   $0x1
     2ba:	e8 40 3d 00 00       	call   3fff <sleep>
     2bf:	83 c4 10             	add    $0x10,%esp
  if(unlink("oidir") != 0){
     2c2:	83 ec 0c             	sub    $0xc,%esp
     2c5:	68 7b 45 00 00       	push   $0x457b
     2ca:	e8 f0 3c 00 00       	call   3fbf <unlink>
     2cf:	83 c4 10             	add    $0x10,%esp
     2d2:	85 c0                	test   %eax,%eax
     2d4:	74 1b                	je     2f1 <openiputtest+0xf9>
    printf(stdout, "unlink failed\n");
     2d6:	a1 4c 63 00 00       	mov    0x634c,%eax
     2db:	83 ec 08             	sub    $0x8,%esp
     2de:	68 bc 45 00 00       	push   $0x45bc
     2e3:	50                   	push   %eax
     2e4:	e8 f9 3d 00 00       	call   40e2 <printf>
     2e9:	83 c4 10             	add    $0x10,%esp
    exit();
     2ec:	e8 7e 3c 00 00       	call   3f6f <exit>
  }
  wait();
     2f1:	e8 81 3c 00 00       	call   3f77 <wait>
  printf(stdout, "openiput test ok\n");
     2f6:	a1 4c 63 00 00       	mov    0x634c,%eax
     2fb:	83 ec 08             	sub    $0x8,%esp
     2fe:	68 cb 45 00 00       	push   $0x45cb
     303:	50                   	push   %eax
     304:	e8 d9 3d 00 00       	call   40e2 <printf>
     309:	83 c4 10             	add    $0x10,%esp
}
     30c:	90                   	nop
     30d:	c9                   	leave  
     30e:	c3                   	ret    

0000030f <opentest>:

// simple file system tests

void
opentest(void)
{
     30f:	55                   	push   %ebp
     310:	89 e5                	mov    %esp,%ebp
     312:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
     315:	a1 4c 63 00 00       	mov    0x634c,%eax
     31a:	83 ec 08             	sub    $0x8,%esp
     31d:	68 dd 45 00 00       	push   $0x45dd
     322:	50                   	push   %eax
     323:	e8 ba 3d 00 00       	call   40e2 <printf>
     328:	83 c4 10             	add    $0x10,%esp
  fd = open("echo", 0);
     32b:	83 ec 08             	sub    $0x8,%esp
     32e:	6a 00                	push   $0x0
     330:	68 98 44 00 00       	push   $0x4498
     335:	e8 75 3c 00 00       	call   3faf <open>
     33a:	83 c4 10             	add    $0x10,%esp
     33d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
     340:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     344:	79 1b                	jns    361 <opentest+0x52>
    printf(stdout, "open echo failed!\n");
     346:	a1 4c 63 00 00       	mov    0x634c,%eax
     34b:	83 ec 08             	sub    $0x8,%esp
     34e:	68 e8 45 00 00       	push   $0x45e8
     353:	50                   	push   %eax
     354:	e8 89 3d 00 00       	call   40e2 <printf>
     359:	83 c4 10             	add    $0x10,%esp
    exit();
     35c:	e8 0e 3c 00 00       	call   3f6f <exit>
  }
  close(fd);
     361:	83 ec 0c             	sub    $0xc,%esp
     364:	ff 75 f4             	pushl  -0xc(%ebp)
     367:	e8 2b 3c 00 00       	call   3f97 <close>
     36c:	83 c4 10             	add    $0x10,%esp
  fd = open("doesnotexist", 0);
     36f:	83 ec 08             	sub    $0x8,%esp
     372:	6a 00                	push   $0x0
     374:	68 fb 45 00 00       	push   $0x45fb
     379:	e8 31 3c 00 00       	call   3faf <open>
     37e:	83 c4 10             	add    $0x10,%esp
     381:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
     384:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     388:	78 1b                	js     3a5 <opentest+0x96>
    printf(stdout, "open doesnotexist succeeded!\n");
     38a:	a1 4c 63 00 00       	mov    0x634c,%eax
     38f:	83 ec 08             	sub    $0x8,%esp
     392:	68 08 46 00 00       	push   $0x4608
     397:	50                   	push   %eax
     398:	e8 45 3d 00 00       	call   40e2 <printf>
     39d:	83 c4 10             	add    $0x10,%esp
    exit();
     3a0:	e8 ca 3b 00 00       	call   3f6f <exit>
  }
  printf(stdout, "open test ok\n");
     3a5:	a1 4c 63 00 00       	mov    0x634c,%eax
     3aa:	83 ec 08             	sub    $0x8,%esp
     3ad:	68 26 46 00 00       	push   $0x4626
     3b2:	50                   	push   %eax
     3b3:	e8 2a 3d 00 00       	call   40e2 <printf>
     3b8:	83 c4 10             	add    $0x10,%esp
}
     3bb:	90                   	nop
     3bc:	c9                   	leave  
     3bd:	c3                   	ret    

000003be <writetest>:

void
writetest(void)
{
     3be:	55                   	push   %ebp
     3bf:	89 e5                	mov    %esp,%ebp
     3c1:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
     3c4:	a1 4c 63 00 00       	mov    0x634c,%eax
     3c9:	83 ec 08             	sub    $0x8,%esp
     3cc:	68 34 46 00 00       	push   $0x4634
     3d1:	50                   	push   %eax
     3d2:	e8 0b 3d 00 00       	call   40e2 <printf>
     3d7:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_CREATE|O_RDWR);
     3da:	83 ec 08             	sub    $0x8,%esp
     3dd:	68 02 02 00 00       	push   $0x202
     3e2:	68 45 46 00 00       	push   $0x4645
     3e7:	e8 c3 3b 00 00       	call   3faf <open>
     3ec:	83 c4 10             	add    $0x10,%esp
     3ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     3f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3f6:	78 22                	js     41a <writetest+0x5c>
    printf(stdout, "creat small succeeded; ok\n");
     3f8:	a1 4c 63 00 00       	mov    0x634c,%eax
     3fd:	83 ec 08             	sub    $0x8,%esp
     400:	68 4b 46 00 00       	push   $0x464b
     405:	50                   	push   %eax
     406:	e8 d7 3c 00 00       	call   40e2 <printf>
     40b:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     40e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     415:	e9 8f 00 00 00       	jmp    4a9 <writetest+0xeb>
    printf(stdout, "error: creat small failed!\n");
     41a:	a1 4c 63 00 00       	mov    0x634c,%eax
     41f:	83 ec 08             	sub    $0x8,%esp
     422:	68 66 46 00 00       	push   $0x4666
     427:	50                   	push   %eax
     428:	e8 b5 3c 00 00       	call   40e2 <printf>
     42d:	83 c4 10             	add    $0x10,%esp
    exit();
     430:	e8 3a 3b 00 00       	call   3f6f <exit>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     435:	83 ec 04             	sub    $0x4,%esp
     438:	6a 0a                	push   $0xa
     43a:	68 82 46 00 00       	push   $0x4682
     43f:	ff 75 f0             	pushl  -0x10(%ebp)
     442:	e8 48 3b 00 00       	call   3f8f <write>
     447:	83 c4 10             	add    $0x10,%esp
     44a:	83 f8 0a             	cmp    $0xa,%eax
     44d:	74 1e                	je     46d <writetest+0xaf>
      printf(stdout, "error: write aa %d new file failed\n", i);
     44f:	a1 4c 63 00 00       	mov    0x634c,%eax
     454:	83 ec 04             	sub    $0x4,%esp
     457:	ff 75 f4             	pushl  -0xc(%ebp)
     45a:	68 90 46 00 00       	push   $0x4690
     45f:	50                   	push   %eax
     460:	e8 7d 3c 00 00       	call   40e2 <printf>
     465:	83 c4 10             	add    $0x10,%esp
      exit();
     468:	e8 02 3b 00 00       	call   3f6f <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     46d:	83 ec 04             	sub    $0x4,%esp
     470:	6a 0a                	push   $0xa
     472:	68 b4 46 00 00       	push   $0x46b4
     477:	ff 75 f0             	pushl  -0x10(%ebp)
     47a:	e8 10 3b 00 00       	call   3f8f <write>
     47f:	83 c4 10             	add    $0x10,%esp
     482:	83 f8 0a             	cmp    $0xa,%eax
     485:	74 1e                	je     4a5 <writetest+0xe7>
      printf(stdout, "error: write bb %d new file failed\n", i);
     487:	a1 4c 63 00 00       	mov    0x634c,%eax
     48c:	83 ec 04             	sub    $0x4,%esp
     48f:	ff 75 f4             	pushl  -0xc(%ebp)
     492:	68 c0 46 00 00       	push   $0x46c0
     497:	50                   	push   %eax
     498:	e8 45 3c 00 00       	call   40e2 <printf>
     49d:	83 c4 10             	add    $0x10,%esp
      exit();
     4a0:	e8 ca 3a 00 00       	call   3f6f <exit>
  for(i = 0; i < 100; i++){
     4a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     4a9:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     4ad:	7e 86                	jle    435 <writetest+0x77>
    }
  }
  printf(stdout, "writes ok\n");
     4af:	a1 4c 63 00 00       	mov    0x634c,%eax
     4b4:	83 ec 08             	sub    $0x8,%esp
     4b7:	68 e4 46 00 00       	push   $0x46e4
     4bc:	50                   	push   %eax
     4bd:	e8 20 3c 00 00       	call   40e2 <printf>
     4c2:	83 c4 10             	add    $0x10,%esp
  close(fd);
     4c5:	83 ec 0c             	sub    $0xc,%esp
     4c8:	ff 75 f0             	pushl  -0x10(%ebp)
     4cb:	e8 c7 3a 00 00       	call   3f97 <close>
     4d0:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     4d3:	83 ec 08             	sub    $0x8,%esp
     4d6:	6a 00                	push   $0x0
     4d8:	68 45 46 00 00       	push   $0x4645
     4dd:	e8 cd 3a 00 00       	call   3faf <open>
     4e2:	83 c4 10             	add    $0x10,%esp
     4e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     4e8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4ec:	78 3c                	js     52a <writetest+0x16c>
    printf(stdout, "open small succeeded ok\n");
     4ee:	a1 4c 63 00 00       	mov    0x634c,%eax
     4f3:	83 ec 08             	sub    $0x8,%esp
     4f6:	68 ef 46 00 00       	push   $0x46ef
     4fb:	50                   	push   %eax
     4fc:	e8 e1 3b 00 00       	call   40e2 <printf>
     501:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     504:	83 ec 04             	sub    $0x4,%esp
     507:	68 d0 07 00 00       	push   $0x7d0
     50c:	68 40 8b 00 00       	push   $0x8b40
     511:	ff 75 f0             	pushl  -0x10(%ebp)
     514:	e8 6e 3a 00 00       	call   3f87 <read>
     519:	83 c4 10             	add    $0x10,%esp
     51c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(i == 2000){
     51f:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     526:	75 57                	jne    57f <writetest+0x1c1>
     528:	eb 1b                	jmp    545 <writetest+0x187>
    printf(stdout, "error: open small failed!\n");
     52a:	a1 4c 63 00 00       	mov    0x634c,%eax
     52f:	83 ec 08             	sub    $0x8,%esp
     532:	68 08 47 00 00       	push   $0x4708
     537:	50                   	push   %eax
     538:	e8 a5 3b 00 00       	call   40e2 <printf>
     53d:	83 c4 10             	add    $0x10,%esp
    exit();
     540:	e8 2a 3a 00 00       	call   3f6f <exit>
    printf(stdout, "read succeeded ok\n");
     545:	a1 4c 63 00 00       	mov    0x634c,%eax
     54a:	83 ec 08             	sub    $0x8,%esp
     54d:	68 23 47 00 00       	push   $0x4723
     552:	50                   	push   %eax
     553:	e8 8a 3b 00 00       	call   40e2 <printf>
     558:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     55b:	83 ec 0c             	sub    $0xc,%esp
     55e:	ff 75 f0             	pushl  -0x10(%ebp)
     561:	e8 31 3a 00 00       	call   3f97 <close>
     566:	83 c4 10             	add    $0x10,%esp

  if(unlink("small") < 0){
     569:	83 ec 0c             	sub    $0xc,%esp
     56c:	68 45 46 00 00       	push   $0x4645
     571:	e8 49 3a 00 00       	call   3fbf <unlink>
     576:	83 c4 10             	add    $0x10,%esp
     579:	85 c0                	test   %eax,%eax
     57b:	79 38                	jns    5b5 <writetest+0x1f7>
     57d:	eb 1b                	jmp    59a <writetest+0x1dc>
    printf(stdout, "read failed\n");
     57f:	a1 4c 63 00 00       	mov    0x634c,%eax
     584:	83 ec 08             	sub    $0x8,%esp
     587:	68 36 47 00 00       	push   $0x4736
     58c:	50                   	push   %eax
     58d:	e8 50 3b 00 00       	call   40e2 <printf>
     592:	83 c4 10             	add    $0x10,%esp
    exit();
     595:	e8 d5 39 00 00       	call   3f6f <exit>
    printf(stdout, "unlink small failed\n");
     59a:	a1 4c 63 00 00       	mov    0x634c,%eax
     59f:	83 ec 08             	sub    $0x8,%esp
     5a2:	68 43 47 00 00       	push   $0x4743
     5a7:	50                   	push   %eax
     5a8:	e8 35 3b 00 00       	call   40e2 <printf>
     5ad:	83 c4 10             	add    $0x10,%esp
    exit();
     5b0:	e8 ba 39 00 00       	call   3f6f <exit>
  }
  printf(stdout, "small file test ok\n");
     5b5:	a1 4c 63 00 00       	mov    0x634c,%eax
     5ba:	83 ec 08             	sub    $0x8,%esp
     5bd:	68 58 47 00 00       	push   $0x4758
     5c2:	50                   	push   %eax
     5c3:	e8 1a 3b 00 00       	call   40e2 <printf>
     5c8:	83 c4 10             	add    $0x10,%esp
}
     5cb:	90                   	nop
     5cc:	c9                   	leave  
     5cd:	c3                   	ret    

000005ce <writetest1>:

void
writetest1(void)
{
     5ce:	55                   	push   %ebp
     5cf:	89 e5                	mov    %esp,%ebp
     5d1:	83 ec 18             	sub    $0x18,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     5d4:	a1 4c 63 00 00       	mov    0x634c,%eax
     5d9:	83 ec 08             	sub    $0x8,%esp
     5dc:	68 6c 47 00 00       	push   $0x476c
     5e1:	50                   	push   %eax
     5e2:	e8 fb 3a 00 00       	call   40e2 <printf>
     5e7:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_CREATE|O_RDWR);
     5ea:	83 ec 08             	sub    $0x8,%esp
     5ed:	68 02 02 00 00       	push   $0x202
     5f2:	68 7c 47 00 00       	push   $0x477c
     5f7:	e8 b3 39 00 00       	call   3faf <open>
     5fc:	83 c4 10             	add    $0x10,%esp
     5ff:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     602:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     606:	79 1b                	jns    623 <writetest1+0x55>
    printf(stdout, "error: creat big failed!\n");
     608:	a1 4c 63 00 00       	mov    0x634c,%eax
     60d:	83 ec 08             	sub    $0x8,%esp
     610:	68 80 47 00 00       	push   $0x4780
     615:	50                   	push   %eax
     616:	e8 c7 3a 00 00       	call   40e2 <printf>
     61b:	83 c4 10             	add    $0x10,%esp
    exit();
     61e:	e8 4c 39 00 00       	call   3f6f <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     623:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     62a:	eb 4b                	jmp    677 <writetest1+0xa9>
    ((int*)buf)[0] = i;
     62c:	ba 40 8b 00 00       	mov    $0x8b40,%edx
     631:	8b 45 f4             	mov    -0xc(%ebp),%eax
     634:	89 02                	mov    %eax,(%edx)
    if(write(fd, buf, 512) != 512){
     636:	83 ec 04             	sub    $0x4,%esp
     639:	68 00 02 00 00       	push   $0x200
     63e:	68 40 8b 00 00       	push   $0x8b40
     643:	ff 75 ec             	pushl  -0x14(%ebp)
     646:	e8 44 39 00 00       	call   3f8f <write>
     64b:	83 c4 10             	add    $0x10,%esp
     64e:	3d 00 02 00 00       	cmp    $0x200,%eax
     653:	74 1e                	je     673 <writetest1+0xa5>
      printf(stdout, "error: write big file failed\n", i);
     655:	a1 4c 63 00 00       	mov    0x634c,%eax
     65a:	83 ec 04             	sub    $0x4,%esp
     65d:	ff 75 f4             	pushl  -0xc(%ebp)
     660:	68 9a 47 00 00       	push   $0x479a
     665:	50                   	push   %eax
     666:	e8 77 3a 00 00       	call   40e2 <printf>
     66b:	83 c4 10             	add    $0x10,%esp
      exit();
     66e:	e8 fc 38 00 00       	call   3f6f <exit>
  for(i = 0; i < MAXFILE; i++){
     673:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     677:	8b 45 f4             	mov    -0xc(%ebp),%eax
     67a:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     67f:	76 ab                	jbe    62c <writetest1+0x5e>
    }
  }

  close(fd);
     681:	83 ec 0c             	sub    $0xc,%esp
     684:	ff 75 ec             	pushl  -0x14(%ebp)
     687:	e8 0b 39 00 00       	call   3f97 <close>
     68c:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_RDONLY);
     68f:	83 ec 08             	sub    $0x8,%esp
     692:	6a 00                	push   $0x0
     694:	68 7c 47 00 00       	push   $0x477c
     699:	e8 11 39 00 00       	call   3faf <open>
     69e:	83 c4 10             	add    $0x10,%esp
     6a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     6a4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6a8:	79 1b                	jns    6c5 <writetest1+0xf7>
    printf(stdout, "error: open big failed!\n");
     6aa:	a1 4c 63 00 00       	mov    0x634c,%eax
     6af:	83 ec 08             	sub    $0x8,%esp
     6b2:	68 b8 47 00 00       	push   $0x47b8
     6b7:	50                   	push   %eax
     6b8:	e8 25 3a 00 00       	call   40e2 <printf>
     6bd:	83 c4 10             	add    $0x10,%esp
    exit();
     6c0:	e8 aa 38 00 00       	call   3f6f <exit>
  }

  n = 0;
     6c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(;;){
    i = read(fd, buf, 512);
     6cc:	83 ec 04             	sub    $0x4,%esp
     6cf:	68 00 02 00 00       	push   $0x200
     6d4:	68 40 8b 00 00       	push   $0x8b40
     6d9:	ff 75 ec             	pushl  -0x14(%ebp)
     6dc:	e8 a6 38 00 00       	call   3f87 <read>
     6e1:	83 c4 10             	add    $0x10,%esp
     6e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(i == 0){
     6e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6eb:	75 27                	jne    714 <writetest1+0x146>
      if(n == MAXFILE - 1){
     6ed:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     6f4:	75 7d                	jne    773 <writetest1+0x1a5>
        printf(stdout, "read only %d blocks from big", n);
     6f6:	a1 4c 63 00 00       	mov    0x634c,%eax
     6fb:	83 ec 04             	sub    $0x4,%esp
     6fe:	ff 75 f0             	pushl  -0x10(%ebp)
     701:	68 d1 47 00 00       	push   $0x47d1
     706:	50                   	push   %eax
     707:	e8 d6 39 00 00       	call   40e2 <printf>
     70c:	83 c4 10             	add    $0x10,%esp
        exit();
     70f:	e8 5b 38 00 00       	call   3f6f <exit>
      }
      break;
    } else if(i != 512){
     714:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     71b:	74 1e                	je     73b <writetest1+0x16d>
      printf(stdout, "read failed %d\n", i);
     71d:	a1 4c 63 00 00       	mov    0x634c,%eax
     722:	83 ec 04             	sub    $0x4,%esp
     725:	ff 75 f4             	pushl  -0xc(%ebp)
     728:	68 ee 47 00 00       	push   $0x47ee
     72d:	50                   	push   %eax
     72e:	e8 af 39 00 00       	call   40e2 <printf>
     733:	83 c4 10             	add    $0x10,%esp
      exit();
     736:	e8 34 38 00 00       	call   3f6f <exit>
    }
    if(((int*)buf)[0] != n){
     73b:	b8 40 8b 00 00       	mov    $0x8b40,%eax
     740:	8b 00                	mov    (%eax),%eax
     742:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     745:	74 23                	je     76a <writetest1+0x19c>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     747:	b8 40 8b 00 00       	mov    $0x8b40,%eax
      printf(stdout, "read content of block %d is %d\n",
     74c:	8b 10                	mov    (%eax),%edx
     74e:	a1 4c 63 00 00       	mov    0x634c,%eax
     753:	52                   	push   %edx
     754:	ff 75 f0             	pushl  -0x10(%ebp)
     757:	68 00 48 00 00       	push   $0x4800
     75c:	50                   	push   %eax
     75d:	e8 80 39 00 00       	call   40e2 <printf>
     762:	83 c4 10             	add    $0x10,%esp
      exit();
     765:	e8 05 38 00 00       	call   3f6f <exit>
    }
    n++;
     76a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    i = read(fd, buf, 512);
     76e:	e9 59 ff ff ff       	jmp    6cc <writetest1+0xfe>
      break;
     773:	90                   	nop
  }
  close(fd);
     774:	83 ec 0c             	sub    $0xc,%esp
     777:	ff 75 ec             	pushl  -0x14(%ebp)
     77a:	e8 18 38 00 00       	call   3f97 <close>
     77f:	83 c4 10             	add    $0x10,%esp
  if(unlink("big") < 0){
     782:	83 ec 0c             	sub    $0xc,%esp
     785:	68 7c 47 00 00       	push   $0x477c
     78a:	e8 30 38 00 00       	call   3fbf <unlink>
     78f:	83 c4 10             	add    $0x10,%esp
     792:	85 c0                	test   %eax,%eax
     794:	79 1b                	jns    7b1 <writetest1+0x1e3>
    printf(stdout, "unlink big failed\n");
     796:	a1 4c 63 00 00       	mov    0x634c,%eax
     79b:	83 ec 08             	sub    $0x8,%esp
     79e:	68 20 48 00 00       	push   $0x4820
     7a3:	50                   	push   %eax
     7a4:	e8 39 39 00 00       	call   40e2 <printf>
     7a9:	83 c4 10             	add    $0x10,%esp
    exit();
     7ac:	e8 be 37 00 00       	call   3f6f <exit>
  }
  printf(stdout, "big files ok\n");
     7b1:	a1 4c 63 00 00       	mov    0x634c,%eax
     7b6:	83 ec 08             	sub    $0x8,%esp
     7b9:	68 33 48 00 00       	push   $0x4833
     7be:	50                   	push   %eax
     7bf:	e8 1e 39 00 00       	call   40e2 <printf>
     7c4:	83 c4 10             	add    $0x10,%esp
}
     7c7:	90                   	nop
     7c8:	c9                   	leave  
     7c9:	c3                   	ret    

000007ca <createtest>:

void
createtest(void)
{
     7ca:	55                   	push   %ebp
     7cb:	89 e5                	mov    %esp,%ebp
     7cd:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     7d0:	a1 4c 63 00 00       	mov    0x634c,%eax
     7d5:	83 ec 08             	sub    $0x8,%esp
     7d8:	68 44 48 00 00       	push   $0x4844
     7dd:	50                   	push   %eax
     7de:	e8 ff 38 00 00       	call   40e2 <printf>
     7e3:	83 c4 10             	add    $0x10,%esp

  name[0] = 'a';
     7e6:	c6 05 40 ab 00 00 61 	movb   $0x61,0xab40
  name[2] = '\0';
     7ed:	c6 05 42 ab 00 00 00 	movb   $0x0,0xab42
  for(i = 0; i < 52; i++){
     7f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     7fb:	eb 35                	jmp    832 <createtest+0x68>
    name[1] = '0' + i;
     7fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     800:	83 c0 30             	add    $0x30,%eax
     803:	a2 41 ab 00 00       	mov    %al,0xab41
    fd = open(name, O_CREATE|O_RDWR);
     808:	83 ec 08             	sub    $0x8,%esp
     80b:	68 02 02 00 00       	push   $0x202
     810:	68 40 ab 00 00       	push   $0xab40
     815:	e8 95 37 00 00       	call   3faf <open>
     81a:	83 c4 10             	add    $0x10,%esp
     81d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     820:	83 ec 0c             	sub    $0xc,%esp
     823:	ff 75 f0             	pushl  -0x10(%ebp)
     826:	e8 6c 37 00 00       	call   3f97 <close>
     82b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 52; i++){
     82e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     832:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     836:	7e c5                	jle    7fd <createtest+0x33>
  }
  name[0] = 'a';
     838:	c6 05 40 ab 00 00 61 	movb   $0x61,0xab40
  name[2] = '\0';
     83f:	c6 05 42 ab 00 00 00 	movb   $0x0,0xab42
  for(i = 0; i < 52; i++){
     846:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     84d:	eb 1f                	jmp    86e <createtest+0xa4>
    name[1] = '0' + i;
     84f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     852:	83 c0 30             	add    $0x30,%eax
     855:	a2 41 ab 00 00       	mov    %al,0xab41
    unlink(name);
     85a:	83 ec 0c             	sub    $0xc,%esp
     85d:	68 40 ab 00 00       	push   $0xab40
     862:	e8 58 37 00 00       	call   3fbf <unlink>
     867:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 52; i++){
     86a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     86e:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     872:	7e db                	jle    84f <createtest+0x85>
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     874:	a1 4c 63 00 00       	mov    0x634c,%eax
     879:	83 ec 08             	sub    $0x8,%esp
     87c:	68 6c 48 00 00       	push   $0x486c
     881:	50                   	push   %eax
     882:	e8 5b 38 00 00       	call   40e2 <printf>
     887:	83 c4 10             	add    $0x10,%esp
}
     88a:	90                   	nop
     88b:	c9                   	leave  
     88c:	c3                   	ret    

0000088d <dirtest>:

void dirtest(void)
{
     88d:	55                   	push   %ebp
     88e:	89 e5                	mov    %esp,%ebp
     890:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "mkdir test\n");
     893:	a1 4c 63 00 00       	mov    0x634c,%eax
     898:	83 ec 08             	sub    $0x8,%esp
     89b:	68 92 48 00 00       	push   $0x4892
     8a0:	50                   	push   %eax
     8a1:	e8 3c 38 00 00       	call   40e2 <printf>
     8a6:	83 c4 10             	add    $0x10,%esp

  if(mkdir("dir0") < 0){
     8a9:	83 ec 0c             	sub    $0xc,%esp
     8ac:	68 9e 48 00 00       	push   $0x489e
     8b1:	e8 21 37 00 00       	call   3fd7 <mkdir>
     8b6:	83 c4 10             	add    $0x10,%esp
     8b9:	85 c0                	test   %eax,%eax
     8bb:	79 1b                	jns    8d8 <dirtest+0x4b>
    printf(stdout, "mkdir failed\n");
     8bd:	a1 4c 63 00 00       	mov    0x634c,%eax
     8c2:	83 ec 08             	sub    $0x8,%esp
     8c5:	68 c1 44 00 00       	push   $0x44c1
     8ca:	50                   	push   %eax
     8cb:	e8 12 38 00 00       	call   40e2 <printf>
     8d0:	83 c4 10             	add    $0x10,%esp
    exit();
     8d3:	e8 97 36 00 00       	call   3f6f <exit>
  }

  if(chdir("dir0") < 0){
     8d8:	83 ec 0c             	sub    $0xc,%esp
     8db:	68 9e 48 00 00       	push   $0x489e
     8e0:	e8 fa 36 00 00       	call   3fdf <chdir>
     8e5:	83 c4 10             	add    $0x10,%esp
     8e8:	85 c0                	test   %eax,%eax
     8ea:	79 1b                	jns    907 <dirtest+0x7a>
    printf(stdout, "chdir dir0 failed\n");
     8ec:	a1 4c 63 00 00       	mov    0x634c,%eax
     8f1:	83 ec 08             	sub    $0x8,%esp
     8f4:	68 a3 48 00 00       	push   $0x48a3
     8f9:	50                   	push   %eax
     8fa:	e8 e3 37 00 00       	call   40e2 <printf>
     8ff:	83 c4 10             	add    $0x10,%esp
    exit();
     902:	e8 68 36 00 00       	call   3f6f <exit>
  }

  if(chdir("..") < 0){
     907:	83 ec 0c             	sub    $0xc,%esp
     90a:	68 b6 48 00 00       	push   $0x48b6
     90f:	e8 cb 36 00 00       	call   3fdf <chdir>
     914:	83 c4 10             	add    $0x10,%esp
     917:	85 c0                	test   %eax,%eax
     919:	79 1b                	jns    936 <dirtest+0xa9>
    printf(stdout, "chdir .. failed\n");
     91b:	a1 4c 63 00 00       	mov    0x634c,%eax
     920:	83 ec 08             	sub    $0x8,%esp
     923:	68 b9 48 00 00       	push   $0x48b9
     928:	50                   	push   %eax
     929:	e8 b4 37 00 00       	call   40e2 <printf>
     92e:	83 c4 10             	add    $0x10,%esp
    exit();
     931:	e8 39 36 00 00       	call   3f6f <exit>
  }

  if(unlink("dir0") < 0){
     936:	83 ec 0c             	sub    $0xc,%esp
     939:	68 9e 48 00 00       	push   $0x489e
     93e:	e8 7c 36 00 00       	call   3fbf <unlink>
     943:	83 c4 10             	add    $0x10,%esp
     946:	85 c0                	test   %eax,%eax
     948:	79 1b                	jns    965 <dirtest+0xd8>
    printf(stdout, "unlink dir0 failed\n");
     94a:	a1 4c 63 00 00       	mov    0x634c,%eax
     94f:	83 ec 08             	sub    $0x8,%esp
     952:	68 ca 48 00 00       	push   $0x48ca
     957:	50                   	push   %eax
     958:	e8 85 37 00 00       	call   40e2 <printf>
     95d:	83 c4 10             	add    $0x10,%esp
    exit();
     960:	e8 0a 36 00 00       	call   3f6f <exit>
  }
  printf(stdout, "mkdir test ok\n");
     965:	a1 4c 63 00 00       	mov    0x634c,%eax
     96a:	83 ec 08             	sub    $0x8,%esp
     96d:	68 de 48 00 00       	push   $0x48de
     972:	50                   	push   %eax
     973:	e8 6a 37 00 00       	call   40e2 <printf>
     978:	83 c4 10             	add    $0x10,%esp
}
     97b:	90                   	nop
     97c:	c9                   	leave  
     97d:	c3                   	ret    

0000097e <exectest>:

void
exectest(void)
{
     97e:	55                   	push   %ebp
     97f:	89 e5                	mov    %esp,%ebp
     981:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "exec test\n");
     984:	a1 4c 63 00 00       	mov    0x634c,%eax
     989:	83 ec 08             	sub    $0x8,%esp
     98c:	68 ed 48 00 00       	push   $0x48ed
     991:	50                   	push   %eax
     992:	e8 4b 37 00 00       	call   40e2 <printf>
     997:	83 c4 10             	add    $0x10,%esp
  if(exec("echo", echoargv) < 0){
     99a:	83 ec 08             	sub    $0x8,%esp
     99d:	68 38 63 00 00       	push   $0x6338
     9a2:	68 98 44 00 00       	push   $0x4498
     9a7:	e8 fb 35 00 00       	call   3fa7 <exec>
     9ac:	83 c4 10             	add    $0x10,%esp
     9af:	85 c0                	test   %eax,%eax
     9b1:	79 1b                	jns    9ce <exectest+0x50>
    printf(stdout, "exec echo failed\n");
     9b3:	a1 4c 63 00 00       	mov    0x634c,%eax
     9b8:	83 ec 08             	sub    $0x8,%esp
     9bb:	68 f8 48 00 00       	push   $0x48f8
     9c0:	50                   	push   %eax
     9c1:	e8 1c 37 00 00       	call   40e2 <printf>
     9c6:	83 c4 10             	add    $0x10,%esp
    exit();
     9c9:	e8 a1 35 00 00       	call   3f6f <exit>
  }
}
     9ce:	90                   	nop
     9cf:	c9                   	leave  
     9d0:	c3                   	ret    

000009d1 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     9d1:	55                   	push   %ebp
     9d2:	89 e5                	mov    %esp,%ebp
     9d4:	83 ec 28             	sub    $0x28,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     9d7:	83 ec 0c             	sub    $0xc,%esp
     9da:	8d 45 d8             	lea    -0x28(%ebp),%eax
     9dd:	50                   	push   %eax
     9de:	e8 9c 35 00 00       	call   3f7f <pipe>
     9e3:	83 c4 10             	add    $0x10,%esp
     9e6:	85 c0                	test   %eax,%eax
     9e8:	74 17                	je     a01 <pipe1+0x30>
    printf(1, "pipe() failed\n");
     9ea:	83 ec 08             	sub    $0x8,%esp
     9ed:	68 0a 49 00 00       	push   $0x490a
     9f2:	6a 01                	push   $0x1
     9f4:	e8 e9 36 00 00       	call   40e2 <printf>
     9f9:	83 c4 10             	add    $0x10,%esp
    exit();
     9fc:	e8 6e 35 00 00       	call   3f6f <exit>
  }
  pid = fork(0);
     a01:	83 ec 0c             	sub    $0xc,%esp
     a04:	6a 00                	push   $0x0
     a06:	e8 5c 35 00 00       	call   3f67 <fork>
     a0b:	83 c4 10             	add    $0x10,%esp
     a0e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  seq = 0;
     a11:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if(pid == 0){
     a18:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     a1c:	0f 85 89 00 00 00    	jne    aab <pipe1+0xda>
    close(fds[0]);
     a22:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a25:	83 ec 0c             	sub    $0xc,%esp
     a28:	50                   	push   %eax
     a29:	e8 69 35 00 00       	call   3f97 <close>
     a2e:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
     a31:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     a38:	eb 66                	jmp    aa0 <pipe1+0xcf>
      for(i = 0; i < 1033; i++)
     a3a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a41:	eb 19                	jmp    a5c <pipe1+0x8b>
        buf[i] = seq++;
     a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a46:	8d 50 01             	lea    0x1(%eax),%edx
     a49:	89 55 f4             	mov    %edx,-0xc(%ebp)
     a4c:	89 c2                	mov    %eax,%edx
     a4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a51:	05 40 8b 00 00       	add    $0x8b40,%eax
     a56:	88 10                	mov    %dl,(%eax)
      for(i = 0; i < 1033; i++)
     a58:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     a5c:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     a63:	7e de                	jle    a43 <pipe1+0x72>
      if(write(fds[1], buf, 1033) != 1033){
     a65:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a68:	83 ec 04             	sub    $0x4,%esp
     a6b:	68 09 04 00 00       	push   $0x409
     a70:	68 40 8b 00 00       	push   $0x8b40
     a75:	50                   	push   %eax
     a76:	e8 14 35 00 00       	call   3f8f <write>
     a7b:	83 c4 10             	add    $0x10,%esp
     a7e:	3d 09 04 00 00       	cmp    $0x409,%eax
     a83:	74 17                	je     a9c <pipe1+0xcb>
        printf(1, "pipe1 oops 1\n");
     a85:	83 ec 08             	sub    $0x8,%esp
     a88:	68 19 49 00 00       	push   $0x4919
     a8d:	6a 01                	push   $0x1
     a8f:	e8 4e 36 00 00       	call   40e2 <printf>
     a94:	83 c4 10             	add    $0x10,%esp
        exit();
     a97:	e8 d3 34 00 00       	call   3f6f <exit>
    for(n = 0; n < 5; n++){
     a9c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     aa0:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     aa4:	7e 94                	jle    a3a <pipe1+0x69>
      }
    }
    exit();
     aa6:	e8 c4 34 00 00       	call   3f6f <exit>
  } else if(pid > 0){
     aab:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     aaf:	0f 8e f4 00 00 00    	jle    ba9 <pipe1+0x1d8>
    close(fds[1]);
     ab5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ab8:	83 ec 0c             	sub    $0xc,%esp
     abb:	50                   	push   %eax
     abc:	e8 d6 34 00 00       	call   3f97 <close>
     ac1:	83 c4 10             	add    $0x10,%esp
    total = 0;
     ac4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    cc = 1;
     acb:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     ad2:	eb 66                	jmp    b3a <pipe1+0x169>
      for(i = 0; i < n; i++){
     ad4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     adb:	eb 3b                	jmp    b18 <pipe1+0x147>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     add:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ae0:	05 40 8b 00 00       	add    $0x8b40,%eax
     ae5:	0f b6 00             	movzbl (%eax),%eax
     ae8:	0f be c8             	movsbl %al,%ecx
     aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aee:	8d 50 01             	lea    0x1(%eax),%edx
     af1:	89 55 f4             	mov    %edx,-0xc(%ebp)
     af4:	31 c8                	xor    %ecx,%eax
     af6:	0f b6 c0             	movzbl %al,%eax
     af9:	85 c0                	test   %eax,%eax
     afb:	74 17                	je     b14 <pipe1+0x143>
          printf(1, "pipe1 oops 2\n");
     afd:	83 ec 08             	sub    $0x8,%esp
     b00:	68 27 49 00 00       	push   $0x4927
     b05:	6a 01                	push   $0x1
     b07:	e8 d6 35 00 00       	call   40e2 <printf>
     b0c:	83 c4 10             	add    $0x10,%esp
     b0f:	e9 ac 00 00 00       	jmp    bc0 <pipe1+0x1ef>
      for(i = 0; i < n; i++){
     b14:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b18:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b1b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     b1e:	7c bd                	jl     add <pipe1+0x10c>
          return;
        }
      }
      total += n;
     b20:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b23:	01 45 e4             	add    %eax,-0x1c(%ebp)
      cc = cc * 2;
     b26:	d1 65 e8             	shll   -0x18(%ebp)
      if(cc > sizeof(buf))
     b29:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b2c:	3d 00 20 00 00       	cmp    $0x2000,%eax
     b31:	76 07                	jbe    b3a <pipe1+0x169>
        cc = sizeof(buf);
     b33:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     b3a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b3d:	83 ec 04             	sub    $0x4,%esp
     b40:	ff 75 e8             	pushl  -0x18(%ebp)
     b43:	68 40 8b 00 00       	push   $0x8b40
     b48:	50                   	push   %eax
     b49:	e8 39 34 00 00       	call   3f87 <read>
     b4e:	83 c4 10             	add    $0x10,%esp
     b51:	89 45 ec             	mov    %eax,-0x14(%ebp)
     b54:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     b58:	0f 8f 76 ff ff ff    	jg     ad4 <pipe1+0x103>
    }
    if(total != 5 * 1033){
     b5e:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     b65:	74 1a                	je     b81 <pipe1+0x1b0>
      printf(1, "pipe1 oops 3 total %d\n", total);
     b67:	83 ec 04             	sub    $0x4,%esp
     b6a:	ff 75 e4             	pushl  -0x1c(%ebp)
     b6d:	68 35 49 00 00       	push   $0x4935
     b72:	6a 01                	push   $0x1
     b74:	e8 69 35 00 00       	call   40e2 <printf>
     b79:	83 c4 10             	add    $0x10,%esp
      exit();
     b7c:	e8 ee 33 00 00       	call   3f6f <exit>
    }
    close(fds[0]);
     b81:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b84:	83 ec 0c             	sub    $0xc,%esp
     b87:	50                   	push   %eax
     b88:	e8 0a 34 00 00       	call   3f97 <close>
     b8d:	83 c4 10             	add    $0x10,%esp
    wait();
     b90:	e8 e2 33 00 00       	call   3f77 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     b95:	83 ec 08             	sub    $0x8,%esp
     b98:	68 5b 49 00 00       	push   $0x495b
     b9d:	6a 01                	push   $0x1
     b9f:	e8 3e 35 00 00       	call   40e2 <printf>
     ba4:	83 c4 10             	add    $0x10,%esp
     ba7:	eb 17                	jmp    bc0 <pipe1+0x1ef>
    printf(1, "fork() failed\n");
     ba9:	83 ec 08             	sub    $0x8,%esp
     bac:	68 4c 49 00 00       	push   $0x494c
     bb1:	6a 01                	push   $0x1
     bb3:	e8 2a 35 00 00       	call   40e2 <printf>
     bb8:	83 c4 10             	add    $0x10,%esp
    exit();
     bbb:	e8 af 33 00 00       	call   3f6f <exit>
}
     bc0:	c9                   	leave  
     bc1:	c3                   	ret    

00000bc2 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     bc2:	55                   	push   %ebp
     bc3:	89 e5                	mov    %esp,%ebp
     bc5:	83 ec 28             	sub    $0x28,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     bc8:	83 ec 08             	sub    $0x8,%esp
     bcb:	68 65 49 00 00       	push   $0x4965
     bd0:	6a 01                	push   $0x1
     bd2:	e8 0b 35 00 00       	call   40e2 <printf>
     bd7:	83 c4 10             	add    $0x10,%esp
  pid1 = fork(0);
     bda:	83 ec 0c             	sub    $0xc,%esp
     bdd:	6a 00                	push   $0x0
     bdf:	e8 83 33 00 00       	call   3f67 <fork>
     be4:	83 c4 10             	add    $0x10,%esp
     be7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid1 == 0)
     bea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bee:	75 02                	jne    bf2 <preempt+0x30>
    for(;;)
     bf0:	eb fe                	jmp    bf0 <preempt+0x2e>
      ;

  pid2 = fork(0);
     bf2:	83 ec 0c             	sub    $0xc,%esp
     bf5:	6a 00                	push   $0x0
     bf7:	e8 6b 33 00 00       	call   3f67 <fork>
     bfc:	83 c4 10             	add    $0x10,%esp
     bff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid2 == 0)
     c02:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     c06:	75 02                	jne    c0a <preempt+0x48>
    for(;;)
     c08:	eb fe                	jmp    c08 <preempt+0x46>
      ;

  pipe(pfds);
     c0a:	83 ec 0c             	sub    $0xc,%esp
     c0d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     c10:	50                   	push   %eax
     c11:	e8 69 33 00 00       	call   3f7f <pipe>
     c16:	83 c4 10             	add    $0x10,%esp
  pid3 = fork(0);
     c19:	83 ec 0c             	sub    $0xc,%esp
     c1c:	6a 00                	push   $0x0
     c1e:	e8 44 33 00 00       	call   3f67 <fork>
     c23:	83 c4 10             	add    $0x10,%esp
     c26:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid3 == 0){
     c29:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c2d:	75 4d                	jne    c7c <preempt+0xba>
    close(pfds[0]);
     c2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c32:	83 ec 0c             	sub    $0xc,%esp
     c35:	50                   	push   %eax
     c36:	e8 5c 33 00 00       	call   3f97 <close>
     c3b:	83 c4 10             	add    $0x10,%esp
    if(write(pfds[1], "x", 1) != 1)
     c3e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c41:	83 ec 04             	sub    $0x4,%esp
     c44:	6a 01                	push   $0x1
     c46:	68 6f 49 00 00       	push   $0x496f
     c4b:	50                   	push   %eax
     c4c:	e8 3e 33 00 00       	call   3f8f <write>
     c51:	83 c4 10             	add    $0x10,%esp
     c54:	83 f8 01             	cmp    $0x1,%eax
     c57:	74 12                	je     c6b <preempt+0xa9>
      printf(1, "preempt write error");
     c59:	83 ec 08             	sub    $0x8,%esp
     c5c:	68 71 49 00 00       	push   $0x4971
     c61:	6a 01                	push   $0x1
     c63:	e8 7a 34 00 00       	call   40e2 <printf>
     c68:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     c6b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c6e:	83 ec 0c             	sub    $0xc,%esp
     c71:	50                   	push   %eax
     c72:	e8 20 33 00 00       	call   3f97 <close>
     c77:	83 c4 10             	add    $0x10,%esp
    for(;;)
     c7a:	eb fe                	jmp    c7a <preempt+0xb8>
      ;
  }

  close(pfds[1]);
     c7c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c7f:	83 ec 0c             	sub    $0xc,%esp
     c82:	50                   	push   %eax
     c83:	e8 0f 33 00 00       	call   3f97 <close>
     c88:	83 c4 10             	add    $0x10,%esp
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c8b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c8e:	83 ec 04             	sub    $0x4,%esp
     c91:	68 00 20 00 00       	push   $0x2000
     c96:	68 40 8b 00 00       	push   $0x8b40
     c9b:	50                   	push   %eax
     c9c:	e8 e6 32 00 00       	call   3f87 <read>
     ca1:	83 c4 10             	add    $0x10,%esp
     ca4:	83 f8 01             	cmp    $0x1,%eax
     ca7:	74 14                	je     cbd <preempt+0xfb>
    printf(1, "preempt read error");
     ca9:	83 ec 08             	sub    $0x8,%esp
     cac:	68 85 49 00 00       	push   $0x4985
     cb1:	6a 01                	push   $0x1
     cb3:	e8 2a 34 00 00       	call   40e2 <printf>
     cb8:	83 c4 10             	add    $0x10,%esp
     cbb:	eb 7e                	jmp    d3b <preempt+0x179>
    return;
  }
  close(pfds[0]);
     cbd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cc0:	83 ec 0c             	sub    $0xc,%esp
     cc3:	50                   	push   %eax
     cc4:	e8 ce 32 00 00       	call   3f97 <close>
     cc9:	83 c4 10             	add    $0x10,%esp
  printf(1, "kill... ");
     ccc:	83 ec 08             	sub    $0x8,%esp
     ccf:	68 98 49 00 00       	push   $0x4998
     cd4:	6a 01                	push   $0x1
     cd6:	e8 07 34 00 00       	call   40e2 <printf>
     cdb:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
     cde:	83 ec 0c             	sub    $0xc,%esp
     ce1:	ff 75 f4             	pushl  -0xc(%ebp)
     ce4:	e8 b6 32 00 00       	call   3f9f <kill>
     ce9:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
     cec:	83 ec 0c             	sub    $0xc,%esp
     cef:	ff 75 f0             	pushl  -0x10(%ebp)
     cf2:	e8 a8 32 00 00       	call   3f9f <kill>
     cf7:	83 c4 10             	add    $0x10,%esp
  kill(pid3);
     cfa:	83 ec 0c             	sub    $0xc,%esp
     cfd:	ff 75 ec             	pushl  -0x14(%ebp)
     d00:	e8 9a 32 00 00       	call   3f9f <kill>
     d05:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
     d08:	83 ec 08             	sub    $0x8,%esp
     d0b:	68 a1 49 00 00       	push   $0x49a1
     d10:	6a 01                	push   $0x1
     d12:	e8 cb 33 00 00       	call   40e2 <printf>
     d17:	83 c4 10             	add    $0x10,%esp
  wait();
     d1a:	e8 58 32 00 00       	call   3f77 <wait>
  wait();
     d1f:	e8 53 32 00 00       	call   3f77 <wait>
  wait();
     d24:	e8 4e 32 00 00       	call   3f77 <wait>
  printf(1, "preempt ok\n");
     d29:	83 ec 08             	sub    $0x8,%esp
     d2c:	68 aa 49 00 00       	push   $0x49aa
     d31:	6a 01                	push   $0x1
     d33:	e8 aa 33 00 00       	call   40e2 <printf>
     d38:	83 c4 10             	add    $0x10,%esp
}
     d3b:	c9                   	leave  
     d3c:	c3                   	ret    

00000d3d <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     d3d:	55                   	push   %ebp
     d3e:	89 e5                	mov    %esp,%ebp
     d40:	83 ec 18             	sub    $0x18,%esp
  int i, pid;

  for(i = 0; i < 100; i++){
     d43:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d4a:	eb 57                	jmp    da3 <exitwait+0x66>
    pid = fork(0);
     d4c:	83 ec 0c             	sub    $0xc,%esp
     d4f:	6a 00                	push   $0x0
     d51:	e8 11 32 00 00       	call   3f67 <fork>
     d56:	83 c4 10             	add    $0x10,%esp
     d59:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0){
     d5c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d60:	79 14                	jns    d76 <exitwait+0x39>
      printf(1, "fork failed\n");
     d62:	83 ec 08             	sub    $0x8,%esp
     d65:	68 39 45 00 00       	push   $0x4539
     d6a:	6a 01                	push   $0x1
     d6c:	e8 71 33 00 00       	call   40e2 <printf>
     d71:	83 c4 10             	add    $0x10,%esp
      return;
     d74:	eb 45                	jmp    dbb <exitwait+0x7e>
    }
    if(pid){
     d76:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d7a:	74 1e                	je     d9a <exitwait+0x5d>
      if(wait() != pid){
     d7c:	e8 f6 31 00 00       	call   3f77 <wait>
     d81:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     d84:	74 19                	je     d9f <exitwait+0x62>
        printf(1, "wait wrong pid\n");
     d86:	83 ec 08             	sub    $0x8,%esp
     d89:	68 b6 49 00 00       	push   $0x49b6
     d8e:	6a 01                	push   $0x1
     d90:	e8 4d 33 00 00       	call   40e2 <printf>
     d95:	83 c4 10             	add    $0x10,%esp
        return;
     d98:	eb 21                	jmp    dbb <exitwait+0x7e>
      }
    } else {
      exit();
     d9a:	e8 d0 31 00 00       	call   3f6f <exit>
  for(i = 0; i < 100; i++){
     d9f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     da3:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     da7:	7e a3                	jle    d4c <exitwait+0xf>
    }
  }
  printf(1, "exitwait ok\n");
     da9:	83 ec 08             	sub    $0x8,%esp
     dac:	68 c6 49 00 00       	push   $0x49c6
     db1:	6a 01                	push   $0x1
     db3:	e8 2a 33 00 00       	call   40e2 <printf>
     db8:	83 c4 10             	add    $0x10,%esp
}
     dbb:	c9                   	leave  
     dbc:	c3                   	ret    

00000dbd <mem>:

void
mem(void)
{
     dbd:	55                   	push   %ebp
     dbe:	89 e5                	mov    %esp,%ebp
     dc0:	83 ec 18             	sub    $0x18,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     dc3:	83 ec 08             	sub    $0x8,%esp
     dc6:	68 d3 49 00 00       	push   $0x49d3
     dcb:	6a 01                	push   $0x1
     dcd:	e8 10 33 00 00       	call   40e2 <printf>
     dd2:	83 c4 10             	add    $0x10,%esp
  ppid = getpid();
     dd5:	e8 15 32 00 00       	call   3fef <getpid>
     dda:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((pid = fork(0)) == 0){
     ddd:	83 ec 0c             	sub    $0xc,%esp
     de0:	6a 00                	push   $0x0
     de2:	e8 80 31 00 00       	call   3f67 <fork>
     de7:	83 c4 10             	add    $0x10,%esp
     dea:	89 45 ec             	mov    %eax,-0x14(%ebp)
     ded:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     df1:	0f 85 b7 00 00 00    	jne    eae <mem+0xf1>
    m1 = 0;
     df7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     dfe:	eb 0e                	jmp    e0e <mem+0x51>
      *(char**)m2 = m1;
     e00:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e03:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e06:	89 10                	mov    %edx,(%eax)
      m1 = m2;
     e08:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     e0e:	83 ec 0c             	sub    $0xc,%esp
     e11:	68 11 27 00 00       	push   $0x2711
     e16:	e8 9a 35 00 00       	call   43b5 <malloc>
     e1b:	83 c4 10             	add    $0x10,%esp
     e1e:	89 45 e8             	mov    %eax,-0x18(%ebp)
     e21:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     e25:	75 d9                	jne    e00 <mem+0x43>
    }
    while(m1){
     e27:	eb 1c                	jmp    e45 <mem+0x88>
      m2 = *(char**)m1;
     e29:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e2c:	8b 00                	mov    (%eax),%eax
     e2e:	89 45 e8             	mov    %eax,-0x18(%ebp)
      free(m1);
     e31:	83 ec 0c             	sub    $0xc,%esp
     e34:	ff 75 f4             	pushl  -0xc(%ebp)
     e37:	e8 37 34 00 00       	call   4273 <free>
     e3c:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
     e3f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e42:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while(m1){
     e45:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e49:	75 de                	jne    e29 <mem+0x6c>
    }
    m1 = malloc(1024*20);
     e4b:	83 ec 0c             	sub    $0xc,%esp
     e4e:	68 00 50 00 00       	push   $0x5000
     e53:	e8 5d 35 00 00       	call   43b5 <malloc>
     e58:	83 c4 10             	add    $0x10,%esp
     e5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(m1 == 0){
     e5e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e62:	75 25                	jne    e89 <mem+0xcc>
      printf(1, "couldn't allocate mem?!!\n");
     e64:	83 ec 08             	sub    $0x8,%esp
     e67:	68 dd 49 00 00       	push   $0x49dd
     e6c:	6a 01                	push   $0x1
     e6e:	e8 6f 32 00 00       	call   40e2 <printf>
     e73:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
     e76:	83 ec 0c             	sub    $0xc,%esp
     e79:	ff 75 f0             	pushl  -0x10(%ebp)
     e7c:	e8 1e 31 00 00       	call   3f9f <kill>
     e81:	83 c4 10             	add    $0x10,%esp
      exit();
     e84:	e8 e6 30 00 00       	call   3f6f <exit>
    }
    free(m1);
     e89:	83 ec 0c             	sub    $0xc,%esp
     e8c:	ff 75 f4             	pushl  -0xc(%ebp)
     e8f:	e8 df 33 00 00       	call   4273 <free>
     e94:	83 c4 10             	add    $0x10,%esp
    printf(1, "mem ok\n");
     e97:	83 ec 08             	sub    $0x8,%esp
     e9a:	68 f7 49 00 00       	push   $0x49f7
     e9f:	6a 01                	push   $0x1
     ea1:	e8 3c 32 00 00       	call   40e2 <printf>
     ea6:	83 c4 10             	add    $0x10,%esp
    exit();
     ea9:	e8 c1 30 00 00       	call   3f6f <exit>
  } else {
    wait();
     eae:	e8 c4 30 00 00       	call   3f77 <wait>
  }
}
     eb3:	90                   	nop
     eb4:	c9                   	leave  
     eb5:	c3                   	ret    

00000eb6 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     eb6:	55                   	push   %ebp
     eb7:	89 e5                	mov    %esp,%ebp
     eb9:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     ebc:	83 ec 08             	sub    $0x8,%esp
     ebf:	68 ff 49 00 00       	push   $0x49ff
     ec4:	6a 01                	push   $0x1
     ec6:	e8 17 32 00 00       	call   40e2 <printf>
     ecb:	83 c4 10             	add    $0x10,%esp

  unlink("sharedfd");
     ece:	83 ec 0c             	sub    $0xc,%esp
     ed1:	68 0e 4a 00 00       	push   $0x4a0e
     ed6:	e8 e4 30 00 00       	call   3fbf <unlink>
     edb:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", O_CREATE|O_RDWR);
     ede:	83 ec 08             	sub    $0x8,%esp
     ee1:	68 02 02 00 00       	push   $0x202
     ee6:	68 0e 4a 00 00       	push   $0x4a0e
     eeb:	e8 bf 30 00 00       	call   3faf <open>
     ef0:	83 c4 10             	add    $0x10,%esp
     ef3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     ef6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     efa:	79 17                	jns    f13 <sharedfd+0x5d>
    printf(1, "fstests: cannot open sharedfd for writing");
     efc:	83 ec 08             	sub    $0x8,%esp
     eff:	68 18 4a 00 00       	push   $0x4a18
     f04:	6a 01                	push   $0x1
     f06:	e8 d7 31 00 00       	call   40e2 <printf>
     f0b:	83 c4 10             	add    $0x10,%esp
    return;
     f0e:	e9 8c 01 00 00       	jmp    109f <sharedfd+0x1e9>
  }
  pid = fork(0);
     f13:	83 ec 0c             	sub    $0xc,%esp
     f16:	6a 00                	push   $0x0
     f18:	e8 4a 30 00 00       	call   3f67 <fork>
     f1d:	83 c4 10             	add    $0x10,%esp
     f20:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     f23:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     f27:	75 07                	jne    f30 <sharedfd+0x7a>
     f29:	b8 63 00 00 00       	mov    $0x63,%eax
     f2e:	eb 05                	jmp    f35 <sharedfd+0x7f>
     f30:	b8 70 00 00 00       	mov    $0x70,%eax
     f35:	83 ec 04             	sub    $0x4,%esp
     f38:	6a 0a                	push   $0xa
     f3a:	50                   	push   %eax
     f3b:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     f3e:	50                   	push   %eax
     f3f:	e8 90 2e 00 00       	call   3dd4 <memset>
     f44:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 1000; i++){
     f47:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f4e:	eb 31                	jmp    f81 <sharedfd+0xcb>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     f50:	83 ec 04             	sub    $0x4,%esp
     f53:	6a 0a                	push   $0xa
     f55:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     f58:	50                   	push   %eax
     f59:	ff 75 e8             	pushl  -0x18(%ebp)
     f5c:	e8 2e 30 00 00       	call   3f8f <write>
     f61:	83 c4 10             	add    $0x10,%esp
     f64:	83 f8 0a             	cmp    $0xa,%eax
     f67:	74 14                	je     f7d <sharedfd+0xc7>
      printf(1, "fstests: write sharedfd failed\n");
     f69:	83 ec 08             	sub    $0x8,%esp
     f6c:	68 44 4a 00 00       	push   $0x4a44
     f71:	6a 01                	push   $0x1
     f73:	e8 6a 31 00 00       	call   40e2 <printf>
     f78:	83 c4 10             	add    $0x10,%esp
      break;
     f7b:	eb 0d                	jmp    f8a <sharedfd+0xd4>
  for(i = 0; i < 1000; i++){
     f7d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f81:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
     f88:	7e c6                	jle    f50 <sharedfd+0x9a>
    }
  }
  if(pid == 0)
     f8a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     f8e:	75 05                	jne    f95 <sharedfd+0xdf>
    exit();
     f90:	e8 da 2f 00 00       	call   3f6f <exit>
  else
    wait();
     f95:	e8 dd 2f 00 00       	call   3f77 <wait>
  close(fd);
     f9a:	83 ec 0c             	sub    $0xc,%esp
     f9d:	ff 75 e8             	pushl  -0x18(%ebp)
     fa0:	e8 f2 2f 00 00       	call   3f97 <close>
     fa5:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", 0);
     fa8:	83 ec 08             	sub    $0x8,%esp
     fab:	6a 00                	push   $0x0
     fad:	68 0e 4a 00 00       	push   $0x4a0e
     fb2:	e8 f8 2f 00 00       	call   3faf <open>
     fb7:	83 c4 10             	add    $0x10,%esp
     fba:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     fbd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     fc1:	79 17                	jns    fda <sharedfd+0x124>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     fc3:	83 ec 08             	sub    $0x8,%esp
     fc6:	68 64 4a 00 00       	push   $0x4a64
     fcb:	6a 01                	push   $0x1
     fcd:	e8 10 31 00 00       	call   40e2 <printf>
     fd2:	83 c4 10             	add    $0x10,%esp
    return;
     fd5:	e9 c5 00 00 00       	jmp    109f <sharedfd+0x1e9>
  }
  nc = np = 0;
     fda:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     fe1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fe4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     fe7:	eb 3b                	jmp    1024 <sharedfd+0x16e>
    for(i = 0; i < sizeof(buf); i++){
     fe9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ff0:	eb 2a                	jmp    101c <sharedfd+0x166>
      if(buf[i] == 'c')
     ff2:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     ff5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ff8:	01 d0                	add    %edx,%eax
     ffa:	0f b6 00             	movzbl (%eax),%eax
     ffd:	3c 63                	cmp    $0x63,%al
     fff:	75 04                	jne    1005 <sharedfd+0x14f>
        nc++;
    1001:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(buf[i] == 'p')
    1005:	8d 55 d6             	lea    -0x2a(%ebp),%edx
    1008:	8b 45 f4             	mov    -0xc(%ebp),%eax
    100b:	01 d0                	add    %edx,%eax
    100d:	0f b6 00             	movzbl (%eax),%eax
    1010:	3c 70                	cmp    $0x70,%al
    1012:	75 04                	jne    1018 <sharedfd+0x162>
        np++;
    1014:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    for(i = 0; i < sizeof(buf); i++){
    1018:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    101c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    101f:	83 f8 09             	cmp    $0x9,%eax
    1022:	76 ce                	jbe    ff2 <sharedfd+0x13c>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1024:	83 ec 04             	sub    $0x4,%esp
    1027:	6a 0a                	push   $0xa
    1029:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    102c:	50                   	push   %eax
    102d:	ff 75 e8             	pushl  -0x18(%ebp)
    1030:	e8 52 2f 00 00       	call   3f87 <read>
    1035:	83 c4 10             	add    $0x10,%esp
    1038:	89 45 e0             	mov    %eax,-0x20(%ebp)
    103b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    103f:	7f a8                	jg     fe9 <sharedfd+0x133>
    }
  }
  close(fd);
    1041:	83 ec 0c             	sub    $0xc,%esp
    1044:	ff 75 e8             	pushl  -0x18(%ebp)
    1047:	e8 4b 2f 00 00       	call   3f97 <close>
    104c:	83 c4 10             	add    $0x10,%esp
  unlink("sharedfd");
    104f:	83 ec 0c             	sub    $0xc,%esp
    1052:	68 0e 4a 00 00       	push   $0x4a0e
    1057:	e8 63 2f 00 00       	call   3fbf <unlink>
    105c:	83 c4 10             	add    $0x10,%esp
  if(nc == 10000 && np == 10000){
    105f:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
    1066:	75 1d                	jne    1085 <sharedfd+0x1cf>
    1068:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
    106f:	75 14                	jne    1085 <sharedfd+0x1cf>
    printf(1, "sharedfd ok\n");
    1071:	83 ec 08             	sub    $0x8,%esp
    1074:	68 8f 4a 00 00       	push   $0x4a8f
    1079:	6a 01                	push   $0x1
    107b:	e8 62 30 00 00       	call   40e2 <printf>
    1080:	83 c4 10             	add    $0x10,%esp
    1083:	eb 1a                	jmp    109f <sharedfd+0x1e9>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1085:	ff 75 ec             	pushl  -0x14(%ebp)
    1088:	ff 75 f0             	pushl  -0x10(%ebp)
    108b:	68 9c 4a 00 00       	push   $0x4a9c
    1090:	6a 01                	push   $0x1
    1092:	e8 4b 30 00 00       	call   40e2 <printf>
    1097:	83 c4 10             	add    $0x10,%esp
    exit();
    109a:	e8 d0 2e 00 00       	call   3f6f <exit>
  }
}
    109f:	c9                   	leave  
    10a0:	c3                   	ret    

000010a1 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    10a1:	55                   	push   %ebp
    10a2:	89 e5                	mov    %esp,%ebp
    10a4:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    10a7:	c7 45 c8 b1 4a 00 00 	movl   $0x4ab1,-0x38(%ebp)
    10ae:	c7 45 cc b4 4a 00 00 	movl   $0x4ab4,-0x34(%ebp)
    10b5:	c7 45 d0 b7 4a 00 00 	movl   $0x4ab7,-0x30(%ebp)
    10bc:	c7 45 d4 ba 4a 00 00 	movl   $0x4aba,-0x2c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    10c3:	83 ec 08             	sub    $0x8,%esp
    10c6:	68 bd 4a 00 00       	push   $0x4abd
    10cb:	6a 01                	push   $0x1
    10cd:	e8 10 30 00 00       	call   40e2 <printf>
    10d2:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    10d5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    10dc:	e9 f8 00 00 00       	jmp    11d9 <fourfiles+0x138>
    fname = names[pi];
    10e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10e4:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    10e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    unlink(fname);
    10eb:	83 ec 0c             	sub    $0xc,%esp
    10ee:	ff 75 e4             	pushl  -0x1c(%ebp)
    10f1:	e8 c9 2e 00 00       	call   3fbf <unlink>
    10f6:	83 c4 10             	add    $0x10,%esp

    pid = fork(0);
    10f9:	83 ec 0c             	sub    $0xc,%esp
    10fc:	6a 00                	push   $0x0
    10fe:	e8 64 2e 00 00       	call   3f67 <fork>
    1103:	83 c4 10             	add    $0x10,%esp
    1106:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if(pid < 0){
    1109:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    110d:	79 17                	jns    1126 <fourfiles+0x85>
      printf(1, "fork failed\n");
    110f:	83 ec 08             	sub    $0x8,%esp
    1112:	68 39 45 00 00       	push   $0x4539
    1117:	6a 01                	push   $0x1
    1119:	e8 c4 2f 00 00       	call   40e2 <printf>
    111e:	83 c4 10             	add    $0x10,%esp
      exit();
    1121:	e8 49 2e 00 00       	call   3f6f <exit>
    }

    if(pid == 0){
    1126:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    112a:	0f 85 a5 00 00 00    	jne    11d5 <fourfiles+0x134>
      fd = open(fname, O_CREATE | O_RDWR);
    1130:	83 ec 08             	sub    $0x8,%esp
    1133:	68 02 02 00 00       	push   $0x202
    1138:	ff 75 e4             	pushl  -0x1c(%ebp)
    113b:	e8 6f 2e 00 00       	call   3faf <open>
    1140:	83 c4 10             	add    $0x10,%esp
    1143:	89 45 dc             	mov    %eax,-0x24(%ebp)
      if(fd < 0){
    1146:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
    114a:	79 17                	jns    1163 <fourfiles+0xc2>
        printf(1, "create failed\n");
    114c:	83 ec 08             	sub    $0x8,%esp
    114f:	68 cd 4a 00 00       	push   $0x4acd
    1154:	6a 01                	push   $0x1
    1156:	e8 87 2f 00 00       	call   40e2 <printf>
    115b:	83 c4 10             	add    $0x10,%esp
        exit();
    115e:	e8 0c 2e 00 00       	call   3f6f <exit>
      }
      
      memset(buf, '0'+pi, 512);
    1163:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1166:	83 c0 30             	add    $0x30,%eax
    1169:	83 ec 04             	sub    $0x4,%esp
    116c:	68 00 02 00 00       	push   $0x200
    1171:	50                   	push   %eax
    1172:	68 40 8b 00 00       	push   $0x8b40
    1177:	e8 58 2c 00 00       	call   3dd4 <memset>
    117c:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 12; i++){
    117f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1186:	eb 42                	jmp    11ca <fourfiles+0x129>
        if((n = write(fd, buf, 500)) != 500){
    1188:	83 ec 04             	sub    $0x4,%esp
    118b:	68 f4 01 00 00       	push   $0x1f4
    1190:	68 40 8b 00 00       	push   $0x8b40
    1195:	ff 75 dc             	pushl  -0x24(%ebp)
    1198:	e8 f2 2d 00 00       	call   3f8f <write>
    119d:	83 c4 10             	add    $0x10,%esp
    11a0:	89 45 d8             	mov    %eax,-0x28(%ebp)
    11a3:	81 7d d8 f4 01 00 00 	cmpl   $0x1f4,-0x28(%ebp)
    11aa:	74 1a                	je     11c6 <fourfiles+0x125>
          printf(1, "write failed %d\n", n);
    11ac:	83 ec 04             	sub    $0x4,%esp
    11af:	ff 75 d8             	pushl  -0x28(%ebp)
    11b2:	68 dc 4a 00 00       	push   $0x4adc
    11b7:	6a 01                	push   $0x1
    11b9:	e8 24 2f 00 00       	call   40e2 <printf>
    11be:	83 c4 10             	add    $0x10,%esp
          exit();
    11c1:	e8 a9 2d 00 00       	call   3f6f <exit>
      for(i = 0; i < 12; i++){
    11c6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    11ca:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    11ce:	7e b8                	jle    1188 <fourfiles+0xe7>
        }
      }
      exit();
    11d0:	e8 9a 2d 00 00       	call   3f6f <exit>
  for(pi = 0; pi < 4; pi++){
    11d5:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11d9:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    11dd:	0f 8e fe fe ff ff    	jle    10e1 <fourfiles+0x40>
    }
  }

  for(pi = 0; pi < 4; pi++){
    11e3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    11ea:	eb 09                	jmp    11f5 <fourfiles+0x154>
    wait();
    11ec:	e8 86 2d 00 00       	call   3f77 <wait>
  for(pi = 0; pi < 4; pi++){
    11f1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11f5:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    11f9:	7e f1                	jle    11ec <fourfiles+0x14b>
  }

  for(i = 0; i < 2; i++){
    11fb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1202:	e9 d4 00 00 00       	jmp    12db <fourfiles+0x23a>
    fname = names[i];
    1207:	8b 45 f4             	mov    -0xc(%ebp),%eax
    120a:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    120e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    fd = open(fname, 0);
    1211:	83 ec 08             	sub    $0x8,%esp
    1214:	6a 00                	push   $0x0
    1216:	ff 75 e4             	pushl  -0x1c(%ebp)
    1219:	e8 91 2d 00 00       	call   3faf <open>
    121e:	83 c4 10             	add    $0x10,%esp
    1221:	89 45 dc             	mov    %eax,-0x24(%ebp)
    total = 0;
    1224:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    122b:	eb 4a                	jmp    1277 <fourfiles+0x1d6>
      for(j = 0; j < n; j++){
    122d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1234:	eb 33                	jmp    1269 <fourfiles+0x1c8>
        if(buf[j] != '0'+i){
    1236:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1239:	05 40 8b 00 00       	add    $0x8b40,%eax
    123e:	0f b6 00             	movzbl (%eax),%eax
    1241:	0f be c0             	movsbl %al,%eax
    1244:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1247:	83 c2 30             	add    $0x30,%edx
    124a:	39 d0                	cmp    %edx,%eax
    124c:	74 17                	je     1265 <fourfiles+0x1c4>
          printf(1, "wrong char\n");
    124e:	83 ec 08             	sub    $0x8,%esp
    1251:	68 ed 4a 00 00       	push   $0x4aed
    1256:	6a 01                	push   $0x1
    1258:	e8 85 2e 00 00       	call   40e2 <printf>
    125d:	83 c4 10             	add    $0x10,%esp
          exit();
    1260:	e8 0a 2d 00 00       	call   3f6f <exit>
      for(j = 0; j < n; j++){
    1265:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1269:	8b 45 f0             	mov    -0x10(%ebp),%eax
    126c:	3b 45 d8             	cmp    -0x28(%ebp),%eax
    126f:	7c c5                	jl     1236 <fourfiles+0x195>
        }
      }
      total += n;
    1271:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1274:	01 45 ec             	add    %eax,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1277:	83 ec 04             	sub    $0x4,%esp
    127a:	68 00 20 00 00       	push   $0x2000
    127f:	68 40 8b 00 00       	push   $0x8b40
    1284:	ff 75 dc             	pushl  -0x24(%ebp)
    1287:	e8 fb 2c 00 00       	call   3f87 <read>
    128c:	83 c4 10             	add    $0x10,%esp
    128f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    1292:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    1296:	7f 95                	jg     122d <fourfiles+0x18c>
    }
    close(fd);
    1298:	83 ec 0c             	sub    $0xc,%esp
    129b:	ff 75 dc             	pushl  -0x24(%ebp)
    129e:	e8 f4 2c 00 00       	call   3f97 <close>
    12a3:	83 c4 10             	add    $0x10,%esp
    if(total != 12*500){
    12a6:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
    12ad:	74 1a                	je     12c9 <fourfiles+0x228>
      printf(1, "wrong length %d\n", total);
    12af:	83 ec 04             	sub    $0x4,%esp
    12b2:	ff 75 ec             	pushl  -0x14(%ebp)
    12b5:	68 f9 4a 00 00       	push   $0x4af9
    12ba:	6a 01                	push   $0x1
    12bc:	e8 21 2e 00 00       	call   40e2 <printf>
    12c1:	83 c4 10             	add    $0x10,%esp
      exit();
    12c4:	e8 a6 2c 00 00       	call   3f6f <exit>
    }
    unlink(fname);
    12c9:	83 ec 0c             	sub    $0xc,%esp
    12cc:	ff 75 e4             	pushl  -0x1c(%ebp)
    12cf:	e8 eb 2c 00 00       	call   3fbf <unlink>
    12d4:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 2; i++){
    12d7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    12db:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
    12df:	0f 8e 22 ff ff ff    	jle    1207 <fourfiles+0x166>
  }

  printf(1, "fourfiles ok\n");
    12e5:	83 ec 08             	sub    $0x8,%esp
    12e8:	68 0a 4b 00 00       	push   $0x4b0a
    12ed:	6a 01                	push   $0x1
    12ef:	e8 ee 2d 00 00       	call   40e2 <printf>
    12f4:	83 c4 10             	add    $0x10,%esp
}
    12f7:	90                   	nop
    12f8:	c9                   	leave  
    12f9:	c3                   	ret    

000012fa <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    12fa:	55                   	push   %ebp
    12fb:	89 e5                	mov    %esp,%ebp
    12fd:	83 ec 38             	sub    $0x38,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    1300:	83 ec 08             	sub    $0x8,%esp
    1303:	68 18 4b 00 00       	push   $0x4b18
    1308:	6a 01                	push   $0x1
    130a:	e8 d3 2d 00 00       	call   40e2 <printf>
    130f:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    1312:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1319:	e9 fe 00 00 00       	jmp    141c <createdelete+0x122>
    pid = fork(0);
    131e:	83 ec 0c             	sub    $0xc,%esp
    1321:	6a 00                	push   $0x0
    1323:	e8 3f 2c 00 00       	call   3f67 <fork>
    1328:	83 c4 10             	add    $0x10,%esp
    132b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid < 0){
    132e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1332:	79 17                	jns    134b <createdelete+0x51>
      printf(1, "fork failed\n");
    1334:	83 ec 08             	sub    $0x8,%esp
    1337:	68 39 45 00 00       	push   $0x4539
    133c:	6a 01                	push   $0x1
    133e:	e8 9f 2d 00 00       	call   40e2 <printf>
    1343:	83 c4 10             	add    $0x10,%esp
      exit();
    1346:	e8 24 2c 00 00       	call   3f6f <exit>
    }

    if(pid == 0){
    134b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    134f:	0f 85 c3 00 00 00    	jne    1418 <createdelete+0x11e>
      name[0] = 'p' + pi;
    1355:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1358:	83 c0 70             	add    $0x70,%eax
    135b:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[2] = '\0';
    135e:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
      for(i = 0; i < N; i++){
    1362:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1369:	e9 9b 00 00 00       	jmp    1409 <createdelete+0x10f>
        name[1] = '0' + i;
    136e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1371:	83 c0 30             	add    $0x30,%eax
    1374:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1377:	83 ec 08             	sub    $0x8,%esp
    137a:	68 02 02 00 00       	push   $0x202
    137f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1382:	50                   	push   %eax
    1383:	e8 27 2c 00 00       	call   3faf <open>
    1388:	83 c4 10             	add    $0x10,%esp
    138b:	89 45 e8             	mov    %eax,-0x18(%ebp)
        if(fd < 0){
    138e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1392:	79 17                	jns    13ab <createdelete+0xb1>
          printf(1, "create failed\n");
    1394:	83 ec 08             	sub    $0x8,%esp
    1397:	68 cd 4a 00 00       	push   $0x4acd
    139c:	6a 01                	push   $0x1
    139e:	e8 3f 2d 00 00       	call   40e2 <printf>
    13a3:	83 c4 10             	add    $0x10,%esp
          exit();
    13a6:	e8 c4 2b 00 00       	call   3f6f <exit>
        }
        close(fd);
    13ab:	83 ec 0c             	sub    $0xc,%esp
    13ae:	ff 75 e8             	pushl  -0x18(%ebp)
    13b1:	e8 e1 2b 00 00       	call   3f97 <close>
    13b6:	83 c4 10             	add    $0x10,%esp
        if(i > 0 && (i % 2 ) == 0){
    13b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13bd:	7e 46                	jle    1405 <createdelete+0x10b>
    13bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13c2:	83 e0 01             	and    $0x1,%eax
    13c5:	85 c0                	test   %eax,%eax
    13c7:	75 3c                	jne    1405 <createdelete+0x10b>
          name[1] = '0' + (i / 2);
    13c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13cc:	89 c2                	mov    %eax,%edx
    13ce:	c1 ea 1f             	shr    $0x1f,%edx
    13d1:	01 d0                	add    %edx,%eax
    13d3:	d1 f8                	sar    %eax
    13d5:	83 c0 30             	add    $0x30,%eax
    13d8:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    13db:	83 ec 0c             	sub    $0xc,%esp
    13de:	8d 45 c8             	lea    -0x38(%ebp),%eax
    13e1:	50                   	push   %eax
    13e2:	e8 d8 2b 00 00       	call   3fbf <unlink>
    13e7:	83 c4 10             	add    $0x10,%esp
    13ea:	85 c0                	test   %eax,%eax
    13ec:	79 17                	jns    1405 <createdelete+0x10b>
            printf(1, "unlink failed\n");
    13ee:	83 ec 08             	sub    $0x8,%esp
    13f1:	68 bc 45 00 00       	push   $0x45bc
    13f6:	6a 01                	push   $0x1
    13f8:	e8 e5 2c 00 00       	call   40e2 <printf>
    13fd:	83 c4 10             	add    $0x10,%esp
            exit();
    1400:	e8 6a 2b 00 00       	call   3f6f <exit>
      for(i = 0; i < N; i++){
    1405:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1409:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    140d:	0f 8e 5b ff ff ff    	jle    136e <createdelete+0x74>
          }
        }
      }
      exit();
    1413:	e8 57 2b 00 00       	call   3f6f <exit>
  for(pi = 0; pi < 4; pi++){
    1418:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    141c:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    1420:	0f 8e f8 fe ff ff    	jle    131e <createdelete+0x24>
    }
  }

  for(pi = 0; pi < 4; pi++){
    1426:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    142d:	eb 09                	jmp    1438 <createdelete+0x13e>
    wait();
    142f:	e8 43 2b 00 00       	call   3f77 <wait>
  for(pi = 0; pi < 4; pi++){
    1434:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1438:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    143c:	7e f1                	jle    142f <createdelete+0x135>
  }

  name[0] = name[1] = name[2] = 0;
    143e:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1442:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
    1446:	88 45 c9             	mov    %al,-0x37(%ebp)
    1449:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
    144d:	88 45 c8             	mov    %al,-0x38(%ebp)
  for(i = 0; i < N; i++){
    1450:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1457:	e9 b2 00 00 00       	jmp    150e <createdelete+0x214>
    for(pi = 0; pi < 4; pi++){
    145c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1463:	e9 98 00 00 00       	jmp    1500 <createdelete+0x206>
      name[0] = 'p' + pi;
    1468:	8b 45 f0             	mov    -0x10(%ebp),%eax
    146b:	83 c0 70             	add    $0x70,%eax
    146e:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1471:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1474:	83 c0 30             	add    $0x30,%eax
    1477:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    147a:	83 ec 08             	sub    $0x8,%esp
    147d:	6a 00                	push   $0x0
    147f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1482:	50                   	push   %eax
    1483:	e8 27 2b 00 00       	call   3faf <open>
    1488:	83 c4 10             	add    $0x10,%esp
    148b:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    148e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1492:	74 06                	je     149a <createdelete+0x1a0>
    1494:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1498:	7e 21                	jle    14bb <createdelete+0x1c1>
    149a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    149e:	79 1b                	jns    14bb <createdelete+0x1c1>
        printf(1, "oops createdelete %s didn't exist\n", name);
    14a0:	83 ec 04             	sub    $0x4,%esp
    14a3:	8d 45 c8             	lea    -0x38(%ebp),%eax
    14a6:	50                   	push   %eax
    14a7:	68 2c 4b 00 00       	push   $0x4b2c
    14ac:	6a 01                	push   $0x1
    14ae:	e8 2f 2c 00 00       	call   40e2 <printf>
    14b3:	83 c4 10             	add    $0x10,%esp
        exit();
    14b6:	e8 b4 2a 00 00       	call   3f6f <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    14bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14bf:	7e 27                	jle    14e8 <createdelete+0x1ee>
    14c1:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    14c5:	7f 21                	jg     14e8 <createdelete+0x1ee>
    14c7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    14cb:	78 1b                	js     14e8 <createdelete+0x1ee>
        printf(1, "oops createdelete %s did exist\n", name);
    14cd:	83 ec 04             	sub    $0x4,%esp
    14d0:	8d 45 c8             	lea    -0x38(%ebp),%eax
    14d3:	50                   	push   %eax
    14d4:	68 50 4b 00 00       	push   $0x4b50
    14d9:	6a 01                	push   $0x1
    14db:	e8 02 2c 00 00       	call   40e2 <printf>
    14e0:	83 c4 10             	add    $0x10,%esp
        exit();
    14e3:	e8 87 2a 00 00       	call   3f6f <exit>
      }
      if(fd >= 0)
    14e8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    14ec:	78 0e                	js     14fc <createdelete+0x202>
        close(fd);
    14ee:	83 ec 0c             	sub    $0xc,%esp
    14f1:	ff 75 e8             	pushl  -0x18(%ebp)
    14f4:	e8 9e 2a 00 00       	call   3f97 <close>
    14f9:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    14fc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1500:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    1504:	0f 8e 5e ff ff ff    	jle    1468 <createdelete+0x16e>
  for(i = 0; i < N; i++){
    150a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    150e:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1512:	0f 8e 44 ff ff ff    	jle    145c <createdelete+0x162>
    }
  }

  for(i = 0; i < N; i++){
    1518:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    151f:	eb 38                	jmp    1559 <createdelete+0x25f>
    for(pi = 0; pi < 4; pi++){
    1521:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1528:	eb 25                	jmp    154f <createdelete+0x255>
      name[0] = 'p' + i;
    152a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152d:	83 c0 70             	add    $0x70,%eax
    1530:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1533:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1536:	83 c0 30             	add    $0x30,%eax
    1539:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    153c:	83 ec 0c             	sub    $0xc,%esp
    153f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1542:	50                   	push   %eax
    1543:	e8 77 2a 00 00       	call   3fbf <unlink>
    1548:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    154b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    154f:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    1553:	7e d5                	jle    152a <createdelete+0x230>
  for(i = 0; i < N; i++){
    1555:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1559:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    155d:	7e c2                	jle    1521 <createdelete+0x227>
    }
  }

  printf(1, "createdelete ok\n");
    155f:	83 ec 08             	sub    $0x8,%esp
    1562:	68 70 4b 00 00       	push   $0x4b70
    1567:	6a 01                	push   $0x1
    1569:	e8 74 2b 00 00       	call   40e2 <printf>
    156e:	83 c4 10             	add    $0x10,%esp
}
    1571:	90                   	nop
    1572:	c9                   	leave  
    1573:	c3                   	ret    

00001574 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1574:	55                   	push   %ebp
    1575:	89 e5                	mov    %esp,%ebp
    1577:	83 ec 18             	sub    $0x18,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    157a:	83 ec 08             	sub    $0x8,%esp
    157d:	68 81 4b 00 00       	push   $0x4b81
    1582:	6a 01                	push   $0x1
    1584:	e8 59 2b 00 00       	call   40e2 <printf>
    1589:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_CREATE | O_RDWR);
    158c:	83 ec 08             	sub    $0x8,%esp
    158f:	68 02 02 00 00       	push   $0x202
    1594:	68 92 4b 00 00       	push   $0x4b92
    1599:	e8 11 2a 00 00       	call   3faf <open>
    159e:	83 c4 10             	add    $0x10,%esp
    15a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    15a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15a8:	79 17                	jns    15c1 <unlinkread+0x4d>
    printf(1, "create unlinkread failed\n");
    15aa:	83 ec 08             	sub    $0x8,%esp
    15ad:	68 9d 4b 00 00       	push   $0x4b9d
    15b2:	6a 01                	push   $0x1
    15b4:	e8 29 2b 00 00       	call   40e2 <printf>
    15b9:	83 c4 10             	add    $0x10,%esp
    exit();
    15bc:	e8 ae 29 00 00       	call   3f6f <exit>
  }
  write(fd, "hello", 5);
    15c1:	83 ec 04             	sub    $0x4,%esp
    15c4:	6a 05                	push   $0x5
    15c6:	68 b7 4b 00 00       	push   $0x4bb7
    15cb:	ff 75 f4             	pushl  -0xc(%ebp)
    15ce:	e8 bc 29 00 00       	call   3f8f <write>
    15d3:	83 c4 10             	add    $0x10,%esp
  close(fd);
    15d6:	83 ec 0c             	sub    $0xc,%esp
    15d9:	ff 75 f4             	pushl  -0xc(%ebp)
    15dc:	e8 b6 29 00 00       	call   3f97 <close>
    15e1:	83 c4 10             	add    $0x10,%esp

  fd = open("unlinkread", O_RDWR);
    15e4:	83 ec 08             	sub    $0x8,%esp
    15e7:	6a 02                	push   $0x2
    15e9:	68 92 4b 00 00       	push   $0x4b92
    15ee:	e8 bc 29 00 00       	call   3faf <open>
    15f3:	83 c4 10             	add    $0x10,%esp
    15f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    15f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15fd:	79 17                	jns    1616 <unlinkread+0xa2>
    printf(1, "open unlinkread failed\n");
    15ff:	83 ec 08             	sub    $0x8,%esp
    1602:	68 bd 4b 00 00       	push   $0x4bbd
    1607:	6a 01                	push   $0x1
    1609:	e8 d4 2a 00 00       	call   40e2 <printf>
    160e:	83 c4 10             	add    $0x10,%esp
    exit();
    1611:	e8 59 29 00 00       	call   3f6f <exit>
  }
  if(unlink("unlinkread") != 0){
    1616:	83 ec 0c             	sub    $0xc,%esp
    1619:	68 92 4b 00 00       	push   $0x4b92
    161e:	e8 9c 29 00 00       	call   3fbf <unlink>
    1623:	83 c4 10             	add    $0x10,%esp
    1626:	85 c0                	test   %eax,%eax
    1628:	74 17                	je     1641 <unlinkread+0xcd>
    printf(1, "unlink unlinkread failed\n");
    162a:	83 ec 08             	sub    $0x8,%esp
    162d:	68 d5 4b 00 00       	push   $0x4bd5
    1632:	6a 01                	push   $0x1
    1634:	e8 a9 2a 00 00       	call   40e2 <printf>
    1639:	83 c4 10             	add    $0x10,%esp
    exit();
    163c:	e8 2e 29 00 00       	call   3f6f <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1641:	83 ec 08             	sub    $0x8,%esp
    1644:	68 02 02 00 00       	push   $0x202
    1649:	68 92 4b 00 00       	push   $0x4b92
    164e:	e8 5c 29 00 00       	call   3faf <open>
    1653:	83 c4 10             	add    $0x10,%esp
    1656:	89 45 f0             	mov    %eax,-0x10(%ebp)
  write(fd1, "yyy", 3);
    1659:	83 ec 04             	sub    $0x4,%esp
    165c:	6a 03                	push   $0x3
    165e:	68 ef 4b 00 00       	push   $0x4bef
    1663:	ff 75 f0             	pushl  -0x10(%ebp)
    1666:	e8 24 29 00 00       	call   3f8f <write>
    166b:	83 c4 10             	add    $0x10,%esp
  close(fd1);
    166e:	83 ec 0c             	sub    $0xc,%esp
    1671:	ff 75 f0             	pushl  -0x10(%ebp)
    1674:	e8 1e 29 00 00       	call   3f97 <close>
    1679:	83 c4 10             	add    $0x10,%esp

  if(read(fd, buf, sizeof(buf)) != 5){
    167c:	83 ec 04             	sub    $0x4,%esp
    167f:	68 00 20 00 00       	push   $0x2000
    1684:	68 40 8b 00 00       	push   $0x8b40
    1689:	ff 75 f4             	pushl  -0xc(%ebp)
    168c:	e8 f6 28 00 00       	call   3f87 <read>
    1691:	83 c4 10             	add    $0x10,%esp
    1694:	83 f8 05             	cmp    $0x5,%eax
    1697:	74 17                	je     16b0 <unlinkread+0x13c>
    printf(1, "unlinkread read failed");
    1699:	83 ec 08             	sub    $0x8,%esp
    169c:	68 f3 4b 00 00       	push   $0x4bf3
    16a1:	6a 01                	push   $0x1
    16a3:	e8 3a 2a 00 00       	call   40e2 <printf>
    16a8:	83 c4 10             	add    $0x10,%esp
    exit();
    16ab:	e8 bf 28 00 00       	call   3f6f <exit>
  }
  if(buf[0] != 'h'){
    16b0:	0f b6 05 40 8b 00 00 	movzbl 0x8b40,%eax
    16b7:	3c 68                	cmp    $0x68,%al
    16b9:	74 17                	je     16d2 <unlinkread+0x15e>
    printf(1, "unlinkread wrong data\n");
    16bb:	83 ec 08             	sub    $0x8,%esp
    16be:	68 0a 4c 00 00       	push   $0x4c0a
    16c3:	6a 01                	push   $0x1
    16c5:	e8 18 2a 00 00       	call   40e2 <printf>
    16ca:	83 c4 10             	add    $0x10,%esp
    exit();
    16cd:	e8 9d 28 00 00       	call   3f6f <exit>
  }
  if(write(fd, buf, 10) != 10){
    16d2:	83 ec 04             	sub    $0x4,%esp
    16d5:	6a 0a                	push   $0xa
    16d7:	68 40 8b 00 00       	push   $0x8b40
    16dc:	ff 75 f4             	pushl  -0xc(%ebp)
    16df:	e8 ab 28 00 00       	call   3f8f <write>
    16e4:	83 c4 10             	add    $0x10,%esp
    16e7:	83 f8 0a             	cmp    $0xa,%eax
    16ea:	74 17                	je     1703 <unlinkread+0x18f>
    printf(1, "unlinkread write failed\n");
    16ec:	83 ec 08             	sub    $0x8,%esp
    16ef:	68 21 4c 00 00       	push   $0x4c21
    16f4:	6a 01                	push   $0x1
    16f6:	e8 e7 29 00 00       	call   40e2 <printf>
    16fb:	83 c4 10             	add    $0x10,%esp
    exit();
    16fe:	e8 6c 28 00 00       	call   3f6f <exit>
  }
  close(fd);
    1703:	83 ec 0c             	sub    $0xc,%esp
    1706:	ff 75 f4             	pushl  -0xc(%ebp)
    1709:	e8 89 28 00 00       	call   3f97 <close>
    170e:	83 c4 10             	add    $0x10,%esp
  unlink("unlinkread");
    1711:	83 ec 0c             	sub    $0xc,%esp
    1714:	68 92 4b 00 00       	push   $0x4b92
    1719:	e8 a1 28 00 00       	call   3fbf <unlink>
    171e:	83 c4 10             	add    $0x10,%esp
  printf(1, "unlinkread ok\n");
    1721:	83 ec 08             	sub    $0x8,%esp
    1724:	68 3a 4c 00 00       	push   $0x4c3a
    1729:	6a 01                	push   $0x1
    172b:	e8 b2 29 00 00       	call   40e2 <printf>
    1730:	83 c4 10             	add    $0x10,%esp
}
    1733:	90                   	nop
    1734:	c9                   	leave  
    1735:	c3                   	ret    

00001736 <linktest>:

void
linktest(void)
{
    1736:	55                   	push   %ebp
    1737:	89 e5                	mov    %esp,%ebp
    1739:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "linktest\n");
    173c:	83 ec 08             	sub    $0x8,%esp
    173f:	68 49 4c 00 00       	push   $0x4c49
    1744:	6a 01                	push   $0x1
    1746:	e8 97 29 00 00       	call   40e2 <printf>
    174b:	83 c4 10             	add    $0x10,%esp

  unlink("lf1");
    174e:	83 ec 0c             	sub    $0xc,%esp
    1751:	68 53 4c 00 00       	push   $0x4c53
    1756:	e8 64 28 00 00       	call   3fbf <unlink>
    175b:	83 c4 10             	add    $0x10,%esp
  unlink("lf2");
    175e:	83 ec 0c             	sub    $0xc,%esp
    1761:	68 57 4c 00 00       	push   $0x4c57
    1766:	e8 54 28 00 00       	call   3fbf <unlink>
    176b:	83 c4 10             	add    $0x10,%esp

  fd = open("lf1", O_CREATE|O_RDWR);
    176e:	83 ec 08             	sub    $0x8,%esp
    1771:	68 02 02 00 00       	push   $0x202
    1776:	68 53 4c 00 00       	push   $0x4c53
    177b:	e8 2f 28 00 00       	call   3faf <open>
    1780:	83 c4 10             	add    $0x10,%esp
    1783:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1786:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    178a:	79 17                	jns    17a3 <linktest+0x6d>
    printf(1, "create lf1 failed\n");
    178c:	83 ec 08             	sub    $0x8,%esp
    178f:	68 5b 4c 00 00       	push   $0x4c5b
    1794:	6a 01                	push   $0x1
    1796:	e8 47 29 00 00       	call   40e2 <printf>
    179b:	83 c4 10             	add    $0x10,%esp
    exit();
    179e:	e8 cc 27 00 00       	call   3f6f <exit>
  }
  if(write(fd, "hello", 5) != 5){
    17a3:	83 ec 04             	sub    $0x4,%esp
    17a6:	6a 05                	push   $0x5
    17a8:	68 b7 4b 00 00       	push   $0x4bb7
    17ad:	ff 75 f4             	pushl  -0xc(%ebp)
    17b0:	e8 da 27 00 00       	call   3f8f <write>
    17b5:	83 c4 10             	add    $0x10,%esp
    17b8:	83 f8 05             	cmp    $0x5,%eax
    17bb:	74 17                	je     17d4 <linktest+0x9e>
    printf(1, "write lf1 failed\n");
    17bd:	83 ec 08             	sub    $0x8,%esp
    17c0:	68 6e 4c 00 00       	push   $0x4c6e
    17c5:	6a 01                	push   $0x1
    17c7:	e8 16 29 00 00       	call   40e2 <printf>
    17cc:	83 c4 10             	add    $0x10,%esp
    exit();
    17cf:	e8 9b 27 00 00       	call   3f6f <exit>
  }
  close(fd);
    17d4:	83 ec 0c             	sub    $0xc,%esp
    17d7:	ff 75 f4             	pushl  -0xc(%ebp)
    17da:	e8 b8 27 00 00       	call   3f97 <close>
    17df:	83 c4 10             	add    $0x10,%esp

  if(link("lf1", "lf2") < 0){
    17e2:	83 ec 08             	sub    $0x8,%esp
    17e5:	68 57 4c 00 00       	push   $0x4c57
    17ea:	68 53 4c 00 00       	push   $0x4c53
    17ef:	e8 db 27 00 00       	call   3fcf <link>
    17f4:	83 c4 10             	add    $0x10,%esp
    17f7:	85 c0                	test   %eax,%eax
    17f9:	79 17                	jns    1812 <linktest+0xdc>
    printf(1, "link lf1 lf2 failed\n");
    17fb:	83 ec 08             	sub    $0x8,%esp
    17fe:	68 80 4c 00 00       	push   $0x4c80
    1803:	6a 01                	push   $0x1
    1805:	e8 d8 28 00 00       	call   40e2 <printf>
    180a:	83 c4 10             	add    $0x10,%esp
    exit();
    180d:	e8 5d 27 00 00       	call   3f6f <exit>
  }
  unlink("lf1");
    1812:	83 ec 0c             	sub    $0xc,%esp
    1815:	68 53 4c 00 00       	push   $0x4c53
    181a:	e8 a0 27 00 00       	call   3fbf <unlink>
    181f:	83 c4 10             	add    $0x10,%esp

  if(open("lf1", 0) >= 0){
    1822:	83 ec 08             	sub    $0x8,%esp
    1825:	6a 00                	push   $0x0
    1827:	68 53 4c 00 00       	push   $0x4c53
    182c:	e8 7e 27 00 00       	call   3faf <open>
    1831:	83 c4 10             	add    $0x10,%esp
    1834:	85 c0                	test   %eax,%eax
    1836:	78 17                	js     184f <linktest+0x119>
    printf(1, "unlinked lf1 but it is still there!\n");
    1838:	83 ec 08             	sub    $0x8,%esp
    183b:	68 98 4c 00 00       	push   $0x4c98
    1840:	6a 01                	push   $0x1
    1842:	e8 9b 28 00 00       	call   40e2 <printf>
    1847:	83 c4 10             	add    $0x10,%esp
    exit();
    184a:	e8 20 27 00 00       	call   3f6f <exit>
  }

  fd = open("lf2", 0);
    184f:	83 ec 08             	sub    $0x8,%esp
    1852:	6a 00                	push   $0x0
    1854:	68 57 4c 00 00       	push   $0x4c57
    1859:	e8 51 27 00 00       	call   3faf <open>
    185e:	83 c4 10             	add    $0x10,%esp
    1861:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1864:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1868:	79 17                	jns    1881 <linktest+0x14b>
    printf(1, "open lf2 failed\n");
    186a:	83 ec 08             	sub    $0x8,%esp
    186d:	68 bd 4c 00 00       	push   $0x4cbd
    1872:	6a 01                	push   $0x1
    1874:	e8 69 28 00 00       	call   40e2 <printf>
    1879:	83 c4 10             	add    $0x10,%esp
    exit();
    187c:	e8 ee 26 00 00       	call   3f6f <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1881:	83 ec 04             	sub    $0x4,%esp
    1884:	68 00 20 00 00       	push   $0x2000
    1889:	68 40 8b 00 00       	push   $0x8b40
    188e:	ff 75 f4             	pushl  -0xc(%ebp)
    1891:	e8 f1 26 00 00       	call   3f87 <read>
    1896:	83 c4 10             	add    $0x10,%esp
    1899:	83 f8 05             	cmp    $0x5,%eax
    189c:	74 17                	je     18b5 <linktest+0x17f>
    printf(1, "read lf2 failed\n");
    189e:	83 ec 08             	sub    $0x8,%esp
    18a1:	68 ce 4c 00 00       	push   $0x4cce
    18a6:	6a 01                	push   $0x1
    18a8:	e8 35 28 00 00       	call   40e2 <printf>
    18ad:	83 c4 10             	add    $0x10,%esp
    exit();
    18b0:	e8 ba 26 00 00       	call   3f6f <exit>
  }
  close(fd);
    18b5:	83 ec 0c             	sub    $0xc,%esp
    18b8:	ff 75 f4             	pushl  -0xc(%ebp)
    18bb:	e8 d7 26 00 00       	call   3f97 <close>
    18c0:	83 c4 10             	add    $0x10,%esp

  if(link("lf2", "lf2") >= 0){
    18c3:	83 ec 08             	sub    $0x8,%esp
    18c6:	68 57 4c 00 00       	push   $0x4c57
    18cb:	68 57 4c 00 00       	push   $0x4c57
    18d0:	e8 fa 26 00 00       	call   3fcf <link>
    18d5:	83 c4 10             	add    $0x10,%esp
    18d8:	85 c0                	test   %eax,%eax
    18da:	78 17                	js     18f3 <linktest+0x1bd>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    18dc:	83 ec 08             	sub    $0x8,%esp
    18df:	68 df 4c 00 00       	push   $0x4cdf
    18e4:	6a 01                	push   $0x1
    18e6:	e8 f7 27 00 00       	call   40e2 <printf>
    18eb:	83 c4 10             	add    $0x10,%esp
    exit();
    18ee:	e8 7c 26 00 00       	call   3f6f <exit>
  }

  unlink("lf2");
    18f3:	83 ec 0c             	sub    $0xc,%esp
    18f6:	68 57 4c 00 00       	push   $0x4c57
    18fb:	e8 bf 26 00 00       	call   3fbf <unlink>
    1900:	83 c4 10             	add    $0x10,%esp
  if(link("lf2", "lf1") >= 0){
    1903:	83 ec 08             	sub    $0x8,%esp
    1906:	68 53 4c 00 00       	push   $0x4c53
    190b:	68 57 4c 00 00       	push   $0x4c57
    1910:	e8 ba 26 00 00       	call   3fcf <link>
    1915:	83 c4 10             	add    $0x10,%esp
    1918:	85 c0                	test   %eax,%eax
    191a:	78 17                	js     1933 <linktest+0x1fd>
    printf(1, "link non-existant succeeded! oops\n");
    191c:	83 ec 08             	sub    $0x8,%esp
    191f:	68 00 4d 00 00       	push   $0x4d00
    1924:	6a 01                	push   $0x1
    1926:	e8 b7 27 00 00       	call   40e2 <printf>
    192b:	83 c4 10             	add    $0x10,%esp
    exit();
    192e:	e8 3c 26 00 00       	call   3f6f <exit>
  }

  if(link(".", "lf1") >= 0){
    1933:	83 ec 08             	sub    $0x8,%esp
    1936:	68 53 4c 00 00       	push   $0x4c53
    193b:	68 23 4d 00 00       	push   $0x4d23
    1940:	e8 8a 26 00 00       	call   3fcf <link>
    1945:	83 c4 10             	add    $0x10,%esp
    1948:	85 c0                	test   %eax,%eax
    194a:	78 17                	js     1963 <linktest+0x22d>
    printf(1, "link . lf1 succeeded! oops\n");
    194c:	83 ec 08             	sub    $0x8,%esp
    194f:	68 25 4d 00 00       	push   $0x4d25
    1954:	6a 01                	push   $0x1
    1956:	e8 87 27 00 00       	call   40e2 <printf>
    195b:	83 c4 10             	add    $0x10,%esp
    exit();
    195e:	e8 0c 26 00 00       	call   3f6f <exit>
  }

  printf(1, "linktest ok\n");
    1963:	83 ec 08             	sub    $0x8,%esp
    1966:	68 41 4d 00 00       	push   $0x4d41
    196b:	6a 01                	push   $0x1
    196d:	e8 70 27 00 00       	call   40e2 <printf>
    1972:	83 c4 10             	add    $0x10,%esp
}
    1975:	90                   	nop
    1976:	c9                   	leave  
    1977:	c3                   	ret    

00001978 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1978:	55                   	push   %ebp
    1979:	89 e5                	mov    %esp,%ebp
    197b:	83 ec 58             	sub    $0x58,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    197e:	83 ec 08             	sub    $0x8,%esp
    1981:	68 4e 4d 00 00       	push   $0x4d4e
    1986:	6a 01                	push   $0x1
    1988:	e8 55 27 00 00       	call   40e2 <printf>
    198d:	83 c4 10             	add    $0x10,%esp
  file[0] = 'C';
    1990:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    1994:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    1998:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    199f:	e9 04 01 00 00       	jmp    1aa8 <concreate+0x130>
    file[1] = '0' + i;
    19a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a7:	83 c0 30             	add    $0x30,%eax
    19aa:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    19ad:	83 ec 0c             	sub    $0xc,%esp
    19b0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19b3:	50                   	push   %eax
    19b4:	e8 06 26 00 00       	call   3fbf <unlink>
    19b9:	83 c4 10             	add    $0x10,%esp
    pid = fork(0);
    19bc:	83 ec 0c             	sub    $0xc,%esp
    19bf:	6a 00                	push   $0x0
    19c1:	e8 a1 25 00 00       	call   3f67 <fork>
    19c6:	83 c4 10             	add    $0x10,%esp
    19c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid && (i % 3) == 1){
    19cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19d0:	74 3b                	je     1a0d <concreate+0x95>
    19d2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    19d5:	ba 56 55 55 55       	mov    $0x55555556,%edx
    19da:	89 c8                	mov    %ecx,%eax
    19dc:	f7 ea                	imul   %edx
    19de:	89 c8                	mov    %ecx,%eax
    19e0:	c1 f8 1f             	sar    $0x1f,%eax
    19e3:	29 c2                	sub    %eax,%edx
    19e5:	89 d0                	mov    %edx,%eax
    19e7:	01 c0                	add    %eax,%eax
    19e9:	01 d0                	add    %edx,%eax
    19eb:	29 c1                	sub    %eax,%ecx
    19ed:	89 ca                	mov    %ecx,%edx
    19ef:	83 fa 01             	cmp    $0x1,%edx
    19f2:	75 19                	jne    1a0d <concreate+0x95>
      link("C0", file);
    19f4:	83 ec 08             	sub    $0x8,%esp
    19f7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19fa:	50                   	push   %eax
    19fb:	68 5e 4d 00 00       	push   $0x4d5e
    1a00:	e8 ca 25 00 00       	call   3fcf <link>
    1a05:	83 c4 10             	add    $0x10,%esp
    1a08:	e9 87 00 00 00       	jmp    1a94 <concreate+0x11c>
    } else if(pid == 0 && (i % 5) == 1){
    1a0d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a11:	75 3b                	jne    1a4e <concreate+0xd6>
    1a13:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1a16:	ba 67 66 66 66       	mov    $0x66666667,%edx
    1a1b:	89 c8                	mov    %ecx,%eax
    1a1d:	f7 ea                	imul   %edx
    1a1f:	d1 fa                	sar    %edx
    1a21:	89 c8                	mov    %ecx,%eax
    1a23:	c1 f8 1f             	sar    $0x1f,%eax
    1a26:	29 c2                	sub    %eax,%edx
    1a28:	89 d0                	mov    %edx,%eax
    1a2a:	c1 e0 02             	shl    $0x2,%eax
    1a2d:	01 d0                	add    %edx,%eax
    1a2f:	29 c1                	sub    %eax,%ecx
    1a31:	89 ca                	mov    %ecx,%edx
    1a33:	83 fa 01             	cmp    $0x1,%edx
    1a36:	75 16                	jne    1a4e <concreate+0xd6>
      link("C0", file);
    1a38:	83 ec 08             	sub    $0x8,%esp
    1a3b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1a3e:	50                   	push   %eax
    1a3f:	68 5e 4d 00 00       	push   $0x4d5e
    1a44:	e8 86 25 00 00       	call   3fcf <link>
    1a49:	83 c4 10             	add    $0x10,%esp
    1a4c:	eb 46                	jmp    1a94 <concreate+0x11c>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    1a4e:	83 ec 08             	sub    $0x8,%esp
    1a51:	68 02 02 00 00       	push   $0x202
    1a56:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1a59:	50                   	push   %eax
    1a5a:	e8 50 25 00 00       	call   3faf <open>
    1a5f:	83 c4 10             	add    $0x10,%esp
    1a62:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(fd < 0){
    1a65:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1a69:	79 1b                	jns    1a86 <concreate+0x10e>
        printf(1, "concreate create %s failed\n", file);
    1a6b:	83 ec 04             	sub    $0x4,%esp
    1a6e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1a71:	50                   	push   %eax
    1a72:	68 61 4d 00 00       	push   $0x4d61
    1a77:	6a 01                	push   $0x1
    1a79:	e8 64 26 00 00       	call   40e2 <printf>
    1a7e:	83 c4 10             	add    $0x10,%esp
        exit();
    1a81:	e8 e9 24 00 00       	call   3f6f <exit>
      }
      close(fd);
    1a86:	83 ec 0c             	sub    $0xc,%esp
    1a89:	ff 75 e8             	pushl  -0x18(%ebp)
    1a8c:	e8 06 25 00 00       	call   3f97 <close>
    1a91:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1a94:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a98:	75 05                	jne    1a9f <concreate+0x127>
      exit();
    1a9a:	e8 d0 24 00 00       	call   3f6f <exit>
    else
      wait();
    1a9f:	e8 d3 24 00 00       	call   3f77 <wait>
  for(i = 0; i < 40; i++){
    1aa4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1aa8:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1aac:	0f 8e f2 fe ff ff    	jle    19a4 <concreate+0x2c>
  }

  memset(fa, 0, sizeof(fa));
    1ab2:	83 ec 04             	sub    $0x4,%esp
    1ab5:	6a 28                	push   $0x28
    1ab7:	6a 00                	push   $0x0
    1ab9:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1abc:	50                   	push   %eax
    1abd:	e8 12 23 00 00       	call   3dd4 <memset>
    1ac2:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    1ac5:	83 ec 08             	sub    $0x8,%esp
    1ac8:	6a 00                	push   $0x0
    1aca:	68 23 4d 00 00       	push   $0x4d23
    1acf:	e8 db 24 00 00       	call   3faf <open>
    1ad4:	83 c4 10             	add    $0x10,%esp
    1ad7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  n = 0;
    1ada:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    1ae1:	e9 93 00 00 00       	jmp    1b79 <concreate+0x201>
    if(de.inum == 0)
    1ae6:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    1aea:	66 85 c0             	test   %ax,%ax
    1aed:	75 05                	jne    1af4 <concreate+0x17c>
      continue;
    1aef:	e9 85 00 00 00       	jmp    1b79 <concreate+0x201>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1af4:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    1af8:	3c 43                	cmp    $0x43,%al
    1afa:	75 7d                	jne    1b79 <concreate+0x201>
    1afc:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    1b00:	84 c0                	test   %al,%al
    1b02:	75 75                	jne    1b79 <concreate+0x201>
      i = de.name[1] - '0';
    1b04:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    1b08:	0f be c0             	movsbl %al,%eax
    1b0b:	83 e8 30             	sub    $0x30,%eax
    1b0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    1b11:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1b15:	78 08                	js     1b1f <concreate+0x1a7>
    1b17:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b1a:	83 f8 27             	cmp    $0x27,%eax
    1b1d:	76 1e                	jbe    1b3d <concreate+0x1c5>
        printf(1, "concreate weird file %s\n", de.name);
    1b1f:	83 ec 04             	sub    $0x4,%esp
    1b22:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1b25:	83 c0 02             	add    $0x2,%eax
    1b28:	50                   	push   %eax
    1b29:	68 7d 4d 00 00       	push   $0x4d7d
    1b2e:	6a 01                	push   $0x1
    1b30:	e8 ad 25 00 00       	call   40e2 <printf>
    1b35:	83 c4 10             	add    $0x10,%esp
        exit();
    1b38:	e8 32 24 00 00       	call   3f6f <exit>
      }
      if(fa[i]){
    1b3d:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1b40:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b43:	01 d0                	add    %edx,%eax
    1b45:	0f b6 00             	movzbl (%eax),%eax
    1b48:	84 c0                	test   %al,%al
    1b4a:	74 1e                	je     1b6a <concreate+0x1f2>
        printf(1, "concreate duplicate file %s\n", de.name);
    1b4c:	83 ec 04             	sub    $0x4,%esp
    1b4f:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1b52:	83 c0 02             	add    $0x2,%eax
    1b55:	50                   	push   %eax
    1b56:	68 96 4d 00 00       	push   $0x4d96
    1b5b:	6a 01                	push   $0x1
    1b5d:	e8 80 25 00 00       	call   40e2 <printf>
    1b62:	83 c4 10             	add    $0x10,%esp
        exit();
    1b65:	e8 05 24 00 00       	call   3f6f <exit>
      }
      fa[i] = 1;
    1b6a:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1b6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b70:	01 d0                	add    %edx,%eax
    1b72:	c6 00 01             	movb   $0x1,(%eax)
      n++;
    1b75:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    1b79:	83 ec 04             	sub    $0x4,%esp
    1b7c:	6a 10                	push   $0x10
    1b7e:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1b81:	50                   	push   %eax
    1b82:	ff 75 e8             	pushl  -0x18(%ebp)
    1b85:	e8 fd 23 00 00       	call   3f87 <read>
    1b8a:	83 c4 10             	add    $0x10,%esp
    1b8d:	85 c0                	test   %eax,%eax
    1b8f:	0f 8f 51 ff ff ff    	jg     1ae6 <concreate+0x16e>
    }
  }
  close(fd);
    1b95:	83 ec 0c             	sub    $0xc,%esp
    1b98:	ff 75 e8             	pushl  -0x18(%ebp)
    1b9b:	e8 f7 23 00 00       	call   3f97 <close>
    1ba0:	83 c4 10             	add    $0x10,%esp

  if(n != 40){
    1ba3:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    1ba7:	74 17                	je     1bc0 <concreate+0x248>
    printf(1, "concreate not enough files in directory listing\n");
    1ba9:	83 ec 08             	sub    $0x8,%esp
    1bac:	68 b4 4d 00 00       	push   $0x4db4
    1bb1:	6a 01                	push   $0x1
    1bb3:	e8 2a 25 00 00       	call   40e2 <printf>
    1bb8:	83 c4 10             	add    $0x10,%esp
    exit();
    1bbb:	e8 af 23 00 00       	call   3f6f <exit>
  }

  for(i = 0; i < 40; i++){
    1bc0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1bc7:	e9 4d 01 00 00       	jmp    1d19 <concreate+0x3a1>
    file[1] = '0' + i;
    1bcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bcf:	83 c0 30             	add    $0x30,%eax
    1bd2:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork(0);
    1bd5:	83 ec 0c             	sub    $0xc,%esp
    1bd8:	6a 00                	push   $0x0
    1bda:	e8 88 23 00 00       	call   3f67 <fork>
    1bdf:	83 c4 10             	add    $0x10,%esp
    1be2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid < 0){
    1be5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1be9:	79 17                	jns    1c02 <concreate+0x28a>
      printf(1, "fork failed\n");
    1beb:	83 ec 08             	sub    $0x8,%esp
    1bee:	68 39 45 00 00       	push   $0x4539
    1bf3:	6a 01                	push   $0x1
    1bf5:	e8 e8 24 00 00       	call   40e2 <printf>
    1bfa:	83 c4 10             	add    $0x10,%esp
      exit();
    1bfd:	e8 6d 23 00 00       	call   3f6f <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    1c02:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1c05:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1c0a:	89 c8                	mov    %ecx,%eax
    1c0c:	f7 ea                	imul   %edx
    1c0e:	89 c8                	mov    %ecx,%eax
    1c10:	c1 f8 1f             	sar    $0x1f,%eax
    1c13:	29 c2                	sub    %eax,%edx
    1c15:	89 d0                	mov    %edx,%eax
    1c17:	89 c2                	mov    %eax,%edx
    1c19:	01 d2                	add    %edx,%edx
    1c1b:	01 c2                	add    %eax,%edx
    1c1d:	89 c8                	mov    %ecx,%eax
    1c1f:	29 d0                	sub    %edx,%eax
    1c21:	85 c0                	test   %eax,%eax
    1c23:	75 06                	jne    1c2b <concreate+0x2b3>
    1c25:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c29:	74 28                	je     1c53 <concreate+0x2db>
       ((i % 3) == 1 && pid != 0)){
    1c2b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1c2e:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1c33:	89 c8                	mov    %ecx,%eax
    1c35:	f7 ea                	imul   %edx
    1c37:	89 c8                	mov    %ecx,%eax
    1c39:	c1 f8 1f             	sar    $0x1f,%eax
    1c3c:	29 c2                	sub    %eax,%edx
    1c3e:	89 d0                	mov    %edx,%eax
    1c40:	01 c0                	add    %eax,%eax
    1c42:	01 d0                	add    %edx,%eax
    1c44:	29 c1                	sub    %eax,%ecx
    1c46:	89 ca                	mov    %ecx,%edx
    if(((i % 3) == 0 && pid == 0) ||
    1c48:	83 fa 01             	cmp    $0x1,%edx
    1c4b:	75 7c                	jne    1cc9 <concreate+0x351>
       ((i % 3) == 1 && pid != 0)){
    1c4d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c51:	74 76                	je     1cc9 <concreate+0x351>
      close(open(file, 0));
    1c53:	83 ec 08             	sub    $0x8,%esp
    1c56:	6a 00                	push   $0x0
    1c58:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c5b:	50                   	push   %eax
    1c5c:	e8 4e 23 00 00       	call   3faf <open>
    1c61:	83 c4 10             	add    $0x10,%esp
    1c64:	83 ec 0c             	sub    $0xc,%esp
    1c67:	50                   	push   %eax
    1c68:	e8 2a 23 00 00       	call   3f97 <close>
    1c6d:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1c70:	83 ec 08             	sub    $0x8,%esp
    1c73:	6a 00                	push   $0x0
    1c75:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c78:	50                   	push   %eax
    1c79:	e8 31 23 00 00       	call   3faf <open>
    1c7e:	83 c4 10             	add    $0x10,%esp
    1c81:	83 ec 0c             	sub    $0xc,%esp
    1c84:	50                   	push   %eax
    1c85:	e8 0d 23 00 00       	call   3f97 <close>
    1c8a:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1c8d:	83 ec 08             	sub    $0x8,%esp
    1c90:	6a 00                	push   $0x0
    1c92:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c95:	50                   	push   %eax
    1c96:	e8 14 23 00 00       	call   3faf <open>
    1c9b:	83 c4 10             	add    $0x10,%esp
    1c9e:	83 ec 0c             	sub    $0xc,%esp
    1ca1:	50                   	push   %eax
    1ca2:	e8 f0 22 00 00       	call   3f97 <close>
    1ca7:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1caa:	83 ec 08             	sub    $0x8,%esp
    1cad:	6a 00                	push   $0x0
    1caf:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1cb2:	50                   	push   %eax
    1cb3:	e8 f7 22 00 00       	call   3faf <open>
    1cb8:	83 c4 10             	add    $0x10,%esp
    1cbb:	83 ec 0c             	sub    $0xc,%esp
    1cbe:	50                   	push   %eax
    1cbf:	e8 d3 22 00 00       	call   3f97 <close>
    1cc4:	83 c4 10             	add    $0x10,%esp
    1cc7:	eb 3c                	jmp    1d05 <concreate+0x38d>
    } else {
      unlink(file);
    1cc9:	83 ec 0c             	sub    $0xc,%esp
    1ccc:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1ccf:	50                   	push   %eax
    1cd0:	e8 ea 22 00 00       	call   3fbf <unlink>
    1cd5:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1cd8:	83 ec 0c             	sub    $0xc,%esp
    1cdb:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1cde:	50                   	push   %eax
    1cdf:	e8 db 22 00 00       	call   3fbf <unlink>
    1ce4:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1ce7:	83 ec 0c             	sub    $0xc,%esp
    1cea:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1ced:	50                   	push   %eax
    1cee:	e8 cc 22 00 00       	call   3fbf <unlink>
    1cf3:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1cf6:	83 ec 0c             	sub    $0xc,%esp
    1cf9:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1cfc:	50                   	push   %eax
    1cfd:	e8 bd 22 00 00       	call   3fbf <unlink>
    1d02:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1d05:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d09:	75 05                	jne    1d10 <concreate+0x398>
      exit();
    1d0b:	e8 5f 22 00 00       	call   3f6f <exit>
    else
      wait();
    1d10:	e8 62 22 00 00       	call   3f77 <wait>
  for(i = 0; i < 40; i++){
    1d15:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1d19:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1d1d:	0f 8e a9 fe ff ff    	jle    1bcc <concreate+0x254>
  }

  printf(1, "concreate ok\n");
    1d23:	83 ec 08             	sub    $0x8,%esp
    1d26:	68 e5 4d 00 00       	push   $0x4de5
    1d2b:	6a 01                	push   $0x1
    1d2d:	e8 b0 23 00 00       	call   40e2 <printf>
    1d32:	83 c4 10             	add    $0x10,%esp
}
    1d35:	90                   	nop
    1d36:	c9                   	leave  
    1d37:	c3                   	ret    

00001d38 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1d38:	55                   	push   %ebp
    1d39:	89 e5                	mov    %esp,%ebp
    1d3b:	83 ec 18             	sub    $0x18,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1d3e:	83 ec 08             	sub    $0x8,%esp
    1d41:	68 f3 4d 00 00       	push   $0x4df3
    1d46:	6a 01                	push   $0x1
    1d48:	e8 95 23 00 00       	call   40e2 <printf>
    1d4d:	83 c4 10             	add    $0x10,%esp

  unlink("x");
    1d50:	83 ec 0c             	sub    $0xc,%esp
    1d53:	68 6f 49 00 00       	push   $0x496f
    1d58:	e8 62 22 00 00       	call   3fbf <unlink>
    1d5d:	83 c4 10             	add    $0x10,%esp
  pid = fork(0);
    1d60:	83 ec 0c             	sub    $0xc,%esp
    1d63:	6a 00                	push   $0x0
    1d65:	e8 fd 21 00 00       	call   3f67 <fork>
    1d6a:	83 c4 10             	add    $0x10,%esp
    1d6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid < 0){
    1d70:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d74:	79 17                	jns    1d8d <linkunlink+0x55>
    printf(1, "fork failed\n");
    1d76:	83 ec 08             	sub    $0x8,%esp
    1d79:	68 39 45 00 00       	push   $0x4539
    1d7e:	6a 01                	push   $0x1
    1d80:	e8 5d 23 00 00       	call   40e2 <printf>
    1d85:	83 c4 10             	add    $0x10,%esp
    exit();
    1d88:	e8 e2 21 00 00       	call   3f6f <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    1d8d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d91:	74 07                	je     1d9a <linkunlink+0x62>
    1d93:	b8 01 00 00 00       	mov    $0x1,%eax
    1d98:	eb 05                	jmp    1d9f <linkunlink+0x67>
    1d9a:	b8 61 00 00 00       	mov    $0x61,%eax
    1d9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 100; i++){
    1da2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1da9:	e9 9a 00 00 00       	jmp    1e48 <linkunlink+0x110>
    x = x * 1103515245 + 12345;
    1dae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1db1:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1db7:	05 39 30 00 00       	add    $0x3039,%eax
    1dbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((x % 3) == 0){
    1dbf:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1dc2:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1dc7:	89 c8                	mov    %ecx,%eax
    1dc9:	f7 e2                	mul    %edx
    1dcb:	89 d0                	mov    %edx,%eax
    1dcd:	d1 e8                	shr    %eax
    1dcf:	89 c2                	mov    %eax,%edx
    1dd1:	01 d2                	add    %edx,%edx
    1dd3:	01 c2                	add    %eax,%edx
    1dd5:	89 c8                	mov    %ecx,%eax
    1dd7:	29 d0                	sub    %edx,%eax
    1dd9:	85 c0                	test   %eax,%eax
    1ddb:	75 23                	jne    1e00 <linkunlink+0xc8>
      close(open("x", O_RDWR | O_CREATE));
    1ddd:	83 ec 08             	sub    $0x8,%esp
    1de0:	68 02 02 00 00       	push   $0x202
    1de5:	68 6f 49 00 00       	push   $0x496f
    1dea:	e8 c0 21 00 00       	call   3faf <open>
    1def:	83 c4 10             	add    $0x10,%esp
    1df2:	83 ec 0c             	sub    $0xc,%esp
    1df5:	50                   	push   %eax
    1df6:	e8 9c 21 00 00       	call   3f97 <close>
    1dfb:	83 c4 10             	add    $0x10,%esp
    1dfe:	eb 44                	jmp    1e44 <linkunlink+0x10c>
    } else if((x % 3) == 1){
    1e00:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1e03:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1e08:	89 c8                	mov    %ecx,%eax
    1e0a:	f7 e2                	mul    %edx
    1e0c:	d1 ea                	shr    %edx
    1e0e:	89 d0                	mov    %edx,%eax
    1e10:	01 c0                	add    %eax,%eax
    1e12:	01 d0                	add    %edx,%eax
    1e14:	29 c1                	sub    %eax,%ecx
    1e16:	89 ca                	mov    %ecx,%edx
    1e18:	83 fa 01             	cmp    $0x1,%edx
    1e1b:	75 17                	jne    1e34 <linkunlink+0xfc>
      link("cat", "x");
    1e1d:	83 ec 08             	sub    $0x8,%esp
    1e20:	68 6f 49 00 00       	push   $0x496f
    1e25:	68 04 4e 00 00       	push   $0x4e04
    1e2a:	e8 a0 21 00 00       	call   3fcf <link>
    1e2f:	83 c4 10             	add    $0x10,%esp
    1e32:	eb 10                	jmp    1e44 <linkunlink+0x10c>
    } else {
      unlink("x");
    1e34:	83 ec 0c             	sub    $0xc,%esp
    1e37:	68 6f 49 00 00       	push   $0x496f
    1e3c:	e8 7e 21 00 00       	call   3fbf <unlink>
    1e41:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1e44:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1e48:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1e4c:	0f 8e 5c ff ff ff    	jle    1dae <linkunlink+0x76>
    }
  }

  if(pid)
    1e52:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1e56:	74 07                	je     1e5f <linkunlink+0x127>
    wait();
    1e58:	e8 1a 21 00 00       	call   3f77 <wait>
    1e5d:	eb 05                	jmp    1e64 <linkunlink+0x12c>
  else 
    exit();
    1e5f:	e8 0b 21 00 00       	call   3f6f <exit>

  printf(1, "linkunlink ok\n");
    1e64:	83 ec 08             	sub    $0x8,%esp
    1e67:	68 08 4e 00 00       	push   $0x4e08
    1e6c:	6a 01                	push   $0x1
    1e6e:	e8 6f 22 00 00       	call   40e2 <printf>
    1e73:	83 c4 10             	add    $0x10,%esp
}
    1e76:	90                   	nop
    1e77:	c9                   	leave  
    1e78:	c3                   	ret    

00001e79 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1e79:	55                   	push   %ebp
    1e7a:	89 e5                	mov    %esp,%ebp
    1e7c:	83 ec 28             	sub    $0x28,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1e7f:	83 ec 08             	sub    $0x8,%esp
    1e82:	68 17 4e 00 00       	push   $0x4e17
    1e87:	6a 01                	push   $0x1
    1e89:	e8 54 22 00 00       	call   40e2 <printf>
    1e8e:	83 c4 10             	add    $0x10,%esp
  unlink("bd");
    1e91:	83 ec 0c             	sub    $0xc,%esp
    1e94:	68 24 4e 00 00       	push   $0x4e24
    1e99:	e8 21 21 00 00       	call   3fbf <unlink>
    1e9e:	83 c4 10             	add    $0x10,%esp

  fd = open("bd", O_CREATE);
    1ea1:	83 ec 08             	sub    $0x8,%esp
    1ea4:	68 00 02 00 00       	push   $0x200
    1ea9:	68 24 4e 00 00       	push   $0x4e24
    1eae:	e8 fc 20 00 00       	call   3faf <open>
    1eb3:	83 c4 10             	add    $0x10,%esp
    1eb6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0){
    1eb9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1ebd:	79 17                	jns    1ed6 <bigdir+0x5d>
    printf(1, "bigdir create failed\n");
    1ebf:	83 ec 08             	sub    $0x8,%esp
    1ec2:	68 27 4e 00 00       	push   $0x4e27
    1ec7:	6a 01                	push   $0x1
    1ec9:	e8 14 22 00 00       	call   40e2 <printf>
    1ece:	83 c4 10             	add    $0x10,%esp
    exit();
    1ed1:	e8 99 20 00 00       	call   3f6f <exit>
  }
  close(fd);
    1ed6:	83 ec 0c             	sub    $0xc,%esp
    1ed9:	ff 75 f0             	pushl  -0x10(%ebp)
    1edc:	e8 b6 20 00 00       	call   3f97 <close>
    1ee1:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    1ee4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1eeb:	eb 63                	jmp    1f50 <bigdir+0xd7>
    name[0] = 'x';
    1eed:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1ef1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ef4:	8d 50 3f             	lea    0x3f(%eax),%edx
    1ef7:	85 c0                	test   %eax,%eax
    1ef9:	0f 48 c2             	cmovs  %edx,%eax
    1efc:	c1 f8 06             	sar    $0x6,%eax
    1eff:	83 c0 30             	add    $0x30,%eax
    1f02:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1f05:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f08:	99                   	cltd   
    1f09:	c1 ea 1a             	shr    $0x1a,%edx
    1f0c:	01 d0                	add    %edx,%eax
    1f0e:	83 e0 3f             	and    $0x3f,%eax
    1f11:	29 d0                	sub    %edx,%eax
    1f13:	83 c0 30             	add    $0x30,%eax
    1f16:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1f19:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(link("bd", name) != 0){
    1f1d:	83 ec 08             	sub    $0x8,%esp
    1f20:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1f23:	50                   	push   %eax
    1f24:	68 24 4e 00 00       	push   $0x4e24
    1f29:	e8 a1 20 00 00       	call   3fcf <link>
    1f2e:	83 c4 10             	add    $0x10,%esp
    1f31:	85 c0                	test   %eax,%eax
    1f33:	74 17                	je     1f4c <bigdir+0xd3>
      printf(1, "bigdir link failed\n");
    1f35:	83 ec 08             	sub    $0x8,%esp
    1f38:	68 3d 4e 00 00       	push   $0x4e3d
    1f3d:	6a 01                	push   $0x1
    1f3f:	e8 9e 21 00 00       	call   40e2 <printf>
    1f44:	83 c4 10             	add    $0x10,%esp
      exit();
    1f47:	e8 23 20 00 00       	call   3f6f <exit>
  for(i = 0; i < 500; i++){
    1f4c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f50:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1f57:	7e 94                	jle    1eed <bigdir+0x74>
    }
  }

  unlink("bd");
    1f59:	83 ec 0c             	sub    $0xc,%esp
    1f5c:	68 24 4e 00 00       	push   $0x4e24
    1f61:	e8 59 20 00 00       	call   3fbf <unlink>
    1f66:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    1f69:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1f70:	eb 5e                	jmp    1fd0 <bigdir+0x157>
    name[0] = 'x';
    1f72:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1f76:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f79:	8d 50 3f             	lea    0x3f(%eax),%edx
    1f7c:	85 c0                	test   %eax,%eax
    1f7e:	0f 48 c2             	cmovs  %edx,%eax
    1f81:	c1 f8 06             	sar    $0x6,%eax
    1f84:	83 c0 30             	add    $0x30,%eax
    1f87:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1f8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f8d:	99                   	cltd   
    1f8e:	c1 ea 1a             	shr    $0x1a,%edx
    1f91:	01 d0                	add    %edx,%eax
    1f93:	83 e0 3f             	and    $0x3f,%eax
    1f96:	29 d0                	sub    %edx,%eax
    1f98:	83 c0 30             	add    $0x30,%eax
    1f9b:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1f9e:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(unlink(name) != 0){
    1fa2:	83 ec 0c             	sub    $0xc,%esp
    1fa5:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1fa8:	50                   	push   %eax
    1fa9:	e8 11 20 00 00       	call   3fbf <unlink>
    1fae:	83 c4 10             	add    $0x10,%esp
    1fb1:	85 c0                	test   %eax,%eax
    1fb3:	74 17                	je     1fcc <bigdir+0x153>
      printf(1, "bigdir unlink failed");
    1fb5:	83 ec 08             	sub    $0x8,%esp
    1fb8:	68 51 4e 00 00       	push   $0x4e51
    1fbd:	6a 01                	push   $0x1
    1fbf:	e8 1e 21 00 00       	call   40e2 <printf>
    1fc4:	83 c4 10             	add    $0x10,%esp
      exit();
    1fc7:	e8 a3 1f 00 00       	call   3f6f <exit>
  for(i = 0; i < 500; i++){
    1fcc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1fd0:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1fd7:	7e 99                	jle    1f72 <bigdir+0xf9>
    }
  }

  printf(1, "bigdir ok\n");
    1fd9:	83 ec 08             	sub    $0x8,%esp
    1fdc:	68 66 4e 00 00       	push   $0x4e66
    1fe1:	6a 01                	push   $0x1
    1fe3:	e8 fa 20 00 00       	call   40e2 <printf>
    1fe8:	83 c4 10             	add    $0x10,%esp
}
    1feb:	90                   	nop
    1fec:	c9                   	leave  
    1fed:	c3                   	ret    

00001fee <subdir>:

void
subdir(void)
{
    1fee:	55                   	push   %ebp
    1fef:	89 e5                	mov    %esp,%ebp
    1ff1:	83 ec 18             	sub    $0x18,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1ff4:	83 ec 08             	sub    $0x8,%esp
    1ff7:	68 71 4e 00 00       	push   $0x4e71
    1ffc:	6a 01                	push   $0x1
    1ffe:	e8 df 20 00 00       	call   40e2 <printf>
    2003:	83 c4 10             	add    $0x10,%esp

  unlink("ff");
    2006:	83 ec 0c             	sub    $0xc,%esp
    2009:	68 7e 4e 00 00       	push   $0x4e7e
    200e:	e8 ac 1f 00 00       	call   3fbf <unlink>
    2013:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dd") != 0){
    2016:	83 ec 0c             	sub    $0xc,%esp
    2019:	68 81 4e 00 00       	push   $0x4e81
    201e:	e8 b4 1f 00 00       	call   3fd7 <mkdir>
    2023:	83 c4 10             	add    $0x10,%esp
    2026:	85 c0                	test   %eax,%eax
    2028:	74 17                	je     2041 <subdir+0x53>
    printf(1, "subdir mkdir dd failed\n");
    202a:	83 ec 08             	sub    $0x8,%esp
    202d:	68 84 4e 00 00       	push   $0x4e84
    2032:	6a 01                	push   $0x1
    2034:	e8 a9 20 00 00       	call   40e2 <printf>
    2039:	83 c4 10             	add    $0x10,%esp
    exit();
    203c:	e8 2e 1f 00 00       	call   3f6f <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    2041:	83 ec 08             	sub    $0x8,%esp
    2044:	68 02 02 00 00       	push   $0x202
    2049:	68 9c 4e 00 00       	push   $0x4e9c
    204e:	e8 5c 1f 00 00       	call   3faf <open>
    2053:	83 c4 10             	add    $0x10,%esp
    2056:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2059:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    205d:	79 17                	jns    2076 <subdir+0x88>
    printf(1, "create dd/ff failed\n");
    205f:	83 ec 08             	sub    $0x8,%esp
    2062:	68 a2 4e 00 00       	push   $0x4ea2
    2067:	6a 01                	push   $0x1
    2069:	e8 74 20 00 00       	call   40e2 <printf>
    206e:	83 c4 10             	add    $0x10,%esp
    exit();
    2071:	e8 f9 1e 00 00       	call   3f6f <exit>
  }
  write(fd, "ff", 2);
    2076:	83 ec 04             	sub    $0x4,%esp
    2079:	6a 02                	push   $0x2
    207b:	68 7e 4e 00 00       	push   $0x4e7e
    2080:	ff 75 f4             	pushl  -0xc(%ebp)
    2083:	e8 07 1f 00 00       	call   3f8f <write>
    2088:	83 c4 10             	add    $0x10,%esp
  close(fd);
    208b:	83 ec 0c             	sub    $0xc,%esp
    208e:	ff 75 f4             	pushl  -0xc(%ebp)
    2091:	e8 01 1f 00 00       	call   3f97 <close>
    2096:	83 c4 10             	add    $0x10,%esp
  
  if(unlink("dd") >= 0){
    2099:	83 ec 0c             	sub    $0xc,%esp
    209c:	68 81 4e 00 00       	push   $0x4e81
    20a1:	e8 19 1f 00 00       	call   3fbf <unlink>
    20a6:	83 c4 10             	add    $0x10,%esp
    20a9:	85 c0                	test   %eax,%eax
    20ab:	78 17                	js     20c4 <subdir+0xd6>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    20ad:	83 ec 08             	sub    $0x8,%esp
    20b0:	68 b8 4e 00 00       	push   $0x4eb8
    20b5:	6a 01                	push   $0x1
    20b7:	e8 26 20 00 00       	call   40e2 <printf>
    20bc:	83 c4 10             	add    $0x10,%esp
    exit();
    20bf:	e8 ab 1e 00 00       	call   3f6f <exit>
  }

  if(mkdir("/dd/dd") != 0){
    20c4:	83 ec 0c             	sub    $0xc,%esp
    20c7:	68 de 4e 00 00       	push   $0x4ede
    20cc:	e8 06 1f 00 00       	call   3fd7 <mkdir>
    20d1:	83 c4 10             	add    $0x10,%esp
    20d4:	85 c0                	test   %eax,%eax
    20d6:	74 17                	je     20ef <subdir+0x101>
    printf(1, "subdir mkdir dd/dd failed\n");
    20d8:	83 ec 08             	sub    $0x8,%esp
    20db:	68 e5 4e 00 00       	push   $0x4ee5
    20e0:	6a 01                	push   $0x1
    20e2:	e8 fb 1f 00 00       	call   40e2 <printf>
    20e7:	83 c4 10             	add    $0x10,%esp
    exit();
    20ea:	e8 80 1e 00 00       	call   3f6f <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    20ef:	83 ec 08             	sub    $0x8,%esp
    20f2:	68 02 02 00 00       	push   $0x202
    20f7:	68 00 4f 00 00       	push   $0x4f00
    20fc:	e8 ae 1e 00 00       	call   3faf <open>
    2101:	83 c4 10             	add    $0x10,%esp
    2104:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2107:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    210b:	79 17                	jns    2124 <subdir+0x136>
    printf(1, "create dd/dd/ff failed\n");
    210d:	83 ec 08             	sub    $0x8,%esp
    2110:	68 09 4f 00 00       	push   $0x4f09
    2115:	6a 01                	push   $0x1
    2117:	e8 c6 1f 00 00       	call   40e2 <printf>
    211c:	83 c4 10             	add    $0x10,%esp
    exit();
    211f:	e8 4b 1e 00 00       	call   3f6f <exit>
  }
  write(fd, "FF", 2);
    2124:	83 ec 04             	sub    $0x4,%esp
    2127:	6a 02                	push   $0x2
    2129:	68 21 4f 00 00       	push   $0x4f21
    212e:	ff 75 f4             	pushl  -0xc(%ebp)
    2131:	e8 59 1e 00 00       	call   3f8f <write>
    2136:	83 c4 10             	add    $0x10,%esp
  close(fd);
    2139:	83 ec 0c             	sub    $0xc,%esp
    213c:	ff 75 f4             	pushl  -0xc(%ebp)
    213f:	e8 53 1e 00 00       	call   3f97 <close>
    2144:	83 c4 10             	add    $0x10,%esp

  fd = open("dd/dd/../ff", 0);
    2147:	83 ec 08             	sub    $0x8,%esp
    214a:	6a 00                	push   $0x0
    214c:	68 24 4f 00 00       	push   $0x4f24
    2151:	e8 59 1e 00 00       	call   3faf <open>
    2156:	83 c4 10             	add    $0x10,%esp
    2159:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    215c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2160:	79 17                	jns    2179 <subdir+0x18b>
    printf(1, "open dd/dd/../ff failed\n");
    2162:	83 ec 08             	sub    $0x8,%esp
    2165:	68 30 4f 00 00       	push   $0x4f30
    216a:	6a 01                	push   $0x1
    216c:	e8 71 1f 00 00       	call   40e2 <printf>
    2171:	83 c4 10             	add    $0x10,%esp
    exit();
    2174:	e8 f6 1d 00 00       	call   3f6f <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    2179:	83 ec 04             	sub    $0x4,%esp
    217c:	68 00 20 00 00       	push   $0x2000
    2181:	68 40 8b 00 00       	push   $0x8b40
    2186:	ff 75 f4             	pushl  -0xc(%ebp)
    2189:	e8 f9 1d 00 00       	call   3f87 <read>
    218e:	83 c4 10             	add    $0x10,%esp
    2191:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    2194:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    2198:	75 0b                	jne    21a5 <subdir+0x1b7>
    219a:	0f b6 05 40 8b 00 00 	movzbl 0x8b40,%eax
    21a1:	3c 66                	cmp    $0x66,%al
    21a3:	74 17                	je     21bc <subdir+0x1ce>
    printf(1, "dd/dd/../ff wrong content\n");
    21a5:	83 ec 08             	sub    $0x8,%esp
    21a8:	68 49 4f 00 00       	push   $0x4f49
    21ad:	6a 01                	push   $0x1
    21af:	e8 2e 1f 00 00       	call   40e2 <printf>
    21b4:	83 c4 10             	add    $0x10,%esp
    exit();
    21b7:	e8 b3 1d 00 00       	call   3f6f <exit>
  }
  close(fd);
    21bc:	83 ec 0c             	sub    $0xc,%esp
    21bf:	ff 75 f4             	pushl  -0xc(%ebp)
    21c2:	e8 d0 1d 00 00       	call   3f97 <close>
    21c7:	83 c4 10             	add    $0x10,%esp

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    21ca:	83 ec 08             	sub    $0x8,%esp
    21cd:	68 64 4f 00 00       	push   $0x4f64
    21d2:	68 00 4f 00 00       	push   $0x4f00
    21d7:	e8 f3 1d 00 00       	call   3fcf <link>
    21dc:	83 c4 10             	add    $0x10,%esp
    21df:	85 c0                	test   %eax,%eax
    21e1:	74 17                	je     21fa <subdir+0x20c>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    21e3:	83 ec 08             	sub    $0x8,%esp
    21e6:	68 70 4f 00 00       	push   $0x4f70
    21eb:	6a 01                	push   $0x1
    21ed:	e8 f0 1e 00 00       	call   40e2 <printf>
    21f2:	83 c4 10             	add    $0x10,%esp
    exit();
    21f5:	e8 75 1d 00 00       	call   3f6f <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    21fa:	83 ec 0c             	sub    $0xc,%esp
    21fd:	68 00 4f 00 00       	push   $0x4f00
    2202:	e8 b8 1d 00 00       	call   3fbf <unlink>
    2207:	83 c4 10             	add    $0x10,%esp
    220a:	85 c0                	test   %eax,%eax
    220c:	74 17                	je     2225 <subdir+0x237>
    printf(1, "unlink dd/dd/ff failed\n");
    220e:	83 ec 08             	sub    $0x8,%esp
    2211:	68 91 4f 00 00       	push   $0x4f91
    2216:	6a 01                	push   $0x1
    2218:	e8 c5 1e 00 00       	call   40e2 <printf>
    221d:	83 c4 10             	add    $0x10,%esp
    exit();
    2220:	e8 4a 1d 00 00       	call   3f6f <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2225:	83 ec 08             	sub    $0x8,%esp
    2228:	6a 00                	push   $0x0
    222a:	68 00 4f 00 00       	push   $0x4f00
    222f:	e8 7b 1d 00 00       	call   3faf <open>
    2234:	83 c4 10             	add    $0x10,%esp
    2237:	85 c0                	test   %eax,%eax
    2239:	78 17                	js     2252 <subdir+0x264>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    223b:	83 ec 08             	sub    $0x8,%esp
    223e:	68 ac 4f 00 00       	push   $0x4fac
    2243:	6a 01                	push   $0x1
    2245:	e8 98 1e 00 00       	call   40e2 <printf>
    224a:	83 c4 10             	add    $0x10,%esp
    exit();
    224d:	e8 1d 1d 00 00       	call   3f6f <exit>
  }

  if(chdir("dd") != 0){
    2252:	83 ec 0c             	sub    $0xc,%esp
    2255:	68 81 4e 00 00       	push   $0x4e81
    225a:	e8 80 1d 00 00       	call   3fdf <chdir>
    225f:	83 c4 10             	add    $0x10,%esp
    2262:	85 c0                	test   %eax,%eax
    2264:	74 17                	je     227d <subdir+0x28f>
    printf(1, "chdir dd failed\n");
    2266:	83 ec 08             	sub    $0x8,%esp
    2269:	68 d0 4f 00 00       	push   $0x4fd0
    226e:	6a 01                	push   $0x1
    2270:	e8 6d 1e 00 00       	call   40e2 <printf>
    2275:	83 c4 10             	add    $0x10,%esp
    exit();
    2278:	e8 f2 1c 00 00       	call   3f6f <exit>
  }
  if(chdir("dd/../../dd") != 0){
    227d:	83 ec 0c             	sub    $0xc,%esp
    2280:	68 e1 4f 00 00       	push   $0x4fe1
    2285:	e8 55 1d 00 00       	call   3fdf <chdir>
    228a:	83 c4 10             	add    $0x10,%esp
    228d:	85 c0                	test   %eax,%eax
    228f:	74 17                	je     22a8 <subdir+0x2ba>
    printf(1, "chdir dd/../../dd failed\n");
    2291:	83 ec 08             	sub    $0x8,%esp
    2294:	68 ed 4f 00 00       	push   $0x4fed
    2299:	6a 01                	push   $0x1
    229b:	e8 42 1e 00 00       	call   40e2 <printf>
    22a0:	83 c4 10             	add    $0x10,%esp
    exit();
    22a3:	e8 c7 1c 00 00       	call   3f6f <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    22a8:	83 ec 0c             	sub    $0xc,%esp
    22ab:	68 07 50 00 00       	push   $0x5007
    22b0:	e8 2a 1d 00 00       	call   3fdf <chdir>
    22b5:	83 c4 10             	add    $0x10,%esp
    22b8:	85 c0                	test   %eax,%eax
    22ba:	74 17                	je     22d3 <subdir+0x2e5>
    printf(1, "chdir dd/../../dd failed\n");
    22bc:	83 ec 08             	sub    $0x8,%esp
    22bf:	68 ed 4f 00 00       	push   $0x4fed
    22c4:	6a 01                	push   $0x1
    22c6:	e8 17 1e 00 00       	call   40e2 <printf>
    22cb:	83 c4 10             	add    $0x10,%esp
    exit();
    22ce:	e8 9c 1c 00 00       	call   3f6f <exit>
  }
  if(chdir("./..") != 0){
    22d3:	83 ec 0c             	sub    $0xc,%esp
    22d6:	68 16 50 00 00       	push   $0x5016
    22db:	e8 ff 1c 00 00       	call   3fdf <chdir>
    22e0:	83 c4 10             	add    $0x10,%esp
    22e3:	85 c0                	test   %eax,%eax
    22e5:	74 17                	je     22fe <subdir+0x310>
    printf(1, "chdir ./.. failed\n");
    22e7:	83 ec 08             	sub    $0x8,%esp
    22ea:	68 1b 50 00 00       	push   $0x501b
    22ef:	6a 01                	push   $0x1
    22f1:	e8 ec 1d 00 00       	call   40e2 <printf>
    22f6:	83 c4 10             	add    $0x10,%esp
    exit();
    22f9:	e8 71 1c 00 00       	call   3f6f <exit>
  }

  fd = open("dd/dd/ffff", 0);
    22fe:	83 ec 08             	sub    $0x8,%esp
    2301:	6a 00                	push   $0x0
    2303:	68 64 4f 00 00       	push   $0x4f64
    2308:	e8 a2 1c 00 00       	call   3faf <open>
    230d:	83 c4 10             	add    $0x10,%esp
    2310:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2313:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2317:	79 17                	jns    2330 <subdir+0x342>
    printf(1, "open dd/dd/ffff failed\n");
    2319:	83 ec 08             	sub    $0x8,%esp
    231c:	68 2e 50 00 00       	push   $0x502e
    2321:	6a 01                	push   $0x1
    2323:	e8 ba 1d 00 00       	call   40e2 <printf>
    2328:	83 c4 10             	add    $0x10,%esp
    exit();
    232b:	e8 3f 1c 00 00       	call   3f6f <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    2330:	83 ec 04             	sub    $0x4,%esp
    2333:	68 00 20 00 00       	push   $0x2000
    2338:	68 40 8b 00 00       	push   $0x8b40
    233d:	ff 75 f4             	pushl  -0xc(%ebp)
    2340:	e8 42 1c 00 00       	call   3f87 <read>
    2345:	83 c4 10             	add    $0x10,%esp
    2348:	83 f8 02             	cmp    $0x2,%eax
    234b:	74 17                	je     2364 <subdir+0x376>
    printf(1, "read dd/dd/ffff wrong len\n");
    234d:	83 ec 08             	sub    $0x8,%esp
    2350:	68 46 50 00 00       	push   $0x5046
    2355:	6a 01                	push   $0x1
    2357:	e8 86 1d 00 00       	call   40e2 <printf>
    235c:	83 c4 10             	add    $0x10,%esp
    exit();
    235f:	e8 0b 1c 00 00       	call   3f6f <exit>
  }
  close(fd);
    2364:	83 ec 0c             	sub    $0xc,%esp
    2367:	ff 75 f4             	pushl  -0xc(%ebp)
    236a:	e8 28 1c 00 00       	call   3f97 <close>
    236f:	83 c4 10             	add    $0x10,%esp

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2372:	83 ec 08             	sub    $0x8,%esp
    2375:	6a 00                	push   $0x0
    2377:	68 00 4f 00 00       	push   $0x4f00
    237c:	e8 2e 1c 00 00       	call   3faf <open>
    2381:	83 c4 10             	add    $0x10,%esp
    2384:	85 c0                	test   %eax,%eax
    2386:	78 17                	js     239f <subdir+0x3b1>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2388:	83 ec 08             	sub    $0x8,%esp
    238b:	68 64 50 00 00       	push   $0x5064
    2390:	6a 01                	push   $0x1
    2392:	e8 4b 1d 00 00       	call   40e2 <printf>
    2397:	83 c4 10             	add    $0x10,%esp
    exit();
    239a:	e8 d0 1b 00 00       	call   3f6f <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    239f:	83 ec 08             	sub    $0x8,%esp
    23a2:	68 02 02 00 00       	push   $0x202
    23a7:	68 89 50 00 00       	push   $0x5089
    23ac:	e8 fe 1b 00 00       	call   3faf <open>
    23b1:	83 c4 10             	add    $0x10,%esp
    23b4:	85 c0                	test   %eax,%eax
    23b6:	78 17                	js     23cf <subdir+0x3e1>
    printf(1, "create dd/ff/ff succeeded!\n");
    23b8:	83 ec 08             	sub    $0x8,%esp
    23bb:	68 92 50 00 00       	push   $0x5092
    23c0:	6a 01                	push   $0x1
    23c2:	e8 1b 1d 00 00       	call   40e2 <printf>
    23c7:	83 c4 10             	add    $0x10,%esp
    exit();
    23ca:	e8 a0 1b 00 00       	call   3f6f <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    23cf:	83 ec 08             	sub    $0x8,%esp
    23d2:	68 02 02 00 00       	push   $0x202
    23d7:	68 ae 50 00 00       	push   $0x50ae
    23dc:	e8 ce 1b 00 00       	call   3faf <open>
    23e1:	83 c4 10             	add    $0x10,%esp
    23e4:	85 c0                	test   %eax,%eax
    23e6:	78 17                	js     23ff <subdir+0x411>
    printf(1, "create dd/xx/ff succeeded!\n");
    23e8:	83 ec 08             	sub    $0x8,%esp
    23eb:	68 b7 50 00 00       	push   $0x50b7
    23f0:	6a 01                	push   $0x1
    23f2:	e8 eb 1c 00 00       	call   40e2 <printf>
    23f7:	83 c4 10             	add    $0x10,%esp
    exit();
    23fa:	e8 70 1b 00 00       	call   3f6f <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    23ff:	83 ec 08             	sub    $0x8,%esp
    2402:	68 00 02 00 00       	push   $0x200
    2407:	68 81 4e 00 00       	push   $0x4e81
    240c:	e8 9e 1b 00 00       	call   3faf <open>
    2411:	83 c4 10             	add    $0x10,%esp
    2414:	85 c0                	test   %eax,%eax
    2416:	78 17                	js     242f <subdir+0x441>
    printf(1, "create dd succeeded!\n");
    2418:	83 ec 08             	sub    $0x8,%esp
    241b:	68 d3 50 00 00       	push   $0x50d3
    2420:	6a 01                	push   $0x1
    2422:	e8 bb 1c 00 00       	call   40e2 <printf>
    2427:	83 c4 10             	add    $0x10,%esp
    exit();
    242a:	e8 40 1b 00 00       	call   3f6f <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    242f:	83 ec 08             	sub    $0x8,%esp
    2432:	6a 02                	push   $0x2
    2434:	68 81 4e 00 00       	push   $0x4e81
    2439:	e8 71 1b 00 00       	call   3faf <open>
    243e:	83 c4 10             	add    $0x10,%esp
    2441:	85 c0                	test   %eax,%eax
    2443:	78 17                	js     245c <subdir+0x46e>
    printf(1, "open dd rdwr succeeded!\n");
    2445:	83 ec 08             	sub    $0x8,%esp
    2448:	68 e9 50 00 00       	push   $0x50e9
    244d:	6a 01                	push   $0x1
    244f:	e8 8e 1c 00 00       	call   40e2 <printf>
    2454:	83 c4 10             	add    $0x10,%esp
    exit();
    2457:	e8 13 1b 00 00       	call   3f6f <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    245c:	83 ec 08             	sub    $0x8,%esp
    245f:	6a 01                	push   $0x1
    2461:	68 81 4e 00 00       	push   $0x4e81
    2466:	e8 44 1b 00 00       	call   3faf <open>
    246b:	83 c4 10             	add    $0x10,%esp
    246e:	85 c0                	test   %eax,%eax
    2470:	78 17                	js     2489 <subdir+0x49b>
    printf(1, "open dd wronly succeeded!\n");
    2472:	83 ec 08             	sub    $0x8,%esp
    2475:	68 02 51 00 00       	push   $0x5102
    247a:	6a 01                	push   $0x1
    247c:	e8 61 1c 00 00       	call   40e2 <printf>
    2481:	83 c4 10             	add    $0x10,%esp
    exit();
    2484:	e8 e6 1a 00 00       	call   3f6f <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2489:	83 ec 08             	sub    $0x8,%esp
    248c:	68 1d 51 00 00       	push   $0x511d
    2491:	68 89 50 00 00       	push   $0x5089
    2496:	e8 34 1b 00 00       	call   3fcf <link>
    249b:	83 c4 10             	add    $0x10,%esp
    249e:	85 c0                	test   %eax,%eax
    24a0:	75 17                	jne    24b9 <subdir+0x4cb>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    24a2:	83 ec 08             	sub    $0x8,%esp
    24a5:	68 28 51 00 00       	push   $0x5128
    24aa:	6a 01                	push   $0x1
    24ac:	e8 31 1c 00 00       	call   40e2 <printf>
    24b1:	83 c4 10             	add    $0x10,%esp
    exit();
    24b4:	e8 b6 1a 00 00       	call   3f6f <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    24b9:	83 ec 08             	sub    $0x8,%esp
    24bc:	68 1d 51 00 00       	push   $0x511d
    24c1:	68 ae 50 00 00       	push   $0x50ae
    24c6:	e8 04 1b 00 00       	call   3fcf <link>
    24cb:	83 c4 10             	add    $0x10,%esp
    24ce:	85 c0                	test   %eax,%eax
    24d0:	75 17                	jne    24e9 <subdir+0x4fb>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    24d2:	83 ec 08             	sub    $0x8,%esp
    24d5:	68 4c 51 00 00       	push   $0x514c
    24da:	6a 01                	push   $0x1
    24dc:	e8 01 1c 00 00       	call   40e2 <printf>
    24e1:	83 c4 10             	add    $0x10,%esp
    exit();
    24e4:	e8 86 1a 00 00       	call   3f6f <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    24e9:	83 ec 08             	sub    $0x8,%esp
    24ec:	68 64 4f 00 00       	push   $0x4f64
    24f1:	68 9c 4e 00 00       	push   $0x4e9c
    24f6:	e8 d4 1a 00 00       	call   3fcf <link>
    24fb:	83 c4 10             	add    $0x10,%esp
    24fe:	85 c0                	test   %eax,%eax
    2500:	75 17                	jne    2519 <subdir+0x52b>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2502:	83 ec 08             	sub    $0x8,%esp
    2505:	68 70 51 00 00       	push   $0x5170
    250a:	6a 01                	push   $0x1
    250c:	e8 d1 1b 00 00       	call   40e2 <printf>
    2511:	83 c4 10             	add    $0x10,%esp
    exit();
    2514:	e8 56 1a 00 00       	call   3f6f <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    2519:	83 ec 0c             	sub    $0xc,%esp
    251c:	68 89 50 00 00       	push   $0x5089
    2521:	e8 b1 1a 00 00       	call   3fd7 <mkdir>
    2526:	83 c4 10             	add    $0x10,%esp
    2529:	85 c0                	test   %eax,%eax
    252b:	75 17                	jne    2544 <subdir+0x556>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    252d:	83 ec 08             	sub    $0x8,%esp
    2530:	68 92 51 00 00       	push   $0x5192
    2535:	6a 01                	push   $0x1
    2537:	e8 a6 1b 00 00       	call   40e2 <printf>
    253c:	83 c4 10             	add    $0x10,%esp
    exit();
    253f:	e8 2b 1a 00 00       	call   3f6f <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    2544:	83 ec 0c             	sub    $0xc,%esp
    2547:	68 ae 50 00 00       	push   $0x50ae
    254c:	e8 86 1a 00 00       	call   3fd7 <mkdir>
    2551:	83 c4 10             	add    $0x10,%esp
    2554:	85 c0                	test   %eax,%eax
    2556:	75 17                	jne    256f <subdir+0x581>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2558:	83 ec 08             	sub    $0x8,%esp
    255b:	68 ad 51 00 00       	push   $0x51ad
    2560:	6a 01                	push   $0x1
    2562:	e8 7b 1b 00 00       	call   40e2 <printf>
    2567:	83 c4 10             	add    $0x10,%esp
    exit();
    256a:	e8 00 1a 00 00       	call   3f6f <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    256f:	83 ec 0c             	sub    $0xc,%esp
    2572:	68 64 4f 00 00       	push   $0x4f64
    2577:	e8 5b 1a 00 00       	call   3fd7 <mkdir>
    257c:	83 c4 10             	add    $0x10,%esp
    257f:	85 c0                	test   %eax,%eax
    2581:	75 17                	jne    259a <subdir+0x5ac>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2583:	83 ec 08             	sub    $0x8,%esp
    2586:	68 c8 51 00 00       	push   $0x51c8
    258b:	6a 01                	push   $0x1
    258d:	e8 50 1b 00 00       	call   40e2 <printf>
    2592:	83 c4 10             	add    $0x10,%esp
    exit();
    2595:	e8 d5 19 00 00       	call   3f6f <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    259a:	83 ec 0c             	sub    $0xc,%esp
    259d:	68 ae 50 00 00       	push   $0x50ae
    25a2:	e8 18 1a 00 00       	call   3fbf <unlink>
    25a7:	83 c4 10             	add    $0x10,%esp
    25aa:	85 c0                	test   %eax,%eax
    25ac:	75 17                	jne    25c5 <subdir+0x5d7>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    25ae:	83 ec 08             	sub    $0x8,%esp
    25b1:	68 e5 51 00 00       	push   $0x51e5
    25b6:	6a 01                	push   $0x1
    25b8:	e8 25 1b 00 00       	call   40e2 <printf>
    25bd:	83 c4 10             	add    $0x10,%esp
    exit();
    25c0:	e8 aa 19 00 00       	call   3f6f <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    25c5:	83 ec 0c             	sub    $0xc,%esp
    25c8:	68 89 50 00 00       	push   $0x5089
    25cd:	e8 ed 19 00 00       	call   3fbf <unlink>
    25d2:	83 c4 10             	add    $0x10,%esp
    25d5:	85 c0                	test   %eax,%eax
    25d7:	75 17                	jne    25f0 <subdir+0x602>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    25d9:	83 ec 08             	sub    $0x8,%esp
    25dc:	68 01 52 00 00       	push   $0x5201
    25e1:	6a 01                	push   $0x1
    25e3:	e8 fa 1a 00 00       	call   40e2 <printf>
    25e8:	83 c4 10             	add    $0x10,%esp
    exit();
    25eb:	e8 7f 19 00 00       	call   3f6f <exit>
  }
  if(chdir("dd/ff") == 0){
    25f0:	83 ec 0c             	sub    $0xc,%esp
    25f3:	68 9c 4e 00 00       	push   $0x4e9c
    25f8:	e8 e2 19 00 00       	call   3fdf <chdir>
    25fd:	83 c4 10             	add    $0x10,%esp
    2600:	85 c0                	test   %eax,%eax
    2602:	75 17                	jne    261b <subdir+0x62d>
    printf(1, "chdir dd/ff succeeded!\n");
    2604:	83 ec 08             	sub    $0x8,%esp
    2607:	68 1d 52 00 00       	push   $0x521d
    260c:	6a 01                	push   $0x1
    260e:	e8 cf 1a 00 00       	call   40e2 <printf>
    2613:	83 c4 10             	add    $0x10,%esp
    exit();
    2616:	e8 54 19 00 00       	call   3f6f <exit>
  }
  if(chdir("dd/xx") == 0){
    261b:	83 ec 0c             	sub    $0xc,%esp
    261e:	68 35 52 00 00       	push   $0x5235
    2623:	e8 b7 19 00 00       	call   3fdf <chdir>
    2628:	83 c4 10             	add    $0x10,%esp
    262b:	85 c0                	test   %eax,%eax
    262d:	75 17                	jne    2646 <subdir+0x658>
    printf(1, "chdir dd/xx succeeded!\n");
    262f:	83 ec 08             	sub    $0x8,%esp
    2632:	68 3b 52 00 00       	push   $0x523b
    2637:	6a 01                	push   $0x1
    2639:	e8 a4 1a 00 00       	call   40e2 <printf>
    263e:	83 c4 10             	add    $0x10,%esp
    exit();
    2641:	e8 29 19 00 00       	call   3f6f <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    2646:	83 ec 0c             	sub    $0xc,%esp
    2649:	68 64 4f 00 00       	push   $0x4f64
    264e:	e8 6c 19 00 00       	call   3fbf <unlink>
    2653:	83 c4 10             	add    $0x10,%esp
    2656:	85 c0                	test   %eax,%eax
    2658:	74 17                	je     2671 <subdir+0x683>
    printf(1, "unlink dd/dd/ff failed\n");
    265a:	83 ec 08             	sub    $0x8,%esp
    265d:	68 91 4f 00 00       	push   $0x4f91
    2662:	6a 01                	push   $0x1
    2664:	e8 79 1a 00 00       	call   40e2 <printf>
    2669:	83 c4 10             	add    $0x10,%esp
    exit();
    266c:	e8 fe 18 00 00       	call   3f6f <exit>
  }
  if(unlink("dd/ff") != 0){
    2671:	83 ec 0c             	sub    $0xc,%esp
    2674:	68 9c 4e 00 00       	push   $0x4e9c
    2679:	e8 41 19 00 00       	call   3fbf <unlink>
    267e:	83 c4 10             	add    $0x10,%esp
    2681:	85 c0                	test   %eax,%eax
    2683:	74 17                	je     269c <subdir+0x6ae>
    printf(1, "unlink dd/ff failed\n");
    2685:	83 ec 08             	sub    $0x8,%esp
    2688:	68 53 52 00 00       	push   $0x5253
    268d:	6a 01                	push   $0x1
    268f:	e8 4e 1a 00 00       	call   40e2 <printf>
    2694:	83 c4 10             	add    $0x10,%esp
    exit();
    2697:	e8 d3 18 00 00       	call   3f6f <exit>
  }
  if(unlink("dd") == 0){
    269c:	83 ec 0c             	sub    $0xc,%esp
    269f:	68 81 4e 00 00       	push   $0x4e81
    26a4:	e8 16 19 00 00       	call   3fbf <unlink>
    26a9:	83 c4 10             	add    $0x10,%esp
    26ac:	85 c0                	test   %eax,%eax
    26ae:	75 17                	jne    26c7 <subdir+0x6d9>
    printf(1, "unlink non-empty dd succeeded!\n");
    26b0:	83 ec 08             	sub    $0x8,%esp
    26b3:	68 68 52 00 00       	push   $0x5268
    26b8:	6a 01                	push   $0x1
    26ba:	e8 23 1a 00 00       	call   40e2 <printf>
    26bf:	83 c4 10             	add    $0x10,%esp
    exit();
    26c2:	e8 a8 18 00 00       	call   3f6f <exit>
  }
  if(unlink("dd/dd") < 0){
    26c7:	83 ec 0c             	sub    $0xc,%esp
    26ca:	68 88 52 00 00       	push   $0x5288
    26cf:	e8 eb 18 00 00       	call   3fbf <unlink>
    26d4:	83 c4 10             	add    $0x10,%esp
    26d7:	85 c0                	test   %eax,%eax
    26d9:	79 17                	jns    26f2 <subdir+0x704>
    printf(1, "unlink dd/dd failed\n");
    26db:	83 ec 08             	sub    $0x8,%esp
    26de:	68 8e 52 00 00       	push   $0x528e
    26e3:	6a 01                	push   $0x1
    26e5:	e8 f8 19 00 00       	call   40e2 <printf>
    26ea:	83 c4 10             	add    $0x10,%esp
    exit();
    26ed:	e8 7d 18 00 00       	call   3f6f <exit>
  }
  if(unlink("dd") < 0){
    26f2:	83 ec 0c             	sub    $0xc,%esp
    26f5:	68 81 4e 00 00       	push   $0x4e81
    26fa:	e8 c0 18 00 00       	call   3fbf <unlink>
    26ff:	83 c4 10             	add    $0x10,%esp
    2702:	85 c0                	test   %eax,%eax
    2704:	79 17                	jns    271d <subdir+0x72f>
    printf(1, "unlink dd failed\n");
    2706:	83 ec 08             	sub    $0x8,%esp
    2709:	68 a3 52 00 00       	push   $0x52a3
    270e:	6a 01                	push   $0x1
    2710:	e8 cd 19 00 00       	call   40e2 <printf>
    2715:	83 c4 10             	add    $0x10,%esp
    exit();
    2718:	e8 52 18 00 00       	call   3f6f <exit>
  }

  printf(1, "subdir ok\n");
    271d:	83 ec 08             	sub    $0x8,%esp
    2720:	68 b5 52 00 00       	push   $0x52b5
    2725:	6a 01                	push   $0x1
    2727:	e8 b6 19 00 00       	call   40e2 <printf>
    272c:	83 c4 10             	add    $0x10,%esp
}
    272f:	90                   	nop
    2730:	c9                   	leave  
    2731:	c3                   	ret    

00002732 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    2732:	55                   	push   %ebp
    2733:	89 e5                	mov    %esp,%ebp
    2735:	83 ec 18             	sub    $0x18,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    2738:	83 ec 08             	sub    $0x8,%esp
    273b:	68 c0 52 00 00       	push   $0x52c0
    2740:	6a 01                	push   $0x1
    2742:	e8 9b 19 00 00       	call   40e2 <printf>
    2747:	83 c4 10             	add    $0x10,%esp

  unlink("bigwrite");
    274a:	83 ec 0c             	sub    $0xc,%esp
    274d:	68 cf 52 00 00       	push   $0x52cf
    2752:	e8 68 18 00 00       	call   3fbf <unlink>
    2757:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    275a:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    2761:	e9 a8 00 00 00       	jmp    280e <bigwrite+0xdc>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2766:	83 ec 08             	sub    $0x8,%esp
    2769:	68 02 02 00 00       	push   $0x202
    276e:	68 cf 52 00 00       	push   $0x52cf
    2773:	e8 37 18 00 00       	call   3faf <open>
    2778:	83 c4 10             	add    $0x10,%esp
    277b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    277e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2782:	79 17                	jns    279b <bigwrite+0x69>
      printf(1, "cannot create bigwrite\n");
    2784:	83 ec 08             	sub    $0x8,%esp
    2787:	68 d8 52 00 00       	push   $0x52d8
    278c:	6a 01                	push   $0x1
    278e:	e8 4f 19 00 00       	call   40e2 <printf>
    2793:	83 c4 10             	add    $0x10,%esp
      exit();
    2796:	e8 d4 17 00 00       	call   3f6f <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    279b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    27a2:	eb 3f                	jmp    27e3 <bigwrite+0xb1>
      int cc = write(fd, buf, sz);
    27a4:	83 ec 04             	sub    $0x4,%esp
    27a7:	ff 75 f4             	pushl  -0xc(%ebp)
    27aa:	68 40 8b 00 00       	push   $0x8b40
    27af:	ff 75 ec             	pushl  -0x14(%ebp)
    27b2:	e8 d8 17 00 00       	call   3f8f <write>
    27b7:	83 c4 10             	add    $0x10,%esp
    27ba:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc != sz){
    27bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    27c0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    27c3:	74 1a                	je     27df <bigwrite+0xad>
        printf(1, "write(%d) ret %d\n", sz, cc);
    27c5:	ff 75 e8             	pushl  -0x18(%ebp)
    27c8:	ff 75 f4             	pushl  -0xc(%ebp)
    27cb:	68 f0 52 00 00       	push   $0x52f0
    27d0:	6a 01                	push   $0x1
    27d2:	e8 0b 19 00 00       	call   40e2 <printf>
    27d7:	83 c4 10             	add    $0x10,%esp
        exit();
    27da:	e8 90 17 00 00       	call   3f6f <exit>
    for(i = 0; i < 2; i++){
    27df:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    27e3:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    27e7:	7e bb                	jle    27a4 <bigwrite+0x72>
      }
    }
    close(fd);
    27e9:	83 ec 0c             	sub    $0xc,%esp
    27ec:	ff 75 ec             	pushl  -0x14(%ebp)
    27ef:	e8 a3 17 00 00       	call   3f97 <close>
    27f4:	83 c4 10             	add    $0x10,%esp
    unlink("bigwrite");
    27f7:	83 ec 0c             	sub    $0xc,%esp
    27fa:	68 cf 52 00 00       	push   $0x52cf
    27ff:	e8 bb 17 00 00       	call   3fbf <unlink>
    2804:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    2807:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    280e:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    2815:	0f 8e 4b ff ff ff    	jle    2766 <bigwrite+0x34>
  }

  printf(1, "bigwrite ok\n");
    281b:	83 ec 08             	sub    $0x8,%esp
    281e:	68 02 53 00 00       	push   $0x5302
    2823:	6a 01                	push   $0x1
    2825:	e8 b8 18 00 00       	call   40e2 <printf>
    282a:	83 c4 10             	add    $0x10,%esp
}
    282d:	90                   	nop
    282e:	c9                   	leave  
    282f:	c3                   	ret    

00002830 <bigfile>:

void
bigfile(void)
{
    2830:	55                   	push   %ebp
    2831:	89 e5                	mov    %esp,%ebp
    2833:	83 ec 18             	sub    $0x18,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    2836:	83 ec 08             	sub    $0x8,%esp
    2839:	68 0f 53 00 00       	push   $0x530f
    283e:	6a 01                	push   $0x1
    2840:	e8 9d 18 00 00       	call   40e2 <printf>
    2845:	83 c4 10             	add    $0x10,%esp

  unlink("bigfile");
    2848:	83 ec 0c             	sub    $0xc,%esp
    284b:	68 1d 53 00 00       	push   $0x531d
    2850:	e8 6a 17 00 00       	call   3fbf <unlink>
    2855:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", O_CREATE | O_RDWR);
    2858:	83 ec 08             	sub    $0x8,%esp
    285b:	68 02 02 00 00       	push   $0x202
    2860:	68 1d 53 00 00       	push   $0x531d
    2865:	e8 45 17 00 00       	call   3faf <open>
    286a:	83 c4 10             	add    $0x10,%esp
    286d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2870:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2874:	79 17                	jns    288d <bigfile+0x5d>
    printf(1, "cannot create bigfile");
    2876:	83 ec 08             	sub    $0x8,%esp
    2879:	68 25 53 00 00       	push   $0x5325
    287e:	6a 01                	push   $0x1
    2880:	e8 5d 18 00 00       	call   40e2 <printf>
    2885:	83 c4 10             	add    $0x10,%esp
    exit();
    2888:	e8 e2 16 00 00       	call   3f6f <exit>
  }
  for(i = 0; i < 20; i++){
    288d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2894:	eb 52                	jmp    28e8 <bigfile+0xb8>
    memset(buf, i, 600);
    2896:	83 ec 04             	sub    $0x4,%esp
    2899:	68 58 02 00 00       	push   $0x258
    289e:	ff 75 f4             	pushl  -0xc(%ebp)
    28a1:	68 40 8b 00 00       	push   $0x8b40
    28a6:	e8 29 15 00 00       	call   3dd4 <memset>
    28ab:	83 c4 10             	add    $0x10,%esp
    if(write(fd, buf, 600) != 600){
    28ae:	83 ec 04             	sub    $0x4,%esp
    28b1:	68 58 02 00 00       	push   $0x258
    28b6:	68 40 8b 00 00       	push   $0x8b40
    28bb:	ff 75 ec             	pushl  -0x14(%ebp)
    28be:	e8 cc 16 00 00       	call   3f8f <write>
    28c3:	83 c4 10             	add    $0x10,%esp
    28c6:	3d 58 02 00 00       	cmp    $0x258,%eax
    28cb:	74 17                	je     28e4 <bigfile+0xb4>
      printf(1, "write bigfile failed\n");
    28cd:	83 ec 08             	sub    $0x8,%esp
    28d0:	68 3b 53 00 00       	push   $0x533b
    28d5:	6a 01                	push   $0x1
    28d7:	e8 06 18 00 00       	call   40e2 <printf>
    28dc:	83 c4 10             	add    $0x10,%esp
      exit();
    28df:	e8 8b 16 00 00       	call   3f6f <exit>
  for(i = 0; i < 20; i++){
    28e4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    28e8:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    28ec:	7e a8                	jle    2896 <bigfile+0x66>
    }
  }
  close(fd);
    28ee:	83 ec 0c             	sub    $0xc,%esp
    28f1:	ff 75 ec             	pushl  -0x14(%ebp)
    28f4:	e8 9e 16 00 00       	call   3f97 <close>
    28f9:	83 c4 10             	add    $0x10,%esp

  fd = open("bigfile", 0);
    28fc:	83 ec 08             	sub    $0x8,%esp
    28ff:	6a 00                	push   $0x0
    2901:	68 1d 53 00 00       	push   $0x531d
    2906:	e8 a4 16 00 00       	call   3faf <open>
    290b:	83 c4 10             	add    $0x10,%esp
    290e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2911:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2915:	79 17                	jns    292e <bigfile+0xfe>
    printf(1, "cannot open bigfile\n");
    2917:	83 ec 08             	sub    $0x8,%esp
    291a:	68 51 53 00 00       	push   $0x5351
    291f:	6a 01                	push   $0x1
    2921:	e8 bc 17 00 00       	call   40e2 <printf>
    2926:	83 c4 10             	add    $0x10,%esp
    exit();
    2929:	e8 41 16 00 00       	call   3f6f <exit>
  }
  total = 0;
    292e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(i = 0; ; i++){
    2935:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cc = read(fd, buf, 300);
    293c:	83 ec 04             	sub    $0x4,%esp
    293f:	68 2c 01 00 00       	push   $0x12c
    2944:	68 40 8b 00 00       	push   $0x8b40
    2949:	ff 75 ec             	pushl  -0x14(%ebp)
    294c:	e8 36 16 00 00       	call   3f87 <read>
    2951:	83 c4 10             	add    $0x10,%esp
    2954:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(cc < 0){
    2957:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    295b:	79 17                	jns    2974 <bigfile+0x144>
      printf(1, "read bigfile failed\n");
    295d:	83 ec 08             	sub    $0x8,%esp
    2960:	68 66 53 00 00       	push   $0x5366
    2965:	6a 01                	push   $0x1
    2967:	e8 76 17 00 00       	call   40e2 <printf>
    296c:	83 c4 10             	add    $0x10,%esp
      exit();
    296f:	e8 fb 15 00 00       	call   3f6f <exit>
    }
    if(cc == 0)
    2974:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2978:	74 7a                	je     29f4 <bigfile+0x1c4>
      break;
    if(cc != 300){
    297a:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    2981:	74 17                	je     299a <bigfile+0x16a>
      printf(1, "short read bigfile\n");
    2983:	83 ec 08             	sub    $0x8,%esp
    2986:	68 7b 53 00 00       	push   $0x537b
    298b:	6a 01                	push   $0x1
    298d:	e8 50 17 00 00       	call   40e2 <printf>
    2992:	83 c4 10             	add    $0x10,%esp
      exit();
    2995:	e8 d5 15 00 00       	call   3f6f <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    299a:	0f b6 05 40 8b 00 00 	movzbl 0x8b40,%eax
    29a1:	0f be d0             	movsbl %al,%edx
    29a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29a7:	89 c1                	mov    %eax,%ecx
    29a9:	c1 e9 1f             	shr    $0x1f,%ecx
    29ac:	01 c8                	add    %ecx,%eax
    29ae:	d1 f8                	sar    %eax
    29b0:	39 c2                	cmp    %eax,%edx
    29b2:	75 1a                	jne    29ce <bigfile+0x19e>
    29b4:	0f b6 05 6b 8c 00 00 	movzbl 0x8c6b,%eax
    29bb:	0f be d0             	movsbl %al,%edx
    29be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29c1:	89 c1                	mov    %eax,%ecx
    29c3:	c1 e9 1f             	shr    $0x1f,%ecx
    29c6:	01 c8                	add    %ecx,%eax
    29c8:	d1 f8                	sar    %eax
    29ca:	39 c2                	cmp    %eax,%edx
    29cc:	74 17                	je     29e5 <bigfile+0x1b5>
      printf(1, "read bigfile wrong data\n");
    29ce:	83 ec 08             	sub    $0x8,%esp
    29d1:	68 8f 53 00 00       	push   $0x538f
    29d6:	6a 01                	push   $0x1
    29d8:	e8 05 17 00 00       	call   40e2 <printf>
    29dd:	83 c4 10             	add    $0x10,%esp
      exit();
    29e0:	e8 8a 15 00 00       	call   3f6f <exit>
    }
    total += cc;
    29e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    29e8:	01 45 f0             	add    %eax,-0x10(%ebp)
  for(i = 0; ; i++){
    29eb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    cc = read(fd, buf, 300);
    29ef:	e9 48 ff ff ff       	jmp    293c <bigfile+0x10c>
      break;
    29f4:	90                   	nop
  }
  close(fd);
    29f5:	83 ec 0c             	sub    $0xc,%esp
    29f8:	ff 75 ec             	pushl  -0x14(%ebp)
    29fb:	e8 97 15 00 00       	call   3f97 <close>
    2a00:	83 c4 10             	add    $0x10,%esp
  if(total != 20*600){
    2a03:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    2a0a:	74 17                	je     2a23 <bigfile+0x1f3>
    printf(1, "read bigfile wrong total\n");
    2a0c:	83 ec 08             	sub    $0x8,%esp
    2a0f:	68 a8 53 00 00       	push   $0x53a8
    2a14:	6a 01                	push   $0x1
    2a16:	e8 c7 16 00 00       	call   40e2 <printf>
    2a1b:	83 c4 10             	add    $0x10,%esp
    exit();
    2a1e:	e8 4c 15 00 00       	call   3f6f <exit>
  }
  unlink("bigfile");
    2a23:	83 ec 0c             	sub    $0xc,%esp
    2a26:	68 1d 53 00 00       	push   $0x531d
    2a2b:	e8 8f 15 00 00       	call   3fbf <unlink>
    2a30:	83 c4 10             	add    $0x10,%esp

  printf(1, "bigfile test ok\n");
    2a33:	83 ec 08             	sub    $0x8,%esp
    2a36:	68 c2 53 00 00       	push   $0x53c2
    2a3b:	6a 01                	push   $0x1
    2a3d:	e8 a0 16 00 00       	call   40e2 <printf>
    2a42:	83 c4 10             	add    $0x10,%esp
}
    2a45:	90                   	nop
    2a46:	c9                   	leave  
    2a47:	c3                   	ret    

00002a48 <fourteen>:

void
fourteen(void)
{
    2a48:	55                   	push   %ebp
    2a49:	89 e5                	mov    %esp,%ebp
    2a4b:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2a4e:	83 ec 08             	sub    $0x8,%esp
    2a51:	68 d3 53 00 00       	push   $0x53d3
    2a56:	6a 01                	push   $0x1
    2a58:	e8 85 16 00 00       	call   40e2 <printf>
    2a5d:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234") != 0){
    2a60:	83 ec 0c             	sub    $0xc,%esp
    2a63:	68 e2 53 00 00       	push   $0x53e2
    2a68:	e8 6a 15 00 00       	call   3fd7 <mkdir>
    2a6d:	83 c4 10             	add    $0x10,%esp
    2a70:	85 c0                	test   %eax,%eax
    2a72:	74 17                	je     2a8b <fourteen+0x43>
    printf(1, "mkdir 12345678901234 failed\n");
    2a74:	83 ec 08             	sub    $0x8,%esp
    2a77:	68 f1 53 00 00       	push   $0x53f1
    2a7c:	6a 01                	push   $0x1
    2a7e:	e8 5f 16 00 00       	call   40e2 <printf>
    2a83:	83 c4 10             	add    $0x10,%esp
    exit();
    2a86:	e8 e4 14 00 00       	call   3f6f <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    2a8b:	83 ec 0c             	sub    $0xc,%esp
    2a8e:	68 10 54 00 00       	push   $0x5410
    2a93:	e8 3f 15 00 00       	call   3fd7 <mkdir>
    2a98:	83 c4 10             	add    $0x10,%esp
    2a9b:	85 c0                	test   %eax,%eax
    2a9d:	74 17                	je     2ab6 <fourteen+0x6e>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2a9f:	83 ec 08             	sub    $0x8,%esp
    2aa2:	68 30 54 00 00       	push   $0x5430
    2aa7:	6a 01                	push   $0x1
    2aa9:	e8 34 16 00 00       	call   40e2 <printf>
    2aae:	83 c4 10             	add    $0x10,%esp
    exit();
    2ab1:	e8 b9 14 00 00       	call   3f6f <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2ab6:	83 ec 08             	sub    $0x8,%esp
    2ab9:	68 00 02 00 00       	push   $0x200
    2abe:	68 60 54 00 00       	push   $0x5460
    2ac3:	e8 e7 14 00 00       	call   3faf <open>
    2ac8:	83 c4 10             	add    $0x10,%esp
    2acb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2ace:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ad2:	79 17                	jns    2aeb <fourteen+0xa3>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2ad4:	83 ec 08             	sub    $0x8,%esp
    2ad7:	68 90 54 00 00       	push   $0x5490
    2adc:	6a 01                	push   $0x1
    2ade:	e8 ff 15 00 00       	call   40e2 <printf>
    2ae3:	83 c4 10             	add    $0x10,%esp
    exit();
    2ae6:	e8 84 14 00 00       	call   3f6f <exit>
  }
  close(fd);
    2aeb:	83 ec 0c             	sub    $0xc,%esp
    2aee:	ff 75 f4             	pushl  -0xc(%ebp)
    2af1:	e8 a1 14 00 00       	call   3f97 <close>
    2af6:	83 c4 10             	add    $0x10,%esp
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2af9:	83 ec 08             	sub    $0x8,%esp
    2afc:	6a 00                	push   $0x0
    2afe:	68 d0 54 00 00       	push   $0x54d0
    2b03:	e8 a7 14 00 00       	call   3faf <open>
    2b08:	83 c4 10             	add    $0x10,%esp
    2b0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2b0e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2b12:	79 17                	jns    2b2b <fourteen+0xe3>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2b14:	83 ec 08             	sub    $0x8,%esp
    2b17:	68 00 55 00 00       	push   $0x5500
    2b1c:	6a 01                	push   $0x1
    2b1e:	e8 bf 15 00 00       	call   40e2 <printf>
    2b23:	83 c4 10             	add    $0x10,%esp
    exit();
    2b26:	e8 44 14 00 00       	call   3f6f <exit>
  }
  close(fd);
    2b2b:	83 ec 0c             	sub    $0xc,%esp
    2b2e:	ff 75 f4             	pushl  -0xc(%ebp)
    2b31:	e8 61 14 00 00       	call   3f97 <close>
    2b36:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234/12345678901234") == 0){
    2b39:	83 ec 0c             	sub    $0xc,%esp
    2b3c:	68 3a 55 00 00       	push   $0x553a
    2b41:	e8 91 14 00 00       	call   3fd7 <mkdir>
    2b46:	83 c4 10             	add    $0x10,%esp
    2b49:	85 c0                	test   %eax,%eax
    2b4b:	75 17                	jne    2b64 <fourteen+0x11c>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2b4d:	83 ec 08             	sub    $0x8,%esp
    2b50:	68 58 55 00 00       	push   $0x5558
    2b55:	6a 01                	push   $0x1
    2b57:	e8 86 15 00 00       	call   40e2 <printf>
    2b5c:	83 c4 10             	add    $0x10,%esp
    exit();
    2b5f:	e8 0b 14 00 00       	call   3f6f <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2b64:	83 ec 0c             	sub    $0xc,%esp
    2b67:	68 88 55 00 00       	push   $0x5588
    2b6c:	e8 66 14 00 00       	call   3fd7 <mkdir>
    2b71:	83 c4 10             	add    $0x10,%esp
    2b74:	85 c0                	test   %eax,%eax
    2b76:	75 17                	jne    2b8f <fourteen+0x147>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2b78:	83 ec 08             	sub    $0x8,%esp
    2b7b:	68 a8 55 00 00       	push   $0x55a8
    2b80:	6a 01                	push   $0x1
    2b82:	e8 5b 15 00 00       	call   40e2 <printf>
    2b87:	83 c4 10             	add    $0x10,%esp
    exit();
    2b8a:	e8 e0 13 00 00       	call   3f6f <exit>
  }

  printf(1, "fourteen ok\n");
    2b8f:	83 ec 08             	sub    $0x8,%esp
    2b92:	68 d9 55 00 00       	push   $0x55d9
    2b97:	6a 01                	push   $0x1
    2b99:	e8 44 15 00 00       	call   40e2 <printf>
    2b9e:	83 c4 10             	add    $0x10,%esp
}
    2ba1:	90                   	nop
    2ba2:	c9                   	leave  
    2ba3:	c3                   	ret    

00002ba4 <rmdot>:

void
rmdot(void)
{
    2ba4:	55                   	push   %ebp
    2ba5:	89 e5                	mov    %esp,%ebp
    2ba7:	83 ec 08             	sub    $0x8,%esp
  printf(1, "rmdot test\n");
    2baa:	83 ec 08             	sub    $0x8,%esp
    2bad:	68 e6 55 00 00       	push   $0x55e6
    2bb2:	6a 01                	push   $0x1
    2bb4:	e8 29 15 00 00       	call   40e2 <printf>
    2bb9:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dots") != 0){
    2bbc:	83 ec 0c             	sub    $0xc,%esp
    2bbf:	68 f2 55 00 00       	push   $0x55f2
    2bc4:	e8 0e 14 00 00       	call   3fd7 <mkdir>
    2bc9:	83 c4 10             	add    $0x10,%esp
    2bcc:	85 c0                	test   %eax,%eax
    2bce:	74 17                	je     2be7 <rmdot+0x43>
    printf(1, "mkdir dots failed\n");
    2bd0:	83 ec 08             	sub    $0x8,%esp
    2bd3:	68 f7 55 00 00       	push   $0x55f7
    2bd8:	6a 01                	push   $0x1
    2bda:	e8 03 15 00 00       	call   40e2 <printf>
    2bdf:	83 c4 10             	add    $0x10,%esp
    exit();
    2be2:	e8 88 13 00 00       	call   3f6f <exit>
  }
  if(chdir("dots") != 0){
    2be7:	83 ec 0c             	sub    $0xc,%esp
    2bea:	68 f2 55 00 00       	push   $0x55f2
    2bef:	e8 eb 13 00 00       	call   3fdf <chdir>
    2bf4:	83 c4 10             	add    $0x10,%esp
    2bf7:	85 c0                	test   %eax,%eax
    2bf9:	74 17                	je     2c12 <rmdot+0x6e>
    printf(1, "chdir dots failed\n");
    2bfb:	83 ec 08             	sub    $0x8,%esp
    2bfe:	68 0a 56 00 00       	push   $0x560a
    2c03:	6a 01                	push   $0x1
    2c05:	e8 d8 14 00 00       	call   40e2 <printf>
    2c0a:	83 c4 10             	add    $0x10,%esp
    exit();
    2c0d:	e8 5d 13 00 00       	call   3f6f <exit>
  }
  if(unlink(".") == 0){
    2c12:	83 ec 0c             	sub    $0xc,%esp
    2c15:	68 23 4d 00 00       	push   $0x4d23
    2c1a:	e8 a0 13 00 00       	call   3fbf <unlink>
    2c1f:	83 c4 10             	add    $0x10,%esp
    2c22:	85 c0                	test   %eax,%eax
    2c24:	75 17                	jne    2c3d <rmdot+0x99>
    printf(1, "rm . worked!\n");
    2c26:	83 ec 08             	sub    $0x8,%esp
    2c29:	68 1d 56 00 00       	push   $0x561d
    2c2e:	6a 01                	push   $0x1
    2c30:	e8 ad 14 00 00       	call   40e2 <printf>
    2c35:	83 c4 10             	add    $0x10,%esp
    exit();
    2c38:	e8 32 13 00 00       	call   3f6f <exit>
  }
  if(unlink("..") == 0){
    2c3d:	83 ec 0c             	sub    $0xc,%esp
    2c40:	68 b6 48 00 00       	push   $0x48b6
    2c45:	e8 75 13 00 00       	call   3fbf <unlink>
    2c4a:	83 c4 10             	add    $0x10,%esp
    2c4d:	85 c0                	test   %eax,%eax
    2c4f:	75 17                	jne    2c68 <rmdot+0xc4>
    printf(1, "rm .. worked!\n");
    2c51:	83 ec 08             	sub    $0x8,%esp
    2c54:	68 2b 56 00 00       	push   $0x562b
    2c59:	6a 01                	push   $0x1
    2c5b:	e8 82 14 00 00       	call   40e2 <printf>
    2c60:	83 c4 10             	add    $0x10,%esp
    exit();
    2c63:	e8 07 13 00 00       	call   3f6f <exit>
  }
  if(chdir("/") != 0){
    2c68:	83 ec 0c             	sub    $0xc,%esp
    2c6b:	68 0a 45 00 00       	push   $0x450a
    2c70:	e8 6a 13 00 00       	call   3fdf <chdir>
    2c75:	83 c4 10             	add    $0x10,%esp
    2c78:	85 c0                	test   %eax,%eax
    2c7a:	74 17                	je     2c93 <rmdot+0xef>
    printf(1, "chdir / failed\n");
    2c7c:	83 ec 08             	sub    $0x8,%esp
    2c7f:	68 0c 45 00 00       	push   $0x450c
    2c84:	6a 01                	push   $0x1
    2c86:	e8 57 14 00 00       	call   40e2 <printf>
    2c8b:	83 c4 10             	add    $0x10,%esp
    exit();
    2c8e:	e8 dc 12 00 00       	call   3f6f <exit>
  }
  if(unlink("dots/.") == 0){
    2c93:	83 ec 0c             	sub    $0xc,%esp
    2c96:	68 3a 56 00 00       	push   $0x563a
    2c9b:	e8 1f 13 00 00       	call   3fbf <unlink>
    2ca0:	83 c4 10             	add    $0x10,%esp
    2ca3:	85 c0                	test   %eax,%eax
    2ca5:	75 17                	jne    2cbe <rmdot+0x11a>
    printf(1, "unlink dots/. worked!\n");
    2ca7:	83 ec 08             	sub    $0x8,%esp
    2caa:	68 41 56 00 00       	push   $0x5641
    2caf:	6a 01                	push   $0x1
    2cb1:	e8 2c 14 00 00       	call   40e2 <printf>
    2cb6:	83 c4 10             	add    $0x10,%esp
    exit();
    2cb9:	e8 b1 12 00 00       	call   3f6f <exit>
  }
  if(unlink("dots/..") == 0){
    2cbe:	83 ec 0c             	sub    $0xc,%esp
    2cc1:	68 58 56 00 00       	push   $0x5658
    2cc6:	e8 f4 12 00 00       	call   3fbf <unlink>
    2ccb:	83 c4 10             	add    $0x10,%esp
    2cce:	85 c0                	test   %eax,%eax
    2cd0:	75 17                	jne    2ce9 <rmdot+0x145>
    printf(1, "unlink dots/.. worked!\n");
    2cd2:	83 ec 08             	sub    $0x8,%esp
    2cd5:	68 60 56 00 00       	push   $0x5660
    2cda:	6a 01                	push   $0x1
    2cdc:	e8 01 14 00 00       	call   40e2 <printf>
    2ce1:	83 c4 10             	add    $0x10,%esp
    exit();
    2ce4:	e8 86 12 00 00       	call   3f6f <exit>
  }
  if(unlink("dots") != 0){
    2ce9:	83 ec 0c             	sub    $0xc,%esp
    2cec:	68 f2 55 00 00       	push   $0x55f2
    2cf1:	e8 c9 12 00 00       	call   3fbf <unlink>
    2cf6:	83 c4 10             	add    $0x10,%esp
    2cf9:	85 c0                	test   %eax,%eax
    2cfb:	74 17                	je     2d14 <rmdot+0x170>
    printf(1, "unlink dots failed!\n");
    2cfd:	83 ec 08             	sub    $0x8,%esp
    2d00:	68 78 56 00 00       	push   $0x5678
    2d05:	6a 01                	push   $0x1
    2d07:	e8 d6 13 00 00       	call   40e2 <printf>
    2d0c:	83 c4 10             	add    $0x10,%esp
    exit();
    2d0f:	e8 5b 12 00 00       	call   3f6f <exit>
  }
  printf(1, "rmdot ok\n");
    2d14:	83 ec 08             	sub    $0x8,%esp
    2d17:	68 8d 56 00 00       	push   $0x568d
    2d1c:	6a 01                	push   $0x1
    2d1e:	e8 bf 13 00 00       	call   40e2 <printf>
    2d23:	83 c4 10             	add    $0x10,%esp
}
    2d26:	90                   	nop
    2d27:	c9                   	leave  
    2d28:	c3                   	ret    

00002d29 <dirfile>:

void
dirfile(void)
{
    2d29:	55                   	push   %ebp
    2d2a:	89 e5                	mov    %esp,%ebp
    2d2c:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "dir vs file\n");
    2d2f:	83 ec 08             	sub    $0x8,%esp
    2d32:	68 97 56 00 00       	push   $0x5697
    2d37:	6a 01                	push   $0x1
    2d39:	e8 a4 13 00 00       	call   40e2 <printf>
    2d3e:	83 c4 10             	add    $0x10,%esp

  fd = open("dirfile", O_CREATE);
    2d41:	83 ec 08             	sub    $0x8,%esp
    2d44:	68 00 02 00 00       	push   $0x200
    2d49:	68 a4 56 00 00       	push   $0x56a4
    2d4e:	e8 5c 12 00 00       	call   3faf <open>
    2d53:	83 c4 10             	add    $0x10,%esp
    2d56:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2d59:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d5d:	79 17                	jns    2d76 <dirfile+0x4d>
    printf(1, "create dirfile failed\n");
    2d5f:	83 ec 08             	sub    $0x8,%esp
    2d62:	68 ac 56 00 00       	push   $0x56ac
    2d67:	6a 01                	push   $0x1
    2d69:	e8 74 13 00 00       	call   40e2 <printf>
    2d6e:	83 c4 10             	add    $0x10,%esp
    exit();
    2d71:	e8 f9 11 00 00       	call   3f6f <exit>
  }
  close(fd);
    2d76:	83 ec 0c             	sub    $0xc,%esp
    2d79:	ff 75 f4             	pushl  -0xc(%ebp)
    2d7c:	e8 16 12 00 00       	call   3f97 <close>
    2d81:	83 c4 10             	add    $0x10,%esp
  if(chdir("dirfile") == 0){
    2d84:	83 ec 0c             	sub    $0xc,%esp
    2d87:	68 a4 56 00 00       	push   $0x56a4
    2d8c:	e8 4e 12 00 00       	call   3fdf <chdir>
    2d91:	83 c4 10             	add    $0x10,%esp
    2d94:	85 c0                	test   %eax,%eax
    2d96:	75 17                	jne    2daf <dirfile+0x86>
    printf(1, "chdir dirfile succeeded!\n");
    2d98:	83 ec 08             	sub    $0x8,%esp
    2d9b:	68 c3 56 00 00       	push   $0x56c3
    2da0:	6a 01                	push   $0x1
    2da2:	e8 3b 13 00 00       	call   40e2 <printf>
    2da7:	83 c4 10             	add    $0x10,%esp
    exit();
    2daa:	e8 c0 11 00 00       	call   3f6f <exit>
  }
  fd = open("dirfile/xx", 0);
    2daf:	83 ec 08             	sub    $0x8,%esp
    2db2:	6a 00                	push   $0x0
    2db4:	68 dd 56 00 00       	push   $0x56dd
    2db9:	e8 f1 11 00 00       	call   3faf <open>
    2dbe:	83 c4 10             	add    $0x10,%esp
    2dc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2dc4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2dc8:	78 17                	js     2de1 <dirfile+0xb8>
    printf(1, "create dirfile/xx succeeded!\n");
    2dca:	83 ec 08             	sub    $0x8,%esp
    2dcd:	68 e8 56 00 00       	push   $0x56e8
    2dd2:	6a 01                	push   $0x1
    2dd4:	e8 09 13 00 00       	call   40e2 <printf>
    2dd9:	83 c4 10             	add    $0x10,%esp
    exit();
    2ddc:	e8 8e 11 00 00       	call   3f6f <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    2de1:	83 ec 08             	sub    $0x8,%esp
    2de4:	68 00 02 00 00       	push   $0x200
    2de9:	68 dd 56 00 00       	push   $0x56dd
    2dee:	e8 bc 11 00 00       	call   3faf <open>
    2df3:	83 c4 10             	add    $0x10,%esp
    2df6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2df9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2dfd:	78 17                	js     2e16 <dirfile+0xed>
    printf(1, "create dirfile/xx succeeded!\n");
    2dff:	83 ec 08             	sub    $0x8,%esp
    2e02:	68 e8 56 00 00       	push   $0x56e8
    2e07:	6a 01                	push   $0x1
    2e09:	e8 d4 12 00 00       	call   40e2 <printf>
    2e0e:	83 c4 10             	add    $0x10,%esp
    exit();
    2e11:	e8 59 11 00 00       	call   3f6f <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    2e16:	83 ec 0c             	sub    $0xc,%esp
    2e19:	68 dd 56 00 00       	push   $0x56dd
    2e1e:	e8 b4 11 00 00       	call   3fd7 <mkdir>
    2e23:	83 c4 10             	add    $0x10,%esp
    2e26:	85 c0                	test   %eax,%eax
    2e28:	75 17                	jne    2e41 <dirfile+0x118>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2e2a:	83 ec 08             	sub    $0x8,%esp
    2e2d:	68 06 57 00 00       	push   $0x5706
    2e32:	6a 01                	push   $0x1
    2e34:	e8 a9 12 00 00       	call   40e2 <printf>
    2e39:	83 c4 10             	add    $0x10,%esp
    exit();
    2e3c:	e8 2e 11 00 00       	call   3f6f <exit>
  }
  if(unlink("dirfile/xx") == 0){
    2e41:	83 ec 0c             	sub    $0xc,%esp
    2e44:	68 dd 56 00 00       	push   $0x56dd
    2e49:	e8 71 11 00 00       	call   3fbf <unlink>
    2e4e:	83 c4 10             	add    $0x10,%esp
    2e51:	85 c0                	test   %eax,%eax
    2e53:	75 17                	jne    2e6c <dirfile+0x143>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2e55:	83 ec 08             	sub    $0x8,%esp
    2e58:	68 23 57 00 00       	push   $0x5723
    2e5d:	6a 01                	push   $0x1
    2e5f:	e8 7e 12 00 00       	call   40e2 <printf>
    2e64:	83 c4 10             	add    $0x10,%esp
    exit();
    2e67:	e8 03 11 00 00       	call   3f6f <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    2e6c:	83 ec 08             	sub    $0x8,%esp
    2e6f:	68 dd 56 00 00       	push   $0x56dd
    2e74:	68 41 57 00 00       	push   $0x5741
    2e79:	e8 51 11 00 00       	call   3fcf <link>
    2e7e:	83 c4 10             	add    $0x10,%esp
    2e81:	85 c0                	test   %eax,%eax
    2e83:	75 17                	jne    2e9c <dirfile+0x173>
    printf(1, "link to dirfile/xx succeeded!\n");
    2e85:	83 ec 08             	sub    $0x8,%esp
    2e88:	68 48 57 00 00       	push   $0x5748
    2e8d:	6a 01                	push   $0x1
    2e8f:	e8 4e 12 00 00       	call   40e2 <printf>
    2e94:	83 c4 10             	add    $0x10,%esp
    exit();
    2e97:	e8 d3 10 00 00       	call   3f6f <exit>
  }
  if(unlink("dirfile") != 0){
    2e9c:	83 ec 0c             	sub    $0xc,%esp
    2e9f:	68 a4 56 00 00       	push   $0x56a4
    2ea4:	e8 16 11 00 00       	call   3fbf <unlink>
    2ea9:	83 c4 10             	add    $0x10,%esp
    2eac:	85 c0                	test   %eax,%eax
    2eae:	74 17                	je     2ec7 <dirfile+0x19e>
    printf(1, "unlink dirfile failed!\n");
    2eb0:	83 ec 08             	sub    $0x8,%esp
    2eb3:	68 67 57 00 00       	push   $0x5767
    2eb8:	6a 01                	push   $0x1
    2eba:	e8 23 12 00 00       	call   40e2 <printf>
    2ebf:	83 c4 10             	add    $0x10,%esp
    exit();
    2ec2:	e8 a8 10 00 00       	call   3f6f <exit>
  }

  fd = open(".", O_RDWR);
    2ec7:	83 ec 08             	sub    $0x8,%esp
    2eca:	6a 02                	push   $0x2
    2ecc:	68 23 4d 00 00       	push   $0x4d23
    2ed1:	e8 d9 10 00 00       	call   3faf <open>
    2ed6:	83 c4 10             	add    $0x10,%esp
    2ed9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2edc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ee0:	78 17                	js     2ef9 <dirfile+0x1d0>
    printf(1, "open . for writing succeeded!\n");
    2ee2:	83 ec 08             	sub    $0x8,%esp
    2ee5:	68 80 57 00 00       	push   $0x5780
    2eea:	6a 01                	push   $0x1
    2eec:	e8 f1 11 00 00       	call   40e2 <printf>
    2ef1:	83 c4 10             	add    $0x10,%esp
    exit();
    2ef4:	e8 76 10 00 00       	call   3f6f <exit>
  }
  fd = open(".", 0);
    2ef9:	83 ec 08             	sub    $0x8,%esp
    2efc:	6a 00                	push   $0x0
    2efe:	68 23 4d 00 00       	push   $0x4d23
    2f03:	e8 a7 10 00 00       	call   3faf <open>
    2f08:	83 c4 10             	add    $0x10,%esp
    2f0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(write(fd, "x", 1) > 0){
    2f0e:	83 ec 04             	sub    $0x4,%esp
    2f11:	6a 01                	push   $0x1
    2f13:	68 6f 49 00 00       	push   $0x496f
    2f18:	ff 75 f4             	pushl  -0xc(%ebp)
    2f1b:	e8 6f 10 00 00       	call   3f8f <write>
    2f20:	83 c4 10             	add    $0x10,%esp
    2f23:	85 c0                	test   %eax,%eax
    2f25:	7e 17                	jle    2f3e <dirfile+0x215>
    printf(1, "write . succeeded!\n");
    2f27:	83 ec 08             	sub    $0x8,%esp
    2f2a:	68 9f 57 00 00       	push   $0x579f
    2f2f:	6a 01                	push   $0x1
    2f31:	e8 ac 11 00 00       	call   40e2 <printf>
    2f36:	83 c4 10             	add    $0x10,%esp
    exit();
    2f39:	e8 31 10 00 00       	call   3f6f <exit>
  }
  close(fd);
    2f3e:	83 ec 0c             	sub    $0xc,%esp
    2f41:	ff 75 f4             	pushl  -0xc(%ebp)
    2f44:	e8 4e 10 00 00       	call   3f97 <close>
    2f49:	83 c4 10             	add    $0x10,%esp

  printf(1, "dir vs file OK\n");
    2f4c:	83 ec 08             	sub    $0x8,%esp
    2f4f:	68 b3 57 00 00       	push   $0x57b3
    2f54:	6a 01                	push   $0x1
    2f56:	e8 87 11 00 00       	call   40e2 <printf>
    2f5b:	83 c4 10             	add    $0x10,%esp
}
    2f5e:	90                   	nop
    2f5f:	c9                   	leave  
    2f60:	c3                   	ret    

00002f61 <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2f61:	55                   	push   %ebp
    2f62:	89 e5                	mov    %esp,%ebp
    2f64:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2f67:	83 ec 08             	sub    $0x8,%esp
    2f6a:	68 c3 57 00 00       	push   $0x57c3
    2f6f:	6a 01                	push   $0x1
    2f71:	e8 6c 11 00 00       	call   40e2 <printf>
    2f76:	83 c4 10             	add    $0x10,%esp

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2f79:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2f80:	e9 e7 00 00 00       	jmp    306c <iref+0x10b>
    if(mkdir("irefd") != 0){
    2f85:	83 ec 0c             	sub    $0xc,%esp
    2f88:	68 d4 57 00 00       	push   $0x57d4
    2f8d:	e8 45 10 00 00       	call   3fd7 <mkdir>
    2f92:	83 c4 10             	add    $0x10,%esp
    2f95:	85 c0                	test   %eax,%eax
    2f97:	74 17                	je     2fb0 <iref+0x4f>
      printf(1, "mkdir irefd failed\n");
    2f99:	83 ec 08             	sub    $0x8,%esp
    2f9c:	68 da 57 00 00       	push   $0x57da
    2fa1:	6a 01                	push   $0x1
    2fa3:	e8 3a 11 00 00       	call   40e2 <printf>
    2fa8:	83 c4 10             	add    $0x10,%esp
      exit();
    2fab:	e8 bf 0f 00 00       	call   3f6f <exit>
    }
    if(chdir("irefd") != 0){
    2fb0:	83 ec 0c             	sub    $0xc,%esp
    2fb3:	68 d4 57 00 00       	push   $0x57d4
    2fb8:	e8 22 10 00 00       	call   3fdf <chdir>
    2fbd:	83 c4 10             	add    $0x10,%esp
    2fc0:	85 c0                	test   %eax,%eax
    2fc2:	74 17                	je     2fdb <iref+0x7a>
      printf(1, "chdir irefd failed\n");
    2fc4:	83 ec 08             	sub    $0x8,%esp
    2fc7:	68 ee 57 00 00       	push   $0x57ee
    2fcc:	6a 01                	push   $0x1
    2fce:	e8 0f 11 00 00       	call   40e2 <printf>
    2fd3:	83 c4 10             	add    $0x10,%esp
      exit();
    2fd6:	e8 94 0f 00 00       	call   3f6f <exit>
    }

    mkdir("");
    2fdb:	83 ec 0c             	sub    $0xc,%esp
    2fde:	68 02 58 00 00       	push   $0x5802
    2fe3:	e8 ef 0f 00 00       	call   3fd7 <mkdir>
    2fe8:	83 c4 10             	add    $0x10,%esp
    link("README", "");
    2feb:	83 ec 08             	sub    $0x8,%esp
    2fee:	68 02 58 00 00       	push   $0x5802
    2ff3:	68 41 57 00 00       	push   $0x5741
    2ff8:	e8 d2 0f 00 00       	call   3fcf <link>
    2ffd:	83 c4 10             	add    $0x10,%esp
    fd = open("", O_CREATE);
    3000:	83 ec 08             	sub    $0x8,%esp
    3003:	68 00 02 00 00       	push   $0x200
    3008:	68 02 58 00 00       	push   $0x5802
    300d:	e8 9d 0f 00 00       	call   3faf <open>
    3012:	83 c4 10             	add    $0x10,%esp
    3015:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    3018:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    301c:	78 0e                	js     302c <iref+0xcb>
      close(fd);
    301e:	83 ec 0c             	sub    $0xc,%esp
    3021:	ff 75 f0             	pushl  -0x10(%ebp)
    3024:	e8 6e 0f 00 00       	call   3f97 <close>
    3029:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    302c:	83 ec 08             	sub    $0x8,%esp
    302f:	68 00 02 00 00       	push   $0x200
    3034:	68 03 58 00 00       	push   $0x5803
    3039:	e8 71 0f 00 00       	call   3faf <open>
    303e:	83 c4 10             	add    $0x10,%esp
    3041:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    3044:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3048:	78 0e                	js     3058 <iref+0xf7>
      close(fd);
    304a:	83 ec 0c             	sub    $0xc,%esp
    304d:	ff 75 f0             	pushl  -0x10(%ebp)
    3050:	e8 42 0f 00 00       	call   3f97 <close>
    3055:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    3058:	83 ec 0c             	sub    $0xc,%esp
    305b:	68 03 58 00 00       	push   $0x5803
    3060:	e8 5a 0f 00 00       	call   3fbf <unlink>
    3065:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 50 + 1; i++){
    3068:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    306c:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    3070:	0f 8e 0f ff ff ff    	jle    2f85 <iref+0x24>
  }

  chdir("/");
    3076:	83 ec 0c             	sub    $0xc,%esp
    3079:	68 0a 45 00 00       	push   $0x450a
    307e:	e8 5c 0f 00 00       	call   3fdf <chdir>
    3083:	83 c4 10             	add    $0x10,%esp
  printf(1, "empty file name OK\n");
    3086:	83 ec 08             	sub    $0x8,%esp
    3089:	68 06 58 00 00       	push   $0x5806
    308e:	6a 01                	push   $0x1
    3090:	e8 4d 10 00 00       	call   40e2 <printf>
    3095:	83 c4 10             	add    $0x10,%esp
}
    3098:	90                   	nop
    3099:	c9                   	leave  
    309a:	c3                   	ret    

0000309b <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    309b:	55                   	push   %ebp
    309c:	89 e5                	mov    %esp,%ebp
    309e:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
    30a1:	83 ec 08             	sub    $0x8,%esp
    30a4:	68 1a 58 00 00       	push   $0x581a
    30a9:	6a 01                	push   $0x1
    30ab:	e8 32 10 00 00       	call   40e2 <printf>
    30b0:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    30b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    30ba:	eb 25                	jmp    30e1 <forktest+0x46>
    pid = fork(0);
    30bc:	83 ec 0c             	sub    $0xc,%esp
    30bf:	6a 00                	push   $0x0
    30c1:	e8 a1 0e 00 00       	call   3f67 <fork>
    30c6:	83 c4 10             	add    $0x10,%esp
    30c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
    30cc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    30d0:	78 1a                	js     30ec <forktest+0x51>
      break;
    if(pid == 0)
    30d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    30d6:	75 05                	jne    30dd <forktest+0x42>
      exit();
    30d8:	e8 92 0e 00 00       	call   3f6f <exit>
  for(n=0; n<1000; n++){
    30dd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    30e1:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    30e8:	7e d2                	jle    30bc <forktest+0x21>
    30ea:	eb 01                	jmp    30ed <forktest+0x52>
      break;
    30ec:	90                   	nop
  }
  
  if(n == 1000){
    30ed:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    30f4:	75 3b                	jne    3131 <forktest+0x96>
    printf(1, "fork claimed to work 1000 times!\n");
    30f6:	83 ec 08             	sub    $0x8,%esp
    30f9:	68 28 58 00 00       	push   $0x5828
    30fe:	6a 01                	push   $0x1
    3100:	e8 dd 0f 00 00       	call   40e2 <printf>
    3105:	83 c4 10             	add    $0x10,%esp
    exit();
    3108:	e8 62 0e 00 00       	call   3f6f <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
    310d:	e8 65 0e 00 00       	call   3f77 <wait>
    3112:	85 c0                	test   %eax,%eax
    3114:	79 17                	jns    312d <forktest+0x92>
      printf(1, "wait stopped early\n");
    3116:	83 ec 08             	sub    $0x8,%esp
    3119:	68 4a 58 00 00       	push   $0x584a
    311e:	6a 01                	push   $0x1
    3120:	e8 bd 0f 00 00       	call   40e2 <printf>
    3125:	83 c4 10             	add    $0x10,%esp
      exit();
    3128:	e8 42 0e 00 00       	call   3f6f <exit>
  for(; n > 0; n--){
    312d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    3131:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3135:	7f d6                	jg     310d <forktest+0x72>
    }
  }
  
  if(wait() != -1){
    3137:	e8 3b 0e 00 00       	call   3f77 <wait>
    313c:	83 f8 ff             	cmp    $0xffffffff,%eax
    313f:	74 17                	je     3158 <forktest+0xbd>
    printf(1, "wait got too many\n");
    3141:	83 ec 08             	sub    $0x8,%esp
    3144:	68 5e 58 00 00       	push   $0x585e
    3149:	6a 01                	push   $0x1
    314b:	e8 92 0f 00 00       	call   40e2 <printf>
    3150:	83 c4 10             	add    $0x10,%esp
    exit();
    3153:	e8 17 0e 00 00       	call   3f6f <exit>
  }
  
  printf(1, "fork test OK\n");
    3158:	83 ec 08             	sub    $0x8,%esp
    315b:	68 71 58 00 00       	push   $0x5871
    3160:	6a 01                	push   $0x1
    3162:	e8 7b 0f 00 00       	call   40e2 <printf>
    3167:	83 c4 10             	add    $0x10,%esp
}
    316a:	90                   	nop
    316b:	c9                   	leave  
    316c:	c3                   	ret    

0000316d <sbrktest>:

void
sbrktest(void)
{
    316d:	55                   	push   %ebp
    316e:	89 e5                	mov    %esp,%ebp
    3170:	83 ec 68             	sub    $0x68,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    3173:	a1 4c 63 00 00       	mov    0x634c,%eax
    3178:	83 ec 08             	sub    $0x8,%esp
    317b:	68 7f 58 00 00       	push   $0x587f
    3180:	50                   	push   %eax
    3181:	e8 5c 0f 00 00       	call   40e2 <printf>
    3186:	83 c4 10             	add    $0x10,%esp
  oldbrk = sbrk(0);
    3189:	83 ec 0c             	sub    $0xc,%esp
    318c:	6a 00                	push   $0x0
    318e:	e8 64 0e 00 00       	call   3ff7 <sbrk>
    3193:	83 c4 10             	add    $0x10,%esp
    3196:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    3199:	83 ec 0c             	sub    $0xc,%esp
    319c:	6a 00                	push   $0x0
    319e:	e8 54 0e 00 00       	call   3ff7 <sbrk>
    31a3:	83 c4 10             	add    $0x10,%esp
    31a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i;
  for(i = 0; i < 5000; i++){ 
    31a9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    31b0:	eb 4f                	jmp    3201 <sbrktest+0x94>
    b = sbrk(1);
    31b2:	83 ec 0c             	sub    $0xc,%esp
    31b5:	6a 01                	push   $0x1
    31b7:	e8 3b 0e 00 00       	call   3ff7 <sbrk>
    31bc:	83 c4 10             	add    $0x10,%esp
    31bf:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(b != a){
    31c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    31c5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    31c8:	74 24                	je     31ee <sbrktest+0x81>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    31ca:	a1 4c 63 00 00       	mov    0x634c,%eax
    31cf:	83 ec 0c             	sub    $0xc,%esp
    31d2:	ff 75 e8             	pushl  -0x18(%ebp)
    31d5:	ff 75 f4             	pushl  -0xc(%ebp)
    31d8:	ff 75 f0             	pushl  -0x10(%ebp)
    31db:	68 8a 58 00 00       	push   $0x588a
    31e0:	50                   	push   %eax
    31e1:	e8 fc 0e 00 00       	call   40e2 <printf>
    31e6:	83 c4 20             	add    $0x20,%esp
      exit();
    31e9:	e8 81 0d 00 00       	call   3f6f <exit>
    }
    *b = 1;
    31ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
    31f1:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    31f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    31f7:	83 c0 01             	add    $0x1,%eax
    31fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; i < 5000; i++){ 
    31fd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3201:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    3208:	7e a8                	jle    31b2 <sbrktest+0x45>
  }
  pid = fork(0);
    320a:	83 ec 0c             	sub    $0xc,%esp
    320d:	6a 00                	push   $0x0
    320f:	e8 53 0d 00 00       	call   3f67 <fork>
    3214:	83 c4 10             	add    $0x10,%esp
    3217:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    321a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    321e:	79 1b                	jns    323b <sbrktest+0xce>
    printf(stdout, "sbrk test fork failed\n");
    3220:	a1 4c 63 00 00       	mov    0x634c,%eax
    3225:	83 ec 08             	sub    $0x8,%esp
    3228:	68 a5 58 00 00       	push   $0x58a5
    322d:	50                   	push   %eax
    322e:	e8 af 0e 00 00       	call   40e2 <printf>
    3233:	83 c4 10             	add    $0x10,%esp
    exit();
    3236:	e8 34 0d 00 00       	call   3f6f <exit>
  }
  c = sbrk(1);
    323b:	83 ec 0c             	sub    $0xc,%esp
    323e:	6a 01                	push   $0x1
    3240:	e8 b2 0d 00 00       	call   3ff7 <sbrk>
    3245:	83 c4 10             	add    $0x10,%esp
    3248:	89 45 e0             	mov    %eax,-0x20(%ebp)
  c = sbrk(1);
    324b:	83 ec 0c             	sub    $0xc,%esp
    324e:	6a 01                	push   $0x1
    3250:	e8 a2 0d 00 00       	call   3ff7 <sbrk>
    3255:	83 c4 10             	add    $0x10,%esp
    3258:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a + 1){
    325b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    325e:	83 c0 01             	add    $0x1,%eax
    3261:	39 45 e0             	cmp    %eax,-0x20(%ebp)
    3264:	74 1b                	je     3281 <sbrktest+0x114>
    printf(stdout, "sbrk test failed post-fork\n");
    3266:	a1 4c 63 00 00       	mov    0x634c,%eax
    326b:	83 ec 08             	sub    $0x8,%esp
    326e:	68 bc 58 00 00       	push   $0x58bc
    3273:	50                   	push   %eax
    3274:	e8 69 0e 00 00       	call   40e2 <printf>
    3279:	83 c4 10             	add    $0x10,%esp
    exit();
    327c:	e8 ee 0c 00 00       	call   3f6f <exit>
  }
  if(pid == 0)
    3281:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3285:	75 05                	jne    328c <sbrktest+0x11f>
    exit();
    3287:	e8 e3 0c 00 00       	call   3f6f <exit>
  wait();
    328c:	e8 e6 0c 00 00       	call   3f77 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    3291:	83 ec 0c             	sub    $0xc,%esp
    3294:	6a 00                	push   $0x0
    3296:	e8 5c 0d 00 00       	call   3ff7 <sbrk>
    329b:	83 c4 10             	add    $0x10,%esp
    329e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  amt = (BIG) - (uint)a;
    32a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    32a4:	ba 00 00 40 06       	mov    $0x6400000,%edx
    32a9:	29 c2                	sub    %eax,%edx
    32ab:	89 d0                	mov    %edx,%eax
    32ad:	89 45 dc             	mov    %eax,-0x24(%ebp)
  p = sbrk(amt);
    32b0:	8b 45 dc             	mov    -0x24(%ebp),%eax
    32b3:	83 ec 0c             	sub    $0xc,%esp
    32b6:	50                   	push   %eax
    32b7:	e8 3b 0d 00 00       	call   3ff7 <sbrk>
    32bc:	83 c4 10             	add    $0x10,%esp
    32bf:	89 45 d8             	mov    %eax,-0x28(%ebp)
  if (p != a) { 
    32c2:	8b 45 d8             	mov    -0x28(%ebp),%eax
    32c5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    32c8:	74 1b                	je     32e5 <sbrktest+0x178>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    32ca:	a1 4c 63 00 00       	mov    0x634c,%eax
    32cf:	83 ec 08             	sub    $0x8,%esp
    32d2:	68 d8 58 00 00       	push   $0x58d8
    32d7:	50                   	push   %eax
    32d8:	e8 05 0e 00 00       	call   40e2 <printf>
    32dd:	83 c4 10             	add    $0x10,%esp
    exit();
    32e0:	e8 8a 0c 00 00       	call   3f6f <exit>
  }
  lastaddr = (char*) (BIG-1);
    32e5:	c7 45 d4 ff ff 3f 06 	movl   $0x63fffff,-0x2c(%ebp)
  *lastaddr = 99;
    32ec:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    32ef:	c6 00 63             	movb   $0x63,(%eax)

  // can one de-allocate?
  a = sbrk(0);
    32f2:	83 ec 0c             	sub    $0xc,%esp
    32f5:	6a 00                	push   $0x0
    32f7:	e8 fb 0c 00 00       	call   3ff7 <sbrk>
    32fc:	83 c4 10             	add    $0x10,%esp
    32ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-4096);
    3302:	83 ec 0c             	sub    $0xc,%esp
    3305:	68 00 f0 ff ff       	push   $0xfffff000
    330a:	e8 e8 0c 00 00       	call   3ff7 <sbrk>
    330f:	83 c4 10             	add    $0x10,%esp
    3312:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c == (char*)0xffffffff){
    3315:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    3319:	75 1b                	jne    3336 <sbrktest+0x1c9>
    printf(stdout, "sbrk could not deallocate\n");
    331b:	a1 4c 63 00 00       	mov    0x634c,%eax
    3320:	83 ec 08             	sub    $0x8,%esp
    3323:	68 16 59 00 00       	push   $0x5916
    3328:	50                   	push   %eax
    3329:	e8 b4 0d 00 00       	call   40e2 <printf>
    332e:	83 c4 10             	add    $0x10,%esp
    exit();
    3331:	e8 39 0c 00 00       	call   3f6f <exit>
  }
  c = sbrk(0);
    3336:	83 ec 0c             	sub    $0xc,%esp
    3339:	6a 00                	push   $0x0
    333b:	e8 b7 0c 00 00       	call   3ff7 <sbrk>
    3340:	83 c4 10             	add    $0x10,%esp
    3343:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a - 4096){
    3346:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3349:	2d 00 10 00 00       	sub    $0x1000,%eax
    334e:	39 45 e0             	cmp    %eax,-0x20(%ebp)
    3351:	74 1e                	je     3371 <sbrktest+0x204>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3353:	a1 4c 63 00 00       	mov    0x634c,%eax
    3358:	ff 75 e0             	pushl  -0x20(%ebp)
    335b:	ff 75 f4             	pushl  -0xc(%ebp)
    335e:	68 34 59 00 00       	push   $0x5934
    3363:	50                   	push   %eax
    3364:	e8 79 0d 00 00       	call   40e2 <printf>
    3369:	83 c4 10             	add    $0x10,%esp
    exit();
    336c:	e8 fe 0b 00 00       	call   3f6f <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    3371:	83 ec 0c             	sub    $0xc,%esp
    3374:	6a 00                	push   $0x0
    3376:	e8 7c 0c 00 00       	call   3ff7 <sbrk>
    337b:	83 c4 10             	add    $0x10,%esp
    337e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(4096);
    3381:	83 ec 0c             	sub    $0xc,%esp
    3384:	68 00 10 00 00       	push   $0x1000
    3389:	e8 69 0c 00 00       	call   3ff7 <sbrk>
    338e:	83 c4 10             	add    $0x10,%esp
    3391:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a || sbrk(0) != a + 4096){
    3394:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3397:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    339a:	75 1b                	jne    33b7 <sbrktest+0x24a>
    339c:	83 ec 0c             	sub    $0xc,%esp
    339f:	6a 00                	push   $0x0
    33a1:	e8 51 0c 00 00       	call   3ff7 <sbrk>
    33a6:	83 c4 10             	add    $0x10,%esp
    33a9:	89 c2                	mov    %eax,%edx
    33ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    33ae:	05 00 10 00 00       	add    $0x1000,%eax
    33b3:	39 c2                	cmp    %eax,%edx
    33b5:	74 1e                	je     33d5 <sbrktest+0x268>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    33b7:	a1 4c 63 00 00       	mov    0x634c,%eax
    33bc:	ff 75 e0             	pushl  -0x20(%ebp)
    33bf:	ff 75 f4             	pushl  -0xc(%ebp)
    33c2:	68 6c 59 00 00       	push   $0x596c
    33c7:	50                   	push   %eax
    33c8:	e8 15 0d 00 00       	call   40e2 <printf>
    33cd:	83 c4 10             	add    $0x10,%esp
    exit();
    33d0:	e8 9a 0b 00 00       	call   3f6f <exit>
  }
  if(*lastaddr == 99){
    33d5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    33d8:	0f b6 00             	movzbl (%eax),%eax
    33db:	3c 63                	cmp    $0x63,%al
    33dd:	75 1b                	jne    33fa <sbrktest+0x28d>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    33df:	a1 4c 63 00 00       	mov    0x634c,%eax
    33e4:	83 ec 08             	sub    $0x8,%esp
    33e7:	68 94 59 00 00       	push   $0x5994
    33ec:	50                   	push   %eax
    33ed:	e8 f0 0c 00 00       	call   40e2 <printf>
    33f2:	83 c4 10             	add    $0x10,%esp
    exit();
    33f5:	e8 75 0b 00 00       	call   3f6f <exit>
  }

  a = sbrk(0);
    33fa:	83 ec 0c             	sub    $0xc,%esp
    33fd:	6a 00                	push   $0x0
    33ff:	e8 f3 0b 00 00       	call   3ff7 <sbrk>
    3404:	83 c4 10             	add    $0x10,%esp
    3407:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-(sbrk(0) - oldbrk));
    340a:	83 ec 0c             	sub    $0xc,%esp
    340d:	6a 00                	push   $0x0
    340f:	e8 e3 0b 00 00       	call   3ff7 <sbrk>
    3414:	83 c4 10             	add    $0x10,%esp
    3417:	89 c2                	mov    %eax,%edx
    3419:	8b 45 ec             	mov    -0x14(%ebp),%eax
    341c:	29 d0                	sub    %edx,%eax
    341e:	83 ec 0c             	sub    $0xc,%esp
    3421:	50                   	push   %eax
    3422:	e8 d0 0b 00 00       	call   3ff7 <sbrk>
    3427:	83 c4 10             	add    $0x10,%esp
    342a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a){
    342d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3430:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3433:	74 1e                	je     3453 <sbrktest+0x2e6>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3435:	a1 4c 63 00 00       	mov    0x634c,%eax
    343a:	ff 75 e0             	pushl  -0x20(%ebp)
    343d:	ff 75 f4             	pushl  -0xc(%ebp)
    3440:	68 c4 59 00 00       	push   $0x59c4
    3445:	50                   	push   %eax
    3446:	e8 97 0c 00 00       	call   40e2 <printf>
    344b:	83 c4 10             	add    $0x10,%esp
    exit();
    344e:	e8 1c 0b 00 00       	call   3f6f <exit>
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3453:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    345a:	eb 7e                	jmp    34da <sbrktest+0x36d>
    ppid = getpid();
    345c:	e8 8e 0b 00 00       	call   3fef <getpid>
    3461:	89 45 d0             	mov    %eax,-0x30(%ebp)
    pid = fork(0);
    3464:	83 ec 0c             	sub    $0xc,%esp
    3467:	6a 00                	push   $0x0
    3469:	e8 f9 0a 00 00       	call   3f67 <fork>
    346e:	83 c4 10             	add    $0x10,%esp
    3471:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(pid < 0){
    3474:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3478:	79 1b                	jns    3495 <sbrktest+0x328>
      printf(stdout, "fork failed\n");
    347a:	a1 4c 63 00 00       	mov    0x634c,%eax
    347f:	83 ec 08             	sub    $0x8,%esp
    3482:	68 39 45 00 00       	push   $0x4539
    3487:	50                   	push   %eax
    3488:	e8 55 0c 00 00       	call   40e2 <printf>
    348d:	83 c4 10             	add    $0x10,%esp
      exit();
    3490:	e8 da 0a 00 00       	call   3f6f <exit>
    }
    if(pid == 0){
    3495:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3499:	75 33                	jne    34ce <sbrktest+0x361>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    349b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    349e:	0f b6 00             	movzbl (%eax),%eax
    34a1:	0f be d0             	movsbl %al,%edx
    34a4:	a1 4c 63 00 00       	mov    0x634c,%eax
    34a9:	52                   	push   %edx
    34aa:	ff 75 f4             	pushl  -0xc(%ebp)
    34ad:	68 e5 59 00 00       	push   $0x59e5
    34b2:	50                   	push   %eax
    34b3:	e8 2a 0c 00 00       	call   40e2 <printf>
    34b8:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    34bb:	83 ec 0c             	sub    $0xc,%esp
    34be:	ff 75 d0             	pushl  -0x30(%ebp)
    34c1:	e8 d9 0a 00 00       	call   3f9f <kill>
    34c6:	83 c4 10             	add    $0x10,%esp
      exit();
    34c9:	e8 a1 0a 00 00       	call   3f6f <exit>
    }
    wait();
    34ce:	e8 a4 0a 00 00       	call   3f77 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    34d3:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    34da:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    34e1:	0f 86 75 ff ff ff    	jbe    345c <sbrktest+0x2ef>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    34e7:	83 ec 0c             	sub    $0xc,%esp
    34ea:	8d 45 c8             	lea    -0x38(%ebp),%eax
    34ed:	50                   	push   %eax
    34ee:	e8 8c 0a 00 00       	call   3f7f <pipe>
    34f3:	83 c4 10             	add    $0x10,%esp
    34f6:	85 c0                	test   %eax,%eax
    34f8:	74 17                	je     3511 <sbrktest+0x3a4>
    printf(1, "pipe() failed\n");
    34fa:	83 ec 08             	sub    $0x8,%esp
    34fd:	68 0a 49 00 00       	push   $0x490a
    3502:	6a 01                	push   $0x1
    3504:	e8 d9 0b 00 00       	call   40e2 <printf>
    3509:	83 c4 10             	add    $0x10,%esp
    exit();
    350c:	e8 5e 0a 00 00       	call   3f6f <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3511:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3518:	e9 90 00 00 00       	jmp    35ad <sbrktest+0x440>
    if((pids[i] = fork(0)) == 0){
    351d:	83 ec 0c             	sub    $0xc,%esp
    3520:	6a 00                	push   $0x0
    3522:	e8 40 0a 00 00       	call   3f67 <fork>
    3527:	83 c4 10             	add    $0x10,%esp
    352a:	89 c2                	mov    %eax,%edx
    352c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    352f:	89 54 85 a0          	mov    %edx,-0x60(%ebp,%eax,4)
    3533:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3536:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    353a:	85 c0                	test   %eax,%eax
    353c:	75 4a                	jne    3588 <sbrktest+0x41b>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    353e:	83 ec 0c             	sub    $0xc,%esp
    3541:	6a 00                	push   $0x0
    3543:	e8 af 0a 00 00       	call   3ff7 <sbrk>
    3548:	83 c4 10             	add    $0x10,%esp
    354b:	ba 00 00 40 06       	mov    $0x6400000,%edx
    3550:	29 c2                	sub    %eax,%edx
    3552:	89 d0                	mov    %edx,%eax
    3554:	83 ec 0c             	sub    $0xc,%esp
    3557:	50                   	push   %eax
    3558:	e8 9a 0a 00 00       	call   3ff7 <sbrk>
    355d:	83 c4 10             	add    $0x10,%esp
      write(fds[1], "x", 1);
    3560:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3563:	83 ec 04             	sub    $0x4,%esp
    3566:	6a 01                	push   $0x1
    3568:	68 6f 49 00 00       	push   $0x496f
    356d:	50                   	push   %eax
    356e:	e8 1c 0a 00 00       	call   3f8f <write>
    3573:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    3576:	83 ec 0c             	sub    $0xc,%esp
    3579:	68 e8 03 00 00       	push   $0x3e8
    357e:	e8 7c 0a 00 00       	call   3fff <sleep>
    3583:	83 c4 10             	add    $0x10,%esp
    3586:	eb ee                	jmp    3576 <sbrktest+0x409>
    }
    if(pids[i] != -1)
    3588:	8b 45 f0             	mov    -0x10(%ebp),%eax
    358b:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    358f:	83 f8 ff             	cmp    $0xffffffff,%eax
    3592:	74 15                	je     35a9 <sbrktest+0x43c>
      read(fds[0], &scratch, 1);
    3594:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3597:	83 ec 04             	sub    $0x4,%esp
    359a:	6a 01                	push   $0x1
    359c:	8d 55 9f             	lea    -0x61(%ebp),%edx
    359f:	52                   	push   %edx
    35a0:	50                   	push   %eax
    35a1:	e8 e1 09 00 00       	call   3f87 <read>
    35a6:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    35a9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    35ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    35b0:	83 f8 09             	cmp    $0x9,%eax
    35b3:	0f 86 64 ff ff ff    	jbe    351d <sbrktest+0x3b0>
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    35b9:	83 ec 0c             	sub    $0xc,%esp
    35bc:	68 00 10 00 00       	push   $0x1000
    35c1:	e8 31 0a 00 00       	call   3ff7 <sbrk>
    35c6:	83 c4 10             	add    $0x10,%esp
    35c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    35cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    35d3:	eb 2b                	jmp    3600 <sbrktest+0x493>
    if(pids[i] == -1)
    35d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    35d8:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    35dc:	83 f8 ff             	cmp    $0xffffffff,%eax
    35df:	74 1a                	je     35fb <sbrktest+0x48e>
      continue;
    kill(pids[i]);
    35e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    35e4:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    35e8:	83 ec 0c             	sub    $0xc,%esp
    35eb:	50                   	push   %eax
    35ec:	e8 ae 09 00 00       	call   3f9f <kill>
    35f1:	83 c4 10             	add    $0x10,%esp
    wait();
    35f4:	e8 7e 09 00 00       	call   3f77 <wait>
    35f9:	eb 01                	jmp    35fc <sbrktest+0x48f>
      continue;
    35fb:	90                   	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    35fc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3600:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3603:	83 f8 09             	cmp    $0x9,%eax
    3606:	76 cd                	jbe    35d5 <sbrktest+0x468>
  }
  if(c == (char*)0xffffffff){
    3608:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    360c:	75 1b                	jne    3629 <sbrktest+0x4bc>
    printf(stdout, "failed sbrk leaked memory\n");
    360e:	a1 4c 63 00 00       	mov    0x634c,%eax
    3613:	83 ec 08             	sub    $0x8,%esp
    3616:	68 fe 59 00 00       	push   $0x59fe
    361b:	50                   	push   %eax
    361c:	e8 c1 0a 00 00       	call   40e2 <printf>
    3621:	83 c4 10             	add    $0x10,%esp
    exit();
    3624:	e8 46 09 00 00       	call   3f6f <exit>
  }

  if(sbrk(0) > oldbrk)
    3629:	83 ec 0c             	sub    $0xc,%esp
    362c:	6a 00                	push   $0x0
    362e:	e8 c4 09 00 00       	call   3ff7 <sbrk>
    3633:	83 c4 10             	add    $0x10,%esp
    3636:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    3639:	73 20                	jae    365b <sbrktest+0x4ee>
    sbrk(-(sbrk(0) - oldbrk));
    363b:	83 ec 0c             	sub    $0xc,%esp
    363e:	6a 00                	push   $0x0
    3640:	e8 b2 09 00 00       	call   3ff7 <sbrk>
    3645:	83 c4 10             	add    $0x10,%esp
    3648:	89 c2                	mov    %eax,%edx
    364a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    364d:	29 d0                	sub    %edx,%eax
    364f:	83 ec 0c             	sub    $0xc,%esp
    3652:	50                   	push   %eax
    3653:	e8 9f 09 00 00       	call   3ff7 <sbrk>
    3658:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    365b:	a1 4c 63 00 00       	mov    0x634c,%eax
    3660:	83 ec 08             	sub    $0x8,%esp
    3663:	68 19 5a 00 00       	push   $0x5a19
    3668:	50                   	push   %eax
    3669:	e8 74 0a 00 00       	call   40e2 <printf>
    366e:	83 c4 10             	add    $0x10,%esp
}
    3671:	90                   	nop
    3672:	c9                   	leave  
    3673:	c3                   	ret    

00003674 <validateint>:

void
validateint(int *p)
{
    3674:	55                   	push   %ebp
    3675:	89 e5                	mov    %esp,%ebp
    3677:	53                   	push   %ebx
    3678:	83 ec 10             	sub    $0x10,%esp
  int res;
  asm("mov %%esp, %%ebx\n\t"
    367b:	b8 0d 00 00 00       	mov    $0xd,%eax
    3680:	8b 55 08             	mov    0x8(%ebp),%edx
    3683:	89 d1                	mov    %edx,%ecx
    3685:	89 e3                	mov    %esp,%ebx
    3687:	89 cc                	mov    %ecx,%esp
    3689:	cd 40                	int    $0x40
    368b:	89 dc                	mov    %ebx,%esp
    368d:	89 45 f8             	mov    %eax,-0x8(%ebp)
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3690:	90                   	nop
    3691:	83 c4 10             	add    $0x10,%esp
    3694:	5b                   	pop    %ebx
    3695:	5d                   	pop    %ebp
    3696:	c3                   	ret    

00003697 <validatetest>:

void
validatetest(void)
{
    3697:	55                   	push   %ebp
    3698:	89 e5                	mov    %esp,%ebp
    369a:	83 ec 18             	sub    $0x18,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    369d:	a1 4c 63 00 00       	mov    0x634c,%eax
    36a2:	83 ec 08             	sub    $0x8,%esp
    36a5:	68 27 5a 00 00       	push   $0x5a27
    36aa:	50                   	push   %eax
    36ab:	e8 32 0a 00 00       	call   40e2 <printf>
    36b0:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;
    36b3:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)

  for(p = 0; p <= (uint)hi; p += 4096){
    36ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    36c1:	e9 92 00 00 00       	jmp    3758 <validatetest+0xc1>
    if((pid = fork(0)) == 0){
    36c6:	83 ec 0c             	sub    $0xc,%esp
    36c9:	6a 00                	push   $0x0
    36cb:	e8 97 08 00 00       	call   3f67 <fork>
    36d0:	83 c4 10             	add    $0x10,%esp
    36d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    36d6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    36da:	75 14                	jne    36f0 <validatetest+0x59>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    36dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    36df:	83 ec 0c             	sub    $0xc,%esp
    36e2:	50                   	push   %eax
    36e3:	e8 8c ff ff ff       	call   3674 <validateint>
    36e8:	83 c4 10             	add    $0x10,%esp
      exit();
    36eb:	e8 7f 08 00 00       	call   3f6f <exit>
    }
    sleep(0);
    36f0:	83 ec 0c             	sub    $0xc,%esp
    36f3:	6a 00                	push   $0x0
    36f5:	e8 05 09 00 00       	call   3fff <sleep>
    36fa:	83 c4 10             	add    $0x10,%esp
    sleep(0);
    36fd:	83 ec 0c             	sub    $0xc,%esp
    3700:	6a 00                	push   $0x0
    3702:	e8 f8 08 00 00       	call   3fff <sleep>
    3707:	83 c4 10             	add    $0x10,%esp
    kill(pid);
    370a:	83 ec 0c             	sub    $0xc,%esp
    370d:	ff 75 ec             	pushl  -0x14(%ebp)
    3710:	e8 8a 08 00 00       	call   3f9f <kill>
    3715:	83 c4 10             	add    $0x10,%esp
    wait();
    3718:	e8 5a 08 00 00       	call   3f77 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    371d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3720:	83 ec 08             	sub    $0x8,%esp
    3723:	50                   	push   %eax
    3724:	68 36 5a 00 00       	push   $0x5a36
    3729:	e8 a1 08 00 00       	call   3fcf <link>
    372e:	83 c4 10             	add    $0x10,%esp
    3731:	83 f8 ff             	cmp    $0xffffffff,%eax
    3734:	74 1b                	je     3751 <validatetest+0xba>
      printf(stdout, "link should not succeed\n");
    3736:	a1 4c 63 00 00       	mov    0x634c,%eax
    373b:	83 ec 08             	sub    $0x8,%esp
    373e:	68 41 5a 00 00       	push   $0x5a41
    3743:	50                   	push   %eax
    3744:	e8 99 09 00 00       	call   40e2 <printf>
    3749:	83 c4 10             	add    $0x10,%esp
      exit();
    374c:	e8 1e 08 00 00       	call   3f6f <exit>
  for(p = 0; p <= (uint)hi; p += 4096){
    3751:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    3758:	8b 45 f0             	mov    -0x10(%ebp),%eax
    375b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    375e:	0f 86 62 ff ff ff    	jbe    36c6 <validatetest+0x2f>
    }
  }

  printf(stdout, "validate ok\n");
    3764:	a1 4c 63 00 00       	mov    0x634c,%eax
    3769:	83 ec 08             	sub    $0x8,%esp
    376c:	68 5a 5a 00 00       	push   $0x5a5a
    3771:	50                   	push   %eax
    3772:	e8 6b 09 00 00       	call   40e2 <printf>
    3777:	83 c4 10             	add    $0x10,%esp
}
    377a:	90                   	nop
    377b:	c9                   	leave  
    377c:	c3                   	ret    

0000377d <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    377d:	55                   	push   %ebp
    377e:	89 e5                	mov    %esp,%ebp
    3780:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    3783:	a1 4c 63 00 00       	mov    0x634c,%eax
    3788:	83 ec 08             	sub    $0x8,%esp
    378b:	68 67 5a 00 00       	push   $0x5a67
    3790:	50                   	push   %eax
    3791:	e8 4c 09 00 00       	call   40e2 <printf>
    3796:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    3799:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    37a0:	eb 2e                	jmp    37d0 <bsstest+0x53>
    if(uninit[i] != '\0'){
    37a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    37a5:	05 20 64 00 00       	add    $0x6420,%eax
    37aa:	0f b6 00             	movzbl (%eax),%eax
    37ad:	84 c0                	test   %al,%al
    37af:	74 1b                	je     37cc <bsstest+0x4f>
      printf(stdout, "bss test failed\n");
    37b1:	a1 4c 63 00 00       	mov    0x634c,%eax
    37b6:	83 ec 08             	sub    $0x8,%esp
    37b9:	68 71 5a 00 00       	push   $0x5a71
    37be:	50                   	push   %eax
    37bf:	e8 1e 09 00 00       	call   40e2 <printf>
    37c4:	83 c4 10             	add    $0x10,%esp
      exit();
    37c7:	e8 a3 07 00 00       	call   3f6f <exit>
  for(i = 0; i < sizeof(uninit); i++){
    37cc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    37d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    37d3:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    37d8:	76 c8                	jbe    37a2 <bsstest+0x25>
    }
  }
  printf(stdout, "bss test ok\n");
    37da:	a1 4c 63 00 00       	mov    0x634c,%eax
    37df:	83 ec 08             	sub    $0x8,%esp
    37e2:	68 82 5a 00 00       	push   $0x5a82
    37e7:	50                   	push   %eax
    37e8:	e8 f5 08 00 00       	call   40e2 <printf>
    37ed:	83 c4 10             	add    $0x10,%esp
}
    37f0:	90                   	nop
    37f1:	c9                   	leave  
    37f2:	c3                   	ret    

000037f3 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    37f3:	55                   	push   %ebp
    37f4:	89 e5                	mov    %esp,%ebp
    37f6:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    37f9:	83 ec 0c             	sub    $0xc,%esp
    37fc:	68 8f 5a 00 00       	push   $0x5a8f
    3801:	e8 b9 07 00 00       	call   3fbf <unlink>
    3806:	83 c4 10             	add    $0x10,%esp
  pid = fork(0);
    3809:	83 ec 0c             	sub    $0xc,%esp
    380c:	6a 00                	push   $0x0
    380e:	e8 54 07 00 00       	call   3f67 <fork>
    3813:	83 c4 10             	add    $0x10,%esp
    3816:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    3819:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    381d:	0f 85 97 00 00 00    	jne    38ba <bigargtest+0xc7>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3823:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    382a:	eb 12                	jmp    383e <bigargtest+0x4b>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    382c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    382f:	c7 04 85 80 63 00 00 	movl   $0x5a9c,0x6380(,%eax,4)
    3836:	9c 5a 00 00 
    for(i = 0; i < MAXARG-1; i++)
    383a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    383e:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    3842:	7e e8                	jle    382c <bigargtest+0x39>
    args[MAXARG-1] = 0;
    3844:	c7 05 fc 63 00 00 00 	movl   $0x0,0x63fc
    384b:	00 00 00 
    printf(stdout, "bigarg test\n");
    384e:	a1 4c 63 00 00       	mov    0x634c,%eax
    3853:	83 ec 08             	sub    $0x8,%esp
    3856:	68 79 5b 00 00       	push   $0x5b79
    385b:	50                   	push   %eax
    385c:	e8 81 08 00 00       	call   40e2 <printf>
    3861:	83 c4 10             	add    $0x10,%esp
    exec("echo", args);
    3864:	83 ec 08             	sub    $0x8,%esp
    3867:	68 80 63 00 00       	push   $0x6380
    386c:	68 98 44 00 00       	push   $0x4498
    3871:	e8 31 07 00 00       	call   3fa7 <exec>
    3876:	83 c4 10             	add    $0x10,%esp
    printf(stdout, "bigarg test ok\n");
    3879:	a1 4c 63 00 00       	mov    0x634c,%eax
    387e:	83 ec 08             	sub    $0x8,%esp
    3881:	68 86 5b 00 00       	push   $0x5b86
    3886:	50                   	push   %eax
    3887:	e8 56 08 00 00       	call   40e2 <printf>
    388c:	83 c4 10             	add    $0x10,%esp
    fd = open("bigarg-ok", O_CREATE);
    388f:	83 ec 08             	sub    $0x8,%esp
    3892:	68 00 02 00 00       	push   $0x200
    3897:	68 8f 5a 00 00       	push   $0x5a8f
    389c:	e8 0e 07 00 00       	call   3faf <open>
    38a1:	83 c4 10             	add    $0x10,%esp
    38a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    close(fd);
    38a7:	83 ec 0c             	sub    $0xc,%esp
    38aa:	ff 75 ec             	pushl  -0x14(%ebp)
    38ad:	e8 e5 06 00 00       	call   3f97 <close>
    38b2:	83 c4 10             	add    $0x10,%esp
    exit();
    38b5:	e8 b5 06 00 00       	call   3f6f <exit>
  } else if(pid < 0){
    38ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    38be:	79 1b                	jns    38db <bigargtest+0xe8>
    printf(stdout, "bigargtest: fork failed\n");
    38c0:	a1 4c 63 00 00       	mov    0x634c,%eax
    38c5:	83 ec 08             	sub    $0x8,%esp
    38c8:	68 96 5b 00 00       	push   $0x5b96
    38cd:	50                   	push   %eax
    38ce:	e8 0f 08 00 00       	call   40e2 <printf>
    38d3:	83 c4 10             	add    $0x10,%esp
    exit();
    38d6:	e8 94 06 00 00       	call   3f6f <exit>
  }
  wait();
    38db:	e8 97 06 00 00       	call   3f77 <wait>
  fd = open("bigarg-ok", 0);
    38e0:	83 ec 08             	sub    $0x8,%esp
    38e3:	6a 00                	push   $0x0
    38e5:	68 8f 5a 00 00       	push   $0x5a8f
    38ea:	e8 c0 06 00 00       	call   3faf <open>
    38ef:	83 c4 10             	add    $0x10,%esp
    38f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    38f5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    38f9:	79 1b                	jns    3916 <bigargtest+0x123>
    printf(stdout, "bigarg test failed!\n");
    38fb:	a1 4c 63 00 00       	mov    0x634c,%eax
    3900:	83 ec 08             	sub    $0x8,%esp
    3903:	68 af 5b 00 00       	push   $0x5baf
    3908:	50                   	push   %eax
    3909:	e8 d4 07 00 00       	call   40e2 <printf>
    390e:	83 c4 10             	add    $0x10,%esp
    exit();
    3911:	e8 59 06 00 00       	call   3f6f <exit>
  }
  close(fd);
    3916:	83 ec 0c             	sub    $0xc,%esp
    3919:	ff 75 ec             	pushl  -0x14(%ebp)
    391c:	e8 76 06 00 00       	call   3f97 <close>
    3921:	83 c4 10             	add    $0x10,%esp
  unlink("bigarg-ok");
    3924:	83 ec 0c             	sub    $0xc,%esp
    3927:	68 8f 5a 00 00       	push   $0x5a8f
    392c:	e8 8e 06 00 00       	call   3fbf <unlink>
    3931:	83 c4 10             	add    $0x10,%esp
}
    3934:	90                   	nop
    3935:	c9                   	leave  
    3936:	c3                   	ret    

00003937 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3937:	55                   	push   %ebp
    3938:	89 e5                	mov    %esp,%ebp
    393a:	53                   	push   %ebx
    393b:	83 ec 64             	sub    $0x64,%esp
  int nfiles;
  int fsblocks = 0;
    393e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  printf(1, "fsfull test\n");
    3945:	83 ec 08             	sub    $0x8,%esp
    3948:	68 c4 5b 00 00       	push   $0x5bc4
    394d:	6a 01                	push   $0x1
    394f:	e8 8e 07 00 00       	call   40e2 <printf>
    3954:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    3957:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char name[64];
    name[0] = 'f';
    395e:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3962:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3965:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    396a:	89 c8                	mov    %ecx,%eax
    396c:	f7 ea                	imul   %edx
    396e:	c1 fa 06             	sar    $0x6,%edx
    3971:	89 c8                	mov    %ecx,%eax
    3973:	c1 f8 1f             	sar    $0x1f,%eax
    3976:	29 c2                	sub    %eax,%edx
    3978:	89 d0                	mov    %edx,%eax
    397a:	83 c0 30             	add    $0x30,%eax
    397d:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3980:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3983:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3988:	89 d8                	mov    %ebx,%eax
    398a:	f7 ea                	imul   %edx
    398c:	c1 fa 06             	sar    $0x6,%edx
    398f:	89 d8                	mov    %ebx,%eax
    3991:	c1 f8 1f             	sar    $0x1f,%eax
    3994:	89 d1                	mov    %edx,%ecx
    3996:	29 c1                	sub    %eax,%ecx
    3998:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    399e:	29 c3                	sub    %eax,%ebx
    39a0:	89 d9                	mov    %ebx,%ecx
    39a2:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    39a7:	89 c8                	mov    %ecx,%eax
    39a9:	f7 ea                	imul   %edx
    39ab:	c1 fa 05             	sar    $0x5,%edx
    39ae:	89 c8                	mov    %ecx,%eax
    39b0:	c1 f8 1f             	sar    $0x1f,%eax
    39b3:	29 c2                	sub    %eax,%edx
    39b5:	89 d0                	mov    %edx,%eax
    39b7:	83 c0 30             	add    $0x30,%eax
    39ba:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    39bd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    39c0:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    39c5:	89 d8                	mov    %ebx,%eax
    39c7:	f7 ea                	imul   %edx
    39c9:	c1 fa 05             	sar    $0x5,%edx
    39cc:	89 d8                	mov    %ebx,%eax
    39ce:	c1 f8 1f             	sar    $0x1f,%eax
    39d1:	89 d1                	mov    %edx,%ecx
    39d3:	29 c1                	sub    %eax,%ecx
    39d5:	6b c1 64             	imul   $0x64,%ecx,%eax
    39d8:	29 c3                	sub    %eax,%ebx
    39da:	89 d9                	mov    %ebx,%ecx
    39dc:	ba 67 66 66 66       	mov    $0x66666667,%edx
    39e1:	89 c8                	mov    %ecx,%eax
    39e3:	f7 ea                	imul   %edx
    39e5:	c1 fa 02             	sar    $0x2,%edx
    39e8:	89 c8                	mov    %ecx,%eax
    39ea:	c1 f8 1f             	sar    $0x1f,%eax
    39ed:	29 c2                	sub    %eax,%edx
    39ef:	89 d0                	mov    %edx,%eax
    39f1:	83 c0 30             	add    $0x30,%eax
    39f4:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    39f7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    39fa:	ba 67 66 66 66       	mov    $0x66666667,%edx
    39ff:	89 c8                	mov    %ecx,%eax
    3a01:	f7 ea                	imul   %edx
    3a03:	c1 fa 02             	sar    $0x2,%edx
    3a06:	89 c8                	mov    %ecx,%eax
    3a08:	c1 f8 1f             	sar    $0x1f,%eax
    3a0b:	29 c2                	sub    %eax,%edx
    3a0d:	89 d0                	mov    %edx,%eax
    3a0f:	c1 e0 02             	shl    $0x2,%eax
    3a12:	01 d0                	add    %edx,%eax
    3a14:	01 c0                	add    %eax,%eax
    3a16:	29 c1                	sub    %eax,%ecx
    3a18:	89 ca                	mov    %ecx,%edx
    3a1a:	89 d0                	mov    %edx,%eax
    3a1c:	83 c0 30             	add    $0x30,%eax
    3a1f:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3a22:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    printf(1, "writing %s\n", name);
    3a26:	83 ec 04             	sub    $0x4,%esp
    3a29:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3a2c:	50                   	push   %eax
    3a2d:	68 d1 5b 00 00       	push   $0x5bd1
    3a32:	6a 01                	push   $0x1
    3a34:	e8 a9 06 00 00       	call   40e2 <printf>
    3a39:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    3a3c:	83 ec 08             	sub    $0x8,%esp
    3a3f:	68 02 02 00 00       	push   $0x202
    3a44:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3a47:	50                   	push   %eax
    3a48:	e8 62 05 00 00       	call   3faf <open>
    3a4d:	83 c4 10             	add    $0x10,%esp
    3a50:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(fd < 0){
    3a53:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3a57:	79 18                	jns    3a71 <fsfull+0x13a>
      printf(1, "open %s failed\n", name);
    3a59:	83 ec 04             	sub    $0x4,%esp
    3a5c:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3a5f:	50                   	push   %eax
    3a60:	68 dd 5b 00 00       	push   $0x5bdd
    3a65:	6a 01                	push   $0x1
    3a67:	e8 76 06 00 00       	call   40e2 <printf>
    3a6c:	83 c4 10             	add    $0x10,%esp
      break;
    3a6f:	eb 6b                	jmp    3adc <fsfull+0x1a5>
    }
    int total = 0;
    3a71:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(1){
      int cc = write(fd, buf, 512);
    3a78:	83 ec 04             	sub    $0x4,%esp
    3a7b:	68 00 02 00 00       	push   $0x200
    3a80:	68 40 8b 00 00       	push   $0x8b40
    3a85:	ff 75 e8             	pushl  -0x18(%ebp)
    3a88:	e8 02 05 00 00       	call   3f8f <write>
    3a8d:	83 c4 10             	add    $0x10,%esp
    3a90:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(cc < 512)
    3a93:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    3a9a:	7e 0c                	jle    3aa8 <fsfull+0x171>
        break;
      total += cc;
    3a9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3a9f:	01 45 ec             	add    %eax,-0x14(%ebp)
      fsblocks++;
    3aa2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    while(1){
    3aa6:	eb d0                	jmp    3a78 <fsfull+0x141>
        break;
    3aa8:	90                   	nop
    }
    printf(1, "wrote %d bytes\n", total);
    3aa9:	83 ec 04             	sub    $0x4,%esp
    3aac:	ff 75 ec             	pushl  -0x14(%ebp)
    3aaf:	68 ed 5b 00 00       	push   $0x5bed
    3ab4:	6a 01                	push   $0x1
    3ab6:	e8 27 06 00 00       	call   40e2 <printf>
    3abb:	83 c4 10             	add    $0x10,%esp
    close(fd);
    3abe:	83 ec 0c             	sub    $0xc,%esp
    3ac1:	ff 75 e8             	pushl  -0x18(%ebp)
    3ac4:	e8 ce 04 00 00       	call   3f97 <close>
    3ac9:	83 c4 10             	add    $0x10,%esp
    if(total == 0)
    3acc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3ad0:	74 09                	je     3adb <fsfull+0x1a4>
  for(nfiles = 0; ; nfiles++){
    3ad2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3ad6:	e9 83 fe ff ff       	jmp    395e <fsfull+0x27>
      break;
    3adb:	90                   	nop
  }

  while(nfiles >= 0){
    3adc:	e9 db 00 00 00       	jmp    3bbc <fsfull+0x285>
    char name[64];
    name[0] = 'f';
    3ae1:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3ae5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3ae8:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3aed:	89 c8                	mov    %ecx,%eax
    3aef:	f7 ea                	imul   %edx
    3af1:	c1 fa 06             	sar    $0x6,%edx
    3af4:	89 c8                	mov    %ecx,%eax
    3af6:	c1 f8 1f             	sar    $0x1f,%eax
    3af9:	29 c2                	sub    %eax,%edx
    3afb:	89 d0                	mov    %edx,%eax
    3afd:	83 c0 30             	add    $0x30,%eax
    3b00:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3b03:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3b06:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3b0b:	89 d8                	mov    %ebx,%eax
    3b0d:	f7 ea                	imul   %edx
    3b0f:	c1 fa 06             	sar    $0x6,%edx
    3b12:	89 d8                	mov    %ebx,%eax
    3b14:	c1 f8 1f             	sar    $0x1f,%eax
    3b17:	89 d1                	mov    %edx,%ecx
    3b19:	29 c1                	sub    %eax,%ecx
    3b1b:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    3b21:	29 c3                	sub    %eax,%ebx
    3b23:	89 d9                	mov    %ebx,%ecx
    3b25:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3b2a:	89 c8                	mov    %ecx,%eax
    3b2c:	f7 ea                	imul   %edx
    3b2e:	c1 fa 05             	sar    $0x5,%edx
    3b31:	89 c8                	mov    %ecx,%eax
    3b33:	c1 f8 1f             	sar    $0x1f,%eax
    3b36:	29 c2                	sub    %eax,%edx
    3b38:	89 d0                	mov    %edx,%eax
    3b3a:	83 c0 30             	add    $0x30,%eax
    3b3d:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3b40:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3b43:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3b48:	89 d8                	mov    %ebx,%eax
    3b4a:	f7 ea                	imul   %edx
    3b4c:	c1 fa 05             	sar    $0x5,%edx
    3b4f:	89 d8                	mov    %ebx,%eax
    3b51:	c1 f8 1f             	sar    $0x1f,%eax
    3b54:	89 d1                	mov    %edx,%ecx
    3b56:	29 c1                	sub    %eax,%ecx
    3b58:	6b c1 64             	imul   $0x64,%ecx,%eax
    3b5b:	29 c3                	sub    %eax,%ebx
    3b5d:	89 d9                	mov    %ebx,%ecx
    3b5f:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3b64:	89 c8                	mov    %ecx,%eax
    3b66:	f7 ea                	imul   %edx
    3b68:	c1 fa 02             	sar    $0x2,%edx
    3b6b:	89 c8                	mov    %ecx,%eax
    3b6d:	c1 f8 1f             	sar    $0x1f,%eax
    3b70:	29 c2                	sub    %eax,%edx
    3b72:	89 d0                	mov    %edx,%eax
    3b74:	83 c0 30             	add    $0x30,%eax
    3b77:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3b7a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3b7d:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3b82:	89 c8                	mov    %ecx,%eax
    3b84:	f7 ea                	imul   %edx
    3b86:	c1 fa 02             	sar    $0x2,%edx
    3b89:	89 c8                	mov    %ecx,%eax
    3b8b:	c1 f8 1f             	sar    $0x1f,%eax
    3b8e:	29 c2                	sub    %eax,%edx
    3b90:	89 d0                	mov    %edx,%eax
    3b92:	c1 e0 02             	shl    $0x2,%eax
    3b95:	01 d0                	add    %edx,%eax
    3b97:	01 c0                	add    %eax,%eax
    3b99:	29 c1                	sub    %eax,%ecx
    3b9b:	89 ca                	mov    %ecx,%edx
    3b9d:	89 d0                	mov    %edx,%eax
    3b9f:	83 c0 30             	add    $0x30,%eax
    3ba2:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3ba5:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    unlink(name);
    3ba9:	83 ec 0c             	sub    $0xc,%esp
    3bac:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3baf:	50                   	push   %eax
    3bb0:	e8 0a 04 00 00       	call   3fbf <unlink>
    3bb5:	83 c4 10             	add    $0x10,%esp
    nfiles--;
    3bb8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  while(nfiles >= 0){
    3bbc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3bc0:	0f 89 1b ff ff ff    	jns    3ae1 <fsfull+0x1aa>
  }

  printf(1, "fsfull test finished\n");
    3bc6:	83 ec 08             	sub    $0x8,%esp
    3bc9:	68 fd 5b 00 00       	push   $0x5bfd
    3bce:	6a 01                	push   $0x1
    3bd0:	e8 0d 05 00 00       	call   40e2 <printf>
    3bd5:	83 c4 10             	add    $0x10,%esp
}
    3bd8:	90                   	nop
    3bd9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3bdc:	c9                   	leave  
    3bdd:	c3                   	ret    

00003bde <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    3bde:	55                   	push   %ebp
    3bdf:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    3be1:	a1 50 63 00 00       	mov    0x6350,%eax
    3be6:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    3bec:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3bf1:	a3 50 63 00 00       	mov    %eax,0x6350
  return randstate;
    3bf6:	a1 50 63 00 00       	mov    0x6350,%eax
}
    3bfb:	5d                   	pop    %ebp
    3bfc:	c3                   	ret    

00003bfd <main>:

int
main(int argc, char *argv[])
{
    3bfd:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3c01:	83 e4 f0             	and    $0xfffffff0,%esp
    3c04:	ff 71 fc             	pushl  -0x4(%ecx)
    3c07:	55                   	push   %ebp
    3c08:	89 e5                	mov    %esp,%ebp
    3c0a:	51                   	push   %ecx
    3c0b:	83 ec 04             	sub    $0x4,%esp
  printf(1, "usertests starting\n");
    3c0e:	83 ec 08             	sub    $0x8,%esp
    3c11:	68 13 5c 00 00       	push   $0x5c13
    3c16:	6a 01                	push   $0x1
    3c18:	e8 c5 04 00 00       	call   40e2 <printf>
    3c1d:	83 c4 10             	add    $0x10,%esp

  if(open("usertests.ran", 0) >= 0){
    3c20:	83 ec 08             	sub    $0x8,%esp
    3c23:	6a 00                	push   $0x0
    3c25:	68 27 5c 00 00       	push   $0x5c27
    3c2a:	e8 80 03 00 00       	call   3faf <open>
    3c2f:	83 c4 10             	add    $0x10,%esp
    3c32:	85 c0                	test   %eax,%eax
    3c34:	78 17                	js     3c4d <main+0x50>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    3c36:	83 ec 08             	sub    $0x8,%esp
    3c39:	68 38 5c 00 00       	push   $0x5c38
    3c3e:	6a 01                	push   $0x1
    3c40:	e8 9d 04 00 00       	call   40e2 <printf>
    3c45:	83 c4 10             	add    $0x10,%esp
    exit();
    3c48:	e8 22 03 00 00       	call   3f6f <exit>
  }
  close(open("usertests.ran", O_CREATE));
    3c4d:	83 ec 08             	sub    $0x8,%esp
    3c50:	68 00 02 00 00       	push   $0x200
    3c55:	68 27 5c 00 00       	push   $0x5c27
    3c5a:	e8 50 03 00 00       	call   3faf <open>
    3c5f:	83 c4 10             	add    $0x10,%esp
    3c62:	83 ec 0c             	sub    $0xc,%esp
    3c65:	50                   	push   %eax
    3c66:	e8 2c 03 00 00       	call   3f97 <close>
    3c6b:	83 c4 10             	add    $0x10,%esp

  createdelete();
    3c6e:	e8 87 d6 ff ff       	call   12fa <createdelete>
  linkunlink();
    3c73:	e8 c0 e0 ff ff       	call   1d38 <linkunlink>
  concreate();
    3c78:	e8 fb dc ff ff       	call   1978 <concreate>
  fourfiles();
    3c7d:	e8 1f d4 ff ff       	call   10a1 <fourfiles>
  sharedfd();
    3c82:	e8 2f d2 ff ff       	call   eb6 <sharedfd>

  bigargtest();
    3c87:	e8 67 fb ff ff       	call   37f3 <bigargtest>
  bigwrite();
    3c8c:	e8 a1 ea ff ff       	call   2732 <bigwrite>
  bigargtest();
    3c91:	e8 5d fb ff ff       	call   37f3 <bigargtest>
  bsstest();
    3c96:	e8 e2 fa ff ff       	call   377d <bsstest>
  sbrktest();
    3c9b:	e8 cd f4 ff ff       	call   316d <sbrktest>
  validatetest();
    3ca0:	e8 f2 f9 ff ff       	call   3697 <validatetest>

  opentest();
    3ca5:	e8 65 c6 ff ff       	call   30f <opentest>
  writetest();
    3caa:	e8 0f c7 ff ff       	call   3be <writetest>
  writetest1();
    3caf:	e8 1a c9 ff ff       	call   5ce <writetest1>
  createtest();
    3cb4:	e8 11 cb ff ff       	call   7ca <createtest>

  openiputtest();
    3cb9:	e8 3a c5 ff ff       	call   1f8 <openiputtest>
  exitiputtest();
    3cbe:	e8 2e c4 ff ff       	call   f1 <exitiputtest>
  iputtest();
    3cc3:	e8 38 c3 ff ff       	call   0 <iputtest>

  mem();
    3cc8:	e8 f0 d0 ff ff       	call   dbd <mem>
  pipe1();
    3ccd:	e8 ff cc ff ff       	call   9d1 <pipe1>
  preempt();
    3cd2:	e8 eb ce ff ff       	call   bc2 <preempt>
  exitwait();
    3cd7:	e8 61 d0 ff ff       	call   d3d <exitwait>

  rmdot();
    3cdc:	e8 c3 ee ff ff       	call   2ba4 <rmdot>
  fourteen();
    3ce1:	e8 62 ed ff ff       	call   2a48 <fourteen>
  bigfile();
    3ce6:	e8 45 eb ff ff       	call   2830 <bigfile>
  subdir();
    3ceb:	e8 fe e2 ff ff       	call   1fee <subdir>
  linktest();
    3cf0:	e8 41 da ff ff       	call   1736 <linktest>
  unlinkread();
    3cf5:	e8 7a d8 ff ff       	call   1574 <unlinkread>
  dirfile();
    3cfa:	e8 2a f0 ff ff       	call   2d29 <dirfile>
  iref();
    3cff:	e8 5d f2 ff ff       	call   2f61 <iref>
  forktest();
    3d04:	e8 92 f3 ff ff       	call   309b <forktest>
  bigdir(); // slow
    3d09:	e8 6b e1 ff ff       	call   1e79 <bigdir>
  exectest();
    3d0e:	e8 6b cc ff ff       	call   97e <exectest>

  exit();
    3d13:	e8 57 02 00 00       	call   3f6f <exit>

00003d18 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    3d18:	55                   	push   %ebp
    3d19:	89 e5                	mov    %esp,%ebp
    3d1b:	57                   	push   %edi
    3d1c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    3d1d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3d20:	8b 55 10             	mov    0x10(%ebp),%edx
    3d23:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d26:	89 cb                	mov    %ecx,%ebx
    3d28:	89 df                	mov    %ebx,%edi
    3d2a:	89 d1                	mov    %edx,%ecx
    3d2c:	fc                   	cld    
    3d2d:	f3 aa                	rep stos %al,%es:(%edi)
    3d2f:	89 ca                	mov    %ecx,%edx
    3d31:	89 fb                	mov    %edi,%ebx
    3d33:	89 5d 08             	mov    %ebx,0x8(%ebp)
    3d36:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    3d39:	90                   	nop
    3d3a:	5b                   	pop    %ebx
    3d3b:	5f                   	pop    %edi
    3d3c:	5d                   	pop    %ebp
    3d3d:	c3                   	ret    

00003d3e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3d3e:	55                   	push   %ebp
    3d3f:	89 e5                	mov    %esp,%ebp
    3d41:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    3d44:	8b 45 08             	mov    0x8(%ebp),%eax
    3d47:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    3d4a:	90                   	nop
    3d4b:	8b 55 0c             	mov    0xc(%ebp),%edx
    3d4e:	8d 42 01             	lea    0x1(%edx),%eax
    3d51:	89 45 0c             	mov    %eax,0xc(%ebp)
    3d54:	8b 45 08             	mov    0x8(%ebp),%eax
    3d57:	8d 48 01             	lea    0x1(%eax),%ecx
    3d5a:	89 4d 08             	mov    %ecx,0x8(%ebp)
    3d5d:	0f b6 12             	movzbl (%edx),%edx
    3d60:	88 10                	mov    %dl,(%eax)
    3d62:	0f b6 00             	movzbl (%eax),%eax
    3d65:	84 c0                	test   %al,%al
    3d67:	75 e2                	jne    3d4b <strcpy+0xd>
    ;
  return os;
    3d69:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3d6c:	c9                   	leave  
    3d6d:	c3                   	ret    

00003d6e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3d6e:	55                   	push   %ebp
    3d6f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    3d71:	eb 08                	jmp    3d7b <strcmp+0xd>
    p++, q++;
    3d73:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3d77:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    3d7b:	8b 45 08             	mov    0x8(%ebp),%eax
    3d7e:	0f b6 00             	movzbl (%eax),%eax
    3d81:	84 c0                	test   %al,%al
    3d83:	74 10                	je     3d95 <strcmp+0x27>
    3d85:	8b 45 08             	mov    0x8(%ebp),%eax
    3d88:	0f b6 10             	movzbl (%eax),%edx
    3d8b:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d8e:	0f b6 00             	movzbl (%eax),%eax
    3d91:	38 c2                	cmp    %al,%dl
    3d93:	74 de                	je     3d73 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
    3d95:	8b 45 08             	mov    0x8(%ebp),%eax
    3d98:	0f b6 00             	movzbl (%eax),%eax
    3d9b:	0f b6 d0             	movzbl %al,%edx
    3d9e:	8b 45 0c             	mov    0xc(%ebp),%eax
    3da1:	0f b6 00             	movzbl (%eax),%eax
    3da4:	0f b6 c0             	movzbl %al,%eax
    3da7:	29 c2                	sub    %eax,%edx
    3da9:	89 d0                	mov    %edx,%eax
}
    3dab:	5d                   	pop    %ebp
    3dac:	c3                   	ret    

00003dad <strlen>:

uint
strlen(char *s)
{
    3dad:	55                   	push   %ebp
    3dae:	89 e5                	mov    %esp,%ebp
    3db0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    3db3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    3dba:	eb 04                	jmp    3dc0 <strlen+0x13>
    3dbc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    3dc0:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3dc3:	8b 45 08             	mov    0x8(%ebp),%eax
    3dc6:	01 d0                	add    %edx,%eax
    3dc8:	0f b6 00             	movzbl (%eax),%eax
    3dcb:	84 c0                	test   %al,%al
    3dcd:	75 ed                	jne    3dbc <strlen+0xf>
    ;
  return n;
    3dcf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3dd2:	c9                   	leave  
    3dd3:	c3                   	ret    

00003dd4 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3dd4:	55                   	push   %ebp
    3dd5:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    3dd7:	8b 45 10             	mov    0x10(%ebp),%eax
    3dda:	50                   	push   %eax
    3ddb:	ff 75 0c             	pushl  0xc(%ebp)
    3dde:	ff 75 08             	pushl  0x8(%ebp)
    3de1:	e8 32 ff ff ff       	call   3d18 <stosb>
    3de6:	83 c4 0c             	add    $0xc,%esp
  return dst;
    3de9:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3dec:	c9                   	leave  
    3ded:	c3                   	ret    

00003dee <strchr>:

char*
strchr(const char *s, char c)
{
    3dee:	55                   	push   %ebp
    3def:	89 e5                	mov    %esp,%ebp
    3df1:	83 ec 04             	sub    $0x4,%esp
    3df4:	8b 45 0c             	mov    0xc(%ebp),%eax
    3df7:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    3dfa:	eb 14                	jmp    3e10 <strchr+0x22>
    if(*s == c)
    3dfc:	8b 45 08             	mov    0x8(%ebp),%eax
    3dff:	0f b6 00             	movzbl (%eax),%eax
    3e02:	38 45 fc             	cmp    %al,-0x4(%ebp)
    3e05:	75 05                	jne    3e0c <strchr+0x1e>
      return (char*)s;
    3e07:	8b 45 08             	mov    0x8(%ebp),%eax
    3e0a:	eb 13                	jmp    3e1f <strchr+0x31>
  for(; *s; s++)
    3e0c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3e10:	8b 45 08             	mov    0x8(%ebp),%eax
    3e13:	0f b6 00             	movzbl (%eax),%eax
    3e16:	84 c0                	test   %al,%al
    3e18:	75 e2                	jne    3dfc <strchr+0xe>
  return 0;
    3e1a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3e1f:	c9                   	leave  
    3e20:	c3                   	ret    

00003e21 <gets>:

char*
gets(char *buf, int max)
{
    3e21:	55                   	push   %ebp
    3e22:	89 e5                	mov    %esp,%ebp
    3e24:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3e27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3e2e:	eb 42                	jmp    3e72 <gets+0x51>
    cc = read(0, &c, 1);
    3e30:	83 ec 04             	sub    $0x4,%esp
    3e33:	6a 01                	push   $0x1
    3e35:	8d 45 ef             	lea    -0x11(%ebp),%eax
    3e38:	50                   	push   %eax
    3e39:	6a 00                	push   $0x0
    3e3b:	e8 47 01 00 00       	call   3f87 <read>
    3e40:	83 c4 10             	add    $0x10,%esp
    3e43:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    3e46:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3e4a:	7e 33                	jle    3e7f <gets+0x5e>
      break;
    buf[i++] = c;
    3e4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e4f:	8d 50 01             	lea    0x1(%eax),%edx
    3e52:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3e55:	89 c2                	mov    %eax,%edx
    3e57:	8b 45 08             	mov    0x8(%ebp),%eax
    3e5a:	01 c2                	add    %eax,%edx
    3e5c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3e60:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    3e62:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3e66:	3c 0a                	cmp    $0xa,%al
    3e68:	74 16                	je     3e80 <gets+0x5f>
    3e6a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3e6e:	3c 0d                	cmp    $0xd,%al
    3e70:	74 0e                	je     3e80 <gets+0x5f>
  for(i=0; i+1 < max; ){
    3e72:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e75:	83 c0 01             	add    $0x1,%eax
    3e78:	39 45 0c             	cmp    %eax,0xc(%ebp)
    3e7b:	7f b3                	jg     3e30 <gets+0xf>
    3e7d:	eb 01                	jmp    3e80 <gets+0x5f>
      break;
    3e7f:	90                   	nop
      break;
  }
  buf[i] = '\0';
    3e80:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3e83:	8b 45 08             	mov    0x8(%ebp),%eax
    3e86:	01 d0                	add    %edx,%eax
    3e88:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    3e8b:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3e8e:	c9                   	leave  
    3e8f:	c3                   	ret    

00003e90 <stat>:

int
stat(char *n, struct stat *st)
{
    3e90:	55                   	push   %ebp
    3e91:	89 e5                	mov    %esp,%ebp
    3e93:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3e96:	83 ec 08             	sub    $0x8,%esp
    3e99:	6a 00                	push   $0x0
    3e9b:	ff 75 08             	pushl  0x8(%ebp)
    3e9e:	e8 0c 01 00 00       	call   3faf <open>
    3ea3:	83 c4 10             	add    $0x10,%esp
    3ea6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    3ea9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3ead:	79 07                	jns    3eb6 <stat+0x26>
    return -1;
    3eaf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3eb4:	eb 25                	jmp    3edb <stat+0x4b>
  r = fstat(fd, st);
    3eb6:	83 ec 08             	sub    $0x8,%esp
    3eb9:	ff 75 0c             	pushl  0xc(%ebp)
    3ebc:	ff 75 f4             	pushl  -0xc(%ebp)
    3ebf:	e8 03 01 00 00       	call   3fc7 <fstat>
    3ec4:	83 c4 10             	add    $0x10,%esp
    3ec7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    3eca:	83 ec 0c             	sub    $0xc,%esp
    3ecd:	ff 75 f4             	pushl  -0xc(%ebp)
    3ed0:	e8 c2 00 00 00       	call   3f97 <close>
    3ed5:	83 c4 10             	add    $0x10,%esp
  return r;
    3ed8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    3edb:	c9                   	leave  
    3edc:	c3                   	ret    

00003edd <atoi>:

int
atoi(const char *s)
{
    3edd:	55                   	push   %ebp
    3ede:	89 e5                	mov    %esp,%ebp
    3ee0:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    3ee3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3eea:	eb 25                	jmp    3f11 <atoi+0x34>
    n = n*10 + *s++ - '0';
    3eec:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3eef:	89 d0                	mov    %edx,%eax
    3ef1:	c1 e0 02             	shl    $0x2,%eax
    3ef4:	01 d0                	add    %edx,%eax
    3ef6:	01 c0                	add    %eax,%eax
    3ef8:	89 c1                	mov    %eax,%ecx
    3efa:	8b 45 08             	mov    0x8(%ebp),%eax
    3efd:	8d 50 01             	lea    0x1(%eax),%edx
    3f00:	89 55 08             	mov    %edx,0x8(%ebp)
    3f03:	0f b6 00             	movzbl (%eax),%eax
    3f06:	0f be c0             	movsbl %al,%eax
    3f09:	01 c8                	add    %ecx,%eax
    3f0b:	83 e8 30             	sub    $0x30,%eax
    3f0e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3f11:	8b 45 08             	mov    0x8(%ebp),%eax
    3f14:	0f b6 00             	movzbl (%eax),%eax
    3f17:	3c 2f                	cmp    $0x2f,%al
    3f19:	7e 0a                	jle    3f25 <atoi+0x48>
    3f1b:	8b 45 08             	mov    0x8(%ebp),%eax
    3f1e:	0f b6 00             	movzbl (%eax),%eax
    3f21:	3c 39                	cmp    $0x39,%al
    3f23:	7e c7                	jle    3eec <atoi+0xf>
  return n;
    3f25:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3f28:	c9                   	leave  
    3f29:	c3                   	ret    

00003f2a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3f2a:	55                   	push   %ebp
    3f2b:	89 e5                	mov    %esp,%ebp
    3f2d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    3f30:	8b 45 08             	mov    0x8(%ebp),%eax
    3f33:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    3f36:	8b 45 0c             	mov    0xc(%ebp),%eax
    3f39:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    3f3c:	eb 17                	jmp    3f55 <memmove+0x2b>
    *dst++ = *src++;
    3f3e:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3f41:	8d 42 01             	lea    0x1(%edx),%eax
    3f44:	89 45 f8             	mov    %eax,-0x8(%ebp)
    3f47:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f4a:	8d 48 01             	lea    0x1(%eax),%ecx
    3f4d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    3f50:	0f b6 12             	movzbl (%edx),%edx
    3f53:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    3f55:	8b 45 10             	mov    0x10(%ebp),%eax
    3f58:	8d 50 ff             	lea    -0x1(%eax),%edx
    3f5b:	89 55 10             	mov    %edx,0x10(%ebp)
    3f5e:	85 c0                	test   %eax,%eax
    3f60:	7f dc                	jg     3f3e <memmove+0x14>
  return vdst;
    3f62:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3f65:	c9                   	leave  
    3f66:	c3                   	ret    

00003f67 <fork>:
    3f67:	b8 01 00 00 00       	mov    $0x1,%eax
    3f6c:	cd 40                	int    $0x40
    3f6e:	c3                   	ret    

00003f6f <exit>:
    3f6f:	b8 02 00 00 00       	mov    $0x2,%eax
    3f74:	cd 40                	int    $0x40
    3f76:	c3                   	ret    

00003f77 <wait>:
    3f77:	b8 03 00 00 00       	mov    $0x3,%eax
    3f7c:	cd 40                	int    $0x40
    3f7e:	c3                   	ret    

00003f7f <pipe>:
    3f7f:	b8 04 00 00 00       	mov    $0x4,%eax
    3f84:	cd 40                	int    $0x40
    3f86:	c3                   	ret    

00003f87 <read>:
    3f87:	b8 05 00 00 00       	mov    $0x5,%eax
    3f8c:	cd 40                	int    $0x40
    3f8e:	c3                   	ret    

00003f8f <write>:
    3f8f:	b8 10 00 00 00       	mov    $0x10,%eax
    3f94:	cd 40                	int    $0x40
    3f96:	c3                   	ret    

00003f97 <close>:
    3f97:	b8 15 00 00 00       	mov    $0x15,%eax
    3f9c:	cd 40                	int    $0x40
    3f9e:	c3                   	ret    

00003f9f <kill>:
    3f9f:	b8 06 00 00 00       	mov    $0x6,%eax
    3fa4:	cd 40                	int    $0x40
    3fa6:	c3                   	ret    

00003fa7 <exec>:
    3fa7:	b8 07 00 00 00       	mov    $0x7,%eax
    3fac:	cd 40                	int    $0x40
    3fae:	c3                   	ret    

00003faf <open>:
    3faf:	b8 0f 00 00 00       	mov    $0xf,%eax
    3fb4:	cd 40                	int    $0x40
    3fb6:	c3                   	ret    

00003fb7 <mknod>:
    3fb7:	b8 11 00 00 00       	mov    $0x11,%eax
    3fbc:	cd 40                	int    $0x40
    3fbe:	c3                   	ret    

00003fbf <unlink>:
    3fbf:	b8 12 00 00 00       	mov    $0x12,%eax
    3fc4:	cd 40                	int    $0x40
    3fc6:	c3                   	ret    

00003fc7 <fstat>:
    3fc7:	b8 08 00 00 00       	mov    $0x8,%eax
    3fcc:	cd 40                	int    $0x40
    3fce:	c3                   	ret    

00003fcf <link>:
    3fcf:	b8 13 00 00 00       	mov    $0x13,%eax
    3fd4:	cd 40                	int    $0x40
    3fd6:	c3                   	ret    

00003fd7 <mkdir>:
    3fd7:	b8 14 00 00 00       	mov    $0x14,%eax
    3fdc:	cd 40                	int    $0x40
    3fde:	c3                   	ret    

00003fdf <chdir>:
    3fdf:	b8 09 00 00 00       	mov    $0x9,%eax
    3fe4:	cd 40                	int    $0x40
    3fe6:	c3                   	ret    

00003fe7 <dup>:
    3fe7:	b8 0a 00 00 00       	mov    $0xa,%eax
    3fec:	cd 40                	int    $0x40
    3fee:	c3                   	ret    

00003fef <getpid>:
    3fef:	b8 0b 00 00 00       	mov    $0xb,%eax
    3ff4:	cd 40                	int    $0x40
    3ff6:	c3                   	ret    

00003ff7 <sbrk>:
    3ff7:	b8 0c 00 00 00       	mov    $0xc,%eax
    3ffc:	cd 40                	int    $0x40
    3ffe:	c3                   	ret    

00003fff <sleep>:
    3fff:	b8 0d 00 00 00       	mov    $0xd,%eax
    4004:	cd 40                	int    $0x40
    4006:	c3                   	ret    

00004007 <uptime>:
    4007:	b8 0e 00 00 00       	mov    $0xe,%eax
    400c:	cd 40                	int    $0x40
    400e:	c3                   	ret    

0000400f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    400f:	55                   	push   %ebp
    4010:	89 e5                	mov    %esp,%ebp
    4012:	83 ec 18             	sub    $0x18,%esp
    4015:	8b 45 0c             	mov    0xc(%ebp),%eax
    4018:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    401b:	83 ec 04             	sub    $0x4,%esp
    401e:	6a 01                	push   $0x1
    4020:	8d 45 f4             	lea    -0xc(%ebp),%eax
    4023:	50                   	push   %eax
    4024:	ff 75 08             	pushl  0x8(%ebp)
    4027:	e8 63 ff ff ff       	call   3f8f <write>
    402c:	83 c4 10             	add    $0x10,%esp
}
    402f:	90                   	nop
    4030:	c9                   	leave  
    4031:	c3                   	ret    

00004032 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    4032:	55                   	push   %ebp
    4033:	89 e5                	mov    %esp,%ebp
    4035:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    4038:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    403f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    4043:	74 17                	je     405c <printint+0x2a>
    4045:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    4049:	79 11                	jns    405c <printint+0x2a>
    neg = 1;
    404b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    4052:	8b 45 0c             	mov    0xc(%ebp),%eax
    4055:	f7 d8                	neg    %eax
    4057:	89 45 ec             	mov    %eax,-0x14(%ebp)
    405a:	eb 06                	jmp    4062 <printint+0x30>
  } else {
    x = xx;
    405c:	8b 45 0c             	mov    0xc(%ebp),%eax
    405f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    4062:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    4069:	8b 4d 10             	mov    0x10(%ebp),%ecx
    406c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    406f:	ba 00 00 00 00       	mov    $0x0,%edx
    4074:	f7 f1                	div    %ecx
    4076:	89 d1                	mov    %edx,%ecx
    4078:	8b 45 f4             	mov    -0xc(%ebp),%eax
    407b:	8d 50 01             	lea    0x1(%eax),%edx
    407e:	89 55 f4             	mov    %edx,-0xc(%ebp)
    4081:	0f b6 91 54 63 00 00 	movzbl 0x6354(%ecx),%edx
    4088:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    408c:	8b 4d 10             	mov    0x10(%ebp),%ecx
    408f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4092:	ba 00 00 00 00       	mov    $0x0,%edx
    4097:	f7 f1                	div    %ecx
    4099:	89 45 ec             	mov    %eax,-0x14(%ebp)
    409c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    40a0:	75 c7                	jne    4069 <printint+0x37>
  if(neg)
    40a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    40a6:	74 2d                	je     40d5 <printint+0xa3>
    buf[i++] = '-';
    40a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40ab:	8d 50 01             	lea    0x1(%eax),%edx
    40ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
    40b1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    40b6:	eb 1d                	jmp    40d5 <printint+0xa3>
    putc(fd, buf[i]);
    40b8:	8d 55 dc             	lea    -0x24(%ebp),%edx
    40bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40be:	01 d0                	add    %edx,%eax
    40c0:	0f b6 00             	movzbl (%eax),%eax
    40c3:	0f be c0             	movsbl %al,%eax
    40c6:	83 ec 08             	sub    $0x8,%esp
    40c9:	50                   	push   %eax
    40ca:	ff 75 08             	pushl  0x8(%ebp)
    40cd:	e8 3d ff ff ff       	call   400f <putc>
    40d2:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    40d5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    40d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    40dd:	79 d9                	jns    40b8 <printint+0x86>
}
    40df:	90                   	nop
    40e0:	c9                   	leave  
    40e1:	c3                   	ret    

000040e2 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    40e2:	55                   	push   %ebp
    40e3:	89 e5                	mov    %esp,%ebp
    40e5:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    40e8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    40ef:	8d 45 0c             	lea    0xc(%ebp),%eax
    40f2:	83 c0 04             	add    $0x4,%eax
    40f5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    40f8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    40ff:	e9 59 01 00 00       	jmp    425d <printf+0x17b>
    c = fmt[i] & 0xff;
    4104:	8b 55 0c             	mov    0xc(%ebp),%edx
    4107:	8b 45 f0             	mov    -0x10(%ebp),%eax
    410a:	01 d0                	add    %edx,%eax
    410c:	0f b6 00             	movzbl (%eax),%eax
    410f:	0f be c0             	movsbl %al,%eax
    4112:	25 ff 00 00 00       	and    $0xff,%eax
    4117:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    411a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    411e:	75 2c                	jne    414c <printf+0x6a>
      if(c == '%'){
    4120:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4124:	75 0c                	jne    4132 <printf+0x50>
        state = '%';
    4126:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    412d:	e9 27 01 00 00       	jmp    4259 <printf+0x177>
      } else {
        putc(fd, c);
    4132:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4135:	0f be c0             	movsbl %al,%eax
    4138:	83 ec 08             	sub    $0x8,%esp
    413b:	50                   	push   %eax
    413c:	ff 75 08             	pushl  0x8(%ebp)
    413f:	e8 cb fe ff ff       	call   400f <putc>
    4144:	83 c4 10             	add    $0x10,%esp
    4147:	e9 0d 01 00 00       	jmp    4259 <printf+0x177>
      }
    } else if(state == '%'){
    414c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    4150:	0f 85 03 01 00 00    	jne    4259 <printf+0x177>
      if(c == 'd'){
    4156:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    415a:	75 1e                	jne    417a <printf+0x98>
        printint(fd, *ap, 10, 1);
    415c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    415f:	8b 00                	mov    (%eax),%eax
    4161:	6a 01                	push   $0x1
    4163:	6a 0a                	push   $0xa
    4165:	50                   	push   %eax
    4166:	ff 75 08             	pushl  0x8(%ebp)
    4169:	e8 c4 fe ff ff       	call   4032 <printint>
    416e:	83 c4 10             	add    $0x10,%esp
        ap++;
    4171:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4175:	e9 d8 00 00 00       	jmp    4252 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    417a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    417e:	74 06                	je     4186 <printf+0xa4>
    4180:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    4184:	75 1e                	jne    41a4 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    4186:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4189:	8b 00                	mov    (%eax),%eax
    418b:	6a 00                	push   $0x0
    418d:	6a 10                	push   $0x10
    418f:	50                   	push   %eax
    4190:	ff 75 08             	pushl  0x8(%ebp)
    4193:	e8 9a fe ff ff       	call   4032 <printint>
    4198:	83 c4 10             	add    $0x10,%esp
        ap++;
    419b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    419f:	e9 ae 00 00 00       	jmp    4252 <printf+0x170>
      } else if(c == 's'){
    41a4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    41a8:	75 43                	jne    41ed <printf+0x10b>
        s = (char*)*ap;
    41aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    41ad:	8b 00                	mov    (%eax),%eax
    41af:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    41b2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    41b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    41ba:	75 25                	jne    41e1 <printf+0xff>
          s = "(null)";
    41bc:	c7 45 f4 62 5c 00 00 	movl   $0x5c62,-0xc(%ebp)
        while(*s != 0){
    41c3:	eb 1c                	jmp    41e1 <printf+0xff>
          putc(fd, *s);
    41c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41c8:	0f b6 00             	movzbl (%eax),%eax
    41cb:	0f be c0             	movsbl %al,%eax
    41ce:	83 ec 08             	sub    $0x8,%esp
    41d1:	50                   	push   %eax
    41d2:	ff 75 08             	pushl  0x8(%ebp)
    41d5:	e8 35 fe ff ff       	call   400f <putc>
    41da:	83 c4 10             	add    $0x10,%esp
          s++;
    41dd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    41e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41e4:	0f b6 00             	movzbl (%eax),%eax
    41e7:	84 c0                	test   %al,%al
    41e9:	75 da                	jne    41c5 <printf+0xe3>
    41eb:	eb 65                	jmp    4252 <printf+0x170>
        }
      } else if(c == 'c'){
    41ed:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    41f1:	75 1d                	jne    4210 <printf+0x12e>
        putc(fd, *ap);
    41f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    41f6:	8b 00                	mov    (%eax),%eax
    41f8:	0f be c0             	movsbl %al,%eax
    41fb:	83 ec 08             	sub    $0x8,%esp
    41fe:	50                   	push   %eax
    41ff:	ff 75 08             	pushl  0x8(%ebp)
    4202:	e8 08 fe ff ff       	call   400f <putc>
    4207:	83 c4 10             	add    $0x10,%esp
        ap++;
    420a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    420e:	eb 42                	jmp    4252 <printf+0x170>
      } else if(c == '%'){
    4210:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4214:	75 17                	jne    422d <printf+0x14b>
        putc(fd, c);
    4216:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4219:	0f be c0             	movsbl %al,%eax
    421c:	83 ec 08             	sub    $0x8,%esp
    421f:	50                   	push   %eax
    4220:	ff 75 08             	pushl  0x8(%ebp)
    4223:	e8 e7 fd ff ff       	call   400f <putc>
    4228:	83 c4 10             	add    $0x10,%esp
    422b:	eb 25                	jmp    4252 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    422d:	83 ec 08             	sub    $0x8,%esp
    4230:	6a 25                	push   $0x25
    4232:	ff 75 08             	pushl  0x8(%ebp)
    4235:	e8 d5 fd ff ff       	call   400f <putc>
    423a:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    423d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4240:	0f be c0             	movsbl %al,%eax
    4243:	83 ec 08             	sub    $0x8,%esp
    4246:	50                   	push   %eax
    4247:	ff 75 08             	pushl  0x8(%ebp)
    424a:	e8 c0 fd ff ff       	call   400f <putc>
    424f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    4252:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    4259:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    425d:	8b 55 0c             	mov    0xc(%ebp),%edx
    4260:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4263:	01 d0                	add    %edx,%eax
    4265:	0f b6 00             	movzbl (%eax),%eax
    4268:	84 c0                	test   %al,%al
    426a:	0f 85 94 fe ff ff    	jne    4104 <printf+0x22>
    }
  }
}
    4270:	90                   	nop
    4271:	c9                   	leave  
    4272:	c3                   	ret    

00004273 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4273:	55                   	push   %ebp
    4274:	89 e5                	mov    %esp,%ebp
    4276:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    4279:	8b 45 08             	mov    0x8(%ebp),%eax
    427c:	83 e8 08             	sub    $0x8,%eax
    427f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4282:	a1 08 64 00 00       	mov    0x6408,%eax
    4287:	89 45 fc             	mov    %eax,-0x4(%ebp)
    428a:	eb 24                	jmp    42b0 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    428c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    428f:	8b 00                	mov    (%eax),%eax
    4291:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    4294:	72 12                	jb     42a8 <free+0x35>
    4296:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4299:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    429c:	77 24                	ja     42c2 <free+0x4f>
    429e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42a1:	8b 00                	mov    (%eax),%eax
    42a3:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    42a6:	72 1a                	jb     42c2 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    42a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42ab:	8b 00                	mov    (%eax),%eax
    42ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
    42b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    42b3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    42b6:	76 d4                	jbe    428c <free+0x19>
    42b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42bb:	8b 00                	mov    (%eax),%eax
    42bd:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    42c0:	73 ca                	jae    428c <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
    42c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    42c5:	8b 40 04             	mov    0x4(%eax),%eax
    42c8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    42cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    42d2:	01 c2                	add    %eax,%edx
    42d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42d7:	8b 00                	mov    (%eax),%eax
    42d9:	39 c2                	cmp    %eax,%edx
    42db:	75 24                	jne    4301 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    42dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    42e0:	8b 50 04             	mov    0x4(%eax),%edx
    42e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42e6:	8b 00                	mov    (%eax),%eax
    42e8:	8b 40 04             	mov    0x4(%eax),%eax
    42eb:	01 c2                	add    %eax,%edx
    42ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
    42f0:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    42f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42f6:	8b 00                	mov    (%eax),%eax
    42f8:	8b 10                	mov    (%eax),%edx
    42fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    42fd:	89 10                	mov    %edx,(%eax)
    42ff:	eb 0a                	jmp    430b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    4301:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4304:	8b 10                	mov    (%eax),%edx
    4306:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4309:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    430b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    430e:	8b 40 04             	mov    0x4(%eax),%eax
    4311:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    4318:	8b 45 fc             	mov    -0x4(%ebp),%eax
    431b:	01 d0                	add    %edx,%eax
    431d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    4320:	75 20                	jne    4342 <free+0xcf>
    p->s.size += bp->s.size;
    4322:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4325:	8b 50 04             	mov    0x4(%eax),%edx
    4328:	8b 45 f8             	mov    -0x8(%ebp),%eax
    432b:	8b 40 04             	mov    0x4(%eax),%eax
    432e:	01 c2                	add    %eax,%edx
    4330:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4333:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    4336:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4339:	8b 10                	mov    (%eax),%edx
    433b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    433e:	89 10                	mov    %edx,(%eax)
    4340:	eb 08                	jmp    434a <free+0xd7>
  } else
    p->s.ptr = bp;
    4342:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4345:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4348:	89 10                	mov    %edx,(%eax)
  freep = p;
    434a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    434d:	a3 08 64 00 00       	mov    %eax,0x6408
}
    4352:	90                   	nop
    4353:	c9                   	leave  
    4354:	c3                   	ret    

00004355 <morecore>:

static Header*
morecore(uint nu)
{
    4355:	55                   	push   %ebp
    4356:	89 e5                	mov    %esp,%ebp
    4358:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    435b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    4362:	77 07                	ja     436b <morecore+0x16>
    nu = 4096;
    4364:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    436b:	8b 45 08             	mov    0x8(%ebp),%eax
    436e:	c1 e0 03             	shl    $0x3,%eax
    4371:	83 ec 0c             	sub    $0xc,%esp
    4374:	50                   	push   %eax
    4375:	e8 7d fc ff ff       	call   3ff7 <sbrk>
    437a:	83 c4 10             	add    $0x10,%esp
    437d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    4380:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    4384:	75 07                	jne    438d <morecore+0x38>
    return 0;
    4386:	b8 00 00 00 00       	mov    $0x0,%eax
    438b:	eb 26                	jmp    43b3 <morecore+0x5e>
  hp = (Header*)p;
    438d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4390:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    4393:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4396:	8b 55 08             	mov    0x8(%ebp),%edx
    4399:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    439c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    439f:	83 c0 08             	add    $0x8,%eax
    43a2:	83 ec 0c             	sub    $0xc,%esp
    43a5:	50                   	push   %eax
    43a6:	e8 c8 fe ff ff       	call   4273 <free>
    43ab:	83 c4 10             	add    $0x10,%esp
  return freep;
    43ae:	a1 08 64 00 00       	mov    0x6408,%eax
}
    43b3:	c9                   	leave  
    43b4:	c3                   	ret    

000043b5 <malloc>:

void*
malloc(uint nbytes)
{
    43b5:	55                   	push   %ebp
    43b6:	89 e5                	mov    %esp,%ebp
    43b8:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    43bb:	8b 45 08             	mov    0x8(%ebp),%eax
    43be:	83 c0 07             	add    $0x7,%eax
    43c1:	c1 e8 03             	shr    $0x3,%eax
    43c4:	83 c0 01             	add    $0x1,%eax
    43c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    43ca:	a1 08 64 00 00       	mov    0x6408,%eax
    43cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    43d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    43d6:	75 23                	jne    43fb <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    43d8:	c7 45 f0 00 64 00 00 	movl   $0x6400,-0x10(%ebp)
    43df:	8b 45 f0             	mov    -0x10(%ebp),%eax
    43e2:	a3 08 64 00 00       	mov    %eax,0x6408
    43e7:	a1 08 64 00 00       	mov    0x6408,%eax
    43ec:	a3 00 64 00 00       	mov    %eax,0x6400
    base.s.size = 0;
    43f1:	c7 05 04 64 00 00 00 	movl   $0x0,0x6404
    43f8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    43fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    43fe:	8b 00                	mov    (%eax),%eax
    4400:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4403:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4406:	8b 40 04             	mov    0x4(%eax),%eax
    4409:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    440c:	77 4d                	ja     445b <malloc+0xa6>
      if(p->s.size == nunits)
    440e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4411:	8b 40 04             	mov    0x4(%eax),%eax
    4414:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    4417:	75 0c                	jne    4425 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    4419:	8b 45 f4             	mov    -0xc(%ebp),%eax
    441c:	8b 10                	mov    (%eax),%edx
    441e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4421:	89 10                	mov    %edx,(%eax)
    4423:	eb 26                	jmp    444b <malloc+0x96>
      else {
        p->s.size -= nunits;
    4425:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4428:	8b 40 04             	mov    0x4(%eax),%eax
    442b:	2b 45 ec             	sub    -0x14(%ebp),%eax
    442e:	89 c2                	mov    %eax,%edx
    4430:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4433:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    4436:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4439:	8b 40 04             	mov    0x4(%eax),%eax
    443c:	c1 e0 03             	shl    $0x3,%eax
    443f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    4442:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4445:	8b 55 ec             	mov    -0x14(%ebp),%edx
    4448:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    444b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    444e:	a3 08 64 00 00       	mov    %eax,0x6408
      return (void*)(p + 1);
    4453:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4456:	83 c0 08             	add    $0x8,%eax
    4459:	eb 3b                	jmp    4496 <malloc+0xe1>
    }
    if(p == freep)
    445b:	a1 08 64 00 00       	mov    0x6408,%eax
    4460:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    4463:	75 1e                	jne    4483 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    4465:	83 ec 0c             	sub    $0xc,%esp
    4468:	ff 75 ec             	pushl  -0x14(%ebp)
    446b:	e8 e5 fe ff ff       	call   4355 <morecore>
    4470:	83 c4 10             	add    $0x10,%esp
    4473:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4476:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    447a:	75 07                	jne    4483 <malloc+0xce>
        return 0;
    447c:	b8 00 00 00 00       	mov    $0x0,%eax
    4481:	eb 13                	jmp    4496 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4483:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4486:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4489:	8b 45 f4             	mov    -0xc(%ebp),%eax
    448c:	8b 00                	mov    (%eax),%eax
    448e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4491:	e9 6d ff ff ff       	jmp    4403 <malloc+0x4e>
  }
}
    4496:	c9                   	leave  
    4497:	c3                   	ret    
