/-  *monkey
/+  *monkey, *mip, re, default-agent, dbug, agentio
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
    :: =shirts
    shirts=(map watch shirt)
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
      (bind-path:hc /apps/grid/perma)
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
  ::     (bind-path:hc /apps/grid/perma)
  :: cards^this
  =/  old  !<(versioned-state old-state)
  =.  state  old
  `this
  ::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  =^  sync-cards  shirts  get-shirts:hc
  =-  [(weld sync-cards -<) ->]
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
      ::
      %ls-bindings
    ~&  get-bindings:hc
    `this
      ::
      %ls-shirts
    ~&  shirts
    `this
      ::
      :: warning: danger
      ::
      %bind
    =+  !<(=path vase)
    =^  cards  state
      (bind-path:hc path)
    cards^this
      ::
      %unbind
    =+  !<(=path vase)
    =^  cards  state
      (unbind-path:hc path)
    cards^this
      ::
      :: patching
      ::
      %patch
    =+  !<(=kit vase)
    =,  kit
    =*  watch  watch.patch
    =/  catch-valid
      ?@  catch.patch  %.y
      ?:  ?=([%regex *] catch.patch)
        (valid:re `tape`+.catch.patch)
      %.y
    =/  hatch-valid
      ?^  hatch.patch
        (valid:re +.hatch.patch)
      %.y
    ?.  catch-valid
      ~|(%catch-regex-invalid !!)
    ?.  hatch-valid
      ~|(%hatch-regex-invalid !!)
    =^  cards  state
      (bind-path:hc watch)
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
    =*  watch  site.req-line
    ~&  url.request.req
    =/  app  (get-app-for-watch:hc watch)
    |^
      =/  paths  ~[/http-response/[eyre-id]]
      ?~  app
        :_  this
        (four-oh-four paths)
      ?~  (find-suffix watch /apps/grid/perma)
        =.  pins  (~(put by pins) eyre-id request.req)
        :_  this
        (relay-cards %patch u.app)
      =/  url  (don-uggs:hc req-line)
      :_  this
      ?~  url  (relay-cards %relay u.app)
      ~&  "attempting to redirect"
      (redirect-cards:hc u.url paths)
    ++  relay-cards
      |=  [=term app=term]
      :~
        [%pass /[term]/[eyre-id] %agent [our.bowl app] %watch /http-response/[eyre-id]]
        [%pass /[term]/[eyre-id] %agent [our.bowl app] %poke [mark vase]]
      ==
    ++  four-oh-four
      |=  paths=(list path)
      :~
        [%give %fact paths %http-response-header !>(`response-header:http`[500 ~])]
        [%give %fact paths %http-response-data !>(*(unit octs))]
        [%give %kick paths ~]
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
  ?+  path  (on-peek:def path)
      [%x %patches ~]
    ``patches+!>(get-patches:hc)
      [%x %patches ^]
    =/  patch  (get-patch:hc t.t.path)
    ?~  patch  `~
    ``patch+!>(u.patch)
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
++  get-shirts
  ^-  (quip card ^shirts)
  (merge-shirts get-eyre-shirts shirts)
++  our-shirts
  ^-  (list [watch shirt])
  %+  murn  ~(tap by shirts)
  |=  [w=watch s=shirt]
  ^-  (unit [watch shirt])
  ?.  ours.s  ~
  `[w s]
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
  :_  *state-0
  %+  roll  our-shirts
    |=  [[=watch =shirt] cards=(list card)]
    :-  (disconnect-card watch)
    cards
::
++  setup  (bind-path /apps/grid/perma)

++  put-shirt
  |=  [=watch =shirt]
  ^-  _state
  state(shirts (~(put by shirts) watch shirt))
::
++  bind-path
  |=  =watch
  ^-  (quip card _state)
  =/  ushirt  (~(get by shirts) watch)
  =/  connect-cards  [(connect-card watch)]~
  ?~  ushirt
    :-  connect-cards
    (put-shirt watch [%.y ~])
  ?:  ours.u.ushirt
    :: nothing to do
    `state
  ?~  app.u.ushirt
    :: forbidden
    `state  
  :-  connect-cards
  (put-shirt watch [%.y app.u.ushirt])
::
++  unbind-path
  |=  [=watch]
  ^-  (quip card _state)
  =/  ushirt  (~(get by shirts) watch)
  ?~  ushirt  `state
  ?.  ours.u.ushirt
    `state
  :_  state(shirts (~(del by shirts) watch))
  ?~  app.u.ushirt
    [(disconnect-card watch)]~
  [(connect-card-app watch u.app.u.ushirt)]~
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
++  get-patches
  ^-  (map latch patch)
  %-  malt
  ^-  (list [latch patch])
  %+  murn  ~(tap by chaps)
  |=  [=latch =watch]
  ^-  (unit [^latch patch])
  %+  bind
    (~(get bi pants) watch latch)
  |=  =patch
  [latch patch]
::
++  get-patch
  |=  [=latch]
  ^-  (unit patch)
  =/  chap  (~(get by chaps) latch)
  ?~  chap  ~
  =/  pant  (~(get by pants) u.chap)
  ?~  pant  ~
  (~(get by u.pant) latch)
::
++  maybe-patch-data
  |=  [req=request:http data=octs]
  ^-  octs
  ?.  ((sane %t) q.data)  data
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
++  get-app-for-watch
  |=  =watch
  ^-  (unit term)
  =/  m-shirts  %-  sort-wrists
    (get-wrists-for-watch watch shirts)
  |-  ^-  (unit term)
  ?~  m-shirts  `%docket
  =/  shirt  +.i.m-shirts
  ?^  app.shirt  app.shirt
  ?.  ours.shirt  ~  :: non-app binding matched: bail
  $(m-shirts t.m-shirts)
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
++  yget-paths-for-app-from-bindings
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
