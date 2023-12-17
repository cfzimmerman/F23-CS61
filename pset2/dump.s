
bomb:     file format elf64-x86-64

Disassembly of section .text:

0000000000400dd0 <main>:
  400dd0:	55                   	push   %rbp
  400dd1:	48 89 e5             	mov    %rsp,%rbp
  400dd4:	41 54                	push   %r12
  400dd6:	53                   	push   %rbx
  400dd7:	48 89 f3             	mov    %rsi,%rbx
  400dda:	83 ff 02             	cmp    $0x2,%edi
  400ddd:	0f 84 e0 00 00 00    	je     400ec3 <main+0xf3>
  400de3:	0f 8f 2b 01 00 00    	jg     400f14 <main+0x144>
  400de9:	e8 e2 08 00 00       	call   4016d0 <initialize_bomb()>
  400dee:	bf d7 22 40 00       	mov    $0x4022d7,%edi
  400df3:	e8 78 ff ff ff       	call   400d70 <puts@plt>
  400df8:	e8 c3 09 00 00       	call   4017c0 <read_line()>
  400dfd:	48 89 c7             	mov    %rax,%rdi
  400e00:	e8 1b 02 00 00       	call   401020 <phase1(char*)>
  400e05:	e8 26 0c 00 00       	call   401a30 <phase_defused()>
  400e0a:	bf e7 22 40 00       	mov    $0x4022e7,%edi
  400e0f:	e8 5c ff ff ff       	call   400d70 <puts@plt>
  400e14:	e8 a7 09 00 00       	call   4017c0 <read_line()>
  400e19:	48 89 c7             	mov    %rax,%rdi
  400e1c:	e8 2f 02 00 00       	call   401050 <phase2(char*)>
  400e21:	e8 0a 0c 00 00       	call   401a30 <phase_defused()>
  400e26:	bf f8 22 40 00       	mov    $0x4022f8,%edi
  400e2b:	e8 40 ff ff ff       	call   400d70 <puts@plt>
  400e30:	e8 8b 09 00 00       	call   4017c0 <read_line()>
  400e35:	48 89 c7             	mov    %rax,%rdi
  400e38:	e8 53 02 00 00       	call   401090 <phase3(char*)>
  400e3d:	e8 ee 0b 00 00       	call   401a30 <phase_defused()>
  400e42:	bf 09 23 40 00       	mov    $0x402309,%edi
  400e47:	e8 24 ff ff ff       	call   400d70 <puts@plt>
  400e4c:	e8 6f 09 00 00       	call   4017c0 <read_line()>
  400e51:	48 89 c7             	mov    %rax,%rdi
  400e54:	e8 87 02 00 00       	call   4010e0 <phase4(char*)>
  400e59:	e8 d2 0b 00 00       	call   401a30 <phase_defused()>
  400e5e:	bf 1a 23 40 00       	mov    $0x40231a,%edi
  400e63:	e8 08 ff ff ff       	call   400d70 <puts@plt>
  400e68:	e8 53 09 00 00       	call   4017c0 <read_line()>
  400e6d:	48 89 c7             	mov    %rax,%rdi
  400e70:	e8 8b 03 00 00       	call   401200 <phase5(char*)>
  400e75:	e8 b6 0b 00 00       	call   401a30 <phase_defused()>
  400e7a:	bf 2b 23 40 00       	mov    $0x40232b,%edi
  400e7f:	e8 ec fe ff ff       	call   400d70 <puts@plt>
  400e84:	e8 37 09 00 00       	call   4017c0 <read_line()>
  400e89:	48 89 c7             	mov    %rax,%rdi
  400e8c:	e8 ff 04 00 00       	call   401390 <phase6(char*)>
  400e91:	e8 9a 0b 00 00       	call   401a30 <phase_defused()>
  400e96:	bf 3c 23 40 00       	mov    $0x40233c,%edi
  400e9b:	e8 d0 fe ff ff       	call   400d70 <puts@plt>
  400ea0:	e8 1b 09 00 00       	call   4017c0 <read_line()>
  400ea5:	48 89 c7             	mov    %rax,%rdi
  400ea8:	e8 63 05 00 00       	call   401410 <phase7(char*)>
  400ead:	e8 7e 0b 00 00       	call   401a30 <phase_defused()>
  400eb2:	bf 4d 23 40 00       	mov    $0x40234d,%edi
  400eb7:	e8 b4 fe ff ff       	call   400d70 <puts@plt>
  400ebc:	31 c0                	xor    %eax,%eax
  400ebe:	5b                   	pop    %rbx
  400ebf:	41 5c                	pop    %r12
  400ec1:	5d                   	pop    %rbp
  400ec2:	c3                   	ret    
  400ec3:	4c 8b 66 08          	mov    0x8(%rsi),%r12
  400ec7:	be a4 22 40 00       	mov    $0x4022a4,%esi
  400ecc:	4c 89 e7             	mov    %r12,%rdi
  400ecf:	e8 5c fe ff ff       	call   400d30 <strcmp@plt>
  400ed4:	85 c0                	test   %eax,%eax
  400ed6:	0f 84 0d ff ff ff    	je     400de9 <main+0x19>
  400edc:	be a6 22 40 00       	mov    $0x4022a6,%esi
  400ee1:	4c 89 e7             	mov    %r12,%rdi
  400ee4:	e8 f7 fd ff ff       	call   400ce0 <fopen@plt>
  400ee9:	48 89 05 e0 34 20 00 	mov    %rax,0x2034e0(%rip)        # 6043d0 <infile>
  400ef0:	48 85 c0             	test   %rax,%rax
  400ef3:	0f 85 f0 fe ff ff    	jne    400de9 <main+0x19>
  400ef9:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  400efd:	48 8b 33             	mov    (%rbx),%rsi
  400f00:	bf a8 22 40 00       	mov    $0x4022a8,%edi
  400f05:	e8 e6 fc ff ff       	call   400bf0 <printf@plt>
  400f0a:	bf 08 00 00 00       	mov    $0x8,%edi
  400f0f:	e8 ec fd ff ff       	call   400d00 <exit@plt>
  400f14:	48 8b 36             	mov    (%rsi),%rsi
  400f17:	bf c5 22 40 00       	mov    $0x4022c5,%edi
  400f1c:	31 c0                	xor    %eax,%eax
  400f1e:	e8 cd fc ff ff       	call   400bf0 <printf@plt>
  400f23:	bf 08 00 00 00       	mov    $0x8,%edi
  400f28:	e8 d3 fd ff ff       	call   400d00 <exit@plt>
  400f2d:	0f 1f 00             	nopl   (%rax)

