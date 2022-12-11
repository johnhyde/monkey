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
+$  patch
  $:  $=  catch  :: which files on the path should be extended
      $@  ?(%path %all)
      $%  [%cord cord]
          [%regex regex]
      ==
      $=  hatch  :: where to insert the text in the file
      $@  ?(%start %end)
      $%  [%before regex]
          [%after regex]
          [%replace regex]
      ==
      =thatch  :: the text to be inserted
  ==
::
+$  kit
  $:  =latch  :: the unique identifier for the patch
      =watch  :: the path to watch and relay
      =patch
  ==
::
+$  latch  path
+$  watch  path
+$  thatch  cord
::
+$  request-line
  $:  [ext=(unit @ta) site=(list @t)]
      args=(list [key=@t value=@t])
  ==
::
+$  binding  [=binding:eyre =duct =action:eyre]
::
--
