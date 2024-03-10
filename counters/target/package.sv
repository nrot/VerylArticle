package hello_PackageRoot;
    typedef struct packed {
        logic a;
    } StructA;
    localparam int unsigned             WIDTH = 16;
    function automatic void sum(
        input  logic        [WIDTH-1:0] a    ,
        output logic        [WIDTH-1:0] b    
    ) ;
        b     = a + b;
    endfunction
endpackage