0000000000401020 <phase1(char*)>:
  401020:	55                   	push   %rbp
  401021:	31 d2                	xor    %edx,%edx
  401023:	48 89 e5             	mov    %rsp,%rbp
  401026:	48 83 ec 10          	sub    $0x10,%rsp
  40102a:	48 8d 75 f8          	lea    -0x8(%rbp),%rsi
  40102e:	e8 0d fd ff ff       	call   400d40 <strtol@plt>
  401033:	48 3d 63 2d 00 00    	cmp    $0x2d63,%rax
  401039:	75 05                	jne    401040 <phase1(char*)+0x20>
  40103b:	c9                   	leave  
  40103c:	c3                   	ret    
  40103d:	0f 1f 00             	nopl   (%rax)
  401040:	e8 6b 09 00 00       	call   4019b0 <explode_bomb()>
  401045:	90                   	nop
  401046:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40104d:	00 00 00 

0000000000401050 <phase2(char*)>:
  401050:	55                   	push   %rbp
  401051:	48 89 e5             	mov    %rsp,%rbp
  401054:	48 83 ec 20          	sub    $0x20,%rsp
  401058:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
  40105c:	e8 8f 09 00 00       	call   4019f0 <read_six_numbers(char const*, int*)>
  401061:	8b 75 e0             	mov    -0x20(%rbp),%esi
  401064:	31 c0                	xor    %eax,%eax
  401066:	89 f1                	mov    %esi,%ecx
  401068:	eb 0a                	jmp    401074 <phase2(char*)+0x24>
  40106a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401070:	8b 4c 85 e0          	mov    -0x20(%rbp,%rax,4),%ecx
  401074:	89 c2                	mov    %eax,%edx
  401076:	0f af d0             	imul   %eax,%edx
  401079:	01 f2                	add    %esi,%edx
  40107b:	39 ca                	cmp    %ecx,%edx
  40107d:	75 0c                	jne    40108b <phase2(char*)+0x3b>
  40107f:	48 83 c0 01          	add    $0x1,%rax
  401083:	48 83 f8 06          	cmp    $0x6,%rax
  401087:	75 e7                	jne    401070 <phase2(char*)+0x20>
  401089:	c9                   	leave  
  40108a:	c3                   	ret    
  40108b:	e8 20 09 00 00       	call   4019b0 <explode_bomb()>

0000000000401090 <phase3(char*)>:
  401090:	55                   	push   %rbp
  401091:	31 c0                	xor    %eax,%eax
  401093:	be 27 27 40 00       	mov    $0x402727,%esi
  401098:	48 89 e5             	mov    %rsp,%rbp
  40109b:	48 83 ec 10          	sub    $0x10,%rsp
  40109f:	4c 8d 45 fc          	lea    -0x4(%rbp),%r8
  4010a3:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
  4010a7:	48 8d 55 f4          	lea    -0xc(%rbp),%rdx
  4010ab:	e8 d0 fb ff ff       	call   400c80 <sscanf@plt>
  4010b0:	83 f8 02             	cmp    $0x2,%eax
  4010b3:	7e 19                	jle    4010ce <phase3(char*)+0x3e>
  4010b5:	8b 45 f4             	mov    -0xc(%rbp),%eax
  4010b8:	83 f8 07             	cmp    $0x7,%eax
  4010bb:	77 11                	ja     4010ce <phase3(char*)+0x3e>
  4010bd:	8b 55 f8             	mov    -0x8(%rbp),%edx
  4010c0:	2b 55 fc             	sub    -0x4(%rbp),%edx
  4010c3:	3b 14 85 60 24 40 00 	cmp    0x402460(,%rax,4),%edx
  4010ca:	75 02                	jne    4010ce <phase3(char*)+0x3e>
  4010cc:	c9                   	leave  
  4010cd:	c3                   	ret    
  4010ce:	e8 dd 08 00 00       	call   4019b0 <explode_bomb()>
  4010d3:	0f 1f 00             	nopl   (%rax)
  4010d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4010dd:	00 00 00 

00000000004010e0 <phase4(char*)>:
  4010e0:	55                   	push   %rbp
  4010e1:	be 90 23 40 00       	mov    $0x402390,%esi
  4010e6:	48 89 e5             	mov    %rsp,%rbp
  4010e9:	e8 42 fc ff ff       	call   400d30 <strcmp@plt>
  4010ee:	85 c0                	test   %eax,%eax
  4010f0:	75 02                	jne    4010f4 <phase4(char*)+0x14>
  4010f2:	5d                   	pop    %rbp
  4010f3:	c3                   	ret    
  4010f4:	e8 b7 08 00 00       	call   4019b0 <explode_bomb()>
  4010f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000401100 <phase5_word1(char const*)>:
  401100:	55                   	push   %rbp
  401101:	48 89 e5             	mov    %rsp,%rbp
  401104:	41 54                	push   %r12
  401106:	49 89 fc             	mov    %rdi,%r12
  401109:	bf 5e 23 40 00       	mov    $0x40235e,%edi
  40110e:	53                   	push   %rbx
  40110f:	bb 80 24 40 00       	mov    $0x402480,%ebx
  401114:	eb 17                	jmp    40112d <phase5_word1(char const*)+0x2d>
  401116:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40111d:	00 00 00 
  401120:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
  401124:	48 83 c3 08          	add    $0x8,%rbx
  401128:	48 85 ff             	test   %rdi,%rdi
  40112b:	74 1b                	je     401148 <phase5_word1(char const*)+0x48>
  40112d:	4c 89 e6             	mov    %r12,%rsi
  401130:	e8 fb fb ff ff       	call   400d30 <strcmp@plt>
  401135:	85 c0                	test   %eax,%eax
  401137:	75 e7                	jne    401120 <phase5_word1(char const*)+0x20>
  401139:	5b                   	pop    %rbx
  40113a:	b8 01 00 00 00       	mov    $0x1,%eax
  40113f:	41 5c                	pop    %r12
  401141:	5d                   	pop    %rbp
  401142:	c3                   	ret    
  401143:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401148:	5b                   	pop    %rbx
  401149:	31 c0                	xor    %eax,%eax
  40114b:	41 5c                	pop    %r12
  40114d:	5d                   	pop    %rbp
  40114e:	c3                   	ret    
  40114f:	90                   	nop

