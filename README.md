# MiSTer-Scripts for MiSTer FPGA users<br>

## mra_sort_scan:<br>
![image](https://user-images.githubusercontent.com/45669411/109841961-96bd1c00-7c17-11eb-8c90-70a486edb3a0.png)

#### Q: why write mra_sort_scan ?<br>
A: The official update_all tool does a lot of things really well and is essential to the MiSTer experience, but I wanted to explore a different approach that was both I/O and storage conscious. All sorting is accomplished by reading each source MRA file and creating a Symlink to the source MRA file from the corasponding sort by directory. This aproach reduces the overall storage consumption and disk I/O by not copying the same MRA file to each contextually sorted directory, which may also prevent the early demise of an SD storage device which has a definitive number of write cycles. <br>
 #### Q: Why are some titles missing from the sorted lists ?<br>
 A: mra_sort_scan relies entirely on the tags employed in each respective MRA file. As there is little or no governance on MRA file creation we often find common tags such as <-manufacturer->, <-year->, or <-rbf-> to be missing or characterized differently based on developer preferences. If these tags are not populated mra_sort_scan will not take any action.
 
 #### Q: How is the Sort-By-Manufacturer formatting different than the formatting employed by update_all?
 A: mra_sort_scan aims to reduce the artisnal clutter derived from the source MRA files where the same manufacturer may be tagged differently based on the license or other attributes. To avoid situiations where five different "Namco" manufacturer tags are used, mra_sort_scan uses a weak form of string matching to distil the list down to a single common value to be used as the defining parent manufacturer directory name. The current approach is far from perfect but can be simplified and possibly obsoleted as MRA manufacturer tags are standardized. 

 #### Q: How does the last 25 arcade MRA sorting work?
 A: currently mra_sort_scan sorts the _Arcade directory root by date and builds symlinks based on the last 25 MRA files added. The number 25 can be altered by passing a number switch to the -mr option. Future releases may enable support for recursive scanning to include alternatives and other mra sources.

 #### Q: What is this Sort-By-Platform directory structure?
 A: Sort-By-Platform is an attempt to address and bring light to the need for an arch or platform tag within the MRA file format. There are times where I would like to see what other titles exist for a common platform like the Sega System 1 architecture, or Capcom's CPS1. The architecture isn't always clear based on the core name chosen by the developer which is often a core based on an individual title. The current platform association scan is weak and limited by static values and will be enriched as more platform to title associations become clear, or a <-platform-> tag is added to the MRA file format.
 
 #### Q: When should mra_sort_scan be run?
 A: Whenever you want to update your Sort-By directory structure to reflect recent changes.
 
 #### Q: When does mra_sort_scan get updates?
 A: That depends on community interest and the rate which new core and MRA updates that bring structural changes are released.
 
<pre>
mra_sort_scan <option> <switch>
options:
   -bc : Create Sort-By-Core Directory Structure
   -bm : Create Sort-By-Manufacturer Directory Structure
   -by : Create Sort-By-Year Directory Structure
   -bp : Create Sort-By-Platform Directory Structure
   -mr : Create Last 25 Arcade Most Recent Updates Directory Structure
       : Passing a number overides the default 25

switches:
     -v : verbose output

example:
     ./mra_sort_scan -mr 35
</pre>
