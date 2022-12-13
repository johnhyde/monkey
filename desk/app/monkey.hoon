/-  *monkey
/+  *monkey, *mip, default-agent, dbug, agentio
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
    :: =shirts
    shirts=(map watch shirt-old)
    pants=(mip watch latch patch)
    chaps=(map latch watch)
    uggs=(map path ugg)
    pins=(map @t request:http)
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
  ::
  :: =/  old  *state-0
  :: =.  state  old
  :: =^  cards  state
  ::     (bind-path:hc /apps/grid/perma %redirect-ug)
  :: cards^this
  =/  old  !<(versioned-state old-state)
  =.  state  old
  `this
  ::
  :: :~
  ::   :: [%pass /eyre-test %arvo %e %connect [~ /apps/astrolabe] %monkey]
  ::   :: [%pass /eyre-test %arvo %e %connect [~ /pals] %pals]
  :: ==
++  on-poke
  :: on-poke:def
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  =(our src):bowl
  ?+    mark  (on-poke:def mark vase)
      ::
      :: operation
      ::
      %reset
    =^  cards  state  reset:hc
    cards^this
      ::
      %setup
    =^  cards  state  setup:hc
    cards^this
      ::
      %resetup
    =^  cards-1  state  reset:hc
    =^  cards-2  state  setup:hc
    :_  this
    (weld cards-1 cards-2)
      %ls-bindings
    ~&  get-bindings:hc
    `this
      ::
      :: warning: danger
      ::
      %bind
    =+  !<(=path vase)
    =^  cards  state
      (bind-path:hc path *job)
    cards^this
      ::
      %bind-to-job
    =+  !<([=path =job] vase)
    =^  cards  state
      (bind-path:hc path job)
    cards^this
      ::
      %unbind
    =+  !<(=path vase)
    =^  cards  state
      (unbind-path:hc path force=%.n)
    cards^this
      ::
      %unbind-force
    =+  !<(=path vase)
    =^  cards  state
      (unbind-path:hc path force=%.y)
    cards^this
      ::
      :: patching
      ::
      %patch
    =+  !<(=kit vase)
    =,  kit
    =*  watch  watch.patch
    =^  cards  state
      (bind-path:hc watch %patch)
    =/  old-watch  (~(gut by chaps) latch watch)
    =^  chap-cards  state
      ?:  =(watch old-watch)
        `state
      (rip-pants:hc old-watch latch)
    =.  chaps  (~(put by chaps) latch watch)
    ^-  (quip card _this)
    =.  pants  (~(put bi pants) watch latch patch)
    :_  this
    (weld cards chap-cards)
      ::
      %unpatch
    =+  !<(=latch vase)
    =/  uwatch  (~(get by chaps) latch)
    =^  cards  state
      ?~  uwatch  `state
      (rip-pants:hc u.uwatch latch)
    =.  chaps  (~(del by chaps) latch)
    ^-  (quip card _this)
    cards^this
      ::
      :: urbitgraph handling
      ::
      %bind-ug
    =+  !<([=path =ugg] vase)
    =/  forbidden-root
      ?|
        ?&(=(~ +.path) (start-eq:hc -.path 'groups'))
        =(-.path 'groups')
        (start-eq:hc '~' -.path)
      ==
    ?:  forbidden-root
      ~|(%ug-bind-reserved !!)
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
      :: being sneaky
      ::
      %handle-http-request
    =+  !<([eyre-id=@ta req=inbound-request:eyre] vase)
    ?~  &(authenticated.req secure.req)  !!
    =/  req-line  (parse-request-line url.request.req)
    =*  path  site.req-line
    ~&  url.request.req
    ~&  path
    ~&  args.req-line
    =/  shirt  (get-wrist-for-watch path shirts)
    ~&  shirt
    =/  paths  ~[/http-response/[eyre-id]]
    ?~  shirt
      ~&  "attempting to send 500"
      :_  this
      :~
        [%give %fact paths %http-response-header !>(`response-header:http`[500 ~])]
        [%give %fact paths %http-response-data !>(*(unit octs))]
        [%give %kick paths ~]
      ==
    |^
      ?-  job.u.shirt
          %patch
        =.  pins  (~(put by pins) eyre-id request.req)
        :_  this
        (relay-cards %patch)
          ::
          %redirect-ug
        =/  url  (don-uggs:hc req-line)
        :_  this
        ?~  url  (relay-cards %relay)
        ~&  "attempting to redirect"
        (redirect-cards:hc u.url paths)
      ==
    ++  relay-cards
      |=  =term
      :~
        [%pass /[term]/[eyre-id] %agent [our.bowl app.sliv.u.shirt] %watch /http-response/[eyre-id]]
        [%pass /[term]/[eyre-id] %agent [our.bowl app.sliv.u.shirt] %poke [mark vase]]
      ==
    --
  ==
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path
    (on-watch:def path)
  ::
      [%http-response *]
    ?>  =(our src):bowl
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
  ?>  =(our src):bowl
  ?+    wire  (on-agent:def wire sign)
      [?(%relay %patch) @ta ~]
    =/  eyre-id  &2.wire
    =/  res-paths  (res-paths:hc eyre-id)
    ?+    -.sign  (on-agent:def wire sign)
        %kick
      =.  pins  (~(del by pins) eyre-id)
      :_  this
      [%give %kick res-paths ~]~
        %fact
      ?+    p.cage.sign  (on-agent:def wire sign)
          %http-response-header
        ~&  "header received"
        :_  this
        [%give %fact res-paths cage.sign]~
          ::
          %http-response-data
        =/  req  (~(get by pins) eyre-id)
        :_  this
        ?:  |(=(~ req) =(%relay -.wire))
          [%give %fact res-paths cage.sign]~
        ?>  ?=(^ req)
        =/  data  !<((unit octs) q.cage.sign)
        =.  data  ?~  data  ~
          (some (maybe-patch-data:hc u.req u.data))
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
++  get-bindings  .^((list binding) %e (scrio %bindings ~))
++  get-eyre-shirts
  ^-  ^shirts
  (bindings-to-shirts get-bindings)
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
::
++  reset
  =/  paths  (get-paths-for-app-from-bindings %monkey)
  :_  *state-0
  %+  roll  paths
    |=  [=path cards=(list card)]
    %+  weld  cards
    -:(unbind-path path %.y)
