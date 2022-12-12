/+  naive, *mip, re
|%
+$  shirt
  $:  =job
      =sliv
  ==
+$  sliv
  $:  cuff=(unit binding:eyre)  :: ~ means the original binding was not overwritten
      app=term
  ==
+$  job  ?(%redirect-ug %patch)
+$  ugg  @t  :: the url to attach urbitgraph data to, e.g. '/apps/monkey?ref='
+$  regex  tape
::
+$  kit
  $:  =latch  :: the unique identifier for the patch
      =patch
  ==
::
+$  patch
  $:  =watch  :: the path to watch and relay
      =catch  :: which files on the path should be extended
      =hatch  :: where to insert the text in the file
      =thatch  :: the text to be inserted
  ==
::
+$  latch  path
+$  watch  path
+$  thatch  cord
::
+$  catch
  $@  ?(%path %all)
  $%  [%cord cord]
      [%regex regex]
  ==
+$  hatch
  $@  ?(%start %end)
  $%  [%before regex]
      [%after regex]
      [%replace regex]
  ==
::
+$  request-line
  $:  [ext=(unit @ta) site=(list @t)]
      args=(list [key=@t value=@t])
  ==
::
+$  binding  [=binding:eyre =duct =action:eyre]
::
--
