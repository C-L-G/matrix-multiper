/*******************************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________

--Module Name:
--Project Name:
--Chinese Description:
	
--English Description:
	
--Version:VERA.1.0.0
--Data modified:
--author:Young-ÎâÃ÷
--E-mail: wmy367@Gmail.com
--Data created:
________________________________________________________
********************************************************/
`timescale 1ns/1ps
module matrix_multiper #(
	parameter DSIZE	= 8			,
	parameter MSIZE	= 8
)(
	input				clock	,
	input [DSIZE-1:0]	iR      ,
	input [DSIZE-1:0]	iG      ,
	input [DSIZE-1:0]	iB      ,

	input [MSIZE-1:0]	M00  	,
	input [MSIZE-1:0]	M01     ,
	input [MSIZE-1:0]	M02     ,
	input [MSIZE-1:0]	M10     ,
	input [MSIZE-1:0]	M11     ,
	input [MSIZE-1:0]	M12     ,
	input [MSIZE-1:0]	M20     ,
	input [MSIZE-1:0]	M21     ,
	input [MSIZE-1:0]	M22     ,
	
	output[DSIZE-1:0]	Ro 		,
	output[DSIZE-1:0]	Go      ,
	output[DSIZE-1:0]	Bo
);

/*
  Ro  = M00*iR + M01*iG + M02*iB
  Go  = M10*iR + M11*iG + M12*iB
  Bo  = M20*iR + M21*iG + M22*iB

*/
wire[MSIZE-2:0]		MM00	;
wire[MSIZE-2:0]		MM01    ;
wire[MSIZE-2:0]		MM02    ;
wire[MSIZE-2:0]		MM10    ;
wire[MSIZE-2:0]		MM11    ;
wire[MSIZE-2:0]		MM12    ;
wire[MSIZE-2:0]		MM20    ;
wire[MSIZE-2:0]		MM21    ;
wire[MSIZE-2:0]		MM22    ;

wire				SM00	; 
wire				SM01    ; 
wire				SM02    ; 
wire				SM10    ; 
wire				SM11    ; 
wire				SM12    ; 
wire				SM20    ; 
wire				SM21    ; 
wire				SM22    ;

assign		MM00	=  M00[MSIZE-2:0];	
assign		MM01    =  M01[MSIZE-2:0];
assign		MM02    =  M02[MSIZE-2:0];
assign		MM10    =  M10[MSIZE-2:0];
assign		MM11    =  M11[MSIZE-2:0];
assign		MM12    =  M12[MSIZE-2:0];
assign		MM20    =  M20[MSIZE-2:0];
assign		MM21    =  M21[MSIZE-2:0];
assign		MM22    =  M22[MSIZE-2:0];
 
assign		SM00	=  M00[MSIZE-1];
assign		SM01    =  M01[MSIZE-1];
assign		SM02    =  M02[MSIZE-1];
assign		SM10    =  M10[MSIZE-1];
assign		SM11    =  M11[MSIZE-1];
assign		SM12    =  M12[MSIZE-1];
assign		SM20    =  M20[MSIZE-1];
assign		SM21    =  M21[MSIZE-1];
assign		SM22    =  M22[MSIZE-1];

reg[DSIZE+MSIZE-2:0]		PMM00		;
reg[DSIZE+MSIZE-2:0]		PMM01    	;
reg[DSIZE+MSIZE-2:0]		PMM02    	;
reg[DSIZE+MSIZE-2:0]		PMM10    	;
reg[DSIZE+MSIZE-2:0]		PMM11    	;
reg[DSIZE+MSIZE-2:0]		PMM12    	;
reg[DSIZE+MSIZE-2:0]		PMM20    	;
reg[DSIZE+MSIZE-2:0]		PMM21    	;
reg[DSIZE+MSIZE-2:0]		PMM22    	;

reg							PSM00		;
reg							PSM01    	;
reg							PSM02    	;
reg							PSM10    	;
reg							PSM11    	;
reg							PSM12    	;
reg							PSM20    	;
reg							PSM21    	;
reg							PSM22    	;

  

always@(posedge clock)begin
	PMM00	<= MM00	 * iR	 ;
	PMM01	<= MM01  * iG    ;
	PMM02	<= MM02  * iB    ;
	PMM10	<= MM10  * iR    ;
	PMM11	<= MM11  * iG    ;
	PMM12	<= MM12  * iB    ;
	PMM20	<= MM20  * iR    ;
	PMM21	<= MM21  * iG    ;
	PMM22	<= MM22  * iB    ;
end

always@(posedge clock)begin
	PSM00	<= SM00	;
    PSM01	<= SM01 ;
    PSM02	<= SM02 ;
    PSM10	<= SM10 ;
    PSM11	<= SM11 ;
    PSM12	<= SM12 ;
    PSM20	<= SM20 ;
    PSM21	<= SM21 ;
    PSM22	<= SM22 ;
end

reg	[DSIZE+MSIZE+1:0]	BMM00		;
reg	[DSIZE+MSIZE+1:0]	BMM01       ;
reg	[DSIZE+MSIZE+1:0]	BMM02       ;
reg	[DSIZE+MSIZE+1:0]	BMM10       ;
reg	[DSIZE+MSIZE+1:0]	BMM11       ;
reg	[DSIZE+MSIZE+1:0]	BMM12       ;
reg	[DSIZE+MSIZE+1:0]	BMM20       ;
reg	[DSIZE+MSIZE+1:0]	BMM21       ;
reg	[DSIZE+MSIZE+1:0]	BMM22       ;

always@(posedge clock)begin
	BMM00	<= PSM00? (1<<(DSIZE+MSIZE+2)) - PMM00 : PMM00	; 
    BMM01	<= PSM01? (1<<(DSIZE+MSIZE+2)) - PMM01 : PMM01	;
    BMM02	<= PSM02? (1<<(DSIZE+MSIZE+2)) - PMM02 : PMM02	;
    BMM10	<= PSM10? (1<<(DSIZE+MSIZE+2)) - PMM10 : PMM10	;
    BMM11	<= PSM11? (1<<(DSIZE+MSIZE+2)) - PMM11 : PMM11	;
    BMM12	<= PSM12? (1<<(DSIZE+MSIZE+2)) - PMM12 : PMM12	;
    BMM20	<= PSM20? (1<<(DSIZE+MSIZE+2)) - PMM20 : PMM20	;
    BMM21	<= PSM21? (1<<(DSIZE+MSIZE+2)) - PMM21 : PMM21	;
    BMM22	<= PSM22? (1<<(DSIZE+MSIZE+2)) - PMM22 : PMM22	;
end

reg	[DSIZE+MSIZE+1:0]	ADD_00_01		;
reg	[DSIZE+MSIZE+1:0]	ADD_02       ;
reg	[DSIZE+MSIZE+1:0]	ADD_10_11       ;
reg	[DSIZE+MSIZE+1:0]	ADD_12       ;
reg	[DSIZE+MSIZE+1:0]	ADD_20_21       ;
reg	[DSIZE+MSIZE+1:0]	ADD_22       ;  

always@(posedge clock)begin
	ADD_00_01	<= BMM00 + BMM01	;
	ADD_10_11	<= BMM10 + BMM11	;
	ADD_20_21	<= BMM20 + BMM21	; 
end

always@(posedge clock)begin
	ADD_02		<= BMM02;
	ADD_12		<= BMM12;
	ADD_22		<= BMM22;
end

reg	[DSIZE+MSIZE+1:0]	ADD_00_01_02;
reg	[DSIZE+MSIZE+1:0]	ADD_10_11_12;
reg	[DSIZE+MSIZE+1:0]	ADD_20_21_22; 

always@(posedge clock)begin
	ADD_00_01_02	<=	ADD_00_01 + ADD_02	;
    ADD_10_11_12	<=	ADD_10_11 + ADD_12	;
    ADD_20_21_22	<=	ADD_20_21 + ADD_22	;
end

assign	Ro	= ADD_00_01_02[DSIZE+MSIZE+1-:DSIZE]	;	
assign	Go	= ADD_10_11_12[DSIZE+MSIZE+1-:DSIZE]	;
assign	Bo	= ADD_20_21_22[DSIZE+MSIZE+1-:DSIZE]	;

endmodule

