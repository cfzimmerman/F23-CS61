
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

0000000000400f30 <_GLOBAL__sub_I_infile>:
  400f30:	48 8b 05 79 34 20 00 	mov    0x203479(%rip),%rax        # 6043b0 <stdin@GLIBC_2.2.5>
  400f37:	48 89 05 92 34 20 00 	mov    %rax,0x203492(%rip)        # 6043d0 <infile>
  400f3e:	c3                   	ret    
  400f3f:	90                   	nop

0000000000400f40 <_start>:
  400f40:	31 ed                	xor    %ebp,%ebp
  400f42:	49 89 d1             	mov    %rdx,%r9
  400f45:	5e                   	pop    %rsi
  400f46:	48 89 e2             	mov    %rsp,%rdx
  400f49:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  400f4d:	50                   	push   %rax
  400f4e:	54                   	push   %rsp
  400f4f:	49 c7 c0 60 22 40 00 	mov    $0x402260,%r8
  400f56:	48 c7 c1 00 22 40 00 	mov    $0x402200,%rcx
  400f5d:	48 c7 c7 d0 0d 40 00 	mov    $0x400dd0,%rdi
  400f64:	ff 15 86 30 20 00    	call   *0x203086(%rip)        # 603ff0 <__libc_start_main@GLIBC_2.2.5>
  400f6a:	f4                   	hlt    
  400f6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000400f70 <deregister_tm_clones>:
  400f70:	b8 98 43 60 00       	mov    $0x604398,%eax
  400f75:	48 3d 98 43 60 00    	cmp    $0x604398,%rax
  400f7b:	74 13                	je     400f90 <deregister_tm_clones+0x20>
  400f7d:	b8 00 00 00 00       	mov    $0x0,%eax
  400f82:	48 85 c0             	test   %rax,%rax
  400f85:	74 09                	je     400f90 <deregister_tm_clones+0x20>
  400f87:	bf 98 43 60 00       	mov    $0x604398,%edi
  400f8c:	ff e0                	jmp    *%rax
  400f8e:	66 90                	xchg   %ax,%ax
  400f90:	c3                   	ret    
  400f91:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400f96:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  400f9d:	00 00 00 

0000000000400fa0 <register_tm_clones>:
  400fa0:	be 98 43 60 00       	mov    $0x604398,%esi
  400fa5:	48 81 ee 98 43 60 00 	sub    $0x604398,%rsi
  400fac:	48 89 f0             	mov    %rsi,%rax
  400faf:	48 c1 ee 3f          	shr    $0x3f,%rsi
  400fb3:	48 c1 f8 03          	sar    $0x3,%rax
  400fb7:	48 01 c6             	add    %rax,%rsi
  400fba:	48 d1 fe             	sar    %rsi
  400fbd:	74 11                	je     400fd0 <register_tm_clones+0x30>
  400fbf:	b8 00 00 00 00       	mov    $0x0,%eax
  400fc4:	48 85 c0             	test   %rax,%rax
  400fc7:	74 07                	je     400fd0 <register_tm_clones+0x30>
  400fc9:	bf 98 43 60 00       	mov    $0x604398,%edi
  400fce:	ff e0                	jmp    *%rax
  400fd0:	c3                   	ret    
  400fd1:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400fd6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  400fdd:	00 00 00 

0000000000400fe0 <__do_global_dtors_aux>:
  400fe0:	f3 0f 1e fa          	endbr64 
  400fe4:	80 3d dd 33 20 00 00 	cmpb   $0x0,0x2033dd(%rip)        # 6043c8 <completed.0>
  400feb:	75 13                	jne    401000 <__do_global_dtors_aux+0x20>
  400fed:	55                   	push   %rbp
  400fee:	48 89 e5             	mov    %rsp,%rbp
  400ff1:	e8 7a ff ff ff       	call   400f70 <deregister_tm_clones>
  400ff6:	c6 05 cb 33 20 00 01 	movb   $0x1,0x2033cb(%rip)        # 6043c8 <completed.0>
  400ffd:	5d                   	pop    %rbp
  400ffe:	c3                   	ret    
  400fff:	90                   	nop
  401000:	c3                   	ret    
  401001:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401006:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40100d:	00 00 00 

0000000000401010 <frame_dummy>:
  401010:	f3 0f 1e fa          	endbr64 
  401014:	eb 8a                	jmp    400fa0 <register_tm_clones>
  401016:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40101d:	00 00 00 

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
  401421:	b9 01 00 00 00       	mov    $0x1,%ecx
  401426:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40142d:	00 00 00 
  401430:	8b 54 8d ac          	mov    -0x54(%rbp,%rcx,4),%edx
  401434:	8d 42 ff             	lea    -0x1(%rdx),%eax
  401437:	83 f8 05             	cmp    $0x5,%eax
  40143a:	0f 87 b0 00 00 00    	ja     4014f0 <phase7(char*)+0xe0>
  401440:	48 83 f9 06          	cmp    $0x6,%rcx
  401444:	74 23                	je     401469 <phase7(char*)+0x59>
  401446:	48 89 c8             	mov    %rcx,%rax
  401449:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401450:	3b 54 85 b0          	cmp    -0x50(%rbp,%rax,4),%edx
  401454:	0f 84 96 00 00 00    	je     4014f0 <phase7(char*)+0xe0>
  40145a:	48 83 c0 01          	add    $0x1,%rax
  40145e:	83 f8 06             	cmp    $0x6,%eax
  401461:	75 ed                	jne    401450 <phase7(char*)+0x40>
  401463:	48 83 c1 01          	add    $0x1,%rcx
  401467:	eb c7                	jmp    401430 <phase7(char*)+0x20>
  401469:	31 f6                	xor    %esi,%esi
  40146b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401470:	8b 4c b5 b0          	mov    -0x50(%rbp,%rsi,4),%ecx
  401474:	b8 01 00 00 00       	mov    $0x1,%eax
  401479:	ba 10 43 60 00       	mov    $0x604310,%edx
  40147e:	83 f9 01             	cmp    $0x1,%ecx
  401481:	7e 10                	jle    401493 <phase7(char*)+0x83>
  401483:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401488:	83 c0 01             	add    $0x1,%eax
  40148b:	48 8b 52 08          	mov    0x8(%rdx),%rdx
  40148f:	39 c1                	cmp    %eax,%ecx
  401491:	75 f5                	jne    401488 <phase7(char*)+0x78>
  401493:	48 89 54 f5 d0       	mov    %rdx,-0x30(%rbp,%rsi,8)
  401498:	48 83 c6 01          	add    $0x1,%rsi
  40149c:	48 83 fe 06          	cmp    $0x6,%rsi
  4014a0:	75 ce                	jne    401470 <phase7(char*)+0x60>
  4014a2:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  4014a6:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  4014aa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
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

