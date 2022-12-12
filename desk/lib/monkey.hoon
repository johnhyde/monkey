/-  sur=monkey
/+  re
:: /+  azimuth, naive, mip
=<  [sur .]
=,  sur
|%
++  maybe-apply-patch
  |=  [=patch data=octs req=request:http]
  ^-  octs
  =/  caught  (catch-req patch req)
  ?.  caught
    data
  :: data
  (patch-response-data patch data)
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
++  patch-response-data
  |=  [=patch data=octs]
  ^-  octs
  =/  text  ((sand %t) q.data)
  ?~  text  data
  %-  ta-to-octs
  (thatch-hatch thatch.patch hatch.patch u.text)
::
++  thatch-hatch
  |=  [=thatch =hatch text=@t]
  ^-  @t
  ?@  hatch.patch
    ?:  ?=(%start hatch)
      (cat 3 thatch text)
    (cat 3 text thatch)
  =/  texape  (trip text)
  =/  lines  (split "\0a" texape)
  =/  thape  (trip thatch)
  =/  urange  (rut:re +.hatch texape)
  ?~  urange  text
  =/  pint  p.u.urange
  %-  crip  %-  zing
  %+  join  "\0a"
  ?-  -.hatch
      %before
    =/  [sline=(list tape) mline=(list tape) eline=(list tape)]
      (smaag (sub p.p.pint 1) p.p.pint lines)
    ?~  mline  lines
    =/  line  i.mline
    =/  [start=tape end=tape]  (smag q.p.pint line)
    =/  new-line  :(weld start thape end)
    (snap lines (sub p.p.pint 1) new-line)
      %after
    =/  [sline=(list tape) mline=(list tape) eline=(list tape)]
      (smaag (sub p.q.pint 1) p.q.pint lines)
    ?~  mline  lines
    =/  line  i.mline
    =/  [start=tape end=tape]  (smag q.q.pint line)
    =/  new-line  :(weld start thape end)
    (snap lines (sub p.q.pint 1) new-line)
      %replace
    =/  [sline=(list tape) mline=(list tape) eline=(list tape)]
      (smaag (sub p.q.pint 1) p.p.pint lines)
    ?~  mline  lines
    =/  start-line  i.mline
    =/  end-line  (rear mline)
    =/  start=tape  (scag p.p.pint start-line)
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
