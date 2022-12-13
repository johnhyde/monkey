/+  naive, *mip, re
|%
+$  shirts  (map watch shirt)
+$  shirt
  $:  ours=?
      app=(unit term)  :: ~ means it's not an %app action
  ==
+$  shirt-old
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
+$  card  card:agent:gall
::
+$  request-line
  $:  [ext=(unit @ta) site=(list @t)]
      args=(list [key=@t value=@t])
  ==
::
+$  binding  [=binding:eyre =duct =action:eyre]
::
::  ref from lull.hoon
::  binding:eyre
:: +$  binding
::   $:  site=(unit @t)
::       ::    /~myapp will match /~myapp or /~myapp/longer/path
::       path=(list @t)
::   ==
::
:: +$  action
::   $%  [%gen =generator]
::       ::  dispatch to an application
::       ::
::       [%app app=term]
::       [%authentication ~]
::       [%logout ~]
::       [%channel ~]
::       [%scry ~]
::       [%four-oh-four ~]
::   ==
::
--
