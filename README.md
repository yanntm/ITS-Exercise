# ITS-Exercise

This exercise is designed to investigate how a symbolic encoding of a state space works.
We will use DDD to build the state space of some GAL models.

We will build models of the classic [tower of Hanoi problem](https://en.wikipedia.org/wiki/Tower_of_Hanoi): 
* we encode the state (current position of the rings)
* the legal moves or rules of the game (cannot move a ring if there is a smaller ring above it, cannot place a ring on top of a smaller ring)
* the goal of the game (move all rings from a given pole to another one)

Then we ask the solver its-reach to find a solution.

![Hanoi towers](https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Iterative_algorithm_solving_a_6_disks_Tower_of_Hanoi.gif/220px-Iterative_algorithm_solving_a_6_disks_Tower_of_Hanoi.gif) 


## Step 1 : Download and Install

Follow [these instructions to get ITS-Tools](https://lip6.github.io/ITSTools-web/eclipsestart.html)

Basically :
* Download Eclipse, we recommend selecting "Packages->Java Developper" for your platform so you get a plain archive instead of an installer.
* Go to "Help->Install new Software", add "https://lip6.github.io/ITSTools/" as update site, then select "All-in-one". Next/Accept/Finish/Restart.

## Step 2 : A model

### Getting started
Either create a new empty project or clone this repository.

To clone this repository into your eclipse.
* Go to Perspective->Git (button in top right corner)
* Copy this URL (so it is in the copy buffer) : https://github.com/yanntm/ITS-Exercise.git
* Click "Clone repo" in the browser on left
* Finish should work, if the url is in copy buffer it will fill itself.
* Explore the newly cloned project, right click the main folder and select "import project"
* Finish/ok should work

Otherwise,
* Create a "new->Project->General->Project".
* Import the hanoi model into your project :  download the raw file, "import->file system" it from eclipse or put it in the project folder and hit "File->Refresh" in Eclipse.

### Run the model-checker

Right-click a GAL file then "Run As...->ITS model check".

Inspect the degeneralized versions of the model in the "work/" folder. 
These versions without parameters are the models the command line tools use.

## Q1. Compare the two variants, explain how the two encodings differ.

Do both models generate the same Kripke structure / State space ?

## Q2. Model size

Increase or decrease the number of rings in the model.

How does the state space size evolve with respect to $N ?

How does the shortest solution path length evolve with $N ?

## Step 3 : State space encoding

Inspect the final state space representation as a DD : 
 * in the "Run As...->Run Configurations" menu, open the "reach" and activate the "export as dot file" flag.
 * after running the model-checking look in the work/ folder for a d3XXX.dot file. Because we did not use hierarchy, the other dot file (without d3 in front) is irrelevant.
 * run dot on it like this `dot -Tpdf file.dot -o file.pdf`
 * inspect the pdf for both versions of the model

## Q3. DD encoding

How can you explain the linear aspect of the state space of the "ring state" version ?
Is the compression efficient ?

How can you explain the multi line aspect of the state space of the "pole state" version ?
Is the compression efficient ?

To make things more interesting, in the "reach" tab of the "run configuration" menu, add a BMC depth (10 is good for the 4 ring version). Take any value smaller than the shortest solution trace should be good. Inspect the DD you now obtain. 
Are they larger or smaller
* in representation size
* in number of represented states

What does this experiment suggest concerning the complexity of symbolic BFS exploration ?
Will memory usage grow steadily as we store more and more states ?

## Q4. DD Ordering

In the eclipse console, you have the command line invocation that produced the result. Open a console and reproduce the run. Make sure you `cd` to the `work/` folder.
 * add flag "--dump-order order.ord"
 * modify the order by permuting line in the file
 * replace the dump order flag by "--load-order order.ord"
 * inspect how the state space representation varies with dot
 
Use the "pole state" version for this exercise, or the ring version with a BMC limit.

Move the "init" variable at the top or bottom of the order. Explain the result.

Can we have an encoding as compact for poles as for the ring version ?

(Hint) Try building an order where all bits representing a ring state are adjacent. i.e. bits (0,N,2N) then (1,N+1,2N+1) etc...
 
## Step 4 : Saturation

Saturation is enabled by default in the tool. 
We can disable it by asking for BMC, which forces a BFS exploration of the state space.

Set a larger N for this experiment, forget about the goal, or just ask that the largest ring be on pole 2, and forget about the smaller ones. We want to be able to measure and compare runtimes.

Set a large BMC bound (with command line `-bmc DEPTH` where DEPTH is an integer), larger than the shortest solution trace length.
Compare with just letting the tool run without -bmc.

Is saturation effective on this model ?

On the "ring state" version, reverse the order of the variables. 
(Hint) `tail -r myfile.txt` will reverse all lines, just edit the file to put the first and last line back in place.

Why does this impact efficiency ?
  


