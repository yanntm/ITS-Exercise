# ITS-Exercise

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

Compare the two variants, explain how the two encodings differ.

Inspect the degeneralized versions of the model in the "work/" folder.

Do both models generate the same Kripke structure / State space ?

Increase or decrease the number of rings in the model.

How does the state space size evolve with respect to $N ?

How does the shortest solution path length evolve with $N ?

## Step 3 : State space encoding

Inspect the final state space representation as a DD : 
 * in the "Run As...->Run Configurations" menu, open the "reach" and activate the "export as dot file" flag.
 * after running the model-checking look in the work/ folder for a .dot file
 * run dot on it like this `dot -Tpdf file.dot -o file.pdf`
 * inspect the pdf for both versions of the model

in the eclipse console, you have the command line invocation that produced the result. Open a console and reproduce the run.
 * add flag "--dump-order order.ord"
 * modify the order by permuting line in the file
 * add flag "--load-order order.ord"
 * inspect how the state space representation varies
 
## Step 4 : Saturation

  