0000000000401150 <phase5_word2(char const*, unsigned long)>:
  401150:	b8 01 00 00 00       	mov    $0x1,%eax
  401155:	48 85 f6             	test   %rsi,%rsi
  401158:	74 0e                	je     401168 <phase5_word2(char const*, unsigned long)+0x18>
  40115a:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  40115f:	0f b6 10             	movzbl (%rax),%edx
  401162:	38 17                	cmp    %dl,(%rdi)
  401164:	74 0a                	je     401170 <phase5_word2(char const*, unsigned long)+0x20>
  401166:	31 c0                	xor    %eax,%eax
  401168:	c3                   	ret    
  401169:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401170:	48 83 c7 01          	add    $0x1,%rdi
  401174:	48 83 e8 01          	sub    $0x1,%rax
  401178:	48 83 ee 02          	sub    $0x2,%rsi
  40117c:	75 e1                	jne    40115f <phase5_word2(char const*, unsigned long)+0xf>
  40117e:	b8 01 00 00 00       	mov    $0x1,%eax
  401183:	c3                   	ret    
  401184:	66 90                	xchg   %ax,%ax
  401186:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40118d:	00 00 00 

0000000000401190 <phase5_word1_word2(char const*, char const*)>:
  401190:	55                   	push   %rbp
  401191:	48 89 e5             	mov    %rsp,%rbp
  401194:	41 55                	push   %r13
  401196:	41 54                	push   %r12
  401198:	49 89 f4             	mov    %rsi,%r12
  40119b:	53                   	push   %rbx
  40119c:	48 89 fb             	mov    %rdi,%rbx
  40119f:	48 89 f7             	mov    %rsi,%rdi
  4011a2:	48 83 ec 08          	sub    $0x8,%rsp
  4011a6:	e8 b5 fa ff ff       	call   400c60 <strlen@plt>
  4011ab:	48 89 df             	mov    %rbx,%rdi
  4011ae:	49 89 c5             	mov    %rax,%r13
  4011b1:	e8 aa fa ff ff       	call   400c60 <strlen@plt>
  4011b6:	48 8d 54 00 02       	lea    0x2(%rax,%rax,1),%rdx
  4011bb:	31 c0                	xor    %eax,%eax
  4011bd:	49 39 d5             	cmp    %rdx,%r13
  4011c0:	72 22                	jb     4011e4 <phase5_word1_word2(char const*, char const*)+0x54>
  4011c2:	0f b6 13             	movzbl (%rbx),%edx
  4011c5:	84 d2                	test   %dl,%dl
  4011c7:	74 27                	je     4011f0 <phase5_word1_word2(char const*, char const*)+0x60>
  4011c9:	31 c0                	xor    %eax,%eax
  4011cb:	eb 0f                	jmp    4011dc <phase5_word1_word2(char const*, char const*)+0x4c>
  4011cd:	0f 1f 00             	nopl   (%rax)
  4011d0:	48 83 c0 01          	add    $0x1,%rax
  4011d4:	0f b6 14 03          	movzbl (%rbx,%rax,1),%edx
  4011d8:	84 d2                	test   %dl,%dl
  4011da:	74 14                	je     4011f0 <phase5_word1_word2(char const*, char const*)+0x60>
  4011dc:	41 38 14 04          	cmp    %dl,(%r12,%rax,1)
  4011e0:	74 ee                	je     4011d0 <phase5_word1_word2(char const*, char const*)+0x40>
  4011e2:	31 c0                	xor    %eax,%eax
  4011e4:	48 83 c4 08          	add    $0x8,%rsp
  4011e8:	5b                   	pop    %rbx
  4011e9:	41 5c                	pop    %r12
  4011eb:	41 5d                	pop    %r13
  4011ed:	5d                   	pop    %rbp
  4011ee:	c3                   	ret    
  4011ef:	90                   	nop
  4011f0:	48 83 c4 08          	add    $0x8,%rsp
  4011f4:	b8 01 00 00 00       	mov    $0x1,%eax
  4011f9:	5b                   	pop    %rbx
  4011fa:	41 5c                	pop    %r12
  4011fc:	41 5d                	pop    %r13
  4011fe:	5d                   	pop    %rbp
  4011ff:	c3                   	ret    

0000000000401200 <phase5(char*)>:
  401200:	55                   	push   %rbp
  401201:	31 c0                	xor    %eax,%eax
  401203:	be 41 26 40 00       	mov    $0x402641,%esi
  401208:	48 89 e5             	mov    %rsp,%rbp
  40120b:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  401212:	48 8d 8d 60 ff ff ff 	lea    -0xa0(%rbp),%rcx
  401219:	48 8d 95 c0 fe ff ff 	lea    -0x140(%rbp),%rdx
  401220:	e8 5b fa ff ff       	call   400c80 <sscanf@plt>
  401225:	83 f8 02             	cmp    $0x2,%eax
  401228:	75 48                	jne    401272 <phase5(char*)+0x72>
  40122a:	48 8d bd c0 fe ff ff 	lea    -0x140(%rbp),%rdi
  401231:	e8 ca fe ff ff       	call   401100 <phase5_word1(char const*)>
  401236:	84 c0                	test   %al,%al
  401238:	74 38                	je     401272 <phase5(char*)+0x72>
  40123a:	48 8d bd 60 ff ff ff 	lea    -0xa0(%rbp),%rdi
  401241:	e8 1a fa ff ff       	call   400c60 <strlen@plt>
  401246:	48 8d bd 60 ff ff ff 	lea    -0xa0(%rbp),%rdi
  40124d:	48 89 c6             	mov    %rax,%rsi
  401250:	e8 fb fe ff ff       	call   401150 <phase5_word2(char const*, unsigned long)>
  401255:	84 c0                	test   %al,%al
  401257:	74 19                	je     401272 <phase5(char*)+0x72>
  401259:	48 8d b5 60 ff ff ff 	lea    -0xa0(%rbp),%rsi
  401260:	48 8d bd c0 fe ff ff 	lea    -0x140(%rbp),%rdi
  401267:	e8 24 ff ff ff       	call   401190 <phase5_word1_word2(char const*, char const*)>
  40126c:	84 c0                	test   %al,%al
  40126e:	74 02                	je     401272 <phase5(char*)+0x72>
  401270:	c9                   	leave  
  401271:	c3                   	ret    
  401272:	e8 39 07 00 00       	call   4019b0 <explode_bomb()>
  401277:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40127e:	00 00 

