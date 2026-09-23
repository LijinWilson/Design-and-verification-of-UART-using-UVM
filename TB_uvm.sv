`include "uvm_macros.svh"
import uvm_pkg::*;

//configuration of env
// this will decide whether the agent is active or passive
class uart_config extends uvm_object;
  `uvm_object_utils(uart_config)

  function new(string name="uart_config");
    super.new(name);
  endfunction

  uvm_active_passive_enum is_active=UVM_ACTIVE; // making agent active.
endclass

////////////////////////////////////////////////////////
// different test scenarios
typedef enum bit[3:0] {
  rand_baud_1_stop=0,
  rand_length_1_stop=1,
  length5wp=2, //length 5 with parity
  length6wp=3,
  length7wp=4,
  length8wp=5,
  length5wop=6,//length 5 without parity
  length6wop=7,
  length7wop=8,
  length8wop=9,
  rand_baud_2_stop=11,
  rand_length_2_stop=12
}oper_mode;

//transaction class
class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)

  rand oper_mode op;
  logic tx_start,rx_start;
  logic rst;
  rand logic[7:0] tx_data;
  rand logic[16:0] baud;
  rand logic [3:0] length;
  rand logic parity_type, parity_en;
  logic stop2;
  logic tx_done,rx_done,tx_err,rx_err;
  logic [7:0] rx_out;

  constraint baud_c{
    baud inside{4800,9600,14400,19200,38400,57600};
  }
  
  constraint length_c{
    length inside{5,6,7,8};
  }
  
  function new(string name ="transaction");
    super.new(name);
  endfunction
endclass:transaction

//////////////////////////////////////////////////////// MAKING DIFFERENT SEQUENCES FOR DIFFERENT TEST CASES ////////////////////////////////////
// SEQUENCE 1 - random baud; fixed length = 8; parity enable; parity type:random ; single stop

class rand_baud extends uvm_sequence#(transaction);
  `uvm_object_utils(rand_baud)

  transaction tr;

  function new(string name="rand_baud");
    super.new(name);
  endfunction

  virtual task body();
    repeat(5)
      begin
        tr=transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op=rand_baud_1_stop;
        tr.length=8;
        tr.baud=9600;
        tr.rst=1'b0;
        tr.tx_start=1'b1;
        tr.rx_start=1'b1;
        tr.parity_en=1'b1;
        tr.stop2=1'b0;
        finish_item(tr);
      end
  endtask
  
endclass

// SEQUENCE -  2: random baud ; fixed length = 8; parity enable; parity type:random; two stop
class rand_baud_with_stop extends uvm_sequence#(transaction);
  `uvm_object_utils(rand_baud_with_stop)
  
  transaction tr;
  
  function new(string name="rand_baud_with_stop");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        tr=transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op=rand_baud_2_stop;
        tr.rst=1'b0;
        tr.length=8;
        tr.tx_start=1'b1;
        tr.rx_start=1'b1;
        tr.parity_en=1'b1;
        tr.stop2=1'b1;
        finish_item(tr);
      end
  endtask
endclass