0000000000401790 <blank_line(char*)>:
  401790:	55                   	push   %rbp
  401791:	48 89 e5             	mov    %rsp,%rbp
  401794:	53                   	push   %rbx
  401795:	48 89 fb             	mov    %rdi,%rbx
  401798:	48 83 ec 08          	sub    $0x8,%rsp
  40179c:	eb 0f                	jmp    4017ad <blank_line(char*)+0x1d>
  40179e:	66 90                	xchg   %ax,%ax
  4017a0:	48 83 c3 01          	add    $0x1,%rbx
  4017a4:	e8 57 f4 ff ff       	call   400c00 <isspace@plt>
  4017a9:	85 c0                	test   %eax,%eax
  4017ab:	74 0d                	je     4017ba <blank_line(char*)+0x2a>
  4017ad:	0f be 3b             	movsbl (%rbx),%edi
  4017b0:	40 84 ff             	test   %dil,%dil
  4017b3:	75 eb                	jne    4017a0 <blank_line(char*)+0x10>
  4017b5:	b8 01 00 00 00       	mov    $0x1,%eax
  4017ba:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  4017be:	c9                   	leave  
  4017bf:	c3                   	ret    

00000000004017c0 <read_line()>:
  4017c0:	55                   	push   %rbp
  4017c1:	48 63 05 18 2c 20 00 	movslq 0x202c18(%rip),%rax        # 6043e0 <ndefused>
  4017c8:	48 89 e5             	mov    %rsp,%rbp
  4017cb:	41 54                	push   %r12
  4017cd:	53                   	push   %rbx
  4017ce:	83 f8 13             	cmp    $0x13,%eax
  4017d1:	0f 87 e5 00 00 00    	ja     4018bc <read_line()+0xfc>
  4017d7:	4c 8d 24 80          	lea    (%rax,%rax,4),%r12
  4017db:	49 c1 e4 05          	shl    $0x5,%r12
  4017df:	49 81 c4 00 44 60 00 	add    $0x604400,%r12
  4017e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4017ed:	00 00 00 
  4017f0:	48 8b 15 d9 2b 20 00 	mov    0x202bd9(%rip),%rdx        # 6043d0 <infile>
  4017f7:	be a0 00 00 00       	mov    $0xa0,%esi
  4017fc:	4c 89 e7             	mov    %r12,%rdi
  4017ff:	4c 89 e3             	mov    %r12,%rbx
  401802:	e8 79 f5 ff ff       	call   400d80 <fgets@plt>
  401807:	48 85 c0             	test   %rax,%rax
  40180a:	0f 84 90 00 00 00    	je     4018a0 <read_line()+0xe0>
  401810:	0f be 3b             	movsbl (%rbx),%edi
  401813:	40 84 ff             	test   %dil,%dil
  401816:	74 d8                	je     4017f0 <read_line()+0x30>
  401818:	48 83 c3 01          	add    $0x1,%rbx
  40181c:	e8 df f3 ff ff       	call   400c00 <isspace@plt>
  401821:	85 c0                	test   %eax,%eax
  401823:	75 eb                	jne    401810 <read_line()+0x50>
  401825:	4c 89 e7             	mov    %r12,%rdi
  401828:	e8 33 f4 ff ff       	call   400c60 <strlen@plt>
  40182d:	48 3d 9e 00 00 00    	cmp    $0x9e,%rax
  401833:	76 4b                	jbe    401880 <read_line()+0xc0>
  401835:	41 80 bc 24 9f 00 00 	cmpb   $0xa,0x9f(%r12)
  40183c:	00 0a 
  40183e:	74 28                	je     401868 <read_line()+0xa8>
  401840:	bf b1 26 40 00       	mov    $0x4026b1,%edi
  401845:	e8 26 f5 ff ff       	call   400d70 <puts@plt>
  40184a:	4c 89 e7             	mov    %r12,%rdi
  40184d:	be cc 26 40 00       	mov    $0x4026cc,%esi
  401852:	e8 69 f4 ff ff       	call   400cc0 <strcpy@plt>
  401857:	4c 89 e7             	mov    %r12,%rdi
  40185a:	e8 01 f4 ff ff       	call   400c60 <strlen@plt>
  40185f:	48 85 c0             	test   %rax,%rax
  401862:	74 21                	je     401885 <read_line()+0xc5>
  401864:	0f 1f 40 00          	nopl   0x0(%rax)
  401868:	48 83 e8 01          	sub    $0x1,%rax
  40186c:	41 0f b6 14 04       	movzbl (%r12,%rax,1),%edx
  401871:	80 fa 0d             	cmp    $0xd,%dl
  401874:	74 05                	je     40187b <read_line()+0xbb>
  401876:	80 fa 0a             	cmp    $0xa,%dl
  401879:	75 0a                	jne    401885 <read_line()+0xc5>
  40187b:	41 c6 04 04 00       	movb   $0x0,(%r12,%rax,1)
  401880:	48 85 c0             	test   %rax,%rax
  401883:	75 e3                	jne    401868 <read_line()+0xa8>
  401885:	4c 89 e6             	mov    %r12,%rsi
  401888:	bf a0 50 60 00       	mov    $0x6050a0,%edi
  40188d:	e8 2e f4 ff ff       	call   400cc0 <strcpy@plt>
  401892:	4c 89 e0             	mov    %r12,%rax
  401895:	5b                   	pop    %rbx
  401896:	41 5c                	pop    %r12
  401898:	5d                   	pop    %rbp
  401899:	c3                   	ret    
  40189a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  4018a0:	48 8b 05 09 2b 20 00 	mov    0x202b09(%rip),%rax        # 6043b0 <stdin@GLIBC_2.2.5>
  4018a7:	48 39 05 22 2b 20 00 	cmp    %rax,0x202b22(%rip)        # 6043d0 <infile>
  4018ae:	74 25                	je     4018d5 <read_line()+0x115>
  4018b0:	48 89 05 19 2b 20 00 	mov    %rax,0x202b19(%rip)        # 6043d0 <infile>
  4018b7:	e9 34 ff ff ff       	jmp    4017f0 <read_line()+0x30>
  4018bc:	b9 7f 26 40 00       	mov    $0x40267f,%ecx
  4018c1:	ba c4 00 00 00       	mov    $0xc4,%edx
  4018c6:	be 91 26 40 00       	mov    $0x402691,%esi
  4018cb:	bf b8 25 40 00       	mov    $0x4025b8,%edi
  4018d0:	e8 9b f3 ff ff       	call   400c70 <__assert_fail@plt>
  4018d5:	bf 9c 26 40 00       	mov    $0x40269c,%edi
  4018da:	e8 91 f4 ff ff       	call   400d70 <puts@plt>
  4018df:	bf 08 00 00 00       	mov    $0x8,%edi
  4018e4:	e8 b7 f4 ff ff       	call   400da0 <_exit@plt>
  4018e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000004018f0 <send_msg(int)>:
  4018f0:	55                   	push   %rbp
  4018f1:	48 89 e5             	mov    %rsp,%rbp
  4018f4:	53                   	push   %rbx
  4018f5:	89 fb                	mov    %edi,%ebx
  4018f7:	bf a0 50 60 00       	mov    $0x6050a0,%edi
  4018fc:	48 81 ec 08 40 00 00 	sub    $0x4008,%rsp
  401903:	e8 58 f3 ff ff       	call   400c60 <strlen@plt>
  401908:	48 83 c0 64          	add    $0x64,%rax
  40190c:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
  401912:	77 7f                	ja     401993 <send_msg(int)+0xa3>
  401914:	85 db                	test   %ebx,%ebx
  401916:	b8 e9 26 40 00       	mov    $0x4026e9,%eax
  40191b:	b9 e1 26 40 00       	mov    $0x4026e1,%ecx
  401920:	8b 15 6e 2a 20 00    	mov    0x202a6e(%rip),%edx        # 604394 <bomb_id>
  401926:	48 0f 44 c8          	cmove  %rax,%rcx
  40192a:	8b 05 b0 2a 20 00    	mov    0x202ab0(%rip),%eax        # 6043e0 <ndefused>
  401930:	be f2 26 40 00       	mov    $0x4026f2,%esi
  401935:	48 8d bd f0 bf ff ff 	lea    -0x4010(%rbp),%rdi
  40193c:	41 b9 a0 50 60 00    	mov    $0x6050a0,%r9d
  401942:	44 8d 40 01          	lea    0x1(%rax),%r8d
  401946:	31 c0                	xor    %eax,%eax
  401948:	e8 c3 f2 ff ff       	call   400c10 <sprintf@plt>
  40194d:	31 c9                	xor    %ecx,%ecx
  40194f:	be 70 43 60 00       	mov    $0x604370,%esi
  401954:	4c 8d 85 f0 df ff ff 	lea    -0x2010(%rbp),%r8
  40195b:	48 8d 95 f0 bf ff ff 	lea    -0x4010(%rbp),%rdx
  401962:	bf 88 43 60 00       	mov    $0x604388,%edi
  401967:	e8 d4 07 00 00       	call   402140 <driver_post(char*, char*, char*, int, char*)>
  40196c:	85 c0                	test   %eax,%eax
  40196e:	78 10                	js     401980 <send_msg(int)+0x90>
  401970:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  401974:	c9                   	leave  
  401975:	c3                   	ret    
  401976:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40197d:	00 00 00 
  401980:	48 8d bd f0 df ff ff 	lea    -0x2010(%rbp),%rdi
  401987:	e8 e4 f3 ff ff       	call   400d70 <puts@plt>
  40198c:	31 ff                	xor    %edi,%edi
  40198e:	e8 0d f4 ff ff       	call   400da0 <_exit@plt>
  401993:	bf e0 25 40 00       	mov    $0x4025e0,%edi
  401998:	e8 d3 f3 ff ff       	call   400d70 <puts@plt>
  40199d:	bf 08 00 00 00       	mov    $0x8,%edi
  4019a2:	e8 f9 f3 ff ff       	call   400da0 <_exit@plt>
  4019a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4019ae:	00 00 

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
  4019f0:	55                   	push   %rbp
  4019f1:	48 8d 46 14          	lea    0x14(%rsi),%rax
  4019f5:	48 89 f2             	mov    %rsi,%rdx
  4019f8:	48 8d 4e 04          	lea    0x4(%rsi),%rcx
  4019fc:	4c 8d 4e 0c          	lea    0xc(%rsi),%r9
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

