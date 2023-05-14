/+  naive, *mip, re
|%
+$  shirts  (map watch shirt)  :: representations of eyre bindings
+$  shirt  :: representation of what eyre has bound to a path
  $:  ours=?  :: ours=%.y - this path is bound to %monkey
      =app  :: (unit term)
      :: app=~ - it's not an %app action
      :: app=[~ u=%app] - it is (or was) bound to %app
  ==
+$  app  (unit term)
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
+$  patches  (map latch patch)
::
+$  kit
  $:  =latch  :: the unique identifier for the patch, e.g. /patchee/patcher/name
      =patch
  ==
::
+$  pitch
  $:  paste  :: configuration for using the patch
      =patch
  ==
::
+$  paste
  $:  enabled=?
  ==
::
+$  patch
  $:  =watch  :: the path to watch and relay
      =catch  :: define which responses on the path should be extended
      =hatch  :: where to insert the thatch in the response
      =thatch  :: the text to be inserted
  ==
::
+$  latch  path
+$  watch  path
+$  thatch  cord
::
+$  catch
  $@  $?  %path  :: requires exact match between response url and watch
          %all  :: this matches any path starting with the watch
      ==
  $%  [%cord cord]  :: cord exactly matches response path
      [%regex regex]  :: regex tape
  ==
+$  hatch
  $@  $?  %start  :: prepends thatch at the beginning
          %end  :: appends thatch at the end
      ==
  $%  [%before regex]  :: insert thatch before the first match
      [%after regex]  :: insert thatch after the first match
      [%replace regex]  :: replace the first match with the thatch
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
