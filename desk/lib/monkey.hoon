/-  sur=monkey
/+  re
:: /+  azimuth, naive, mip
=<  [sur .]
=,  sur
|%
+$  card  card:agent:gall
++  bindings-to-shirts
  |=  bindings=(list binding)
  ^-  shirts
  ?~  bindings  ~
  %-  malt
  %+  murn  bindings
  |=  =binding
  ^-  (unit [watch shirt])
  ?^  site.binding.binding
    ~
  :-  ~
  :-  path.binding.binding
  ?.  ?=(%app -.action.binding)
    [%.n ~]
  =/  app  +.action.binding
  ?:  =(%monkey app)
    [%.y ~]
  [%.n `app]
::
++  merge-shirts
  |=  [e-shirts=shirts s-shirts=shirts]
  ^-  (quip card shirts)
  =-  [-> -<]
  %^  ruts  e-shirts  s-shirts
  |=  [k=watch ev=(unit shirt) sv=(unit shirt) cards=(list card)]
  ^-  [(unit shirt) _cards]
  =-  [-> (weld -< cards)]
  ^-  (quip card (unit shirt))
  ?~  sv
    ?~  ev  `~
    ?:  ours.u.ev
      ~[(connect-card k) (disconnect-card k)]~
    `ev
  ?~  ev
    ?.  ours.u.sv
      `~
    :: our binding was removed, reconnect w/o app
    :-  [(connect-card k)]~
    `[%.y ~]
  ?:  =(ours.u.ev ours.u.sv)
    :: we agree on owner
    ?.  ours.u.ev
      :: not ours: accept eyre
      `ev
    :: ours: keep state
    `sv
  :: we disagree on owner
  ?.  ours.u.sv
    :: we can't handle this: disconnect and remove
    ~[(disconnect-card k)]~
  ?~  app.u.ev
    :: path has been bound by not-an-app
    `ev
  :: an app overwrote our binding
  :-  [(connect-card k)]~
  `[%.y app.u.ev]
::
++  ruts
  |*  [m1=(map) m2=(map) g=gate]
  ((rutsc g) m1 m2)
::
++  rutsc
  |*  g=_|=([k=* v1=(unit) v2=(unit) a=*] [*(unit) a:+<])
  =/  s  +<.g
  =+
    ~|  %invalid-gate-type
    ?@  s  !!  ?@  +.s  !!  ?@  +>.s  !!
    [k=_,.&1.s v1=_&2.s v2=_&3.s a=_,.+>+.s]
  =/  uv  _-:(g)
  =>  .(g `$-([k v1 v2 a] [uv a])`g)
  |*  [m1=(map k *) m2=(map k *)]
  =/  keys1=(set k)  ~(key by m1)
  =/  keys2=(set k)  ~(key by m2)
  =/  keys=(list k)  ~(tap in (~(gas in keys1) ~(tap in keys2)))
  =/  unit-list
    ^-  [(list [k uv]) a]
    %^  spin  keys  *a
    |=  [=k =a]
    =/  gm1  ~(get by m1)
    =/  =v1  ?~  m1  ~  (gm1 k)
    =/  gm2  ~(get by m2)
    =/  =v2  ?~  m2  ~  (gm2 k)
    =-  [[k -<] ->]
    (g k v1 v2 a)
  =/  l  -.unit-list
  =/  v  $_
    ?>
      ?=(^ l)
    ?>  ?=(^ +.i.l)
    +>.i.l
  ^-  [(map k v) a]
  :_  +.unit-list
  %-  malt
  %+  murn  l
  |=  [=k =uv]
  ^-  (unit [^k v])
  ?~  uv  ~
  `[k +.uv]
::
++  connect-card
  |=  =path
  ^-  card
  [%pass /eyre-test %arvo %e %connect [~ path] %monkey]
::
++  connect-card-app
  |=  [=path app=term]
  ^-  card
  [%pass /eyre-test %arvo %e %connect [~ path] app]
::
++  disconnect-card
  |=  =path
  ^-  card
  [%pass /eyre-test %arvo %e %disconnect [~ path]]
::
++  unbind-card
  |=  [=path =app]
  ^-  card
  ?~  app
    (disconnect-card path)
  (connect-card-app path u.app)
::
++  apply-pitch
  |=  [=pitch data=octs req=request:http]
  ^-  octs
  ?.  enabled.pitch  data
  =/  caught  (catch-req patch.pitch req)
  ?.  caught
    data
  :: ~&  "caught by {<catch.patch.pitch>}"
  :: ~&  "check sanity"
  ?.  ((saner %t) q.data)  data
  :: ~&  "sanity checked"
  (apply-patch patch.pitch data)
::
++  catch-req
  |=  [=patch req=request:http]
  ?-  catch.patch
      %all  %.y
      %path
    =/  spit  (spat watch.patch)
    =/  sput  (cat 3 spit '/')
    ?|  =(spit url.req)
        =(sput url.req)
    ==
      [%cord *]
    =(+.catch.patch url.req)
      [%regex *]
    =/  urange  (rut:re +.catch.patch (trip url.req))
    ?~  urange  %.n  %.y
  ==
++  apply-patch
  |=  [=patch data=octs]
  ^-  octs
  :: ~&  "attempt sander"
  =/  text  ((sander %t) q.data)
  ?~  text  data
  :: ~&  "sandered"
  %-  ta-to-octs
  (thatch-hatch thatch.patch hatch.patch u.text)
::
++  thatch-hatch
  |=  [=thatch =hatch text=@t]
  ^-  @t
  ?@  hatch
    ?:  ?=(%start hatch)
      (cat 3 thatch text)
    (cat 3 text thatch)
  =/  texape  (trip text)
  =/  lines  (split "\0a" texape)
  =/  thape  (trip thatch)
  =/  urange  (rut:re +.hatch texape)
  ?~  urange  text
  =/  pint  (pour p.u.urange)
  %-  crip  %-  zing
  %+  join  "\0a"
  ?-  -.hatch
      %before
    =/  [sline=(list tape) mline=(list tape) eline=(list tape)]
      (smaag p.p.pint +(p.p.pint) lines)
    ?~  mline  lines
    =/  line  i.mline
    =/  [start=tape end=tape]  (smag q.p.pint line)
    =/  new-line  :(weld start thape end)
    (snap lines p.p.pint new-line)
      %after
    =/  [sline=(list tape) mline=(list tape) eline=(list tape)]
      (smaag p.q.pint +(p.q.pint) lines)
    ?~  mline  lines
    =/  line  i.mline
    =/  [start=tape end=tape]  (smag q.q.pint line)
    =/  new-line  :(weld start thape end)
    (snap lines p.q.pint new-line)
      %replace
    =/  [sline=(list tape) mline=(list tape) eline=(list tape)]
      (smaag p.p.pint +(p.q.pint) lines)
    ?~  mline  lines
    =/  start-line  i.mline
    =/  end-line  (rear mline)
    =/  start=tape  (scag q.p.pint start-line)
    =/  end=tape  (slag q.q.pint end-line)
    =/  new-line=tape  :(weld start thape end)
    :(weld sline [new-line]~ eline)
  ==
::
++  get-wrist-for-watch
  |*  [swatch=watch wrists-map=(map watch *)]
  =/  wrists  (get-wrists-for-watch swatch wrists-map)
  ?~  wrists  ~
  =/  wrist  _+.i.wrists
  =/  item  $:(rolo=watch ruka=wrist)
  =/  wrists  `(list item)`wrists
  ^-  (unit wrist)
  %-  bind
  :_  |=(=item ruka.item)
  %+  roll  wrists
  |=  [[rolo=watch ruka=wrist] utem=(unit item)]
  ^-  (unit item)
  ?~  utem  `[rolo ruka]
  ?:  (gth (lent rolo) (lent rolo.u.utem))
    `[rolo ruka]
  utem
::
++  get-wrists-for-watch
  |*  [swatch=watch wrists-map=(map watch *)]
  =/  wrists  ~(tap by wrists-map)
  ?~  wrists  ~
  =/  wrist  _q.i.wrists
  =/  wrists  `(list _i.wrists)`wrists
  ^-  (list [watch wrist])
  %+  murn  wrists
  |=  [rolo=watch ruka=wrist]
  ^-  (unit [watch wrist])
  =/  suffix  (find-suffix rolo swatch)
  ?~  suffix  ~
  `[rolo ruka]
::
++  sort-wrists
  |*  wrists=(list [watch *])
  ^-  _wrists
  %+  sort  wrists
  |=  [[w1=watch *] [w2=watch *]]
  (gth (lent w1) (lent w2))
::
++  find-suffix
  |=  [prefix=path full=path]
  ^-  (unit path)
  ?~  prefix
    `full
  ?~  full
    ~
  ?.  =(i.prefix i.full)
    ~
  $(prefix t.prefix, full t.full)
::
++  parse-request-line
  |=  url=@t
  ^-  request-line
  (fall (rush url ;~(plug apat:de-purl:html yque:de-purl:html)) [[~ ~] ~])
::
++  ta-to-octs
  |=  text=@ta
  ^-  octs
  [(met 3 text) text]
::
++  start-eq
  |=  [sm=@ta bg=@ta]
  .=  sm
  (end [3 (met 3 sm)] bg)
::
++  split
  |*  [nedl=(list) hstk=(list)]
  |-  ^-  (list _hstk)
  =/  brk  (find nedl hstk)
  ?~  brk  ~[hstk]
  =/  next  (add u.brk (lent nedl))
  :-  (scag u.brk hstk)
  $(hstk (slag next hstk))
::
++  smaag
  |*  [a=@ aa=@ c=(list)]
  ?>  (lte a aa)
  ^+  [c c c]
  =/  smg  (smag a c)
  [-.smg (smag (sub aa a) +.smg)]
::
++  smag
  |*  [a=@ c=(list)]
  =/  b=_c  ~
  |-  ^+  [b c]
  ?:  =(0 a)  b^c
  ?~  c  b^~
  $(b (snoc b i.c), c t.c, a (dec a))
::
++  pour
  |=  p=pint
  ^-  pint
  :- 
    :-  (sub p.p.p 1)
    (sub q.p.p 1)
  :-  (sub p.q.p 1)
  (sub q.q.p 1)
::
++  sander                                              ::  atom sanity
  |=  a=@ta
  (flit (saner a))
::
++  saner                                               ::  atom sanity
  |=  a=@ta
  |=  b=@  ^-  ?
  ?.  =(%t (end 3 a))
    ::  XX more and better sanity
    ::
    &
  =+  [inx=0 len=(met 3 b)]
  ?:  =(%tas a)
    |-  ^-  ?
    ?:  =(inx len)  &
    =+  cur=(cut 3 [inx 1] b)
    ?&  ?|  &((gte cur 'a') (lte cur 'z'))
            &(=('-' cur) !=(0 inx) !=(len inx))
            &(&((gte cur '0') (lte cur '9')) !=(0 inx))
        ==
        $(inx +(inx))
    ==
  ?:  =(%ta a)
    |-  ^-  ?
    ?:  =(inx len)  &
    =+  cur=(cut 3 [inx 1] b)
    ?&  ?|  &((gte cur 'a') (lte cur 'z'))
            &((gte cur '0') (lte cur '9'))
            |(=('-' cur) =('~' cur) =('_' cur) =('.' cur))
        ==
        $(inx +(inx))
    ==
  |-  ^-  ?
  :: ~&  "inx: {<inx>}"
  ?:  =(inx len)  &
  =+  cur=(cut 3 [inx 1] b)
  ?:  &((lth cur 32) !=(10 cur))  |
  :: ?:  &((lth cur 32) !=(10 cur))  ~&("illegal: {<cur>}" |)
  =+  tef=(teff cur)
  ::  ==
  ?&  ?|
          =(1 tef)
          =+  i=1
        |-  ?|
            =(i tef)
            ?&  (gte (cut 3 [(add i inx) 1] b) 128)
                $(i +(i))
        ==  ==
      ==
      $(inx +(inx))
  ==
::
++  example-patch
'''
setInterval(() => {
  const spans = document.querySelectorAll('div > span[title^="~"][cursor="pointer"]');
  spans.forEach((span) => {
    let title = span.getAttribute('title');
    if (span.innerHTML.indexOf(title) === -1) {
      span.innerHTML = span.innerHTML + ' ' + title;
    }

    // console.log(span.innerHTML);
  });
}, 100);

let p = document.createElement('p');
p.innerHTML = "You are great";
p.style.position = 'absolute';
p.style.top = '0';
p.style.backgroundColor = "white";
document.body.appendChild(p);
'''
::
++  redirect-cards
  |=  [url=@t paths=(list path)]
  =/  headers  ['Location' url]~
  :~
    [%give %fact paths %http-response-header !>(`response-header:http`[307 headers])]
    [%give %fact paths %http-response-data !>(*(unit octs))]
    [%give %kick paths ~]
  ==
--