0000000000401a50 <sigalrm_handler(int)>:
  401a50:	55                   	push   %rbp
  401a51:	48 8b 3d 68 29 20 00 	mov    0x202968(%rip),%rdi        # 6043c0 <stderr@GLIBC_2.2.5>
  401a58:	31 d2                	xor    %edx,%edx
  401a5a:	be 30 27 40 00       	mov    $0x402730,%esi
  401a5f:	31 c0                	xor    %eax,%eax
  401a61:	48 89 e5             	mov    %rsp,%rbp
  401a64:	e8 e7 f2 ff ff       	call   400d50 <fprintf@plt>
  401a69:	bf 01 00 00 00       	mov    $0x1,%edi
  401a6e:	e8 2d f3 ff ff       	call   400da0 <_exit@plt>
  401a73:	0f 1f 00             	nopl   (%rax)
  401a76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  401a7d:	00 00 00 

0000000000401a80 <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]>:
  401a80:	55                   	push   %rbp
  401a81:	48 89 e5             	mov    %rsp,%rbp
  401a84:	41 57                	push   %r15
  401a86:	41 bf 01 00 00 00    	mov    $0x1,%r15d
  401a8c:	41 56                	push   %r14
  401a8e:	49 89 f6             	mov    %rsi,%r14
  401a91:	41 55                	push   %r13
  401a93:	41 54                	push   %r12
  401a95:	4c 8d 67 10          	lea    0x10(%rdi),%r12
  401a99:	53                   	push   %rbx
  401a9a:	48 89 fb             	mov    %rdi,%rbx
  401a9d:	48 83 ec 08          	sub    $0x8,%rsp
  401aa1:	eb 3d                	jmp    401ae0 <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]+0x60>
  401aa3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401aa8:	85 c0                	test   %eax,%eax
  401aaa:	0f 84 80 00 00 00    	je     401b30 <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]+0xb0>
  401ab0:	4c 89 63 08          	mov    %r12,0x8(%rbx)
  401ab4:	41 0f b6 45 00       	movzbl 0x0(%r13),%eax
  401ab9:	83 ea 01             	sub    $0x1,%edx
  401abc:	49 83 c5 01          	add    $0x1,%r13
  401ac0:	49 83 c6 01          	add    $0x1,%r14
  401ac4:	4c 89 6b 08          	mov    %r13,0x8(%rbx)
  401ac8:	89 53 04             	mov    %edx,0x4(%rbx)
  401acb:	41 88 46 ff          	mov    %al,-0x1(%r14)
  401acf:	3c 0a                	cmp    $0xa,%al
  401ad1:	74 65                	je     401b38 <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]+0xb8>
  401ad3:	49 83 c7 01          	add    $0x1,%r15
  401ad7:	49 81 ff 00 20 00 00 	cmp    $0x2000,%r15
  401ade:	74 6e                	je     401b4e <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]+0xce>
  401ae0:	8b 53 04             	mov    0x4(%rbx),%edx
  401ae3:	4d 89 e5             	mov    %r12,%r13
  401ae6:	85 d2                	test   %edx,%edx
  401ae8:	7f 6b                	jg     401b55 <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]+0xd5>
  401aea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401af0:	8b 3b                	mov    (%rbx),%edi
  401af2:	ba 00 20 00 00       	mov    $0x2000,%edx
  401af7:	4c 89 e6             	mov    %r12,%rsi
  401afa:	e8 61 f2 ff ff       	call   400d60 <read@plt>
  401aff:	89 43 04             	mov    %eax,0x4(%rbx)
  401b02:	89 c2                	mov    %eax,%edx
  401b04:	85 c0                	test   %eax,%eax
  401b06:	79 a0                	jns    401aa8 <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]+0x28>
  401b08:	e8 d3 f0 ff ff       	call   400be0 <__errno_location@plt>
  401b0d:	83 38 04             	cmpl   $0x4,(%rax)
  401b10:	74 de                	je     401af0 <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]+0x70>
  401b12:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  401b19:	48 83 c4 08          	add    $0x8,%rsp
  401b1d:	5b                   	pop    %rbx
  401b1e:	41 5c                	pop    %r12
  401b20:	41 5d                	pop    %r13
  401b22:	41 5e                	pop    %r14
  401b24:	41 5f                	pop    %r15
  401b26:	5d                   	pop    %rbp
  401b27:	c3                   	ret    
  401b28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  401b2f:	00 
  401b30:	31 c0                	xor    %eax,%eax
  401b32:	49 83 ff 01          	cmp    $0x1,%r15
  401b36:	74 e1                	je     401b19 <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]+0x99>
  401b38:	4c 89 f8             	mov    %r15,%rax
  401b3b:	41 c6 06 00          	movb   $0x0,(%r14)
  401b3f:	48 83 c4 08          	add    $0x8,%rsp
  401b43:	5b                   	pop    %rbx
  401b44:	41 5c                	pop    %r12
  401b46:	41 5d                	pop    %r13
  401b48:	41 5e                	pop    %r14
  401b4a:	41 5f                	pop    %r15
  401b4c:	5d                   	pop    %rbp
  401b4d:	c3                   	ret    
  401b4e:	b8 00 20 00 00       	mov    $0x2000,%eax
  401b53:	eb e6                	jmp    401b3b <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]+0xbb>
  401b55:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
  401b59:	e9 56 ff ff ff       	jmp    401ab4 <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]+0x34>
  401b5e:	66 90                	xchg   %ax,%ax

