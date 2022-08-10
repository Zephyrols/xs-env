set -x
set -e

# Build XiangShan
cd XiangShan
rm -rf build
make verilog
rm -f build/tsmc28_sram.v.conf
rm -f build/tsmc28_sram.v
cd ..

# Build FPGA
cp -r ~/resource/scripts_v2 .
cp ~/XSTop_wrapper.v scripts_v2/src/rtl/XSTop_wrapper.v
cd scripts_v2
make update_core_flist CORE_DIR=$NOOP_HOME/build
make nanhu CORE_DIR=$NOOP_HOME/build
make bitstream CORE_DIR=$NOOP_HOME/build

echo ""
echo "Please wait for xs_nanhu/xs_nanhu.runs/impl_1/runme.log"
echo "MUST check whether it says write_bitstream completed successfully"
echo "Then the bit is generated correctly."
echo "This step may take more than 15 hours."

