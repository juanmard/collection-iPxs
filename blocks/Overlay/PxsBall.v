//////////////////////////////////////////////////////////////////////////////////
// Company: University of Alicante
// Engineer: Sergio Cuenca
// 
// Create Date: 03/11/2017 
// Module Name: PxsBall
// Description: Draw a ball overlay.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
//
// Additional Comments: based on PixelStream lib from Celoxica Ltd.
//
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------
`include "Pxs.vh"

module PxsBall
#(
    parameter SIZE_BALL = 16,
    parameter color = 3'b111
)
(
    input wire        px_clk,       // Pixel clock.
    input wire [25:0] RGBStr_i,     // RGB input stream.
    input wire [9:0]  x_ball,       // X ball position.
    input wire [9:0]  y_ball,       // Y ball position.
    output reg [25:0] RGBStr_o      // RGB output stream.
);

always @(posedge px_clk)
begin
        // Clone VGA stream in a RGB stream.
        RGBStr_o[`VGA] <= RGBStr_i[`VGA];

        // Draw ball.
        if (RGBStr_i[`Active])
            begin
                RGBStr_o[`RGB] <= (
                       (RGBStr_i[`YC] > y_ball) && (RGBStr_i[`YC] < y_ball+SIZE_BALL) &&
                       (RGBStr_i[`XC] > x_ball) && (RGBStr_i[`XC] < x_ball+SIZE_BALL)
                     ) ? color : RGBStr_i[`RGB];
            end
        else
            RGBStr_o[`RGB] <= 3'b000;
end

endmodule
