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
module matrix_multiper_tb;

wire		clk_50M;       
                           
clock_rst clk_rst_inst(    
	.clock		(clk_50M), 
	.rst		()         
);  

defparam clk_rst_inst.ACTIVE = 0;
initial begin:INITIAL_CLOCK
	clk_rst_inst.run(10 , 1000/50 ,0);
end

localparam	DSIZE	= 8,
			MSIZE	= 9;


logic[DSIZE-1:0]	iR		;
logic[DSIZE-1:0]	iG      ;
logic[DSIZE-1:0]	iB      ;
logic[DSIZE-1:0]	Ro      ;
logic[DSIZE-1:0]	Go      ;
logic[DSIZE-1:0]	Bo      ; 

logic[MSIZE-1:0]	M00  	;
logic[MSIZE-1:0]	M01     ;
logic[MSIZE-1:0]	M02     ;
logic[MSIZE-1:0]	M10     ;
logic[MSIZE-1:0]	M11     ;
logic[MSIZE-1:0]	M12     ;
logic[MSIZE-1:0]	M20     ;
logic[MSIZE-1:0]	M21     ;
logic[MSIZE-1:0]	M22     ;

 


always@(posedge clk_50M)begin
	iR		<= 255    ;          
    iG		<= 255    ;
    iB		<= 255    ;
end

always@(posedge clk_50M)begin
	 M00	<= $urandom_range(0,511);
     M01	<= $urandom_range(0,511);
     M02	<= $urandom_range(0,511);
     M10	<= $urandom_range(0,511);
     M11	<= $urandom_range(0,511);
     M12	<= $urandom_range(0,511);
     M20	<= $urandom_range(0,511);
     M21	<= $urandom_range(0,511);
     M22	<= $urandom_range(0,511);

end

integer		SM00  	; 
integer		SM01    ; 
integer		SM02    ; 
integer		SM10    ; 
integer		SM11    ; 
integer		SM12    ; 
integer		SM20    ; 
integer		SM21    ; 
integer		SM22    ; 

assign	SM00	= M00[MSIZE-1]? - M00[MSIZE-2:0] : M00[MSIZE-2:0];
assign	SM01	= M01[MSIZE-1]? - M01[MSIZE-2:0] : M01[MSIZE-2:0];
assign	SM02	= M02[MSIZE-1]? - M02[MSIZE-2:0] : M02[MSIZE-2:0];
assign	SM10	= M10[MSIZE-1]? - M10[MSIZE-2:0] : M10[MSIZE-2:0];
assign	SM11	= M11[MSIZE-1]? - M11[MSIZE-2:0] : M11[MSIZE-2:0];
assign	SM12	= M12[MSIZE-1]? - M12[MSIZE-2:0] : M12[MSIZE-2:0];
assign	SM20	= M20[MSIZE-1]? - M20[MSIZE-2:0] : M20[MSIZE-2:0];
assign	SM21	= M21[MSIZE-1]? - M21[MSIZE-2:0] : M21[MSIZE-2:0];
assign	SM22	= M22[MSIZE-1]? - M22[MSIZE-2:0] : M22[MSIZE-2:0];

integer	REL0	;
integer	REL1	;
integer	REL2	; 

assign	REL0	= SM00*iR + SM01*iG + SM02*iB	;
assign	REL1	= SM10*iR + SM11*iG + SM12*iB   ;
assign	REL2	= SM20*iR + SM21*iG + SM22*iB   ;

matrix_multiper #(         
	.DSIZE		(DSIZE			),           
	.MSIZE		(MSIZE			)           
)matrix_multiper_inst(                                
	.clock		(clk_50M	),	
	.iR     	(iR         ),
	.iG     	(iG         ),
	.iB     	(iB         ),
            
	.M00		(M00 		), 	
	.M01        (M01        ),
	.M02        (M02        ),
	.M10        (M10        ),
	.M11        (M11        ),
	.M12        (M12        ),
	.M20        (M20        ),
	.M21        (M21        ),
	.M22        (M22        ),
	        
	.Ro 		(Ro			),	
	.Go         (Go         ),
	.Bo         (Bo         )
);                           

endmodule
     