0000000000401280 <calc6_factor(char*, calc6*)>:
  401280:	55                   	push   %rbp
  401281:	48 89 e5             	mov    %rsp,%rbp
  401284:	41 55                	push   %r13
  401286:	41 54                	push   %r12
  401288:	49 89 f4             	mov    %rsi,%r12
  40128b:	be 64 23 40 00       	mov    $0x402364,%esi
  401290:	53                   	push   %rbx
  401291:	48 89 fb             	mov    %rdi,%rbx
  401294:	48 83 ec 08          	sub    $0x8,%rsp
  401298:	e8 b3 f9 ff ff       	call   400c50 <strspn@plt>
  40129d:	ba 0a 00 00 00       	mov    $0xa,%edx
  4012a2:	31 f6                	xor    %esi,%esi
  4012a4:	48 89 df             	mov    %rbx,%rdi
  4012a7:	49 89 c5             	mov    %rax,%r13
  4012aa:	e8 81 f9 ff ff       	call   400c30 <strtoul@plt>
  4012af:	4d 85 ed             	test   %r13,%r13
  4012b2:	0f 94 c2             	sete   %dl
  4012b5:	41 89 04 24          	mov    %eax,(%r12)
  4012b9:	41 08 54 24 08       	or     %dl,0x8(%r12)
  4012be:	83 f8 01             	cmp    $0x1,%eax
  4012c1:	77 06                	ja     4012c9 <calc6_factor(char*, calc6*)+0x49>
  4012c3:	41 83 6c 24 04 01    	subl   $0x1,0x4(%r12)
  4012c9:	48 83 c4 08          	add    $0x8,%rsp
  4012cd:	4a 8d 04 2b          	lea    (%rbx,%r13,1),%rax
  4012d1:	5b                   	pop    %rbx
  4012d2:	41 5c                	pop    %r12
  4012d4:	41 5d                	pop    %r13
  4012d6:	5d                   	pop    %rbp
  4012d7:	c3                   	ret    
  4012d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4012df:	00 

00000000004012e0 <calc6_term(char*, calc6*)>:
  4012e0:	55                   	push   %rbp
  4012e1:	48 89 e5             	mov    %rsp,%rbp
  4012e4:	41 54                	push   %r12
  4012e6:	53                   	push   %rbx
  4012e7:	48 89 f3             	mov    %rsi,%rbx
  4012ea:	e8 91 ff ff ff       	call   401280 <calc6_factor(char*, calc6*)>
  4012ef:	80 38 3c             	cmpb   $0x3c,(%rax)
  4012f2:	74 19                	je     40130d <calc6_term(char*, calc6*)+0x2d>
  4012f4:	eb 48                	jmp    40133e <calc6_term(char*, calc6*)+0x5e>
  4012f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4012fd:	00 00 00 
  401300:	c6 43 08 01          	movb   $0x1,0x8(%rbx)
  401304:	83 43 04 01          	addl   $0x1,0x4(%rbx)
  401308:	80 38 3c             	cmpb   $0x3c,(%rax)
  40130b:	75 31                	jne    40133e <calc6_term(char*, calc6*)+0x5e>
  40130d:	80 78 01 3c          	cmpb   $0x3c,0x1(%rax)
  401311:	75 2b                	jne    40133e <calc6_term(char*, calc6*)+0x5e>
  401313:	48 8d 78 02          	lea    0x2(%rax),%rdi
  401317:	48 89 de             	mov    %rbx,%rsi
  40131a:	44 8b 23             	mov    (%rbx),%r12d
  40131d:	e8 5e ff ff ff       	call   401280 <calc6_factor(char*, calc6*)>
  401322:	80 7b 08 00          	cmpb   $0x0,0x8(%rbx)
  401326:	75 dc                	jne    401304 <calc6_term(char*, calc6*)+0x24>
  401328:	8b 0b                	mov    (%rbx),%ecx
  40132a:	83 f9 1f             	cmp    $0x1f,%ecx
  40132d:	77 d1                	ja     401300 <calc6_term(char*, calc6*)+0x20>
  40132f:	41 d3 e4             	shl    %cl,%r12d
  401332:	83 43 04 01          	addl   $0x1,0x4(%rbx)
  401336:	44 89 23             	mov    %r12d,(%rbx)
  401339:	80 38 3c             	cmpb   $0x3c,(%rax)
  40133c:	74 cf                	je     40130d <calc6_term(char*, calc6*)+0x2d>
  40133e:	5b                   	pop    %rbx
  40133f:	41 5c                	pop    %r12
  401341:	5d                   	pop    %rbp
  401342:	c3                   	ret    
  401343:	0f 1f 00             	nopl   (%rax)
  401346:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40134d:	00 00 00 