0000000000401b60 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)>:
  401b60:	55                   	push   %rbp
  401b61:	48 89 e5             	mov    %rsp,%rbp
  401b64:	41 57                	push   %r15
  401b66:	4d 89 cf             	mov    %r9,%r15
  401b69:	41 56                	push   %r14
  401b6b:	49 89 ce             	mov    %rcx,%r14
  401b6e:	41 55                	push   %r13
  401b70:	41 54                	push   %r12
  401b72:	53                   	push   %rbx
  401b73:	89 f3                	mov    %esi,%ebx
  401b75:	be 01 00 00 00       	mov    $0x1,%esi
  401b7a:	48 81 ec 58 c0 00 00 	sub    $0xc058,%rsp
  401b81:	48 89 bd 90 3f ff ff 	mov    %rdi,-0xc070(%rbp)
  401b88:	bf 02 00 00 00       	mov    $0x2,%edi
  401b8d:	4c 8b 6d 10          	mov    0x10(%rbp),%r13
  401b91:	48 89 95 98 3f ff ff 	mov    %rdx,-0xc068(%rbp)
  401b98:	31 d2                	xor    %edx,%edx
  401b9a:	4c 89 85 88 3f ff ff 	mov    %r8,-0xc078(%rbp)
  401ba1:	c7 85 ac 3f ff ff 00 	movl   $0x0,-0xc054(%rbp)
  401ba8:	00 00 00 
  401bab:	e8 70 f0 ff ff       	call   400c20 <socket@plt>
  401bb0:	4c 8b 95 90 3f ff ff 	mov    -0xc070(%rbp),%r10
  401bb7:	85 c0                	test   %eax,%eax
  401bb9:	0f 88 dc 03 00 00    	js     401f9b <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x43b>
  401bbf:	4c 89 d7             	mov    %r10,%rdi
  401bc2:	41 89 c4             	mov    %eax,%r12d
  401bc5:	e8 06 f1 ff ff       	call   400cd0 <gethostbyname@plt>
  401bca:	48 85 c0             	test   %rax,%rax
  401bcd:	0f 84 ea 03 00 00    	je     401fbd <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x45d>
  401bd3:	48 63 50 14          	movslq 0x14(%rax),%rdx
  401bd7:	48 8b 40 18          	mov    0x18(%rax),%rax
  401bdb:	66 0f ef c0          	pxor   %xmm0,%xmm0
  401bdf:	b9 02 00 00 00       	mov    $0x2,%ecx
  401be4:	0f 29 85 b0 3f ff ff 	movaps %xmm0,-0xc050(%rbp)
  401beb:	48 8d bd b4 3f ff ff 	lea    -0xc04c(%rbp),%rdi
  401bf2:	48 8b 30             	mov    (%rax),%rsi
  401bf5:	66 89 8d b0 3f ff ff 	mov    %cx,-0xc050(%rbp)
  401bfc:	66 c1 cb 08          	ror    $0x8,%bx
  401c00:	e8 8b f1 ff ff       	call   400d90 <memmove@plt>
  401c05:	ba 10 00 00 00       	mov    $0x10,%edx
  401c0a:	44 89 e7             	mov    %r12d,%edi
  401c0d:	48 8d b5 b0 3f ff ff 	lea    -0xc050(%rbp),%rsi
  401c14:	66 89 9d b2 3f ff ff 	mov    %bx,-0xc04e(%rbp)
  401c1b:	e8 80 f0 ff ff       	call   400ca0 <connect@plt>
  401c20:	85 c0                	test   %eax,%eax
  401c22:	0f 88 9f 03 00 00    	js     401fc7 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x467>
  401c28:	4c 89 ef             	mov    %r13,%rdi
  401c2b:	e8 30 f0 ff ff       	call   400c60 <strlen@plt>
  401c30:	48 8b bd 98 3f ff ff 	mov    -0xc068(%rbp),%rdi
  401c37:	48 89 85 90 3f ff ff 	mov    %rax,-0xc070(%rbp)
  401c3e:	e8 1d f0 ff ff       	call   400c60 <strlen@plt>
  401c43:	4c 89 f7             	mov    %r14,%rdi
  401c46:	48 89 c3             	mov    %rax,%rbx
  401c49:	e8 12 f0 ff ff       	call   400c60 <strlen@plt>
  401c4e:	4c 89 ff             	mov    %r15,%rdi
  401c51:	48 01 c3             	add    %rax,%rbx
  401c54:	e8 07 f0 ff ff       	call   400c60 <strlen@plt>
  401c59:	48 8b 95 90 3f ff ff 	mov    -0xc070(%rbp),%rdx
  401c60:	48 8d 84 03 80 00 00 	lea    0x80(%rbx,%rax,1),%rax
  401c67:	00 
  401c68:	48 8d 14 52          	lea    (%rdx,%rdx,2),%rdx
  401c6c:	48 01 d0             	add    %rdx,%rax
  401c6f:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
  401c75:	0f 87 f0 02 00 00    	ja     401f6b <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x40b>
  401c7b:	4c 8d 8d c0 3f ff ff 	lea    -0xc040(%rbp),%r9
  401c82:	31 c0                	xor    %eax,%eax
  401c84:	b9 00 04 00 00       	mov    $0x400,%ecx
  401c89:	4c 89 cf             	mov    %r9,%rdi
  401c8c:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  401c8f:	4c 89 ef             	mov    %r13,%rdi
  401c92:	e8 c9 ef ff ff       	call   400c60 <strlen@plt>
  401c97:	4c 8d 8d c0 3f ff ff 	lea    -0xc040(%rbp),%r9
  401c9e:	85 c0                	test   %eax,%eax
  401ca0:	0f 84 b2 00 00 00    	je     401d58 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x1f8>
  401ca6:	49 ba 26 00 ff ff ff 	movabs $0xffdfffffffff0026,%r10
  401cad:	ff df ff 
  401cb0:	83 e8 01             	sub    $0x1,%eax
  401cb3:	4c 89 cb             	mov    %r9,%rbx
  401cb6:	49 8d 4c 05 01       	lea    0x1(%r13,%rax,1),%rcx
  401cbb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401cc0:	41 0f b6 45 00       	movzbl 0x0(%r13),%eax
  401cc5:	8d 50 d6             	lea    -0x2a(%rax),%edx
  401cc8:	80 fa 35             	cmp    $0x35,%dl
  401ccb:	0f 86 ff 01 00 00    	jbe    401ed0 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x370>
  401cd1:	89 c2                	mov    %eax,%edx
  401cd3:	83 e2 df             	and    $0xffffffdf,%edx
  401cd6:	83 ea 41             	sub    $0x41,%edx
  401cd9:	80 fa 19             	cmp    $0x19,%dl
  401cdc:	0f 86 f4 01 00 00    	jbe    401ed6 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x376>
  401ce2:	3c 20                	cmp    $0x20,%al
  401ce4:	0f 84 6e 02 00 00    	je     401f58 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x3f8>
  401cea:	8d 50 e0             	lea    -0x20(%rax),%edx
  401ced:	80 fa 5f             	cmp    $0x5f,%dl
  401cf0:	76 08                	jbe    401cfa <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x19a>
  401cf2:	3c 09                	cmp    $0x9,%al
  401cf4:	0f 85 6a 02 00 00    	jne    401f64 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x404>
  401cfa:	0f b6 d0             	movzbl %al,%edx
  401cfd:	be e0 29 40 00       	mov    $0x4029e0,%esi
  401d02:	31 c0                	xor    %eax,%eax
  401d04:	49 83 c5 01          	add    $0x1,%r13
  401d08:	48 8d bd d0 bf ff ff 	lea    -0x4030(%rbp),%rdi
  401d0f:	48 89 8d 90 3f ff ff 	mov    %rcx,-0xc070(%rbp)
  401d16:	48 83 c3 03          	add    $0x3,%rbx
  401d1a:	e8 f1 ee ff ff       	call   400c10 <sprintf@plt>
  401d1f:	0f b7 85 d0 bf ff ff 	movzwl -0x4030(%rbp),%eax
  401d26:	48 8b 8d 90 3f ff ff 	mov    -0xc070(%rbp),%rcx
  401d2d:	49 ba 26 00 ff ff ff 	movabs $0xffdfffffffff0026,%r10
  401d34:	ff df ff 
  401d37:	4c 8d 8d c0 3f ff ff 	lea    -0xc040(%rbp),%r9
  401d3e:	66 89 43 fd          	mov    %ax,-0x3(%rbx)
  401d42:	0f b6 85 d2 bf ff ff 	movzbl -0x402e(%rbp),%eax
  401d49:	88 43 ff             	mov    %al,-0x1(%rbx)
  401d4c:	49 39 cd             	cmp    %rcx,%r13
  401d4f:	0f 85 6b ff ff ff    	jne    401cc0 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x160>
  401d55:	0f 1f 00             	nopl   (%rax)
  401d58:	48 83 ec 08          	sub    $0x8,%rsp
  401d5c:	48 8b 95 98 3f ff ff 	mov    -0xc068(%rbp),%rdx
  401d63:	4c 89 f1             	mov    %r14,%rcx
  401d66:	31 c0                	xor    %eax,%eax
  401d68:	41 51                	push   %r9
  401d6a:	be 60 29 40 00       	mov    $0x402960,%esi
  401d6f:	4d 89 f9             	mov    %r15,%r9
  401d72:	4c 8b 85 88 3f ff ff 	mov    -0xc078(%rbp),%r8
  401d79:	48 8d bd d0 bf ff ff 	lea    -0x4030(%rbp),%rdi
  401d80:	4c 8d ad d0 bf ff ff 	lea    -0x4030(%rbp),%r13
  401d87:	e8 84 ee ff ff       	call   400c10 <sprintf@plt>
  401d8c:	48 8d bd d0 bf ff ff 	lea    -0x4030(%rbp),%rdi
  401d93:	e8 c8 ee ff ff       	call   400c60 <strlen@plt>
  401d98:	49 89 c6             	mov    %rax,%r14
  401d9b:	58                   	pop    %rax
  401d9c:	5a                   	pop    %rdx
  401d9d:	4c 89 f3             	mov    %r14,%rbx
  401da0:	4d 85 f6             	test   %r14,%r14
  401da3:	74 2b                	je     401dd0 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x270>
  401da5:	0f 1f 00             	nopl   (%rax)
  401da8:	48 89 da             	mov    %rbx,%rdx
  401dab:	4c 89 ee             	mov    %r13,%rsi
  401dae:	44 89 e7             	mov    %r12d,%edi
  401db1:	e8 8a ee ff ff       	call   400c40 <write@plt>
  401db6:	48 85 c0             	test   %rax,%rax
  401db9:	0f 8e 51 01 00 00    	jle    401f10 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x3b0>
  401dbf:	49 01 c5             	add    %rax,%r13
  401dc2:	48 29 c3             	sub    %rax,%rbx
  401dc5:	75 e1                	jne    401da8 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x248>
  401dc7:	4d 85 f6             	test   %r14,%r14
  401dca:	0f 88 4e 01 00 00    	js     401f1e <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x3be>
  401dd0:	48 8d 85 d0 9f ff ff 	lea    -0x6030(%rbp),%rax
  401dd7:	48 8d b5 d0 bf ff ff 	lea    -0x4030(%rbp),%rsi
  401dde:	44 89 a5 c0 9f ff ff 	mov    %r12d,-0x6040(%rbp)
  401de5:	48 8d bd c0 9f ff ff 	lea    -0x6040(%rbp),%rdi
  401dec:	48 89 85 c8 9f ff ff 	mov    %rax,-0x6038(%rbp)
  401df3:	c7 85 c4 9f ff ff 00 	movl   $0x0,-0x603c(%rbp)
  401dfa:	00 00 00 
  401dfd:	e8 7e fc ff ff       	call   401a80 <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]>
  401e02:	48 85 c0             	test   %rax,%rax
  401e05:	0f 8e a8 01 00 00    	jle    401fb3 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x453>
  401e0b:	48 8d 95 c0 5f ff ff 	lea    -0xa040(%rbp),%rdx
  401e12:	4c 8d 85 c0 7f ff ff 	lea    -0x8040(%rbp),%r8
  401e19:	31 c0                	xor    %eax,%eax
  401e1b:	be e7 29 40 00       	mov    $0x4029e7,%esi
  401e20:	48 8d 8d ac 3f ff ff 	lea    -0xc054(%rbp),%rcx
  401e27:	48 8d bd d0 bf ff ff 	lea    -0x4030(%rbp),%rdi
  401e2e:	e8 4d ee ff ff       	call   400c80 <sscanf@plt>
  401e33:	8b 95 ac 3f ff ff    	mov    -0xc054(%rbp),%edx
  401e39:	81 fa c8 00 00 00    	cmp    $0xc8,%edx
  401e3f:	74 1d                	je     401e5e <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x2fe>
  401e41:	e9 2c 01 00 00       	jmp    401f72 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x412>
  401e46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  401e4d:	00 00 00 
  401e50:	e8 2b fc ff ff       	call   401a80 <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]>
  401e55:	48 85 c0             	test   %rax,%rax
  401e58:	0f 8e ca 00 00 00    	jle    401f28 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x3c8>
  401e5e:	be f8 29 40 00       	mov    $0x4029f8,%esi
  401e63:	48 8d bd d0 bf ff ff 	lea    -0x4030(%rbp),%rdi
  401e6a:	e8 c1 ee ff ff       	call   400d30 <strcmp@plt>
  401e6f:	48 8d b5 d0 bf ff ff 	lea    -0x4030(%rbp),%rsi
  401e76:	48 8d bd c0 9f ff ff 	lea    -0x6040(%rbp),%rdi
  401e7d:	85 c0                	test   %eax,%eax
  401e7f:	75 cf                	jne    401e50 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x2f0>
  401e81:	e8 fa fb ff ff       	call   401a80 <rio_readlineb(rio_t*, void*, unsigned long) [clone .constprop.0]>
  401e86:	48 85 c0             	test   %rax,%rax
  401e89:	0f 8e 42 01 00 00    	jle    401fd1 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x471>
  401e8f:	48 8b 7d 18          	mov    0x18(%rbp),%rdi
  401e93:	48 8d b5 d0 bf ff ff 	lea    -0x4030(%rbp),%rsi
  401e9a:	e8 21 ee ff ff       	call   400cc0 <strcpy@plt>
  401e9f:	44 89 e7             	mov    %r12d,%edi
  401ea2:	e8 19 ef ff ff       	call   400dc0 <close@plt>
  401ea7:	48 8b 7d 18          	mov    0x18(%rbp),%rdi
  401eab:	be fb 29 40 00       	mov    $0x4029fb,%esi
  401eb0:	e8 7b ee ff ff       	call   400d30 <strcmp@plt>
  401eb5:	f7 d8                	neg    %eax
  401eb7:	19 c0                	sbb    %eax,%eax
  401eb9:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
  401ebd:	5b                   	pop    %rbx
  401ebe:	41 5c                	pop    %r12
  401ec0:	41 5d                	pop    %r13
  401ec2:	41 5e                	pop    %r14
  401ec4:	41 5f                	pop    %r15
  401ec6:	5d                   	pop    %rbp
  401ec7:	c3                   	ret    
  401ec8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  401ecf:	00 
  401ed0:	49 0f a3 d2          	bt     %rdx,%r10
  401ed4:	72 1a                	jb     401ef0 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x390>
  401ed6:	88 03                	mov    %al,(%rbx)
  401ed8:	48 83 c3 01          	add    $0x1,%rbx
  401edc:	49 83 c5 01          	add    $0x1,%r13
  401ee0:	49 39 cd             	cmp    %rcx,%r13
  401ee3:	0f 85 d7 fd ff ff    	jne    401cc0 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x160>
  401ee9:	e9 6a fe ff ff       	jmp    401d58 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x1f8>
  401eee:	66 90                	xchg   %ax,%ax
  401ef0:	89 c2                	mov    %eax,%edx
  401ef2:	83 e2 df             	and    $0xffffffdf,%edx
  401ef5:	83 ea 41             	sub    $0x41,%edx
  401ef8:	80 fa 19             	cmp    $0x19,%dl
  401efb:	76 d9                	jbe    401ed6 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x376>
  401efd:	8d 50 e0             	lea    -0x20(%rax),%edx
  401f00:	80 fa 5f             	cmp    $0x5f,%dl
  401f03:	0f 87 e9 fd ff ff    	ja     401cf2 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x192>
  401f09:	e9 ec fd ff ff       	jmp    401cfa <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x19a>
  401f0e:	66 90                	xchg   %ax,%ax
  401f10:	e8 cb ec ff ff       	call   400be0 <__errno_location@plt>
  401f15:	83 38 04             	cmpl   $0x4,(%rax)
  401f18:	0f 84 8a fe ff ff    	je     401da8 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x248>
  401f1e:	be 10 28 40 00       	mov    $0x402810,%esi
  401f23:	eb 08                	jmp    401f2d <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x3cd>
  401f25:	0f 1f 00             	nopl   (%rax)
  401f28:	be a8 28 40 00       	mov    $0x4028a8,%esi
  401f2d:	48 8b 7d 18          	mov    0x18(%rbp),%rdi
  401f31:	e8 8a ed ff ff       	call   400cc0 <strcpy@plt>
  401f36:	44 89 e7             	mov    %r12d,%edi
  401f39:	e8 82 ee ff ff       	call   400dc0 <close@plt>
  401f3e:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
  401f42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401f47:	5b                   	pop    %rbx
  401f48:	41 5c                	pop    %r12
  401f4a:	41 5d                	pop    %r13
  401f4c:	41 5e                	pop    %r14
  401f4e:	41 5f                	pop    %r15
  401f50:	5d                   	pop    %rbp
  401f51:	c3                   	ret    
  401f52:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401f58:	c6 03 2b             	movb   $0x2b,(%rbx)
  401f5b:	48 83 c3 01          	add    $0x1,%rbx
  401f5f:	e9 78 ff ff ff       	jmp    401edc <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x37c>
  401f64:	be 18 29 40 00       	mov    $0x402918,%esi
  401f69:	eb c2                	jmp    401f2d <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x3cd>
  401f6b:	be d8 27 40 00       	mov    $0x4027d8,%esi
  401f70:	eb bb                	jmp    401f2d <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x3cd>
  401f72:	48 8b 7d 18          	mov    0x18(%rbp),%rdi
  401f76:	48 8d 8d c0 7f ff ff 	lea    -0x8040(%rbp),%rcx
  401f7d:	be 78 28 40 00       	mov    $0x402878,%esi
  401f82:	31 c0                	xor    %eax,%eax
  401f84:	e8 87 ec ff ff       	call   400c10 <sprintf@plt>
  401f89:	44 89 e7             	mov    %r12d,%edi
  401f8c:	e8 2f ee ff ff       	call   400dc0 <close@plt>
  401f91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401f96:	e9 1e ff ff ff       	jmp    401eb9 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x359>
  401f9b:	48 8b 7d 18          	mov    0x18(%rbp),%rdi
  401f9f:	be 58 27 40 00       	mov    $0x402758,%esi
  401fa4:	e8 17 ed ff ff       	call   400cc0 <strcpy@plt>
  401fa9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401fae:	e9 06 ff ff ff       	jmp    401eb9 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x359>
  401fb3:	be 40 28 40 00       	mov    $0x402840,%esi
  401fb8:	e9 70 ff ff ff       	jmp    401f2d <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x3cd>
  401fbd:	be 80 27 40 00       	mov    $0x402780,%esi
  401fc2:	e9 66 ff ff ff       	jmp    401f2d <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x3cd>
  401fc7:	be b0 27 40 00       	mov    $0x4027b0,%esi
  401fcc:	e9 5c ff ff ff       	jmp    401f2d <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x3cd>
  401fd1:	be e0 28 40 00       	mov    $0x4028e0,%esi
  401fd6:	e9 52 ff ff ff       	jmp    401f2d <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)+0x3cd>
  401fdb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000401fe0 <init_timeout(int)>:
  401fe0:	85 ff                	test   %edi,%edi
  401fe2:	75 04                	jne    401fe8 <init_timeout(int)+0x8>
  401fe4:	c3                   	ret    
  401fe5:	0f 1f 00             	nopl   (%rax)
  401fe8:	55                   	push   %rbp
  401fe9:	be 50 1a 40 00       	mov    $0x401a50,%esi
  401fee:	48 89 e5             	mov    %rsp,%rbp
  401ff1:	53                   	push   %rbx
  401ff2:	89 fb                	mov    %edi,%ebx
  401ff4:	bf 0e 00 00 00       	mov    $0xe,%edi
  401ff9:	48 83 ec 08          	sub    $0x8,%rsp
  401ffd:	e8 ee ec ff ff       	call   400cf0 <signal@plt>
  402002:	31 c0                	xor    %eax,%eax
  402004:	85 db                	test   %ebx,%ebx
  402006:	0f 49 c3             	cmovns %ebx,%eax
  402009:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  40200d:	c9                   	leave  
  40200e:	89 c7                	mov    %eax,%edi
  402010:	e9 9b ed ff ff       	jmp    400db0 <alarm@plt>
  402015:	90                   	nop
  402016:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40201d:	00 00 00 

