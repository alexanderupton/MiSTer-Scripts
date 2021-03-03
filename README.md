# MiSTer-Scripts
# Scripts for MiSTer FPGA users<br>

## mra_sort_scan:<br>
![image](https://user-images.githubusercontent.com/45669411/109841961-96bd1c00-7c17-11eb-8c90-70a486edb3a0.png)

 Q: why write mra_sort_scan ?<br>
 A: The official update_all tool does a lot of things really well, but I wanted to explore a different approach that was both I/O and storage conscious.<br>

<pre>
mra_sort_scan <option> <switch>
options:
   -bc : Create Sort-By-Core Directory Structure
   -bm : Create Sort-By-Manufacturer Directory Structure
   -by : Create Sort-By-Year Directory Structure
   -bp : Create Sort-By-Platform Directory Structure
   -mr : Create Last 25 Arcade MRA Updates Directory Structure
       : Passing a number overides the default 25

switches:
     -v : verbose output

example:
     ./mra_sort_scan -mr 35
</pre>