0000000000401350 <calc6_expr(char*, calc6*)>:
  401350:	55                   	push   %rbp
  401351:	48 89 e5             	mov    %rsp,%rbp
  401354:	41 54                	push   %r12
  401356:	53                   	push   %rbx
  401357:	48 89 f3             	mov    %rsi,%rbx
  40135a:	e8 81 ff ff ff       	call   4012e0 <calc6_term(char*, calc6*)>
  40135f:	80 38 7c             	cmpb   $0x7c,(%rax)
  401362:	75 27                	jne    40138b <calc6_expr(char*, calc6*)+0x3b>
  401364:	44 8b 23             	mov    (%rbx),%r12d
  401367:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40136e:	00 00 
  401370:	48 8d 78 01          	lea    0x1(%rax),%rdi
  401374:	48 89 de             	mov    %rbx,%rsi
  401377:	e8 64 ff ff ff       	call   4012e0 <calc6_term(char*, calc6*)>
  40137c:	44 0b 23             	or     (%rbx),%r12d
  40137f:	83 43 04 01          	addl   $0x1,0x4(%rbx)
  401383:	44 89 23             	mov    %r12d,(%rbx)
  401386:	80 38 7c             	cmpb   $0x7c,(%rax)
  401389:	74 e5                	je     401370 <calc6_expr(char*, calc6*)+0x20>
  40138b:	5b                   	pop    %rbx
  40138c:	41 5c                	pop    %r12
  40138e:	5d                   	pop    %rbp
  40138f:	c3                   	ret    

0000000000401390 <phase6(char*)>:
  401390:	55                   	push   %rbp
  401391:	48 89 e5             	mov    %rsp,%rbp
  401394:	48 83 ec 10          	sub    $0x10,%rsp
  401398:	48 8d 75 f4          	lea    -0xc(%rbp),%rsi
  40139c:	48 c7 45 f4 00 00 00 	movq   $0x0,-0xc(%rbp)
  4013a3:	00 
  4013a4:	c6 45 fc 00          	movb   $0x0,-0x4(%rbp)
  4013a8:	e8 a3 ff ff ff       	call   401350 <calc6_expr(char*, calc6*)>
  4013ad:	80 7d fc 00          	cmpb   $0x0,-0x4(%rbp)
  4013b1:	75 1d                	jne    4013d0 <phase6(char*)+0x40>
  4013b3:	8b 75 f4             	mov    -0xc(%rbp),%esi
  4013b6:	81 fe 90 a9 e2 71    	cmp    $0x71e2a990,%esi
  4013bc:	75 17                	jne    4013d5 <phase6(char*)+0x45>
  4013be:	8b 75 f8             	mov    -0x8(%rbp),%esi
  4013c1:	83 fe 03             	cmp    $0x3,%esi
  4013c4:	7e 2a                	jle    4013f0 <phase6(char*)+0x60>
  4013c6:	c9                   	leave  
  4013c7:	c3                   	ret    
  4013c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4013cf:	00 
  4013d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
  4013d5:	bf 6f 23 40 00       	mov    $0x40236f,%edi
  4013da:	31 c0                	xor    %eax,%eax
  4013dc:	e8 0f f8 ff ff       	call   400bf0 <printf@plt>
  4013e1:	e8 ca 05 00 00       	call   4019b0 <explode_bomb()>
  4013e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4013ed:	00 00 00 
  4013f0:	bf e8 23 40 00       	mov    $0x4023e8,%edi
  4013f5:	31 c0                	xor    %eax,%eax
  4013f7:	e8 f4 f7 ff ff       	call   400bf0 <printf@plt>
  4013fc:	e8 af 05 00 00       	call   4019b0 <explode_bomb()>
  401401:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401406:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40140d:	00 00 00 

0000000000401410 <phase7(char*)>:
  401410:	55                   	push   %rbp
  401411:	48 89 e5             	mov    %rsp,%rbp
  401414:	48 83 ec 50          	sub    $0x50,%rsp
  401418:	48 8d 75 b0          	lea    -0x50(%rbp),%rsi
  40141c:	e8 cf 05 00 00       	call   4019f0 <read_six_numbers(char const*, int*)>

  # [6, 5, 4, 3, 2, 1]
  # from 0x40008004e0 to 0x40008004f4 

  401421:	b9 01 00 00 00       	mov    $0x1,%ecx
  401426:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)


  # check input nums

  40142d:	00 00 00 
  401430:	8b 54 8d ac          	mov    -0x54(%rbp,%rcx,4),%edx
  # rdx = arr[rcxInd]
  401434:	8d 42 ff             	lea    -0x1(%rdx),%eax
  # rax = rdx - 1
  401437:	83 f8 05             	cmp    $0x5,%eax
  40143a:	0f 87 b0 00 00 00    	ja     4014f0 <phase7(char*)+0xe0>
  # if (arr[rcxInd] - 1) > 5, explode
  401440:	48 83 f9 06          	cmp    $0x6,%rcx
  401444:	74 23                	je     401469 <phase7(char*)+0x59>
  401446:	48 89 c8             	mov    %rcx,%rax
  401449:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401450:	3b 54 85 b0          	cmp    -0x50(%rbp,%rax,4),%edx
  # if (4 == 5), explode
  # if (3 == 5), explode
  # if (2 == 5), explode
  401454:	0f 84 96 00 00 00    	je     4014f0 <phase7(char*)+0xe0>
  40145a:	48 83 c0 01          	add    $0x1,%rax
  40145e:	83 f8 06             	cmp    $0x6,%eax
  401461:	75 ed                	jne    401450 <phase7(char*)+0x40>
  401463:	48 83 c1 01          	add    $0x1,%rcx
  401467:	eb c7                	jmp    401430 <phase7(char*)+0x20>

  /*

  for (int ind1 = 0; ind1 < 6; ind1++) {
    int base = arr[ind1]
    if (base - 1 > 5) {
      explode
    }
    for (int ind2 = ind1; ind2 < 6; ind2++) {
      int other = arr[ind2]
      if (base == other) {
        explode
      }
    } 
  }

  By the end, every number 0 <= num <= 6 and unique in the array

  */

  # [6, 5, 4, 3, 2, 1]

  401469:	31 f6                	xor    %esi,%esi
  40146b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

  401470:	8b 4c b5 b0          	mov    -0x50(%rbp,%rsi,4),%ecx
  # ecx contains 6

  401474:	b8 01 00 00 00       	mov    $0x1,%eax
  401479:	ba 10 43 60 00       	mov    $0x604310,%edx
  40147e:	83 f9 01             	cmp    $0x1,%ecx
  401481:	7e 10                	jle    401493 <phase7(char*)+0x83>
  401483:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  # seems to loop $ecx times, which is 6 here
  401488:	83 c0 01             	add    $0x1,%eax
  40148b:	48 8b 52 08          	mov    0x8(%rdx),%rdx
  40148f:	39 c1                	cmp    %eax,%ecx
  401491:	75 f5                	jne    401488 <phase7(char*)+0x78>

  /*
  *rdx = CONST

  if ecx == 1:
  jump past the loop 

  seems to iterate through a static data structure

  rdx: 808 
  rdx: 871
  rdx: 682
  rdx: 855
  rdx: 762
  rdx: 532

  */

  401493:	48 89 54 f5 d0       	mov    %rdx,-0x30(%rbp,%rsi,8)
  401498:	48 83 c6 01          	add    $0x1,%rsi
  40149c:	48 83 fe 06          	cmp    $0x6,%rsi
  4014a0:	75 ce                	jne    401470 <phase7(char*)+0x60>

  # Move pointer values into registers
  4014aa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  4014a2:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  4014a6:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx


  4014ae:	48 89 50 08          	mov    %rdx,0x8(%rax)
  4014b2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)


  4014b6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  4014ba:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  4014be:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  4014c2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  4014c6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  4014ca:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  4014ce:	8b 08                	mov    (%rax),%ecx
  4014d0:	48 c7 42 08 00 00 00 	movq   $0x0,0x8(%rdx)
  4014d7:	00 
  4014d8:	ba 05 00 00 00       	mov    $0x5,%edx
  4014dd:	48 8b 40 08          	mov    0x8(%rax),%rax
  4014e1:	89 ce                	mov    %ecx,%esi
  4014e3:	8b 08                	mov    (%rax),%ecx
  4014e5:	39 f1                	cmp    %esi,%ecx
  4014e7:	7c 07                	jl     4014f0 <phase7(char*)+0xe0>
  4014e9:	83 ea 01             	sub    $0x1,%edx
  4014ec:	75 ef                	jne    4014dd <phase7(char*)+0xcd>
  4014ee:	c9                   	leave  
  4014ef:	c3                   	ret    
  4014f0:	e8 bb 04 00 00       	call   4019b0 <explode_bomb()>
  4014f5:	90                   	nop
  4014f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4014fd:	00 00 00 