// SEQUENCE - 3 fixed length = 5-variable baud-with parity
class rand_baud_len5p extends uvm_sequence#(transaction);
  
  `uvm_object_utils(rand_baud_len5p)
  transaction tr;
  
  function new(string name = "rand_baud_len5p");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        tr=transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op=lenght5wp;
        tr.rst=1'b0;
        tr.tx_data={3'b000,tr.tx_data[7:3]};
        tr.length=5;
        tr.tx_start=1'b1;
        tr.rx_start=1'b1;
        tr.parity_en=1'b1;
        tr.stop2=1'b0;
        finish_item(tr);
      end
  endtask
endclass

// SEQUENCE - 4 fixed length=6; variable baud; with parity

class rand_baud_len6p extends uvm_sequence#(transaction);
  `uvm_object_utils(rand_baud_len6p)
  
  transaction tr;
  
  function new(string name ="rand_baud_len6p");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        tr=transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op=length6wp;
        tr.rst=1'b0;
        tr.length=6;
        tr.tx_data={2'b00,tr.tx_data[7:2]};
        tr.tx_start=1'b1;
        tr.rx_start=1'b1;
        tr.parity_en=1'b1;
        tr.stop2=1'b0;
        finish_item(tr);
      end
  endtask
  
endclass

tr.parity_en=1'b1;
        tr.stop2=1'b0;
        finish_item(tr);
      end
  endtask
  
endclass

// SEQUENCE - 5 fixed length=7; variable baud; with parity

class rand_baud_len7p extends uvm_sequence#(transaction);
  `uvm_object_utils(rand_baud_len7p)
  
  transaction tr;
  
  function new(string name="rand_baud_len7p");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        tr=transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op=length7wp;
        tr.rst=1'b0;
        tr.length=7;
        tr.tx_data={1'b0,tr.tx_data[7:1]};
        tr.tx_start=1'b1;
        tr.rx_start=1'b1;
        tr.parity_en=1'b1;
        tr.stop2=1'b0;
        finish_item(tr);
      end
  endtask
endclass

Code snippet
        tr.tx_start=1'b1;
        tr.rx_start=1'b1;
        tr.parity_en=1'b1;
        tr.stop2=1'b0;
        finish_item(tr);
      end
  endtask
endclass

// SEQUENCE - 6 fixed length=8; variable baud; with parity

class rand_baud_len8p extends uvm_sequence#(transaction);
  `uvm_object_utils(rand_baud_len8p)
  
  transaction tr;
  
  function new(string name="rand_baud_len8p");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        tr=transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op = length8wp;
        tr.rst = 1'b0;
        tr.length = 8;
        tr.tx_data = tr.tx_data[7:0];
        tr.tx_start = 1'b1;
        tr.rx_start = 1'b1;
        tr.parity_en = 1'b1;
        tr.stop2 = 1'b0;
        finish_item(tr);
      end
  endtask
endclass

Code snippet
        tr.parity_en = 1'b1;
        tr.stop2     = 1'b0;
        finish_item(tr);
      end
  endtask
endclass

// SEQUENCE - 7 fixed lenght=5; variable baud; withpout parity

class rand_baud_len5 extends uvm_sequence#(transaction);
  `uvm_object_utils(rand_baud_len5);
  
  transaction tr;
  
  function new(string name="rand_baud_len5");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        tr=transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op=length5wop;
        tr.rst=1'b0;
        tr.length=5;
        tr.tx_data={3'b000,tr.tx_data[7:3]};
        tr.tx_start=1'b1;
        tr.rx_start=1'b1;
        tr.parity_en=1'b0;
        tr.stop2=1'b0;
        finish_item(tr);
      end
  endtask
endclass

// SEQUENCE - 8 fixed length=6; variable baud; without parity

class rand_baud_len6 extends uvm_sequence#(transaction);
  `uvm_object_utils(rand_baud_len6);
  
  transaction tr;
  
  function new(string name="rand_baud_len6");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        tr=transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op=length6wop;
        tr.rst=1'b0;
        tr.length=6;
        tr.tx_data={2'b00,tr.tx_data[7:2]};
        tr.tx_start=1'b1;
        tr.rx_start=1'b1;
        tr.parity_en=1'b0;
        tr.stop2=1'b0;
        finish_item(tr);
      end
  endtask
endclass

Code snippet
        tr.tx_start=1'b1;
        tr.rx_start=1'b1;
        tr.parity_en=1'b0;
        tr.stop2=1'b0;
        finish_item(tr);
      end
  endtask
endclass

// SEQUENCE - 9 fixed length=7; variable baud; without parity

class rand_baud_len7 extends uvm_sequence#(transaction);
  `uvm_object_utils(rand_baud_len7);
  transaction tr;
  function new(string name="rand_baud_len7");
    super.new(name);
  endfunction

  virtual task body();
    repeat(5)
      begin
        tr=transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op=length7wop;
        tr.rst=1'b0;
        tr.length=7;
        tr.tx_data={1'b0,tr.tx_data[7:1]};
        tr.tx_start=1'b1;
        tr.rx_start=1'b1;
        tr.parity_en=1'b0;
        tr.stop2=1'b0;
        finish_item(tr);
      end
  endtask
endclass

Code snippet
        tr.parity_en=1'b0;
        tr.stop2=1'b0;
        finish_item(tr);
      end
  endtask
endclass

// SEQUENCE - 10  fixed length=8; variable baud; without parity

class rand_baud_len8 extends uvm_sequence#(transaction);
  `uvm_object_utils(rand_baud_len8);
  transaction tr;

  function new(string name="rand_baud_len8");
    super.new(name);
  endfunction

  virtual task body();
    repeat(5)
      begin
        tr=transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op=length8wop;
        tr.rst=1'b0;
        tr.length=8;
        tr.tx_data=tr.tx_data[7:0];
        tr.tx_start=1'b1;
        tr.rx_start=1'b1;
        tr.parity_en=1'b0;
        tr.stop2=1'b0;
        finish_item(tr);
      end
  endtask
endclass

Code snippet
// =========================================================== driver class ===========================================================

class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver);

  virtual uart_if vif;
  transaction tr;

  function new(input string path="drv", uvm_component parent=null);
    super.new(path,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr=transaction::type_id::create("tr");
    
    if(!uvm_config_db#(virtual uart_if)::get(this,"","vif",vif))
      `uvm_error("drv","unable to access interface");
  endfunction
  
  task reset_dut();
    repeat(5)
    begin
      vif.rst<=1'b1;
      vif.tx_start<=1'b0;
      vif.rx_start<=1'b0;
      vif.tx_data<=8'h00;
      vif.baud<=16'h0;
      vif.length<=4'h0;
      vif.parity_type<=1'b0;
      vif.parity_en<=1'b0;
      vif.stop2<=1'b0;
      `uvm_info("DRV","System reset:Start of simulation", UVM_MEDIUM);
      @(posedge vif.clk);
    end
  endtask
  
  task drive();
        reset_dut();
        forever begin
          seq_item_port.get_next_item(tr); // WAITING FOR ITEM TO GET FROM SEQUENCER
          
          vif.rst<=1'b0;
          vif.tx_start<=tr.tx_start;
          vif.rx_start<=tr.rx_start;
          vif.tx_data<=tr.tx_data;
          vif.baud<=tr.baud;
          vif.length<=tr.length;
          vif.parity_type<=tr.parity_type;
          vif.parity_en<=tr.parity_en;
          vif.stop2<=tr.stop2;
          
          `uvm_info("DRV", $sformatf("Baud:%0d LEN:%0d PAR_T:%0d PAR_EN:%0d STOP:%0d TX_DATA:%0d", tr.baud,tr.length,tr.parity_type,tr.parity_en,tr.stop2,tr.tx_data), UVM_NONE);
          @(posedge vif.clk);
          @(posedge vif.tx_done); // WAITING FOR TX DONE TO BECOME HIGH
          
          @(negedge vif.rx_done); // WAITING FOR RX DONE TO HIGH
          seq_item_port.item_done();
          
        end
      endtask
      
      virtual task run_phase(uvm_phase phase);
        drive();
      endtask
      
    endclass

// =========================================================== Monitor ===========================================================
    
class mon extends uvm_monitor;
  `uvm_component_utils(mon);
  
  uvm_analysis_port#(transaction) send;
  transaction tr;
  virtual uart_if vif;
  
  function new(input string inst="mon", uvm_component parent=null);
    super.new(inst,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr=transaction::type_id::create("tr");
    send=new("send",this);
    if(!uvm_config_db#(virtual uart_if)::get(this,"","vif",vif))
      `uvm_error("MON","unable to access interface");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk);
      if(vif.rst)
        begin
          tr.rst=1'b1;
          `uvm_info("MON","System Reset Detected ",UVM_NONE);
          send.write(tr);
        end
      else
        begin
          @(posedge vif.tx_done);
          tr.rst=1'b0;
          tr.tx_start=vif.tx_start;
          tr.rx_start=vif.rx_start;
          tr.tx_data=vif.tx_data;
          tr.baud=vif.baud;
          tr.length=vif.length;
          tr.parity_type=vif.parity_type;
          tr.parity_en=vif.parity_en;
          tr.stop2=vif.stop2;
          @(negedge vif.rx_done);
          tr.rx_out=vif.rx_out;
          tr.rx_out=vif.rx_out;
          
          `uvm_info("MON", $sformatf("BAUD:%0d LEN:%0d PAR_T:%0d PAR_EN:%0d STOP:%0d TX_DATA:%0d RX_DATA:%0d", tr.baud, tr.length, tr.parity_type, tr.parity_en, tr.stop2, tr.tx_data, tr.rx_out), UVM_NONE);
          
          send.write(tr); // SENDING TO SCOREBOARD
        end
      end
  endtask
endclass


// ================================================================= scoreboard =================================================================
class sco extends uvm_scoreboard;
  `uvm_component_utils(sco)
  
  uvm_analysis_imp#(transaction,sco) recv;
  bit [31:0] arr[32] = '{default:0};
  bit [31:0] addr=0;
  bit [31:0] data_rd=0;
  
  function new(input string inst ="sco", uvm_component parent=null);
    super.new(inst,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv=new("recv",this);
  endfunction
  
  virtual function void write(transaction tr);
    
    `uvm_info("SCO", $sformatf("BAUD:%0d LEN:%0d PAR_T:%0d PAR_EN:%0d STOP:%0d TX_DATA:%0d RX_DATA:%0d", tr.baud, tr.length, tr.parity_type, tr.parity_en, tr.stop2, tr.tx_data, tr.rx_out), UVM_NONE);
    
    if(tr.rst == 1'b1)
      `uvm_info("SCO", "System Reset", UVM_NONE)
    else if(tr.tx_data == tr.rx_out)
      `uvm_info("SCO", "Test Passed", UVM_NONE)
    else
      `uvm_info("SCO", "Test Failed", UVM_NONE)
      $display("......................................");
  endfunction
  
endclass

// ============================================================================ AGENT ============================================================================
Code snippet
endclass

//////////////////////////////////////////////////////// AGENT

class agent extends uvm_agent;
  `uvm_component_utils(agent)
  uart_config cfg;
  
  function new(input string inst ="agent", uvm_component parent=null);
    super.new(inst,parent);
  endfunction
  
  //sequencer+driver+monitor
  driver d;
  uvm_sequencer#(transaction) seqr;
  mon m;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg=uart_config::type_id::create("cfg");
    m=mon::type_id::create("m",this);
    
    if(cfg.is_active==UVM_ACTIVE)
      begin
        d=driver::type_id::create("d",this);
        seqr=uvm_sequencer#(transaction)::type_id::create("seqr",this);
      end
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(cfg.is_active==UVM_ACTIVE) begin
      d.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction
endclass

// ========================================================================= ENVIRONMENT =========================================================================
class env extends uvm_env;
  `uvm_component_utils(env)
  
  function new(input string inst="env", uvm_component c);
    super.new(inst,c);
  endfunction
  
  agent a;
  sco s;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a=agent::type_id::create("a",this);
    s=sco::type_id::create("s",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    a.m.send.connect(s.recv);
  endfunction
endclass

// ================================================================== TEST CLASS ==================================================================

class test extends uvm_test;
  `uvm_component_utils(test);
  
  function new(input string inst="test", uvm_component c);
    super.new(inst,c);
  endfunction
  
  env e;
  rand_baud rb;
  rand_baud_with_stop rbs;
  rand_baud_len5p rb51;
  rand_baud_len6p rb61;
  rand_baud_len7p rb71;
  rand_baud_len8p rb81;
  
////////////////////////////////////////////////////////

  rand_baud_len5 rb51wop;
  rand_baud_len6 rb61wop;
  rand_baud_len7 rb71wop;
  rand_baud_len8 rb81wop;
  

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e=env::type_id::create("env",this);
    rb=rand_baud::type_id::create("rb");
    rbs=rand_baud_with_stop::type_id::create("rbs");

//////////////////////////////////////////////////////// fixed length var baud with parity

    rb51=rand_baud_len5p::type_id::create("rb51");
    rb61=rand_baud_len6p::type_id::create("rb61");
    rb71=rand_baud_len7p::type_id::create("rb71");
    rb81=rand_baud_len8p::type_id::create("rb81");

//////////////////////////////////////////////////////// fixed len var baud without parity

    rb51wop=rand_baud_len5::type_id::create("rb51wop");
    rb61wop=rand_baud_len6::type_id::create("rb61wop");
    rb71wop=rand_baud_len7::type_id::create("rb71wop");
    rb81wop=rand_baud_len8::type_id::create("eb81wop");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    rb81wop.start(e.a.seqr); // CHANGE "rb81wop" sequence with another sequence for another test.
    #20;
    phase.drop_objection(this);
  endtask
endclass

// ======================================================================= TEST BENCH MODULE ==========================================================================

module tb;
  uart_if vif();
  
  uart_top dut(
    .clk(vif.clk),
    .rst(vif.rst),
    .tx_start(vif.tx_start),
    .rx_start(vif.rx_start),
    .tx_data(vif.tx_data),
    .baud(vif.baud),
    .length(vif.length),
    .parity_type(vif.parity_type),
    .parity_en(vif.parity_en),
    .stop2(vif.stop2),
    .tx_done(vif.tx_done),
    .rx_done(vif.rx_done),
    .tx_err(vif.tx_err),
    .rx_err(vif.rx_err),
    .rx_out(vif.rx_out)
  );
  
  initial begin
    vif.clk<=0;
  end
  
  always #10 vif.clk<=~vif.clk;
  
  initial begin
    uvm_config_db#(virtual uart_if)::set(null,"*","vif",vif);
    run_test("test");
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule

// ============================================================== OUTPUT ==============================================================
# KERNEL: UVM_INFO /home/runner/testbench.sv(437) @ 70000: uvm_test_top.env.a.m [MON] System Reset Detected
# KERNEL: UVM_INFO /home/runner/testbench.sv(506) @ 70000: uvm_test_top.env.s [SCO] BAUD:x LEN:x PAR_T:x PAR_EN:x STOP:x TX_DATA:x RX_DATA:x
# KERNEL: UVM_INFO /home/runner/testbench.sv(509) @ 70000: uvm_test_top.env.s [SCO] System Reset
# KERNEL: ......................................
# KERNEL: UVM_INFO /home/runner/testbench.sv(393) @ 70000: uvm_test_top.env.a.d [DRV] System reset:Start of simulation
# KERNEL: UVM_INFO /home/runner/testbench.sv(437) @ 90000: uvm_test_top.env.a.m [MON] System Reset Detected
# KERNEL: UVM_INFO /home/runner/testbench.sv(506) @ 90000: uvm_test_top.env.s [SCO] BAUD:x LEN:x PAR_T:x PAR_EN:x STOP:x TX_DATA:x RX_DATA:x
# KERNEL: UVM_INFO /home/runner/testbench.sv(509) @ 90000: uvm_test_top.env.s [SCO] System Reset
# KERNEL: ......................................
# KERNEL: UVM_INFO /home/runner/testbench.sv(413) @ 90000: uvm_test_top.env.a.d [DRV] Baud:38400 LEN:8 PAR_T:0 PAR_EN:0 STOP:0 TX_DATA:76
# KERNEL: UVM_INFO /home/runner/testbench.sv(476) @ 562830000: uvm_test_top.env.a.m [MON] BAUD:38400 LEN:8 PAR_T:0 PAR_EN:0 STOP:0 TX_DATA:76 RX_DATA:76
# KERNEL: UVM_INFO /home/runner/testbench.sv(506) @ 562830000: uvm_test_top.env.s [SCO] BAUD:38400 LEN:8 PAR_T:0 PAR_EN:0 STOP:0 TX_DATA:76 RX_DATA:76
# KERNEL: UVM_INFO /home/runner/testbench.sv(511) @ 562830000: uvm_test_top.env.s [SCO] Test Passed
# KERNEL: ......................................
# KERNEL: UVM_INFO /home/runner/testbench.sv(413) @ 562830000: uvm_test_top.env.a.d [DRV] Baud:9600 LEN:8 PAR_T:1 PAR_EN:0 STOP:0 TX_DATA:71
# KERNEL: UVM_INFO /home/runner/testbench.sv(476) @ 5781750000: uvm_test_top.env.a.m [MON] BAUD:9600 LEN:8 PAR_T:1 PAR_EN:0 STOP:0 TX_DATA:71 RX_DATA:71
# KERNEL: UVM_INFO /home/runner/testbench.sv(506) @ 5781750000: uvm_test_top.env.s [SCO] BAUD:9600 LEN:8 PAR_T:1 PAR_EN:0 STOP:0 TX_DATA:71 RX_DATA:71
# KERNEL: UVM_INFO /home/runner/testbench.sv(511) @ 5781750000: uvm_test_top.env.s [SCO] Test Passed
# KERNEL: ......................................
# KERNEL: UVM_INFO /home/runner/testbench.sv(413) @ 5781750000: uvm_test_top.env.a.d [DRV] Baud:57600 LEN:8 PAR_T:1 PAR_EN:0 STOP:0 TX_DATA:91
# KERNEL: UVM_INFO /home/runner/testbench.sv(476) @ 6229750000: uvm_test_top.env.a.m [MON] BAUD:57600 LEN:8 PAR_T:1 PAR_EN:0 STOP:0 TX_DATA:91 RX_DATA:91
# KERNEL: UVM_INFO /home/runner/testbench.sv(506) @ 6229750000: uvm_test_top.env.s [SCO] BAUD:57600 LEN:8 PAR_T:1 PAR_EN:0 STOP:0 TX_DATA:91 RX_DATA:91
# KERNEL: UVM_INFO /home/runner/testbench.sv(511) @ 6229750000: uvm_test_top.env.s [SCO] Test Passed
# KERNEL: ......................................
# KERNEL: UVM_INFO /home/runner/testbench.sv(413) @ 6229750000: uvm_test_top.env.a.d [DRV] Baud:14400 LEN:8 PAR_T:0 PAR_EN:0 STOP:0 TX_DATA:36
# KERNEL: UVM_INFO /home/runner/testbench.sv(476) @ 8051830000: uvm_test_top.env.a.m [MON] BAUD:14400 LEN:8 PAR_T:0 PAR_EN:0 STOP:0 TX_DATA:36 RX_DATA:36
# KERNEL: UVM_INFO /home/runner/testbench.sv(506) @ 8051830000: uvm_test_top.env.s [SCO] BAUD:14400 LEN:8 PAR_T:0 PAR_EN:0 STOP:0 TX_DATA:36 RX_DATA:36
# KERNEL: UVM_INFO /home/runner/testbench.sv(511) @ 8051830000: uvm_test_top.env.s [SCO] Test Passed
# KERNEL: ......................................
# KERNEL: UVM_INFO /home/runner/testbench.sv(413) @ 8051830000: uvm_test_top.env.a.d [DRV] Baud:9600 LEN:8 PAR_T:0 PAR_EN:0 STOP:0 TX_DATA:8
# KERNEL: UVM_INFO /home/runner/testbench.sv(476) @ 10550110000: uvm_test_top.env.a.m [MON] BAUD:9600 LEN:8 PAR_T:0 PAR_EN:0 STOP:0 TX_DATA:8 RX_DATA:8
# KERNEL: UVM_INFO /home/runner/testbench.sv(506) @ 10550110000: uvm_test_top.env.s [SCO] BAUD:9600 LEN:8 PAR_T:0 PAR_EN:0 STOP:0 TX_DATA:8 RX_DATA:8
# KERNEL: UVM_INFO /home/runner/testbench.sv(511) @ 10550110000: uvm_test_top.env.s [SCO] Test Passed
# KERNEL: ......................................
# KERNEL: UVM_INFO /home/build/vlib1/vlib/uvm-1.2/src/base/uvm_objection.svh(1271) @ 10550130000: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
# KERNEL: UVM_INFO /home/build/vlib1/vlib/uvm-1.2/src/base/uvm_report_server.svh(869) @ 10550130000: reporter [UVM/REPORT/SERVER]
# KERNEL: --- UVM Report Summary ---
