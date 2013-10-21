	DEVICE ZXSPECTRUM128

	ORG 0x8000
START  
;�������� ����
WIZ_BASE_ADDR	= 0xc000
W_MR			= WIZ_BASE_ADDR+0x0000
W_SHAR			= WIZ_BASE_ADDR+0x0008

S0_MR		= WIZ_BASE_ADDR+0x0201 ;��.����
S0_CR		= WIZ_BASE_ADDR+0x0203 ;��.����
S0_SSR		= WIZ_BASE_ADDR+0x0209 ;��.����
S0_PORTR	= WIZ_BASE_ADDR+0x020a
S0_DPORTR	= WIZ_BASE_ADDR+0x0212
S0_DIPR		= WIZ_BASE_ADDR+0x0214
S0_TX_WRSR	= WIZ_BASE_ADDR+0x0222 ;��.�����
S0_RX_RSR	= WIZ_BASE_ADDR+0x022a 
S0_TX_FAKE	= WIZ_BASE_ADDR+0x2000
S0_RX_FAKE	= WIZ_BASE_ADDR+0x3000
;/***************************************/ 
;/* The bit of Sn_MR regsiter defintion */ 
;/***************************************/ 
Sn_MR_CLOSE        = 0x00                 ;/**< Protocol bits of Sn_MR. */
Sn_MR_TCP          = 0x01                 ;/**< Protocol bits of Sn_MR. */
Sn_MR_UDP          = 0x02                 ;/**< Protocol bits of Sn_MR. */
Sn_MR_IPRAW        = 0x03                 ;/**< Protocol bits of Sn_MR. */
Sn_MR_MACRAW       = 0x04                 ;/**< Protocol bits of Sn_MR. */
Sn_MR_PPPoE        = 0x05                 ;/**< Protocol bits of Sn_MR. */

/******************************/ 
/* The values of CR defintion */ 
/******************************/
Sn_CR_OPEN         = 0x01                 ;/**< OPEN command value of Sn_CR. */
Sn_CR_LISTEN       = 0x02                 ;/**< LISTEN command value of Sn_CR. */
Sn_CR_CONNECT      = 0x04                 ;/**< CONNECT command value of Sn_CR. */
Sn_CR_DISCON       = 0x08                 ;/**< DISCONNECT command value of Sn_CR. */
Sn_CR_CLOSE        = 0x10                 ;/**< CLOSE command value of Sn_CR. */
Sn_CR_SEND         = 0x20                 ;/**< SEND command value of Sn_CR. */
Sn_CR_SEND_MAC     = 0x21                 ;/**< SEND_MAC command value of Sn_CR. */ 
Sn_CR_SEND_KEEP    = 0x22                 ;/**< SEND_KEEP command value of Sn_CR */
Sn_CR_RECV         = 0x40                 ;/**< RECV command value of Sn_CR */
Sn_CR_PCON         = 0x23                 ;/**< PCON command value of Sn_CR */
Sn_CR_PDISCON      = 0x24                 ;/**< PDISCON command value of Sn_CR */ 
Sn_CR_PCR          = 0x25                 ;/**< PCR command value of Sn_CR */
Sn_CR_PCN          = 0x26                 ;/**< PCN command value of Sn_CR */
Sn_CR_PCJ          = 0x27                 ;/**< PCJ command value of Sn_CR */

;/**********************************/ 
;/* The values of Sn_SSR defintion */ 
;/**********************************/
SOCK_CLOSED        = 0x00                 ;< SOCKETn is released */
SOCK_ARP           = 0x01                 ;< ARP-request is transmitted in order to acquire destination hardware address. */
SOCK_INIT          = 0x13                 ;< SOCKETn is open as TCP mode. */
SOCK_LISTEN        = 0x14                 ;< SOCKETn operates as "TCP SERVER" and waits for connection-request (SYN packet) from "TCP CLIENT". */
SOCK_SYNSENT       = 0x15                 ;< Connect-request(SYN packet) is transmitted to "TCP SERVER". */
SOCK_SYNRECV       = 0x16                 ;< Connect-request(SYN packet) is received from "TCP CLIENT". */
SOCK_ESTABLISHED   = 0x17                 ;< TCP connection is established. */
SOCK_FIN_WAIT      = 0x18                 ;< SOCKETn is closing. */
SOCK_CLOSING       = 0x1A                 ;< SOCKETn is closing. */
SOCK_TIME_WAIT     = 0x1B                 ;< SOCKETn is closing. */
SOCK_CLOSE_WAIT    = 0x1C                 ;< Disconnect-request(FIN packet) is received from the peer. */
SOCK_LAST_ACK      = 0x1D                 ;< SOCKETn is closing. */
SOCK_UDP           = 0x22                 ;< SOCKETn is open as UDP mode. */
SOCK_IPRAW         = 0x32                 ;< SOCKETn is open as IPRAW mode. */
SOCK_MACRAW        = 0x42                 ;< SOCKET0 is open as MACRAW mode. */
SOCK_PPPoE         = 0x5F                 ;< SOCKET0 is open as PPPoE mode. */

	di
	ld sp,0xc000
	ld hl,0x4000
	ld (hl),0
	ld de,0x4001
	ld bc,192*256/8-1
	ldir