0000000000401500 <f8(treeNodeStruct*, int)>:
  401500:	48 85 ff             	test   %rdi,%rdi
  401503:	74 30                	je     401535 <f8(treeNodeStruct*, int)+0x35>
  401505:	55                   	push   %rbp
  401506:	48 89 e5             	mov    %rsp,%rbp
  401509:	39 37                	cmp    %esi,(%rdi)
  40150b:	7f 1b                	jg     401528 <f8(treeNodeStruct*, int)+0x28>
  40150d:	b8 00 00 00 00       	mov    $0x0,%eax
  401512:	74 0d                	je     401521 <f8(treeNodeStruct*, int)+0x21>
  401514:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
  401518:	e8 e3 ff ff ff       	call   401500 <f8(treeNodeStruct*, int)>
  40151d:	8d 44 00 01          	lea    0x1(%rax,%rax,1),%eax
  401521:	5d                   	pop    %rbp
  401522:	c3                   	ret    
  401523:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401528:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
  40152c:	e8 cf ff ff ff       	call   401500 <f8(treeNodeStruct*, int)>
  401531:	5d                   	pop    %rbp
  401532:	01 c0                	add    %eax,%eax
  401534:	c3                   	ret    
  401535:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  40153a:	c3                   	ret    
  40153b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000401540 <secret_phase()>:
  401540:	55                   	push   %rbp
  401541:	48 89 e5             	mov    %rsp,%rbp
  401544:	e8 77 02 00 00       	call   4017c0 <read_line()>
  401549:	31 d2                	xor    %edx,%edx
  40154b:	31 f6                	xor    %esi,%esi
  40154d:	48 89 c7             	mov    %rax,%rdi
  401550:	e8 eb f7 ff ff       	call   400d40 <strtol@plt>
  401555:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  401559:	48 81 fa e8 03 00 00 	cmp    $0x3e8,%rdx
  401560:	77 46                	ja     4015a8 <secret_phase()+0x68>
  401562:	3b 05 c8 2b 20 00    	cmp    0x202bc8(%rip),%eax        # 604130 <n1>
  401568:	89 c6                	mov    %eax,%esi
  40156a:	7c 2c                	jl     401598 <secret_phase()+0x58>
  40156c:	74 14                	je     401582 <secret_phase()+0x42>
  40156e:	48 8b 3d cb 2b 20 00 	mov    0x202bcb(%rip),%rdi        # 604140 <n1+0x10>
  401575:	e8 86 ff ff ff       	call   401500 <f8(treeNodeStruct*, int)>
  40157a:	8d 44 00 01          	lea    0x1(%rax,%rax,1),%eax
  40157e:	85 c0                	test   %eax,%eax
  401580:	75 26                	jne    4015a8 <secret_phase()+0x68>
  401582:	bf 20 24 40 00       	mov    $0x402420,%edi
  401587:	e8 e4 f7 ff ff       	call   400d70 <puts@plt>
  40158c:	5d                   	pop    %rbp
  40158d:	e9 9e 04 00 00       	jmp    401a30 <phase_defused()>
  401592:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401598:	48 8b 3d 99 2b 20 00 	mov    0x202b99(%rip),%rdi        # 604138 <n1+0x8>
  40159f:	e8 5c ff ff ff       	call   401500 <f8(treeNodeStruct*, int)>
  4015a4:	01 c0                	add    %eax,%eax
  4015a6:	eb d6                	jmp    40157e <secret_phase()+0x3e>
  4015a8:	e8 03 04 00 00       	call   4019b0 <explode_bomb()>
  4015ad:	0f 1f 00             	nopl   (%rax)

