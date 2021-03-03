# MiSTer-Scripts for MiSTer FPGA users<br>

## mra_sort_scan:<br>
![image](https://user-images.githubusercontent.com/45669411/109841961-96bd1c00-7c17-11eb-8c90-70a486edb3a0.png)

#### Q: why write mra_sort_scan ?<br>
 A: The official update_all tool does a lot of things really well and is essential to the MiSTer experience, but I wanted to explore a different approach that was both I/O and storage conscious. All sorting is accomplished by reading each source MRA file and creating a Symlink to the source MRA file from the corasponding sort by directory. This aproach reduces the overall storage consumption and disk I/O by not copying the same MRA file to each contextually sorted directory, which may also extend the life of an SD storage device which has a definitive number of write cycles. <br>
 #### Q: Why are some titles missing from the sorted lists ?<br>
 A: mra_sort_scan relies entirely on the tags employed in each respective MRA file. As there is little or no govornance on MRA creation we often find common tags such as <manufacturer> or <rbf> to be missing or characterized differently based on developer preferences.
 
 #### Q: Why does the Sort-By-Manufacturer directory look different than the formatting employed by update_all?
 A: 

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
