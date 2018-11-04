// Code your testbench here
// or browse Examples
/**********************************************************************************
 * Module	: I2C_master_TB.v
 * Description	: I2C master controller
 * Date		: 11/09/2018
 * Author	: Srinivas
 * *******************************************************************************/

module i2c_master_TB();

  //SIGNAL DECLARATIONS
  wire i2c_scl_inout;
  wire  i2c_sda_inout;
  reg [6:0]addr;
  reg [7:0]data;
  reg clk_in;
  reg rst_in;
  reg start;
  wire ready_out;
  reg read_write;
  wire read_value;
  reg sda_en;
  reg sda_in;

  //INSTANTIATION
  i2c_master master(
                    .i2c_scl_inout      (i2c_scl_inout),
                    .i2c_sda_inout      (i2c_sda_inout),
                    .addr               (addr),
                    .data               (data),
                    .clk_in             (clk_in),
                    .rst_in             (rst_in),
                    .start              (start),
                    .ready_out          (ready_out),
                    .read_write         (read_write)
	           );

  //INITIALIZATION BLOCK
  initial begin
  //  i2c_sda_inout = 'b0;
    addr  	  = 'b1010101;
    data	  = 'b11111111;
    clk_in	  = 'b0;
    rst_in	  = 'b0;
	//valid     = 'b1;
  end

  //CLOCKING BLOCK
  always #10 clk_in = !clk_in;

  //RESET BLOCK
  initial begin
    repeat(1) @(posedge clk_in)
      rst_in = 'b1;

    repeat(2) @(posedge clk_in)
      rst_in = 'b0;
  end

  //ASSIGNMENTS
   //assign read_vlaue = (valid) ? i2c_sda_inout : 'hz;
  assign read_value = (!sda_en) ?sda_in : 'hz ;
  //assign i2c_sda_inout  = ack;

  //STIMULUS BLOCK
  initial begin
      read_write = 'b0;
      #230  sda_en = 'b0; //ack = 'b0;	
	  	  
		   
     //       ack  = 'b0;
	 // #250  sda_en = 'b1;			
     /* #250
			i2c_sda_inout  = 'b1;
			i2c_sda_inout  = 'b0;
			i2c_sda_inout  = 'b0;
			i2c_sda_inout  = 'b1;
			i2c_sda_inout  = 'b0;
			i2c_sda_inout  = 'b1;
			i2c_sda_inout  = 'b1;
	        i2c_sda_inout  = 'b0;
    $monitor($time,"SDA = %b",i2c_sda_inout);*/
$monitor($time,"\tsda line when read = %b",read_value);
    sda_in  = 'b0;
    #500 $finish;
  end

endmodule