;������ ��������� ����
;��� �������� ��������� �� 50��
	ei
	halt
	ld bc,0x83ab
	in a,(c)
	and 0xee
	out (c),a	; �����
	halt
	or 0x10
	out (c),a	; ������ ������
	halt
	
;������������� ��������� � �������� ������������ z80.
;��� ������� ���������� � ������ 0xc000-0xffff (� �������� ZX-Evo baseconf).
;������������� ����� ����������� ������ ��� ������������ ��� � �������� �������� ����.
;�������� ��� �� ����� ��������
	ld a,1
	out (0xbf),a
	ld bc,0xfff7
	ld a,0x3f
	out (c),a
;������ �������� �������������
	ld bc,0x82ab
	ld a,7	
	out (c),a
	
;����� ��������� ����(������ �������� ��������, �� ����������)
	ld a,0x80
	ld (W_MR+1),a
	halt
	ld a,0x3c
	ld (W_MR),a
	di
;���������� MAC, ����, ����� � ��. �������� ��� ����!!!
	ld hl,mac
	ld de,W_SHAR
	ld bc,20
	ldir
	;� ����� ������� ��� ����� ����������� � ��������� ����� ������� ������������.
	;������� ����� �������� ����� � ��������� ������ ���, �� ��� ������� � ����� ����������.
	
;----------------------------------------------------------
;������ ����������� � TCP(����) ������� � �������� �������
;----------------------------------------------------------

;�������� �����
soc_noinit
	ld a,Sn_CR_CLOSE	;������� ����������
	ld (S0_CR),a		
	ld a,Sn_MR_TCP		;����� ������ TCP
	ld (S0_MR),a
	ld hl,(source_port)	;���������� ���������� ����, ���� � ���������� �� ���������
	inc hl
	ld (source_port),hl
	ld e,h				;���������, ������ ����� �������
	ld d,l
	ld (S0_PORTR),de
	ld a,Sn_CR_OPEN		;���� ������� �������� ������
	ld (S0_CR),a
wait_cr0
	ld a,(S0_CR)		;������� ���������� �������
	or a
	jr nz,wait_cr0
	ld a,(S0_SSR)		;���� �� �����������������, �� ������
	cp SOCK_INIT
	jr nz,soc_noinit
;--------------------	
;���������� � �������
;--------------------
	ld hl,S0_DPORTR ;���� ������� !���������!
	ld (hl),0
	inc hl
	ld (hl),80
	ld hl,S0_DIPR	;ip ������� ������1999 217.146.69.13
	ld (hl),217
	inc hl
	ld (hl),146
	inc hl
	ld (hl),69
	inc hl
	ld (hl),13
	ld a,Sn_CR_CONNECT		;���� ������� �������
	ld (S0_CR),a
wait_cr1
	ld a,(S0_CR)		;������� ���������� �������
	or a
	jr nz,wait_cr1
;������� �������� � ��������
wait_con
	ld a,(S0_SSR)
	or a
	jp z,soc_noinit		;������ ����� ������(��������) �������
	cp SOCK_ESTABLISHED	;������ �� ��� ���� ��������� � ������ ���� ����, � ������ �����
	jr nz,wait_con		;�� �� ������ �� ��� ����
wait_con_end	