0000000000402020 <init_driver(char*)>:
  402020:	55                   	push   %rbp
  402021:	be 01 00 00 00       	mov    $0x1,%esi
  402026:	48 89 e5             	mov    %rsp,%rbp
  402029:	41 55                	push   %r13
  40202b:	49 89 fd             	mov    %rdi,%r13
  40202e:	bf 0d 00 00 00       	mov    $0xd,%edi
  402033:	41 54                	push   %r12
  402035:	48 83 ec 10          	sub    $0x10,%rsp
  402039:	e8 b2 ec ff ff       	call   400cf0 <signal@plt>
  40203e:	be 01 00 00 00       	mov    $0x1,%esi
  402043:	bf 1d 00 00 00       	mov    $0x1d,%edi
  402048:	e8 a3 ec ff ff       	call   400cf0 <signal@plt>
  40204d:	be 01 00 00 00       	mov    $0x1,%esi
  402052:	bf 1d 00 00 00       	mov    $0x1d,%edi
  402057:	e8 94 ec ff ff       	call   400cf0 <signal@plt>
  40205c:	31 d2                	xor    %edx,%edx
  40205e:	be 01 00 00 00       	mov    $0x1,%esi
  402063:	bf 02 00 00 00       	mov    $0x2,%edi
  402068:	e8 b3 eb ff ff       	call   400c20 <socket@plt>
  40206d:	85 c0                	test   %eax,%eax
  40206f:	78 7a                	js     4020eb <init_driver(char*)+0xcb>
  402071:	bf fe 29 40 00       	mov    $0x4029fe,%edi
  402076:	41 89 c4             	mov    %eax,%r12d
  402079:	e8 52 ec ff ff       	call   400cd0 <gethostbyname@plt>
  40207e:	48 85 c0             	test   %rax,%rax
  402081:	0f 84 9b 00 00 00    	je     402122 <init_driver(char*)+0x102>
  402087:	66 0f ef c0          	pxor   %xmm0,%xmm0
  40208b:	ba 02 00 00 00       	mov    $0x2,%edx
  402090:	48 8d 7d e4          	lea    -0x1c(%rbp),%rdi
  402094:	0f 29 45 e0          	movaps %xmm0,-0x20(%rbp)
  402098:	66 89 55 e0          	mov    %dx,-0x20(%rbp)
  40209c:	48 63 50 14          	movslq 0x14(%rax),%rdx
  4020a0:	48 8b 40 18          	mov    0x18(%rax),%rax
  4020a4:	48 8b 30             	mov    (%rax),%rsi
  4020a7:	e8 e4 ec ff ff       	call   400d90 <memmove@plt>
  4020ac:	b9 3b 6e 00 00       	mov    $0x6e3b,%ecx
  4020b1:	ba 10 00 00 00       	mov    $0x10,%edx
  4020b6:	44 89 e7             	mov    %r12d,%edi
  4020b9:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
  4020bd:	66 89 4d e2          	mov    %cx,-0x1e(%rbp)
  4020c1:	e8 da eb ff ff       	call   400ca0 <connect@plt>
  4020c6:	85 c0                	test   %eax,%eax
  4020c8:	78 35                	js     4020ff <init_driver(char*)+0xdf>
  4020ca:	44 89 e7             	mov    %r12d,%edi
  4020cd:	e8 ee ec ff ff       	call   400dc0 <close@plt>
  4020d2:	be fb 29 40 00       	mov    $0x4029fb,%esi
  4020d7:	4c 89 ef             	mov    %r13,%rdi
  4020da:	e8 e1 eb ff ff       	call   400cc0 <strcpy@plt>
  4020df:	31 c0                	xor    %eax,%eax
  4020e1:	48 83 c4 10          	add    $0x10,%rsp
  4020e5:	41 5c                	pop    %r12
  4020e7:	41 5d                	pop    %r13
  4020e9:	5d                   	pop    %rbp
  4020ea:	c3                   	ret    
  4020eb:	be 58 27 40 00       	mov    $0x402758,%esi
  4020f0:	4c 89 ef             	mov    %r13,%rdi
  4020f3:	e8 c8 eb ff ff       	call   400cc0 <strcpy@plt>
  4020f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4020fd:	eb e2                	jmp    4020e1 <init_driver(char*)+0xc1>
  4020ff:	ba fe 29 40 00       	mov    $0x4029fe,%edx
  402104:	be b8 29 40 00       	mov    $0x4029b8,%esi
  402109:	4c 89 ef             	mov    %r13,%rdi
  40210c:	31 c0                	xor    %eax,%eax
  40210e:	e8 fd ea ff ff       	call   400c10 <sprintf@plt>
  402113:	44 89 e7             	mov    %r12d,%edi
  402116:	e8 a5 ec ff ff       	call   400dc0 <close@plt>
  40211b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  402120:	eb bf                	jmp    4020e1 <init_driver(char*)+0xc1>
  402122:	be 80 27 40 00       	mov    $0x402780,%esi
  402127:	4c 89 ef             	mov    %r13,%rdi
  40212a:	e8 91 eb ff ff       	call   400cc0 <strcpy@plt>
  40212f:	44 89 e7             	mov    %r12d,%edi
  402132:	e8 89 ec ff ff       	call   400dc0 <close@plt>
  402137:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  40213c:	eb a3                	jmp    4020e1 <init_driver(char*)+0xc1>
  40213e:	66 90                	xchg   %ax,%ax

