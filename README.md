# ITS-Exercise

## Step 1 : Download and Install

Follow [these instructions to get ITS-Tools](https://lip6.github.io/ITSTools-web/eclipsestart.htmlhttps://lip6.github.io/ITSTools-web/eclipsestart.html)

## Step 2 : A model

Create a "new->Project->General->Project".

Import the hanoi model into your project.

Right-click then "Run As...->ITS model check".

Compare the two variants, explain how the encodings differ.

Inspect the degeneralized versions of the model in the "work/" folder.

Do they generate the same Kripke structure / State space ?

Increase or decrease the number of rings in the model.

How does the state space size evolve with respect to $N ?

How does the shortest solution path length evolve with $N ?

## Step 3 : State space encoding

Inspect the final state space representation as a DD : 
 * in the "Run As...->Run Configurations" menu, open the "reach" and activate the "export as dot file" flag.
 * after running the model-checking look in the work/ folder for a .dot file
 * run dot on it like this `dot -Tpdf file.dot -o file.pdf`
 * inspect the pdf for both versions of the model
 * in the eclipse console, you have the command line invocation that produced the result. Open a console and reproduce the run.
 * add flag "--dump-order order.ord"
 * modify the order by permuting line in the file
 * add flag "--load-order order.ord"
 * inspect how the state space representation varies
 
## Step 4 : Saturation

  