00000000004015b0 <sig_handler(int)>:
  4015b0:	55                   	push   %rbp
  4015b1:	ba 39 00 00 00       	mov    $0x39,%edx
  4015b6:	be a8 24 40 00       	mov    $0x4024a8,%esi
  4015bb:	bf 01 00 00 00       	mov    $0x1,%edi
  4015c0:	48 89 e5             	mov    %rsp,%rbp
  4015c3:	e8 78 f6 ff ff       	call   400c40 <write@plt>
  4015c8:	bf 03 00 00 00       	mov    $0x3,%edi
  4015cd:	e8 be f6 ff ff       	call   400c90 <sleep@plt>
  4015d2:	ba 07 00 00 00       	mov    $0x7,%edx
  4015d7:	be 2b 26 40 00       	mov    $0x40262b,%esi
  4015dc:	bf 01 00 00 00       	mov    $0x1,%edi
  4015e1:	e8 5a f6 ff ff       	call   400c40 <write@plt>
  4015e6:	bf 01 00 00 00       	mov    $0x1,%edi
  4015eb:	e8 a0 f6 ff ff       	call   400c90 <sleep@plt>
  4015f0:	bf 01 00 00 00       	mov    $0x1,%edi
  4015f5:	ba 08 00 00 00       	mov    $0x8,%edx
  4015fa:	be 33 26 40 00       	mov    $0x402633,%esi
  4015ff:	e8 3c f6 ff ff       	call   400c40 <write@plt>
  401604:	bf 10 00 00 00       	mov    $0x10,%edi
  401609:	e8 92 f7 ff ff       	call   400da0 <_exit@plt>
  40160e:	66 90                	xchg   %ax,%ax

0000000000401610 <e() [clone .part.0]>:
  401610:	55                   	push   %rbp
  401611:	31 c0                	xor    %eax,%eax
  401613:	be 3c 26 40 00       	mov    $0x40263c,%esi
  401618:	bf 40 45 60 00       	mov    $0x604540,%edi
  40161d:	48 89 e5             	mov    %rsp,%rbp
  401620:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  401627:	4c 8d 85 c0 fe ff ff 	lea    -0x140(%rbp),%r8
  40162e:	4c 8d 8d 60 ff ff ff 	lea    -0xa0(%rbp),%r9
  401635:	4c 89 c1             	mov    %r8,%rcx
  401638:	4c 89 c2             	mov    %r8,%rdx
  40163b:	e8 40 f6 ff ff       	call   400c80 <sscanf@plt>
  401640:	83 f8 04             	cmp    $0x4,%eax
  401643:	74 1b                	je     401660 <e() [clone .part.0]+0x50>
  401645:	bf 48 25 40 00       	mov    $0x402548,%edi
  40164a:	e8 21 f7 ff ff       	call   400d70 <puts@plt>
  40164f:	bf 70 25 40 00       	mov    $0x402570,%edi
  401654:	e8 17 f7 ff ff       	call   400d70 <puts@plt>
  401659:	c9                   	leave  
  40165a:	c3                   	ret    
  40165b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401660:	be 48 26 40 00       	mov    $0x402648,%esi
  401665:	48 8d bd 60 ff ff ff 	lea    -0xa0(%rbp),%rdi
  40166c:	e8 bf f6 ff ff       	call   400d30 <strcmp@plt>
  401671:	85 c0                	test   %eax,%eax
  401673:	75 d0                	jne    401645 <e() [clone .part.0]+0x35>
  401675:	bf e8 24 40 00       	mov    $0x4024e8,%edi
  40167a:	e8 f1 f6 ff ff       	call   400d70 <puts@plt>
  40167f:	bf 10 25 40 00       	mov    $0x402510,%edi
  401684:	e8 e7 f6 ff ff       	call   400d70 <puts@plt>
  401689:	e8 b2 fe ff ff       	call   401540 <secret_phase()>
  40168e:	eb b5                	jmp    401645 <e() [clone .part.0]+0x35>

0000000000401690 <e()>:
  401690:	83 3d 49 2d 20 00 07 	cmpl   $0x7,0x202d49(%rip)        # 6043e0 <ndefused>
  401697:	74 07                	je     4016a0 <e()+0x10>
  401699:	c3                   	ret    
  40169a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  4016a0:	e9 6b ff ff ff       	jmp    401610 <e() [clone .part.0]>
  4016a5:	90                   	nop
  4016a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4016ad:	00 00 00 

00000000004016b0 <invalid_phase(char*)>:
  4016b0:	55                   	push   %rbp
  4016b1:	48 89 fe             	mov    %rdi,%rsi
  4016b4:	31 c0                	xor    %eax,%eax
  4016b6:	bf 54 26 40 00       	mov    $0x402654,%edi
  4016bb:	48 89 e5             	mov    %rsp,%rbp
  4016be:	e8 2d f5 ff ff       	call   400bf0 <printf@plt>
  4016c3:	bf 08 00 00 00       	mov    $0x8,%edi
  4016c8:	e8 33 f6 ff ff       	call   400d00 <exit@plt>
  4016cd:	0f 1f 00             	nopl   (%rax)