0000000000402140 <driver_post(char*, char*, char*, int, char*)>:
  402140:	55                   	push   %rbp
  402141:	48 89 e5             	mov    %rsp,%rbp
  402144:	41 56                	push   %r14
  402146:	49 89 d6             	mov    %rdx,%r14
  402149:	41 55                	push   %r13
  40214b:	4d 89 c5             	mov    %r8,%r13
  40214e:	41 54                	push   %r12
  402150:	53                   	push   %rbx
  402151:	85 c9                	test   %ecx,%ecx
  402153:	75 3b                	jne    402190 <driver_post(char*, char*, char*, int, char*)+0x50>
  402155:	49 89 fc             	mov    %rdi,%r12
  402158:	48 85 ff             	test   %rdi,%rdi
  40215b:	74 11                	je     40216e <driver_post(char*, char*, char*, int, char*)+0x2e>
  40215d:	48 89 f3             	mov    %rsi,%rbx
  402160:	be fa 29 40 00       	mov    $0x4029fa,%esi
  402165:	e8 c6 eb ff ff       	call   400d30 <strcmp@plt>
  40216a:	85 c0                	test   %eax,%eax
  40216c:	75 52                	jne    4021c0 <driver_post(char*, char*, char*, int, char*)+0x80>
  40216e:	4c 89 ef             	mov    %r13,%rdi
  402171:	be fb 29 40 00       	mov    $0x4029fb,%esi
  402176:	e8 45 eb ff ff       	call   400cc0 <strcpy@plt>
  40217b:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
  40217f:	31 c0                	xor    %eax,%eax
  402181:	5b                   	pop    %rbx
  402182:	41 5c                	pop    %r12
  402184:	41 5d                	pop    %r13
  402186:	41 5e                	pop    %r14
  402188:	5d                   	pop    %rbp
  402189:	c3                   	ret    
  40218a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  402190:	48 89 d6             	mov    %rdx,%rsi
  402193:	bf 14 2a 40 00       	mov    $0x402a14,%edi
  402198:	31 c0                	xor    %eax,%eax
  40219a:	e8 51 ea ff ff       	call   400bf0 <printf@plt>
  40219f:	4c 89 ef             	mov    %r13,%rdi
  4021a2:	be fb 29 40 00       	mov    $0x4029fb,%esi
  4021a7:	e8 14 eb ff ff       	call   400cc0 <strcpy@plt>
  4021ac:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
  4021b0:	31 c0                	xor    %eax,%eax
  4021b2:	5b                   	pop    %rbx
  4021b3:	41 5c                	pop    %r12
  4021b5:	41 5d                	pop    %r13
  4021b7:	41 5e                	pop    %r14
  4021b9:	5d                   	pop    %rbp
  4021ba:	c3                   	ret    
  4021bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4021c0:	41 55                	push   %r13
  4021c2:	4c 89 e1             	mov    %r12,%rcx
  4021c5:	49 89 d8             	mov    %rbx,%r8
  4021c8:	ba 35 2a 40 00       	mov    $0x402a35,%edx
  4021cd:	41 56                	push   %r14
  4021cf:	41 b9 2b 2a 40 00    	mov    $0x402a2b,%r9d
  4021d5:	be 6e 3b 00 00       	mov    $0x3b6e,%esi
  4021da:	bf fe 29 40 00       	mov    $0x4029fe,%edi
  4021df:	e8 7c f9 ff ff       	call   401b60 <submitr(char const*, int, char const*, char const*, char const*, char const*, char const*, char*)>
  4021e4:	5a                   	pop    %rdx
  4021e5:	59                   	pop    %rcx
  4021e6:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
  4021ea:	5b                   	pop    %rbx
  4021eb:	41 5c                	pop    %r12
  4021ed:	41 5d                	pop    %r13
  4021ef:	41 5e                	pop    %r14
  4021f1:	5d                   	pop    %rbp
  4021f2:	c3                   	ret    
  4021f3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4021fa:	00 00 00 
  4021fd:	0f 1f 00             	nopl   (%rax)