::
++  setup  (bind-path /apps/grid/perma %redirect-ug)
::
++  bind-path
  |=  [=path =job]
  ^-  (quip card _state)
  =/  sliv  (get-sliv-for-path-from-bindings path)
  ~&  "try to bind"
  ?~  sliv  `state
  =/  new-shirts  (~(put by shirts) path [job u.sliv])
  =/  cards  [%pass /eyre-test %arvo %e %connect [~ path] %monkey]~
  :: =/  cards  [%pass /eyre-test %arvo %e %connect [`'http://warkgnall.com' path] %monkey]~
  ?.  =(%monkey app.u.sliv)
    ~&  "found sliv"
    :-  cards
    state(shirts new-shirts)
  ?.  =(cuff.u.sliv ~)
    ~&  "found exact %monkey sliv"
    :: %monkey was already bound to this exact path
    :: bind anyway, just in case
    cards^state(shirts new-shirts)
  ~&  "found %monkey sub-sliv"
  :-  ~  ^-  _state
  =/  shirt  (get-wrist-for-watch path shirts)
  ?~  shirt  state
  ?:  =(job.u.shirt job)
    state
  ~|(%parent-bind-job-mismatch !!)
::
++  unbind-path
  |=  [=path force=?]
  ^-  (quip card _state)
  =/  coat  (~(get by shirts) path)
  =/  sliv  (bind coat |=(shirt=shirt-old sliv.shirt))
  :-  (unbind-sliv path sliv force)
  %=  state  shirts
    (~(del by shirts) path)
  ==
::
++  unbind-sliv
  |=  [=path coat=(unit sliv) force=?]
  ^-  (list card)
  =/  disconnect-card  [%pass /eyre-test %arvo %e %disconnect [~ path]]
  ?~  coat
    ?:  force  [disconnect-card]~
    ~&  "no sliv found, not unbinding"
    ~
  ~&  "found sliv"
  ?~  cuff.u.coat
    ~&  "no cuff! unbinding"
    [disconnect-card]~
  ?:  =(%monkey app.u.coat)
    ~&  "monkey cuff found, unbind don't rebind"
    [disconnect-card]~
  ~&  "cuff found, rebind to cuff"
  [%pass /eyre-test %arvo %e %connect u.cuff.u.coat app.u.coat]~
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
++  rip-pants
  |=  [=watch =latch]
  ^-  (quip card _state)
  =.  pants  (~(del bi pants) watch latch)
  :: TODO: clean up unused shirts/bindings
  `state
::
++  maybe-patch-data
  |=  [req=request:http data=octs]
  ^-  octs
  =/  req-line  (parse-request-line url.req)
  =*  path  site.req-line
  =/  patches  (get-patches-for-watch path)
  %+  roll  patches
  |=  [=patch =_data]
  (maybe-apply-patch patch data req)
::
++  get-patches-for-watch
  |=  swatch=watch
  ^-  (list patch)
  %+  roll  (get-wrists-for-watch swatch pants)
  |=  [[* leg=(map * patch)] patches=(list patch)]
  (weld patches ~(val by leg))
::
++  get-sliv-for-path-from-bindings
:: Note that nested bindings are presorted by decreasing specificity
  |=  =path
  ^-  (unit sliv)
  =/  bindings  get-bindings
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
++  get-paths-for-app-from-bindings
  |=  app=term
  ^-  (list path)
  =/  bindings  get-bindings
  |-  ^-  (list path)
  ?~  bindings  ~
  =/  action  action.i.bindings
  ?.  ?&
        ?=([%app app=term] action)
        =(app +.action)
      ==
    $(bindings t.bindings)
  :-  path.binding.i.bindings
  $(bindings t.bindings)
--