;��������������, ������ GET ������
;--------------------
;�������� ������
;--------------------
	ld hl,get_str		;���������� ���� � ����� ����
	ld de,S0_TX_FAKE
	ld bc,get_str_end-get_str
	inc bc				;���������� ���� ������ ���������� ����
	res 0,c				;������� �������� �� �������
	ldir				;������ ��������!!! ldir'��� ����� �� ����� 512 ����, ������ �������� ������,
						;�� �� ������� ���� ������, �.�. ������ � ��� ���� ������
	ld a,high (get_str_end-get_str)
	ld (S0_TX_WRSR),a	;���������� ������ ����, �� ������� ��� ���������
	ld a,low (get_str_end-get_str)
	ld (S0_TX_WRSR+1),a	;� ��� ����� ����� ��������� ������ ���-�� ����, �������� �� ����������
	
	ld a,Sn_CR_SEND	;���� ������� ��������
	ld (S0_CR),a
wait_cr2
	ld a,(S0_CR)		;������� ���������� �������
	or a
	jr nz,wait_cr2
	
;--------------------
;������� ����� �� �������
;--------------------
	ld de,0
wait_pack0
	ld de,(S0_RX_RSR)	;������ ������ ������
	ld a,d
	or e				;���� �������, �� ��� ������
	jr z,wait_pack0
wait_pack1
	ld hl,(S0_RX_RSR)	;���, ������
	ex de,hl			;������ ��� ������������� ����
	xor a				;�������� ������ � ���� �� ��������, �� ������ ��� ��� ������
	sbc hl,de
	ld a,h
	or l
	jr nz,wait_pack1
;����� ������� ����� ���������, ���� ��� ��������
;�.�. � S0_RX_RSR ������ ������ ����, ��...

;--------------------
;������ ��������� �������� ������, ��� ����� � ������ ���� ������ ������ ������
;--------------------
	ld hl,(S0_RX_FAKE)
	ld b,l				;��������� ���������
	ld c,h
;--------------------
;������ �����, � de � ��� ����� ������ ������� ����(���������)
;--------------------
;���������� � ������ �������
	ld b,e
	ld c,d
	dec bc		;� �������� ������ ������ ���� � ������ ���� ������ ����,
	dec bc		;������� ������� ��� ������(������ ������ ������)
	ld hl,S0_RX_FAKE 
	ld de,buf_rx
loop_read
	ld l,0
	ld a,c
	or b
	jr z,end_read
	ldi
	ldi
	jr loop_read
end_read
	
	ld a,Sn_CR_RECV		;���� ����� ��� ����� �������
	ld (S0_CR),a
wait_cr3
	ld a,(S0_CR)		;������� ���������� �������
	or a
	jr nz,wait_cr3
	
;���� ��, ����� ��������� �����, �������� ���������, ����������. �� ��� ��� ����, � �������� ����������.
	
;--------------------
;������� ����������
;--------------------
	
	ld a,Sn_CR_CLOSE	;������� ����������
	ld (S0_CR),a	
	
;--------------------
;��, ������ �������.
;--------------------


	ld bc,768			;�� ����� �� ����������.
	ld hl,buf_rx+478	;��� ����� �������� ���������(����� ����������, ���� �������� ���� � �������������)
	ld de,0x5800		;� �������� ��� ���� ���������� HTTP �������
	ldir
	di
	halt

;������ ����(!!!��� �������� �������� ��� ����������� ����!!!)
mac	
	db 0x00,0x08,0xDC,0x01,0x02,0x03	;����� �� ����� ����, �� ���������� ����
reserved
	db 0x00,0x00	;��� ��� ����, ���� ����� ������ ��������
gateway
	db 192,168,0,1
mask
	db 255,255,255,0
ip
	db 192,168,0,77
	
;���������� ����
source_port dw 0

;http://zx.maros.pri.ee/file/id/15733/filename/Yerzmyey_-_Cat_42_%282009%29_%28_International_Vodka_Party_5%2C_4%29.atr	
get_str
	db "GET /file/id/15733/filename/Yerzmyey_-_Cat_42_%282009%29_%28_International_Vodka_Party_5%2C_4%29.atr HTTP/1.1",13,10
	db "Host: zx.maros.pri.ee",13,10
	db 13,10,0
get_str_end
buf_rx
	
ENDPROG
	SAVEHOB  "s1.$C","s1.C",START,ENDPROG-START
	SAVEBIN  "s1",START,ENDPROG-START