0000000000402200 <__libc_csu_init>:
  402200:	41 57                	push   %r15
  402202:	41 56                	push   %r14
  402204:	49 89 d7             	mov    %rdx,%r15
  402207:	41 55                	push   %r13
  402209:	41 54                	push   %r12
  40220b:	4c 8d 25 c6 1b 20 00 	lea    0x201bc6(%rip),%r12        # 603dd8 <__frame_dummy_init_array_entry>
  402212:	55                   	push   %rbp
  402213:	48 8d 2d ce 1b 20 00 	lea    0x201bce(%rip),%rbp        # 603de8 <__do_global_dtors_aux_fini_array_entry>
  40221a:	53                   	push   %rbx
  40221b:	41 89 fd             	mov    %edi,%r13d
  40221e:	49 89 f6             	mov    %rsi,%r14
  402221:	4c 29 e5             	sub    %r12,%rbp
  402224:	48 83 ec 08          	sub    $0x8,%rsp
  402228:	48 c1 fd 03          	sar    $0x3,%rbp
  40222c:	e8 77 e9 ff ff       	call   400ba8 <_init>
  402231:	48 85 ed             	test   %rbp,%rbp
  402234:	74 18                	je     40224e <__libc_csu_init+0x4e>
  402236:	31 db                	xor    %ebx,%ebx
  402238:	4c 89 fa             	mov    %r15,%rdx
  40223b:	4c 89 f6             	mov    %r14,%rsi
  40223e:	44 89 ef             	mov    %r13d,%edi
  402241:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  402245:	48 83 c3 01          	add    $0x1,%rbx
  402249:	48 39 dd             	cmp    %rbx,%rbp
  40224c:	75 ea                	jne    402238 <__libc_csu_init+0x38>
  40224e:	48 83 c4 08          	add    $0x8,%rsp
  402252:	5b                   	pop    %rbx
  402253:	5d                   	pop    %rbp
  402254:	41 5c                	pop    %r12
  402256:	41 5d                	pop    %r13
  402258:	41 5e                	pop    %r14
  40225a:	41 5f                	pop    %r15
  40225c:	c3                   	ret    
  40225d:	0f 1f 00             	nopl   (%rax)

0000000000402260 <__libc_csu_fini>:
  402260:	f3 c3                	repz ret 
  402262:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  402269:	00 00 00 
  40226c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000402270 <atexit>:
  402270:	48 c7 c0 28 41 60 00 	mov    $0x604128,%rax
  402277:	31 d2                	xor    %edx,%edx
  402279:	48 85 c0             	test   %rax,%rax
  40227c:	74 03                	je     402281 <atexit+0x11>
  40227e:	48 8b 10             	mov    (%rax),%rdx
  402281:	31 f6                	xor    %esi,%esi
  402283:	e9 28 ea ff ff       	jmp    400cb0 <__cxa_atexit@plt>

Disassembly of section .fini:

0000000000402288 <_fini>:
  402288:	48 83 ec 08          	sub    $0x8,%rsp
  40228c:	48 83 c4 08          	add    $0x8,%rsp
  402290:	c3                   	ret    
