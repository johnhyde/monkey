/-  *monkey
/+  *monkey, default-agent, dbug, agentio
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
    shirts=(map path shirt)
    uggs=(map path ugg)
  ==
::
+$  shirt
  $:  =job
      sliv
  ==
+$  sliv
  $:  cuff=(unit binding:eyre)
      app=term
  ==
+$  job  ?(%redirect-ug %relay)
+$  ugg  @t  :: the url to attach urbitgraph data to, e.g. '/apps/monkey?ref='
::
+$  request-line
  $:  [ext=(unit @ta) site=(list @t)]
      args=(list [key=@t value=@t])
  ==
::
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    hc    ~(. +> bowl)
::
++  on-init
  ^-  (quip card _this)
  =^  cards  state
      (bind-path:hc /apps/grid/perma %redirect-ug)
  :_  this
  cards
  :: :~
  ::   [%pass /eyre-test %arvo %e %connect [~ /apps/astrolabe] %monkey]
  ::   [%pass /eyre-test %arvo %e %connect [~ /apps/] %monkey]
  :: ==
::
++  on-save  !>(state)
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  :: =/  old  *state-0
  =.  state  old
  :: =^  cards  state
  ::     (bind-path:hc /apps/grid/perma %redirect-ug)
  :: cards^this
  `this
  :: :~
  ::   :: [%pass /eyre-test %arvo %e %connect [~ /apps/astrolabe] %monkey]
  ::   :: [%pass /eyre-test %arvo %e %connect [~ /pals] %pals]
  :: ==
++  on-poke
  :: on-poke:def
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:def mark vase)
      %bind
    =+  !<(=path vase)
    =^  cards  state
      (bind-path:hc path *job)
    [cards this]
      %unbind
    =+  !<(=path vase)
    =/  shirt  (~(get by shirts.state) path)
    ?~  shirt
      ~&  "no shirt found, not unbinding"
      `this
    ~&  "found shirt"
    =/  cards
      ?~  cuff.u.shirt
        ~&  "no cuff!"
        [%pass /eyre-test %arvo %e %disconnect [~ path]]~
      ~&  "cuff found, rebind to cuff"
      [%pass /eyre-test %arvo %e %connect u.cuff.u.shirt app.u.shirt]~
    =.  shirts.state
      (~(del by shirts.state) path)
    [cards this]
      %unbind-app
    =+  !<(app=term vase)
    :_  this
    [%pass /eyre-test %arvo %e %disconnect [~ /apps/[app]]]~
      ::
      %bind-ug
    =+  !<([=path =ugg] vase)
    =/  forbidden-root
      ?|
        ?&(=(~ +.path) (start-eq:hc -.path 'groups'))
        (start-eq:hc '~' -.path)
      ==
    ?:  forbidden-root
      ~|(%illegal-ugg-path !!)
    =.  uggs
      (~(put by uggs) path ugg)
    `this
      ::
      %unbind-ug
    =+  !<(=path vase)
    =.  uggs
      (~(del by uggs) path)
    `this
      ::
      %bind-force
    =+  !<(=path vase)
    :_  this
    [%pass /eyre-test %arvo %e %connect [~ path] %monkey]~
      %unbind-force
    =+  !<(=path vase)
    :_  this
    [%pass /eyre-test %arvo %e %disconnect [~ path]]~
      %handle-http-request
    =+  !<([eyre-id=@ta req=inbound-request:eyre] vase)
    ?~  &(authenticated.req secure.req)  !!
    =/  req-line  (parse-request-line url.request.req)
    =*  path  site.req-line
    ~&  url.request.req
    ~&  path
    ~&  args.req-line
    :: =/  shirt  (~(get by shirts.state) path)
    =/  shirt  (get-shirt-for-path-from-shirts path)
    ~&  shirt
    :: =/  res  'hello, world'
    =/  paths  ~[/http-response/[eyre-id]]
    :_  this
    ?~  shirt
      ~&  "attempting to send 500"
      :~
        [%give %fact paths %http-response-header !>(`response-header:http`[500 ~])]
        [%give %fact paths %http-response-data !>(*(unit octs))]
        [%give %kick paths ~]
      ==
    =/  relay-cards
      :~
        [%pass /relay/[eyre-id] %agent [our.bowl app.u.shirt] %watch /http-response/[eyre-id]]
        [%pass /relay/[eyre-id] %agent [our.bowl app.u.shirt] %poke [mark vase]]
      ==
    ?-  job.u.shirt
        %relay  relay-cards
        %redirect-ug
      =/  url  (don-uggs:hc req-line)
      ?~  url  relay-cards
      =/  headers  ['Location' u.url]~
      ~&  "attempting to redirect"
      :~
        [%give %fact paths %http-response-header !>(`response-header:http`[303 headers])]
        [%give %fact paths %http-response-data !>(*(unit octs))]
        [%give %kick paths ~]
      ==
    ==
  ==
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path
    (on-watch:def path)
  ::
      [%http-response *]
    %-  (slog leaf+"Eyre subscribed to {(spud path)}." ~)
    `this
  ==
++  on-leave
  |=  =path
  ^-  (quip card _this)
  :-  ~
  this
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
      [%x %null ~]
    ``noun+!>(~)
  ==
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    wire  (on-agent:def wire sign)
      [%relay @ta ~]
    =/  res-paths  (res-paths:hc &2.wire)
    ?+    -.sign  (on-agent:def wire sign)
        %kick
      :_  this
      [%give %kick res-paths ~]~
        %fact
      ?+    p.cage.sign  (on-agent:def wire sign)
          %http-response-header
        ~&  "header received"
        :_  this
        [%give %fact res-paths cage.sign]~
          %http-response-data
        =/  data  !<((unit octs) q.cage.sign)
        =.  data
          ?~  data  ~
          (some (patch-response-data wire u.data example-patch))
        :_  this
        [%give %fact res-paths %http-response-data !>(data)]~
      ==
    ==
  ==
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([%eyre-test *] wire)
    (on-arvo:def [wire sign-arvo])
  ?>  ?=([%eyre %bound *] sign-arvo)
  ?:  accepted.sign-arvo
    %-  (slog leaf+"{<path.binding.sign-arvo>} bound successfully!" ~)
    `this
  %-  (slog leaf+"Binding {<path.binding.sign-arvo>} failed!" ~)
  `this
++  on-fail  on-fail:def
--
::
:: Helper Core
|_  =bowl:gall
++  scrio  ~(scry agentio bowl)
++  az-events-card  [%pass /azimuth-events %agent [our.bowl %azimuth] %watch /event]
++  res-paths
  |=  id=@ta
  ~[/http-response/[id]]
::
:: ++  read-doc
::   |=  =path
::   =/  doc-path=^path  :(weld /doc/usr path /udon)
::   ^-  (unit @t)
::   ?.  .^(? %cu (scrio q.byk.bowl doc-path))
::     ~
::   =/  mme=(each manx tang)  (mule |.((udon-to-docu .^(@t %cx (scrio q.byk.bowl doc-path)))))
::   ?:  ?=(%.n -.mme)
::     %-  (slog p.mme)
::     ~
::   `(crip (en-xml:html p.mme))::  +find-suffix: returns [~ /tail] if :full is (weld :prefix /tail)
++  bind-path
  |=  [=path =job]
    ^-  (quip card _state)
    =/  sliv  (get-sliv-for-path-from-bindings path)
    ~&  "try to bind"
    ?~  sliv  `state
    ~&  "found sliv"
    ?:  &(=(%monkey app.u.sliv) !=(cuff.u.sliv ~))
      ~|(%attempted-direct-double-monkey-bind !!)
    =.  shirts.state
      (~(put by shirts.state) path [job u.sliv])
    :_  state
    [%pass /eyre-test %arvo %e %connect [~ path] %monkey]~
::
++  don-uggs
  |=  req=request-line
  ^-  (unit @t)
  =/  ext
    %-  %~  get  by
      (malt args.req)
    'ext'
  ~&  "got ext"
  ~&  ext
  ?~  ext  ~
  :: split off 'web+urbitgraph:/'
  :: keep end / to check w/ path
  :: =/  sock  +:(trim 16 (trip ext))
  =/  sock=@t  (rsh [3 16] u.ext)
  ~&  "got sock"
  ~&  sock
  ?~  sock  ~
  =/  shoes  ~(tap by uggs)
  ~&  "got shoes"
  ~&  shoes
  =/  shoe-box
    |-
    ^-  (unit [sole=@t =ugg])
    ?~  shoes  ~
    =/  sole  (spat p.i.shoes)
    ~&  "got sole"
    ~&  sole
    ?:  (start-eq sole sock)
      `[sole q.i.shoes]
    $(shoes t.shoes)
  ~&  "got shoe box"
  ~&  shoe-box
  ?~  shoe-box  ~
  =*  shoe  u.shoe-box
  =/  hem  (rsh [3 (met 3 sole.shoe)] sock)
  `(cat 3 ugg.shoe hem)
::
++  get-shirt-for-path-from-shirts
  |=  =path
  ^-  (unit shirt)
  =/  shirts  ~(tap by shirts.state)
  |-  ^-  (unit shirt)
  ?~  shirts  ~
  =/  suffix  (find-suffix p.i.shirts path)
  ?~  suffix
    $(shirts t.shirts)
  `q.i.shirts
::
++  get-sliv-for-path-from-bindings
  |=  =path
  ^-  (unit sliv)
  =/  bindings  .^((list [=binding:eyre =duct =action:eyre]) %e (scrio %bindings ~))
  |-  ^-  (unit sliv)
  ?~  bindings  ~
  =/  suffix  (find-suffix path.binding.i.bindings path)
  ?~  suffix
    $(bindings t.bindings)
  =/  action  action.i.bindings
  ?.  ?=([%app app=term] action)
    ~
  :-  ~
  ^-  sliv
  :_  +.action
  ?~  u.suffix
    (some binding.i.bindings)
  ~
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
--