00000000004016d0 <initialize_bomb()>:
  4016d0:	55                   	push   %rbp
  4016d1:	48 89 e5             	mov    %rsp,%rbp
  4016d4:	48 81 ec a0 20 00 00 	sub    $0x20a0,%rsp
  4016db:	48 8d bd 68 df ff ff 	lea    -0x2098(%rbp),%rdi
  4016e2:	48 c7 85 60 df ff ff 	movq   $0x4015b0,-0x20a0(%rbp)
  4016e9:	b0 15 40 00 
  4016ed:	e8 1e f6 ff ff       	call   400d10 <sigemptyset@plt>
  4016f2:	31 d2                	xor    %edx,%edx
  4016f4:	bf 02 00 00 00       	mov    $0x2,%edi
  4016f9:	48 8d b5 60 df ff ff 	lea    -0x20a0(%rbp),%rsi
  401700:	c7 85 e8 df ff ff 00 	movl   $0x0,-0x2018(%rbp)
  401707:	00 00 00 
  40170a:	e8 11 f6 ff ff       	call   400d20 <sigaction@plt>
  40170f:	48 8b 3d 8a 2c 20 00 	mov    0x202c8a(%rip),%rdi        # 6043a0 <stdout@GLIBC_2.2.5>
  401716:	31 c9                	xor    %ecx,%ecx
  401718:	31 f6                	xor    %esi,%esi
  40171a:	ba 02 00 00 00       	mov    $0x2,%edx
  40171f:	e8 ac f4 ff ff       	call   400bd0 <setvbuf@plt>
  401724:	48 8b 3d 95 2c 20 00 	mov    0x202c95(%rip),%rdi        # 6043c0 <stderr@GLIBC_2.2.5>
  40172b:	31 c9                	xor    %ecx,%ecx
  40172d:	31 f6                	xor    %esi,%esi
  40172f:	ba 02 00 00 00       	mov    $0x2,%edx
  401734:	e8 97 f4 ff ff       	call   400bd0 <setvbuf@plt>
  401739:	48 8d bd 00 e0 ff ff 	lea    -0x2000(%rbp),%rdi
  401740:	e8 db 08 00 00       	call   402020 <init_driver(char*)>
  401745:	85 c0                	test   %eax,%eax
  401747:	78 0c                	js     401755 <initialize_bomb()+0x85>
  401749:	bf 90 16 40 00       	mov    $0x401690,%edi
  40174e:	e8 1d 0b 00 00       	call   402270 <atexit>
  401753:	c9                   	leave  
  401754:	c3                   	ret    
  401755:	bf 65 26 40 00       	mov    $0x402665,%edi
  40175a:	48 8d b5 00 e0 ff ff 	lea    -0x2000(%rbp),%rsi
  401761:	31 c0                	xor    %eax,%eax
  401763:	e8 88 f4 ff ff       	call   400bf0 <printf@plt>
  401768:	bf 08 00 00 00       	mov    $0x8,%edi
  40176d:	e8 8e f5 ff ff       	call   400d00 <exit@plt>
  401772:	0f 1f 40 00          	nopl   0x0(%rax)
  401776:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40177d:	00 00 00 

0000000000401780 <initialize_bomb_solve()>:
  401780:	c3                   	ret    
  401781:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401786:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40178d:	00 00 00 

00000000004019b0 <explode_bomb()>:
  4019b0:	55                   	push   %rbp
  4019b1:	bf fe 26 40 00       	mov    $0x4026fe,%edi
  4019b6:	48 89 e5             	mov    %rsp,%rbp
  4019b9:	e8 b2 f3 ff ff       	call   400d70 <puts@plt>
  4019be:	bf 07 27 40 00       	mov    $0x402707,%edi
  4019c3:	e8 a8 f3 ff ff       	call   400d70 <puts@plt>
  4019c8:	31 ff                	xor    %edi,%edi
  4019ca:	e8 21 ff ff ff       	call   4018f0 <send_msg(int)>
  4019cf:	bf 08 26 40 00       	mov    $0x402608,%edi
  4019d4:	e8 97 f3 ff ff       	call   400d70 <puts@plt>
  4019d9:	bf 08 00 00 00       	mov    $0x8,%edi
  4019de:	e8 bd f3 ff ff       	call   400da0 <_exit@plt>
  4019e3:	0f 1f 00             	nopl   (%rax)
  4019e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4019ed:	00 00 00 

00000000004019f0 <read_six_numbers(char const*, int*)>:
  # Set up the stack
  4019f0:	55                   	push   %rbp

  4019f1:	48 8d 46 14          	lea    0x14(%rsi),%rax
  4019f5:	48 89 f2             	mov    %rsi,%rdx
  4019fc:	4c 8d 4e 0c          	lea    0xc(%rsi),%r9
  4019f8:	48 8d 4e 04          	lea    0x4(%rsi),%rcx
  401a00:	4c 8d 46 08          	lea    0x8(%rsi),%r8

  401a04:	48 89 e5             	mov    %rsp,%rbp
  401a07:	50                   	push   %rax
  401a08:	48 8d 46 10          	lea    0x10(%rsi),%rax
  401a0c:	be 1e 27 40 00       	mov    $0x40271e,%esi
  401a11:	50                   	push   %rax
  401a12:	31 c0                	xor    %eax,%eax
  401a14:	e8 67 f2 ff ff       	call   400c80 <sscanf@plt>
  401a19:	5a                   	pop    %rdx
  401a1a:	59                   	pop    %rcx
  401a1b:	83 f8 05             	cmp    $0x5,%eax
  401a1e:	7e 02                	jle    401a22 <read_six_numbers(char const*, int*)+0x32>
  401a20:	c9                   	leave  
  401a21:	c3                   	ret    
  401a22:	e8 89 ff ff ff       	call   4019b0 <explode_bomb()>
  401a27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  401a2e:	00 00 
  /**
  On exit after input 
5 4 3 2 1 -1

rbp and rsp are at 0x40008004d0 
+0x10
the value of 5 is at 0x40008004e0
+0x4
the value of 4 is at 0x40008004e4
+0x4
the value of 3 is at 0x40008004e8 
+0x4
the value of 2 is at 0x40008004ec
+0x4
$rdx holds the address to 1 at 0x40008004f0
+0x4
$rcx holds the address to -1 at 0x40008004f4

[5, 4, 3, 2, 1, -1]
from 0x40008004e0 to 0x40008004f4 
  */

0000000000401a30 <phase_defused()>:
  401a30:	55                   	push   %rbp
  401a31:	bf 01 00 00 00       	mov    $0x1,%edi
  401a36:	48 89 e5             	mov    %rsp,%rbp
  401a39:	e8 b2 fe ff ff       	call   4018f0 <send_msg(int)>
  401a3e:	83 05 9b 29 20 00 01 	addl   $0x1,0x20299b(%rip)        # 6043e0 <ndefused>
  401a45:	5d                   	pop    %rbp
  401a46:	c3                   	ret    
  401a47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  401a4e:	00 00 

